#include <QtCore/QEventLoop>
#include <QtMultimedia/QCameraInfo>
#include <QtMultimedia/QVideoRendererControl>
#include <QtMultimedia/QVideoSurfaceFormat>
#include <QWCX/Controls/qrcodescanner.h>
#include <ZXing/BarcodeFormat.h>
#include <ZXing/DecodeHints.h>
#include <ZXing/GenericLuminanceSource.h>
#include <ZXing/HybridBinarizer.h>
#include <ZXing/MultiFormatReader.h>
#include <ZXing/Result.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

class QrCodeScannerCameraViewfinder : public QAbstractVideoSurface
{
    Q_OBJECT

    typedef QAbstractVideoBuffer::HandleType HandleType;
    typedef QList<QVideoFrame::PixelFormat> PixelFormatList;

public:
    QrCodeScannerCameraViewfinder(QObject *parent = nullptr) : QAbstractVideoSurface(parent) {}
    ~QrCodeScannerCameraViewfinder() override = default;

    PixelFormatList supportedPixelFormats(HandleType type = HandleType::NoHandle) const override
    {
        Q_UNUSED(type)
        return m_camera ? m_camera->supportedViewfinderPixelFormats() : PixelFormatList();
    }

    bool present(const QVideoFrame &frame) override
    {
        if (!frame.isValid())
            return false;

        QCamera::Position cameraPosition = QCamera::Position::UnspecifiedPosition;
        if (m_camera) {
            QCameraInfo cameraInfo(*m_camera);
            cameraPosition = cameraInfo.position();
        }

        QVideoSurfaceFormat format(surfaceFormat());
        switch (cameraPosition) {
        case QCamera::FrontFace:
            format.setMirrored(true);
            break;
        case QCamera::BackFace:
            format.setMirrored(false);
            break;
        case QCamera::UnspecifiedPosition:
            //[[fallthrough]]; // (C++17 feature)
        default:
            // trying to guess reasonable default
#if defined(Q_OS_ANROID) || defined(Q_OS_IOS)
            format.setMirrored(true);
#else
            format.setMirrored(true);
#endif
            break;
        }

        Q_EMIT videoFrameCaptured(QVideoFrame(frame), QVideoSurfaceFormat(format));

        QVideoFrame buffer(frame);
        const bool mapped = buffer.map(QAbstractVideoBuffer::ReadOnly);
        if (mapped) {
            scan(buffer);
            buffer.unmap();
        }

        return true;
    }

    void scan(const QVideoFrame &frame)
    {
        QImage image{
            frame.bits(),
            frame.width(),
            frame.height(),
            frame.bytesPerLine(),
            QVideoFrame::imageFormatFromPixelFormat(frame.pixelFormat())
        };

        if (image.isNull() || image.width() < 1 || image.height() < 1)
            return;

        QRect rect = m_cropArea.isValid() ? m_cropArea : QRect(0, 0, image.width(), image.height());
        QImage cropped = image.copy(rect);

        try {
            auto src = std::make_shared<ZXing::GenericLuminanceSource>(
                cropped.width(),
                cropped.height(),
                cropped.bits(),
                cropped.bytesPerLine(),
                4, // pixel bytes count
                2, // red index
                1, // green index
                0); // blue index

            std::vector<ZXing::BarcodeFormat> formats = { ZXing::BarcodeFormat::QR_CODE };

            ZXing::DecodeHints hints;
            hints.setPossibleFormats(formats);
            hints.setTryHarder(true);
            hints.setTryRotate(true);

            ZXing::MultiFormatReader reader(hints);

            auto result = reader.read(ZXing::HybridBinarizer(src));
            if (result.isValid()) {
                auto decodedText = QString::fromStdWString(result.text());
                Q_EMIT qrCodeCaptured(decodedText);
            } else {
                // QR-code is not found.
            }
        } catch (const std::exception &e) {
            qDebug() << "Exception:" << e.what();
        }
    }

    void setCamera(QCamera *camera) { m_camera = camera; }
    QCamera *camera() const { return m_camera; }

    void setCropArea(const QRect &cropArea) { m_cropArea = cropArea; }
    QRect cropArea() const { return m_cropArea; }

Q_SIGNALS:
    void qrCodeCaptured(const QString &decodedText);
    void videoFrameCaptured(const QVideoFrame &frame, const QVideoSurfaceFormat &format);

private:
    QCamera *m_camera = nullptr; // Not owned!
    QRect m_cropArea;
};

class QrCodeScannerCameraThread : public QThread
{
    Q_OBJECT

public:
    explicit QrCodeScannerCameraThread(QObject *parent = nullptr) : QThread(parent) {}
    ~QrCodeScannerCameraThread() override
    {
        stop();
        wait();
    }

public Q_SLOTS:
    void stop()
    {
        if (isRunning())
            quit();
    }

protected:
    void run() override
    {
        QrCodeScanner *qrCodeScanner = qobject_cast<QrCodeScanner *>(parent());
        if (!qrCodeScanner)
            return;

        QrCodeScannerCameraViewfinder cameraViewfinder;
        cameraViewfinder.setCropArea(qrCodeScanner->cropArea());
        connect(&cameraViewfinder, &QrCodeScannerCameraViewfinder::qrCodeCaptured,
                qrCodeScanner, &QrCodeScanner::handleQrCodeText);
        connect(&cameraViewfinder, &QrCodeScannerCameraViewfinder::videoFrameCaptured,
                qrCodeScanner, &QrCodeScanner::handleVideoFrame);
        connect(qrCodeScanner, &QrCodeScanner::cropAreaChanged,
                &cameraViewfinder, &QrCodeScannerCameraViewfinder::setCropArea);

        QCameraInfo cameraInfo = QCameraInfo::defaultCamera();

        QCamera camera(cameraInfo.deviceName().toLatin1());
        camera.setCaptureMode(QCamera::CaptureViewfinder);
        camera.setViewfinder(&cameraViewfinder);
        camera.load();

        QSize highestResolution(320, 240);
        for (const QSize &r : camera.supportedViewfinderResolutions()) {
            if ((r.width() * r.height()) > (highestResolution.width() * highestResolution.height()))
                highestResolution = r;
        }

        QVideoSurfaceFormat videoSurfaceFormat(highestResolution, QVideoFrame::Format_ARGB32);

        QCameraViewfinderSettings viewfinderSettings;
        viewfinderSettings.setResolution(highestResolution);
        viewfinderSettings.setMinimumFrameRate(24);
        viewfinderSettings.setMaximumFrameRate(60);
        viewfinderSettings.setPixelFormat(QVideoFrame::PixelFormat::Format_ARGB32);
        camera.setViewfinderSettings(viewfinderSettings);

        cameraViewfinder.setCamera(&camera);
        cameraViewfinder.start(videoSurfaceFormat);
        camera.start();

        exec();

        cameraViewfinder.setCamera(nullptr);
        cameraViewfinder.stop();
        camera.stop();
    }
};

QrCodeScanner::QrCodeScanner(QObject *parent)
    : QObject(parent),
      m_cameraThread(nullptr),
      m_videoSurface(nullptr)
{
}

QrCodeScanner::~QrCodeScanner()
{
    stop();
}

void QrCodeScanner::setCropArea(const QRect &cropArea)
{
    if (m_cropArea == cropArea)
        return;

    m_cropArea = cropArea;
    Q_EMIT cropAreaChanged(m_cropArea);
}

QRect QrCodeScanner::cropArea() const
{
    return m_cropArea;
}

QCamera::Status QrCodeScanner::cameraStatus() const
{
    return QCamera::UnavailableStatus;
}

QString QrCodeScanner::decodedText() const
{
    return m_decodedText;
}

void QrCodeScanner::setVideoSurface(QAbstractVideoSurface *videoSurface)
{
    if (m_videoSurface == videoSurface)
        return;

    if (m_videoSurface && m_videoSurface->isActive()) {
        m_videoSurface->stop();
    }

    m_videoSurface = videoSurface;
    Q_EMIT videoSurfaceChanged();
}

QAbstractVideoSurface *QrCodeScanner::videoSurface() const
{
    return m_videoSurface;
}

void QrCodeScanner::start()
{
    if (m_cameraThread)
        return;

    QrCodeScannerCameraThread *t = new QrCodeScannerCameraThread(this);
    connect(this, &QrCodeScanner::aboutToStart, t, &QThread::start);
    connect(this, &QrCodeScanner::aboutToStop, t, &QrCodeScannerCameraThread::stop);
    connect(t, &QrCodeScannerCameraThread::finished, t, &QrCodeScannerCameraThread::deleteLater);

    m_cameraThread = t;

    Q_EMIT aboutToStart();
}

void QrCodeScanner::stop()
{
    if (!m_cameraThread)
        return;

    emit aboutToStop();

    if (m_videoSurface && m_videoSurface->isActive())
        m_videoSurface->stop();

    QMetaObject::invokeMethod(m_cameraThread, "stop", Qt::QueuedConnection);
    m_cameraThread = nullptr;
}

void QrCodeScanner::handleQrCodeText(const QString &decodedText)
{
    if (m_decodedText == decodedText)
        return;

    m_decodedText = decodedText;
    Q_EMIT decodedTextChanged();
}

void QrCodeScanner::handleVideoFrame(const QVideoFrame &frame, const QVideoSurfaceFormat &format)
{
    if (!frame.isValid())
        return;

    if (!m_videoSurface)
        return;

    if (m_videoSurface->surfaceFormat() != format) {
        if (m_videoSurface->isActive())
            m_videoSurface->stop();

        m_videoSurface->start(format);
    }

    m_videoSurface->present(frame);
}

// TODO: Implement QThread *createCameraThread();

QWCX_CONTROLS_END_NAMESPACE

#include "qrcodescanner.moc"

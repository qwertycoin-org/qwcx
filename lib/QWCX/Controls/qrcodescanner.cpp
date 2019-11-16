#include <QtCore/QTimer>
#include <QtMultimedia/QCamera>
#include <QtMultimedia/QCameraImageCapture>
#include <QtMultimedia/QVideoProbe>
#include <QWCX/Controls/qrcodescanner.h>
#include <ZXing/BarcodeFormat.h>
#include <ZXing/DecodeHints.h>
#include <ZXing/GenericLuminanceSource.h>
#include <ZXing/HybridBinarizer.h>
#include <ZXing/MultiFormatReader.h>
#include <ZXing/Result.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

QrCodeScanner::QrCodeScanner(QObject *parent)
    : QObject(parent),
      m_cropArea(QRect(QPoint(0, 0), QPoint(-1, -1))),
      m_imageCapture(nullptr),
      m_source(QVariant::fromValue(nullptr)),
      m_timer(new QTimer(this))
{
    connect(this, &QrCodeScanner::sourceChanged, this, &QrCodeScanner::handleSourceChanged);

    m_timer->setInterval(int{1000});
    m_timer->setSingleShot(false);
    m_timer->setTimerType(Qt::CoarseTimer);
    connect(m_timer, &QTimer::timeout, this, &QrCodeScanner::handleTimerTimeout);
}

QrCodeScanner::~QrCodeScanner()
{
}

void QrCodeScanner::setCropArea(const QRect &cropArea)
{
    if (m_cropArea == cropArea)
        return;

    m_cropArea = cropArea;
    Q_EMIT cropAreaChanged();
}

QRect QrCodeScanner::cropArea() const
{
    return m_cropArea;
}

void QrCodeScanner::setRunning(const bool running)
{
    if (m_timer->isActive() == running)
        return;

    if (running) {
        m_timer->start();
    } else {
        m_timer->stop();
    }
    Q_EMIT runningChanged();
}

bool QrCodeScanner::isRunning() const
{
    return m_timer->isActive();
}

void QrCodeScanner::setSource(const QVariant &source)
{
    if (m_source == source)
        return;

    m_source = source;
    Q_EMIT sourceChanged();
}

QVariant QrCodeScanner::source() const
{
    return m_source;
}

QString QrCodeScanner::text() const
{
    return m_text;
}

void QrCodeScanner::handleSourceChanged()
{
    if (m_imageCapture != nullptr) {
        m_imageCapture->disconnect(this);
        delete m_imageCapture;
        m_imageCapture = nullptr;
    }

    QMediaObject *mediaObject = nullptr;
    if (!m_source.isNull() && m_source.isValid()) {
        auto declarativeCamera = m_source.value<QObject *>();
        if (declarativeCamera) {
            auto camera = declarativeCamera->property("mediaObject").value<QCamera *>();
            mediaObject = camera ? camera : nullptr;
        }
    }

    m_imageCapture = new QCameraImageCapture(mediaObject, this);
    m_imageCapture->setBufferFormat(QVideoFrame::Format_ARGB32);
    m_imageCapture->setCaptureDestination(QCameraImageCapture::CaptureToBuffer);
    connect(m_imageCapture, &QCameraImageCapture::imageCaptured, this, &QrCodeScanner::scanCapturedImage);
}

void QrCodeScanner::handleTimerTimeout()
{
    if (!m_imageCapture)
        return;

    if (!m_imageCapture->isReadyForCapture())
        return;

    m_imageCapture->capture();
}

void QrCodeScanner::scanCapturedImage(const int id, const QImage &image)
{
    Q_UNUSED(id)

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
            if (m_text != decodedText) {
                m_text = decodedText;
                Q_EMIT textChanged();
            }
        } else {
            // QR-code is not found.
        }
    } catch (const std::exception &e) {
        qDebug() << "Exception:" << e.what();
    }
}

QWCX_CONTROLS_END_NAMESPACE

#include "moc_qrcodescanner.cpp"

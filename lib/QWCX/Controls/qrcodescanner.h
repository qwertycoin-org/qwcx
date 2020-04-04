#ifndef QWCX_CONTROLS_QRCODESCANNER_H
#define QWCX_CONTROLS_QRCODESCANNER_H

#include <QtCore/QObject>
#include <QtCore/QRect>
#include <QtCore/QThread>
#include <QtMultimedia/QAbstractVideoSurface>
#include <QtMultimedia/QCamera>
#include <QWCX/Global/constants.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

class QrCodeScanner : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QRect cropArea READ cropArea WRITE setCropArea NOTIFY cropAreaChanged)
    Q_PROPERTY(QCamera::Status cameraStatus READ cameraStatus NOTIFY cameraStatusChanged)
    Q_PROPERTY(QString decodedText READ decodedText NOTIFY decodedTextChanged)
    Q_PROPERTY(QAbstractVideoSurface *videoSurface READ videoSurface WRITE setVideoSurface NOTIFY videoSurfaceChanged)

public:
    explicit QrCodeScanner(QObject *parent = nullptr);
    ~QrCodeScanner() override;

    void setCropArea(const QRect &cropArea);
    QRect cropArea() const;

    QCamera::Status cameraStatus() const;

    QString decodedText() const;

    void setVideoSurface(QAbstractVideoSurface *videoSurface);
    QAbstractVideoSurface *videoSurface() const;

    Q_INVOKABLE void start();
    Q_INVOKABLE void stop();

public Q_SLOTS:
    void handleQrCodeText(const QString &decodedText);
    void handleVideoFrame(const QVideoFrame &frame, const QVideoSurfaceFormat &format);

Q_SIGNALS:
    void cropAreaChanged(const QRect &cropArea);
    void cameraStatusChanged();
    void decodedTextChanged();
    void videoSurfaceChanged();

    void aboutToStart(QThread::Priority Priority = QThread::TimeCriticalPriority);
    void aboutToStop();

private:
    QRect m_cropArea;
    QThread *m_cameraThread;
    QString m_decodedText;
    QAbstractVideoSurface *m_videoSurface; // Not owned!
};

QWCX_CONTROLS_END_NAMESPACE

#endif // QWCX_CONTROLS_QRCODESCANNER_H

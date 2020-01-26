#ifndef QWCX_CONTROLS_QRCODESCANNER_H
#define QWCX_CONTROLS_QRCODESCANNER_H

#include <QtCore/QObject>
#include <QtCore/QRect>
#include <QtCore/QVariant>
#include <QWCX/Global/constants.h>

QT_BEGIN_NAMESPACE
class QCameraImageCapture;
class QTimer;
QT_END_NAMESPACE

QWCX_CONTROLS_BEGIN_NAMESPACE

class QrCodeScanner : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QRect cropArea READ cropArea WRITE setCropArea NOTIFY cropAreaChanged)
    Q_PROPERTY(int interval READ interval WRITE setInterval NOTIFY intervalChanged)
    Q_PROPERTY(bool running READ isRunning WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(QVariant source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString text READ text NOTIFY textChanged)

public:
    explicit QrCodeScanner(QObject *parent = nullptr);
    ~QrCodeScanner() override;

    void setCropArea(const QRect &cropArea);
    QRect cropArea() const;

    void setInterval(const int interval);
    int interval() const;

    void setRunning(const bool running);
    bool isRunning() const;

    void setSource(const QVariant &source);
    QVariant source() const;

    QString text() const;

Q_SIGNALS:
    void cropAreaChanged();
    void intervalChanged();
    void runningChanged();
    void sourceChanged();
    void textChanged();

private Q_SLOTS:
    void handleSourceChanged();
    void handleTimerTimeout();
    void scanCapturedImage(const int id, const QImage &image);

private:
    QRect m_cropArea;
    QCameraImageCapture *m_imageCapture;
    QVariant m_source;
    QString m_text;
    QTimer *m_timer;
};

QWCX_CONTROLS_END_NAMESPACE

#endif // QWCX_CONTROLS_QRCODESCANNER_H

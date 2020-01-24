#ifndef QWCX_CONTROLS_QRCODEITEM_H
#define QWCX_CONTROLS_QRCODEITEM_H

#include <QtQuick/QQuickPaintedItem>
#include <QWCX/Global/constants.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

class QrCodeItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    explicit QrCodeItem(QQuickItem *parent = nullptr);
    ~QrCodeItem() override;

    void setColor(const QColor &color);
    QColor color() const;

    void setText(const QString &text);
    QString text() const;

    void paint(QPainter *painter) override;

signals:
    void colorChanged();
    void textChanged();

private:
    QColor m_color;
    QString m_text;
};

QWCX_CONTROLS_END_NAMESPACE

#endif // QWCX_CONTROLS_QRCODEITEM_H

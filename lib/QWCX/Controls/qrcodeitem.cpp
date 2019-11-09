#include <QtGui/QImage>
#include <QtGui/QPainter>
#include <QWCX/Controls/qrcodeitem.h>
#include <ZXing/BarcodeFormat.h>
#include <ZXing/BitMatrix.h>
#include <ZXing/ByteMatrix.h>
#include <ZXing/MultiFormatWriter.h>
#include <ZXing/TextUtfEncoding.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

QrCodeItem::QrCodeItem(QQuickItem *parent)
    : QQuickPaintedItem(parent),
      m_color(Qt::black),
      m_text(QString{})
{
    setFillColor(Qt::white);

    connect(this, &QrCodeItem::colorChanged, this, &QQuickItem::update);
    connect(this, &QrCodeItem::textChanged, this, &QQuickItem::update);
}

QrCodeItem::~QrCodeItem()
{
}

void QrCodeItem::setColor(const QColor &color)
{
    if (m_color == color)
        return;

    m_color = color;
    emit colorChanged();
}

QColor QrCodeItem::color() const
{
    return m_color;
}

void QrCodeItem::setText(const QString &text)
{
    if (m_text == text)
        return;

    m_text = text;
    emit textChanged();
}

QString QrCodeItem::text() const
{
    return m_text;
}

void QrCodeItem::paint(QPainter *painter)
{
    QImage image{int(width()), int(height()), QImage::Format_ARGB32};

    try {
        const std::string str = text().toStdString();

        ZXing::ByteMatrix bitmap;
        if (!str.empty()) {
            const auto data = ZXing::TextUtfEncoding::FromUtf8(str);
            const ZXing::MultiFormatWriter writer{ZXing::BarcodeFormat::QR_CODE};
            bitmap = writer.encode(data, image.width(), image.height()).toByteMatrix();
        }

        for (int i = 0; i < bitmap.size(); ++i) {
            const bool isFilled = (bitmap.data()[i] == -1); // empty is 0, filled is -1
            const int offset = i * 4;

            // ARGB32
            image.bits()[offset + 0] = color().blue();
            image.bits()[offset + 1] = color().green();
            image.bits()[offset + 2] = color().red();
            image.bits()[offset + 3] = isFilled ? color().alpha() : 0;
        }
    } catch (const std::exception &) {
        image.fill(Qt::transparent);
    }

    painter->drawImage(QPoint(0, 0), image);
}

QWCX_CONTROLS_END_NAMESPACE

#include "moc_qrcodeitem.cpp"

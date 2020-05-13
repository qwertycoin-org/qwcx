#include <QtQml/QJSEngine>
#include <QtQml/QQmlEngine>
#include <QWCX/Core/qwcx.h>

QWCX_CORE_BEGIN_NAMESPACE

static Qwcx *m_instance = nullptr;

Qwcx::Qwcx(QObject *parent)
    : QObject(parent),
      m_mnemonics(new QwcxMnemonics(this))
{
}

Qwcx::~Qwcx()
{
}

QVariantList Qwcx::communityLinks() const
{
    QVariantList links = {
        QVariantMap({
            {
                QStringLiteral("title"),
                QStringLiteral("Facebook")
            },
            {
                QStringLiteral("link"),
                QStringLiteral("https://facebook.com/Qwertycoin-422694361519282")
            }
        }),
        QVariantMap({
            {
                QStringLiteral("title"),
                QStringLiteral("Medium")
            },
            {
                QStringLiteral("link"),
                QStringLiteral("https://medium.com/@xecuteqwc")
            }
        }),
        QVariantMap({
            {
                QStringLiteral("title"),
                QStringLiteral("Twitter")
            },
            {
                QStringLiteral("link"),
                QStringLiteral("https://twitter.com/qwertycoin_qwc")
            }
        })
    };

    return links;
}

QVariantList Qwcx::ecosystemLinks() const
{
    QVariantList links = {
        QVariantMap({
            {
                QStringLiteral("title"),
                QStringLiteral("Explorer")
            },
            {
                QStringLiteral("link"),
                QStringLiteral("https://explorer.qwertycoin.org")
            }
        }),
        QVariantMap({
            {
                QStringLiteral("title"),
                QStringLiteral("CoinMarketCap")
            },
            {
                QStringLiteral("link"),
                QStringLiteral("https://coinmarketcap.com/currencies/qwertycoin")
            }
        }),
        QVariantMap({
            {
                QStringLiteral("title"),
                QStringLiteral("CoinStats")
            },
            {
                QStringLiteral("link"),
                QStringLiteral("https://coinstats.app/en/coins/qwertycoin")
            }
        })
    };

    return links;
}

QwcxMnemonics *Qwcx::mnemonics() const
{
    return m_mnemonics;
}

Qwcx *Qwcx::instance()
{
    return m_instance ? m_instance : new Qwcx(nullptr);
}

Qwcx *Qwcx::i()
{
    return Qwcx::instance();
}

void Qwcx::destroyInstance()
{
    if (!m_instance)
        return;

    delete m_instance;
    m_instance = nullptr;
}

QObject *Qwcx::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(scriptEngine)

    Qwcx *object = Qwcx::instance();

    engine->setObjectOwnership(object, QQmlEngine::ObjectOwnership::CppOwnership);

    return object;
}

QWCX_CORE_END_NAMESPACE

#include "moc_qwcx.cpp"

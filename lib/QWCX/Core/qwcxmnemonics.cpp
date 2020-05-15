#include <QWCX/Core/qwcxmnemonics.h>
#include <QWCX/Core/private/chinesesimplifiedlanguage.h>
#include <QWCX/Core/private/dutchlanguage.h>
#include <QWCX/Core/private/englishlanguage.h>
#include <QWCX/Core/private/frenchlanguage.h>
#include <QWCX/Core/private/germanlanguage.h>

QWCX_CORE_BEGIN_NAMESPACE

QwcxMnemonics::QwcxMnemonics(QObject *parent)
    : QObject(parent)
{
    m_languages = {
        { QStringLiteral("zh_CN"), new ChineseSimplifiedLanguage() },
        { QStringLiteral("nl_NL"), new DutchLanguage() },
        { QStringLiteral("en_US"), new EnglishLanguage() },
        { QStringLiteral("fr_FR"), new FrenchLanguage() },
        { QStringLiteral("de_DE"), new GermanLanguage() }
    };
}

QwcxMnemonics::~QwcxMnemonics()
{
    for (AbstractLanguage *language : m_languages.values()) {
        delete language;
        language = nullptr;
    }
    m_languages.clear();
    m_languages.squeeze();
}

QStringList QwcxMnemonics::locales() const
{
    return m_languages.keys();
}

QString QwcxMnemonics::randomWord(const QString &locale) const
{
    if (!m_languages.contains(locale)) {
        return QString();
    }

    return QString();
}

QStringList QwcxMnemonics::randomWords(const QString &locale, const int count) const
{
    if (count < 1) {
        return QStringList();
    }

    QStringList words;
    for (int i = 0; i < count; ++i) {
        words.append(randomWord(locale));
    }
    words.removeAll(QString()); // remove empty parts

    return words;
}

QWCX_CORE_END_NAMESPACE

#include "moc_qwcxmnemonics.cpp"

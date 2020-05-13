#ifndef QWCX_CORE_QWCXMNEMONICS_H
#define QWCX_CORE_QWCXMNEMONICS_H

#include <QtCore/QHash>
#include <QtCore/QObject>
#include <QWCX/Global/constants.h>

QWCX_CORE_BEGIN_NAMESPACE

class AbstractLanguage;

class QwcxMnemonics : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList locales READ locales CONSTANT)

public:
    explicit QwcxMnemonics(QObject *parent = nullptr);
    ~QwcxMnemonics() override;

    QStringList locales() const;

    Q_INVOKABLE QString randomWord(const QString &locale = QStringLiteral("en_US")) const;
    Q_INVOKABLE QStringList randomWords(const QString &locale = QStringLiteral("en_US"), const int count = 0) const;

private:
    QHash<QString, AbstractLanguage *> m_languages;
};

QWCX_CORE_END_NAMESPACE

#endif // QWCX_CORE_QWCXMNEMONICS_H

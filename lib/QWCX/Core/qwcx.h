#ifndef QWCX_CORE_QWCX_H
#define QWCX_CORE_QWCX_H

#include <QtCore/QObject>
#include <QWCX/Core/qwcxmnemonics.h>
#include <QWCX/Global/constants.h>

QT_BEGIN_NAMESPACE
class QJSEngine;
class QQmlEngine;
QT_END_NAMESPACE

QWCX_CORE_BEGIN_NAMESPACE

class Qwcx : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList communityLinks READ communityLinks CONSTANT)
    Q_PROPERTY(QVariantList ecosystemLinks READ ecosystemLinks CONSTANT)
    Q_PROPERTY(QwcxMnemonics *mnemonics READ mnemonics CONSTANT)

    explicit Qwcx(QObject *parent = nullptr);
    ~Qwcx() override;

public:
    QVariantList communityLinks() const;

    QVariantList ecosystemLinks() const;

    QwcxMnemonics *mnemonics() const;

    // Used from C++
    static Qwcx *instance();
    static Qwcx *i();
    static void destroyInstance();

    // Used from QML
    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);

private:
    QwcxMnemonics *m_mnemonics;

private:
    Q_DISABLE_COPY(Qwcx)
};

QWCX_CORE_END_NAMESPACE

#endif // QWCX_CORE_QWCX_H

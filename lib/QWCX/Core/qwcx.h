#ifndef QWCX_CORE_QWCX_H
#define QWCX_CORE_QWCX_H

#include <QtCore/QObject>
#include <QWCX/Global/constants.h>

QT_BEGIN_NAMESPACE
class QJSEngine;
class QQmlEngine;
QT_END_NAMESPACE

QWCX_CORE_BEGIN_NAMESPACE

class Qwcx : public QObject
{
    Q_OBJECT

    explicit Qwcx(QObject *parent = nullptr);
    ~Qwcx() override;

public:
    // Used from C++
    static Qwcx *instance();
    static Qwcx *i();
    static void destroyInstance();

    // Used from QML
    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);

private:
    Q_DISABLE_COPY(Qwcx)
};

QWCX_CORE_END_NAMESPACE

#endif // QWCX_CORE_QWCX_H

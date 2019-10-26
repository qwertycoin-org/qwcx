#include <QtQml/qqml.h>
#include <QWCX/Controls/qmlcontrolsplugin.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

void QmlControlsPlugin::registerTypes(const char *uri)
{
    qmlRegisterModule(uri, 1, 0);
}

void QmlControlsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(engine)
    Q_UNUSED(uri)
}

QWCX_CONTROLS_END_NAMESPACE

#include "moc_qmlcontrolsplugin.cpp"

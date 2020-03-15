#include <QtQml/qqml.h>
#include <QWCX/Controls/Fluid/qwcxcontrolsfluidplugin.h>
#include <QWCX/Controls/Fluid/qwcxcontrolsfluidstyle_p.h>

inline void initResources()
{
#ifdef QT_STATICPLUGIN
    Q_INIT_RESOURCE(qwcxcontrolsfluidplugin);
#endif
}

inline void cleanupResources()
{
#ifdef QT_STATICPLUGIN
    Q_CLEANUP_RESOURCE(qwcxcontrolsfluidplugin);
#endif
}

QWCX_CONTROLS_BEGIN_NAMESPACE

QwcxControlsFluidPlugin::QwcxControlsFluidPlugin(QObject *parent)
    : QQmlExtensionPlugin(parent)
{
    initResources();
}

QwcxControlsFluidPlugin::~QwcxControlsFluidPlugin()
{
    cleanupResources();
}

void QwcxControlsFluidPlugin::registerTypes(const char *uri)
{
    qmlRegisterModule(uri, 1, 0);

    qmlRegisterUncreatableType<QwcxControlsFluidStyle>(uri, 1, 0, "Fluid", tr("Fluid is an attached property"));
}

void QwcxControlsFluidPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(engine)
    Q_UNUSED(uri)
}

QWCX_CONTROLS_END_NAMESPACE

#include "moc_qwcxcontrolsfluidplugin.cpp"

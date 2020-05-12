#include <QtQml/qqml.h>
#include <QWCX/Core/qwcx.h>
#include <QWCX/Core/qwcxcoreplugin.h>

inline void initResources()
{
#ifdef QT_STATICPLUGIN
    Q_INIT_RESOURCE(qwcxcoreplugin);
#endif
}

inline void cleanupResources()
{
#ifdef QT_STATICPLUGIN
    Q_CLEANUP_RESOURCE(qwcxcoreplugin);
#endif
}

QWCX_CORE_BEGIN_NAMESPACE

QwcxCorePlugin::QwcxCorePlugin(QObject *parent)
    : QQmlExtensionPlugin(parent)
{
    initResources();
}

QwcxCorePlugin::~QwcxCorePlugin()
{
    cleanupResources();
}

void QwcxCorePlugin::registerTypes(const char *uri)
{
    qmlRegisterModule(uri, 1, 0);
    qmlRegisterSingletonType<Qwcx>(uri, 1, 0, "Qwcx", &Qwcx::qmlInstance);
}

void QwcxCorePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(engine)
    Q_UNUSED(uri)
}

QWCX_CORE_END_NAMESPACE

#include "moc_qwcxcoreplugin.cpp"

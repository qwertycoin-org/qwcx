#include <QtQml/qqml.h>
#include <QWCX/Controls/qrcodeitem.h>
#include <QWCX/Controls/qrcodescanner.h>
#include <QWCX/Controls/qwcxcontrolsplugin.h>

inline void initResources()
{
#ifdef QT_STATICPLUGIN
    Q_INIT_RESOURCE(qwcxcontrolsplugin);
#endif
}

inline void cleanupResources()
{
#ifdef QT_STATICPLUGIN
    Q_CLEANUP_RESOURCE(qwcxcontrolsplugin);
#endif
}

QWCX_CONTROLS_BEGIN_NAMESPACE

QwcxControlsPlugin::QwcxControlsPlugin(QObject *parent)
    : QQmlExtensionPlugin(parent)
{
    initResources();
}

QwcxControlsPlugin::~QwcxControlsPlugin()
{
    cleanupResources();
}

void QwcxControlsPlugin::registerTypes(const char *uri)
{
    qmlRegisterModule(uri, 1, 0);

    qmlRegisterType<QrCodeItem>(uri, 1, 0, "QrCodeItem");
    qmlRegisterType<QrCodeScanner>(uri, 1, 0, "QrCodeScanner");
}

void QwcxControlsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(engine)
    Q_UNUSED(uri)
}

QWCX_CONTROLS_END_NAMESPACE

#include "moc_qwcxcontrolsplugin.cpp"

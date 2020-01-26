#include <QtQml/qqml.h>
#include <QWCX/Controls/qmlcontrolsplugin.h>
#include <QWCX/Controls/qrcodeitem.h>
#include <QWCX/Controls/qrcodescanner.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

void QmlControlsPlugin::registerTypes(const char *uri)
{
    qmlRegisterModule(uri, 1, 0);

    qmlRegisterType<QrCodeItem>("QWCX.Controls", 1, 0, "QrCodeItem");
    qmlRegisterType<QrCodeScanner>("QWCX.Controls", 1, 0, "QrCodeScanner");
}

void QmlControlsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(engine)
    Q_UNUSED(uri)
}

QWCX_CONTROLS_END_NAMESPACE

#include "moc_qmlcontrolsplugin.cpp"

#ifndef QWCX_CONTROLS_QMLCONTROLSPLUGIN_H
#define QWCX_CONTROLS_QMLCONTROLSPLUGIN_H

#include <QtQml/QQmlExtensionPlugin>
#include <QWCX/Global/constants.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

class QmlControlsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    explicit QmlControlsPlugin(QObject *parent = nullptr) : QQmlExtensionPlugin(parent) {};
    ~QmlControlsPlugin() override = default;

    void registerTypes(const char *uri) override;
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
};

QWCX_CONTROLS_END_NAMESPACE

#endif // QWCX_CONTROLS_QMLCONTROLSPLUGIN_H

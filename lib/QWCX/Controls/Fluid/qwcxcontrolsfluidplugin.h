#ifndef QWCX_CONTROLS_FLUID_QWCXCONTROLSFLUIDPLUGIN_H
#define QWCX_CONTROLS_FLUID_QWCXCONTROLSFLUIDPLUGIN_H

#include <QtQml/QQmlExtensionPlugin>
#include <QWCX/Global/constants.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

class QwcxControlsFluidPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    explicit QwcxControlsFluidPlugin(QObject *parent = nullptr);
    ~QwcxControlsFluidPlugin() override;

    void registerTypes(const char *uri) override;
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
};

QWCX_CONTROLS_END_NAMESPACE

#endif // QWCX_CONTROLS_FLUID_QWCXCONTROLSFLUIDPLUGIN_H

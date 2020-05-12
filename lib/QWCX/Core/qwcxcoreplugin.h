#ifndef QWCX_CORE_QWCXCOREPLUGIN_H
#define QWCX_CORE_QWCXCOREPLUGIN_H

#include <QtQml/QQmlExtensionPlugin>
#include <QWCX/Global/constants.h>

QWCX_CORE_BEGIN_NAMESPACE

class QwcxCorePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    explicit QwcxCorePlugin(QObject *parent = nullptr);
    ~QwcxCorePlugin() override;

    void registerTypes(const char *uri) override;
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
};

QWCX_CORE_END_NAMESPACE

#endif // QWCX_CORE_QWCXCOREPLUGIN_H

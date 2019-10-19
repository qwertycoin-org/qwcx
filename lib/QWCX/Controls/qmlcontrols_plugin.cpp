#include <QtQml/qqml.h>
#include <QWCX/Controls/qmlcontrols_plugin.h>

inline void initializeResources()
{
    Q_INIT_RESOURCE(qmlcontrols);
}

QWCX_BEGIN_NAMESPACE

void Controls::initialize()
{
    initializeResources();
}

QWCX_END_NAMESPACE

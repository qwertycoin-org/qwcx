#ifndef QWCX_GLOBAL_CONSTANTS_H
#define QWCX_GLOBAL_CONSTANTS_H

#define QWCX_BEGIN_NAMESPACE namespace QWCX {
#define QWCX_END_NAMESPACE }
#define QWCX_USE_NAMESPACE using namespace QWCX;

#define QWCX_CONTROLS_BEGIN_NAMESPACE namespace QWCX { namespace Controls {
#define QWCX_CONTROLS_END_NAMESPACE } /* Controls */ } /* QWCX */

#define QWCX_CORE_BEGIN_NAMESPACE namespace QWCX { namespace Core {
#define QWCX_CORE_END_NAMESPACE } /* Core */ } /* QWCX */

#include <QtCore/QObject>

QWCX_BEGIN_NAMESPACE

class Constants : public QObject
{
    Q_OBJECT

public:
    explicit Constants(QObject *parent = nullptr);
    ~Constants() override;
};

QWCX_END_NAMESPACE

#endif // QWCX_GLOBAL_CONSTANTS_H

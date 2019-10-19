#ifndef QWCX_GLOBAL_CONSTANTS_H
#define QWCX_GLOBAL_CONSTANTS_H

#define QWCX_BEGIN_NAMESPACE namespace QWCX {
#define QWCX_END_NAMESPACE }
#define QWCX_USE_NAMESPACE using namespace QWCX;

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

#ifndef QWCX_APPLICATIONCONSTANTS_H
#define QWCX_APPLICATIONCONSTANTS_H

#define QWCX_BEGIN_NAMESPACE namespace QWCX {
#define QWCX_END_NAMESPACE }
#define QWCX_USE_NAMESPACE using namespace QWCX;

#include <QtCore/QObject>

QWCX_BEGIN_NAMESPACE

class ApplicationConstants : public QObject
{
    Q_OBJECT

public:
    explicit ApplicationConstants(QObject *parent = nullptr);
    ~ApplicationConstants() override = default;

    static QString applicationDisplayName();
    static QString applicationName();
    static QString applicationVersion();

    static QString organizationDomain();
    static QString organizationName();
};

QWCX_END_NAMESPACE

#endif // QWCX_APPLICATIONCONSTANTS_H

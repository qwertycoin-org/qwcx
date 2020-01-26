#ifndef QWCX_APPLICATIONCONSTANTS_H
#define QWCX_APPLICATIONCONSTANTS_H

#include <QtCore/QObject>
#include <QWCX/Global/constants.h>

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

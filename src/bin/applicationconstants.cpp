#include "applicationconstants.h"

QWCX_BEGIN_NAMESPACE

ApplicationConstants::ApplicationConstants(QObject *parent)
    : QObject(parent)
{
}

QString ApplicationConstants::applicationDisplayName()
{
    return QStringLiteral(QWCX_APPLICATION_DISPLAY_NAME);
}

QString ApplicationConstants::applicationName()
{
    return QStringLiteral(QWCX_APPLICATION_NAME);
}

QString ApplicationConstants::applicationVersion()
{
    return QStringLiteral(QWCX_APPLICATION_VERSION);
}

QString ApplicationConstants::organizationDomain()
{
    return QStringLiteral(QWCX_ORGANIZATION_DOMAIN);
}

QString ApplicationConstants::organizationName()
{
    return QStringLiteral(QWCX_ORGANIZATION_NAME);
}

QWCX_END_NAMESPACE

#include "moc_applicationconstants.cpp"

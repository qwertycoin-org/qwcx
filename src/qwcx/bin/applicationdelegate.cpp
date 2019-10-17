#include <iostream>
#include <QtQml/QQmlApplicationEngine>
#include <QtWidgets/QApplication>
#include "applicationconstants.h"
#include "applicationdelegate.h"

QWCX_BEGIN_NAMESPACE

ApplicationDelegate::ApplicationDelegate(QObject *parent)
    : QObject(parent),
      m_qmlApplicationEngine(nullptr)
{
    initialize();
}

ApplicationDelegate::~ApplicationDelegate()
{
    close();
}

bool ApplicationDelegate::show()
{
    if (m_qmlApplicationEngine)
        return false;

    m_qmlApplicationEngine = new QQmlApplicationEngine(this);
    m_qmlApplicationEngine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return (m_qmlApplicationEngine->rootObjects().count() == 1);
}

void ApplicationDelegate::close()
{
    if (m_qmlApplicationEngine) {
        delete m_qmlApplicationEngine;
        m_qmlApplicationEngine = nullptr;
    }
}

void ApplicationDelegate::handleDebugMessage(QtMsgType t,
                                             const QMessageLogContext &ctx,
                                             const QString &msg)
{
    Q_UNUSED(t)
    Q_UNUSED(ctx)

    // TODO: Add better message handling support
    // TODO: Handle QT_NO_WARNING_OUTPUT and QT_NO_DEBUG_OUTPUT

    std::cout << msg.toStdString() << std::endl;
}

void ApplicationDelegate::initialize()
{
    initializeAttributes();
    initializeBreakpad();
    initializeCredentials();
}

void ApplicationDelegate::initializeAttributes()
{
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling, true);
    QApplication::setAttribute(Qt::AA_DisableWindowContextHelpButton, true);
}

void ApplicationDelegate::initializeBreakpad()
{
    // TODO: Initialize Google Breakpad.
}

void ApplicationDelegate::initializeCredentials()
{
    QApplication::setApplicationDisplayName(ApplicationConstants::applicationDisplayName());
    QApplication::setApplicationName(ApplicationConstants::applicationName());
    QApplication::setApplicationVersion(ApplicationConstants::applicationVersion());
    QApplication::setOrganizationDomain(ApplicationConstants::organizationDomain());
    QApplication::setOrganizationName(ApplicationConstants::organizationName());
}

QWCX_END_NAMESPACE

#include "moc_applicationdelegate.cpp"

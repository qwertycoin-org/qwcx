#include <iostream>
#include <QtCore/QFile>
#include <QtGui/QFontDatabase>
#include <QtGui/QIcon>
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
    initializeFontDatabase();
    initializeIconTheme();
}

void ApplicationDelegate::initializeAttributes()
{
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

void ApplicationDelegate::initializeFontDatabase()
{
    const QStringList fonts = QStringList()
        << QStringLiteral("Roboto/Roboto-Black.ttf")
        << QStringLiteral("Roboto/Roboto-BlackItalic.ttf")
        << QStringLiteral("Roboto/Roboto-Bold.ttf")
        << QStringLiteral("Roboto/Roboto-BoldItalic.ttf")
        << QStringLiteral("Roboto/Roboto-Light.ttf")
        << QStringLiteral("Roboto/Roboto-LightItalic.ttf")
        << QStringLiteral("Roboto/Roboto-Medium.ttf")
        << QStringLiteral("Roboto/Roboto-MediumItalic.ttf")
        << QStringLiteral("Roboto/Roboto-Regular.ttf")
        << QStringLiteral("Roboto/Roboto-RegularItalic.ttf")
        << QStringLiteral("Roboto/Roboto-Thin.ttf")
        << QStringLiteral("Roboto/Roboto-ThinItalic.ttf");

    for (const QString &font : fonts) {
        const QString fileName = QStringLiteral(":/resources/fonts/%1").arg(font);
        if (!QFile::exists(fileName))
            continue;

        const int fontId = QFontDatabase::addApplicationFont(fileName);
        Q_UNUSED(fontId)
    }
}

void ApplicationDelegate::initializeIconTheme()
{
    QStringList searchPaths = QIcon::themeSearchPaths();
    searchPaths.append(QStringLiteral(":/resources/icons"));
    QIcon::setThemeSearchPaths(searchPaths);

    QIcon::setThemeName(QStringLiteral("MaterialIcons"));
}

QWCX_END_NAMESPACE

#include "moc_applicationdelegate.cpp"

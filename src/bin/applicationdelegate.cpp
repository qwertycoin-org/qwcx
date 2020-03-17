#include <iostream>
#include <QtCore/QFile>
#include <QtGui/QFontDatabase>
#include <QtGui/QIcon>
#include <QtQml/QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
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
    if (m_qmlApplicationEngine) {
        delete m_qmlApplicationEngine;
        m_qmlApplicationEngine = nullptr;
    }
}

bool ApplicationDelegate::show()
{
    if (m_qmlApplicationEngine)
        return false;

    m_qmlApplicationEngine = new QQmlApplicationEngine(this);
    m_qmlApplicationEngine->addImportPath(QStringLiteral(":/lib"));
    m_qmlApplicationEngine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return (m_qmlApplicationEngine->rootObjects().count() == 1);
}

void ApplicationDelegate::hide()
{
    if (!m_qmlApplicationEngine)
        return;

    if (m_qmlApplicationEngine->rootObjects().count() < 1)
        return;

    QObject *rootWindow = m_qmlApplicationEngine->rootObjects().at(0);
    if (rootWindow->metaObject()->indexOfMethod("hide") < 0)
        return;

    rootWindow->metaObject()->invokeMethod(rootWindow, "hide", Qt::DirectConnection);
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
    initializeDeclarativeControlsStyle();
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

void ApplicationDelegate::initializeDeclarativeControlsStyle()
{
    qputenv("QT_QUICK_CONTROLS_CONF", QByteArrayLiteral(":/resources/qtquickcontrols2.conf"));

    // The style must be configured before loading QML that imports Qt Quick Controls 2.
    // It is not possible to change the style after the QML types have been registered.
#ifdef Q_OS_WINDOWS
    QQuickStyle::setStyle(QStringLiteral("Universal"));
#else
    QQuickStyle::setStyle(QStringLiteral("Material"));
#endif

    // The fallback style must be the name of one of the built-in Qt Quick Controls 2 styles.
    QQuickStyle::setFallbackStyle(QStringLiteral("Default"));
}

void ApplicationDelegate::initializeFontDatabase()
{
    const QStringList fonts = QStringList()
        << QStringLiteral("Eczar/Eczar-Bold.ttf")
        << QStringLiteral("Eczar/Eczar-Regular.ttf")
        << QStringLiteral("Roboto/Roboto-Regular.ttf") // Unused. Makes "Material" style happy.
        << QStringLiteral("RobotoCondensed/RobotoCondensed-Bold.ttf")
        << QStringLiteral("RobotoCondensed/RobotoCondensed-Light.ttf")
        << QStringLiteral("RobotoCondensed/RobotoCondensed-Regular.ttf")
        << QStringLiteral("SegoeUI/SegoeUI-Regular.ttf"); // Unused. Makes "Universal" style happy.

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

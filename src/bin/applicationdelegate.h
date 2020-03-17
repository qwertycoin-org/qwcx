#ifndef QWCX_APPLICATIONDELEGATE_H
#define QWCX_APPLICATIONDELEGATE_H

#include <QtCore/QObject>
#include "applicationconstants.h"

QT_BEGIN_NAMESPACE
class QQmlApplicationEngine;
QT_END_NAMESPACE

QWCX_BEGIN_NAMESPACE

class ApplicationDelegate : public QObject
{
    Q_OBJECT

public:
    explicit ApplicationDelegate(QObject *parent = nullptr);
    ~ApplicationDelegate() override;

    bool show();
    void hide();

public slots:
    static void handleDebugMessage(QtMsgType t, const QMessageLogContext &ctx, const QString &msg);

private:
    void initialize(); // all-in-one application initializer
    void initializeAttributes();
    void initializeBreakpad();
    void initializeCredentials();
    void initializeDeclarativeControlsStyle();
    void initializeFontDatabase();
    void initializeIconTheme();

private:
    QQmlApplicationEngine *m_qmlApplicationEngine;
};

QWCX_END_NAMESPACE

#endif // QWCX_APPLICATIONDELEGATE_H

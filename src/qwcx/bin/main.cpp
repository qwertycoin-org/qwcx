#include <QtWidgets/QApplication>
#include "applicationdelegate.h"

QWCX_USE_NAMESPACE

int main(int argc, char **argv)
{
    qInstallMessageHandler(ApplicationDelegate::handleDebugMessage);

    QApplication app(argc, argv);

    ApplicationDelegate delegate(&app);
    const bool ok = delegate.show();
    if (!ok) {
        // Unable to initialize QML root object.
        return EXIT_FAILURE;
    }

    return QApplication::exec();
}

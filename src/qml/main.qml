import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ApplicationWindow {
    id: root
    width: 320
    height: 568
    minimumWidth: 320
    minimumHeight: 480
    font: Fluid.font(Fluid.Body1)
    title: Qt.application.displayName
    visible: true

    Fluid.theme: Fluid.System
}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls.Fluid 1.0

Frame {
    id: control

    property real radius: 2

    Fluid.elevation: 0

    background: Rectangle {
        radius: control.radius
        color: control.Fluid.surface
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls.Fluid 1.0

Frame {
    id: control

    Fluid.elevation: 0

    background: Rectangle {
        radius: 2
        color: control.Fluid.surface
    }
}

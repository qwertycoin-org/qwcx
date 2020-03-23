import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls.Fluid 1.0

Label {
    id: control

    property int size: 1

    font: control.size >= 2 ? Fluid.font(Fluid.Subtitle1) : Fluid.font(Fluid.Subtitle1)
}

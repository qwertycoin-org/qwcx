import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Templates 2.12 as T

T.Frame {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 12
    verticalPadding: Material.frameVerticalPadding

    Material.elevation: 2

    background: Rectangle {
        radius: 4
        border {
            color: control.Material.elevation > 0 ? "transparent" : control.Material.frameColor
            width: 1
        }
        color: control.Material.elevation > 0 ? control.Material.backgroundColor : "transparent"

        layer {
            effect: ElevationEffect {
                elevation: control.Material.elevation
            }
            enabled: control.enabled && control.Material.elevation > 0
        }
    }
}

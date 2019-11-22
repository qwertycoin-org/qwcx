import QtQuick 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Templates 2.12 as T

T.ItemDelegate {
    id: control

    implicitWidth: {
        var totalBackgroundWidth = implicitBackgroundWidth + leftInset + rightInset
        var totalContentWidth = implicitContentWidth + leftPadding + rightPadding

        return Math.max(totalBackgroundWidth, totalContentWidth)
    }
    implicitHeight: {
        var totalBackgroundHeight = implicitBackgroundHeight + topInset + bottomInset
        var totalContentHeight = implicitContentHeight + topPadding + bottomPadding
        var totalIndicatorHeight = implicitIndicatorHeight + topPadding + bottomPadding

        return Math.max(totalBackgroundHeight, totalContentHeight, totalIndicatorHeight)
    }
    padding: 12
    verticalPadding: control.Material.frameVerticalPadding
    display: T.ItemDelegate.TextUnderIcon
    icon {
        width: 24
        height: 24
        color: enabled ? control.Material.foreground : control.Material.hintTextColor
    }
    hoverEnabled: true

    Material.elevation: control.hovered && !control.down ? 4 : 2

    background: Rectangle {
        implicitWidth: 96
        implicitHeight: 96
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

    contentItem: Item {
        anchors {
            centerIn: control.display === T.ItemDelegate.IconOnly ? parent : undefined
        }
        implicitWidth: contentItemColumn.width
        implicitHeight: contentItemColumn.height

        Column {
            id: contentItemColumn
            anchors {
                bottom: parent.bottom
                left: parent.left
            }
            spacing: control.spacing

            IconLabel {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                alignment: control.display === IconLabel.IconOnly ? Qt.AlignCenter : Qt.AlignLeft
                display: control.display
                mirrored: control.mirrored
                font: control.font
                icon: control.icon
                color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
                text: ""
            }

            T.Label {
                anchors.left: parent.left
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
                linkColor: control.Material.accentColor
                text: control.text
            }
        }
    }

    indicator: null
}

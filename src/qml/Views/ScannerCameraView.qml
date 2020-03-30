import QtQuick 2.12
import QtQuick.Controls 2.12

Pane {
    id: view

    readonly property rect cropArea: {
        var awidth = 256
        var aheight = 256
        var ax = (this.width - awidth) / 2
        var ay = (this.height - aheight) / 2

        return Qt.rect(ax, ay, awidth, aheight)
    }

    signal accepted()
    signal rejected()

    background: Rectangle {
        anchors {
            fill: parent
            topMargin: view.topInset
            rightMargin: view.rightInset
            bottomMargin: view.bottomInset
            leftMargin: view.leftInset
        }
        color: "black"
    }

    contentItem: Item {
        anchors.fill: parent

        RoundButton {
            anchors {
                top: parent.top
                topMargin: 8
                right: parent.right
                rightMargin: 8
            }
            display: RoundButton.IconOnly
            flat: true
            icon.name: "times"

            onClicked: view.rejected()
        }

        Rectangle {
            x: view.cropArea.x
            y: view.cropArea.y
            width: view.cropArea.width
            height: view.cropArea.height
            border {
                width: 1
                color: "white"
            }
            color: "transparent"
            visible: true

            Rectangle {
                x: 0
                y: 50
                width: parent.width
                height: 2
                color: parent.border.color
                opacity: 0.5

                SequentialAnimation on y {
                    running: true
                    loops: SequentialAnimation.Infinite

                    NumberAnimation { from: 1; to: 255; duration: 1500; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 255; to: 1; duration: 1500; easing.type: Easing.InOutQuad }
                }
            }
        }

        Frame {
            anchors {
                bottom: parent.bottom
                bottomMargin: 16
                horizontalCenter: parent.horizontalCenter
            }
            width: view.cropArea.width
            opacity: 0.5
            visible: contextualHint.length > 0

            Label {
                readonly property string contextualHint: qsTr("Loading camera...")

                width: parent.width
                height: parent.height
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                font.pixelSize: 14
                text: contextualHint
            }
        }
    } // contentItem: Item
}

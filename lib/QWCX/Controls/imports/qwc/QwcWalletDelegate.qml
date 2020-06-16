import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QWCX.Controls.Fluid 1.0

ItemDelegate {
    id: control

    property string address: ""
    property real amount: 0.0
    property color color: "grey"
    property string name: ""

    spacing: 12

    contentItem: Item {
        implicitHeight: 48

        Rectangle {
            id: rect
            width: parent.height
            height: parent.height
            color: control.color || "transparent"
            radius: 4
        }

        Label {
            anchors {
                right: parent.right
                bottom: parent.verticalCenter
                bottomMargin: 2
                left: rect.right
                leftMargin: control.spacing
            }
            font: Fluid.font(Fluid.Headline6)
            elide: Label.ElideMiddle
            text: "<b>%1</b> <i>(%2)</i>".arg(control.name).arg(control.address)
            opacity: 0.6
        }

        Label {
            anchors {
                top: parent.verticalCenter
                topMargin: 1
                right: parent.right
                left: rect.right
                leftMargin: control.spacing
            }
            font: Fluid.font(Fluid.Number2)
            text: "%1 QWC".arg(control.amount)
        }
    }
}

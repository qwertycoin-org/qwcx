import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QWCX.Controls.Fluid 1.0

ItemDelegate {
    id: control

    property real amount: 0.0
    property int confirmations: 0
    property string hash: ""
    property date timestamp: new Date(null)

    contentItem: Item {
        implicitHeight: 32

        Label {
            id: amountLabel
            anchors {
                right: timestampLabel.left
                rightMargin: 4
                left: parent.left
                bottom: parent.verticalCenter
            }
            elide: Label.ElideRight
            font: {
                var f = Fluid.font(Fluid.Number3)
                return f
            }
            color: {
                if (control.amount > 0.0)
                    return control.Material.color(Material.Green, Material.Shade700)

                return control.Material.foreground
            }
            text: _m.formatAmount(control.amount)
        }

        Label {
            id: timestampLabel
            anchors {
                right: parent.right
                verticalCenter: amountLabel.verticalCenter
            }
            font.pixelSize: 12
            text: _m.formatTimestamp(control.timestamp)
        }

        Label {
            id: hashLabel
            anchors {
                top: parent.verticalCenter
                topMargin: 2
                right: confirmationsRow.left
                rightMargin: 4
                left: parent.left
            }
            elide: Label.ElideRight
            font.pixelSize: 12
            text: _m.formatHash(control.hash)
            opacity: 0.8
        }

        Row {
            id: confirmationsRow
            anchors {
                right: parent.right
                verticalCenter: hashLabel.verticalCenter
            }
            spacing: 2

            Label {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 12
                font.bold: true
                text: control.confirmations < 1 ? qsTr("Sent") : qsTr("Confirmed")
                opacity: 0.8
            }

            Label {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 12
                font.bold: true
                text: "(%1)".arg(control.confirmations)
                opacity: 0.8
                visible: control.confirmations > 0
            }
        }
    }

////////////////////////////////////////////////////////////////////////////////////////////////////

    QtObject {
        id: _m

        function formatAmount(input) {
            return input > 0.0 ? "+%1 QWC".arg(input) : "%1 QWC".arg(input)
        }

        function formatHash(input) {
            if (!input || input.length < 1)
                return qsTr("N/A")

            return String(input)
        }

        function formatTimestamp(input) {
            if (!input || !(input instanceof Date) || input.getTime() === new Date(null).getTime())
                return qsTr("N/A")

            return Qt.formatDateTime(input, "yyyy.MM.dd hh:mm")
        }
    }
}

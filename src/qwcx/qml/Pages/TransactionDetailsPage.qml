import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: transactionDetailsPage

    property string address: ""
    property double amount: 0.0
    property double fee: 0.0
    property string paymentId: ""

    title: ""
    spacing: 0

    header: ToolBar {
        ToolButton {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "chevron_left"
            visible: transactionDetailsPage.StackView.index > 0

            onClicked: {
                var stack = transactionDetailsPage.StackView.view
                if (!stack && stack.depth > 0)
                    return

                stack.pop()
            }
        }

        Label {
            anchors.centerIn: parent
            width: parent.width - 96
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            elide: Label.ElideMiddle
            text: transactionDetailsPage.title
        }

        ToolButton {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "more_vert"

            Menu {
                x: parent.width - width
                y: parent.height
                width: 210
                dim: false
                modal: true

                MenuItem { text: qsTr("Open in Block Explorer...") }
                MenuItem { text: qsTr("Save as template...") }
                MenuItem { text: qsTr("Repeat") }

                Component.onCompleted: parent.clicked.connect(this.open)
            }
        }
    }

    contentItem: Pane {
        anchors {
            fill: parent
            topMargin: parent.header ? parent.header.height : 0
            bottomMargin: parent.footer ? parent.footer.height : 0
        }
    }

    footer: null
}

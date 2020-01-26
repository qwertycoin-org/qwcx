import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0

Page {
    id: fundsRequestPage
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
            visible: fundsRequestPage.StackView.index > 0

            onClicked: {
                var stack = fundsRequestPage.StackView.view
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
            text: fundsRequestPage.title
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
                dim: false
                modal: true

                MenuItem { text: qsTr("Customize QR-code") }
                MenuItem { text: qsTr("Reset QR-code") }

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

        Frame {
            anchors.centerIn: parent

            contentItem: Column {
                spacing: 4

                Heading {
                    anchors.left: parent.left
                    text: qsTr("Share QR-code")
                }

                Label {
                    anchors.left: parent.left
                    text: qsTr("Show this QR-code to receive funds")
                }

                // extra spacing
                Item {
                    anchors.left: parent.left
                    width: 1
                    height: 2
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 256
                    height: 256
                    color: "white"

                    QrCodeItem {
                        anchors {
                            fill: parent
                            margins: 8
                        }
                        text: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvqh52sVnNc1pYmoF2TEXsAvZnyPaZu8MW3S8EWHNfAh7X2xa63P7Y"
                    }
                }

                // extra spacing
                Item {
                    anchors.left: parent.left
                    width: 1
                    height: 2
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 11
                    opacity: 0.5
                    text: qsTr("Press QR-code to copy its content as text")
                }
            }
        }
    }

    footer: Column {
        anchors {
            right: parent.right
            left: parent.left
        }
        spacing: 0

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 11
            opacity: 0.5
            text: qsTr("Share QR-code to") + ":"
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            RoundButton {
                text: "FB"
            }

            RoundButton {
                text: "TW"
            }

            RoundButton {
                text: "WA"
            }

            RoundButton {
                text: "AA"
            }

            RoundButton {
                text: "BB"
            }
        }

        // extra spacing
        Item {
            width: 1
            height: 2
        }
    }
}

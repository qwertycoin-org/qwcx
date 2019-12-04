import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0

Page {
    id: settingsPage

    signal actionChosen(string action)

    title: ""
    spacing: 0

    header: ToolBar {
        Label {
            anchors.centerIn: parent
            width: parent.width - 96
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            elide: Label.ElideMiddle
            text: settingsPage.title
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

                MenuItem {
                    text: qsTr("Log out")

                    onTriggered: logoutConfirmationDialog.open()
                }

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

        Column {
            anchors {
                top: parent.top
                topMargin: 16
                right: parent.right
                left: parent.left
            }
            spacing: 4

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 96
                height: 96
                radius: Math.ceil(width / 2)
                color: "grey"

                Text {
                    anchors.centerIn: parent
                    font {
                        bold: true
                        pixelSize: 42
                    }
                    color: "white"
                    text: "Q"
                }
            }

            Item { // extra spacing
                width: 1
                height: 12
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    bold: true
                    pixelSize: 24
                }
                text: "QWCX wallet"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: 0.8
                text: qsTr("The easiest way to qwertycoin!")
            }

            Item { // extra spacing
                width: 1
                height: 16
            }

            Frame {
                anchors {
                    right: parent.right
                    left: parent.left
                }

                Column {
                    width: parent.width

                    Label {
                        font.bold: true
                        text: "%1:".arg(qsTr("Preferred node"))
                    }

                    ComboBox {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width + 24
                        flat: true
                        model: [
                            "node-00.qwertycoin.org:8197",
                            "node-01.qwertycoin.org:8197",
                            "node-02.qwertycoin.org:8197",
                            "node-03.qwertycoin.org:8197",
                            "node-04.qwertycoin.org:8197",
                            "node-05.qwertycoin.org:8197",
                            "198.147.30.115:8197",
                            "explorer.qwertycoin.org:8197",
                            "220.82.126.94:8197",
                            "superblockchain.con-ip.com:8197",
                            "qwertycoin.spdns.org:8197",
                            "pa-us-na-node.qwertycoin.tradecrypto.click:8197"
                        ]
                        currentIndex: 0
                    }

                    Label {
                        font.pixelSize: 11
                        opacity: 0.5
                        text: qsTr("%1: <b>%2<b>").arg(qsTr("Node state")).arg(qsTr("OK"))
                    }
                }
            }

            Item { // extra spacing
                width: 1
                height: 16
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                horizontalAlignment: Label.AlignHCenter
                text: "<b>%1</b> v%2".arg(Qt.application.displayName).arg(Qt.application.version)
            }
        }
    }

    footer: null

    Popup {
        id: logoutConfirmationDialog

        anchors.centerIn: parent
        width: 256
        height: 96
        horizontalPadding: 0
        verticalPadding: 0
        modal: true

        Column {
            anchors {
                right: parent.right
                rightMargin: 16
                left: parent.left
                leftMargin: 16
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 4
            }
            spacing: 12

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                font.bold: true
                wrapMode: Label.WordWrap
                text: qsTr("Are you sure you want to log out?")
            }

            Row {
                anchors.right: parent.right
                spacing: 8

                Button {
                    flat: true
                    text: qsTr("Cancel")

                    onClicked: logoutConfirmationDialog.close()
                }

                OutlinedButton {
                    text: qsTr("Log out")

                    onClicked: {
                        settingsPage.actionChosen("logout")
                        logoutConfirmationDialog.close()
                    }
                }
            }
        }
    }
}

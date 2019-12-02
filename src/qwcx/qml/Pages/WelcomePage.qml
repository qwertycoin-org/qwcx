import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: welcomePage

    signal actionChosen(string action)

    title: ""
    spacing: 0

    header: null

    contentItem: Pane {
        anchors {
            fill: parent
            topMargin: parent.header ? parent.header.height : 0
            bottomMargin: parent.footer ? parent.footer.height : 0
        }

        Column {
            anchors.centerIn: parent
            spacing: 4

            Rectangle {
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
                font.pixelSize: 16
                opacity: 0.8
                text: qsTr("Welcome to")
            }

            Label {
                font {
                    bold: true
                    pixelSize: 24
                }
                text: "QWCX wallet"
            }

            Label {
                opacity: 0.8
                text: qsTr("The easiest way to qwertycoin!")
            }
        }

        Column {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 4

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 256
                text: qsTr("Create new wallet")

                onClicked: welcomePage.actionChosen("create")
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "or <a href='#'>restore</a> an existing wallet"

                onLinkActivated: welcomePage.actionChosen("restore")
            }
        }
    }

    footer: null
}

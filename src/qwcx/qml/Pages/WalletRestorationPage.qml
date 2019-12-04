import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: walletRestorationPage

    signal actionChosen(string action)

    title: ""
    spacing: 0

    header: ToolBar {
        background: Item {
            implicitHeight: 48
        }

        ToolButton {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "chevron_left"

            onClicked: walletRestorationPage.actionChosen("cancel")
        }

        Label {
            anchors.centerIn: parent
            text: qsTr("Log Into Your Wallet")
        }

        ToolButton {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.TextOnly
            text: qsTr("Done")

            onClicked: walletRestorationPage.actionChosen("done")
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
                right: parent.right
                left: parent.left
            }
            spacing: 16

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                font.bold: true
                text: qsTr("Type in your secret mnemonic phrase")
            }

            TextArea {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                focus: true
                wrapMode: TextArea.WordWrap
                placeholderText: "%1...".arg(qsTr("For an existing wallet"))
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                wrapMode: Label.WordWrap
                text: {
                    var t = "<b>%1:</b> %2"
                    var arg1 = qsTr("NOTE")
                    var arg2 = qsTr("This secret mnemonic is never sent over the network.")

                    return t.arg(arg1).arg(arg2)
                }
            }
        }
    }

    footer: null
}

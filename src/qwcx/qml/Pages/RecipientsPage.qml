import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0

Page {
    id: recipientsPage

    function addNewRecipient(name, address) {
        if ((typeof name) !== "string" || name.length < 1)
            return false

        if ((typeof address) !== "string" || address.length < 1 || !address.startsWith("QWC"))
            return false

        var element = {
            "name": name,
            "address": address
        }
        _m.recipients.append(element)

        return true
    }

    title: ""
    spacing: 0

    header: ToolBar {
        Label {
            anchors.centerIn: parent
            width: parent.width - 96
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            elide: Label.ElideMiddle
            text: recipientsPage.title
        }

        ToolButton {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "person_add"

            onClicked: newRecipientDialog.open()
        }
    }

    contentItem: Pane {
        anchors {
            fill: parent
            topMargin: parent.header ? parent.header.height : 0
            bottomMargin: parent.footer ? parent.footer.height : 0
        }
        horizontalPadding: 0
        verticalPadding: 0

        contentItem: ListView {
            anchors.fill: parent
            model: _m.recipients.count
            delegate: ItemDelegate {
                width: parent ? parent.width : 0
                height: 48

                contentItem: Label {
                    anchors {
                        fill: parent
                        margins: 8
                    }
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                    text: {
                        var t = "<b>%1</b><br/>%2: %3"
                        var arg1 = _m.recipients.get(index).name
                        var arg2 = qsTr("Address")
                        var arg3 = _m.recipients.get(index).address

                        return t.arg(arg1).arg(arg2).arg(arg3)
                    }
                }
            }
            interactive: true

            Column {
                anchors.centerIn: parent
                spacing: 4
                visible: _m.recipients.count < 1

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font {
                        bold: true
                        pixelSize: 18
                    }
                    opacity: 0.5
                    text: "%1.".arg(qsTr("No recipients"))
                }

                OutlinedButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    display: OutlinedButton.TextBesideIcon
                    icon.name: "person_add"
                    text: qsTr("Add new recipient")

                    onClicked: newRecipientDialog.open()
                }
            }
        }
    }

    footer: null

    Popup {
        id: newRecipientDialog
        anchors.centerIn: parent
        width: 256
        height: 256
        horizontalPadding: 0
        verticalPadding: 0
        modal: true

        Column {
            anchors {
                fill: parent
                margins: 16
            }
            spacing: 0

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                font {
                    bold: true
                    pixelSize: 18
                }
                text: qsTr("New Recipient")
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 16
                text: "%1:".arg(qsTr("Recipient Name"))
            }

            TextField {
                id: recipientNameTextField
                anchors {
                    right: parent.right
                    left: parent.left
                }
                placeholderText: qsTr("John Doe")
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 16
                text: "%1:".arg(qsTr("Recipient Address"))
            }

            TextField {
                id: recipientAddressTextField
                anchors {
                    right: parent.right
                    left: parent.left
                }
                placeholderText: "QWC1VAGTkpgDrtGzG4iMFx2V9MpCfJvC6JVRrYFvgiYh7bfhVNoqrKf3w9dAKxEesi2ZCSckoeeMJBbSEbBv9zNt7Tq2gYaW6Z"
            }

            Item { // extra spacing
                width: 1
                height: 12
            }

            OutlinedButton {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                display: OutlinedButton.TextBesideIcon
                icon.name: "person_add"
                text: qsTr("Add")

                onClicked: {
                    var ok = recipientsPage.addNewRecipient(recipientNameTextField.text, recipientAddressTextField.text)
                    if (ok) {
                        recipientNameTextField.clear()
                        recipientAddressTextField.clear()
                        newRecipientDialog.close()
                    }
                }
            }
        }
    }

    QtObject {
        id: _m

        property ListModel recipients: ListModel { dynamicRoles: false }
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12 as Models

Page {
    id: walletCreationPage

    signal actionChosen(string action)

    function nextStep() {
        if (steps.currentIndex === steps.count - 1) {
            walletCreationPage.actionChosen("done")
            return
        }

        steps.currentIndex += 1
    }

    function previousStep() {
        if (steps.currentIndex === 0) {
            walletCreationPage.actionChosen("cancel")
            return
        }

        steps.currentIndex -= 1
    }

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

            onClicked: walletCreationPage.previousStep()
        }

        Label {
            anchors.centerIn: parent
            text: qsTr("Step %1/%2").arg(steps.currentIndex + 1).arg(steps.count)
        }

        ToolButton {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.TextOnly
            text: steps.currentIndex === steps.count - 1 ? qsTr("Done") : qsTr("Next Step")
            enabled: steps.currentItem && steps.currentItem.done

            onClicked: walletCreationPage.nextStep()
        }
    }

    contentItem: Pane {
        anchors {
            fill: parent
            topMargin: parent.header ? parent.header.height : 0
            bottomMargin: parent.footer ? parent.footer.height : 0
        }

        ListView {
            anchors.fill: parent
            orientation: Qt.Horizontal
            model: steps
            currentIndex: steps.currentIndex
            interactive: false
            highlightMoveDuration: 0
        }
    }

    footer: null

    Models.ObjectModel {
        id: steps

        property int currentIndex: 0
        readonly property var currentItem: steps.get(steps.currentIndex) || null

        Column {
            property bool done: false

            width: ListView.view ? ListView.view.width : 0
            height: ListView.view ? ListView.view.height : 0
            spacing: 16
            visible: ListView.isCurrentItem

            Repeater {
                model: ListModel {
                    id: fruitModel

                    ListElement {
                        title: qsTr("Create a wallet")
                        text: qsTr("Each wallet gets a unique word-sequence called a mnemonic.")
                    }

                    ListElement {
                        title: qsTr("Write down your mnemonic")
                        text: qsTr("It's the only way to regain access, and it's never sent to the server!")
                    }

                    ListElement {
                        title: qsTr("Keep it secret and safe")
                        text: qsTr("If you save it to an insecure location, copy, screenshot, or email it, it may be viewable by other apps.")
                    }

                    ListElement {
                        title: qsTr("Use it like an actual wallet")
                        text: qsTr("For large amounts and better privacy, make a cold-storage wallet or set your own server in settings.")
                    }

                    ListElement {
                        title: qsTr("Feel free to contact us")
                        text: qsTr("Please feel free to contact us. Our email is support@qwertycoin.org. We're here to help.")
                    }
                }
                delegate: Label {
                    width: parent ? parent.width : 0
                    leftPadding: 8
                    wrapMode: Label.Wrap
                    text: "<b>%1</b><br/>%2".arg(model.title).arg(model.text)
                }
            }

            CheckBox {
                width: parent.width
                verticalPadding: 0
                text: qsTr("Got it! Let's continue!")

                onCheckedChanged: parent.done = this.checked
            }
        }

        Column {
            property bool done: false

            width: ListView.view ? ListView.view.width : 0
            height: ListView.view ? ListView.view.height : 0
            spacing: 16
            visible: ListView.isCurrentItem

            Label {
                width: parent.width
                leftPadding: 8
                wrapMode: Label.Wrap
                text: {
                    var t = "<b>%1</b><br/>%2"
                    var title = qsTr("Write down your mnemonic!")
                    var subtitle = qsTr("You'll confirm this sequence on the next screen.")

                    return t.arg(title).arg(subtitle)
                }
            }

            Grid {
                anchors.horizontalCenter: parent.horizontalCenter
                columns: 3
                columnSpacing: 16
                rowSpacing: 16

                Repeater {
                    model: [
                        "roared", "present", "unjustly", "rugged",
                        "anchor", "bomb", "ankle", "gourmet",
                        "vipers", "begun", "names", "cuddled",
                        "artistic", "gorilla", "sake", "fences",
                        "arsenic", "hitched", "eldest", "moon",
                        "unafraid", "awkward", "sober", "suede"
                    ]
                    delegate: Label {
                        text: "%1. <b>%2</b>".arg(index + 1).arg(modelData)
                    }
                }
            }

            Label {
                width: parent.width
                leftPadding: 8
                wrapMode: Label.Wrap
                text: {
                    var t = "<b>%1:</b> %2"
                    var arg1 = qsTr("NOTE")
                    var arg2 = qsTr("This is the only way to access your wallet if you switch devices, use another wallet app, or lose your data.")

                    return t.arg(arg1).arg(arg2)
                }
            }

            CheckBox {
                width: parent.width
                verticalPadding: 0
                text: qsTr("I wrote down my mnemonic phrase")

                onCheckedChanged: parent.done = this.checked
            }
        }

        Column {
            property bool done: false

            width: ListView.view ? ListView.view.width : 0
            height: ListView.view ? ListView.view.height : 0
            spacing: 16
            visible: ListView.isCurrentItem

            Label {
                width: parent.width
                leftPadding: 8
                wrapMode: Label.Wrap
                text: {
                    var t = "<b>%1</b><br/>%2"
                    var title = qsTr("Verify your mnemonic phrase")
                    var subtitle = qsTr("Type the first 5 words in the correct order.")

                    return t.arg(title).arg(subtitle)
                }
            }

            Repeater {
                model: 5
                delegate: TextField {
                    width: parent ? parent.width : 0
                    placeholderText: "%1%2".arg(qsTr("Word #")).arg(index + 1)
                }
            }

            Button {
                width: parent.width
                text: qsTr("Confirm")

                onClicked: parent.done = true
            }
        }
    }
}

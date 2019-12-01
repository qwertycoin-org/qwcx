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

    contentItem: ScrollView {
        anchors {
            fill: parent
            topMargin: parent.header ? parent.header.height : 0
            bottomMargin: parent.footer ? parent.footer.height : 0
        }
        padding: 8
        spacing: 0
        wheelEnabled: true

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        Column {
            width: {
                var container = transactionDetailsPage.contentItem
                return container.width - container.leftPadding - container.rightPadding
            }
            spacing: 8

            GroupBox {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                title: "%1:".arg(qsTr("Transaction"))

                Column {
                    readonly property ListModel model: ListModel {
                        dynamicRoles: false

                        ListElement {
                            key: qsTr("Confirmations")
                            value: "1"
                        }

                        ListElement {
                            key: qsTr("First confirmation time")
                            value: "12/1/2019, 7:18:06 PM (2 minutes ago)"
                        }

                        ListElement {
                            key: qsTr("Unlock time")
                            value: "0"
                        }

                        ListElement {
                            key: qsTr("Fee")
                            value: "3.00000000 QWC"
                        }

                        ListElement {
                            key: qsTr("Sum of outputs")
                            value: "20005.00000000 QWC"
                        }

                        ListElement {
                            key: qsTr("Size")
                            value: "1.16 KB"
                        }

                        ListElement {
                            key: qsTr("Version")
                            value: "1"
                        }

                        ListElement {
                            key: qsTr("Mixin count")
                            value: "4"
                        }

                        ListElement {
                            key: qsTr("Extra (raw)")
                            value: "01609e9828294b792898f3734f1a1b81fb705e95b844fdbfceb2bd80c57a7d9462"
                        }

                        ListElement {
                            key: qsTr("Public key")
                            value: "609e9828294b792898f3734f1a1b81fb705e95b844fdbfceb2bd80c57a7d9462"
                        }
                    }

                    anchors {
                        right: parent.right
                        left: parent.left
                    }
                    spacing: 8

                    Repeater {
                        model: (parent && parent.model) ? parent.model.count : 0
                        delegate: Label {
                            readonly property string thisKey: parent.model.get(index).key || ""
                            readonly property string thisValue: parent.model.get(index).value || ""

                            anchors {
                                right: parent.right
                                left: parent.left
                            }
                            wrapMode: Label.Wrap
                            text: "<b>%1</b><br/>%2".arg(thisKey).arg(thisValue)
                        }
                    }
                }
            }

            GroupBox {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                title: "%1:".arg(qsTr("In Block"))

                Column {
                    readonly property ListModel model: ListModel {
                        dynamicRoles: false

                        ListElement {
                            key: qsTr("Hash")
                            value: "36420af6b108a493afaf4061b661b10e9eb02d4db42c35536cf008d472915d0e"
                        }

                        ListElement {
                            key: qsTr("Height")
                            value: "466599"
                        }

                        ListElement {
                            key: qsTr("Timestamp")
                            value: "12/1/2019, 7:18:06 PM"
                        }
                    }

                    anchors {
                        right: parent.right
                        left: parent.left
                    }
                    spacing: 8

                    Repeater {
                        model: (parent && parent.model) ? parent.model.count : 0
                        delegate: Label {
                            readonly property string thisKey: parent.model.get(index).key || ""
                            readonly property string thisValue: parent.model.get(index).value || ""

                            anchors {
                                right: parent.right
                                left: parent.left
                            }
                            wrapMode: Label.Wrap
                            text: "<b>%1</b><br/>%2".arg(thisKey).arg(thisValue)
                        }
                    }
                }
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 8
                font.pixelSize: 12
                horizontalAlignment: Label.AlignHCenter
                wrapMode: Label.WordWrap
                text: qsTr("For more information please visit\nonline blockchain explorer")
                opacity: 0.8
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    bold: true
                    pixelSize: 12
                }
                text: {
                    var t = "<a href='https://explorer.qwertycoin.org/?hash=%1#blockchain_transaction'>%2</a>"

                    var hash = "edd0a7cf79f73ad8ddc55f6d87d7c2fcadf9ee406f504c4925f9933228a2a7b0"
                    var site = "explorer.qwertycoin.org"

                    return t.arg(hash).arg(site)
                }

                onLinkActivated: Qt.openUrlExternally(link)
            }

            Item { // extra spacing
                width: parent.width
                height: 2
            }
        }
    }

    footer: null
}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view

    readonly property string blockExplorerLink: {
        var hash = "edd0a7cf79f73ad8ddc55f6d87d7c2fcadf9ee406f504c4925f9933228a2a7b0"
        return "https://explorer.qwertycoin.org/?hash=%1#blockchain_transaction".arg(hash)
    }

    property Action leftAction: null
    property Action rightAction: Action {
        icon.name: "external-link-alt"

        onTriggered: Qt.openUrlExternally(view.blockExplorerLink)
    }

    topPadding: 0
    rightPadding: 8
    bottomPadding: 0
    leftPadding: 8
    maximumContentWidth: 960
    title: qsTr("Transaction Details")

    header: null

    sourceComponent: Component {
        ColumnLayout {
            RowLayout {
                width: parent.width

                RoundButton {
                    display: RoundButton.IconOnly
                    flat: true
                    action: view.leftAction
                }

                Label {
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    font.bold: true
                    text: view.title

                    Layout.fillWidth: true
                }

                RoundButton {
                    display: RoundButton.IconOnly
                    flat: true
                    action: view.rightAction
                }
            }

            GroupBox {
                title: "%1:".arg(qsTr("Transaction"))

                Layout.fillWidth: true

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
                            value: "01609e9828294b792898f3734f1a1b81fb705e95b844fdbfceb2bd80c57a7d9"
                        }

                        ListElement {
                            key: qsTr("Public key")
                            value: "609e9828294b792898f3734f1a1b81fb705e95b844fdbfceb2bd80c57a79462"
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

            // extra spacing between groups
            Item {
                height: 8

                Layout.fillWidth: true
            }

            GroupBox {
                title: "%1:".arg(qsTr("In Block"))

                Layout.fillWidth: true

                Column {
                    readonly property ListModel model: ListModel {
                        dynamicRoles: false

                        ListElement {
                            key: qsTr("Hash")
                            value: "36420af6b108a493afaf4061b661b10e9eb02d4db42c35536cf008d472915d0"
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
                topPadding: 8
                horizontalAlignment: Label.AlignHCenter
                wrapMode: Label.WordWrap
                text: qsTr("For more information please visit online blockchain explorer")
                opacity: 0.8

                Layout.fillWidth: true
            }

            Label {
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                font.bold: true
                text: {
                    var site = "explorer.qwertycoin.org"
                    return "<a href='%1'>%2</a>".arg(view.blockExplorerLink).arg(site)
                }

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                onLinkActivated: Qt.openUrlExternally(link)
            }

            // extra spacing at the bottom
            Item {
                height: 2

                Layout.fillWidth: true
            }
        }
    }

    footer: null
}

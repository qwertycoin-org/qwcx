import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view
    rightPadding: 8
    leftPadding: 8
    maximumContentWidth: 960

    header: null

    sourceComponent: Component {
        Column {
            spacing: 8

            // small spacing at the top
            Item {
                width: parent.width
                height: 2
            }

            Card {
                bottomPadding: 2
                width: parent.width
                contentItem: Column {
                    width: parent.width
                    spacing: 4

                    Label {
                        width: parent.width
                        text: qsTr("Total balance")
                    }

                    Label {
                        width: parent.width
                        font: view.Fluid.font(Fluid.Number1)
                        text: "0.00 QWC" // "4,137.92 QWC"
                    }

                    Label {
                        width: parent.width
                        font: view.Fluid.font(Fluid.Number2)
                        text: "$0.00" // "$12,132.49"
                        opacity: 0.8
                    }

                    MenuSeparator {
                        topPadding: 10
                        bottomPadding: 0
                        width: parent.width
                    }

                    Item {
                        width: parent.width
                        height: 48

                        Label {
                            anchors.centerIn: parent
                            text: qsTr("Empty accounts list.")
                            opacity: 0.5
                        }
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0
                        width: parent.width
                    }

                    RoundButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        topInset: 0
                        rightInset: 0
                        bottomInset: 2
                        leftInset: 0
                        width: parent.width
                        radius: 0
                        flat: true
                        font {
                            bold: true
                            capitalization: Font.AllUppercase
                        }
                        text: "+ " + qsTr("Add account")
                    }
                }
            }

            Row {
                width: parent.width
                spacing: 8

                Button {
                    width: Math.floor((parent.width - parent.spacing) / 2)
                    text: qsTr("Send to...")
                }

                Button {
                    width: Math.floor((parent.width - parent.spacing) / 2)
                    text: qsTr("Receive")
                }
            }

            Card {
                bottomPadding: 2
                width: parent.width
                contentItem: Column {
                    width: parent.width
                    spacing: 4

                    Label {
                        width: parent.width
                        text: qsTr("Transactions")
                    }

                    MenuSeparator {
                        topPadding: 8
                        bottomPadding: 0
                        width: parent.width
                    }

                    Item {
                        width: parent.width
                        height: 48

                        Label {
                            anchors.centerIn: parent
                            text: qsTr("Empty transactions list.")
                            opacity: 0.5
                        }
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0
                        width: parent.width
                    }

                    RoundButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        topInset: 0
                        rightInset: 0
                        bottomInset: 2
                        leftInset: 0
                        width: parent.width
                        radius: 0
                        flat: true
                        font {
                            bold: true
                            capitalization: Font.AllUppercase
                        }
                        text: qsTr("See all")
                    }
                }
            }

            Card {
                bottomPadding: 2
                width: parent.width
                contentItem: Column {
                    width: parent.width
                    spacing: 4

                    Label {
                        width: parent.width
                        text: qsTr("Ecosystem")
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0
                        width: parent.width
                    }

                    Repeater {
                        model: ListModel {
                            dynamicRoles: false

                            ListElement {
                                title: qsTr("Explorer")
                                link: "https://explorer.qwertycoin.org/"
                            }

                            ListElement {
                                title: qsTr("CoinMarketCap")
                                link: "https://coinmarketcap.com/currencies/qwertycoin/"
                            }

                            ListElement {
                                title: qsTr("CoinStats")
                                link: "https://coinstats.app/en/coins/qwertycoin"
                            }
                        }
                        delegate: ItemDelegate {
                            rightPadding: 2
                            leftPadding: 2
                            width: parent ? parent.width : 0
                            text: {
                                var template = "<b>%1</b> <i>(%2)</i>"
                                return template.arg(model.title).arg(model.link)
                            }

                            onClicked: Qt.openUrlExternally(model.link)
                        }
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0
                        width: parent.width
                    }

                    RoundButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        topInset: 0
                        rightInset: 0
                        bottomInset: 2
                        leftInset: 0
                        width: parent.width
                        radius: 0
                        flat: true
                        font {
                            bold: true
                            capitalization: Font.AllUppercase
                        }
                        text: qsTr("See all")
                    }
                }
            }

            Card {
                bottomPadding: 2
                width: parent.width
                contentItem: Column {
                    width: parent.width
                    spacing: 4

                    Label {
                        width: parent.width
                        text: qsTr("Community")
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0
                        width: parent.width
                    }

                    Repeater {
                        model: ListModel {
                            dynamicRoles: false

                            ListElement {
                                title: qsTr("Facebook")
                                link: "https://facebook.com/Qwertycoin-422694361519282"
                            }

                            ListElement {
                                title: qsTr("Medium")
                                link: "https://medium.com/@xecuteqwc"
                            }

                            ListElement {
                                title: qsTr("Twitter")
                                link: "https://twitter.com/qwertycoin_qwc"
                            }
                        }
                        delegate: ItemDelegate {
                            rightPadding: 2
                            leftPadding: 2
                            width: parent ? parent.width : 0
                            text: {
                                var template = "<b>%1</b> <i>(%2)</i>"
                                return template.arg(model.title).arg(model.link)
                            }

                            onClicked: Qt.openUrlExternally(model.link)
                        }
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0
                        width: parent.width
                    }

                    RoundButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        topInset: 0
                        rightInset: 0
                        bottomInset: 2
                        leftInset: 0
                        width: parent.width
                        radius: 0
                        flat: true
                        font {
                            bold: true
                            capitalization: Font.AllUppercase
                        }
                        text: qsTr("See all")
                    }
                }
            }

            Caption {
                anchors.horizontalCenter: parent.horizontalCenter
                text: Qt.application.displayName + " v" + Qt.application.version
                opacity: 0.25
            }

            // small spacing at the bottom
            Item {
                width: parent.width
                height: 2
            }
        }
    }

    footer: null
}

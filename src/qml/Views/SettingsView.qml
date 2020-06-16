import QtQuick 2.15
import QtQuick.Controls 2.15
import QWCX.Controls 1.0

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
                width: parent.width
                contentItem: Column {
                    width: parent.width
                    spacing: 4

                    Label {
                        width: parent.width
                        text: qsTr("Public nodes")
                    }

                    ComboBox {
                        width: parent.width
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

                    CheckBox {
                        leftPadding: 2
                        text: qsTr("Automatically connect to nearest public node")
                    }
                }
            }

            Card {
                width: parent.width
                contentItem: Column {
                    width: parent.width
                    spacing: 4

                    Label {
                        width: parent.width
                        text: qsTr("Software updates")
                    }

                    Row {
                        width: parent.width
                        spacing: 8

                        Button {
                            anchors.verticalCenter: parent.verticalCenter
                            width: Math.floor((parent.width - parent.spacing) / 2)
                            text: qsTr("Check for updates")
                        }

                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "%1: <i>%2</i>".arg(qsTr("Last checked")).arg("20.02.2020")
                            opacity: 0.5
                        }
                    }

                    CheckBox {
                        leftPadding: 2
                        text: qsTr("Automatically check for updates")
                    }
                }
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

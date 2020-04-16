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
                        text: "4,137.92 QWC"
                    }

                    Label {
                        width: parent.width
                        font: view.Fluid.font(Fluid.Number2)
                        text: "$12,132.49"
                        opacity: 0.8
                    }

                    MenuSeparator {
                        topPadding: 10
                        bottomPadding: 0
                        width: parent.width
                    }

                    QwcWalletListView {
                        width: parent.width
                        height: this.count > 0 ? this.contentHeight : 48
                        model: ListModel {
                            dynamicRoles: false

                            ListElement {
                                address: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvqh52sVnNc1p"
                                amount: 132.77
                                color: "#ff9800"
                                name: "Orange Wallet"
                            }

                            ListElement {
                                address: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvqh52sVnNc1p"
                                amount: 12.01
                                color: "#4caf50"
                                name: "Green Wallet"
                            }

                            ListElement {
                                address: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvqh52sVnNc1p"
                                amount: 242.33
                                color: "#2196f3"
                                name: "Blue Wallet"
                            }
                        }
                        delegate: QwcWalletDelegate {
                            readonly property int modelIndex: index
                            readonly property var modelItem: model || null

                            width: parent ? parent.width : 0
                            horizontalPadding: 2
                            address: modelItem.address || ""
                            amount: modelItem.amount || 0.0
                            color: modelItem.color || "grey"
                            name: modelItem.name || qsTr("Unnamed")
                        }
                        interactive: false

                        Label {
                            anchors.centerIn: parent
                            text: qsTr("Empty accounts list.")
                            opacity: 0.5
                            visible: parent.count < 1
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
                    display: Button.TextBesideIcon
                    icon.name: "telegram-plane"
                    text: qsTr("Send to...")

                    onClicked: fundsTransferDrawer.open()
                }

                Button {
                    width: Math.floor((parent.width - parent.spacing) / 2)
                    display: Button.TextBesideIcon
                    icon.name: "qrcode"
                    text: qsTr("Receive")

                    onClicked: fundsRequestDrawer.open()
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

                    QwcTransactionListView {
                        width: parent.width
                        height: this.count > 0 ? this.contentHeight : 48
                        model: ListModel {
                            dynamicRoles: false

                            ListElement {
                                amount: -1234.0
                                confirmations: 0
                                timestamp: 1574009014547
                                hash: "9117db7aZ5b463bdf051xZ"
                            }

                            ListElement {
                                amount: 56.0
                                confirmations: 5
                                timestamp: 1574008152638
                                hash: "FzT2X921942CAL6zJM9XyS"
                            }

                            ListElement {
                                amount: 243.0
                                confirmations: 5
                                timestamp: 1574008121753
                                hash: ""
                            }
                        }
                        delegate: QwcTransactionDelegate {
                            readonly property int modelIndex: index
                            readonly property var modelItem: model || null

                            width: parent ? parent.width : 0
                            horizontalPadding: 2
                            amount: modelItem.amount || 0.0
                            confirmations: modelItem.confirmations || 0
                            timestamp: new Date(modelItem.timestamp || null)
                            hash: modelItem.hash || ""
                        }
                        interactive: false

                        Label {
                            anchors.centerIn: parent
                            text: qsTr("Empty transactions list.")
                            opacity: 0.5
                            visible: parent.count < 1
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

                        onClicked: transactionHistoryDrawer.open()
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
                                var template = "<b>%1</b> - <i>%2</i>"
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

                        onClicked: ecosystemDrawer.open()
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
                                var template = "<b>%1</b> - <i>%2</i>"
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

                        onClicked: communityDrawer.open()
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

    Drawer {
        id: fundsRequestDrawer
        width: view.ApplicationWindow.window.width
        height: view.ApplicationWindow.window.height
        edge: Qt.RightEdge
        interactive: true

        FundsRequestView {
            anchors.fill: parent
            leftAction: Action {
                icon.name: "arrow-left"

                onTriggered: fundsRequestDrawer.close()
            }
        }
    }

    Drawer {
        id: fundsTransferDrawer
        width: view.ApplicationWindow.window.width
        height: view.ApplicationWindow.window.height
        edge: Qt.RightEdge
        interactive: true

        FundsTransferView {
            anchors.fill: parent
            leftAction: Action {
                icon.name: "arrow-left"

                onTriggered: fundsTransferDrawer.close()
            }
        }
    }

    Drawer {
        id: transactionHistoryDrawer
        width: view.ApplicationWindow.window.width
        height: view.ApplicationWindow.window.height
        edge: Qt.RightEdge
        interactive: true

        TransactionHistoryView {
            anchors.fill: parent
            leftAction: Action {
                icon.name: "arrow-left"

                onTriggered: transactionHistoryDrawer.close()
            }
        }
    }

    Drawer {
        id: ecosystemDrawer
        width: view.ApplicationWindow.window.width
        height: view.ApplicationWindow.window.height
        edge: Qt.RightEdge
        interactive: true

        EcosystemView {
            anchors.fill: parent
            leftAction: Action {
                icon.name: "arrow-left"

                onTriggered: ecosystemDrawer.close()
            }
        }
    }

    Drawer {
        id: communityDrawer
        width: view.ApplicationWindow.window.width
        height: view.ApplicationWindow.window.height
        edge: Qt.RightEdge
        interactive: true

        CommunityView {
            anchors.fill: parent
            leftAction: Action {
                icon.name: "arrow-left"

                onTriggered: communityDrawer.close()
            }
        }
    }
}

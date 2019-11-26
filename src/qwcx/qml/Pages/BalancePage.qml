import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0

Page {
    id: balancePage

    function findStackView(item) {
        var view = null

        while (item.parent) {
            item = item.parent
            if (item instanceof StackView) {
                view = item
                break
            }
        }

        return view
    }

    function push(item, properties, operation) {
        var stack = findStackView(this)
        if (!stack)
            return

        stack.push(item, properties, operation)
    }

    title: ""
    spacing: 0

    header: null

    contentItem: ScrollView {
        anchors {
            fill: parent
            topMargin: balancePage.header ? balancePage.header.height + balancePage.spacing : 0
            bottomMargin: balancePage.footer ? balancePage.footer.height + balancePage.spacing : 0
        }
        padding: 8
        spacing: 0
        wheelEnabled: true

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        Column {
            width: {
                var container = balancePage.contentItem
                return container.width - container.leftPadding - container.rightPadding
            }
            spacing: 8

            Column {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                spacing: 4

                Heading {
                    text: qsTr("Total balance")
                }

                Label {
                    font {
                        bold: true
                        pixelSize: 28
                    }
                    text: qsTr("1803,63 QWC")
                }

                Label {
                    font {
                        bold: true
                        pixelSize: 14
                    }
                    opacity: 0.5
                    text: qsTr("12,05 USD / 0,001 BTC")
                }
            }

            Row {
                property list<Action> model: [
                    Action {
                        icon.name: "center_focus_strong"
                        text: qsTr("Scan\nQR-code")

                        onTriggered: {
                            var item = qrCodeScannerComponent
                            var properties = { title: qsTr("Scan QR-code") }
                            var operation = StackView.PushTransition

                            balancePage.push(item, properties, operation)
                        }
                    },
                    Action {
                        icon.name: "arrow_upward"
                        text: qsTr("Transfer\nmoney")

                        onTriggered: {
                            var item = fundsTransferPageComponent
                            var properties = { title: qsTr("Transfer money") }
                            var operation = StackView.PushTransition

                            balancePage.push(item, properties, operation)
                        }
                    },
                    Action {
                        icon.name: "arrow_downward"
                        text: qsTr("Receive\n")

                        onTriggered: {
                            var item = fundsRequestPageComponent
                            var properties = { title: qsTr("Receive") }
                            var operation = StackView.PushTransition

                            balancePage.push(item, properties, operation)
                        }
                    },
                    Action {
                        icon.name: "more_horiz"
                        text: qsTr("Other\n")
                    }
                ]

                anchors {
                    right: parent.right
                    left: parent.left
                }
                spacing: 0

                Repeater {
                    model: parent.model
                    delegate: Item {
                        readonly property int modelIndex: index
                        readonly property Action modelItem: modelData || null

                        width: parent.width / parent.model.length
                        height: 96

                        Button {
                            anchors {
                                fill: parent
                                leftMargin: Math.max(Math.floor((parent.width - 96) / 2), 0)
                                rightMargin: Math.max(Math.floor((parent.width - 96) / 2), 0)
                            }
                            font {
                                bold: true
                                capitalization: Font.MixedCase
                                pixelSize: 12
                            }
                            padding: 0
                            topInset: 0
                            bottomInset: 0
                            flat: true
                            display: RoundButton.TextUnderIcon
                            action: parent.modelItem || null
                            text: parent.modelItem.text || ""
                        }

                        Rectangle {
                            anchors {
                                top: parent.top
                                right: parent.right
                                bottom: parent.bottom
                            }
                            width: 1
                            color: "black"
                            opacity: 0.1
                            visible: parent.modelIndex !== (parent.parent.model.length - 1)
                        }
                    }
                }
            }

            Frame {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                spacing: 0

                Column {
                    anchors {
                        right: parent.right
                        left: parent.left
                    }
                    spacing: 4

                    Heading {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        horizontalAlignment: Heading.AlignLeft
                        elide: Heading.ElideRight
                        text: qsTr("Recent transactions")
                    }

                    QwcTransactionListView {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        height: contentHeight
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

                            onClicked: {
                                var item = transactionDetailsComponent
                                var properties = {
                                    title: qsTr("Transaction Details"),
                                    amount: modelItem.amount
                                }
                                var operation = StackView.PushTransition

                                balancePage.push(item, properties, operation)
                            }
                        }
                        interactive: false
                    }

                    OutlinedButton {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        verticalPadding: 0
                        topInset: 0
                        bottomInset: 0
                        text: qsTr("Show all transactions...")

                        onClicked: {
                            var item = transactionHistoryComponent
                            var properties = {}
                            var operation = StackView.PushTransition

                            balancePage.push(item, properties, operation)
                        }
                    }
                }
            }

            Heading {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 8
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                text: qsTr("Explore Network")
            }

            CarouselView {
                width: parent.width
                model: ListModel {
                    dynamicRoles: false

                    ListElement {
                        iconName: "category"
                        title: "Block Explorer"
                        description: "QWC Block Explorer"
                        url: "https://explorer.qwertycoin.org"
                    }

                    ListElement {
                        iconName: "category"
                        title: "Network"
                        description: "QWC Network"
                        url: "https://explorer.qwertycoin.org/#network"
                    }

                    ListElement {
                        iconName: "category"
                        title: "Available Nodes"
                        description: "QWC Masternodes"
                        url: "https://nodes.qwertycoin.org"
                    }
                }
                delegate: CarouselDelegate {
                    readonly property int modelIndex: index
                    readonly property var modelItem: model || null

                    anchors {
                        top: parent ? parent.top : undefined
                        bottom: parent ? parent.bottom : undefined
                    }
                    spacing: 8
                    icon.name: modelItem.iconName || ""
                    text: "<b>%1</b><br/>%2".arg(modelItem.title || "").arg(modelItem.description || "")

                    onClicked: {
                        if (!modelItem.url)
                            return

                        Qt.openUrlExternally(modelItem.url)
                    }
                }
                interactive: false
            }

            Heading {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 8
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                text: qsTr("Exchanges")
            }

            CarouselView {
                width: parent.width
                model: ListModel {
                    dynamicRoles: false

                    ListElement {
                        iconName: "category"
                        iconColor: "#ff8f00"
                        title: "QBTC"
                        description: "Digital assets trading"
                        url: "https://www.qbtc.com"
                    }

                    ListElement {
                        iconName: "category"
                        iconColor: "#ff8f00"
                        title: "GJ"
                        description: "Digital assets trading"
                        url: "https://www.gj.com"
                    }

                    ListElement {
                        iconName: "category"
                        iconColor: "#ff8f00"
                        title: "CITEX"
                        description: "Centralized trading"
                        url: "https://www.citex.co.kr"
                    }

                    ListElement {
                        iconName: "category"
                        iconColor: "#ff8f00"
                        title: "Crex24"
                        description: "Profitable trading"
                        url: "https://crex24.com"
                    }
                }
                delegate: CarouselDelegate {
                    readonly property int modelIndex: index
                    readonly property var modelItem: model || null

                    anchors {
                        top: parent ? parent.top : undefined
                        bottom: parent ? parent.bottom : undefined
                    }
                    spacing: 8
                    icon {
                        color: modelItem.iconColor || color
                        name: modelItem.iconName || ""
                    }
                    text: "<b>%1</b><br/>%2".arg(modelItem.title || "").arg(modelItem.description || "")

                    onClicked: {
                        if (!modelItem.url)
                            return

                        Qt.openUrlExternally(modelItem.url)
                    }
                }
                interactive: false
            }

            Heading {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 8
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                text: qsTr("Markets")
            }

            CarouselView {
                width: parent.width
                model: ListModel {
                    dynamicRoles: false

                    ListElement {
                        iconName: "category"
                        iconColor: "#1565c0"
                        title: "CoinGecko"
                        description: "Market Capitalization"
                        url: "https://www.coingecko.com/en/coins/qwertycoin"
                    }

                    ListElement {
                        iconName: "category"
                        iconColor: "#1565c0"
                        title: "Feixiaohao"
                        description: "Chinese Market Cap."
                        url: "https://www.feixiaohao.com/currencies/qwertycoin"
                    }

                    ListElement {
                        iconName: "category"
                        iconColor: "#1565c0"
                        title: "CoinMarketCap"
                        description: "Market Capitalization"
                        url: "https://coinmarketcap.com/currencies/qwertycoin"
                    }

                    ListElement {
                        iconName: "category"
                        iconColor: "#1565c0"
                        title: "Coin Stats"
                        description: "Crypto Portfolio"
                        url: "https://coinstats.app/en/coins/qwertycoin"
                    }
                }
                delegate: CarouselDelegate {
                    readonly property int modelIndex: index
                    readonly property var modelItem: model || null

                    anchors {
                        top: parent ? parent.top : undefined
                        bottom: parent ? parent.bottom : undefined
                    }
                    spacing: 8
                    icon {
                        color: modelItem.iconColor || color
                        name: modelItem.iconName || ""
                    }
                    text: "<b>%1</b><br/>%2".arg(modelItem.title || "").arg(modelItem.description || "")

                    onClicked: {
                        if (!modelItem.url)
                            return

                        Qt.openUrlExternally(modelItem.url)
                    }
                }
                interactive: false
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
                text: qsTr("For more information about all QWC services\nplease visit our website.")
                opacity: 0.8
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    bold: true
                    pixelSize: 12
                }
                text: "<a href='https://www.qwertycoin.org'>Qwertycoin.org</a>"

                onLinkActivated: Qt.openUrlExternally(link)
            }

            Item { // extra spacing
                width: parent.width
                height: 2
            }
        }
    }

    footer: null

    Component {
        id: fundsRequestPageComponent

        FundsRequestPage { }
    }

    Component {
        id: fundsTransferPageComponent

        FundsTransferPage { }
    }

    Component {
        id: qrCodeScannerComponent

        QrCodeScannerPage { }
    }

    Component {
        id: transactionDetailsComponent

        TransactionDetailsPage { }
    }

    Component {
        id: transactionHistoryComponent

        TransactionHistoryPage { }
    }
}

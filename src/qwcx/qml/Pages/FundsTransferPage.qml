import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0

Page {
    id: fundsTransferPage
    title: ""
    spacing: 0

    property string address: ""
    property double amount: 0.0
    property double fee: 0.0
    property string paymentId: ""

    function saveAsTemplate() {
        // TODO: implement this.
    }

    function cleanupAllFields() {
        fundsTransferPage.address = ""
        fundsTransferPage.amount = 0.0
        fundsTransferPage.fee = 0.0
        fundsTransferPage.paymentId = ""
    }

    header: ToolBar {
        ToolButton {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "chevron_left"
            visible: fundsTransferPage.StackView.index > 0

            onClicked: {
                var stack = fundsTransferPage.StackView.view
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
            text: fundsTransferPage.title
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
                dim: false
                modal: true

                MenuItem {
                    text: qsTr("Save as template...")

                    onTriggered: fundsTransferPage.saveAsTemplate()
                }

                MenuItem {
                    text: qsTr("Cleanup all fields")

                    onTriggered: fundsTransferPage.cleanupAllFields()
                }

                Component.onCompleted: parent.clicked.connect(this.open)
            }
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
            spacing: 8

            Column {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                spacing: 4

                Heading {
                    text: qsTr("Available balance")
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

            Frame {
                anchors {
                    right: parent.right
                    left: parent.left
                }

                contentItem: Column {
                    anchors {
                        right: parent.right
                        rightMargin: parent.rightPadding
                        left: parent.left
                        leftMargin: parent.leftPadding
                    }
                    spacing: 2

                    Label {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        horizontalAlignment: Label.AlignLeft
                        text: "%1:".arg(qsTr("Destination address"))
                    }

                    TextField {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        topPadding: 0
                        placeholderText: "QWC1dbyFtjBF3wer4ae..."
                        text: fundsTransferPage.address

                        onTextChanged: {
                            fundsTransferPage.address = text
                            this.text = Qt.binding(() => fundsTransferPage.address)
                        }
                    }

                    Label {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        topPadding: 4
                        horizontalAlignment: Label.AlignLeft
                        text: qsTr("Amount to send") + ":"
                    }

                    TextField {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        topPadding: 0
                        validator: DoubleValidator {
                            bottom: 0.0
                            top: Number.MAX_SAFE_INTEGER
                            decimals: 64
                            notation: DoubleValidator.StandardNotation
                        }
                        placeholderText: "0.00"
                        text: fundsTransferPage.amount || ""

                        onTextChanged: {
                            fundsTransferPage.amount = Number(text)
                            this.text = Qt.binding(() => fundsTransferPage.amount || "")
                        }
                    }

                    Label {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        topPadding: 4
                        horizontalAlignment: Label.AlignLeft
                        text: qsTr("Payment ID (optional)") + ":"
                    }

                    TextField {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        topPadding: 0
                        placeholderText: qsTr("Empty")
                        text: fundsTransferPage.paymentId

                        onTextChanged: {
                            fundsTransferPage.paymentId = text
                            this.text = Qt.binding(() => fundsTransferPage.paymentId)
                        }
                    }

                    Item { // extra spacing
                        width: parent.width
                        height: 8
                    }

                    OutlinedButton {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        topInset: 0
                        bottomInset: 0
                        text: qsTr("Send Transaction")

                        onClicked: transactionConfirmationDialog.open()
                    }
                }
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignTop
                font.pixelSize: 11
                opacity: 0.5
                text: _m.transactionWarningText
                wrapMode: Label.WordWrap
            }
        }
    }

    Drawer {
        id: transactionConfirmationDialog
        width: fundsTransferPage.width
        edge: Qt.BottomEdge
        topPadding: 8
        rightPadding: 8
        bottomPadding: 8
        leftPadding: 8

        contentItem: Column {
            anchors {
                fill: parent
                topMargin: transactionConfirmationDialog.topPadding
                rightMargin: transactionConfirmationDialog.rightPadding
                bottomMargin: transactionConfirmationDialog.bottomPadding
                leftMargin: transactionConfirmationDialog.leftPadding
            }
            spacing: 0

            Heading {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                text: qsTr("Confirmation sending QWC")
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 4
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                opacity: 0.5
                text: qsTr("Amount")
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                font {
                    bold: true
                    pixelSize: 21
                }
                text: _m.formatAmount(fundsTransferPage.amount)
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 4
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                opacity: 0.5
                text: qsTr("Fee")
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                font.bold: true
                text: _m.formatFee(fundsTransferPage.fee)
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 6
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                opacity: 0.5
                text: qsTr("QWC Address")
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                font.bold: true
                text: _m.formatAddress(fundsTransferPage.address)
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 6
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                opacity: 0.5
                text: qsTr("Payment ID")
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                horizontalAlignment: Heading.AlignLeft
                elide: Heading.ElideRight
                font.bold: true
                text: _m.formatPaymentId(fundsTransferPage.paymentId)
            }

            Label {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topPadding: 6
                bottomPadding: 12
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignTop
                font.pixelSize: 11
                opacity: 0.5
                text: _m.transactionWarningText
                wrapMode: Label.WordWrap
            }

            OutlinedButton {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                topInset: 0
                bottomInset: 0
                text: qsTr("Confirm Transaction")

                onClicked: {
                    transactionConfirmationDialog.close()

                    var stack = fundsTransferPage.StackView.view
                    if (!stack && stack.depth > 0)
                        return

                    stack.pop()
                }
            }
        }
    }

    footer: null

    QtObject {
        id: _m

        readonly property string transactionWarningText: {
            var part1 = qsTr("WARNING")
            var part2 = qsTr("After transaction is sent it can not be undone!")
            var part3 = qsTr("Please, be careful and")
            var part4 = qsTr("check information twice")

            return "<b>%1!</b> %2 %3 <b>%4</b>.".arg(part1).arg(part2).arg(part3).arg(part4)
        }

        function formatAddress(input) {
            return input || "-"
        }

        function formatAmount(input) {
            if (input === 0.0)
                return "0.00"

            return input
        }

        function formatFee(input) {
            return _m.formatAmount(input)
        }

        function formatPaymentId(input) {
            return input || "-"
        }
    }
}

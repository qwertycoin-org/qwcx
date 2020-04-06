import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view

    property ListModel model: ListModel {
        ListElement {
            name: "Main Wallet"
            address: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUG1K6XEhCC1WsZzT9RRVpc1MLXXdHV1Kpc1MLXXdHV"
        }

        ListElement {
            name: "Secondary Wallet"
            address: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvqh52sVnNc1pYmoF2TEC1WsKt2BUGSrs"
        }

        ListElement {
            name: "Work Wallet"
            address: "QWC1K6XEhCsZzT9RRVpc1MLXXdHVKt2BUGSrsmkksZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvUGSz"
        }
    }

    property Action leftAction: null
    property Action rightAction: Action {
        icon.name: "camera"
    }

    topPadding: 0
    rightPadding: 8
    bottomPadding: 0
    leftPadding: 8
    maximumContentWidth: 960

    header: null

    sourceComponent: Component {
        ColumnLayout {
            height: view.height - view.topPadding - view.bottomPadding

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
                    text: qsTr("Transfer Funds")

                    Layout.fillWidth: true
                }

                RoundButton {
                    display: RoundButton.IconOnly
                    flat: true
                    action: view.rightAction
                }
            }

            Label {
                text: qsTr("From wallet:")
            }

            ComboBox {
                id: comboBox
                model: view.model
                textRole: "name"
                valueRole: "address"
                displayText: "%1 - %2".arg(currentText).arg(currentValue)

                Layout.fillWidth: true
            }

            // small spacing between inputs
            Item {
                width: parent.width
                height: 8
            }

            Label {
                text: qsTr("Amount:")

                Layout.fillWidth: true
            }

            TextField {
                validator: DoubleValidator {
                    bottom: 0.0
                    top: Number.MAX_SAFE_INTEGER
                    decimals: 64
                    notation: DoubleValidator.StandardNotation
                }
                placeholderText: "0.00"

                Layout.fillWidth: true
            }

            // small spacing between inputs
            Item {
                width: parent.width
                height: 8
            }

            Label {
                text: qsTr("Recipient:")

                Layout.fillWidth: true
            }

            TextField {
                placeholderText: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUG1K6XEhCC1WsZzT9RRVpc1MLXXdHV"

                Layout.fillWidth: true
            }

            // small spacing between inputs
            Item {
                width: parent.width
                height: 8
            }

            Label {
                horizontalAlignment: Label.AlignLeft
                text: qsTr("Payment ID (optional)") + ":"

                Layout.fillWidth: true
            }

            TextField {
                placeholderText: qsTr("Payment ID text...")

                Layout.fillWidth: true
            }

            // small spacing between inputs
            Item {
                width: parent.width
                height: 8
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Button {
                text: qsTr("Send Transaction")

                Layout.fillWidth: true
            }

            Label {
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.WordWrap
                font: view.Fluid.font(Fluid.Body2)
                text: {
                    var part1 = qsTr("WARNING")
                    var part2 = qsTr("After transaction is sent it can not be undone!")
                    var part3 = qsTr("Please, be careful and")
                    var part4 = qsTr("check information twice")

                    return "<b>%1!</b> %2 %3 <b>%4</b>.".arg(part1).arg(part2).arg(part3).arg(part4)
                }
                opacity: 0.5

                Layout.fillWidth: true
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

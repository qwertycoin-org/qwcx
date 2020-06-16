import QtQuick 2.15
import QtQuick.Controls 2.15
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
        icon.name: "question-circle"
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
                    text: qsTr("Request Funds")

                    Layout.fillWidth: true
                }

                RoundButton {
                    display: RoundButton.IconOnly
                    flat: true
                    action: view.rightAction
                }
            }

            ComboBox {
                id: comboBox
                model: view.model
                textRole: "name"
                valueRole: "address"
                displayText: "%1 - %2".arg(currentText).arg(currentValue)

                Layout.fillWidth: true
            }

            Item {
                Layout.topMargin: 16
                Layout.bottomMargin: 16
                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle {
                    anchors.centerIn: parent
                    width: {
                        var w = Math.min(parent.width, parent.height)
                        return Math.min(w, 480)
                    }
                    height: width
                    color: "white"

                    Label {
                        anchors {
                            right: parent.right
                            bottom: parent.top
                            bottomMargin: 4
                            left: parent.left
                        }
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        text: "<b>%1</b> %2".arg(comboBox.currentText).arg(qsTr("address"))
                        opacity: 0.5

                        Layout.fillWidth: true
                    }

                    QrCodeItem {
                        anchors.fill: parent
                        text: comboBox.currentValue
                    }

                    Label {
                        anchors {
                            top: parent.bottom
                            topMargin: 4
                            right: parent.right
                            left: parent.left
                        }
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        elide: Label.ElideMiddle
                        text: comboBox.currentValue
                        opacity: 0.5

                        Layout.fillWidth: true
                    }
                }
            }

            Button {
                text: qsTr("Share address")

                Layout.fillWidth: true
            }

            Label {
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.WordWrap
                text: qsTr("Show QR code or share address with sender")

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

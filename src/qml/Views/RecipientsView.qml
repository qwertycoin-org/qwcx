import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view

    property ListModel model: ListModel {
        ListElement {
            name: "John Smith"
            address: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvqh52sVnNc1pYmoF2TEC1WsKt2BUGSrs"
        }

        ListElement {
            name: "Jane Doe"
            address: "QWC1K6XEhCC1WsZzT9RRVpc1MLXXdHVKt2BUGSrsmkkXAvqh52sVnNc1pYmoF2TEC1WsKt2BUGSrs"
        }
    }

    rightPadding: 8
    leftPadding: 8
    maximumContentWidth: 960

    header: null

    sourceComponent: Component {
        ListView {
            height: view.height
            model: view.model

            header: Rectangle {
                z: 2
                width: parent.width
                height: this.childrenRect.height
                color: view.Fluid.background

                GridLayout {
                    anchors.top: parent.top
                    width: parent.width
                    columns: 2
                    rows: 2
                    columnSpacing: 0
                    rowSpacing: 0

                    Label {
                        leftPadding: 8
                        font.bold: true
                        text: "%1 (%2)".arg(qsTr("Recipients")).arg(view.model.count)

                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                        Layout.fillWidth: true
                    }

                    RoundButton {
                        font {
                            bold: true
                            capitalization: Font.AllUppercase
                        }
                        display: Button.IconOnly
                        flat: true
                        icon.name: "person_add"
                        text: ""

                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0

                        Layout.columnSpan: 2
                        Layout.rowSpan: 1
                        Layout.fillWidth: true
                    }
                }
            }
            headerPositioning: ListView.OverlayHeader

            delegate: ItemDelegate {
                rightPadding: 8
                leftPadding: 8
                width: parent ? parent.width : 0
                text: "<b>%1</b> - <i>%2</i>".arg(model.name).arg(model.address)
            }

            footer: null

            Column {
                anchors.centerIn: parent
                spacing: 4
                visible: !view.model || (view.model.count < 1)

                RoundButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    topInset: 0
                    rightInset: 0
                    bottomInset: 0
                    leftInset: 0
                    padding: 0
                    topPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    leftPadding: 0
                    display: RoundButton.IconOnly
                    icon {
                        width: 96
                        height: 96
                        name: "people"
                    }
                    flat: true
                    enabled: false
                }

                Label {
                    horizontalAlignment: Label.AlignHCenter
                    width: parent.width
                    text: qsTr("Recipients list is empty.")
                    opacity: 0.5
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font {
                        bold: true
                        capitalization: Font.AllUppercase
                    }
                    display: Button.TextBesideIcon
                    icon.name: "person_add"
                    text: qsTr("Add recipient")
                }
            }
        }
    }

    footer: null
}

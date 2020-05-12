import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view

    property var model: []

    property Action leftAction: null
    property Action rightAction: Action {
        icon.name: "question-circle"
    }

    rightPadding: 8
    leftPadding: 8
    maximumContentWidth: 960
    title: qsTr("Ecosystem Links")

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
                    columns: 3
                    rows: 2
                    columnSpacing: 0
                    rowSpacing: 0

                    RoundButton {
                        display: Button.IconOnly
                        flat: true
                        text: ""
                        action: view.leftAction

                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                    }

                    Label {
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        leftPadding: 8
                        font.bold: true
                        text: "%1 (%2)".arg(view.title).arg(view.model.length)

                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                        Layout.fillWidth: true
                    }

                    RoundButton {
                        display: Button.IconOnly
                        flat: true
                        text: ""
                        action: view.rightAction

                        Layout.columnSpan: 1
                        Layout.rowSpan: 1
                    }

                    MenuSeparator {
                        topPadding: 0
                        bottomPadding: 0

                        Layout.columnSpan: 3
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
                text: "<b>%1</b> - <i>%2</i>".arg(modelData.title).arg(modelData.link)
            }

            footer: null
        }
    }

    footer: null
}

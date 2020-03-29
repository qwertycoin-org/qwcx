import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Shapes 1.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view
    topPadding: 0
    rightPadding: 8
    bottomPadding: 0
    leftPadding: 8
    maximumContentWidth: 960

    header: null

    sourceComponent: Component {
        GridLayout {
            height: view.height - view.topPadding - view.bottomPadding
            columns: 2
            rows: 3
            columnSpacing: 0
            rowSpacing: 0

            Label {
                leftPadding: 8
                font.bold: true
                text: qsTr("Invoice scanner")

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
                icon.name: "photo_camera"

                Layout.columnSpan: 1
                Layout.rowSpan: 1

                onClicked: camera.open()
            }

            MenuSeparator {
                topPadding: 0
                bottomPadding: 0

                Layout.columnSpan: 2
                Layout.rowSpan: 1
                Layout.fillWidth: true
            }

            Card {
                topInset: 8
                bottomInset: 8
                topPadding: 8
                rightPadding: 0
                bottomPadding: 8
                leftPadding: 0
                radius: 0

                Layout.columnSpan: 2
                Layout.rowSpan: 1
                Layout.fillWidth: true
                Layout.fillHeight: true

                contentItem: Shape {
                    id: dashLineShape
                    width: parent.width - parent.leftPadding - parent.rightPadding
                    height: parent.height - parent.topPadding - parent.bottomPadding
                    asynchronous: true

                    ShapePath {
                        dashPattern: [8, 4]
                        fillColor: "transparent"
                        strokeColor: view.Fluid.theme === Fluid.Dark ? "#55FFFFFF" : "#55000000"
                        strokeStyle: ShapePath.DashLine
                        strokeWidth: 1
                        capStyle: ShapePath.RoundCap

                        startX: 1; startY: 1
                        PathLine { x: dashLineShape.width - 1; y: 1 }
                        PathLine { x: dashLineShape.width - 1; y: dashLineShape.height - 1 }
                        PathLine { x: 1; y: dashLineShape.height - 1 }
                        PathLine { x: 1; y: 4 }
                    }

                    Column {
                        anchors.centerIn: parent

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
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Label.AlignHCenter
                            text: qsTr("Drag and drop a <br/> Qwertycoin invoice <b>QR-code</b>.")
                            opacity: 0.5
                        }

                        Item {
                            width: 1
                            height: 8
                        }

                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Label.AlignHCenter
                            text: qsTr("or")
                            opacity: 0.5
                        }

                        Item {
                            width: 1
                            height: 8
                        }

                        Button {
                            anchors.horizontalCenter: parent.horizontalCenter
                            font {
                                bold: true
                                capitalization: Font.AllUppercase
                            }
                            display: Button.TextBesideIcon
                            icon.name: "insert_photo"
                            text: qsTr("Load QR-code from file...")
                        }
                    }
                }
            } // Card
        }
    }

    footer: null

    Drawer {
        id: camera
        width: view.ApplicationWindow.window.width
        height: view.ApplicationWindow.window.height
        edge: Qt.BottomEdge
        interactive: true

        ScannerCameraView {
            anchors.fill: parent

            onRejected: camera.close()
        }
    }
}

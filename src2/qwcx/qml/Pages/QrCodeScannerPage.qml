import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QWCX.Controls 1.0

Page {
    id: qrCodeScannerPage

    readonly property alias text: qrCodeScanner.text

    readonly property rect cropArea: {
        var awidth = 256
        var aheight = 256
        var ax = (this.width - awidth) / 2
        var ay = (this.height - aheight) / 2

        return Qt.rect(ax, ay, awidth, aheight)
    }
    property rect contentCropArea: {
        if (vout.contentRect.width < 1 || vout.contentRect.height < 1)
            return Qt.rect(-1, -1, -1, -1)

        if (vout.sourceRect.width < 1 || vout.sourceRect.height < 1)
            return Qt.rect(-1, -1, -1, -1)

        var camera = vout.source
        if (!(camera instanceof Camera) || camera.cameraState !== Camera.ActiveState)
            return Qt.rect(-1, -1, -1, -1)

        var rectf = vout.mapRectToSource(qrCodeScannerPage.cropArea)

        return Qt.rect(rectf.x, rectf.y, rectf.width, rectf.height)
    }

    title: ""
    spacing: 0

    background: Rectangle {
        color: "black"

        VideoOutput {
            id: vout
            anchors.fill: parent
            autoOrientation: true
            fillMode: VideoOutput.PreserveAspectCrop
            filters: []
            source: Camera {
                cameraState: Camera.UnloadedState
                captureMode: Camera.CaptureStillImage
                viewfinder {
                    minimumFrameRate: 24
                    maximumFrameRate: 60
                }
            }
        }

        Timer {
            interval: 1000
            repeat: false
            running: false
            triggeredOnStart: false

            onTriggered: {
                var camera = vout.source

                if (!(camera instanceof Camera))
                    return

                switch (camera.cameraState) {
                case Camera.UnloadedState:
                    camera.cameraState = Camera.LoadedState
                    this.restart()
                    break
                case Camera.LoadedState:
                    camera.cameraState = Camera.ActiveState
                    camera.unlock()
                    this.restart()
                    break
                case Camera.ActiveState:
                    // fall through
                default:
                    // do nothing
                    break
                }
            }

            Component.onCompleted: this.start()
        }
    }

    header: ToolBar {
        ToolButton {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "chevron_left"
            visible: qrCodeScannerPage.StackView.index > 0

            onClicked: {
                var stack = qrCodeScannerPage.StackView.view
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
            text: qrCodeScannerPage.title
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

                MenuItem { text: qsTr("Choose image...") }
                MenuItem { text: qsTr("Switch camera") }

                Component.onCompleted: parent.clicked.connect(this.open)
            }
        }
    }

    contentItem: Item {
        anchors.fill: parent

        Rectangle {
            x: qrCodeScannerPage.cropArea.x
            y: qrCodeScannerPage.cropArea.y
            width: qrCodeScannerPage.cropArea.width
            height: qrCodeScannerPage.cropArea.height
            border {
                width: 1
                color: "white"
            }
            color: "transparent"
            visible: {
                var camera = vout.source
                return (camera.cameraState === Camera.ActiveState)
            }

            Rectangle {
                x: 0
                y: 50
                width: parent.width
                height: 2
                color: parent.border.color
                opacity: 0.5

                SequentialAnimation on y {
                    running: true
                    loops: SequentialAnimation.Infinite

                    NumberAnimation { from: 1; to: 255; duration: 1500; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 255; to: 1; duration: 1500; easing.type: Easing.InOutQuad }
                }
            }
        }
    }

    footer: Frame {
        readonly property string contextualHint: {
            var t = ""

            var camera = vout.source
            switch (camera.cameraState) {
            case Camera.UnloadedState:
                t = qsTr("Loading camera...")
                break
            case Camera.LoadedState:
                t = qsTr("Activating camera...")
                break
            case Camera.ActiveState:
                t = qsTr("Align the QR-code within\nthe frame to scan")
                break
            default:
                t = ""
                break
            }

            return t
        }

        topInset: 8
        rightInset: 8
        bottomInset: 8
        leftInset: 8
        verticalPadding: 18
        opacity: 0.85
        visible: contextualHint.length > 0

        Label {
            anchors.fill: parent
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            font.pixelSize: 14
            text: qrCodeScannerPage.footer.contextualHint
        }
    }

    QrCodeScanner {
        id: qrCodeScanner
        cropArea: qrCodeScannerPage.contentCropArea
        running: true
        source: vout.source
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QWCX.Controls 1.0

Pane {
    id: view

    readonly property rect cropArea: {
        var awidth = 256
        var aheight = 256
        var ax = (this.width - awidth) / 2
        var ay = (this.height - aheight) / 2

        return Qt.rect(ax, ay, awidth, aheight)
    }
    readonly property rect contentCropArea: {
        if (vout.contentRect.width < 1 || vout.contentRect.height < 1)
            return Qt.rect(-1, -1, -1, -1)

        if (vout.sourceRect.width < 1 || vout.sourceRect.height < 1)
            return Qt.rect(-1, -1, -1, -1)

//        var camera = vout.source
//        if (!(camera instanceof Camera) || camera.cameraState !== Camera.ActiveState)
//            return Qt.rect(-1, -1, -1, -1)

        var rectf = vout.mapRectToSource(view.cropArea)

        return Qt.rect(rectf.x, rectf.y, rectf.width, rectf.height)
    }

    function start() {
        scanner.start()
    }

    function stop() {
        scanner.stop()
    }

    signal accepted(string text)
    signal rejected()

    background: Rectangle {
        anchors {
            fill: parent
            topMargin: view.topInset
            rightMargin: view.rightInset
            bottomMargin: view.bottomInset
            leftMargin: view.leftInset
        }
        color: "black"
    }

    contentItem: Item {
        anchors.fill: parent

        VideoOutput {
            id: vout
            anchors.fill: parent
            autoOrientation: true
            source: QrCodeScanner {
                id: scanner
                cropArea: view.contentCropArea

                onDecodedTextChanged: {
                    if (scanner.decodedText.length < 1)
                        return

                    view.accepted(scanner.decodedText)
                }
            }
            fillMode: VideoOutput.PreserveAspectCrop
            filters: []
            //visible: scanner.cameraStatus === Camera.ActiveStatus
        }

        RoundButton {
            anchors {
                top: parent.top
                topMargin: 8
                right: parent.right
                rightMargin: 8
            }
            display: RoundButton.IconOnly
            flat: true
            icon.name: "times"

            onClicked: view.rejected()
        }

        Rectangle {
            x: view.cropArea.x
            y: view.cropArea.y
            width: view.cropArea.width
            height: view.cropArea.height
            border {
                width: 1
                color: "white"
            }
            color: "transparent"
            visible: true

            Rectangle {
                x: 0
                y: Math.floor(parent.height / 2)
                width: parent.width
                height: 2
                color: parent.border.color
                opacity: 0.5

                SequentialAnimation on y {
                    running: true
                    loops: SequentialAnimation.Infinite

                    NumberAnimation { to: 255; duration: 1500; easing.type: Easing.InOutQuad }
                    NumberAnimation { to: 1; duration: 1500; easing.type: Easing.InOutQuad }
                }
            }
        }

        Label {
            readonly property string contextualHint: {
                var cameraStatus = Camera.UnavailableStatus
                if (scanner.camera) {
                    cameraStatus = scanner.cameraStatus
                }

                var hint = ""
                switch (cameraStatus) {
                case Camera.ActiveStatus:
                    hint = qsTr("Place QR-code inside the frame.")
                    break
                case Camera.StartingStatus:
                    hint = qsTr("Starting camera...")
                    break
                case Camera.StoppingStatus:
                    hint = qsTr("Stopping camera...")
                    break
                case Camera.StandbyStatus:
                    hint = ""
                    break
                case Camera.LoadedStatus:
                    hint = ""
                    break
                case Camera.LoadingStatus:
                    hint = qsTr("Loading camera...")
                    break
                case Camera.UnloadingStatus:
                    hint = qsTr("Unloading camera...")
                    break
                case Camera.UnloadedStatus:
                    hint = qsTr("Camera is unloaded.")
                    break
                case Camera.UnavailableStatus:
                    hint = qsTr("Camera is unavailable!")
                    break
                default:
                    hint = ""
                    break
                }
                return hint
            }
            readonly property string errorHint: ""

            anchors {
                bottom: parent.bottom
                bottomMargin: 16
            }
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            width: parent.width
            text: this.errorHint.length > 0 ? this.errorHint : this.contextualHint
            opacity: 0.8
        }
    }
}

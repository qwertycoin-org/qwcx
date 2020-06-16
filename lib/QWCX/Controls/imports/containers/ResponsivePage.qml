import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: control

    property real minimumContentWidth: 0
    property real maximumContentWidth: Number.POSITIVE_INFINITY

    property string icon: ""

    property bool active: true
    property url source: ""
    property Component sourceComponent: null
    property int status: Loader.Null

    signal loaded

    header: null

    contentItem: Item {
        anchors {
            fill: parent
            topMargin: control.topPadding
            rightMargin: control.rightPadding
            bottomMargin: control.bottomPadding
            leftMargin: control.leftPadding
        }
        clip: true

        Flickable {
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            width: Math.min(control.contentItem.width, control.maximumContentWidth)
            contentWidth: loader.active && loader.item ? loader.item.width : 0
            contentHeight: loader.active && loader.item ? loader.item.height : 0
            flickableDirection: Flickable.AutoFlickIfNeeded

            Loader {
                id: loader
                width: {
                    var w = control.contentItem.width
                    w = Math.max(w, control.minimumContentWidth)
                    w = Math.min(w, control.maximumContentWidth)
                    return w
                }
                active: control.active
                asynchronous: false
                source: control.source
                sourceComponent: control.sourceComponent

                onLoaded: control.loaded()

                onStatusChanged: control.status = this.status

                Component.onCompleted: control.status = this.status
            }
        }
    }

    footer: null
}

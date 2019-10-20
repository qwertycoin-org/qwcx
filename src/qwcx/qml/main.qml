import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: root
    width: 320
    height: 568
    minimumWidth: 320
    minimumHeight: 480
    title: Qt.application.displayName
    visible: true

    Material.theme: Material.Light
    Material.accent: "#FF8754"

    ListModel {
        id: pages
        dynamicRoles: false

        ListElement {
            iconName: "add"
            source: ""
            title: qsTr("Balance")
        }

        ListElement {
            iconName: "add"
            source: ""
            title: qsTr("Categories")
        }

        ListElement {
            iconName: "add"
            source: ""
            title: qsTr("Chat")
        }

        ListElement {
            iconName: "add"
            source: ""
            title: qsTr("More")
        }
    }

    Loader {
        id: loader
        anchors.fill: parent
        active: true
        asynchronous: false
        focus: true
        visible: loader.status === Loader.Ready

        Component.onCompleted: {
            // TODO: Select between desktop, mobile and web view.
            var src = "qrc:/qml/main_mobile.qml"
            var properties = { "model": pages }
            loader.setSource(src, properties)
        }
    }
}

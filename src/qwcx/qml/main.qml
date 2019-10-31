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
    Material.accent: Material.color(Material.Amber, Material.Shade800)
    Material.primary: Material.background

    ListModel {
        id: pages
        dynamicRoles: false

        ListElement {
            iconName: "account_balance"
            source: "qrc:/qml/Pages/BalancePage.qml"
            title: qsTr("Balance")
        }

        ListElement {
            iconName: "category"
            source: "qrc:/qml/Pages/CategoriesPage.qml"
            title: qsTr("Categories")
        }

        ListElement {
            iconName: "people"
            source: "qrc:/qml/Pages/RecipientsPage.qml"
            title: qsTr("Recipients")
        }

        ListElement {
            iconName: "build"
            source: "qrc:/qml/Pages/SettingsPage.qml"
            title: qsTr("Settings")
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

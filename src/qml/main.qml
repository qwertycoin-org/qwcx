import QtQuick 2.12
import QtQuick.Controls 2.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0
import  "./Views" as Views

ApplicationWindow {
    width: 480
    height: 640
    minimumWidth: 320
    minimumHeight: 480
    font: Fluid.font(Fluid.Body1)
    title: Qt.application.displayName
    visible: true

    Fluid.theme: Fluid.System
    Fluid.secondary: "#FFF9AA33"
    Fluid.surface: Fluid.theme === Fluid.Light ? "#FFEEEEEE" : "#FF404040"

    header: null

    TabView {
        anchors.fill: parent

        Views.BalanceView {
            title: qsTr("Balance")
            icon: "account_balance"
        }

        Views.RecipientsView {
            title: qsTr("Recipients")
            icon: "people"
        }

        Views.ScannerView {
            title: qsTr("Scanner")
            icon: "photo_camera"
        }

        Views.SettingsView {
            title: qsTr("Settings")
            icon: "build"
        }
    }

    footer: null
}

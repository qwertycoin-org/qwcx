import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "./Pages" as Pages

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

    StackView {
        id: stackView
        anchors.fill: parent
    }

    Component {
        id: mainView

        Pages.MainPage {
            onActionChosen: {
                if (action === "logout")
                    stackView.replace(stackView.get(0, StackView.DontLoad), welcomeView, {}, StackView.PopTransition)
            }
        }
    }

    Component {
        id: walletCreationView

        Pages.WalletCreationPage {
            onActionChosen: {
                switch (action) {
                case "cancel":
                    stackView.replace(this, welcomeView, {}, StackView.PopTransition)
                    break
                case "done":
                    stackView.replace(this, mainView, {}, StackView.PushTransition)
                    break
                default:
                    // unknown action, do nothing
                    break
                }
            }
        }
    }

    Component {
        id: walletRestorationView

        Pages.WalletRestorationPage {
            onActionChosen: {
                switch (action) {
                case "cancel":
                    stackView.replace(this, welcomeView, {}, StackView.PopTransition)
                    break
                case "done":
                    stackView.replace(this, mainView, {}, StackView.PushTransition)
                    break
                default:
                    // unknown action, do nothing
                    break
                }
            }
        }
    }

    Component {
        id: welcomeView

        Pages.WelcomePage {
            onActionChosen: {
                switch (action) {
                case "create":
                    stackView.replace(this, walletCreationView, {}, StackView.PushTransition)
                    break
                case "restore":
                    stackView.replace(this, walletRestorationView, {}, StackView.PushTransition)
                    break
                default:
                    // unknown action, do nothing
                    break
                }
            }
        }
    }

    Component.onCompleted: {
        var authorized = false
        var initialView = authorized ? mainView : welcomeView
        stackView.push(initialView)
    }
}

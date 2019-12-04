import QtQuick 2.12
import QtQuick.Controls 2.12
import "./Pages" as Pages

StackView {
    id: mobileView

    property ListModel model: undefined

    initialItem: undefined

    Component {
        id: mainView

        Page {
            header: null

            contentItem: SwipeView {
                id: swipeView
                anchors {
                    top: parent.top
                    right: parent.right
                    bottom: toolBar.top
                    left: parent.left
                }
                currentIndex: tabBar.currentIndex
                interactive: false
                orientation: Qt.Vertical // WARNING: Qt.Horizontal is glitching when resizing window

                // hack-ish fix that disables SwipeView animation for transitions between items
                Binding {
                    target: swipeView.contentItem
                    property: "highlightMoveDuration"
                    value: 0
                    when: (swipeView.contentItem instanceof ListView)
                }

                Repeater {
                    model: mobileView.model ? mobileView.model.count : 0
                    delegate: Loader {
                        readonly property int modelIndex: index
                        readonly property QtObject modelItem: mobileView.model.get(index) || null
                        readonly property bool isCurrentItem: SwipeView.isCurrentItem

                        function activate() {
                            var src = modelItem.source
                            var properties = { "title": modelItem.title }
                            setSource(src, properties)
                            active = true
                        }

                        active: false
                        asynchronous: false
                        focus: visible
                        visible: isCurrentItem && loader.status === Loader.Ready

                        onIsCurrentItemChanged: { if (isCurrentItem && !active) { activate() } }
                    }
                }
            } // SwipeView (contentItem)

            footer: ToolBar {
                id: toolBar
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                    left: parent.left
                }
                position: ToolBar.Footer
                spacing: 0

                TabBar {
                    id: tabBar
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    position: TabBar.Footer

                    Repeater {
                        model: mobileView.model ? mobileView.model.count : 0
                        delegate: TabButton {
                            readonly property int modelIndex: index
                            readonly property QtObject modelItem: mobileView.model.get(index)
                            readonly property bool isCurrentItem: SwipeView.isCurrentItem

                            width: 80
                            padding: 8
                            display: TabButton.TextUnderIcon
                            spacing: 1
                            font {
                                capitalization: Font.MixedCase
                                pixelSize: 12
                            }
                            icon.name: modelItem ? modelItem.iconName : ""
                            text: modelItem ? modelItem.title : ""
                        }
                    }
                }
            } // ToolBar (footer)
        }
    }

    Component {
        id: walletCreationView

        Pages.WalletCreationPage {
            onActionChosen: {
                switch (action) {
                case "cancel":
                    mobileView.replace(this, welcomeView, {}, StackView.PopTransition)
                    break
                case "done":
                    mobileView.replace(this, mainView, {}, StackView.PushTransition)
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
                    mobileView.replace(this, welcomeView, {}, StackView.PopTransition)
                    break
                case "done":
                    mobileView.replace(this, mainView, {}, StackView.PushTransition)
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
                    mobileView.replace(this, walletCreationView, {}, StackView.PushTransition)
                    break
                case "restore":
                    mobileView.replace(this, walletRestorationView, {}, StackView.PushTransition)
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
        mobileView.push(initialView)
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: mainPage

    signal actionChosen(string action)

    title: ""
    spacing: 0

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
            model: pages.count || 0
            delegate: Loader {
                readonly property int modelIndex: index
                readonly property QtObject modelItem: pages.get(index) || null
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
                visible: isCurrentItem && this.status === Loader.Ready

                onIsCurrentItemChanged: { if (isCurrentItem && !active) { activate() } }

                Connections {
                    target: item || null
                    ignoreUnknownSignals: true
                    enabled: {
                        if (!item)
                            return false

                        if (!(item instanceof Page))
                            return false

                        if (!item.actionChosen)
                            return false

                        if (typeof item.actionChosen !== "function")
                            return false

                        return true
                    }

                    onActionChosen: mainPage.actionChosen(action)
                }
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
                model: pages.count || 0
                delegate: TabButton {
                    readonly property int modelIndex: index
                    readonly property QtObject modelItem: pages.get(index)
                    readonly property bool isCurrentItem: SwipeView.isCurrentItem

                    width: tabBar.count ? Math.floor(toolBar.width / tabBar.count) - 1 : 0
                    padding: 8
                    display: TabButton.TextUnderIcon
                    spacing: 0
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

    ListModel {
        id: pages
         dynamicRoles: false

         ListElement {
             iconName: "account_balance"
             source: "qrc:/qml/Pages/BalancePage.qml"
             title: qsTr("Balance")
         }

         ListElement {
             iconName: "list_alt"
             source: "qrc:/qml/Pages/TransactionHistoryPage.qml"
             title: qsTr("History")
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
}

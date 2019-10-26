import QtQuick 2.12
import QtQuick.Controls 2.12

Control {
    id: mobileView

    property ListModel model: undefined
    readonly property alias currentIndex: tabBar.currentIndex
    readonly property alias currentItem: swipeView.currentItem

    SwipeView {
        id: swipeView
        anchors {
            top: parent.top
            right: parent.right
            bottom: tabBar.top
            left: parent.left
        }
        currentIndex: mobileView.currentIndex
        interactive: false
        orientation: Qt.Vertical // WARNING: Qt.Horizontal has issues when quickly resizing window
        clip: true

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
                visible: modelIndex === swipeView.currentIndex && loader.status === Loader.Ready

                onIsCurrentItemChanged: { if (isCurrentItem && !active) { activate() } }
            }
        }
    }

    Rectangle {
        id: tabBarShadow
        anchors {
            right: parent.right
            bottom: tabBar.top
            left: parent.left
        }
        height: 3
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: "black" }
        }
        opacity: 0.2
    }

    TabBar {
        id: tabBar
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        position: TabBar.Footer

        Repeater {
            model: mobileView.model ? mobileView.model.count : 0
            delegate: TabButton {
                readonly property int modelIndex: index
                readonly property QtObject modelItem: mobileView.model.get(index) || null
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
    } // TabBar
}

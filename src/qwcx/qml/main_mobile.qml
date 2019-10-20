import QtQuick 2.12
import QtQuick.Controls 2.12

Control {
    id: mobileView

    property ListModel model: undefined

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
                readonly property QtObject modelItem: mobileView.model.get(index) || null

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

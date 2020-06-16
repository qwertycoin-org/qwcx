import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QWCX.Controls.Fluid 1.0

Page {
    id: control

    default property alias model: tabStack.children

    property int currentIndex: 0
    readonly property ResponsivePage currentItem: control.model[control.currentIndex] || null

    padding: 0
    topPadding: 0
    rightPadding: 0
    bottomPadding: 0
    leftPadding: 0

    header: Loader {
        id: tabBarInHeader
        active: (Qt.platform.os !== "android" && Qt.platform.os !== "ios")
        asynchronous: false
        sourceComponent: tabBarComponent

        Binding {
            target: tabBarInHeader.item
            property: "position"
            value: TabBar.Header
            delayed: false
            when: tabBarInHeader.active
        }
    }

    StackLayout {
        id: tabStack
        anchors.fill: parent
        currentIndex: control.currentIndex
    }

    footer: Loader {
        id: tabBarInFooter
        active: !tabBarInHeader.active
        asynchronous: false
        sourceComponent: tabBarComponent

        Binding {
            target: tabBarInFooter.item
            property: "position"
            value: TabBar.Footer
            delayed: false
            when: tabBarInFooter.active
        }
    }

    MenuSeparator {
        parent: {
            if (tabBarInHeader.active)
                return tabBarInHeader.item

            if (tabBarInFooter)
                return tabBarInFooter.item

            return null
        }
        anchors {
            top: tabBarInFooter.active ? parent.top : undefined
            bottom: tabBarInHeader.active ? parent.bottom : undefined
        }
        padding: 0
        topPadding: 0
        rightPadding: 0
        bottomPadding: 0
        leftPadding: 0
        width: parent ? parent.width : 0
    }

    Component {
        id: tabBarComponent

        TabBar {
            id: tabBar
            leftPadding: Math.max(Math.floor((tabBar.width - tabBar.contentWidth) / 2), 0)

            Fluid.elevation: 4

            Repeater {
                model: control.model ? control.model.length : 0
                delegate: TabButton {
                    readonly property int modelIndex: index
                    readonly property ResponsivePage modelItem: control.model[index]

                    rightPadding: 4
                    leftPadding: 4
                    width: Math.min(Math.floor(tabBar.width / tabBar.count) - 1, 128)
                    display: {
                        if (width >= 128) {
                            return TabButton.TextBesideIcon
                        } else {
                            var header = (tabBar.position === TabBar.Header)
                            return header ? TabButton.TextOnly : TabButton.TextUnderIcon
                        }
                    }
                    spacing: 4
                    font: Fluid.font(Fluid.Body1)
                    icon.name: modelItem ? (modelItem["icon"] || "") : ""
                    text: modelItem ? (modelItem["title"] || "") : ""

                    onClicked: control.currentIndex = modelIndex
                }
            }
        } // TabBar
    }
}

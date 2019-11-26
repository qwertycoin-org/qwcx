import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: transactionHistoryPage

    title: ""
    spacing: 0

    header: ToolBar {
        ToolButton {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "chevron_left"
            visible: transactionHistoryPage.StackView.index > 0

            onClicked: {
                var stack = transactionHistoryPage.StackView.view
                if (!stack && stack.depth > 0)
                    return

                stack.pop()
            }
        }

        Label {
            anchors.centerIn: parent
            width: parent.width - 96
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            elide: Label.ElideMiddle
            text: {
                if (transactionHistoryPage.title.length > 0)
                    return transactionHistoryPage.title

                return Qt.formatDate(new Date(), "MMM dd yyyy")
            }
        }

        ToolButton {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            display: ToolButton.IconOnly
            icon.name: "calendar_today"
        }
    }

    contentItem: Pane {
        anchors {
            fill: parent
            topMargin: parent.header ? parent.header.height : 0
            bottomMargin: parent.footer ? parent.footer.height : 0
        }
    }

    footer: null
}

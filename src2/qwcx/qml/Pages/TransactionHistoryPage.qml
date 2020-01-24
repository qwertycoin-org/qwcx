import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.calendar 1.0
import QWCX.Controls 1.0

Page {
    id: transactionHistoryPage

    property date date: new Date()

    function findStackView(item) {
        var view = null

        while (item.parent) {
            item = item.parent
            if (item instanceof StackView) {
                view = item
                break
            }
        }

        return view
    }

    function push(item, properties, operation) {
        var stack = findStackView(this)
        if (!stack)
            return

        stack.push(item, properties, operation)
    }

    implicitWidth: 0
    implicitHeight: 0
    title: ""
    spacing: 0

    header: ToolBar {
        height: implicitBackgroundHeight * 2

        Item {
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.verticalCenter
                left: parent.left
            }

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

                    return Qt.formatDate(transactionHistoryPage.date, "MMMM dd, yyyy")
                }
            }

            ToolButton {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                display: ToolButton.IconOnly
                icon.name: "calendar_today"

                onClicked: datePickerDialog.open()
            }
        }

        ListView {
            anchors {
                top: parent.verticalCenter
                right: parent.right
                bottom: parent.bottom
                left: parent.left
            }
            orientation: Qt.Horizontal
            interactive: false
            model: {
                var startDate = new Date(transactionHistoryPage.date)
                var endDate = new Date(transactionHistoryPage.date)

                var offset = 7 // days
                startDate.setDate(startDate.getDate() - offset)
                endDate.setDate(endDate.getDate() + offset)

                return _m.getDateArray(startDate, endDate)
            }
            delegate: ItemDelegate {
                readonly property date modelItem: modelData || null

                width: ListView.view.width / 7
                height: ListView.view.height
                topPadding: 0
                rightPadding: 0
                bottomPadding: 0
                leftPadding: 0
                topInset: 0
                rightInset: 0
                bottomInset: 0
                leftInset: 0
                display: ItemDelegate.TextUnderIcon // sets text alignment to Qt.AlignCenter
                text: index

                contentItem: Column {
                    anchors.fill: parent

                    Label {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        height: parent.height / 2
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        text: Qt.formatDate(modelItem, "ddd")
                    }

                    Label {
                        anchors {
                            right: parent.right
                            left: parent.left
                        }
                        height: parent.height / 2
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        font.bold: true
                        text: Qt.formatDate(modelItem, "dd")
                    }
                }

                onClicked: transactionHistoryPage.date = new Date(modelItem)
            }
            highlight: Item {
                Rectangle {
                    anchors {
                        right: parent.right
                        bottom: parent.bottom
                        left: parent.left
                    }
                    height: 4
                    color: "#ff8f00"
                }
            }
            highlightMoveDuration: 0
            highlightMoveVelocity: -1
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: currentItem ? Math.floor(width - currentItem.width) / 2 : 0
            preferredHighlightEnd: currentItem ? Math.floor(width + currentItem.width) / 2 : width
            currentIndex: _m.findDateInArray(this.model, transactionHistoryPage.date)
        }
    }

    contentItem: Pane {
        anchors {
            fill: parent
            topMargin: parent.header ? parent.header.height : 0
            bottomMargin: parent.footer ? parent.footer.height : 0
        }
        horizontalPadding: 0
        verticalPadding: 0

        contentItem: QwcTransactionListView {
            anchors.fill: parent
            model: 10
            delegate: QwcTransactionDelegate {
                width: parent ? parent.width : 0
                amount: index + 12
                confirmations: index
                hash: "JustARandomHashString"
                timestamp: transactionHistoryPage.date

                onClicked: {
                    var item = transactionDetailsComponent
                    var properties = {
                        title: qsTr("Transaction Details"),
                        amount: index + 12
                    }
                    var operation = StackView.PushTransition

                    transactionHistoryPage.push(item, properties, operation)
                }
            }
            interactive: true
        }
    }

    footer: null

    Popup {
        id: datePickerDialog

        property date date: {
            var d = new Date(transactionHistoryPage.date)
            var offset = datePickerDialog.monthOffset

            return new Date(d.setMonth(d.getMonth() + offset))
        }
        property int monthOffset: 0

        anchors.centerIn: parent
        width: 256
        height: 256
        horizontalPadding: 0
        verticalPadding: 0
        modal: true

        Column {
            anchors {
                fill: parent
                bottomMargin: 8
            }
            spacing: 0

            Item {
                anchors {
                    right: parent.right
                    left: parent.left
                }
                height: 48

                RoundButton {
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                    display: RoundButton.IconOnly
                    flat: true
                    icon.name: "chevron_left"

                    onClicked: datePickerDialog.monthOffset -= 1
                }

                Label {
                    anchors.centerIn: parent
                    width: parent.width - 96
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    elide: Label.ElideMiddle
                    text: Qt.formatDate(datePickerDialog.date, "MMMM yyyy")

                    MouseArea {
                        anchors.centerIn: parent
                        width: parent.paintedWidth
                        height: parent.paintedHeight

                        onDoubleClicked: datePickerDialog.monthOffset = 0
                    }
                }

                RoundButton {
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                    display: RoundButton.IconOnly
                    flat: true
                    icon.name: "chevron_right"

                    onClicked: datePickerDialog.monthOffset += 1
                }
            }

            DayOfWeekRow {
                anchors {
                    right: parent.right
                    rightMargin: 8
                    left: parent.left
                    leftMargin: 8
                }
                locale: Qt.locale("en_US")
            }

            MonthGrid {
                anchors {
                    right: parent.right
                    rightMargin: 8
                    left: parent.left
                    leftMargin: 8
                }
                height: parent.height - y // fill remaining vertical space
                month: datePickerDialog.date.getMonth()
                year: datePickerDialog.date.getFullYear()
                delegate: ItemDelegate {
                    readonly property MonthGrid grid: {
                        var monthGrid = parent.parent
                        return (monthGrid instanceof MonthGrid) ? monthGrid : null
                    }

                    readonly property bool isCurrentItem: {
                        var date1 = model.date
                        var date2 = transactionHistoryPage.date

                        var yearMatch = (date1.getFullYear() === date2.getFullYear())
                        var monthMatch = (date1.getMonth() === date2.getMonth())
                        var dateMatch = (date1.getDate() === date2.getDate())

                        return (yearMatch && monthMatch && dateMatch)
                    }

                    topPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    leftPadding: 0
                    topInset: 0
                    rightInset: 0
                    bottomInset: 0
                    leftInset: 0
                    display: ItemDelegate.TextUnderIcon // sets text alignment to Qt.AlignCenter
                    text: model.day
                    enabled: (model.month === grid.month)

                    Rectangle {
                        anchors.fill: parent
                        border {
                            width: 1
                            color: "#ff8f00"
                        }
                        color: "transparent"
                        visible: parent.isCurrentItem
                    }

                    onClicked: {
                        datePickerDialog.close()
                        transactionHistoryPage.date = new Date(model.date)
                    }
                }
                locale: Qt.locale("en_US")
            }
        }

        onClosed: datePickerDialog.monthOffset = 0
    }

    Component {
        id: transactionDetailsComponent

        TransactionDetailsPage { }
    }

    QtObject {
        id: _m

        function findDateInArray(array, date) {
            if (!array || !(array instanceof Array))
                return -1

            if (array.length < 1)
                return -1

            var index = array.findIndex(function(element) {
                var yearMatch = (element.getFullYear() === date.getFullYear())
                var monthMatch = (element.getMonth() === date.getMonth())
                var dateMatch = (element.getDate() === date.getDate())

                return (yearMatch && monthMatch && dateMatch)
            })

            return Math.max(index, 0)
        }

        function getDateArray(start, end) {
            var arr = []

            var dt = new Date(start)

            while (dt <= end) {
                arr.push(new Date(dt))
                dt.setDate(dt.getDate() + 1)
            }

            return arr;
        }
    }
}

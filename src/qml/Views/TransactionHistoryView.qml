import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.calendar 1.0
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view

    property date date: new Date()

    property Action leftAction: null
    property Action rightAction: Action {
        icon.name: "calendar-day"

        onTriggered: datePickerDialog.open()
    }

    topPadding: 0
    rightPadding: 8
    bottomPadding: 0
    leftPadding: 8
    maximumContentWidth: 960
    title: Qt.formatDate(view.date, "MMMM, yyyy")

    header: null

    sourceComponent: Component {
        ColumnLayout {
            height: view.height - view.topPadding - view.bottomPadding

            RowLayout {
                width: parent.width

                RoundButton {
                    display: RoundButton.IconOnly
                    flat: true
                    action: view.leftAction
                }

                Label {
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    font.bold: true
                    text: view.title

                    Layout.fillWidth: true
                }

                RoundButton {
                    display: RoundButton.IconOnly
                    flat: true
                    action: view.rightAction
                }
            }

            TabBar {
                id: dayOfWeekRow

                readonly property var model: {
                    var daysOfWeek = [
                        Locale.Sunday,
                        Locale.Monday,
                        Locale.Tuesday,
                        Locale.Wednesday,
                        Locale.Thursday,
                        Locale.Friday,
                        Locale.Saturday
                    ]

                    var firstDays = daysOfWeek.slice(view.locale.firstDayOfWeek, 7)
                    var lastDays = daysOfWeek.slice(0, view.locale.firstDayOfWeek)

                    return firstDays.concat(lastDays)
                }

                position: TabBar.Header
                currentIndex: model.indexOf(view.date.getDay())

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true

                Repeater {
                    model: dayOfWeekRow.model
                    delegate: TabButton {
                        readonly property string shortName: view.locale.dayName(modelData, Locale.ShortFormat)
                        readonly property string longName: view.locale.dayName(modelData, Locale.LongFormat)
                        readonly property date value: {
                            var firstDayOfWeek = view.date.getDate() - view.date.getDay()
                            if (view.date.getDay() < view.locale.firstDayOfWeek)
                                firstDayOfWeek -= 7
                            firstDayOfWeek += view.locale.firstDayOfWeek

                            var offset = TabBar.index

                            return new Date(new Date(view.date).setDate(firstDayOfWeek + offset))
                        }

                        text: {
                            var name = this.shortName
                            if (TabBar.tabBar && TabBar.tabBar.width > 560)
                                name = this.longName

                            var date = this.value.getDate()
                            if (date < 10)
                                date = "0%1".arg(date)

                            return "%1%2%3".arg(name).arg("\n").arg(date)
                        }

                        onClicked: view.date = this.value
                    }
                }
            }

            MenuSeparator {
                topPadding: 0
                bottomPadding: 0

                Layout.topMargin: - (parent.spacing + 4)
                Layout.fillWidth: true
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Label {
                    anchors.centerIn: parent
                    text: qsTr("Empty transactions list.")
                    opacity: 0.5
                    visible: parent.count < 1
                }
            }
        }
    }

    footer: null

    Popup {
        id: datePickerDialog

        property date date: {
            var d = new Date(view.date)
            var offset = datePickerDialog.monthOffset
            return new Date(d.setMonth(d.getMonth() + offset))
        }
        property int monthOffset: 0

        anchors.centerIn: parent
        width: Math.min(Math.min(view.contentItem.width, view.contentItem.height), 480)
        height: datePickerDialog.width
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
                    icon.name: "angle-left"

                    onClicked: datePickerDialog.monthOffset -= 1
                }

                Label {
                    anchors.centerIn: parent
                    width: parent.width - 96
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    font.bold: true
                    elide: Label.ElideMiddle
                    text: Qt.formatDate(datePickerDialog.date, "MMMM, yyyy")

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
                    icon.name: "angle-right"

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
                delegate: Label {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    text: model.shortName
                }
                locale: view.locale
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
                        var date2 = view.date

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
                    highlighted: isCurrentItem
                    enabled: (model.month === grid.month)

                    Rectangle {
                        anchors.fill: parent
                        border {
                            width: 1
                            color: view.Fluid.secondary
                        }
                        color: "transparent"
                        visible: parent.isCurrentItem
                    }

                    onClicked: {
                        datePickerDialog.close()
                        view.date = new Date(model.date)
                    }
                }
                locale: view.locale
            }
        }

        onClosed: datePickerDialog.monthOffset = 0
    }
}

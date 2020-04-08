import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QWCX.Controls 1.0
import QWCX.Controls.Fluid 1.0

ResponsivePage {
    id: view

    property date date: new Date()

    property Action leftAction: null
    property Action rightAction: Action {
        icon.name: "calendar-day"
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

                    onClicked: view.date = new Date()
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
}

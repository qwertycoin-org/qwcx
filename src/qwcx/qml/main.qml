import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    width: 640
    height: 480
    title: Qt.application.displayName
    visible: true

    Button {
        anchors.centerIn: parent
        icon.name: "add"
        text: qsTr("Add")
    }
}

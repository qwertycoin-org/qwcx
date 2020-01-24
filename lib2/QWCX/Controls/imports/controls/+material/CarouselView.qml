import QtQuick 2.12

ListView {
    id: control
    implicitWidth: 320
    implicitHeight: 96
    orientation: Qt.Horizontal
    boundsBehavior: ListView.StopAtBounds
    boundsMovement: ListView.StopAtBounds
    flickableDirection: ListView.HorizontalFlick
    spacing: 16
}

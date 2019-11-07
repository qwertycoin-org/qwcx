import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material 2.12

T.Label {
    id: control

    font {
        letterSpacing: 0.15
        pixelSize: 20
        weight: Font.Medium
    }
    color: enabled ? Material.foreground : Material.hintTextColor
    linkColor: Material.accentColor
}

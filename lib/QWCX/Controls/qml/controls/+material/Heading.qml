import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material 2.12

T.Label {
    id: control

    color: enabled ? Material.foreground : Material.hintTextColor
    linkColor: Material.accentColor
}

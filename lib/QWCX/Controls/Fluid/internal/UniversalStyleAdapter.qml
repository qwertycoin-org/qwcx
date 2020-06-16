import QtQuick 2.15
import QtQuick.Controls.Universal 2.15
import QWCX.Controls.Fluid 1.0

QtObject {
    id: control

    property QtObject target: null
    property Fluid fluid: null
    readonly property var universal: control.target ? control.target["Universal"] : null

    readonly property Connections connections: Connections {
        target: control.fluid
        ignoreUnknownSignals: true
        enabled: (control.parent !== null) && (control.fluid !== null)

        function onThemeChanged() { control.inheritTheme(control.fluid.theme) }
        function onSecondaryChanged() { control.inheritAccent(control.fluid.secondary) }
        function onBackgroundChanged() { control.inheritBackground(control.fluid.background) }
        function onForegroundChanged() { control.inheritForeground(control.fluid.foreground) }

        Component.onCompleted: {
            control.inheritTheme(control.fluid.theme)
            control.inheritAccent(control.fluid.secondary)
            control.inheritBackground(control.fluid.background)
            control.inheritForeground(control.fluid.foreground)
        }
    }

    function inheritTheme(theme) {
        if (!control.universal)
            return

        control.universal.theme = (theme === Fluid.Dark) ? Universal.Dark : Universal.Light
    }

    function inheritAccent(accent) {
        if (!control.universal)
            return

        control.universal.accent = accent
    }

    function inheritBackground(background) {
        if (!control.universal)
            return

        control.universal.background = background
    }

    function inheritForeground(foreground) {
        if (!control.universal)
            return

        control.universal.foreground = foreground
    }
}

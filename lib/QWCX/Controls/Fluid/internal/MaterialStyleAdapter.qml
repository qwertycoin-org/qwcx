import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QWCX.Controls.Fluid 1.0

QtObject {
    id: control

    property QtObject target: null
    property Fluid fluid: null
    readonly property var material: control.target ? control.target["Material"] : null

    readonly property Connections connections: Connections {
        target: control.fluid
        ignoreUnknownSignals: true
        enabled: (control.parent !== null) && (control.fluid !== null)

        function onThemeChanged() { control.inheritTheme(control.fluid.theme) }
        function onPrimaryChanged() { control.inheritPrimary(control.fluid.primary) }
        function onSecondaryChanged() { control.inheritAccent(control.fluid.secondary) }
        function onBackgroundChanged() { control.inheritBackground(control.fluid.background) }
        function onForegroundChanged() { control.inheritForeground(control.fluid.foreground) }
        function onElevationChanged() { control.inheritElevation(control.fluid.elevation) }

        Component.onCompleted: {
            control.inheritTheme(control.fluid.theme)
            control.inheritPrimary(control.fluid.primary)
            control.inheritAccent(control.fluid.secondary)
            control.inheritBackground(control.fluid.background)
            control.inheritForeground(control.fluid.foreground)
            control.inheritElevation(control.fluid.elevation)
        }
    }

    function inheritTheme(theme) {
        if (!control.material)
            return

        control.material.theme = (theme === Fluid.Dark) ? Material.Dark : Material.Light
    }

    function inheritPrimary(primary) {
        if (!control.material)
            return

        control.material.primary = primary
    }

    function inheritAccent(accent) {
        if (!control.material)
            return

        control.material.accent = accent
    }

    function inheritBackground(background) {
        if (!control.material)
            return

        control.material.background = background
    }

    function inheritForeground(foreground) {
        if (!control.material)
            return

        control.material.foreground = foreground
    }

    function inheritElevation(elevation) {
        if (!material)
            return

        control.material.elevation = elevation
    }
}

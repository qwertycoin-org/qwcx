import QtQuick 2.15
import QtQuick.Controls 2.15
import QWCX.Controls.Fluid 1.0

Label {
    id: control

    property int size: 1

    font: {
        var types = [
            Fluid.Headline1,
            Fluid.Headline2,
            Fluid.Headline3,
            Fluid.Headline4,
            Fluid.Headline5,
            Fluid.Headline6
        ]

        var index = control.size - 1
        index = Math.max(index, 0)
        index = Math.min(index, 5)

        return Fluid.font(types[index])
    }
}

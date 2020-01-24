import QtQuick 2.12
import QtQuick.Templates 2.12 as T

T.ItemDelegate {
    property real amount: 0.0
    property int confirmations: 0
    property string hash: null
    property date timestamp: new Date(null)
}

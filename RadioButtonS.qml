import QtQuick 2.0

MouseArea{
    property string icon_default: ""
    property string status: ""
    property alias source: img.source
    implicitWidth: img.width
    implicitHeight: img.height

    Image {
        id: img
        source: icon_default
    }
}

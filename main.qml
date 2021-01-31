import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 480
    height: 320
    visible: true
    title: qsTr("Transit Funding")
    property variant win;

    //Backgroud of Application
    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/Image/green-black-geometric-background.jpg"
    }

    //Setting
    Item {
        id: setting
        width: 60; height: 60

        Image {
            id: icon_setting
            x: 37
            y: 59
            height: parent.height
            width: parent.width
            anchors.rightMargin: -66
            anchors.bottomMargin: -63
            source: "qrc:/Image/car-repair.png"
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                onClicked: {
                    var component = Qt.createComponent("settingWindow.qml")
                    win = component.createObject(setting);
                    win.show();
                }
            }
        }
        Text {
            id: icon_text
            x: 45
            y: 125
            text: qsTr("Setting")
            horizontalAlignment: Text.AlignHCenter
            anchors.bottomMargin: -13
            color: "#00FF00"
            font.pixelSize: 14

        }
    }

    //Route
    Item {
        id: route
        x: 104
        y: 59
        width: 60; height: 60

        Image {
            id: icon_route
            x: 1
            y: 0
            height: parent.height
            width: parent.width
            anchors.rightMargin: -66
            anchors.bottomMargin: -63
            source: "qrc:/Image/car_route.png"
            MouseArea{
                id: mouseAreaRoute
                anchors.fill: parent
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                onClicked: {
                    console.log("button is clicked")
                    var component = Qt.createComponent("accruedExpenses.qml")
                    win = component.createObject(setting);
                    win.show();
                }
            }
        }
        Text {
            id: text_route
            x: 12
            y: 66
            text: qsTr("Route")
            horizontalAlignment: Text.AlignHCenter
            color: "#00FF00"
            font.pixelSize: 14

        }   
    }
}



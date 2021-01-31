import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Dialogs 1.2

Window{
    width: 480
    height: 320
    title: "Accrued Expenses"

    //Background
    Image{
        id: background
        anchors.fill: parent
        source: "qrc:/Image/green-black-geometric-background.jpg"
    }

    RadioButtonS{
        id: radio_button_oneWay
        x: 21
        y: 91
        icon_default: "qrc:/Image/radio_button_check.png"
        status: "check"
        onClicked: {
            radio_button_oneWay.status = "check"
            radio_button_twoWays.status = "uncheck"
            icon_default = "qrc:/Image/radio_button_check.png"
            radio_button_twoWays.icon_default = "qrc:/Image/radio_button_uncheck.png"
        }
        visible: true
        Text {
            id: oneWay
            x: 29
            y: 2
            text: qsTr("1 Chiều")
            color: "#00FF00"
            font.pixelSize: 14
        }
    }
    RadioButtonS{
        id: radio_button_twoWays
        x: 137
        y: 91
        icon_default: "qrc:/Image/radio_button_uncheck.png"
        status: "uncheck"
        onClicked: {
            radio_button_oneWay.status = "uncheck"
            radio_button_twoWays.status = "check"
            icon_default = "qrc:/Image/radio_button_check.png"
            radio_button_oneWay.icon_default = "qrc:/Image/radio_button_uncheck.png"
        }
        visible: true
        Text {
            id: twoWays
            x: 28
            y: 2
            text: qsTr("2 Chiều")
            color: "#00FF00"
            font.pixelSize: 14
        }
    }

    Text {
        id: distance
        x: 21
        y: 145
        text: qsTr("Quãng đường (Km):")
        color: "#00FF00"
        font.pixelSize: 14
    }

    //Ảnh để tạo background cho TextField
    Image {
        id: pic
        source: ""
    }

    TextField {
        id: fieldDistance
        x: 150
        y: 140
        width: 125
        height: 27
        placeholderText: qsTr("Enter here")
        color: "yellow"
        font.pixelSize: 14
        background: pic
    }

    ButtonControl{
        id: calculte
        x: 302
        y: 139
        icon_default: "qrc:/Image/icon-calculate.png"
        icon_pressed: "qrc:/Image/icon-calculate-click.png"
        icon_released: "qrc:/Image/icon-calculate.png"

        Text{
            id: cal
            x: 23
            y: 5
            text: qsTr("Calculate")
            color: "yellow"
            font.pixelSize: 14
        }

        Component.onCompleted:{
            var db = LocalStorage.openDatabaseSync("MyDatabase", "1.0", "The Example QML SQL!", 1000000);
            db.transaction(
                  function(tx){
                      // Create the database if it doesn't already exist
                      tx.executeSql('CREATE TABLE IF NOT EXISTS Data
                            (door_open NUMERIC,thirty NUMERIC,more_than_thirty NUMERIC)');
                  }
            )
        }

        onClicked: {
            var door_open, thirty, more_than_thirty, distances;
            var db = LocalStorage.openDatabaseSync("MyDatabase", "1.0", "The Example QML SQL!", 1000000);
            db.transaction(
                  function(tx){
                      var rs = tx.executeSql('SELECT * FROM Data');
                      var r = ""
                      if(rs.rows.length === 0)
                          failMessage.visible = true
                      else
                      {
                          door_open = rs.rows.item(rs.rows.length - 1).door_open
                          thirty = rs.rows.item(rs.rows.length - 1).thirty
                          more_than_thirty = rs.rows.item(rs.rows.length - 1).more_than_thirty
                          distances = fieldDistance.text
                          if(radio_button_oneWay.status === "check")
                          {
                              if(distances < 30)
                              {
                                  accruedExpenseS_text.text = door_open + (distances - 1)*thirty;
                              }else
                              {
                                  accruedExpenseS_text.text = door_open + (30-1)*thirty + (distances-30)*more_than_thirty;
                              }
                          }else if(radio_button_twoWays.status === "check")
                          {
                              if(distances < 60)
                              {
                                  accruedExpenseS_text.text = distances * 11300 * 2;
                              }
                              else
                              {
                                  accruedExpenseS_text.text = 680000 + (distances-60)*7000*2;
                              }
                          }
                      }
                  }
            )
        }
    }

    Text {
        id: accruedExpenseS
        x: 205
        y: 205
        text: qsTr("Tiền phải trả (VNĐ):")
        color: "#00FF00"
        font.pixelSize: 14
    }

    Text {
        id: accruedExpenseS_text
        x: 334
        y: 205
        color: "yellow"
        font.pixelSize: 14
        text: qsTr("0")
    }

    MessageDialog{
        id: failMessage
        icon: StandardIcon.Critical
        text: "Enter information in Setting first"
        onAccepted: {
            close()
        }
        Component.onCompleted: visible = false
    }

    Image {
        id: homeButton
        x: 92
        y: 6
        source: "qrc:/Image/home_button.png"
        MouseArea{
            anchors.fill: parent
            onClicked: close()
        }
    }
}

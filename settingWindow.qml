import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Dialogs 1.2

Window{
    id: mainWindow
    width: 480
    height: 320
    title: "Setting"

    //Background
    Image{
        id: background
        anchors.fill: parent
        source: "qrc:/Image/green-black-geometric-background.jpg"
    }

    Text {
        id: openDoor
        x: 21
        y: 92
        text: qsTr("Phí mở cửa (VNĐ):")
        color: "#00FF00"
        font.pixelSize: 14
    }

    Text {
        id: thirty
        x: 21
        y: 121
        text: qsTr("Trong phạm vi 30 km (VNĐ):")
        color: "#00FF00"
        font.pixelSize: 14
    }

    Text {
        id: moreThanThirty
        x: 21
        y: 150
        text: qsTr("Từ km thứ 31 trở đi (VNĐ):")
        color: "#00FF00"
        font.pixelSize: 14
    }

    //Ảnh để tạo background cho TextField
    Image {
        id: pic
        source: ""
    }

    TextField {
        id: fieldDoorOpen
        x: 206
        y: 87
        width: 200
        height: 27
        placeholderText: qsTr("Enter here")
        color: "yellow"
        font.pixelSize: 14
        background: pic
    }

    TextField {
        id: fieldThirty
        x: 206
        y: 116
        width: 200
        height: 27
        placeholderText: qsTr("Enter here")
        color: "yellow"
        font.pixelSize: 14
        background: pic
    }

    TextField {
        id: fieldMoreThanThirty
        x: 206
        y: 145
        width: 200
        height: 27
        placeholderText: qsTr("Enter here")
        color: "yellow"
        font.pixelSize: 14
        background: pic
    }

    ButtonControl{
        id: ok_button
        x: 336
        y: 213
        icon_default: "qrc:/Image/ok button.png"
        icon_pressed: "qrc:/Image/ok_button_clicked.png"
        icon_released: "qrc:/Image/ok button.png"

        //Create Table of Database
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
            console.log("button clicked!")

            //Check the information
            if(fieldDoorOpen.text =="" || fieldThirty.text == "" || fieldMoreThanThirty.text == "")
                failMessage.visible = true
            else{
                //Save data to database
                var db = LocalStorage.openDatabaseSync("MyDatabase", "1.0", "The Example QML SQL!", 1000000);
                db.transaction(
                    function(tx){
                        // Add (another) row
                        tx.executeSql('INSERT INTO Data VALUES(?, ?, ?)',
                                      [ fieldDoorOpen.text, fieldThirty.text, fieldMoreThanThirty.text]);

//                        // Show all added greetings
//                        var rs = tx.executeSql('SELECT * FROM Data');
//                        var r = ""
//                        var s = ""
//                        for (var i = 0; i < rs.rows.length; i++) {
//                            r += rs.rows.item(i).door_open + ", " + rs.rows.item(i).thirty +", "
//                                      + rs.rows.item(i).more_than_thirty + "\n"
//                        }
//                        s = rs.rows.item(rs.rows.length - 1).door_open + ", "
//                                + rs.rows.item(rs.rows.length - 1).thirty +", "
//                                + rs.rows.item(rs.rows.length - 1).more_than_thirty
//                        console.log(r)
//                        console.log(s)
                    }
                )
                successMessage.visible = true
            }
        } 
    }

    MessageDialog{
        id: successMessage
        text: "Successfully Added"
        onAccepted: {
            mainWindow.close()
        }
        Component.onCompleted: visible = false
    }

    MessageDialog{
        id: failMessage
        icon: StandardIcon.Critical
        text: "Enter information"
        onAccepted: {
            close()
        }
        Component.onCompleted: visible = false
    }

    ButtonControl{
        id: cancel_button
        x: 396
        y: 213
        icon_default: "qrc:/Image/cancel button.png"
        icon_pressed: "qrc:/Image/cacel_button_clicked.png"
        icon_released: "qrc:/Image/cancel button.png"

        onClicked: mainWindow.close();
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

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1}
}
##^##*/

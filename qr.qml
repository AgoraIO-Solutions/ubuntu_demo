import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

ColumnLayout {
    id: mainLayout
    anchors {
        fill: parent
        margins: 10
    }


    Rectangle {
        id: barcodeRectangle
        Layout.fillWidth: true
        Layout.fillHeight: true
        border.width: 1
        border.color: "#bdbebf"
        clip: true
        color: "white"

        Image{
            id:resultImage
            anchors.centerIn: parent
            sourceSize.width: 200
            sourceSize.height: 200
            source: "image://QZXing/encode/test"
            cache: true
        }
    }

    Button {
        id:back
        width: 72
        height: 72
        text: "back"
        onClicked:{
            main.joinChannel(main.channelName)
        }
    }
}

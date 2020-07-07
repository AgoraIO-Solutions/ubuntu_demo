import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.0
import QtWebEngine 1.0

ColumnLayout {
    id: mainLayout
    anchors {
        fill: parent
        margins: 10
    }

    Rectangle {
        id: barcodeRectangle1
        Layout.fillWidth: true
        Layout.fillHeight: true
        border.width: 1
        border.color: "#bdbebf"
        clip: true
        color: "white"

        WebEngineView {
            width: 300
            height: 300
            id:webview1
            anchors.fill: parent
//            url: "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=" + main.channelName
            url: "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=test"
        }
    }

    Button {
        id:btnShow
        width: 72
        height: 72
        text: "open window"
        onClicked:{
//            main.joinChannel(main.channelName)
            qrWindow.show()
        }
    }

    Window {
        id: qrWindow
        visible: false
        width: 400
        height: 400

        WebEngineView {
            width: 300
            height: 300
            id:webview
            anchors.fill: parent
//            url: "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=" + main.channelName
            url: "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=test"
        }

    }
}

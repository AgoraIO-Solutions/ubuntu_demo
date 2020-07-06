import QtQuick 2.5
import QtMultimedia 5.0
import "./controls"

Rectangle {
    id: rectangleRoom
    width: 1000
    property alias titleBar: titleBar
    property alias rectangleRoom: rectangleRoom
    property alias btnSettingsCall: btnSettings
    property alias btnVoiceCall: btnVoice
    property alias btnMuteVoice: btnMuteVoice
    property alias btnExpandView: btnExpandView
    property alias btnEndCall: btnEndCall
    property int maxViewWidth: rectangleRoom.width
    property int maxViewHeight: rectangleRoom.height - titleBar.height - rectToolbar.height
    ATitleBar {
        id: titleBar
        width: parent.width
        height: 24
        anchors.top: parent.top
        anchors.topMargin: 0
    }
    property alias channelName: channelName
    Text {
        id: channelName
        y: 50
        width: 100
        color: "#000000"
        text: qsTr("")
        anchors.left: parent.left
        anchors.leftMargin: 60
        font.bold: true
        z: 1
        anchors.top: titleBar.bottom
        anchors.topMargin: 20
        font.pixelSize: 16
    }
    property alias moviePlayer: moviePlayer
    AVideoView {
        id: moviePlayer
        color: "#424242"
        anchors.right: localVideo.left
        anchors.rightMargin: 4
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.bottom: rectToolbar.top
        anchors.bottomMargin: 4
        anchors.top: channelName.bottom
        anchors.topMargin: 4
        showVideo: true
    }

    property alias localVideo: localVideo
    AVideoView {
        id: localVideo
        x: 0
        y: 0
        width: 190
        height: 100
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: channelName.bottom
        anchors.topMargin: 4
        showVideo: true
        backgroundImage: "images/icon_background_video.png"
    }
    property alias remoteVideo1: remoteVideo1
    AVideoView {
        id: remoteVideo1
        width: 190
        height: 100
        showVideo: false
        z: 1
        backgroundImage: "images/icon_background_video.png"
        anchors.top: localVideo.bottom
        anchors.topMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
    }

    property alias remoteVideo2: remoteVideo2
    AVideoView {
        id: remoteVideo2
        width: 190
        height: 100
        showVideo: false
        z: 1
        anchors.topMargin: 4
        backgroundImage: "images/icon_background_video.png"
        anchors.top: remoteVideo1.bottom
        anchors.right: parent.right
        anchors.rightMargin: 4
    }

    property alias remoteVideo3: remoteVideo3
    AVideoView {
        id: remoteVideo3
        width: 190
        showVideo: false
        z: 1
        height: 100
        visible: true
        anchors.topMargin: 4
        backgroundImage: "images/icon_background_video.png"
        anchors.top: remoteVideo2.bottom
        anchors.right: parent.right
        anchors.rightMargin: 4
    }

    property alias remoteVideo4: remoteVideo4
    AVideoView {
        id: remoteVideo4
        width: 190
        visible: false
        showVideo: false
        z: 1
        anchors.bottom: rectToolbar.top
        anchors.bottomMargin: 4
        anchors.topMargin: 4
        backgroundImage: "images/icon_background_video.png"
        anchors.top: remoteVideo3.bottom
        anchors.right: parent.right
        anchors.rightMargin: 4
    }

    Rectangle {
        id: rectToolbar
        x: 0
        width: parent.width
        height: 60
        color: "#262626"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Rectangle {
            id: rectControlBar
            x: 109
            y: 0
            width: 432
            height: rectToolbar.height
            color: "#00000000"
            anchors.horizontalCenter: parent.horizontalCenter

            AImageButton {
                id: btnSettings
                width: 72
                height: 72
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                defaultImageSource: "images/btn_settings.png"
                hoverImageSource: "images/btn_settings_touch.png"
                pressedImageSource: "images/btn_settings_push.png"
            }

            AImageButton {
                id: btnVoice
                width: 72
                height: 72
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: btnSettings.right
                anchors.leftMargin: 48
                defaultImageSource: "images/btn_qr.png"
                hoverImageSource: "images/btn_qr.png"
                pressedImageSource: "images/btn_qr.png"
            }

            AImageButton {
                id: btnMuteVoice
                width: 72
                height: 72
                anchors.left: btnVoice.right
                anchors.leftMargin: 48
                anchors.verticalCenter: parent.verticalCenter
                defaultImageSource: "images/btn_mute_close.png"
                hoverImageSource: "images/btn_mute_close_touch.png"
                pressedImageSource: "images/btn_mute_close_push.png"
            }

            AImageButton {
                id: btnExpandView
                width: 72
                height: 72
                anchors.left: btnMuteVoice.right
                anchors.leftMargin: 48
                anchors.verticalCenter: parent.verticalCenter
                defaultImageSource: "images/btn_maximize.png"
                hoverImageSource: "images/btn_maximize_touch.png"
                pressedImageSource: "images/btn_maximize_push.png"
            }
        }
        AImageButton {
            id: btnEndCall
            width: 72
            height: 72
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: rectToolbar.right
            anchors.rightMargin: 48

            defaultImageSource: "images/btn_endcall.png"
            hoverImageSource: "images/btn_endcall.png"
            pressedImageSource: "images/btn_endcall_push.png"
        }
    }

    Text {
        id: element
        text: qsTr("Samsung/Agora Watch Together")
        anchors.left: channelName.right
        anchors.leftMargin: 12
        anchors.top: titleBar.bottom
        anchors.topMargin: 20
        font.pixelSize: 16
    }

    property alias cbStreams: cbStreams
    AComboBox {
        id: cbStreams
        x: 668
        y: 34
        width: 300
        height: 29
        visible: true
        anchors.bottom: localVideo.top
        anchors.bottomMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.topMargin: 11
        model: ListModel {
            id: playList
            ListElement {
                text: " "
            }
        }
        editable: false
    }
}

/*##^##
Designer {
    D{i:2;anchors_x:342}D{i:3;anchors_height:480;anchors_width:640;anchors_x:0;anchors_y:48}
D{i:4;anchors_width:200}D{i:7;anchors_height:100}D{i:15;anchors_height:200;anchors_width:200;anchors_x:28;anchors_y:91}
D{i:9;anchors_height:200;anchors_width:200;anchors_x:28;anchors_y:91}D{i:16;anchors_x:219;anchors_y:36}
}
##^##*/


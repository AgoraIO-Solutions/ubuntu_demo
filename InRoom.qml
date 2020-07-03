import QtQuick 2.5

InRoomForm {
    id: inroom
    anchors.fill: parent
    property bool isVideoEnabled: true
    property bool isVideoViewNormal: true
    property bool isVoiceMuted: false
    property var views:[]
    property var videoId

    btnEndCall.onClicked: {
        agoraRtcEngine.setupLocalVideo(null)
        main.leaveChannel()
    }
    btnSettingsCall.onClicked: containerWindow.openDeviceSettings()
    btnMuteVoice.onClicked: {
        isVoiceMuted = !isVoiceMuted
        main.muteLocalAudioStream(isVoiceMuted)
        if (isVoiceMuted) {
            btnMuteVoice.defaultImageSource = "images/btn_mute_open.png"
            btnMuteVoice.hoverImageSource = "images/btn_mute_open_touch.png"
            btnMuteVoice.pressedImageSource = "images/btn_mute_open_push.png"
        } else {
            btnMuteVoice.defaultImageSource = "images/btn_mute_close.png"
            btnMuteVoice.hoverImageSource = "images/btn_mute_close_touch.png"
            btnMuteVoice.pressedImageSource = "images/btn_mute_close_push.png"
        }
    }
    btnVoiceCall.onClicked: {
        main.showQr()
    }
    btnExpandView.onClicked: {
        isVideoViewNormal = !isVideoViewNormal
        if (isVideoViewNormal) {
            containerWindow.showNormal()
            btnExpandView.defaultImageSource = "images/btn_maximize.png"
            btnExpandView.hoverImageSource = "images/btn_maximize_touch.png"
            btnExpandView.pressedImageSource = "images/btn_maximize_push.png"
        } else {
            containerWindow.showMaximized()
            btnExpandView.defaultImageSource = "images/btn_restore.png"
            btnExpandView.hoverImageSource = "images/btn_restore_touch.png"
            btnExpandView.pressedImageSource = "images/btn_restore_push.png"
        }
    }
    Component.onCompleted: {
        inroom.views = [localVideo, remoteVideo1, remoteVideo2, remoteVideo3, remoteVideo4]

        channelName.text = main.channelName
        agoraRtcEngine.setupLocalVideo(localVideo.videoWidget)
    }
    localVideo.onDoubleClicked: {
        inroom.maximizeView(localVideo)
    }
    remoteVideo1.onDoubleClicked: {
        inroom.maximizeView(remoteVideo1)
    }
    remoteVideo2.onDoubleClicked: {
        inroom.maximizeView(remoteVideo2)
    }
    remoteVideo3.onDoubleClicked: {
        inroom.maximizeView(remoteVideo3)
    }
    remoteVideo4.onDoubleClicked: {
        inroom.maximizeView(remoteVideo4)
    }

    Connections {
        target: agoraRtcEngine
        onFirstLocalVideoFrame: {
            localVideo.showVideo = true
        }

        onUserJoined: {
            inroom.handleUserJoined(uid)
        }
        onFirstRemoteVideoDecoded: {
            inroom.handleUserJoined(uid)
        }
        onUserOffline: {
            var view = inroom.findRemoteView(uid)
            if (view)
                inroom.unbindView(uid, view)
        }
    }
    function handleUserJoined(uid) {
        var view
        if(uid === 9999){
            moviePlayer.uid = 9999
            moviePlayer.showVideo = true
            moviePlayer.visible = true
            agoraRtcEngine.setupRemoteVideo(uid, moviePlayer.videoWidget)
            inroom.bindView(uid, moviePlayer)
        }
        else{
            view = inroom.findRemoteView(uid)
            console.log("handle user joined for user " + uid + " view " + view)
            if (view !== undefined)
                return
//            find a free view to bind
            view = inroom.findRemoteView(0)
            console.log("foud free view " + view + "to bind")
            if (view && agoraRtcEngine.setupRemoteVideo(uid, view.videoWidget) === 0) {
                console.log("bind view view " + view + "for user" + uid)
                inroom.bindView(uid, view)
            }
        }
    }

    function maximizeView(view) {
        if (view.width === view.parent.width)
            return
        var i, v, mv
        //find the maximized view
        for (i in inroom.views) {
            v = inroom.views[i]
            if (v.width === v.parent.width) {
                mv = v
                break
            }
        }
        if (mv) {
            view.swap(mv)
        }
        for (i in inroom.views) {
            v = inroom.views[i]
            if (v === view)
                v.z = 0
            else
                v.z = 1
        }
    }

    function findRemoteView(uid) {
        for (var i in inroom.views) {
            var v = inroom.views[i]
            if (v.uid === uid && v !== localVideo)
                return v
        }
    }

    function bindView(uid, view) {
        if (view.uid !== 0)
            return false
        view.uid = uid
        view.showVideo = true
        view.visible = true
//        console.log("bind view " + view + " for user " + uid)
        return true
    }
    function unbindView(uid, view) {
        if (uid !== view.uid)
            return false
        view.showVideo = false
        view.visible = false
        view.uid = 0
//        console.log("unbind view " + view + " for user " + uid)
        return true
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

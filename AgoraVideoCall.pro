TEMPLATE = app

QT += core quickwidgets
CONFIG += c++11
CONFIG += qzxing_qml
SOURCES += main.cpp \
    agorartcengine.cpp \
    mainwindow.cpp \
    avideowidget.cpp \
    video_render_opengl.cpp \
    video_render_impl.cpp

RESOURCES += qml.qrc
CONFIG += enable_encoder_qr_code
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
include(src/QZXing-components.pri)
HEADERS += \
    agorartcengine.h \
    mainwindow.h \
    avideowidget.h \
    video_render_opengl.h \
    video_render_impl.h


win32: {
    INCLUDEPATH += $$PWD/sdk/include
    LIBS += -L$$PWD/sdk/lib/ -lagora_rtc_sdk
    CONFIG(Debug, Debug|Release){
        QMAKE_POST_LINK += copy sdk\dll\*.dll debug
    } else {
        QMAKE_POST_LINK += copy sdk\dll\*.dll release
        QMAKE_POST_LINK  += && windeployqt Release\AgoraVideoCall.exe
    }
}

linux: {
    INCLUDEPATH += $$PWD/lib/include
    LIBS += -pthread -lpthread -L$$PWD/lib -Wl,-rpath=$$PWD/lib -lagora_rtc_sdk -ldl -lrt -lasound -lpulse
}

macx:{
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.11

INCLUDEPATH += $$PWD/lib/AgoraRtcEngineKit.framework/Headers

QMAKE_LFLAGS += -F/System/Library/Frameworks
QMAKE_LFLAGS += -F$$PWD/lib/

LIBS += -framework AgoraRtcEngineKit
LIBS += -framework Foundation \
        -framework CoreAudio \
        -framework CoreVideo \
        -framework CoreServices \
        -framework AppKit \
        -framework AudioToolbox \
        -framework VideoToolbox \
        -framework Accelerate \
        -framework SystemConfiguration \
        -framework AVFoundation \
        -framework CoreMedia \
        -framework CoreWLAN \
        -framework QTKit \
        -framework CoreGraphics

LIBS += -lresolv
}

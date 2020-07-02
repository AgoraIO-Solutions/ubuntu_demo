#include <QApplication>
#include <QGuiApplication>
#include "mainwindow.h"
#include "avideowidget.h"
#include <QQmlApplicationEngine>
#include "QZXing.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName("Agora");
    app.setOrganizationDomain("agora.io");

    qmlRegisterType<AVideoWidget>("AVideoWidget", 1, 0, "AVideoWidget");

    QQmlApplicationEngine engine;

    QZXing::registerQMLTypes();
    QZXing::registerQMLImageProvider(engine);

    engine.load(QUrl(QLatin1String("qrc:/qr.qml")));

    MainWindow w;
    w.show();

    return app.exec();
}


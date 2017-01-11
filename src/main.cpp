#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "FileRecover.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<FileRecover>("Backend", 1, 0, "FileRecover");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/src/main.qml")));

    return app.exec();
}

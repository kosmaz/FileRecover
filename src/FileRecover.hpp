#ifndef FILERECOVER_HPP
#define FILERECOVER_HPP

#include <QObject>
#include <QGuiApplication>


class FileRecover : public QObject
{
    Q_OBJECT
public:
    explicit FileRecover(QObject *parent = 0);
    Q_INVOKABLE void startRecovery(QString);
    Q_INVOKABLE void getDrives();

signals:
    void recoveryComplete();
    void drives(QStringList drv);
    void operationStatus(QString str);

private:
    void restoreFilesAndFolders();

    QString fDrive;
};

#endif // FILERECOVER_HPP

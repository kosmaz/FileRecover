#include "FileRecover.hpp"
#include "DirIterator.hpp"
#include <QDir>

FileRecover::FileRecover(QObject *parent) :
    QObject(parent) {}


void FileRecover::startRecovery(QString drive)
{
    fDrive = drive.replace('\\', '/');
    restoreFilesAndFolders();

    DirIterator* it = new DirIterator(this, fDrive);
    connect(it, &DirIterator::operationStatus, this, &FileRecover::operationStatus);
    connect(it, &DirIterator::finished, this, [=]() {
        emit recoveryComplete();
        it->deleteLater();
    });
    it->start();
    return;
}


void FileRecover::getDrives()
{
    QStringList drive_names;
    QFileInfoList temp_drives = QDir::drives();
    foreach(QFileInfo a , temp_drives)
    {
        if(a.absoluteFilePath() == "C:/" || a.absoluteFilePath() == "/")
            continue;
        QString temp = a.absoluteFilePath();
        temp.replace('/', '\\');
        drive_names.push_back(temp);
    }
    if(drive_names.size())
        emit drives(drive_names);
    return;
}


void FileRecover::restoreFilesAndFolders()
{
    emit operationStatus("Restoring hidden files and folders");
    QString command = "attrib -h -r -s /s /d " + fDrive + "*.*";
    (void)system(command.toStdString().c_str());
    return;
}

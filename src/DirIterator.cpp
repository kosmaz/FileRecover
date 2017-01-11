#include "DirIterator.hpp"
#include <QDirIterator>


DirIterator::DirIterator(QObject* parent, QString drive) :
    QThread(parent),
    fDrive(drive) {}

void DirIterator::run()
{
    relocateFilesAndFolders();
    removeLinksAndSuspiciousFiles();
    return;
}


void DirIterator::relocateFilesAndFolders()
{
    emit operationStatus("Re-arranging directory structure");
    QDirIterator dir_iterator(fDrive);
    while(dir_iterator.hasNext())
    {
        dir_iterator.next();
        if(dir_iterator.fileInfo().isDir() && dir_iterator.fileName() == "")
        {
            QDir dir;
            QString new_name = QString::number(qrand());
            dir.rename(dir_iterator.filePath(), dir_iterator.filePath() + new_name);

            QDirIterator mover(fDrive + new_name);
            while(mover.hasNext())
            {
                mover.next();
                QString command = "move " + mover.filePath() + " " + fDrive;
                (void)system(command.toStdString().c_str());
            }
            dir.remove(fDrive + new_name);
            break;
        }
    }

    return;
}


void DirIterator::removeLinksAndSuspiciousFiles()
{
    emit operationStatus("Removing unwanted symbolic links and files");
    QDir dir;
    QDirIterator dir_iterator(fDrive, QDirIterator::Subdirectories);
    while(dir_iterator.hasNext())
    {
        dir_iterator.next();
        if(dir_iterator.fileInfo().isSymLink())
            dir.remove(dir_iterator.filePath());
        else if(fVirus1.compare(dir_iterator.fileName(), Qt::CaseInsensitive) == 0)
            dir.remove(dir_iterator.filePath());
        else if(fVirus2.compare(dir_iterator.fileName(), Qt::CaseInsensitive) == 0)
            dir.remove(dir_iterator.filePath());
        else if(fVirus3.compare(dir_iterator.fileName(), Qt::CaseInsensitive) == 0)
        {
            dir.remove(dir_iterator.filePath() + "AutoIt3.exe");
            dir.rmdir(dir_iterator.filePath());
        }
        else if(fVirus4.compare(dir_iterator.fileName(), Qt::CaseInsensitive) == 0)
            dir.remove(dir_iterator.filePath());
    }
    return;
}

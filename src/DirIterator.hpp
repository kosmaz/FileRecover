#ifndef DIRITERATOR_HPP
#define DIRITERATOR_HPP

#include <QThread>

class DirIterator : public QThread
{
    Q_OBJECT
public:
    DirIterator(QObject*, QString);
    void run() Q_DECL_OVERRIDE;

signals:
    void operationStatus(QString);

private:
    DirIterator(const DirIterator&) = delete;
    DirIterator(DirIterator&&) = delete;
    DirIterator& operator=(const DirIterator&) = delete;
    DirIterator& operator=(DirIterator&&) = delete;

    void relocateFilesAndFolders();
    void removeLinksAndSuspiciousFiles();

    QString fDrive;
    const QString fVirus1 = "Microsoft Excel.WsF";
    const QString fVirus2 = "update.vbs";
    const QString fVirus3 = "Skypee";
    const QString fVirus4 = "%%%%%%%%%%%%%%%%.1";
};

#endif // DIRITERATOR_HPP

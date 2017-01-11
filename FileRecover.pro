TEMPLATE = app

QT += qml quick core
QT -= network gui
CONFIG += c++11


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

RESOURCES += \
    qml.qrc

HEADERS += \
    src/DirIterator.hpp \
    src/FileRecover.hpp

SOURCES += \
    src/DirIterator.cpp \
    src/FileRecover.cpp \
    src/main.cpp

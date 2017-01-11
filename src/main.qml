import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtQuick 2.5
import Backend 1.0


Window {
    id: mainWindow
    visible: true
    width: 320
    height: 200
    minimumWidth: 320
    minimumHeight: 200
    maximumWidth: 320
    maximumHeight: 200
    color: "#808080"
    opacity: 0.98
    title: qsTr("File Recover")

    property string drive: {
        selectDrive.textAt(selectDrive.currentIndex);
    }

    onDriveChanged: {
        if(drive !== "No Drive")
            restoreButton.enabled = true;
        else
            restoreButton.enabled = false;
    }


    function resetUI() {
        operationProgress.visible = !operationProgress.visible;
        progressLabel.visible = !progressLabel.visible;
        aboutButton.enabled = !aboutButton.enabled;
        selectDrive.enabled = !selectDrive.enabled;
        quitButton.enabled = !quitButton.enabled;
    }


    FileRecover {
        id: fileRecover
        onRecoveryComplete: resetUI();
        Component.onCompleted: {
            getDrives();
        }

        onOperationStatus: {
            progressLabel.text = str;
        }

        onDrives: {
            selectDrive.model = ["No Drive", drv];
        }
    }


    ComboBox {
        id: selectDrive
        anchors.left: infoLabel.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 40
        model: ["No Drive"]
        style: ComboBoxStyle {
            background: Rectangle {
                anchors.fill: parent
                color: selectDrive.hovered ? "#A9A9A9" : "#98e496"
                border.width: 1
                border.color: "#7ae88e"
                radius: 2
                implicitHeight: 30
                implicitWidth: 100
            }
        }
    }


    Label {
        id: infoLabel
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 40
        text: qsTr("Select the affected drive\nfrom the list")
        font.pointSize: 10
        color: "#FFFFF0"
    }


    Button {
        id: refreshButton
        anchors.left: selectDrive.right
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 40
        iconSource: "qrc:/images/refresh1.png"
        onClicked: {
            fileRecover.getDrives();
        }

        onHoveredChanged: {
            if(hovered)
                iconSource = "qrc:/images/refresh0.png"
            else
                iconSource = "qrc:/images/refresh1.png"
        }
        style: ButtonStyle {
            background: Rectangle {
                anchors.fill: parent
                color: "#808080"
                border.width: 1
                border.color: "#808080"
                radius: 10
                implicitHeight: 20
                implicitWidth: 20
            }
        }
    }


    Button {
        id: restoreButton
        text: qsTr("Restore drive")
        enabled: false
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        onClicked: {
            fileRecover.startRecovery(drive);
            enabled = !enabled;
            operationProgress.visible = !operationProgress.visible;
            progressLabel.visible = !progressLabel.visible;
            aboutButton.enabled = !aboutButton.enabled;
            selectDrive.enabled = !selectDrive.enabled;
            quitButton.enabled = !quitButton.enabled;
        }

        style: ButtonStyle {
            id: restoreButtonStyle
            background: Rectangle {
                color: restoreButton.enabled ? (restoreButton.hovered ? "#A9A9A9" : "#98e496") : "#FFFFFF"
                border.width: 1
                border.color: restoreButton.enabled ? "#7ae88e" : "#FFFFFF"
                radius: 2
                implicitWidth: 70
                implicitHeight: 30
            }
        }
    }


    Button {
        id: aboutButton
        text: qsTr("About")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        onClicked: {
            aboutWindow.visible = true;
            openAboutWindow.start();
        }

        style: ButtonStyle {
            background: Rectangle {
                color: aboutButton.enabled ? (aboutButton.hovered ? "#A9A9A9" : "#59b3e0") : "#FFFFFF"
                border.width: 1
                border.color: aboutButton.enabled ? "#92d0ee" : "#FFFFFF"
                radius: 2
                implicitWidth: 70
                implicitHeight: 30
            }
        }

    }


    Button {
        id: quitButton
        text: qsTr("Quit")
        enabled: true
        onClicked: Qt.quit();
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        style: ButtonStyle {
            id: quitButtonStyle
            background: Rectangle {
                color: quitButton.enabled ? (quitButton.hovered ? "#A9A9A9" : "#e84242") : "#FFFFFF"
                border.width: 1
                border.color: quitButton.enabled ? "#e48297" : "#FFFFFF"
                radius: 2
                implicitWidth: 70
                implicitHeight: 30
            }
        }
    }


    Label {
        id: progressLabel
        visible: false
        font.italic: true
        color: "#FFF5EE"
        horizontalAlignment: Text.AlignHCenter
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.bottom: operationProgress.top
        anchors.bottomMargin: 4
    }


    ProgressBar {
        id: operationProgress
        indeterminate: true
        visible: false
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.bottom: aboutButton.top
        anchors.bottomMargin: 4
    }


    Rectangle {
        id: aboutWindow
        color: "#8fbfd1"
        visible: false
        anchors.fill: parent

        Text {
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.right: parent.right
            anchors.rightMargin: 4
            anchors.left: parent.left
            anchors.leftMargin: 4
            text: qsTr("\n\nThis software was developed by\n\t-k0$m@3- Inc.\n\nContact us: kosmaz2009@gmail.com\nBug report: kosmaz2009@yahoo.com")
            font.family: "Droid Sans"
            font.bold: true
            font.pointSize: 12
            horizontalAlignment: Text.AlignHCenter
        }

        Button {
            id: backButton
            text: qsTr("Back");
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 4
            onClicked: {
                closeAboutWindow.start();
            }
        }

        RotationAnimation {
            id: openAboutWindow
            easing.type: Easing.OutElastic
            from: 0
            to: 720
            duration: 1000
            loops: 1
            target: aboutWindow
            easing.amplitude: 2
            properties: "rotation"
        }

        RotationAnimation {
            id: closeAboutWindow
            easing.type: Easing.InElastic
            from: 720
            to: 0
            duration: 1000
            loops: 1
            target: aboutWindow
            easing.amplitude: 2
            properties: "rotation"
            onStopped: {
                aboutWindow.visible = false;
            }
        }
    }
}

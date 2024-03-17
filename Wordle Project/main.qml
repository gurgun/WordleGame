import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import GameManager 1.0

ApplicationWindow {
    visible: true
    width: 360
    height: 640
    title: "Wordle Game"
    color: "#121213"

    maximumWidth: 500
    maximumHeight: 700

    minimumWidth: 360
    minimumHeight: 640

    property int keyboardWidth: 30 // keyboard width
    property int keyboardHeight: 40 // keyboard height
    property int enterDeleteWidth: 50 // width for enter and del keys
    property int radiusSize: 5 // radius for roundy keyboard edges

    Component.onCompleted: {
        GameManager.onWon.connect(function() {
            winPopup.open();
        });
        GameManager.onNonSuitableWord.connect(function() {
            notInWordListPopup.showPopup();
        });
        GameManager.onFailed.connect(function(targetWord) {
            //failText.text = "You failed! Correct word is: " + targetWord;
            failPopup.textValue = "Correct word: " + targetWord;
            failPopup.open();
        });
    }

    NotInWordListPopup {
        id: notInWordListPopup
    }

    CustomPopup {
        id: winPopup
        borderColor: "green"
        textValue: "Correct!"
    }

    CustomPopup {
         id: failPopup
         borderColor: "red"
    }

    HelpPopup {
        id: helpPopup
    }

    Image {
        id: helpIcon
        source: "HelpIcon.PNG"
        width: 50
        height: 50
        anchors.top: parent.top
        anchors.right: parent.right
        MouseArea {
            anchors.fill: parent
            onClicked: {
                helpPopup.open();
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10
        // Game Status Display

        Image {
            id: img
            height: 100
            width: 100
            Layout.alignment: Qt.AlignCenter
            source: "WordleIcon.PNG"
        }
        GameGrid{}
        Keyboard{}
    }
}

import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
Popup {
    id: notInWordListPopup
    width: 100
    height: 40
    visible: false // Initially hidden
    y: 10
    x: (parent.width - width) / 2 // Centering the popup horizontally
    padding: 0

    opacity: 1 // for fade effect
    background: Rectangle {
        anchors.centerIn: parent
        anchors.fill: parent
        radius: radiusSize
        color: "white"
            Text {
                text: "Not in word list"
                anchors.centerIn: parent
                color: "black"
                font.bold: true
        }
    }

    SequentialAnimation {
            id: fadeOutAnimation
            NumberAnimation {
                target: notInWordListPopup
                property: "opacity"
                to: 0
                duration: 500

            }
            ScriptAction {
                script: notInWordListPopup.close()
            }
        }


    Timer {
        id: closeTimer
        interval: 1000 // 2 seconds
        onTriggered: notInWordListPopup.closeWithFadeOut()
    }

    function showPopup() {
        notInWordListPopup.opacity = 1;
        notInWordListPopup.open();
        closeTimer.restart(); // Restart the timer every time the popup is shown
        fadeOutAnimation.stop();

    }

    function closeWithFadeOut() {
        fadeOutAnimation.start();
    }


    closePolicy: Popup.NoAutoClose
}

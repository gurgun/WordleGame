import QtQuick 2.0
import QtQuick.Controls 2.2
import GameManager 1.0

Popup {
    property string textValue: "None"
    property color borderColor: "black"
    id: popup
    anchors.centerIn: parent
    width: 200
    height: 100
    modal: true
    focus: true
    background: Rectangle {
        border.color: popup.borderColor
        border.width: 3
        radius: 20
        Text {
            id: failText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            font.pixelSize: 15
            font.bold: true
            text: popup.textValue
        }

        Button {
            text: "Play Again"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            onClicked: {
                GameManager.resetGame();
                popup.close();
            }
            background: Rectangle {
                color: "#d3d3d3"
                radius: 10 // for rounded corners
                border.width: 2
                border.color: "black"
            }
        }

    }
    closePolicy: Popup.NoAutoClose
}

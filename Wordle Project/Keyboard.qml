import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import GameManager 1.0


ColumnLayout {
    id: keyboardLayout

    spacing: 10
    width: parent.width

    function keyboardButtonClicked(letter) {
        //console.log(letter)
        GameManager.pushKeyIfSuitable(letter);
    }

    // First row of letters
    RowLayout {
        spacing: 5
        Layout.alignment: Qt.AlignCenter
        id: rowParent

        Repeater {
            model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
            Rectangle {
                width: keyboardWidth
                height: keyboardHeight
                color: GameManager.keyColors[0][index]
                radius: radiusSize // Rounded edges

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    color: "white"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: keyboardLayout.keyboardButtonClicked(modelData)
                }
            }
        }
    }

    // Second row of letters
    RowLayout {
        spacing: 5
        Layout.alignment: Qt.AlignCenter

        Repeater {
            model: ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
            Rectangle {
                width: keyboardWidth
                height: keyboardHeight
                color: GameManager.keyColors[1][index]
                radius: radiusSize // Rounded edges

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    color: "white"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: keyboardLayout.keyboardButtonClicked(modelData)
                }
            }
        }
    }

    // Third row of letters
    RowLayout {
        spacing: 5
        Layout.alignment: Qt.AlignCenter
        Rectangle {
            width: enterDeleteWidth
            height: keyboardHeight
            color: "#818384"
            radius: radiusSize // Rounded edges

            Text {
                anchors.centerIn: parent
                text: "Enter"
                color: "white"
                font.pixelSize: 14 // Adjusted font size
            }

            MouseArea {
                anchors.fill: parent
                onClicked: GameManager.checkWord()
            }
        }

        Repeater {
            model: ["Z", "X", "C", "V", "B", "N", "M"]
            Rectangle {
                width: keyboardWidth
                height: keyboardHeight
                color: GameManager.keyColors[2][index]
                radius: radiusSize // Rounded edges

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    color: "white"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: keyboardLayout.keyboardButtonClicked(modelData)
                }
            }
        }

        Rectangle {
            width: enterDeleteWidth
            height: keyboardHeight
            color: "#818384"
            radius: radiusSize // Rounded edges

            Text {
                anchors.centerIn: parent
                text: "Del"
                color: "white"
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                onClicked: GameManager.deleteKeyIfSuitable()
            }
        }
    }
}

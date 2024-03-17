import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Popup {
    id: helpPopup
    width: 300
    height: 450
    modal: true
    focus: true
    visible: false
    x: (parent.width - width) / 2 // Centering the popup horizontally
    y: (parent.height - height) / 2 // Centering the popup vertically

    Rectangle {
        color: "black"
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "How To Play\n" +
                      "Guess the Wordle in 6 tries.\n\n" +
                      "- Each guess must be a valid 5-letter word.\n" +
                      "- The color of the tiles will change to show\n" +
                         "how close your guess was to the word.\n\n" +
                      "Examples\n\n" +
                      "W E A R Y\n" +
                      "W becomes green on the screen because\n" +
                        "it is in the word and in the correct spot.\n" +
                      "P I L L S\n" +
                      "I becomes yellow on the screen because\n" +
                        "it is in the word but in the wrong spot.\n" +
                      "V A G U E\n" +
                      "U becomes green on the screen because\n" +
                        "it is not in the word in any spot.\n\n"
                      // +"Press [Esc] to quit rules."

                color: "white"
                font.pixelSize: 14
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                text: "Quit"

                Layout.alignment: Qt.AlignCenter

                background: Rectangle {
                    color: "#d3d3d3"
                    radius: 10
                    border.width: 2
                    border.color: "black"
                }
                onClicked: helpPopup.close()
            }
        }
    }

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
}

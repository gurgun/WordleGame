import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import GameManager 1.0

GridLayout {
    id: gameGrid
    columns: 5
    Layout.alignment: Qt.AlignCenter
    Repeater {
        model: 30 // 6x5 grid
        Rectangle {
            width: 50
            height: 50
            color: GameManager.cellColors[index]
            border.color: "dimgrey"
            border.width: 2

            Text {
                anchors.centerIn: parent

                text: GameManager.cellTexts.length > index ? GameManager.cellTexts[index] : ""
                color: "white"
                font.pixelSize: 20
                font.bold: true
            }

        }
    }
}

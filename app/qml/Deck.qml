import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Pane {
    id: gpane3
    padding: 0

    property int defaultIndex: 0

    background: Rectangle{
        color: "#111"
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        DeckButton {
            imageString:  "qrc://app/images/icons8-library-filled-100.png"
            val: "Library"
            index: 0
        }

        DeckButton {
            imageString:  "qrc://app/images/icons8-cloud-filled-100.png"
            val : "Online"
            index: 1
        }

        DeckButton {
            imageString:  "qrc://app/images/icons8-exterior-filled-100.png"
            val : "Home"
            index: 2
            selectable: false
        }

        DeckButton {
            imageString:  "qrc://app/images/icons8-available-updates-filled-100.png"
            val : "Updates"
            index: 3
            selectable: false
        }

        DeckButton {
            imageString:  "qrc://app/images/icons8-automatic-filled-100.png"
            val : "Settings"
            rightBorderVal: false
            index: 4
            selectable: false
        }
    }
}
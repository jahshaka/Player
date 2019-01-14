import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Pane {
    id: libraryPage

    background: Rectangle {
        color: "transparent"
    }

    Layout.fillWidth: true
    padding: 0

    Grid {
        anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Layout.fillWidth: true
        Layout.fillHeight: true

        columns: 4
        rows: 3
        columnSpacing: 24
        rowSpacing: 24
        leftPadding: 8

        // verticalLayoutDirection: Grid.TopToBottom
        layoutDirection: Qt.LeftToRight
        flow: Grid.LeftToRight
        // anchors.centerIn: parent
        // flickableDirection: Flickable.HorizontalFlick

        id: grid0
        // clip: true
        // interactive: false

        // cellWidth: 450
        // cellHeight: 320

        Repeater {
            model: libraryModel

            delegate: SceneTile {
                id: moster
                width: 450
                height: 336
                sceneTitle: name
                sceneThumbnail: guid
                sceneGuid: guid
                view: "library"
            }
        }
    }
}
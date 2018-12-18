import QtQuick 2.5

Rectangle {
    width: 1920
    height: 1080

    color: "transparent" //Qt.rgba(.1, .1, .1, .63)

    Rectangle {
        id: rectangle
        width: 1024
        height: parent.height
        color: Qt.rgba(.1, .1, .1, .83);
        anchors.centerIn: parent

        border.width: 8
        border.color: Qt.rgba(.1, .1, .1, .7);

        Text {
            text: "Options"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 96
            font.pixelSize: 96;
            font.bold: true
            color: "white"
            opacity: 0.9
        }

        Column {
            id: column
            width: 258
            height: 264
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            clip: false
            spacing: 36

            Text {
                color: "white"
                text: qsTr("Exit")
                font.pixelSize: 96

                Rectangle {
                    id: rectangle1
                    color: "#ffffff"
                    anchors.fill: parent
                }
            }

            Text {
                color: "white"
                text: qsTr("Home")
                font.pixelSize: 96
            }
        }
    }
}

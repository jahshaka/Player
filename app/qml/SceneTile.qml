import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Rectangle {
    id: rect
    property string sceneThumbnail: ""
    property string sceneName: ""
    property string sceneTitle: ""
    property string view: ""

    Layout.fillHeight: true
    Layout.fillWidth: true
    
    property int fauxBorderWidth: 10

    color: "transparent"

Rectangle {
        anchors.centerIn: parent

        color: "green"

        width: parent.width - fauxBorderWidth
        height: parent.height - fauxBorderWidth
        
        Image {
            id: imageBg
            height: parent.height
            width: parent.width
            source: if (sceneThumbnail) "image://guids/" + sceneThumbnail //"qrc://app/images/icons8-arrow-left-filled-100.png"
            anchors.centerIn: parent
        }

        Rectangle {
            id: textView
            clip: true

            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            color: "#1E1E1E"
            implicitHeight: 50

            Label {
                color: "#FEFEFE"
                text: sceneTitle
                wrapMode: Label.WordWrap
                font.pixelSize: Qt.application.font.pixelSize * 2
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    centerIn: parent
                }

            }
        }

        MouseArea {
            width: parent.width
            height: parent.height

            anchors.fill: parent
            anchors.centerIn: parent

            hoverEnabled: true

            onEntered: {
                rect.color = "#4297ff"
                if (view == "library") {
                    methodHandler.selectMetadata(guid);
                } else {
                    methodHandler.emitMetadata(featured_image, sceneTitle, guid, sceneName, actual_guid);
                }
            }

            onPressed: {
                rect.color = "#006DEF"
                if (view == "library") methodHandler.doSomething(guid)
            }

            onReleased: {
                
            }

            onExited: {
                rect.color = "#111"
                // methodHandler.selectMetadata("empty")
            }
        }
    }
}
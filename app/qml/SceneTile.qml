import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Rectangle {
    id: rect
    property string sceneThumbnail: ""
    property string sceneName: ""
    property string sceneGuid: ""
    property string sceneTitle: ""
    property string view: ""

    Layout.fillHeight: true
    Layout.fillWidth: true
    
    property int fauxBorderWidth: 10
    property bool wasPressed: false

    color: "transparent"

    Rectangle {
        anchors.centerIn: rect

        color: "transparent"

        width: rect.width - fauxBorderWidth
        height: rect.height - fauxBorderWidth
        
        Column {
            spacing: 2

            Item {
                width: rect.width - fauxBorderWidth
                height: 248

                Image {
                    id: imageBg
                    smooth: true
                    width: rect.width - fauxBorderWidth
                    height: 248 //rect.height - 50
                    source: if (sceneThumbnail) "image://guids/" + sceneThumbnail //"qrc://app/images/icons8-arrow-left-filled-100.png"
                }

                FastBlur {
                    visible: wasPressed
                    anchors.fill: imageBg
                    source: imageBg
                    radius: 32
                }

                Image {
                    id: playSceneBtn
                    visible: view == "library" && wasPressed
                    enabled: view == "library" && wasPressed
                    anchors.centerIn: imageBg
                    sourceSize: Qt.size(108, 108)
                    source:  "qrc://app/icons/play-arrow.svg"
                }
            }

            Label {
                color: "#FFF"
                text: sceneTitle
                wrapMode: Label.WordWrap
                font.pixelSize: 34
                font.weight: Font.Bold
            }

            Label {
                color: "#AAA"
                text: sceneTitle
                wrapMode: Label.WordWrap
                font.pixelSize: 24
                font.weight: Font.Medium
            }
        }

        MouseArea {
            width: rect.width
            height: rect.height

            anchors.fill: parent
            anchors.centerIn: parent

            hoverEnabled: true

            onEntered: {
                rect.color = wasPressed ? "#006DEF" : Qt.rgba(1, 1, 1, .1) //"#4297ff"
                if (view == "library") {
                    methodHandler.selectMetadata(guid);
                } else {
                    methodHandler.emitMetadata(featured_image, sceneTitle, guid, sceneName, actual_guid);
                }
            }

            onPressed: {
                rect.color = "#006DEF"

                var theGuid;
                if (view == "library") {
                    theGuid = sceneGuid;
                    methodHandler.emitLastSelectedTileLibrary(sceneGuid);
                } else {
                    theGuid = actual_guid;
                    methodHandler.emitLastSelectedTileOnline(featured_image, sceneTitle, guid, sceneName, actual_guid);
                }

                methodHandler.emitSelectedTile(theGuid);
            }

            onReleased: {
                
            }

            onExited: {
                if (wasPressed) {
                    if (view == "library") {
                        methodHandler.selectMetadata(swipeManager.getLastSelectedTileGuid() ? swipeManager.getLastSelectedTileGuid() : "empty");
                    } else {
                        var a = swipeManager.getLastSelectedTileGuidList()[0]
                        var b = swipeManager.getLastSelectedTileGuidList()[1]
                        var c = swipeManager.getLastSelectedTileGuidList()[2]
                        var d = swipeManager.getLastSelectedTileGuidList()[3]
                        var e = swipeManager.getLastSelectedTileGuidList()[4]

                        methodHandler.emitMetadata(a, b, c, d, e);
                    }
                } else {
                    rect.color = "transparent"

                    if (view == "library") {
                        methodHandler.selectMetadata(swipeManager.getLastSelectedTileGuid() ? swipeManager.getLastSelectedTileGuid() : "empty")
                    } else {
                        
                        var a = swipeManager.getLastSelectedTileGuidList()[0]
                        var b = swipeManager.getLastSelectedTileGuidList()[1]
                        var c = swipeManager.getLastSelectedTileGuidList()[2]
                        var d = swipeManager.getLastSelectedTileGuidList()[3]
                        var e = swipeManager.getLastSelectedTileGuidList()[4]

                        if (a) {
                            methodHandler.emitMetadata(a, b, c, d, e)
                        } else {
                            methodHandler.selectMetadata("empty")  
                        }
                    }
                    // console.log("last selected was " + swipeManager.getLastSelectedTileGuid())
                }
            }

            // https://stackoverflow.com/questions/18135262/how-to-include-child-mouse-hover-events-in-the-parent-mousearea-using-qml
            MouseArea {
                id: playSceneButtonMouseArea
                hoverEnabled: view == "library" && true
                enabled: view == "library" && wasPressed
                width: playSceneBtn.width
                height: playSceneBtn.height

                anchors.centerIn: parent // works because this is the center of the parent mouse area

                onEntered: {
                    playSceneBtn.scale = 1.1
                    playSceneBtn.z = 1
                }

                onExited: {
                    playSceneBtn.scale = 1
                }

                onPressed: {
                    if (view == "library") {
                        methodHandler.doSomething(guid)
                    }
                }
            }
        }
    }

    Connections {
        // https://stackoverflow.com/q/52581687/996468
        target: swipeManager

        onSelectedTileGuid: {
            var theGuid;

            if (view == "library") theGuid = sceneGuid;
            if (view == "online") theGuid = actual_guid;

            if (g == theGuid) {
                wasPressed = true
                rect.color = "#006DEF"
            } else {
                wasPressed = false
                rect.color = "transparent"
            }
        }
    }
}
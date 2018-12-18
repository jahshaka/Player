import QtQuick 2.5
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

// TODO - https://doc.qt.io/qt-5/qtqml-cppintegration-interactqmlfromcpp.html

Rectangle {
    id: root
    width: 3840
    height: 2160

    color: "transparent"

    property string itemName: ""
    property string itemDateCreated: ""
    property bool metaVisible: false

    Rectangle {
        id: rectangle
        width: 960
        height: parent.height
        anchors.centerIn: parent

        color: Qt.rgba(.1, .1, .1, .2)
        border.width: 8
        border.color: Qt.rgba(.1, .1, .1, .02);

        TextMetrics {
            id: textMetrics
            text: "Metadata";
            font.pixelSize: 108;
            font.bold: true
        }

        Rectangle {
            id: rooto
            width: parent.width; height: 256
            color: "transparent"

            Row {
                id: row
                anchors.centerIn: parent
                anchors.topMargin: 32

                Rectangle {
                    width: textMetrics.width
                    height: textMetrics.height
                    color: "transparent"

                    Text {
                        id: textId
                        text: textMetrics.text
                        font: textMetrics.font
                        color: "white"
                    }

                    ShaderEffectSource {
                        id: effectSource
                        sourceItem: textId
                        anchors.centerIn: textId
                        width: 512
                        height: 396
                        sourceRect: Qt.rect(x, y, width, height)
                    }

                    FastBlur {
                        id: blur
                        anchors.fill: effectSource
                        source: effectSource
                        radius: 64
                    }
                }
            }
        }

        // This is very hacky at the moment, the swipeview takes up space from the header so we have
        // to offset the actual content from the top so the buttons can be pressed, clean this up please
        SwipeView {
            id: views
            currentIndex: 0
            anchors.fill: parent

            // ???
            // https://stackoverflow.com/questions/44366283/how-to-implement-swipeview-qtquick-2-5
            // https://stackoverflow.com/questions/49387541/qt-qml-swipeview-change-animation-transition-speed
            clip: true

            anchors.topMargin: 256

            Item {
                id: firstPage

                Column {
                    visible: !metaVisible
                    id: collhidden
                    anchors.centerIn: parent
                    spacing: 32

                    Text {
                        text: "Nothing selected...";
                        font.pixelSize: 96;
                        font.bold: true
                        color: "white"
                        opacity: 0.8
                    }
                }

                Column {
                    visible: metaVisible
                    id: coll
                    anchors.centerIn: parent
                    spacing: 32

                    Text {
                        text: itemName;
                        font.pixelSize: 96;
                        font.bold: true
                        color: "white"
                    }

                    Text {
                        text: "JahFX";
                        font.pixelSize: 96;
                        font.bold: true
                        color: "white"
                    }

                    Text {
                        text: itemDateCreated;
                        font.pixelSize: 96;
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }
    }

Connections{
        // https://stackoverflow.com/q/52581687/996468
        target: swipeManager
        onMetadata: {
            // sigh...
            if (str[0] == "empty") {
                metaVisible = false  
            } else {
                metaVisible = true

                itemName = str[0]
                itemDateCreated = str[1]
            }
        }
    }
}

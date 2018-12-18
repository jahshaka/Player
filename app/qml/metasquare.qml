import QtQuick 2.5
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

// TODO - https://doc.qt.io/qt-5/qtqml-cppintegration-interactqmlfromcpp.html

Rectangle {
    id: root
    width: 3840
    height: 2160

    color: "transparent"

    Rectangle {
        id: rectangle
        width: 960
        height: parent.height
        anchors.centerIn: parent

        color: Qt.rgba(.1, .1, .1, .2)
        // border.width: 8
        // border.color: Qt.rgba(.1, .1, .1, .03);

        TextMetrics {
            id: textMetrics
            text: "Recent";
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
                    id: coll
                    anchors.centerIn: parent
                    spacing: 32

                    Text {
                        text: "Recent Scenes";
                        font.pixelSize: 64;
                        font.bold: true
                        color: "white"
                        opacity: 0.4
                    }

                    Grid {
                        id: grid
                        columns: 1
                        rows: 3
                        spacing: 72

                        Repeater {
                            model: recentModel
                            // Base width (800)
                            // Base height (400) + Text height (72)
                            Rectangle {
                                height: 472 + 16
                                width: 856 + 16
                                color: "#1E1E1E"

                                property string nameid: name

                                Rectangle {
                                    height: 472
                                    width: 856
                                    color: "transparent"

                                    anchors.centerIn: parent

                                    Column {
                                        Rectangle {
                                            height: 400
                                            width: 856
                                            color: "transparent"

                                            Image {
                                                // make these values slightly smaller to emulate a border
                                                height: 400
                                                width: 856
                                                source: "image://guids/" + guid
                                                anchors.centerIn: parent
                                                // fillMode: Image.PreserveAspectFit
                                            }
                                        }

                                        Rectangle {
                                            height: 72
                                            width: 856
                                            color: "transparent"

                                            Text {
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: name;
                                                font.pixelSize: 56;
                                                font.bold: true
                                                color: "white"
                                            }
                                        }
                                    }
                                }

                                MouseArea {
                                    hoverEnabled: true
                                    width: parent.width
                                    height: parent.height
                                    onEntered: {
                                        parent.color = "#1F1F1F"
                                        parent.scale = 1.03
                                        parent.z = 1
                                    }

                                    onPressed: {
                                        parent.color = "#1A1A1A"
                                        methodHandler.doSomething(guid)
                                    }

                                    onReleased: parent.color = "#1E1E1E"

                                    onExited: {
                                        parent.color = "#1E1E1E"
                                        parent.scale = 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

import QtQuick 2.5
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

// TODO - https://doc.qt.io/qt-5/qtqml-cppintegration-interactqmlfromcpp.html

Rectangle {
    id: rootf
    width: 3840
    height: 2160

    color: "transparent"

    // Rectangle {
    //     id: rectangle
    //     width: 960
    //     height: parent.height
    //     anchors.centerIn: parent

    //     color: "blue"//Qt.rgba(.1, .1, .1, .02)

        Row {
            id: row
            spacing: 256
            anchors.centerIn: parent
            // anchors.topMargin: 32

            Rectangle {
                width: 1024
                height: 1024
                color: Qt.rgba(1, 1, 1, .4)
                border.color: Qt.rgba(.1, .1, .1, .8)
                border.width: 12
                radius: width * 0.5

                Image {
                    id: infoButton
                    anchors.centerIn: parent
                    width: 512
                    height: 512
                    source: "qrc://app/images/web-page-home.svg"
                }

                MouseArea {
                    anchors.centerIn: parent
                    hoverEnabled: true
                    width: 1024
                    height: 1024
                    onEntered: {
                        parent.color = Qt.rgba(1, 1, 1, .5)
                        infoButton.scale = 1.01
                    }

                    onPressed: {
                        parent.color = Qt.rgba(1, 1, 1, .3)
                        methodHandler.moveIndex(0)
                    }

                    onReleased: {

                    }

                    onExited: {
                        infoButton.scale = 1
                        parent.color = Qt.rgba(1, 1, 1, .4)
                    }
                }
            }

            Rectangle {
                width: 1024
                height: 1024
                color: Qt.rgba(1, 1, 1, .4)
                border.color: Qt.rgba(.1, .1, .1, .8)
                border.width: 12
                radius: width * 0.5

                Image {
                    id: infoButton1
                    anchors.centerIn: parent
                    width: 512
                    height: 512
                    source: "qrc://app/images/cloud-internet-symbol.svg"
                }

                MouseArea {
                    anchors.centerIn: parent
                    hoverEnabled: true
                    width: 1024
                    height: 1024
                    onEntered: {
                        parent.color = Qt.rgba(1, 1, 1, .5)
                        parent.scale = 1.01
                    }

                    onPressed: {
                        parent.color = Qt.rgba(1, 1, 1, .3)
                        methodHandler.moveIndex(1)
                    }

                    onReleased: {

                    }

                    onExited: {
                        parent.scale = 1
                        parent.color = Qt.rgba(1, 1, 1, 0.4)
                    }
                }
            }

            Rectangle {
                width: 1024
                height: 1024
                color: Qt.rgba(1, 1, 1, .4)
                border.color: Qt.rgba(.1, .1, .1, .8)
                border.width: 12
                radius: width * 0.5

                Image {
                    id: infoButton2
                    anchors.centerIn: parent
                    width: 512
                    height: 512
                    source: "qrc://app/images/add-square-button.svg"
                }

                MouseArea {
                    anchors.centerIn: parent
                    hoverEnabled: true
                    width: 1024
                    height: 1024
                    onEntered: {
                        parent.color = Qt.rgba(1, 1, 1, .5)
                        parent.scale = 1.01
                    }

                    onPressed: {
                        parent.color = Qt.rgba(1, 1, 1, .3)
                        methodHandler.moveIndex(2)
                    }

                    onReleased: {

                    }

                    onExited: {
                        parent.scale = 1
                        parent.color = Qt.rgba(1, 1, 1, 0.4)
                    }
                }
            }
        }
    // }
}

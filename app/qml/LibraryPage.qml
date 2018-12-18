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

    ColumnLayout {
        anchors.fill: parent
        id: col

        RowLayout{
            spacing: 0

            Item {
                Layout.fillWidth: true
            }

            GridView {
                width: 600 * 3
                height: 320 * 3

                // verticalLayoutDirection: Grid.TopToBottom
                // layoutDirection: Qt.LeftToRight
                flow: Grid.LeftToRight
                // anchors.centerIn: parent
                flickableDirection: Flickable.HorizontalFlick

                id: grid0
                clip: true
                interactive: false

                cellWidth: 600
                cellHeight: 320

                model: libraryModel

                delegate: SceneTile {
                    width: 600
                    height: 320
                    sceneTitle: name
                    sceneThumbnail: guid
                    view: "library"
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        RowLayout {
            Layout.fillWidth: true

            CustomButton {
                icon: "qrc://app/images/icons8-arrow-left-filled-100.png"
            }

            PageIndicator {
                id: control
                count: Math.ceil(grid0.count / 9)
                currentIndex: 2

                delegate: Rectangle {
                    implicitWidth: 32
                    implicitHeight: 32

                    radius: width / 2
                    color: "#fff" //"#336699"

                    opacity: index === control.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 100
                        }
                    }
                }
            }

            CustomButton {
                icon: "qrc://app/images/icons8-arrow-right-filled-100.png"
            }
        }
    }
}
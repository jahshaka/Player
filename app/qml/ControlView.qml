import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Pane {
    id: pane1
    Layout.fillHeight: true
    padding: 10

    property int itemsheight: 0
    
    implicitWidth: pane1.implicitWidth
    implicitHeight: pane1.implicitWidth

    clip: true

    background: Rectangle {
        color: "#111"
    }

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: accountInfo
            Layout.fillWidth: true
            implicitHeight: parent.height * .1
            color : "#111"

            RowLayout {
                
                Layout.fillWidth: true
                spacing: 5
                Rectangle {
                    id: image
                //     // implicitHeight: parent.height * 2
                //     // implicitWidth: parent.height
                    height: 64
                    width: 64
                    // Layout.fillWidth: true
                    // color: "red"

                    Image {
                        id: imageBg23
                        fillMode: Image.PreserveAspectFit
                        source: "qrc://app/images/empty_canvas.png"
                        anchors.centerIn: parent
                        anchors.fill: parent
                    }
                }

                Item {
                    implicitWidth: 5
                }

                ColumnLayout {
                    Layout.fillWidth: true

                    Label {
                        id:lab
                        text: "John Doe"
                        font.weight: Font.Medium
                        font.pixelSize: 28
                        color : "#FFF"
                    }

                    Pane {
                        padding: 0
                        implicitHeight: lab.height
                        implicitWidth: lab.width

                        Label {
                            text: "12/12/2018"
                            font.pixelSize: 18
                            color: "#AAA"
                            padding: 0
                            background: Rectangle {
                                // border.color: "#888"
                                // border.width: 1
                                color: "#00000000"
                            }
                        }

                        background: Rectangle {
                            border.color: "#fff"
                            border.width: 0
                            color: "#00000000"
                        }
                    }
                }
            }
        }

        // Item {
        //     implicitHeight: 15
        // }

        Rectangle {
            id: messages
            color: "#111"
            width: parent.width
            Layout.fillWidth: true
            implicitHeight: parent.height * .9

            Flickable {
                width: parent.width
                height: parent.height
                
                ColumnLayout {
                    id: messages2
                    Layout.fillWidth: true
                    width: parent.width

                    // ControlWidget { }
                }
            }
        }

        // Item {
        //     Layout.fillHeight: true
        // }
    }

    Connections {
        // https://stackoverflow.com/q/52581687/996468
        target: swipeManager
        onStartSomething: {
            // console.log("created " + id);
            var component;
            var sprite;
            component = Qt.createComponent("DownloadWidget.qml");

            // https://stackoverflow.com/a/18025964
            if (component.status != Component.Ready) {
                if (component.status == Component.Error)
                    console.debug("Error:"+ component.errorString() );
                return; // or maybe throw
            } else {
                sprite = component.createObject(messages2, {"worldID": name, "worldName": id}); //{"x": 0, "y": 0});
            }
        }
    }
}
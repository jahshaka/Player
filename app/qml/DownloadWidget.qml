import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Pane {
    id: pane34
    Layout.fillWidth: true
    // implicitHeight: 70
    padding: 8

    background: Rectangle {
        color: "#1E1E1E"
        // border.color: "#00333333"
        // border.width: 1
    }

    // property float downloadProgress: 0
    property int worldID: 0
    property string worldName: ""

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        Layout.fillWidth: true

        Rectangle {
            id: image
            color: "transparent"
            height: 32
            width: 32

            Image {
                id: imageBg231
                fillMode: Image.PreserveAspectFit
                source: "qrc://app/images/icons8-down-arrow-filled-100.png"
                anchors.centerIn: parent
                anchors.fill: parent
            }
        }

        Item {
            // implicitWidth: 5
        }

        ColumnLayout {
            Layout.fillWidth: true
            Label {
                id: title
                text: qsTr(worldName)
                //font.bold: true
                font.weight: Font.Medium
                font.pixelSize: Qt.application.font.pixelSize * 1.4
                color: "#fff"
            }

            Label {
                id: description
                text: qsTr("Downloading world...")
                color: "#ccc"
            }

            ProgressBar {
                id: proge
                value: 0.0

                // background: Rectangle {
                //     implicitWidth: parent.width
                //     implicitHeight: 12
                //     color: "white"
                //     // border.color: "gray"
                //     // border.width: 1
                //     // implicitWidth: 200
                //     // implicitHeight: 24
                // }

                // contentItem: Item {
                //     implicitWidth: parent.width
                //     implicitHeight: 12

                //     Rectangle {
                //         width: control.visualPosition * parent.width
                //         height: parent.height
                //         color: "#4297ff"
                //         // border.color: "steelblue"
                //     }
                // }
            }
        }

        // Item {
        //     Layout.fillWidth: true
        // }

        Rectangle {
            id: rect1
            property string icon: ""

            implicitHeight: 32
            implicitWidth: 32
            clip: true

            color: Qt.rgba(1, 0, 0, 0.34);

            anchors.margins: 0
            anchors.right: parent.right

            Image {
                source: "qrc://app/images/icons8-delete-filled-90.png"
                fillMode: Image.PreserveAspectFit  // ensure it fits
                anchors.centerIn: parent
                // width: 32
                // height: 32
                sourceSize.width: 16
                sourceSize.height: 16
            }

            MouseArea {
                width: parent.width
                height: parent.height

                anchors.fill: parent
                anchors.centerIn: parent

                hoverEnabled: true

                onEntered: {
                    rect1.color = Qt.rgba(1, 0, 0, 0.54);
                }

                onPressed: {
                    // http://doc.qt.io/archives/qt-4.8/qdeclarativedynamicobjects.html
                    rect1.color = Qt.rgba(1, 0, 0, 0.30);
                    methodHandler.cancelDownload(worldID);
                    pane34.destroy(0);
                }

                onReleased: {
                    rect1.color = Qt.rgba(1, 0, 0, 0.34);   
                }

                onExited: {
                    rect1.color = Qt.rgba(1, 0, 0, 0.34);
                }
            }
        }

        // Item {
        //     // implicitWidth: 5
        // }
    }

    Connections {
        // https://stackoverflow.com/q/52581687/996468
        target: swipeManager
        onDownloadProgress: {
            // downloadProgress = prog
            if (id == worldID) {
                proge.value = prog;
            }
        }
    }
}
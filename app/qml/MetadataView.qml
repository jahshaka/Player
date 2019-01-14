import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Pane {
    id: pane
    Layout.fillHeight: true

    property string itemGuid: ""
    property string itemName: ""
    property string itemSceneName: ""
    property string actualGuid: ""
    property string itemTitle: ""
    property bool metaVisible: false
    
    implicitWidth: pane.implicitWidth
    implicitHeight: pane.implicitWidth

    background: Rectangle {
        color : "#111"
        radius: 12
    }

    anchors.margins: 0
    padding: 0

    ColumnLayout {
        anchors.margins: 0
        anchors.fill: parent
        Layout.margins: 0

        Rectangle {
            anchors.margins: 0
    
            id: thumbnail
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "transparent"

            implicitWidth: parent.width * .3
            implicitHeight: parent.height * .4

            Image {
                id: imageBg2
                // make these values slightly smaller to emulate a border
                height: parent.height
                width: parent.width
                source: if (itemGuid) {
                            return "image://guids/" + itemGuid;
                        } else {
                            return "qrc://app/images/empty_canvas.png"
                        }
                anchors.centerIn: parent

                Button {
                    id: but
                    visible: itemGuid && itemTitle != "library"
                    text: "Download"
                    font.weight: Font.Medium
                    font.pixelSize: 24

                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 8

                    MouseArea {
                        width: but.width
                        height: but.height
                        anchors.fill: but
                        anchors.centerIn: but
                        hoverEnabled: true
                        onPressed: {
                            methodHandler.startSomething(itemTitle, itemName)
                            //console.log("Downloading " + "https://www.jahfx.com/download/" + itemSceneName + "/?wpdmdl=" + itemTitle)
                            methodHandler.startDownload("https://www.jahfx.com/download/" + itemSceneName + "/?wpdmdl=" + itemTitle, actualGuid)
                        }
                    }
                }
            }


        }

        // Item {
        //     implicitHeight: 10
        // }

        RowLayout {
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            Label {
                id: text1
                visible: itemGuid
                text: qsTr("%1 \n%2").arg(itemName).arg("JahFX")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
                color : "white"
                font.weight: Font.Bold
                font.pixelSize: 24
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Pane {
            Layout.fillWidth: true
            Layout.fillHeight: true

            implicitHeight: parent.height * .4
            implicitWidth: parent.width

            background: Rectangle {
                color: "#000"
            }

            TextArea {
                id: name
                visible: itemGuid
                text: qsTr("The scene description will go here. Words that describe the scene will go here.")
                color: "#fff"
                wrapMode: TextArea.Wrap
                clip: true
                width: parent.width
                padding: 0
                font.pixelSize: 24
            }

            TextArea {
                visible: !itemGuid
                text: qsTr("Nothing selected...")
                clip: true
                width: parent.width
                padding: 32
                color: "gray"
                anchors.centerIn: parent
                font.pixelSize: 24
                horizontalAlignment: TextEdit.AlignHCenter
            }
        }

        // Item {
        //     Layout.fillHeight: true
        // }
    }

    Connections {
        // https://stackoverflow.com/q/52581687/996468
        target: swipeManager

        onMetadata: {
            // console.log(str[0])
            // sigh...
            if (str[0] == "empty") {
                metaVisible = false 

                // null it all
                itemGuid = ""

            } else {
                metaVisible = true

                // console.log("testing")

                itemGuid = str[0]
                itemName = str[1]
                itemTitle = str[2]
                itemSceneName = str[3]
                actualGuid = str[4]
            }
        }
    }
}

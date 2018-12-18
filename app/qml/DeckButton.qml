import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Pane {
    id: tpane

    property string imageString: ""
    property string val: ""
    property bool rightBorderVal: true
    property string backgroundColor: ""
    property int index: 0
    property int currentIndex: 0
    property bool selectable: true

    Layout.fillHeight: true
    Layout.fillWidth: true

    background: Rectangle {
        border.color: "#333"
        border.width: 0
        color: if (backgroundColor == "") {
                    if (index == gpane3.defaultIndex) return "#4297ff";
                    else return "#111";
                } else {
                    return backgroundColor;
                }
    }

    padding: 30

    MouseArea {
        width: parent.width
        height: parent.height

        anchors.fill: parent
        anchors.centerIn: parent

        hoverEnabled: selectable

        onEntered: {
            backgroundColor = "#69a9f7"
        }

        onPressed: {
            backgroundColor = "#4297ff"
            methodHandler.moveIndex(index)
        }

        onReleased: {
        }

        onExited: {
            if (tpane.currentIndex == index) {
                backgroundColor =  "#4297ff"
            } else {
                backgroundColor =  "#111" 
            }
        }
    }

    Connections {
        target: swipeManager
        onSetIndex: {
            tpane.currentIndex = index
            if (tpane.index == index) {
                tpane.backgroundColor = "#4297ff"
            }
            else {
                tpane.backgroundColor = "#111"
            }
        }
    }

    ColumnLayout{
        anchors.fill: parent
        Image {
            id: image
            fillMode: Image.PreserveAspectFit
            source: imageString
            opacity: selectable ? 1.0 : 0.1
            sourceSize.width: parent.height/2
            sourceSize.height: parent.height/2
            horizontalAlignment: Image.AlignHCenter
            Layout.fillWidth: true

            layer.enabled: true

        }

        Item {
            implicitHeight: 5
        }

        Label {
        //    anchors.centerIn: parent
            id:textVal
            text : val
            Layout.fillWidth: true
            color: "#eeeeef"
            opacity: selectable ? 1.0 : 0.1
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Qt.application.font.pixelSize * 2
            font.weight: Font.Bold
        }

        DropShadow {
            anchors.fill: image
            horizontalOffset: 0
            verticalOffset: 0
            radius: 14.0
            samples: 17
            color: "#99000000"
            opacity: selectable ? 1.0 : 0.1
            source: image
        }
    }

    Rectangle{
        id:rightBorder
        implicitWidth: 2
        implicitHeight: parent.height * .7
        color: "#333"

        visible: rightBorderVal
        anchors{
            bottom: parent.bottom
            top: parent.top
            right: parent.right
            rightMargin: -padding
        }
    }
}
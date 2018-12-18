import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Rectangle {
    property string icon: ""

    Layout.fillWidth: true

    implicitHeight: 72
    implicitWidth: 72
    clip: true

    anchors.margins: 0

    Image {
        source: icon
        fillMode: Image.PreserveAspectFit  // ensure it fits
        anchors.centerIn: parent
        width: 64
        height: 64
        // sourceSize.width: parent.width
        // sourceSize.height: parent.height
    }

    color: "transparent"
}

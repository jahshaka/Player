import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2

Pane {
    id: mainView
    
    Layout.fillHeight: true
    Layout.fillWidth: true

    width: 1920
    height: 1080

    background: Rectangle{
        color: "#111"
    }

        // This is very hacky at the moment, the swipeview takes up space from the header so we have
    // to offset the actual content from the top so the buttons can be pressed, clean this up please
    SwipeView {
        id: views
        currentIndex: 0
        anchors.fill: parent

        interactive: false // maybe change this back later

        // ???
        // https://stackoverflow.com/questions/44366283/how-to-implement-swipeview-qtquick-2-5
        // https://stackoverflow.com/questions/49387541/qt-qml-swipeview-change-animation-transition-speed
        clip: true

        // anchors.topMargin: 256

        LibraryPage {

        }

        OnlinePage {

        }

        Item {}
        Item {}
        Item {}
    }

    Connections{
        // https://stackoverflow.com/q/52581687/996468
        target: swipeManager

        onSetIndex: {
            views.currentIndex = index
            // console.log(index)
        }

        // onToRightRight: {
        //     views.currentIndex = 2
        //     // tabName = "Import"
        // }
        
        // onToRight: {
        //     // if(views.currentIndex + 1 != views.count) views.currentIndex += 1
        //     views.currentIndex = 1
        //     // tabName = "Online"
        // }
        // onToLeft: {
        //     // if(views.currentIndex != 0) views.currentIndex -= 1
        //     views.currentIndex = 0
        //     // tabName = "Library"
        // }
    }
}
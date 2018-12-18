import QtQuick 2.5
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0
import Qt.labs.folderlistmodel 2.2

// TODO - https://doc.qt.io/qt-5/qtqml-cppintegration-interactqmlfromcpp.html

Rectangle {
    id: root
    width: 3840
    height: 2160

    color: Qt.rgba(.1, .1, .1, .2)
    // border.width: 8
    // border.color: Qt.rgba(.1, .1, .1, .03);

    property string tabName: "Library"

    Rectangle {
        id: rooto
        width: parent.width; height: 256
        color: "transparent"

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 512
            anchors.topMargin: 32

            Rectangle {
                width: 512
                height: 128
                color: "transparent"
                id: rect

                Text {
                    id: textId
                    text: tabName;
                    // anchors.centerIn: parent.top.left;
                    // anchors.bottom: parent.bottom
                    font.pixelSize: 116;
                    font.bold: true
                    color: Qt.rgba(1, 1, 1, 0.9)

                    // MouseArea {
                    //     hoverEnabled: true
                    //     width: parent.width
                    //     height: parent.height
                    //     onEntered: {
                    //         parent.color = "yellow"
                    //         parent.z = 1
                    //     }

                    //     onPressed: {
                    //         parent.color = "white"
                    //         views.setCurrentIndex(0)
                    //     }

                    //     onReleased: parent.color = Qt.rgba(1, 1, 1, 0.9)

                    //     onExited: {
                    //         parent.color = Qt.rgba(1, 1, 1, 0.9)
                    //         parent.scale = 1
                    //     }
                    // }
                }

                ShaderEffectSource {
                    id: effectSource
                    sourceItem: textId
                    anchors.centerIn: textId
                    width: 512
                    height: 396
                    sourceRect: Qt.rect(x,y, width, height)
                }

                FastBlur {
                    id: blur
                    anchors.fill: effectSource
                    source: effectSource
                    radius: 64
                }
            }

            // Rectangle {
            //     width: 512
            //     height: 128
            //     color: "transparent"
            
            //     Text {
            //         id: textId2
            //         text: "Online";
            //         // anchors.centerIn: parent.top.right;
            //         // anchors.bottom: parent.bottom
            //         font.pixelSize: 108;
            //         font.bold: true
            //         color: "white"

            //         MouseArea {
            //             hoverEnabled: true
            //             width: parent.width
            //             height: parent.height
            //             onEntered: {
            //                 parent.color = "yellow"
            //                 parent.z = 1
            //             }

            //             onPressed: {
            //                 parent.color = "#3498db"
            //                 views.setCurrentIndex(1)
            //             }

            //             onReleased: parent.color = "white"

            //             onExited: {
            //                 parent.color = "white"
            //                 parent.scale = 1
            //             }
            //         }
            //     }

            //     ShaderEffectSource {
            //         id: effectSource2
            //         sourceItem: textId2
            //         anchors.centerIn: textId2
            //         width: 512
            //         height: 396
            //         sourceRect: Qt.rect(x,y, width, height)
            //     }

            //     FastBlur {
            //         id: blur2
            //         anchors.fill: effectSource2
            //         source: effectSource2
            //         radius: 64
            //     }
            // }
        }
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

        anchors.topMargin: 256

        Item {
            id: firstPage

            Column {
                id: coll
                anchors.centerIn: parent
                spacing: 32

                // Text {
                //     text: "Recent Scenes";
                //     font.pixelSize: 64;
                //     font.bold: true
                //     color: "white"
                //     opacity: 0.4
                // }

                Grid {
                    id: grid
                    columns: 4
                    rows: 3
                    spacing: 72

                    Repeater {
                        id: firstRep
                        model: modelo
                        // Base width (800)
                        // Base height (400) + Text height (72)
                        delegate: Rectangle {
                            height: 472 + 16
                            width: 856 + 16
                            color: "#1E1E1E"

                            property string nameid: name
                            property bool metadataVisible: false

                            Rectangle {
                                height: 472
                                width: 856
                                color: "#1E1E1E"

                                anchors.centerIn: parent

                                Column {
                                    Rectangle {
                                        height: 400
                                        width: 856
                                        color: "transparent"

                                        Image {
                                            id: imageBg
                                            // make these values slightly smaller to emulate a border
                                            height: 400
                                            width: 856
                                            source: "image://guids/" + guid
                                            anchors.centerIn: parent
                                            // fillMode: Image.PreserveAspectFit

                                            Row {
                                                visible: false
                                                
                                                width: (parent.width / 2)
                                                height: 132
                                                anchors.centerIn: parent
                                                spacing: 0
                                                
                                                Rectangle {
                                                    id: playLibBtn
                                                    visible: true
                                                    width: (parent.width) - 96
                                                    height: 132
                                                    color: "#2ecc71"
                                                    opacity: 0.8

                                                    Text {
                                                        anchors.centerIn: parent
                                                        font.pixelSize: 64;
                                                        font.bold: true
                                                        color: "white"
                                                        text: "Play"
                                                    }
                                                }

                                                Rectangle {
                                                    id: delLibBtn
                                                    visible: true
                                                    width: 96
                                                    height: 132
                                                    color: "#e74c3c"
                                                    opacity: 0.8

                                                    Text {
                                                        anchors.centerIn: parent
                                                        font.pixelSize: 64;
                                                        font.bold: true
                                                        color: "white"
                                                        text: "X"
                                                    }
                                                }
                                            }
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
                                id: libMouseArea
                                hoverEnabled: true
                                width: parent.width
                                height: parent.height
                                onEntered: {
                                    parent.color = "#3498db"
                                    parent.scale = 1.03
                                    parent.z = 1
                                    methodHandler.selectMetadata(guid)
                                }

                                onPressed: {
                                    parent.color = "#1A1A1A"
                                    methodHandler.doSomething(guid)
                                }

                                onReleased: parent.color = "#1E1E1E"

                                onExited: {
                                    parent.color = "#1E1E1E"
                                    parent.scale = 1
                                    methodHandler.selectMetadata("empty")
                                }
                            }
                        }
                    }
                }

                // This is the custom pagintor bar
                // Rectangle {
                //     width: parent.width / 2
                //     height: 128
                //     color: "transparent"
                //     anchors.horizontalCenter: parent.horizontalCenter

                //     id: lvw
                //     property variant mdls: [paginationModel0, paginationModel1]

                //     // look at this later
                //     // https://stackoverflow.com/questions/32298215/trying-to-center-items-programmatically-in-a-listview
                //     ListView {
                //         anchors.centerIn: parent
                //         visible: (paginationCount - 1)

                //         width: (paginationCount * 100)
                //         height: 100
                //         orientation: Qt.Horizontal

                //         model: paginationCount
                //         delegate: Rectangle {
                //             width: 100
                //             height: 100
                //             color: Qt.rgba(.1, .1, .1, .4)//"transparent"

                //             Text {
                //                 text: index + 1 // we want indexing from 1
                //                 font.pixelSize: 80
                //                 font.bold: true
                //                 color: "white"
                //                 anchors.centerIn: parent

                //                 MouseArea {
                //                     width: parent.width
                //                     height: parent.height
                //                     anchors.centerIn: parent
                //                     onPressed: {
                //                         firstRep.model = lvw.mdls[index]
                //                     }
                //                 }
                //             }
                //         }
                //     }
                // }
            }
        }

        Item {
            id: onlineSection

            Column {
                id: onlineColumn
                anchors.centerIn: parent
                spacing: 32

                // Text {
                //     id: onlineSubText
                //     text: "Scenes Available";
                //     font.pixelSize: 64;
                //     font.bold: true
                //     color: "white"
                //     opacity: 0.4
                // }

                Grid {
                    id: onlineGrid
                    columns: 4
                    rows: 3
                    spacing: 72

                    Repeater {
                        model: onlineModel
                        // Base width (800)
                        // Base height (400) + Text height (72)
                        delegate: Rectangle {
                            id: onlineCellRect
                            height: 472 + 16
                            width: 856 + 16
                            color: "#1E1E1E"

                            // property string nameid: name
                            property bool downloadButtonVisible: false

                            Rectangle {
                                id: onlineCellContent
                                height: 472
                                width: 856
                                color: "transparent"

                                anchors.centerIn: parent

                                Column {
                                    Rectangle {
                                        id: onlineImageContent
                                        height: 400
                                        width: 856
                                        color: "transparent"
                                
                                        Image {
                                            id: onlineImage
                                            height: 400
                                            width: 856
                                            source: "image://guids/" + featured_image
                                            anchors.centerIn: parent
                                            // fillMode: Image.PreserveAspectFit
                                        
                                            Rectangle {
                                                property string downloadProgress: download_progress

                                                id: onlineDownloadState
                                                visible: false
                                                width: parent.width / 1.2
                                                height: 132
                                                color: "#3498db"
                                                opacity: 0.8
                                                anchors.centerIn: parent

                                                Text {
                                                    id: downloadProgressText
                                                    anchors.centerIn: parent
                                                    font.pixelSize: 64;
                                                    font.bold: true
                                                    color: "white"
                                                    text: qsTr("Downloaded %1").arg(download_progress)
                                                }

                                                onDownloadProgressChanged: {
                                                    console.log(download_progress)
                                                    if (download_progress == "100.0%") {
                                                        onlineDownloadState.visible = false
                                                    }
                                                }
                                            }

                                            Rectangle {
                                                id: inLibrarySt
                                                visible: in_library
                                                width: parent.width / 2
                                                height: 132
                                                color: "#2ecc71"
                                                opacity: 0.8
                                                anchors.centerIn: parent

                                                Text {
                                                    anchors.centerIn: parent
                                                    font.pixelSize: 64;
                                                    font.bold: true
                                                    color: "white"
                                                    text: "Play"
                                                }
                                            }

                                            Rectangle {
                                                id: onlineDownloadButton
                                                width: parent.width / 2
                                                height: 132
                                                color: "#3498db"
                                                opacity: 0.8
                                                anchors.centerIn: parent
                                                visible: downloadButtonVisible

                                                Text {
                                                    id: onlineDownloadButtonText
                                                    anchors.centerIn: parent
                                                    font.pixelSize: 64;
                                                    font.bold: true
                                                    color: "white"
                                                    text: "Download"
                                                }
                                            }
                                        }
                                    }

                                    Rectangle {
                                        id: onlineTextContent
                                        height: 72
                                        width: 856
                                        color: "transparent"

                                        Text {
                                            id: onlineContentText
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
                                id: onlineCellContentMouseArea
                                hoverEnabled: true
                                width: parent.width
                                height: parent.height
                                onEntered: {
                                    parent.color = "#1F1F1F"
                                    parent.scale = 1.03
                                    parent.z = 1
                                    downloadButtonVisible = !in_library
                                }

                                onPressed: {
                                    parent.color = "#1A1A1A"
                                    methodHandler.doSomething(model.modelData.guid)
                                }

                                onReleased: parent.color = "#1E1E1E"

                                onExited: {
                                    parent.color = "#1E1E1E"
                                    parent.scale = 1
                                    downloadButtonVisible = false
                                }

                                // https://stackoverflow.com/questions/18135262/how-to-include-child-mouse-hover-events-in-the-parent-mousearea-using-qml
                                MouseArea {
                                    id: onlineDownloadButtonMouseArea
                                    hoverEnabled: true
                                    width: onlineDownloadButton.width
                                    height: onlineDownloadButton.height

                                    anchors.centerIn: parent // works because this is the center of the parent mouse area

                                    onEntered: {
                                        onlineDownloadButton.color = "#2980b9"
                                    }

                                    onExited: {
                                        onlineDownloadButton.color = "#3498db"
                                    }

                                    onPressed: {
                                        console.log(title + guid)
                                        methodHandler.startDownload("https://www.jahfx.com/download/" + title + "/?wpdmdl=" + guid)
                                        onlineDownloadState.visible = true
                                        onlineDownloadButton.visible = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: browserPage

            Item {
                anchors.fill: parent
                path: "file:///home/" // let's start with the Home folder

                id: browser
                property alias path: view.path
                // width: 300
                // height: 200
                ListView {
                    id: view
                    property var colors: ["white","#E0FFE0","white","#EEEEFF" ]
                    property string path

                    anchors.fill: parent
                    model: FolderListModel {
                        id: folder
                        folder: view.path
                        nameFilters: [ "*.zip" ]
                    }

                    delegate: Rectangle {
                        id:delegate
                        width: view.width
                        height:34 * 3.5
                        color: view.colors[index & 3]
                        Row { anchors.fill: parent
                            Image {
                                id: icon
                                width: delegate.height - 2
                                height:width
                                source: "image://guids/" + filePath
                            }

                            Text {
                                font.pixelSize: 72
                                text: fileName
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        MouseArea {
                            id:mouseArea
                            anchors.fill: parent
                            onClicked: fileIsDir ? view.path = fileURL : methodHandler.importWorld(fileURL)//Qt.openUrlExternally(fileURL)
                        }
                    }

                    headerPositioning: ListView.OverlayHeader
                    header: Rectangle {
                        width: browser.width
                        height: 34 * 3.5
                        color: "#1E1E1E"
                        z:2
                        Row {
                            anchors.fill: parent
                            Button {
                                width: 32 * 10
                                height: parent.height
                                text: "Go Up One"
                                font.pixelSize: 72
                                onClicked: view.path = folder.parentFolder
                            }

                            Text {
                                font.pixelSize: 72
                                text: view.path
                                color: "white"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }

                    footerPositioning: ListView.OverlayHeader
                    footer: Rectangle {
                        width: browser.width
                        height: 34 * 3.5
                        color: "#1E1E1E"
                        z:2
                        Row {
                            anchors.fill: parent
                            Text {
                                font.pixelSize: 72
                                color: "white"
                                text: "[ " + folder.count + " Files ]"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
        }
    }

    Connections{
        // https://stackoverflow.com/q/52581687/996468
        target: swipeManager

        onToRightRight: {
            views.currentIndex = 2
            tabName = "Import"
        }
        
        onToRight: {
            // if(views.currentIndex + 1 != views.count) views.currentIndex += 1
            views.currentIndex = 1
            tabName = "Online"
        }
        onToLeft: {
            // if(views.currentIndex != 0) views.currentIndex -= 1
            views.currentIndex = 0
            tabName = "Library"
        }
    }
}

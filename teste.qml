import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        RowLayout {
            id: layout
            spacing: 2

            property var itemWidth: layout.width/layout.visibleChildren.length

            DockItem {
                id: dockItem
                child: blueRect
                Layout.fillWidth: layout.itemWidth
                Layout.fillHeight: true
                Rectangle {
                    id: blueRect
                    anchors.fill: parent
                    color: "blue"
                }
            }

            DockItem {
                id: dockItem2
                child: blueRect2
                Layout.fillWidth: layout.itemWidth
                Layout.fillHeight: true
                
                Rectangle {
                    id: blueRect2
                    anchors.fill: parent
                    color: "red"
                }
            }
        }
        
        RowLayout {
            id: layout2
            spacing: 2
            property var itemWidth: layout.width/layout.visibleChildren.length
            
            DockItem {
                id: dockItem3
                child: blueRect3
                Layout.fillWidth: layout.itemWidth
                Layout.fillHeight: true
                Rectangle {
                    id: blueRect3
                    anchors.fill: parent
                    color: "green"
                }
            }
            DockItem {
                id: dockItem4
                child: blueRect4
                Layout.fillWidth: layout.itemWidth
                Layout.fillHeight: true
                
                Rectangle {
                    id: blueRect4
                    anchors.fill: parent
                    color: "pink"
                }
            }
        }
    }
}

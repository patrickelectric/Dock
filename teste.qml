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
                id: dockItemBlue
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
                id: dockItemRed
                child: redRect
                Layout.fillWidth: layout.itemWidth
                Layout.fillHeight: true

                Rectangle {
                    id: redRect
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
                id: dockItemGreen
                child: greenRect
                Layout.fillWidth: layout.itemWidth
                Layout.fillHeight: true
                Rectangle {
                    id: greenRect
                    anchors.fill: parent
                    color: "green"
                }
            }
            DockItem {
                id: dockItemPink
                child: pinkRect
                Layout.fillWidth: layout.itemWidth
                Layout.fillHeight: true

                Rectangle {
                    id: pinkRect
                    anchors.fill: parent
                    color: "pink"
                }
            }
        }
    }
}

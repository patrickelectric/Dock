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

    DockItem {
        id: dockItem
        child: blueRect

        Rectangle {
            id: blueRect
            width: 50; height: 50
            x: 10; y: 10;
            color: "blue"
        }
    }
}

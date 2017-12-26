import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtQuick.Controls.Styles 1.4

Item {
    id: dock
    property var child
    property var childParent
    property var title

    state: "docked"

    Component.onCompleted: {
        childParent = child.parent
    }

    Window {
        id: rectWindow
        width: 100;
        height: 100;
        visible: false;
        flags: Qt.FramelessWindowHint

        Rectangle {
            id: greenRect
            anchors.fill: parent
            width: parent.width
            height: parent.height
            color:  Qt.rgba(0.7,0.7,0.7,0.6)
            radius: 15
            border.color: Qt.rgba(0.7,0.7,0.7,0.6)
            border.width: 10
            antialiasing: true
        }

        onClosing: {
            dock.state = "docked"
        }

        Button {
            iconSource:"ratio.png"
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            style: ButtonStyle {
                background: Rectangle {
                    color: "#00ffffff"
                    implicitWidth: 10
                    implicitHeight: 10
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.SizeFDiagCursor
                property variant previousPosition
                onPressed: {
                    previousPosition = Qt.point(mouseX, mouseY)
                }
                onPositionChanged: {
                    if (pressedButtons == Qt.LeftButton) {
                        var dx = mouseX - previousPosition.x
                        var dy = mouseY - previousPosition.y
                        rectWindow.width = rectWindow.width + dx
                        rectWindow.height = rectWindow.height + dy
                    }
                }
            }
        }

        Text {
            text: title
            anchors.left: parent.left
            anchors.top: parent.top
        }

        Button {
            iconSource:"move.png"
            anchors.right: parent.right
            anchors.top: parent.top

            style: ButtonStyle {
                background: Rectangle {
                    color: "#00ffffff"
                    implicitWidth: 10
                    implicitHeight: 10
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.OpenHandCursor
                property variant previousPosition
                onPressed: {
                    cursorShape = Qt.ClosedHandCursor
                    previousPosition = Qt.point(mouseX, mouseY)
                }
                onReleased: {
                    cursorShape = Qt.OpenHandCursor
                }
                onPositionChanged: {
                    if (pressedButtons == Qt.LeftButton) {
                        var dx = mouseX - previousPosition.x
                        var dy = mouseY - previousPosition.y
                        rectWindow.x += dx
                        rectWindow.y += dy
                    }
                }
            }
        }

        Button {
            iconSource:"dashboard.png"
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            style: ButtonStyle {
                background: Rectangle {
                    color: "#00ffffff"
                    implicitWidth: 10
                    implicitHeight: 10
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.OpenHandCursor
                property variant previousPosition
                onPressed: {
                    rectWindow.close()
                }
            }
        }
    }

    states: [
        State {
            name: "undocked"
            ParentChange { target: child; parent: greenRect; x: 0; y: 0 }
            PropertyChanges {
                target: blueRect
                visible: false
            }
            PropertyChanges {
                target: dock
                Layout.maximumHeight : 0
                Layout.maximumWidth : 0
            }
        },
        State {
            name: "docked"
            ParentChange { target: child; parent: dock; x: 0; y: 0 }
            PropertyChanges {
                target: blueRect
                visible: true
                width: child.width
                height: child.height
                x: child.x; y: child.y;
            }
            PropertyChanges {
                target: dock
            }
        }
    ]

    Text {
        text: title
        z: dock.z+1
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Item {
        width: 200; height: 100

        Rectangle {
            id: blueRect
            width: child.width
            height: child.height
            x: child.x; y: child.y;
            color: "#55121212"

            property point beginDrag

            MouseArea {
                anchors.fill: parent;
                acceptedButtons: Qt.RightButton
                onClicked: {
                    if(mouse.button & Qt.RightButton) {
                        dock.state = "undocked"
                        rectWindow.visible = true
                    }
                }
            }

            onXChanged: {
                beginDrag.x = x
            }

            onYChanged: {
                beginDrag.y = y
            }

            MouseArea {
                anchors.fill: parent
                drag.target: parent
                acceptedButtons: Qt.LeftButton
                onPressed: {
                    blueRect.beginDrag = Qt.point(blueRect.x, blueRect.y);
                    child.x = blueRect.x
                    child.y = blueRect.y
                }
                onReleased: {
                    blueRect.x = blueRect.beginDrag.x
                    blueRect.y = blueRect.beginDrag.y

                    // Check if window have only one dock
                    if (countDocks(childParent) < 2) {
                        blueRect.x = child.x
                        blueRect.y = child.y
                        return;
                    }

                    var l = mapToGlobal(mouse.x, mouse.y)
                    if(l.x < window.x || l.x > window.width + window.x ||
                        l.y < window.y || l.y > window.height + window.y) {
                        rectWindow.x = l.x
                        rectWindow.y = l.y
                        dock.state = "undocked"
                        rectWindow.visible = true
                    }

                    blueRect.x = child.x
                    blueRect.y = child.y
                }
            }
        }
    }

    function countDocks(item) {
        if(item.parent != null) {
            return countDocks(item.parent)
        }
        return countDocksInMaster(item, 0)
    }

    function getType(item) {
        var name = String(item).split('(')[0]
        if (name.indexOf("_QML") !== -1) {
            name = name.split("_QML")[0]
        }
        return name
    }

    function countDocksInMaster(item, count) {
        count = count === undefined ? 0 : count
        if (getType(item) === "DockItem") {
            if (item.state == 'docked') {
                count++
            }
        }

        var dockItem = null
        for (var i = 0; i < item.children.length; i++) {
            count = countDocksInMaster(item.children[i], count)
            if (dockItem != null) {
                return count
            }
        }
        return count
    }
}
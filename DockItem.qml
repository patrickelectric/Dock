import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

Item {
    property var child

    Window {
        id: rectWindow
        width: 100;
        height: 100;
        visible: false;
        Rectangle {
            id: greenRect
            anchors.fill: parent
        }

        onClosing: {
            blueRect.state = "docked"
        }

    }

    Item {
        width: 200; height: 100

        Rectangle {
            id: redRect
            anchors.fill: parent
        }

        Rectangle {
            id: blueRect
            width: 50; height: 50
            x: 10; y: 10;
            color: "blue"

            property point beginDrag

            states: [
                State {
                    name: "undocked"
                    ParentChange { target: blueRect; parent: greenRect; x: 0; y: 0 }
                },
                State {
                    name: "docked"
                    ParentChange { target: blueRect; parent: redRect; x: 0; y: 0 }
                }
            ]

            MouseArea {
                anchors.fill: parent;
                acceptedButtons: Qt.RightButton
                onClicked: {
                    if(mouse.button & Qt.RightButton) {
                        blueRect.state = "undocked"
                        rectWindow.visible = true
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                drag.target: parent
                onPressed: {
                    blueRect.beginDrag = Qt.point(blueRect.x, blueRect.y);
                }
                onReleased: {
                    print(blueRect.x, blueRect.y)

                    if(blueRect.x < 0 || blueRect.x > window.x ||
                        blueRect.y < 0 || blueRect.y > window.y) {

                        console.log("X: " + window.x + " y: " + window.y)
                        rectWindow.x = window.x + blueRect.x
                        rectWindow.y = window.y + blueRect.y
                        blueRect.state = "undocked"
                        rectWindow.visible = true
                    }

                }

            }
        }
    }
}
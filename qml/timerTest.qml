import QtQuick
import QtQuick.Controls


ApplicationWindow {
    visible: true
    height: 300
    width: 500

    menuBar: Text {text: "menu bar"}

    header: Text {text: "header"}

    footer: Text {text: "footer"}

    Rectangle {
        id: rects
        color: "red"
        height: parent.height - 20
        width: parent.width - 20
        // anchors.horizontalCenter: parent.left
        anchors.left: parent.left

        transitions: Transition{AnchorAnimation{duration:300}}

        states: State {
            name: "right"
            AnchorChanges {
                target: rects
                anchors.left: null

                anchors.right: rects.parent.right
            }
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: timerTrig()

            function timerTrig() {
                let isLeft = rects.anchors.left == rects.parent.left;
                rects.state = isLeft ? "right" : null
            }
        }

        
        

        Text {
            text: "body"
        }


    }
}
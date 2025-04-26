import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import InstrumentLib

MenuBar {
    Material.background: Global.colors.Surface2
    font: Global.fonts.Menu
    height: Global.menuBarHeight

    Menu {
        Material.roundedScale: Material.NotRounded
        Material.foreground: Global.colors.Text
        Material.background: Global.colors.Surface2
        title: "File"
        Action { 
            text: "Save"
            onTriggered: configLoader.save()
        }
        Action { text: "New Section" } //TODO
    }
    
    Menu {
        Material.roundedScale: Material.NotRounded
        Material.foreground: Global.colors.Text
        Material.background: Global.colors.Surface2
        title: "View"
        Menu {
            Material.roundedScale: Material.NotRounded
            Material.foreground: Global.colors.Text
            Material.background: Global.colors.Surface2
            title: "Tile Size"          //TODO
            Action { text: "Small" }
            Action { text: "Medium" }
            Action { text: "Large" }
        }
    }

    delegate: MenuBarItem {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        contentItem: Text {
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            text: parent.text
            color: Global.colors.Text
        }
    }


}
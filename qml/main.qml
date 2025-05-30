import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import InstrumentLib

ApplicationWindow {

    ConfigLoader{
        id: configLoader
        apps: app.apps
    }
    Shortcut {
        sequence: StandardKey.Save
        onActivated: configLoader.save()
    }

    Material.theme: Material.Dark
    Material.foreground: Material.Teal
    Material.primary: Material.Red
    Material.accent: Material.Orange
    property list<SectionModel> gridSections
    property var apps

    visible: true
    height: Global.height
    width: Global.width
    title: Global.windowTitle
    id: app

    menuBar: InstrumentLibMenuBar{}

    // header: Text {
    //     text: "header"
    //     font: Global.fonts.Title_1
    // }

    ScrollView {
        anchors.fill: parent
        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 40
            anchors.topMargin: 20
            Repeater {
                id: sectionRepeater
                model: gridSections
                delegate: ItemGrid {
                        required property var modelData;
                        required property var cells;
                        required property var name;
                        sectionName: name
                        cellList: cells
                        section: modelData
                    }
            }
        }
    }

    AddAppModal{
        id: addApplicationModal
    }

}
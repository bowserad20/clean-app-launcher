import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import InstrumentLib

ApplicationWindow {

    ConfigLoader{id: configLoader}
    Shortcut {
        sequence: StandardKey.Save
        onActivated: configLoader.save()
    }

    Material.theme: Material.Dark
    Material.foreground: Material.Teal
    Material.primary: Material.Red
    Material.accent: Material.Orange
    property list<SectionModel> gridSections

    visible: true
    height: Global.height
    width: Global.width
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
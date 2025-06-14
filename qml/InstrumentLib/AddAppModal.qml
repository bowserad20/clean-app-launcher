import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Dialogs
import InstrumentLib

Popup {
    property SectionModel section
    property var targetGrid
    width: 400
    height: 300
    anchors.centerIn: parent
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 12
        Text {
            text: "Add Cell"
            Layout.alignment: Qt.AlignHCenter 
            color: Global.colors.Text
            font: Global.fonts.Menu
        }
        TextField {
            id: name
            placeholderText: "Name"
            Layout.fillWidth: true
        }
        RowLayout {
            Layout.fillWidth: true
            TextField {
                Layout.fillWidth: true
                id: path
                placeholderText: "Exe Path"
            }
            Button {
                text: "+"
                horizontalPadding: 0
                verticalPadding: 0
                Layout.preferredWidth: 50

                onClicked: fileDialog.open()
                font: Global.fonts.Menu
            }
            FileDialog {
                id: fileDialog
                title: "Choose an executable"
                onAccepted: {
                    path.text = fileDialog.selectedFile
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true
            TextField {
                Layout.fillWidth: true
                id: icon
                placeholderText: "Icon Path"
            }
            Button {
                text: "+"
                horizontalPadding: 0
                verticalPadding: 0
                Layout.preferredWidth: 50
                onClicked: iconDialog.open()
                font: Global.fonts.Menu
            }
            FileDialog {
                id: iconDialog
                title: "Choose an icon"
                onAccepted: {
                    icon.text = iconDialog.selectedFile
                }
            }
        }
        Button {
            text: "Add"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom 
            Layout.preferredWidth: 100
            horizontalPadding: 0
            verticalPadding: 0
            
            onClicked: {
                addApplicationModal.section.addCell(name.text, path.text, icon.text);
                addApplicationModal.targetGrid.cellList = addApplicationModal.section.cells;
            }
            font: Global.fonts.Menu
        }
        
    }

    Overlay.modal: Rectangle {
        color: Global.colors.Surface2Trans
    }
}
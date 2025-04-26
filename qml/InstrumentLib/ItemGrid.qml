import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import InstrumentLib

GridView {
    property list<CellModel> cellList
    property SectionModel section
    property string sectionName
    id: grid
    Layout.fillWidth: true
    Layout.preferredHeight: childrenRect.height
    model: cellList
    cellHeight: Global.cellHeight + Global.cellGap
    cellWidth: Global.cellWidth + Global.cellGap
    clip: true
    interactive: false

    header: 
        RowLayout {
            width: parent.width
            Row {
                Layout.fillWidth: true
                RowLayout {
                    width: parent.width
                    Component {
                        id: displayTitle
                        MouseArea {
                            height: childrenRect.height
                            width: childrenRect.width
                            onClicked: {
                                titleLoader.sourceComponent = editTitle;
                            }
                            Text {
                                bottomPadding: 20
                                text: grid.sectionName
                                font: Global.fonts.Title2
                                color: Global.colors.Text                            
                            }
                        }
                    }
                    Component {
                        id: editTitle
                        TextField {
                            id: sectionName
                            font: Global.fonts.Title2
                            color: Global.colors.Text
                            text: grid.sectionName
                            leftPadding: 0
                            topPadding: 0
                            bottomPadding: 20
                            Keys.onPressed: (ev) => {
                                if (ev.key == Qt.Key_Return) {
                                    configLoader.renameSection(grid.section, sectionName.text);
                                    app.gridSections = configLoader.getSections()
                                    titleLoader.sourceComponent = displayTitle;
                                }
                            }

                            background: Item{}

                            Component.onCompleted: sectionName.forceActiveFocus();
                        }
                    }

                    Loader {
                        Layout.fillWidth: true
                        id: titleLoader
                        sourceComponent: displayTitle
                    }
                }
            }

            Row {
                spacing: 8
                Button {
                    text: "+"
                    horizontalPadding: 0
                    verticalPadding: 0
                    onClicked: { 
                        addApplicationModal.section = section; 
                        addApplicationModal.targetGrid = grid; 
                        addApplicationModal.open() 
                    }
                    Material.background: Global.colors.Surface2
                    font: Global.fonts.Subtitle
                }

                Button {
                    text: "X"
                    onClicked: { 
                        configLoader.removeSection(grid.section)
                        app.gridSections = configLoader.getSections()
                    }
                    Material.background: Global.colors.Surface2
                    font: Global.fonts.Menu
                }
            }
        }

    delegate: 
        Rectangle {
            required property string cellName
            required property string path
            required property string icon
            required property var modelData
            required property var index;
            id: cell
            height: Global.cellHeight
            width: Global.cellWidth
            color: Global.colors.Surface2
            border.color: Global.colors.SurfaceOutline
            border.width: 2
            radius: 12    

            Image {
                source: Qt.resolvedUrl('file:'+icon)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                width:170
                height:170
                fillMode: Image.PreserveAspectCrop
            }    

            Text {
                text: cellName
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                horizontalAlignment: Text.AlignHCenter
                leftPadding: 10
                rightPadding: 10
                width: parent.width - 20       //width - leftPadding - rightPadding
                elide: Text.ElideRight
                color: Global.colors.Text
                font: Global.fonts.Subtitle
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: parent.modelData.cellClicked(parent.path)
            }

            Button {
                text: "X"
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: -15
                anchors.topMargin: -20
                width: 35
                height: 45
                onClicked: { section.removeCell(cell.index); cellList = section.cells; }
                Material.background: Global.colors.Surface2
                font: Global.fonts.Menu

                contentItem: Text{
                    anchors.fill: parent
                    text: parent.text
                    color: Material.foreground
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
}

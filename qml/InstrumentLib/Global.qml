pragma Singleton
import QtQuick
import QtQuick.Controls.Material

QtObject {
    property string windowTitle: "Clean App Launcher"
    property int height: 900
    property int width: 1200
    property int cellWidth: 250
    property int cellHeight: 250
    property int cellGap: 40
    property int menuBarHeight: 25

    property var colors: ({
        Text: Material.color(Material.Grey, Material.Shade50),
        Surface2: '#322F35',
        Surface2Trans: '#99322F35',
        SurfaceOutline: '#79747E',
        Red: Material.color(Material.Red)
    })

    // Typography
    property string fontFamily: "Arial"
    property var fonts: ({
        Title1: Qt.font({ family: fontFamily, pointSize: 32, weight: Font.DemiBold }),
        Title2: Qt.font({ family: fontFamily, pointSize: 24, weight: Font.DemiBold }),
        Subtitle: Qt.font({ family: fontFamily, pointSize: 24, weight: Font.Medium }),
        Menu: Qt.font({ family: fontFamily, pointSize: 12 })
    })
}

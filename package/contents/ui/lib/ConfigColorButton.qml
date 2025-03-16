import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import org.kde.plasma.core 2.0 as PlasmaCore

RowLayout {
    id: configColorButton
    
    property string configKey: ""
    property string label: ""
    property color defaultColor: "#3daee9"
    property bool enabled: true
    
    // Current color from configuration or default
    readonly property color currentColor: {
        if (configKey && plasmoid.configuration[configKey]) {
            return plasmoid.configuration[configKey]
        }
        return defaultColor
    }

    Label {
        text: label
        Layout.preferredWidth: units.gridUnit * 8
    }

    Button {
        id: colorButton
        Layout.preferredWidth: units.gridUnit * 4
        Layout.preferredHeight: units.gridUnit * 2
        enabled: configColorButton.enabled
        Layout.alignment: Qt.AlignVCenter
        
        // Rectangle to display the current color
        Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            color: configColorButton.currentColor
            border.color: Qt.rgba(0, 0, 0, 0.2)
            border.width: 1
            radius: 3
        }

        onClicked: {
            colorDialog.color = configColorButton.currentColor
            colorDialog.open()
        }
    }

    ColorDialog {
        id: colorDialog
        title: i18n("Choose a color")
        showAlphaChannel: true
        
        onAccepted: {
            plasmoid.configuration[configKey] = color
        }
    }
}

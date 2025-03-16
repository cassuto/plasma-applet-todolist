import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import "../lib"

ConfigPage {
	id: page

	ConfigSection {
		Label {
			text: i18n("Text Style")
			font.bold: true
			font.pointSize: theme.defaultFont.pointSize * 1.1
		}

		ConfigCheckBox {
			id: useCustomTextBackground
			configKey: "useCustomTextBackground"
			text: i18n("Use custom text background")
		}

		ConfigColorButton {
			id: textBackgroundColor
			configKey: "textBackgroundColor"
			label: i18n("Text background color:")
			enabled: useCustomTextBackground.checked
		}
	}
}

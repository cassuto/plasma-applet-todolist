import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import "../lib"

ConfigPage {
	id: page

	ConfigSection {
		Label {
			text: i18n("Item Style")
			font.bold: true
			font.pointSize: theme.defaultFont.pointSize * 1.1
		}

		ConfigCheckBox {
			id: useCustomTextBackground
			configKey: "useCustomTextBackground"
			text: i18n("Use custom background & border")
		}

		ConfigColorButton {
			id: textBackgroundColor
			configKey: "textBackgroundColor"
			label: i18n("Text background color:")
			enabled: useCustomTextBackground.checked
		}

		ConfigColorButton {
			id: borderColor
			configKey: "borderColor"
			label: i18n("Border color:")
			enabled: useCustomTextBackground.checked
		}

		ConfigSpinBox {
			id: borderWidth
			configKey: "borderWidth"
			before: i18n("Border width:")
			suffix: i18n(" px")
			minimumValue: 0
			maximumValue: 10
			enabled: useCustomTextBackground.checked
		}

		ConfigCheckBox {
			id: useCustomTextColor
			configKey: "useCustomTextColor"
			text: i18n("Use custom foreground")
		}

		ConfigColorButton {
			id: textColor
			configKey: "textColor"
			label: i18n("Text foreground color:")
			enabled: useCustomTextColor.checked
		}
	}
}

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
			text: i18n("Use Custom Background & Border")
		}

		ConfigColorButton {
			id: textBackgroundColor
			configKey: "textBackgroundColor"
			label: i18n("Text Background Color:")
			enabled: useCustomTextBackground.checked
		}

		ConfigColorButton {
			id: borderColor
			configKey: "borderColor"
			label: i18n("Border Color:")
			enabled: useCustomTextBackground.checked
		}

		ConfigSpinBox {
			id: borderWidth
			configKey: "borderWidth"
			before: i18n("Border Width:")
			suffix: i18n(" px")
			minimumValue: 0
			maximumValue: 10
			enabled: useCustomTextBackground.checked
		}

		ConfigCheckBox {
			id: useCustomTextColor
			configKey: "useCustomTextColor"
			text: i18n("Use Custom Foreground")
		}

		ConfigColorButton {
			id: textColor
			configKey: "textColor"
			label: i18n("Text Foreground Color:")
			enabled: useCustomTextColor.checked
		}
	}
}

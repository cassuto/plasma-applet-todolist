import QtQuick 2.0
import org.kde.plasma.configuration 2.0

ConfigModel {
	ConfigCategory {
		name: i18n("General")
		icon: "configure"
		source: "config/ConfigGeneral.qml"
	}
	ConfigCategory {
		name: i18n("Appearance")
		icon: "preferences-desktop-color"
		source: "config/ConfigAppearance.qml"
	}
}

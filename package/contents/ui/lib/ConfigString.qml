// Version 3

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.notes 0.1 as NotesWidget

TextField {
	id: configString
	Layout.fillWidth: true

	property string configKey: ''
	property alias value: configString.text
	readonly property string configValue: configKey ? plasmoid.configuration[configKey] : ""
	onConfigValueChanged: {
		if (!configString.focus && value != configValue) {
			value = configValue
		}
	}
	property string defaultValue: ""
	property string overlayTempValue: ""
	property bool overlayVisible: false

	// Don't update on text change real-time, to avoid accidentally overwriting unexpected files
	text: configString.configValue

	// Disable direct editing of the text field
	readOnly: true

	// Show the overlay when clicked
	MouseArea {
		anchors.fill: parent
		onClicked: {
			if (!overlayVisible) {
				overlayTempValue = text
				overlayTextField.text = text
				overlayVisible = true
				overlayTextField.forceActiveFocus()
			}
		}
		enabled: !overlayVisible
	}

	ToolButton {
		iconName: "edit-clear"
		onClicked: configString.value = defaultValue

		anchors.top: parent.top
		anchors.right: parent.right
		anchors.bottom: parent.bottom

		width: height
		visible: !overlayVisible
	}

	// Overlay component for editing
	Rectangle {
		id: editOverlay
		anchors.fill: parent
		color: theme.backgroundColor
		border.color: theme.highlightColor
		border.width: 1
		radius: 3
		visible: overlayVisible
		z: 10

		// Handle key events at the overlay level to ensure they work
		// even if the text field doesn't have focus
		Keys.enabled: overlayVisible
		Keys.onEscapePressed: cancelEdit()
		Keys.onReturnPressed: confirmEdit()
		Keys.onEnterPressed: confirmEdit()

		TextField {
			id: overlayTextField
			anchors.left: parent.left
			anchors.right: confirmButton.left
			anchors.verticalCenter: parent.verticalCenter
			anchors.margins: 5
			text: configString.overlayTempValue
			placeholderText: configString.placeholderText

			// Also handle keys at the TextField level
			Keys.onEscapePressed: cancelEdit()
			Keys.onReturnPressed: confirmEdit()
			Keys.onEnterPressed: confirmEdit()
		}

		ToolButton {
			id: confirmButton
			iconName: "dialog-ok"
			anchors.right: cancelButton.left
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			width: height
			onClicked: confirmEdit()
			
			// Add a green rectangle behind the icon
			Rectangle {
				anchors.fill: parent
				anchors.margins: 4
				color: "#4CAF50"  // Green color
				radius: 3
				z: -1  // Place behind the icon
				opacity: 0.7
			}
		}

		ToolButton {
			id: cancelButton
			iconName: "dialog-cancel"
			anchors.right: parent.right
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			width: height
			onClicked: cancelEdit()
			
			// Add a red rectangle behind the icon
			Rectangle {
				anchors.fill: parent
				anchors.margins: 4
				color: "#F44336"  // Red color
				radius: 3
				z: -1  // Place behind the icon
				opacity: 0.7
			}
		}
	}

	// Confirmation dialog
	MessageDialog {
		id: confirmationDialog
		title: i18n("Confirm Overwrite")
		text: i18n("File already exists. Do you want to choose it?")
		standardButtons: StandardButton.Yes | StandardButton.No

		onYes: {
			applyChanges()
		}

		onNo: {
			// Do nothing, keep the overlay open
		}
	}

	MessageDialog {
        id: msgCannotWrite
        title: i18n("Error")
        text: i18n("Cannot write to the choosen file!")
        icon: StandardIcon.Critical
        standardButtons: StandardButton.Ok
    }

	// Since we don't have direct access to check if a file exists,
	// we'll use a workaround by creating a temporary NoteManager
	// and trying to load the note
	NotesWidget.NoteManager { id: tempNoteManager }
	function fileExists(filename) {
		try {
			var note = tempNoteManager.loadNote(filename);
			return note && note.noteText !== "";
		} catch (e) {
			// If there's an error loading the note, assume the file doesn't exist
			return false;
		}
	}

	function confirmEdit() {
		// Only check file for 'noteFilename'
		if (configKey === "noteFilename") {
			if (fileExists(overlayTextField.text)) {
				confirmationDialog.open()
			} else {
				applyChanges()
			}
		} else {
			applyChanges()
		}
	}

	function applyChanges() {
		if (configKey) {
			value = overlayTextField.text
			plasmoid.configuration[configKey] = value
		}
		overlayVisible = false
	}

	function cancelEdit() {
		overlayVisible = false
	}
}

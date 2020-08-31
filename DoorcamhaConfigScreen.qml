import QtQuick 2.1
import qb.components 1.0

Screen {
	id: doorcamhaConfigScreen
	screenTitle: "Doorcam app Setup"

	onShown: {
		doorcamhaImageURL1.inputText = app.doorcamhaImageURL1;
		haURL1.inputText = app.haURL1;
		haEntity_id.inputText= app.haEntity_id;
		haToken.inputText= app.haToken;
		addCustomTopRightButton("Save");
	}

	onCustomButtonClicked: {
		app.saveSettings();
		hide();
	}


	function savedoorcamhaImageURL1(text) {
		if (text) {
			app.doorcamhaImageURL1 = text;
		}
	}

	function savehaURL1(text) {
		if (text) {
			app.haURL1 = text;
		}
	}

	function savehaEntity_id(text) {
		if (text) {
			app.haEntity_id = text;
		}
	}

	function savehaToken(text) {
		if (text) {
			app.haToken = text;
		}
	}

	Text {
		id: myLabel
		text: "Example of valid URL: http://192.168.10.8/live/1/jpeg.jpg :"
		anchors {
			left: parent.left
			top: parent.top
			leftMargin: 20
			topMargin: 20
		}
	}

	EditTextLabel4421 {
		id: doorcamhaImageURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "Cam URL"

		anchors {
			left: parent.left
			top: myLabel.bottom
			leftMargin: 20
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("URL", doorcamhaImageURL1.inputText, savedoorcamhaImageURL1)
		}
	}


	Text {
		id: myLabel2
		text: "Example of valid URL: http://192.168.10.185:8123 :"
		anchors {
			left: parent.left
			top: doorcamhaImageURL1.bottom
			leftMargin: 20
			topMargin: 20
		}
	}


	EditTextLabel4421 {
		id: haURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "HA URL"

		anchors {
			left: parent.left
			top: myLabel2.bottom
			leftMargin: 20
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("URL", haURL1.inputText, savehaURL1)
		}
	}

	Text {
		id: myLabel3
		text: "Helper Entity_id in Home Assistant. Example : input_number.showdoorcamtoon :"
		anchors {
			left: parent.left
			top: haURL1.bottom
			leftMargin: 20
			topMargin: 20
		}
	}

	EditTextLabel4421 {
		id: haEntity_id
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "Entity_id"
		anchors {
			left: parent.left
			top: myLabel3.bottom
			leftMargin: 20
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Entity_id", haEntity_id.inputText, savehaEntity_id)
		}
	}

	Text {
		id: myLabel4
		text: "Home Assistant long-lived access token :"
		anchors {
			left: parent.left
			top: haEntity_id.bottom
			leftMargin: 20
			topMargin: 20
		}
	}

	EditTextLabel4421 {
		id: haToken
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "Token"
		anchors {
			left: parent.left
			top: myLabel4.bottom
			leftMargin: 20
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("Token", haToken.inputText, savehaToken)
		}
	}
}

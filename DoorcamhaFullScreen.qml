import QtQuick 2.1
import qb.components 1.0

Screen {
	id: doorcamhaFullScreen
	screenTitle: "Doorcamha";

	onCustomButtonClicked: {
		if (app.doorcamhaConfigScreen) {
			 app.doorcamhaConfigScreen.show();
		}
	}

	onShown: {
		console.log("webcam: WebcamFullScreen.onShown() called")
		addCustomTopRightButton("Configuratie")
		screenStateController.screenColorDimmedIsReachable = false
		app.doorcamhaTimer1Interval = 1000
		app.pictureCountdownCounter = app.pictureCountdownCounterStart
		app.doorcamhaTimer1Running = true

		//zet de ha Entity_id state naar 150
		var doc = new XMLHttpRequest();
        	doc.onreadystatechange = function() {
            		if (doc.readyState == XMLHttpRequest.DONE) {
            		}
        	}

                var haURL2 = app.haURL1
                haURL2 += "/api/states/"
                haURL2 += app.haEntity_id

                var params = '{"state": "150"}';


                doc.open("POST", haURL2, true);
                doc.setRequestHeader("Authorization", "Bearer " + app.haToken);
                doc.setRequestHeader("Content-Type", "application/json");


                doc.send(params);
	}

	onHidden: {
		console.log("webcam: WebcamFullScreen.onHidden() called")
		app.doorcamhaTimer1Interval = 10000
		app.pictureCountdownCounter = -1
		screenStateController.screenColorDimmedIsReachable = true

		//zet de ha Entity_id state naar 150
		var doc = new XMLHttpRequest();
        	doc.onreadystatechange = function() {
            		if (doc.readyState == XMLHttpRequest.DONE) {
            			}
        	}
                var haurl2 = app.haURL1
                haurl2 += "/api/states/"
                haurl2 += app.haEntity_id

                var params = '{"state": "150"}';

                doc.open("POST", haurl2, true);
                doc.setRequestHeader("Authorization", "Bearer " + app.haToken);
                doc.setRequestHeader("Content-Type", "application/json");
                doc.send(params);
		this.close();
	}


	Image {
		id: doorcamhaImage1
		width: parent.width
		height: parent.height - 30
		fillMode: Image.PreserveAspectFit
		source: app.doorcamhaImage1Source
		anchors {
			left: parent.left
			top: parent.top
		}
		cache: false
		z: app.doorcamhaImage1Z
		onStatusChanged: {
			app.doorcamhaImage1Ready = (doorcamhaImage1.status == Image.Ready)
		}
		MouseArea {
			anchors.fill: parent
		 	onClicked: {
				app.pictureCountdownCounter = app.pictureCountdownCounterStart
		 	}
 		}
	}


	Image {
		id: doorcamhaImage2
		width: parent.width
		height: parent.height - 30
		fillMode: Image.PreserveAspectFit
		source: app.doorcamhaImage2Source
		anchors {
			left: parent.left
			top: parent.top
		}
		cache: false
		z: app.doorcamhaImage2Z
		onStatusChanged: {
			app.doorcamhaImage2Ready = (doorcamhaImage2.status == Image.Ready)
		}
	}

	Rectangle {
	    width: parent.width
	    height: 20
	    color: "white"
			anchors {
				left: parent.left
				bottom: parent.bottom
			}
			z: 10
	}

	Rectangle {
	    width: Math.abs((app.pictureCountdownCounter/app.pictureCountdownCounterStart)*parent.width)
	    height: 20
	    color: "green"
			anchors {
				left: parent.left
				bottom: parent.bottom
			}
			z: 20
	}

}

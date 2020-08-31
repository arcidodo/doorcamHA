import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: doorcamhaTile

	function init() {}

	onClicked: {
		if (app.doorcamhaFullScreen) {
			app.doorcamhaFullScreen.show();
			console.log("webcam: app.doorcamhaFullScreen.show() called")
		}
	}

 	function getha() {
        	var doc = new XMLHttpRequest();
        	doc.onreadystatechange = function() {
            		if (doc.readyState == XMLHttpRequest.DONE) {
				var JsonString = doc.responseText;

                                console.log(JsonString)

        			var JsonObject = JSON.parse(JsonString);
        			//retrieve values from JSON again
        			var aString = JsonObject.state;

				if (aString == "100.0"){
					if (app.doorcamhaFullScreen) {
						//app.doorcamhaFullScreen.showMinimized();
						app.doorcamhaFullScreen.hide();
						console.log("webcam: app.webcamFullScreen.hide() called")
					}
				}

				if (aString == "200.0"){
					if (app.doorcamhaFullScreen) {
						app.doorcamhaFullScreen.show();
						console.log("webcam: app.webcamFullScreen.show() called")
					}
				}

				//mainText.text = doc.responseText;
            		}
        	}
                var haURl2 = app.haURL1
                haURl2 += "/api/states/"
                haURl2 += app.haEntity_id

                doc.open("GET", haURl2, true);
                doc.setRequestHeader("Authorization", "Bearer " + app.haToken);
                doc.setRequestHeader("Content-Type", "application/json");
        	      doc.send();

   	 }

	Image {
		id: tileDoorcamhaImage1
    		width: 200; height: 140
		source: "qrc:/tsc/doorcam_large.jpg"
		anchors {
			verticalCenter: parent.verticalCenter
			horizontalCenter: parent.horizontalCenter
		}
		cache: false
	}

	Text {
		id: mytext
		text: "Doorcamha"

		font {
			family: qfont.semiBold.name
			pixelSize: 24
		}

		anchors {
			bottom: parent.bottom
			bottomMargin: 5
			horizontalCenter: parent.horizontalCenter
		}
	}


	Timer {
        	id: deurTimer
        	interval: 4000
        	repeat: true
        	running: true
        	triggeredOnStart: true
        	onTriggered: getha()
    	}
}

import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import FileIO 1.0

App {
	id: doorcamhaApp

	property url 		tileUrl : "DoorcamhaTile.qml"
	property url 		thumbnailIcon: "qrc:/tsc/doorcam.png"
	property 		DoorcamhaFullScreen doorcamhaFullScreen
	property 		DoorcamhaConfigScreen doorcamhaConfigScreen
	property 		DoorcamhaTile doorcamhaTile

	property string 	doorcamhaImage1Source
	property string 	doorcamhaImage2Source
	property bool 		doorcamhaImage1Ready: false
	property bool 		doorcamhaImage2Ready: false
	property int 		doorcamhaImage1Z: 100
	property int 		doorcamhaImage2Z: 0
	property int 		pictureCycleCounter: 0
	property int 		pictureCountdownCounterStart: 10
	property int 		pictureCountdownCounter: 10
	property int 		doorcamhaTimer1Interval: 1000
	property bool 		doorcamhaTimer1Running: false
	property string 	doorcamhaImageURL1 : "qrc:/tsc/connect.jpg"
	property string 	haURL1 : "http://192.168.10.18:8123"
	property string 	haEntity_id : "entity_id"
	property string 	haToken : "haToken"

// user settings from config file
	property variant doorcamhaSettingsJson : {
		'doorcamImageURL1': "",
		'haURL1': "",
		'haEntity_id': "",
		'haToken': ""
	}

	FileIO {
		id: doorcamhaSettingsFile
		source: "file:///mnt/data/tsc/doorcamha_userSettings.json"
 	}

	QtObject {
		id: p
		property url doorcamhaFullScreenUrl : "DoorcamhaFullScreen.qml"
		property url doorcamhaConfigScreenUrl : "DoorcamhaConfigScreen.qml"
	}

	function init() {
		registry.registerWidget("tile", tileUrl, this, "doorcamhaTile", {thumbLabel: qsTr("Doorcamha"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", p.doorcamhaFullScreenUrl, this, "doorcamhaFullScreen");
		registry.registerWidget("screen", p.doorcamhaConfigScreenUrl, this, "doorcamhaConfigScreen");
		doorcamhaImage1Source = doorcamhaImageURL1;
		doorcamhaImage2Source = doorcamhaImageURL1;
		doorcamhaImage1Z = 0;
		doorcamhaImage2Z = 100;
	}

	function listProperty(item){
    		for (var p in item)
    			console.log(p + ": " + item[p]);
	}


	Component.onCompleted: {
		try {
			doorcamhaSettingsJson = JSON.parse(doorcamhaSettingsFile.read());
			doorcamhaImageURL1 = doorcamhaSettingsJson['camURL'];
			haURL1 = doorcamhaSettingsJson['haURL'];
			haEntity_id = doorcamhaSettingsJson['entity_id'];
			haToken = doorcamhaSettingsJson['token'];

		} catch(e) {
		}
		listProperty(screenStateController)
	}

	function updateDoorcamhaImage1() {
		//if (DoorcamhaFullScreen.visible && !dimState){
		if (doorcamhaFullScreen.visible){

			console.log("doorcamha: updateDoorcamhaImage1() called")
			switch(pictureCycleCounter) {
			case 0:
				doorcamhaImage2Source = ""
				doorcamhaImage2Source = doorcamhaImageURL1
				pictureCycleCounter = pictureCycleCounter + 1
				break
			case 1:
				if (doorcamhaImage2Ready) {
					doorcamhaImage2Z = 100
					doorcamhaImage1Z = 0
					pictureCycleCounter = pictureCycleCounter + 1
					pictureCountdownCounter = pictureCountdownCounter - 1
				}
				break
			case 2:
				doorcamhaImage1Source = ""
				doorcamhaImage1Source = doorcamhaImageURL1
				pictureCycleCounter = pictureCycleCounter + 1
				break
			case 3:
				if (doorcamhaImage1Ready) {
					doorcamhaImage1Z = 100
					doorcamhaImage2Z = 0
					pictureCycleCounter = 0
					pictureCountdownCounter = pictureCountdownCounter - 1
				}
				break
			}
		}
	}

	Timer {
		id: doorcamhaTimer1
		interval: doorcamhaTimer1Interval
		triggeredOnStart: true
		running: doorcamhaTimer1Running
		repeat: true
		onTriggered: updateDoorcamhaImage1()
	}

	function saveSettings() {
 		var setJson = {
			"camURL" : DoorcamhaImageURL1,
			"haURL" : haURL1,
			"entity_id" : haEntity_id,
			"token" : haToken
		}
  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/doorcamha_userSettings.json");
   		doc3.send(JSON.stringify(setJson));
	}

}

/* 
ActionSript : FLV 컨트롤바
만 든 이 : nanpjs
만든날짜 : 2010.3
Q : RGB박대리
*/
import flash.external.*;
import mx.video.*;
class AS.FlvControl extends AS.MainFunction
{
	//생성자
	public function FlvControl(_onwer1:MovieClip, _onwer2:MovieClip, _mcPoint:String, _mcBar:String, _mcBar1:String, _mcBar2:String)
	{
		super();
		this_onwer = _onwer1;
		onwer = _onwer2;
		mcPoint = onwer[_mcPoint];
		mcBar = onwer[_mcBar];
		mcBar1 = onwer[_mcBar1];
		mcBar2 = onwer[_mcBar2];
	}
	// flv메소드
	public function startFlv()
	{
		var widthNum:Number = onwer.conBar_mc._width / 100;
		var listenerObject:Object = new Object();

		var Flv_page = String(ExternalInterface.call("flvPage"));
		var flvPath = Flv_page;
		var movieSource = new XML();
		_global.sourceNode = new Array();
		_global.getPlayTime;
		_global.getPlayTimecheck = new Array();
		_global.getPlayTimeMsg = new Array();
		movieSource.ignoreWhite = true;
		movieSource.onLoad = function(success:Boolean):Void 
		{
			if (success) {
				var fileNameNode = movieSource.firstChild.childNodes;
				for (var i:Number = 0; i < fileNameNode.length; i++) {
					if (flvPath == fileNameNode[i].attributes.value) {
						_global.sourceNode = fileNameNode[i].childNodes;
					}
				}
				body.my_FLVPlybk.contentPath = _global.sourceNode[0].attributes.value;
				//ExternalInterface.call("alert", "flv 경로 확인"+body.my_FLVPlybk.contentPath);////////////////////////  flv경로확인

				_global.getPlayTimecheck = _global.sourceNode[1].attributes.value.split(",");
				_global.getPlayTimeMsg = _global.sourceNode[2].attributes.value.split(",");
				for (var i:Number = 0; i < _global.getPlayTimecheck.length; i++) {
					var sec = 60 * Number(_global.getPlayTimecheck[i].substr(0, 2));
					sec = sec + Number(_global.getPlayTimecheck[i].substr(2, 2));

					var cuePt:Object = new Object();// create cue point object

					cuePt.time = sec;
					cuePt.name = _global.getPlayTimecheck[i];
					body.my_FLVPlybk.addASCuePoint(cuePt);
				}
			} else {
			}
		};

		movieSource.load("../" + ChaSe_Name + "/flv/movie_value.xml");
		var my_seek:Function = function ()
		{
		onwer.onEnterFrame = function()
		{
		    mcPoint._x = body.my_FLVPlybk.playheadPercentage * widthNum;
		    mcBar1._width = body.my_FLVPlybk.playheadPercentage * widthNum;
		};
		};
		my_seek();

		//
		//현재 / 전체  시간 체크
		listenerObject.ready = function(evt):Void 
		{

			var TTM = Math.floor(evt.target.totalTime / 60);
			var TTS = Math.floor(evt.target.totalTime % 60);
			if (TTM < 10) {
				TTM = "0" + TTM;
			} else {
				TTM = TTM;
			}
			if (TTS < 10) {
				TTS = "0" + TTS;
			} else {
				TTS = TTS;
			}
			onwer.total_time.text = "/ " + TTM + ":" + TTS;
		};
		body.my_FLVPlybk.playheadUpdateInterval = 100;
		//진행시간
		listenerObject.playheadUpdate = function(evt):Void 
		{

			mcBar1._width = mcPoint._x;
			_global.Time = int(body.my_FLVPlybk.playheadTime);
			//trace(_global.Time);
			//
			var CTM = Math.floor(evt.target.playheadTime / 60);
			var CTS = Math.floor(evt.target.playheadTime % 60);
			if (CTM < 10) {
				CTM = "0" + CTM;
			} else {
				CTM = CTM;
			}
			if (CTS < 10) {
				CTS = "0" + CTS;
			} else {
				CTS = CTS;
			}
			onwer.this_time.text = CTM + ":" + CTS;
			_global.getPlayTime = CTM + CTS;
			if (_global.getPlayTimecheck[0] > _global.getPlayTime) {
				//_root.mcContent.mcCueMessage.gotoAndStop(1);
			} else {

				for (var i:Number = 0; i < _global.getPlayTimecheck.length; i++) {
					if (_global.getPlayTimecheck[i] == body.my_FLVPlybk.findNearestCuePoint(int(evt.target.playheadTime)).name) {

						body.MC.aa.text = _global.getPlayTimeMsg[i];
						body.MC.aa.text = body.MC.aa.text.substr(6);
					}
				}
			}
		};
		//스트리밍체크 & 버퍼링 
		listenerObject.progress = function(evt):Void 
		{
			var loaded:Number = (evt.target.bytesLoaded);
			var total:Number = (evt.target.bytesTotal);
			mcBar2._width = (loaded / total) * mcBar._width;
			/*if (mcBar2._width >= mcBar._width) {
				mcBar2._visible = false;
			} else {
				mcBar2._visible = true;
			}*/
			body.buffer.text = "Bufferring/" + int((loaded / total) * 100) + "%";
	     if (body.buffer.text == "Bufferring/100%") {
				body.buffer_mc._visible = false;
			} else {
				body.buffer_mc._visible = true;
			}
		};
		//동영상 실행중 함수 
		listenerObject.playing = function(eventObject:Object):Void 
		{
			onwer.conPlay_mc.gotoAndStop(3);
			onwer.conPause_mc.gotoAndStop(1);
			my_seek();
		};
		//동영상 완료후 실행 함수
		listenerObject.complete = function(eventObject:Object):Void 
		{
			onwer.conPause_mc.gotoAndStop(3);
			onwer.conPlay_mc.gotoAndStop(1);
			this_onwer.controlMC.conNext_mc.gotoAndStop("end");
			delete onwer.onEnterFrame;
			trace("실행할 명령어나 함수를 입력하세요");
		};




		//리스너 등록
		body.my_FLVPlybk.addEventListener("playing",listenerObject);
		body.my_FLVPlybk.addEventListener("complete",listenerObject);
		body.my_FLVPlybk.addEventListener("progress",listenerObject);
		body.my_FLVPlybk.addEventListener("playheadUpdate",listenerObject);
		body.my_FLVPlybk.addEventListener("ready",listenerObject);
	
		//





		mcPoint.onPress = function()
		{
			delete onwer.onEnterFrame;
			this.startDrag(true,0,0,mcBar._width - 1,0);
		};
		mcPoint.onRelease = mcPoint.onReleaseOutside = function ()
		{
			this.stopDrag();
			var num = mcPoint._x / widthNum;
			if (num < 0) {
				num = 0;
			}
			body.my_FLVPlybk.play();
			body.my_FLVPlybk.seekPercent(num);
			my_seek();
		};
	}
}
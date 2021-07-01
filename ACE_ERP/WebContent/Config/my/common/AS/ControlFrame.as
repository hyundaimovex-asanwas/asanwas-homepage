/* 
ActionSript : 컨트롤바
만 든 이 : nanpjs
만든날짜 : 2011.1
Q : RGB박대리
*/
import flash.external.*;
class AS.ControlFrame extends AS.MainFunction
{
	//생성자
	public function ControlFrame(_onwer1:MovieClip, _onwer2:MovieClip, _mcPoint:String, _mcBar:String, _mcBar1:String, _mcBar2:String)
	{
		super();
		this_onwer = _onwer1;
		onwer = _onwer2;
		mcPoint = onwer[_mcPoint];
		mcBar = onwer[_mcBar];
		mcBar1 = onwer[_mcBar1];
		mcBar2 = onwer[_mcBar2];
		setButton("conPlay_mc||conPause_mc||conReplay_mc||conSound_mc||conScript_mc||next_mc||prev_mc");

	}
	//페이지 번호 표시
	public function page_num():Void
	{
		//
	}
	//제어바 메소드
	public function startFrame():Void
	{
		var conButtonGap:Number = 0;
		var conF:Number = 0;
		var conClicked:Boolean = false;
		var new_Frame:Number;
		var old_Frame:Number;
		var fpsNum:Number = 24;
		var firstFrame:Number = 1;
		var thispage = pagenum
		//
		onwer.onEnterFrame = function()
		{
			new_Frame = body._currentframe;
			if (old_Frame == new_Frame) {
				onwer.conPause_mc.gotoAndStop(3);
				if (onwer.conPlay_mc._currentframe == 3) {
					onwer.conPlay_mc.gotoAndStop(1);
				}
			} else {
				//mcPoint.CD._rotation += 50;
				old_Frame = body._currentframe;
				if (onwer.conPause_mc._currentframe == 3) {
					onwer.conPause_mc.gotoAndStop(1);
				}
				onwer.conPlay_mc.gotoAndStop(3);
			}
			//
			if (conClicked) {
				var conF = Math.round(((mcPoint._x - mcBar._x) / (mcBar._width - conButtonGap) * (body._totalframes - (firstFrame - 1))));
				if (conF <= firstFrame) {
					conF = firstFrame;
				}
				body.gotoAndPlay(conF);
			} else {
				if (new_Frame <= firstFrame) {
					//mcPoint._x += 10;
					mcPoint._x = mcBar._x;
				} else {
					var conX = Math.floor(mcBar._x + (mcBar._width - conButtonGap) * ((new_Frame - (firstFrame - 1)) / (body._totalframes - (firstFrame - 1))));
					//trace(conX);
					mcPoint._x = conX;
				}
			}
			//trace("new_Frame = "+new_Frame+"    ||     "+"firstFrame = "+firstFrame);
			if (mcPoint._x - mcBar1._x <= 0) {
				mcBar1._width = 0;
			} else {
				mcBar1._width = mcPoint._x - mcBar1._x;
			}
			var timeMin = Math.floor(((body._currentframe - (firstFrame - 1)) / fpsNum) / 60);
			var timeSec = Math.floor(((body._currentframe - (firstFrame - 1)) / fpsNum) % 60);
			if (timeMin < 10) {
				timeMin = "0" + timeMin;
			}
			if (timeSec < 10) {
				timeSec = "0" + timeSec;
			}
			var timeTotalMin = Math.floor(((body._totalframes - (firstFrame - 1)) / fpsNum) / 60);
			var timeTotalSec = Math.floor(((body._totalframes - (firstFrame - 1)) / fpsNum) % 60);
			if (timeTotalMin < 10) {
				timeTotalMin = "0" + timeTotalMin;
			}
			if (timeTotalSec < 10) {
				timeTotalSec = "0" + timeTotalSec;
			}
			onwer.this_time.text = timeMin + ":" + timeSec;
			onwer.total_time.text = "/ " + timeTotalMin + ":" + timeTotalSec;
				if (body._currentframe == body._totalframes) {
					body.stop();
					
					// flash.external.ExternalInterface.call("alert",pagenum); 
					if (_root.MF.cannext) {
						onwer.conNext_mc.gotoAndStop("end");
					}
				if (body._currentframe != body._totalframes) {
					onwer.conNext_mc.gotoAndStop(1);
				}
			}
		};
		mcPoint.onPress = function()
		{
			mcPoint.gotoAndPlay("end")
			stop();
			this.startDrag(false,mcBar._x,mcPoint._y,(mcBar._x + mcBar2._width - conButtonGap - 3),mcPoint._y);
			conClicked = true;
		};
		mcPoint.onRelease = mcPoint.onReleaseOutside = function ()
		{
			mcPoint.gotoAndPlay(1)
			this.stopDrag();
			conClicked = false;
		};
		mcBar.onPress = function()
		{
			stop();
			mcPoint._x = this._parent._xmouse;
			mcPoint.startDrag(false,mcBar._x,mcPoint._y,(mcBar._x + mcBar._width - conButtonGap),mcPoint._y);
			//conSound.setVolume(0);
			conClicked = true;
		};
		mcBar.onRelease = mcBar.onReleaseOutside = function ()
		{
			mcPoint.stopDrag();
			//conPause_mc.gotoAndStop(3);
			conClicked = false;
		};
	}
	public static function itostr(arg:Number):String
	{
		if (arg < 10) {
			return "0" + String(arg);
		} else {
			return String(arg);
		}
	}
	// 버튼 메소드
	public function setButton(makebutton:String)
	{
		var temp_isFlv = isFlv;
		var BTN_temp = makebutton.split("||");
		if (isFlv == true) {
			onwer[BTN_temp[0]].gotoAndStop(3);
		}
		var btnput:Function = function (name_)
		{
		name_.gotoAndStop(3);
		};
		for (var i:Number = 0; i <= BTN_temp.length; i++) {
			onwer[BTN_temp[i]].onRollOver = function()
			{
				if (this._currentframe != 3) {
					this.gotoAndStop(2);
				}
			};
			onwer[BTN_temp[i]].onRollOut = function()
			{
				if (this._currentframe != 3) {
					this.gotoAndStop(1);
				}
			};
			onwer[BTN_temp[i]].onPress = function()
			{
				Buttonsound.start();
				for (var i:Number = 0; i <= BTN_temp.length; i++) {
					if (this._name != "conSound_mc") {
						//onwer[BTN_temp[i]].gotoAndStop(1);
						onwer[BTN_temp[0]].gotoAndStop(1);
						onwer[BTN_temp[1]].gotoAndStop(1);
						onwer[BTN_temp[2]].gotoAndStop(1);
						onwer[BTN_temp[4]].gotoAndStop(1);
						btnput(this);
					}
				}
				switch (this._name) {
					case "conPlay_mc" :
						if (temp_isFlv) {
							body.my_FLVPlybk.play();
						} else {
							body.play();
						}
						break;
					case "conPause_mc" :
						if (temp_isFlv) {
							body.my_FLVPlybk.pause();
						} else {
							//body.gotoAndPlay(firstFrame);
							body.stop();
						}
						break;
					case "conReplay_mc" :
						if (temp_isFlv) {
							body.my_FLVPlybk.seek(0);
							this.gotoAndStop(1);
						} else {
							body.gotoAndPlay(2);
							this.gotoAndStop(1);
							//body.gotoAndStop(1);
						}
						break;
					case "conSound_mc" :
						if (soundRight) {
							globalsound.setVolume(0);
							this.gotoAndStop(3);
							soundRight = false;
						} else {
							globalsound.setVolume(100);
							this.gotoAndStop(1);
							soundRight = true;
						}
						break;
					case "conScript_mc" :
						if (scriptVisible) {
							this._parent._parent.txtMC.gotoAndPlay(2);
							scriptVisible = false;
							this.gotoAndStop(3);
						} else {
							scriptVisible = true;
							this._parent._parent.txtMC.gotoAndPlay("close");
							this.gotoAndStop(1);
						}
						break;
					case "next_mc" :
					
						if (onwer.curnum.text == onwer.totalnum.text) {
							//ExternalInterface.call("alert","마지막페이지입니다.");
							//ExternalInterface.call("rgb_next()");
							_root.MF.MAP();
						} else {
							ExternalInterface.call("rgb_next()");
						}
					
						break;
					case "prev_mc" :
						if (onwer.curnum.text != "01") {
							ExternalInterface.call("rgb_prev()");
						} else {
							ExternalInterface.call("rgb_prev()");
							//ExternalInterface.call("alert","첫페이지입니다.");
						}
						break;
				}
			};
		}
	}
}
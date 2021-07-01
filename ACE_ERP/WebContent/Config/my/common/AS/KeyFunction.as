/* 
ActionSript : 키보드 설정
만 든 이 : nanpjs
만든날짜 : 2010.3
Q : RGB박대리
*/
import flash.external.*;
import mx.managers.DepthManager;
class AS.KeyFunction {
	private var keyObj:Object;
	public var subLink:Array = new Array();
	public var isKeyPlay:Boolean = true;
	public var keyListener:Object = new Object();
	private function getPage(arg:String) {
		subLink = arg.split("_");
		return subLink;
	}
	public static function itostr(arg:Number):String {
		if (arg<10) {
			return "0"+String(arg);
		} else {
			return String(arg);
		}
	}
	public static function remove(obj:Object) {
		Key.removeListener(obj);
	}
	public function KeyStart() {
		//단축키
		Key.removeListener(keyListener);
		remove(keyListener);
		keyListener.onKeyDown = function() {
			if (Key.getCode() == Key.LEFT) {
				_root.MAIN_MC.gotoAndPlay(_root.MAIN_MC._currentframe-24);
			}
			//right         
			if (Key.getCode() == Key.RIGHT) {
				_root.MAIN_MC.gotoAndPlay(_root.MAIN_MC._currentframe+24);
			}
			//up         
			if (Key.getCode() == Key.UP) {
				if (_root.CONTROL_MC.controlMC.curnum.text != "01") {
					ExternalInterface.call("rgb_prev()");
				} else {
					ExternalInterface.call("alert", "첫페이지입니다.");
				}
			}
			//up         
			if (Key.getCode() == Key.DOWN) {
				if (_root.CONTROL_MC.controlMC.curnum.text == _root.CONTROL_MC.controlMC.totalnum.text) {
					ExternalInterface.call("alert", "마지막페이지입니다.");
				} else {
					ExternalInterface.call("rgb_next()");
				}
			}
		};
		Key.addListener(keyListener);
	}
}

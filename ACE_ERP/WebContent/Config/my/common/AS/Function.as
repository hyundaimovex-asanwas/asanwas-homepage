/* 
ActionSript : 클레스 설정
만 든 이 : nanpjs
만든날짜 : 2011.1
Q : RGB박대리
*/
import flash.external.*;
var loadArray:Array = new Array("../common/CONTROL.swf", "../common/BG.swf", "swf/MENU.swf");

// 클래스 호출
import AS.ControlFrame;
import AS.MainFunction;
import AS.PrintFunction;
import AS.FlvControl;
import AS.KeyFunction;
var MF:MainFunction = new MainFunction(_root,this.loadArray);
var PF:PrintFunction = new PrintFunction();
//var KF:KeyFunction = new KeyFunction();
KF.KeyStart();
//
function Onwer(pOnwer) {
	var CF:ControlFrame = new ControlFrame(pOnwer,pOnwer.controlMC, "conButton_mc", "conBar_mc", "conBar1_mc");
    var FC:FlvControl = new FlvControl(pOnwer,pOnwer.controlMC, "conButton_mc", "conBar_mc", "conBar1_mc","stream_mc");

	if (MF.isFlv) {
		FC.startFlv();
	} else {
		CF.startFrame();
		//pOnwer.controlMC.stream_mc._visible = false;
	}
	//
	CF.page_num();
	//현재 전페 페이지번호
}
//


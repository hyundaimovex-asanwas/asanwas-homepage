/* 
ActionSript : 파일로드 액션
만 든 이 : nanpjs
만든날짜 : 2011.1
Q : RGB박대리
*/
import flash.external.*;
class AS.MainFunction
{
	public var ChaSe_Name:String;
	public var pagenum:String;
	public var isFlv:Boolean;
	public var drag:Boolean;
	public var cannext:Boolean;

	private static var totalpage:String;
	private static var Flvpage:String;
	private static var this_onwer:MovieClip;
	private static var onwer:MovieClip;
	private static var mcPoint:MovieClip;
	private static var mcBar:MovieClip;
	private static var mcBar1:MovieClip;
	private static var mcBar2:MovieClip;


	public var target:MovieClip;
	private static var body:MovieClip;

	private static var globalsound:Sound = new Sound();
	private static var Buttonsound:Sound = new Sound();

	public static var soundRight:Boolean = true;
	public static var scriptVisible:Boolean = true;

	private var loadURL:Array;
	private var _this;
	private var loadnum:Number;



	private static var txtLoadVar:LoadVars = new LoadVars();
	private var txtStr:String = "../common/preloader_url.txt";// 프리로더를 불러올 외부경로 파일 

	public function MainFunction(url:MovieClip, loadURL:Array)
	{
		txtLoadVar.load(txtStr);
		txtLoadVar.onLoad = function(success:String)
		{
			if (success) {

				_global.load_percent = this["this_percent"];
			}
		};
		this._this = this;
		this.loadnum = 0;
		this.loadURL = loadURL;
		this.target = url;
		body = _root.MAIN;
		pagenum = String(ExternalInterface.call("thispage"));
		totalpage = String(ExternalInterface.call("totalpage"));
		ChaSe_Name = String(ExternalInterface.call("chapter"));
		Flvpage = String(ExternalInterface.call("flvPage"));
		Buttonsound.attachSound("button_s");
		drag = true;
		cannext = true;
		if (pagenum == Flvpage) {
			isFlv = true;
		} else {
			isFlv = false;
		}
		LoadMC();

	}
	public function getisFlv():Boolean
	{
		return isFlv;
	}
	public function txtclose():Void
	{
		scriptVisible = true;
		// flash.external.ExternalInterface.call("alert",scriptVisible); 
	}
	// 학습내용 로드
	public function LoadMC():Void
	{
		var Target = this.target;
		var _thisCon = this._this;
		//무비클립 생성
		this.target.createEmptyMovieClip("MAP",5);
		this.target.createEmptyMovieClip("MENU",4);
		this.target.createEmptyMovieClip("CONTROL",3);
		this.target.createEmptyMovieClip("MAIN",2);
		this.target.createEmptyMovieClip("BG",1);
		this.target.createEmptyMovieClip("EnterFrame",6);

		//LOAD MOVIE
		var MC:Object = new Object();
		var loadMC:MovieClipLoader = new MovieClipLoader();
		loadMC.loadClip("swf/" + pagenum + ".swf",this.target.MAIN);
		loadMC.addListener(MC);

		MC.onLoadStart = function(target:MovieClip):Void 
		{
			//_thisCon.Menu_Load();
		};


		MC.onLoadProgress = function(target:MovieClip, Load, Total):Void 
		{

			_global.percent_num = Math.floor((Load / Total) * 100);
			Target.CONTROL.controlMC.stream_mc._xscale = _global.percent_num;

			_root.EnterFrame.onEnterFrame = function()
			{
				if (_global.percent_num >= _global.load_percent) {
					if (_thisCon.ChaSe_Name == "09"){
						
						
					}else{
						
						if(_thisCon.pagenum == "01") {
							Target.CONTROL._x = 1500
							Target.MENU._x = 1500;
						}
						
					}

					_thisCon.Menu_Load();
					delete this.onEnterFrame;
				}
			};
		};

		MC.onLoadInit = function(target:MovieClip):Void 
		{
			//_thisCon.Menu_Load();

		};


	}
	public function LoadControl()
	{
		this.loadnum++;
		Menu_Load();
	}
	//컨트롤 -> 배경 -> 메뉴  순차적으로 로드
	public function Menu_Load():Void
	{
		var _thisCon = this._this;
		var Target = this.target;
		var MC1:Object = new Object();
		var loadMC1:MovieClipLoader = new MovieClipLoader();
		loadMC1.addListener(MC1);
		//flash.external.ExternalInterface.call("alert",this.loadnum); 
		var loadURL = this.loadURL[this.loadnum].split("/");
		var load_1 = loadURL[loadURL.length - 1];
		var load_2 = load_1.split(".");
		var loadBody = load_2[0];

		//flash.external.ExternalInterface.call("alert",loadBody); 
		if (this.loadnum < Number(this.loadURL.length)) {
			loadMC1.loadClip(this.loadURL[this.loadnum],this.target[loadBody]);

		} else {

			//flash.external.ExternalInterface.call("alert",'로드완료');
		}
		MC1.onLoadInit = function():Void 
		{
			_thisCon.LoadControl();
		};

	}
	//러닝맵
	public function MAP():Void
	{
		//flash.external.ExternalInterface.call("alert",ChaSe_Name); 
		this.target.MAP.loadMovie("../common/MAP.swf");
		this.target.MAIN.stop();
	}
	//러닝맵 닫기
	public function MAPclose():Void
	{
		this.target.MAP.unloadMovie();
		if (this.target.MAIN._currentframe == this.target.MAIN._totalframes) {
			this.target.MAIN.stop();
		} else {
			this.target.MAIN.play();
		}
	}
}
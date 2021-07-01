stop();


this._lockroot = true
// 프리로더 셋팅
this.createEmptyMovieClip("triangle_mc", this.getNextHighestDepth());
var l = 0 
var r = Stage.width
var t = 0
var b = Stage.height
triangle_mc.beginFill(0xFFFFFF, 100);
triangle_mc.moveTo(0, 0);
triangle_mc.lineTo(r, l);
triangle_mc.lineTo(r, r);
triangle_mc.lineTo(t, b);
triangle_mc.lineTo(t, t);
triangle_mc.endFill();

var container:MovieClip = this.createEmptyMovieClip("container", 100);
var mcLoader:MovieClipLoader = new MovieClipLoader();
mcLoader.addListener(this);
var txtLoadVar:LoadVars = new LoadVars();
var txtStr:String = "../common/preloader_url.txt"; // 프리로더를 불러올 외부경로 파일 

txtLoadVar.load(txtStr);

txtLoadVar.onLoad = function(success:String)
{
	if(success) 
	{
		var server:String = this["credu_server"];
		var url:String = this["address"];		
		_global.load_percent = this["this_percent"]
		
		
		
		if(server == "Y") {			
			System.security.loadPolicyFile("http://www.credu.com");
			System.security.allowDomain("http://www.credu.com");
			mcLoader.loadClip(url, container);
		} else {
			mcLoader.loadClip(url, container);
		}
	}
}

function onLoadInit(mc:MovieClip) 
{
	mc.loadInit(_global.load_percent,Stage.width/2,Stage.height/2);/*화면 중앙에 위치 잡을 때*/
	//mc.loadInit(50,값1,값2);/*값에 좌표값 고정하여 위치 잡을 때*/
}

function init() 
{
	removeMovieClip (triangle_mc);
	play();

	 trace('로드완료')
}
//



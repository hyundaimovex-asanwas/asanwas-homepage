//현재페이지
function thispage() {
	var strUrl = document.location.href;
	var arrURL = strUrl.split("/");
	_url = arrURL[arrURL.length - 1];
	var arrTargetURL = _url.split(".");
	var strTargetURL = arrTargetURL[0]
	this_page = strTargetURL.substr(2,4)	
	return this_page;
}
//현재 챕터
function chapter(){
	var strUrl = document.location.href;
	var arrURL = strUrl.split("/");
	_url = arrURL[arrURL.length - 1];
	var arrTargetURL = _url.split(".");
	var strTargetURL = arrTargetURL[0]
	ChapNum = strTargetURL.substr(0,2)
    return ChapNum
	  
}
//인트로 아웃트로 볼륨 조절
function BG_Volume(){
  volume = 50
 return volume
}
//

//flv 페이지 셋팅 
//flv 차시별 페이지 입력
FLVpage =new Array();
FLVpage[1] = []
FLVpage[2] = []
FLVpage[3] = []
FLVpage[4] = []
FLVpage[5] = []
FLVpage[6] = []
FLVpage[7] = []
FLVpage[8] = []
FLVpage[9] = ["0905"]
FLVpage[10] = ["0105","0106"]
FLVpage[11] = ["0105","0106"]
FLVpage[12] = ["0105","0106"]
FLVpage[13] = ["0105","0106"]
FLVpage[14] = ["0105","0106"]
FLVpage[15] = ["0105","0106"]
FLVpage[16] = ["0105","0106"]
FLVpage[17] = ["0105","0106"]
FLVpage[18] = ["0105","0106"]
FLVpage[19] = ["0105","0106"]
FLVpage[20] = ["0105","0106"]
FLVpage[21] = ["0105","0106"]
FLVpage[22] = ["0105","0106"]
FLVpage[23] = ["0105","0106"]
FLVpage[24] = ["0105","0106"]
FLVpage[25] = ["0105","0106"]
FLVpage[26] = ["0105","0106"]
FLVpage[27] = ["0105","0106"]
FLVpage[28] = ["0105","0106"]
FLVpage[29] = ["0105","0106"]
FLVpage[30] = ["0105","0106"]
FLVpage[31] = ["0105","0106"]
FLVpage[32] = ["0105","0106"]
//
// flv 페이지넘버 지정    
function flvPage(){ 
	 var num = parseInt(ChapNum, 10)
		//alert(this_page);
	for(var i=0; i<=FLVpage[num].length; i++){
    	if(FLVpage[num][i] == this_page){
            pageNum = FLVpage[num][i] 
		 //  alert(pageNum);
		}
	}		
	return pageNum;
}



//
//popup 셋팅
function pop(name,width,height){
  flie_name = name 
  W = width 
  H = height	
	//alert(name,width,height)
window.open('pop.html','','left=0 top=0,status=no,scrollbars=no,resizable=no,width='+W+',height='+H);
}

// 검색
function mSearch(vars){
	window.open("http://search.naver.com/search.naver?where=nexearch&query="+vars);
}
//메모
function mymemo(){
	window.open('../common/memo.htm','','scrollbars=no,width=345,height=230')
}
//요약본
function download(num)
{
    window.open("../common/down/chapter"+num+".zip","_blank","status=yes, scrollbars=yes, resizable=yes, width=500, height=400"); 
} 
//페이지 다운로드
function page_download(num)
{
    window.open("./down/"+num+".zip","_blank","status=yes, scrollbars=yes, resizable=yes, width=500, height=400"); 
} 


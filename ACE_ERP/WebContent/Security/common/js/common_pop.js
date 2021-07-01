/***********************************************************************
 * 	각 업무시스템에서 공용으로 사용하는 스크립트 메서드
 *  정리할 필요가 있습니다.
 *  지나친 스크립트는 사용자 부분의 부하를 증가시킴...
************************************************************************/

var arrParam;


//현장 팝- 기본(sid, 현장명)
	function fnCtSitePop(dir) {

	    var strURL = dir+"/Pms/help/ct010h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}

//현장 팝- 기본(sid, 현장명, 발주처, 계약차수, 변경차수, 계약금액, 공급가액, 부가세 )
	function fnCtSitePop1(dir) {
	    var strURL = dir+"/Pms/help/ct012h.jsp";
	    var strPos = "dialogWidth:720px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}


//공종 팝
	function fnCtKindPop(dir) {
	    var strURL = dir+"/Pms/help/ct011h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}

//업체 팝
	function fnCtCoopPop(dir) {
		var strURL = dir+"/Pms/help/sy030h.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
			
	}

//발주처 팝
	function fnCtOrdererPop(dir) {
		var strURL = dir+"/Pms/help/sy040h.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
			
	}


// 여기까지 새로 만드는 것들 ------------------------------------------------------------------------------------>




/**
 * 로딩바 표시 / 감추기 - 심동현 : 2008-02-19
**/
function fnShowLoading(intWidth, intHeight)
{
	document.all.loadingBar.style.left   = (document.body.clientWidth - intWidth)/2;
	document.all.loadingBar.style.top    = (document.body.clientHeight - intHeight)/2;
	document.all.loadingBar.style.width  = intWidth;
	document.all.loadingBar.style.height = intHeight;
	document.all.loadingBar.style.display="";
}

function fnHideLoading()
{
	document.all.loadingBar.style.display="none";
} 	

/**
 * 트리패널 표시 / 감추기 - 심동현 : 2008-02-19
**/

function togLeftMenu() {
	if (window.leftMenuLayer.style.display=="none") 	{
		window.leftMenuArrow.src="../../images/Common/arrow_menuClose.gif";
		window.leftMenuLayer.style.display = "" ;
	}else{
		window.leftMenuArrow.src="../../images/Common/arrow_menuOpen.gif";
		window.leftMenuLayer.style.display = "none" ;
	}
}



// 달력 띄우기 - 심동현 : 2010-02-19		이건 html 파일을 여는게 더 좋을 수도 있네요..
function fnCalPop(dir){
	alert("1");
    var strURL = dir+ "/Sales/common/include/com_calender.jsp";
    var strPos = "dialogWidth:180px;dialogHeight:230px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    alert(return_value);
    return return_value;
}    

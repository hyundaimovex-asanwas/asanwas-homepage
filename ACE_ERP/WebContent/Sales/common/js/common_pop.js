/***********************************************************************
 * 	관광시스템에서 공용으로 사용하는 스크립트 메서드
 *  정리할 필요가 있습니다.
 *  지나친 스크립트는 사용자 부분의 부하를 증가시킴...
 *  last updated : 2008-02-19
 *  수정자 : 심동현
************************************************************************/

var arrParam;

function fnClientPop(dir,gubun) {
	var strURL = dir+"/Sales/help/cu001h.jsp?gubun="+gubun;
	var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	var return_value = showModalDialog(strURL,arrParam,strPos);	
	
	return return_value;
		
}

function fnCustInfoPop(dir) {
    var strURL = dir+"/Sales/help/cu002h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * 운전자 정보 조회
 */
function fnDriveInfoPop(dir) {
    var strURL = dir+"/Sales/help/cu003h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * 신청서번호 조회
 */
function fnAcceptNoPop(dirPath) {
    var strURL = dirPath+"/Sales/help/rv001h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:389px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

function fnAcceptNoPop1(dirPath,depart_date) {
    var strURL = dirPath+"/Sales/help/rv001h.jsp?depart_date=" + depart_date;
    var strPos = "dialogWidth:495px;dialogHeight:389px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

function fnAcceptNoPop2(dirPath,client_cd) {
    var strURL = dirPath+"/Sales/help/rv001h.jsp?client_cd=" + client_cd;
    var strPos = "dialogWidth:495px;dialogHeight:389px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}






/**
 * 관광요금 결제
 */
function fnCreditPop(dirPath, arrParam) {
    var strURL = dirPath+"/Sales/help/rv005h.jsp"; 
//    var strURL = "http://erp.hdasan.com/services/Sales/help/rv005h.jsp";    
    var strPos = "dialogWidth:900px;dialogHeight:440px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;

/**
    var job_win;
    var w = 405;
    var h = 475;
    var win_left = ( screen.width - w ) / 2;
    var win_top  = ( screen.height - h ) / 2;
    var uri = dirPath+"/Sales/help/rv005h.jsp"+"?v_account_amt="+v_account_amt + "&v_client_cd="+v_client_cd +"&v_goods_nm="+v_goods_nm;
	/Sales/help/rv005h.jsp?v_account_amt=2000&v_client_cd=4&v_goods_nm=2.1;
    var win_props = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+w+',height='+h+',top='+win_top+',left='+win_left;
    
    job_win = window.open( uri, 'credit', win_props) ;
    if (parseInt(navigator.appVersion) >= 4) { job_win.window.focus(); }
    return;
*/
}

/**
 * 쇼핑몰 요금 결제
 */
function fnCreditPop_mall(dirPath, arrParam) {
    var strURL = dirPath+"/Sales/help/ml005h.jsp"; 
//    var strURL = "http://erp.hdasan.com/services/Sales/help/ml005h.jsp";    
    var strPos = "dialogWidth:900px;dialogHeight:440px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;


}

/**
 * 조장, 운전자 조회
 * gubn : 50(조장), 60(운전자)
 */
function fnDrivePeoplePop(dir, arrParam) {
    var strURL = dir+"/Sales/help/cq001h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * 차량 조회
 */
function fnCarInfoPop(dir) {
    var strURL = dir+"/Sales/help/cq002h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * 출경전 출경자 및 입경자 체류변경자 팝업
 */
function fnCustInoutPop(dir, arrParam){
    var strURL = dir+"/Sales/help/cq003h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * 사원정보 
 */
function fnEmpPop(dir){
    var strURL = dir+"/Sales/help/sy020h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * 단체행사정보 
 */
function fnGroupPop(dir){
    var strURL = dir+"/Sales/help/cu005h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
    
}






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



// 달력 띄우기 - 심동현 : 2010-02-19
function fnCalPop(dir){
    var strURL = dir+ "/Sales/common/include/com_calender.jsp";
    var strPos = "dialogWidth:180px;dialogHeight:230px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    return return_value;
}    

/******************************************************************************************
2013.12.27
Descrition : IE 패치후 발생하는 컴퍼넌트 문제를 위한것
******************************************************************************************/
function __WS__(id){
document.write(id.innerHTML);
id.id = "";
}


/*
 * 공백제거 */
//공백제거 Trim
function fn_trim(str){
	var index,len;

	while(true){

		index = str.indexOf(" ");

		if(index == -1) break;
		len = str.length;
		str = str.substring(0, index) + str.substring((index + 1),len)
	}

	return str;
}

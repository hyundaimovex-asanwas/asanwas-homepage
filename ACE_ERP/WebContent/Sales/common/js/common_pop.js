/***********************************************************************
 * 	�����ý��ۿ��� �������� ����ϴ� ��ũ��Ʈ �޼���
 *  ������ �ʿ䰡 �ֽ��ϴ�.
 *  ����ģ ��ũ��Ʈ�� ����� �κ��� ���ϸ� ������Ŵ...
 *  last updated : 2008-02-19
 *  ������ : �ɵ���
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
 * ������ ���� ��ȸ
 */
function fnDriveInfoPop(dir) {
    var strURL = dir+"/Sales/help/cu003h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * ��û����ȣ ��ȸ
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
 * ������� ����
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
 * ���θ� ��� ����
 */
function fnCreditPop_mall(dirPath, arrParam) {
    var strURL = dirPath+"/Sales/help/ml005h.jsp"; 
//    var strURL = "http://erp.hdasan.com/services/Sales/help/ml005h.jsp";    
    var strPos = "dialogWidth:900px;dialogHeight:440px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;


}

/**
 * ����, ������ ��ȸ
 * gubn : 50(����), 60(������)
 */
function fnDrivePeoplePop(dir, arrParam) {
    var strURL = dir+"/Sales/help/cq001h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * ���� ��ȸ
 */
function fnCarInfoPop(dir) {
    var strURL = dir+"/Sales/help/cq002h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * ����� ����� �� �԰��� ü�������� �˾�
 */
function fnCustInoutPop(dir, arrParam){
    var strURL = dir+"/Sales/help/cq003h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * ������� 
 */
function fnEmpPop(dir){
    var strURL = dir+"/Sales/help/sy020h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
}

/**
 * ��ü������� 
 */
function fnGroupPop(dir){
    var strURL = dir+"/Sales/help/cu005h.jsp";
    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;
    
}






/**
 * �ε��� ǥ�� / ���߱� - �ɵ��� : 2008-02-19
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
 * Ʈ���г� ǥ�� / ���߱� - �ɵ��� : 2008-02-19
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



// �޷� ���� - �ɵ��� : 2010-02-19
function fnCalPop(dir){
    var strURL = dir+ "/Sales/common/include/com_calender.jsp";
    var strPos = "dialogWidth:180px;dialogHeight:230px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    return return_value;
}    

/******************************************************************************************
2013.12.27
Descrition : IE ��ġ�� �߻��ϴ� ���۳�Ʈ ������ ���Ѱ�
******************************************************************************************/
function __WS__(id){
document.write(id.innerHTML);
id.id = "";
}


/*
 * �������� */
//�������� Trim
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

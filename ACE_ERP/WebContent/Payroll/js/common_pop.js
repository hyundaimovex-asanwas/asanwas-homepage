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

/**
 * ������� ����
 */
function fnCreditPop(dirPath, arrParam) {
    var strURL = dirPath+"/Sales/help/rv005h.jsp";
    var strPos = "dialogWidth:405px;dialogHeight:475px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    
    return return_value;

/**
    var job_win;
    var w = 405;
    var h = 475;
    var win_left = ( screen.width - w ) / 2;
    var win_top  = ( screen.height - h ) / 2;
    var uri = dirPath+"/Sales/help/rv005h.jsp"+"?v_account_amt="+v_account_amt + "&v_client_cd="+v_client_cd +"&v_goods_nm="+v_goods_nm;
    var win_props = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+w+',height='+h+',top='+win_top+',left='+win_left;
    
    job_win = window.open( uri, 'credit', win_props) ;
    if (parseInt(navigator.appVersion) >= 4) { job_win.window.focus(); }
    return;
*/
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
 
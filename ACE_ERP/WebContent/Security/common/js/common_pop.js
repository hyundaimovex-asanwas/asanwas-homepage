/***********************************************************************
 * 	�� �����ý��ۿ��� �������� ����ϴ� ��ũ��Ʈ �޼���
 *  ������ �ʿ䰡 �ֽ��ϴ�.
 *  ����ģ ��ũ��Ʈ�� ����� �κ��� ���ϸ� ������Ŵ...
************************************************************************/

var arrParam;


//���� ��- �⺻(sid, �����)
	function fnCtSitePop(dir) {

	    var strURL = dir+"/Pms/help/ct010h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}

//���� ��- �⺻(sid, �����, ����ó, �������, ��������, ���ݾ�, ���ް���, �ΰ��� )
	function fnCtSitePop1(dir) {
	    var strURL = dir+"/Pms/help/ct012h.jsp";
	    var strPos = "dialogWidth:720px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}


//���� ��
	function fnCtKindPop(dir) {
	    var strURL = dir+"/Pms/help/ct011h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}

//��ü ��
	function fnCtCoopPop(dir) {
		var strURL = dir+"/Pms/help/sy030h.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
			
	}

//����ó ��
	function fnCtOrdererPop(dir) {
		var strURL = dir+"/Pms/help/sy040h.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
			
	}


// ������� ���� ����� �͵� ------------------------------------------------------------------------------------>




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



// �޷� ���� - �ɵ��� : 2010-02-19		�̰� html ������ ���°� �� ���� ���� �ֳ׿�..
function fnCalPop(dir){
	alert("1");
    var strURL = dir+ "/Sales/common/include/com_calender.jsp";
    var strPos = "dialogWidth:180px;dialogHeight:230px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    alert(return_value);
    return return_value;
}    

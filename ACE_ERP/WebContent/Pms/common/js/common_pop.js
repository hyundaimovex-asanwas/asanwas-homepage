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
	
//ǰ�� ��
	function fnCtKindPop2(dir) {
	    var strURL = dir+"/Pms/help/ct031h.jsp";
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
	//�ŷ�ó ��
	function fnCtCoopPop1(dir) {
		var strURL = dir+"/Pms/help/sy030h_01.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
	}
	
	//ǰ�� ��
	function fnItemPop(dir) {
		var strURL = dir+"/Pms/help/sy030h_02.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
	}

	//�԰� ��
	function fnItemSizePop(dir) {
		var strURL = dir+"/Pms/help/sy030h_03.jsp";
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

	// �޷� �˾� (���� �޷¼ҽ� �̿�.. �ٸ� �͵�� �ٸ��� �Ķ���͸� �̸� �迭�� ������.
	function fnCalPopup(dirPath,servletPath){
		//alert("3");
        var arrResult   = new Array();
        arrResult = fnCalPop(dirPath);
        if (arrResult != null) {
            //alert(arrResult[3]);//��,��,��, ����� ����
            if(arrResult[3] < v_fr_rqst_date.text){
            	alert("�ҿ����� û������ ���Ŀ��� �մϴ�.\n\n�ٽ� ������ �ֽñ� �ٶ��ϴ�.");
            }else{
		   		ds_tender.namevalue(ds_tender.rowposition, "DATE_USE")  = arrResult[3];
		   	}
        }
    }

	// �޷� �˾� (���� �޷¼ҽ� �̿�.. �ٸ� �͵�� �ٸ��� �Ķ���͸� �̸� �迭�� ������.
	function fnCalPopup2(dirPath,servletPath){
		//alert("3");
        var arrResult   = new Array();
        arrResult = fnCalPop(dirPath);
        if (arrResult != null) {
            //alert(arrResult[3]);//��,��,��, ����� ����
           		ds_detail.namevalue(ds_detail.rowposition, "DATE_CON")  = arrResult[3];
		}
    }
    
    // �޷� �˾� (���籸��_�˼����� �޴����� �˼�����)
	function fnCalPopup3(dirPath,servletPath){
		//alert("3");
        var arrResult   = new Array();
        arrResult = fnCalPop(dirPath);
        if (arrResult != null) {
            //alert(arrResult[3]);//��,��,��, ����� ����
           		ds_detail.namevalue(ds_detail.rowposition, "DATE_CGC")  = arrResult[3];
        }
    }
    //���籸��_���� ��- �⺻(sid, �����)
	function fnPuSitePop(dir) {

	    var strURL = dir+"/Pms/help/pu010h_01.jsp";
	    var strPos = "dialogWidth:595px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
    //���籸��_���� ��- �⺻(sid, �����)
	function fnPuSitePop1(dir) {

	    var strURL = dir+"/Pms/help/pu010h_01.jsp";
	    var strPos = "dialogWidth:595px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	//-------------------------------------------------------------------------------------------------->
	
	//ȸ�� �����ڵ� - �⺻
	function fnSiCostPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_01.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//ȸ�� �������� - �⺻
	function fnSiAccPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_02.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//����ī�� 
	function fnSiCardPop1(dir) {

	    var strURL = dir+"/Pms/help/si010h_04.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//���θ� ����ī�� 
	function fnSiCardPop2(dir) {

	    var strURL = dir+"/Pms/help/si010h_03.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//�ڻ���ڵ� 
	function fnSiAstnbrPop(dir,vcostcd) {
	    
	    var arr	= new Array(); 
        arr[0]=vcostcd;
	    var strURL = dir+"/Pms/help/si010h_05.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arr,strPos); 
	    
	    return return_value;
	}
	
	//�ۼ��� 
	function fnSiEmpPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_06.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//�ŷ�ó  
	function fnSiCustPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_07.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//�ⳳ����   
	function fnSiBidSitePop(dir, vcostcd) {
	
	    var arr	= new Array(); 
        arr[0]=vcostcd;

	    var strURL = dir+"/Pms/help/si010h_09.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arr,strPos); 
	    
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




// �޷� ���� - �ɵ��� : 2010-02-19		�̰� html ������ ���°� �� ���� ���� �ֳ׿�..
function fnCalPop(dir){
	//alert("1");
    var strURL = dir+ "/Sales/common/include/com_calender.jsp";
    var strPos = "dialogWidth:180px;dialogHeight:230px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    //alert(return_value);
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

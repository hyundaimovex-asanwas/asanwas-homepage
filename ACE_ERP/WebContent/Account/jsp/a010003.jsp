<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - ������������	
+ ���α׷� ID	:  A010003.html
+ �� �� �� ��	:  �繫ȸ���� ���������� �Է�, ��ȸ�Ѵ�.
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� �� :	   
+ ��   ��  �� :  ������
+ �� �� �� �� :  2006.2.10
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ��ǥ�ŷ�ó �߰� �� �ŷ�ó �����۾�  
+ ��   ��  �� :  ������
+ �� �� �� �� :  2008.07.27
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ��ǥ�ڸ�, ����, ���� �ʼ��׸� �߰�
+ ��   ��  �� :  ������
+ �� �� �� �� :  2010.07.05
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ����������м���
+ ��   ��  �� :  ������
+ �� �� �� �� :  2010.08.02
-----------------------------------------------------------------------------
+ �� �� �� �� :	DB2 -> ORACLE
+ ��   ��  �� :  ������
+ �� �� �� �� :  2013.12.04
-----------------------------------------------------------------------------
+ �� �� �� �� :	��ü���п� �鼼��ü �߰� 
+ ��   ��  �� : ������
+ �� �� �� �� : 2014.06.27
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010003_s0,a010003_s1,a010003_s2,a010003_s3
			  a010003_t0,a010003_t1,a010003_t2,a010003_t3
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<title>��ü�ڵ����</title>
<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

<!--
//-->

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
    fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    
	ln_SetDataHeader();
	//ln_Enable("f");
	ln_DispChk(0);
	gcem_dsudt01.text = gs_date;
	gcem_vend_cd.enable = false;
	gcem_vendid.enable = false;
	gcem_deptyymm4.text = gcurdate.substring(0,4) + gcurdate.substring(5,7);
	gcem_deptyymm5.text = gcurdate.substring(0,4) + gcurdate.substring(5,7);
}

/******************************************************************************************
	Description : ��ȸ
	parameter   : 01 - �ŷ�ó, 02 - ����, 03 - �����, 04 - �μ������� 
******************************************************************************************/
function ln_Query(p){
	if (p=="01"){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s0?v_str1="+gcem_vend_cd_fr01.text
											 + "&v_str2="+txt_vend_nm_fr01.value+"&v_str3="+gcem_svendid.text; 
		gcds_code01.Reset();
		//ln_DupliChk('');
	}else if(p=="02"){
		gcds_code02.DataID = //"<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=B&v_str2="+gcem_atcode_fr02.text+"&v_str3="+gcem_atcode_to02.text; 
		"<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?"+"v_str1=" + gcem_fdcode1.text + "&v_str2="+txt_fdname1.value;
		ln_Enable("f");
		gcds_code02.Reset();
	}else if(p=="03"){
		gcds_code03.DataID =
		"<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s2?"+"v_str1="+gcem_cocode_fr03.text + "&v_str2=" + txt_cosang_to03.value; 
		gcds_code03.Reset();
	}else if(p=="04"){
	  if(fn_trim(gcem_deptyymm4.text)==""){
			alert("�μ��������� �Է��Ͻʽÿ�.");
			return;
		}
		gcds_code04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s3?"+"v_str1="+gcem_deptcd1.text+"&v_str2="+txt_deptnm1.value+"&v_str3="+gcem_deptyymm4.text;
		//prompt('',gcds_code04.DataID);
		gcds_code04.Reset();
	}else if(p=="05"){
	  if(fn_trim(gcem_deptyymm5.text)==""){
			alert("�μ��������� �Է��Ͻʽÿ�.");
			return;
		}
		gcds_code05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s4?"+"v_str1="+gcem_deptcd3.text+"&v_str2="+txt_deptnm3.value+"&v_str3="+gcem_deptyymm5.text;
		gcds_code05.Reset();
	}else if(p=="06"){
	  if(fn_trim(gcem_deptyymm6.text)==""){
			alert("�������� �Է��Ͻʽÿ�.");
			return;
		}
		gcds_code06.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s8?"+"v_str1="+gclx_bgtdivcd6.bindcolval+"&v_str2="+gcem_deptcd6.text
		                                                     +"&v_str3="+txt_deptnm6.value+"&v_str4="+gcem_deptyymm6.text;
		gcds_code06.Reset();
	}
}

/******************************************************************************************
	Description : ��ȸ - ��Ϲ�ȣ �ߺ� üũ
******************************************************************************************/
function ln_DupliChk(e){
	gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s5?v_str1="+e; 
	gcds_temp01.Reset();
}

/******************************************************************************************
	Description : ��ȸ - ��Ϲ�ȣ �ߺ� üũ
******************************************************************************************/
function ln_DupliChk2(e){
	gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s6?v_str1="+e; 
	gcds_temp01.Reset();
}

/*****************************************************************************************
	Description : �߰�
	parameter   : 01 - �ŷ�ó, 02 - ����, 03 - ����� 
*****************************************************************************************/
function ln_Add(p){
  if (p=="01"){
		gcds_code01.addrow();
		gcem_vend_cd.enable = true;
		gcem_vendid.enable = true;
		gcra_cocomyn.CodeValue = "N";
		gcra_useyn.CodeValue = "Y";
		ln_Enable("t",p);
		gcem_vend_cd.focus();
		gcem_vend_cd_fr01.text="";
		txt_vend_nm_fr01.value="";
		gcem_svendid.text="";
	}else if(p=="02"){
		gcds_code02.addrow();
		//gcem_dsudt01.text = gs_date;
		ln_Enable("t",p);
		gcem_fdcode.focus();
	}else if(p=="03"){
		gcds_code03.addrow();
		ln_Enable("t",p);
		gcem_cocode.focus();
	}else if(p=="06"){
		gcds_code06.addrow();
		
		gcem_bgtfrym6_2.text ="201401";
		gcem_bgttoym6_2.text ="201412";
		
	}
}

/******************************************************************************************
	Description : ����
	parameter   : 01 - �ŷ�ó, 02 - ����, 03 - �����, 04 - �μ�������
******************************************************************************************/
function ln_Save(p){
	if (p=="01"){
		if (gcds_code01.IsUpdated){
			if(gcds_code01.SysStatus(gcds_code01.rowposition)!=3){
				if(ln_Chk(p)){
					if (confirm("�����Ͻðڽ��ϱ�?")){	
						gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t0?";
						gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;		
						
						gctr_code01.post();
						gcem_vend_cd_fr01.text = gcem_vend_cd.text;
						
						ln_Query('01');				
					}	
				}
			}else{
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t0?";
					gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;	
					gctr_code01.post();
					gcem_vend_cd_fr01.text = gcem_vend_cd.text;
					ln_Query('01');
				}
			}
		}

	}else if(p=="02"){
		if (gcds_code02.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t1?";
					gctr_code02.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
					gctr_code02.post();
					ln_Query('02');

				  /*gcds_code02.namevalue(gcds_code02.rowposition,"ATCODE") = gcds_code02.namevalue(gcds_code02.rowposition,"ATCODE");
					gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t2?";
					gctr_code02.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
					gctr_code02.post();*/
				}	
			}
		}
	
	}else if(p=="03"){
		if (gcds_code03.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					gctr_code03.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t2?";
					gctr_code03.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
					gctr_code03.post();
					//ln_Query('03');
				}	
			}
		}

	}else if(p=="04"){
		if (gcds_code04.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					gctr_code04.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t3";
					gctr_code04.post();
					//ln_Query('04');
				}	
			}
		}

	}else if(p=="05"){
		if (gcds_code05.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					gctr_code05.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t4";
					gctr_code05.post();
					//ln_Query('05');
				}	
			}
		}
	}else if(p=="06"){  //����������м���
		if (gcds_code06.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					gctr_code06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t6";
					gctr_code06.Parameters = "v_str1="+gs_userid;
					gctr_code06.post();
					//ln_Query('05');
				}	
			}
		}
	}

}

/******************************************************************************************
	Description : ����
	parameter   : 01 - �ŷ�ó, 02 - ����, 03 - ����� 
*****************************************************************************************/
function ln_Delete(p){
	if (p=="01"){
		if (confirm("�����Ͻðڽ��ϱ�?")){	
			gcds_code01.deleterow(gcds_code01.rowposition);
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t0?";
			gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
			gctr_code01.post();
			ln_Query('01');
		}	
		
	}else if(p=="02"){
		if (confirm("�����Ͻðڽ��ϱ�?")){	
			gcds_code02.deleterow(gcds_code02.rowposition);
			gctr_code02.action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t1";
			gctr_code02.post();
			ln_Query('02');

		}

	}else if(p=="03"){
		if (confirm("�����Ͻðڽ��ϱ�?")){			
			gcds_code03.deleterow(gcds_code03.rowposition);
			gctr_code03.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t2?";
			gctr_code03.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
			gctr_code03.post();
			ln_Query('03');
		}
	}else if(p=="06"){
		if (confirm("�����Ͻðڽ��ϱ�?")){			
			gcds_code06.deleterow(gcds_code06.rowposition);
			gctr_code06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_t6?";
			gctr_code06.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_code06.text);
			gctr_code06.post();
			ln_Query('06');
		}
	}
}

/******************************************************************************
	Description : �Է�üũ 
	parameter   : 01 - �ŷ�ó, 02 - ����, 03 - ����� , 06- ����������м���
******************************************************************************/
function ln_Chk(p){
	if (p=="01"){
		if (fn_trim(gcem_vend_cd.text)=="" ){
			alert("�ŷ�ó�ڵ带 �Է��Ͻʽÿ�.");
			gcem_vend_cd.focus();
			return false; 
		}

		if (fn_trim(txt_vend_nm.value)==""){
			alert("�ŷ�ó���� �Է��Ͻʽÿ�.");
			txt_vend_nm.focus();
			return false; 
		}

    //��Ϲ�ȣ�� ������ ���
		if(gcem_vendid.text!=""){
    //2010.07.05
		//��ǥ�ڸ�, ����, ���� �ʼ��׸� �߰� 
			if (fn_trim(txt_vd_direct.value)==""){
				alert("��ǥ�ڸ��� �Է��Ͻʽÿ�.");
				txt_vd_direct.focus();
				return false; 
			}

			if (fn_trim(txt_bsns_cnd.value)==""){
				alert("���¸��� �Է��Ͻʽÿ�.");
				txt_bsns_cnd.focus();
				return false; 
			}

			if (fn_trim(txt_bsns_knd.value)==""){
				alert("�������� �Է��Ͻʽÿ�.");
				txt_bsns_knd.focus();
				return false; 
			}
		}
    
		for(var i=1;i<=gcds_code01.countrow;i++){
			if(gcds_code01.SysStatus(i)!="3"){
				var s_vendid = fn_trim(gcem_vendid.text);
				 ln_DupliChk2(s_vendid);
				
				if(s_vendid.length==10){//����ڹ�ȣ
					if(gcds_temp01.namevalue(1,"CNT")>0){
						alert("�ߺ��� ����ڹ�ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
						return false;
					}
				}else if(s_vendid.length==13){//�ֹι�ȣ
					if(gcds_temp01.namevalue(1,"CNT")>0){
						alert("�ߺ��� �ֹι�ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
						return false;
					}
				}else if(s_vendid.length!=0&&s_vendid.length!=10&&s_vendid.length!=13){
					alert("�ڸ����� ���� �ʽ��ϴ�.");
					return false;
				}
			}
		}
    return true;
	}else if(p=="02"){
		if (fn_trim(gcem_fdcode.text)=="" ){
			alert("�����ڵ带 �Է��Ͻʽÿ�.");
			gcem_fdcode.focus();
			return false; 
		}

		if (fn_trim(txt_fdname.value)==""){
			alert("������ �Է��Ͻʽÿ�.");
			txt_fdname.focus();
			return false; 
		}
	}else if(p=="03"){
		if (fn_trim(gcem_cocode.text)=="" ){
			alert("������ڵ带 �Է��Ͻʽÿ�.");
			gcem_cocode.focus();
			return false; 
		}
	}else if(p=="06"){
		if(fn_trim(gcem_bgtfrym6_2.text)=="" ){
			alert("������۳���� �Է��Ͻʽÿ�.");
			gcem_bgtfrym6_2.focus();
			return false; 
		}

		if(fn_trim(gcem_bgttoym6_2.text)=="" ){
			alert("������������ �Է��Ͻʽÿ�.");
			gcem_bgttoym6_2.focus();
			return false; 
		}
	}
	return true; 
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(p){		
		
   if(p=="01"){
   	gcgd_disp01.GridToExcel("�ŷ�ó","",2);
   } else if (p=="06"){
	gcgd_disp06.GridToExcel("����������м���","",2);
   }
} 

/***********************************************************************************************
	Description : Enable _ Disable 
	parameter   : p2==> t - Enable, f - Disable
	              p==> 01 - �ŷ�ó, 02 - ����, 03 - �����
***********************************************************************************************/
function ln_Enable(p2,p) {
	if (p=="01"){
		if (p2=="t")	txt_vend_nm.disabled=false;
		else if (p2=="f")	txt_vend_nm.disabled=true;
	}else if(p=="02"){
		if (p2=="t")	gcem_fdcode.enalbe=true;
		else if (p2=="f")	gcem_fdcode.enalbe=false;
	}else if(p=="03"){
		if (p2=="t")	gcem_cocode.enalbe=true;
		else if (p2=="f")	gcem_cocode.enalbe=false;
	}
}

/***********************************************************************************************
	Description : �����ȣ ã��
	parameter   : p==> 01 - �ŷ�ó, 02 - ����, 03 - ����� 
**********************************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "<%=dirPath%>/Common/jsp/com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:425px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	/*if (arrResult != null) {
		arrParam = arrResult.split(";");
		var post_no1 = arrParam[0];
		eval("gcem_"+"post_no1").text = post_no1.substring(0,3);
		eval("gcem_"+"post_no2").text = post_no1.substring(3,6);
		
		//alert(aa.substring(0,3)+"-"+aa.substring(3,6));
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		eval("txt_"+"address1").value = val;
	*/

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		var post_no1 = arrParam[0];
		eval("gcem_"+"post_nm").text = arrParam[0];
		eval("gcem_"+"post_no1").text = post_no1.substring(0,3);
		eval("gcem_"+"post_no2").text = post_no1.substring(3,6);
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		eval("txt_"+"address1").value = val;
	}
}

function ln_Popup02(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "<%=dirPath%>/Common/jsp/com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval("gcem_"+"coaddrno").text = arrParam[0];
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		eval("txt_"+"coaddr1").value = val;

	}
}

/******************************************************************************
	Description : �ŷ�ó�ڵ� ã��
	parameter   : p - fr : �з��ڵ� , p- to
******************************************************************************/
function ln_Popup03(p2,p){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Gczm_vender_popup.html";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (p=="01"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			 if(p2=="fr") {
					gcem_vend_cd_fr01.text = arrParam[0];
					txt_vend_nm_fr01.value = arrParam[1];
		
		} else {
			if(p2=="fr") {
				gcem_vend_cd_fr01.text = "";
				txt_vend_nm_fr01.value ="";
				
				}
			}
		}
	}
}

/******************************************************************************
	Description : ������ڵ� ã��
	parameter   : p - fr : �з��ڵ� , p- to
******************************************************************************/
function ln_Popup04(p2,p){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Company_popup.html";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (p=="03"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			 if(p2=="fr") {
					gcem_cocode_fr03.text = arrParam[0];
					txt_cosang_to03.value = arrParam[1];
		} else {
			if(p2=="fr") {
				gcem_cocode_fr03.text = "";
				txt_cosang_to03.value ="";
				
				}
			}
		}
	}
}


/******************************************************************************
	Description : �����ڵ�ã�� - �ŷ�ó
	parameter   : e -1 ; ��������
	              e -2 ; ��������
 ******************************************************************************/
function ln_Popup_Bank(e){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./banklist1_popup.jsp";
	strPos = "dialogWidth:318px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="1"){
			gcem_c_bankcd.text = arrParam[0];
			txt_c_banknm.value = arrParam[2];
			//txt_banna2.value  = ln_Trim(arrParam[2]);
		}else{

		}
	} else {
	  if(e=="1"){
			gcem_c_bankcd.text = "";
			txt_c_banknm.value = "";
			//txt_banna2.value = ""; //
		}else{

		}
	}
}

/******************************************************************************
	Description : Dataset Head ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "CORP_CD:STRING(1),VEND_GB:STRING(1),VEND_CD:STRING(13),VEND_NM:STRING(62),"
						 + "VD_DIRECT:STRING(62),BSNS_CND:STRING(62),BSNS_KND:STRING(62),VD_TELNO:STRING(32),"
						 + "VD_FAXNO:STRING(32),POST_NO1:STRING(10),POST_NO2:STRING(10),ADDRESS1:STRING(132),"
						 + "ADDRESS2:STRING(72),C_BANKCD:STRING(5),C_ACCTNO:STRING(22),C_ACCTNO_NM:STRING(32),"
						 + "C_ACCTNM:STRING(32),B_BANKCD:STRING(5),B_ACCTNO:STRING(22),B_ACCTNO_NM:STRING(32),"	
						 + "B_ACCTNM:STRING(32),O_VENDGB:STRING(1),O_VENDCD:STRING(13),VEND_MAG:STRING(10),"
						 + "USE_TAG:STRING(1),REMARK:STRING(66),CREAT_DT:STRING(12),CREAT_NM:STRING(10),"
						 + "MSN:STRING(13),MPWD:STRING(20),COCOMYN:STRING(1),VEND_ID:STRING(15),VEND_NO:STRING(13),POST_NM:STRING(20)";
}

function ln_SetDataHeader03(){
	gcds_code04_3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=&v_str2=";
	gcds_code04_3.Reset();//�μ��������ڵ��� �����ڵ�� ������ڵ� �޺�
	gcds_code04_4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s2?v_str1=&v_str2=";
	gcds_code04_4.Reset();//�μ��������ڵ��� �����ڵ�� ������ڵ� �޺�
}

function ln_SetDataHeader04(){
	gcds_code05_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0003&v_str4='C'";
	gcds_code05_2.Reset();//����μ��� ����μ�

	gcds_code05_3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0003&v_str4='C'";
	gcds_code05_3.Reset();//����μ��� ����μ�
}

function ln_SetDataHeader05(){
	gcds_code06_1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2171";
	//prompt('',gcds_code06_1.DataID);
	gcds_code06_1.Reset();//������������� �����������(�˻�����)

	gcds_code06_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2171";
	gcds_code06_2.Reset();//������������� �����������(�Է�) 

  gcds_code06_3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0003&v_str4='C'";
	gcds_code06_3.Reset();//����μ��� ����μ�

}

/******************************************************************************
	Description : �Ǳ���
	parameter   :
******************************************************************************/

function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp5","div_disp6");
  
	for(var i=0;i<=5;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
	
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}

	if(index==3) {
		ln_SetDataHeader03();
	}
	if(index==4) {
		ln_SetDataHeader04();
	}
	if(index==5) {
		ln_SetDataHeader05();
		gcem_deptyymm6.text = gcurdate.substring(0,4) + gcurdate.substring(5,7);
	}
}

</script>

<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>

<script>
function openDaumPostcode() {
    	
    var width =500;
    var height =600; 	
    	
    new daum.Postcode({
    	
    	 width:width,
         height:height,
    	
    	
        oncomplete: function(data) {
            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ��Դϴ�.
            // ������ �����Ͽ� �پ��� Ȱ����� Ȯ���� ������.
            
        	 var strpostcode="";  //���� �����ȣ ( 6�ڸ� )
             var strzonecode="";  //�ű� �����ȣ ( 5�ڸ� )
             strzonecode = data.zonecode;    
             document.getElementById('gcem_post_nm').text = strzonecode;
             document.getElementById('txt_address1').value = data.address;
             document.getElementById('txt_address2').focus();
        }
    }).open({
    	    left:(window.screen.width/2)-(width/2),
		    top:(window.screen.height/2)-(height/2)
    	
    		});
 }

</script> 

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--�ŷ�ó-->
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����-->
<comment id="__NSID__"><object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--�����-->
<comment id="__NSID__"><object  id=gcds_code03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--�μ��������ڵ�-->
<comment id="__NSID__"><object  id=gcds_code04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--�μ��������ڵ��� �����ڵ�-->
<comment id="__NSID__"><object  id=gcds_code04_3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--�μ��������ڵ��� ������ڵ�-->
<comment id="__NSID__"><object  id=gcds_code04_4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����μ�-->
<comment id="__NSID__"><object  id=gcds_code05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 


<!--����μ��� ����μ�-->
<comment id="__NSID__"><object  id=gcds_code05_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����μ��� ����μ�-->
<comment id="__NSID__"><object  id=gcds_code05_3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!--�����������-->
<comment id="__NSID__">
  <!-- ��ȸ -->
  <object  id=gcds_code06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  </object>

	<!-- ��������1 �˻� -->
  <object  id=gcds_code06_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr   value="+CDCODE">
  </object>

	<!-- ��������2 ���� -->
  <object  id=gcds_code06_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr   value="+CDCODE">
 </object>

	<!-- ����μ� ���� -->
  <object  id=gcds_code06_3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr   value="+CDCODE">
 </object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t0(I:USER=gcds_code01)"> 
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gctr_code02 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t1(I:USER=gcds_code02)">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gctr_code03 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t2(I:USER=gcds_code03)"> 
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gctr_code04 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t3(I:USER=gcds_code04)"> 
</object></comment><script>__ws__(__NSID__);</script> <!--�μ��������ڵ�-->

<comment id="__NSID__"><object  id=gctr_code05 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t4(I:USER=gcds_code05)"> 
</object></comment><script>__ws__(__NSID__);</script> <!--����μ�-->

<comment id="__NSID__"><object  id=gctr_code06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t6(I:USER=gcds_code06)"> 
</object></comment><script>__ws__(__NSID__);</script> <!--����������м���-->
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	gcem_vend_cd.enable = false;
	gcem_vendid.enable = false;
</script>

<script language="javascript" for="gcds_code02" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language=JavaScript for=gcgd_code02 event=OnClick(row,colid)>
	if(row>0){
		ln_Query(gcds_code02.namevalue(row,"FDCODE"));
	}////////
</script> 

<script language=JavaScript for=gcgd_code02 event=onKeyPress(keycode)>
	if (gcds_code02.countrow>=1){
		if ((keycode==38)||(keycode==40)){
			ln_Query02(gcds_code02.namevalue(gcds_code02.rowposition,"FDCODE"));
		}
	}////////
</script>

 <script language=JavaScript for=gcds_code02_1 event=OnClick(row,colid)>
	if(row>0){
		ln_Query(gcds_code02_1.namevalue(row,"FDCODE"));
	}///////
</script> 

<script language=JavaScript for=gcgd_code02 event=onKeyPress(keycode)>
	if (gcds_code02.countrow>=1){
		if ((keycode==38)||(keycode==40)){
			ln_Query02(gcds_code02.namevalue(gcds_code02.rowposition,"FDCODE"));
		}
	}///////
</script>
 
<script language=JavaScript for=gcds_code02_2 event=OnClick(row,colid)>
	if(row>0){
		ln_Query(gcds_code02_1.namevalue(row,"FDCODE"));
	}///////
</script>

<script language="javascript" for="gcds_code03" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code03" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt03.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	gcgd_disp03.Focus()
</script>

<script language="javascript" for="gcds_code04" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code04" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt04.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<!-- �μ��������ڵ��� �����ڵ��޺��� ������ ������ -->
<script language="javascript" for="gcds_code04_3" event="onloadCompleted(row,colid)">
	gcds_code04_3.insertrow(1);
	gcds_code04_3.namevalue(1,"FDCODE") = "";
	gcds_code04_3.namevalue(1,"FDNAME") = "";
	gclx_fdcode1.index = 0;
</script>

<!-- �μ��������ڵ��� ������ڵ忡 ������ ������ -->
<script language="javascript" for="gcds_code04_4" event="onloadCompleted(row,colid)">
	gcds_code04_4.insertrow(1);
	gcds_code04_4.namevalue(1,"COCODE") = "";
	gcds_code04_4.namevalue(1,"CONAME") = "";
	gclx_cocode1.index = 0;
</script>

<script language="javascript" for="gcds_code05" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code05" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt05.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>


<script language="javascript" for="gcds_code06" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code06" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt06.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>


<!-- ����μ��� ������ ������ -->
<script language="javascript" for="gcds_code05_2" event="onloadCompleted(row,colid)">
	gcds_code05_2.insertrow(1);
	gcds_code05_2.namevalue(1,"CDCODE") = "";
	gcds_code05_2.namevalue(1,"CDNAM") = "";
	gclx_bgtdept.index = 0;
</script>

<script language="javascript" for="gcds_code05_3" event="onloadCompleted(row,colid)">
	gcds_code05_3.insertrow(1);
	gcds_code05_3.namevalue(1,"CDCODE") = "";
	gcds_code05_3.namevalue(1,"CDNAM") = "";
	gclx_bgtdivcd.index = 0;
</script>

<script language="javascript" for="gcds_code06_1" event="onloadCompleted(row,colid)">
	gcds_code06_1.insertrow(1);
	gcds_code06_1.namevalue(1,"CDCODE") = "";
	gcds_code06_1.namevalue(1,"CDNAM") = "��ü";
	gclx_bgtdivcd6.index = 0;
</script>

<script language="javascript" for="gclx_fdcode1" event="OnCloseUp()">
	gcds_code04.namevalue(gcds_code04.rowposition,"FDNAME") = gclx_fdcode1.valuebycolumn("FDCODE",gclx_fdcode1.bindcolval,"FDNAME");
	//�μ��������ڵ��� ������ڵ��޺��� ���� �׸��忡
</script>

<script language="javascript" for="gclx_cocode1" event="OnCloseUp()">
	gcds_code04.namevalue(gcds_code04.rowposition,"CONAME") = gclx_cocode1.valuebycolumn("COCODE",gclx_cocode1.bindcolval,"CONAME");
	//�μ��������ڵ��� �����ڵ��޺��� ���� �׸��忡
</script>

<script language="javascript" for="gclx_bgtdept" event="OnCloseUp()">

	gclx_bgtdivcd.bindcolval=gcds_code05_2.namevalue(gcds_code05_2.rowposition,"GBCD");

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1));
</script>

<!-- �ŷ�ó�ڵ� -->
<script language=JavaScript for="gcgd_disp01" event=OnClick(row,colid)>
	if (row < 1) ln_Enable("f");
	return;////////////
</script> 

<!-- ���� -->
<script language=JavaScript for="gcgd_disp02" event=OnClick(row,colid)>
	if (row < 1)  ln_Enable("f");
	return;/////////////
</script>

<!-- ����� -->
<script language=JavaScript for="gcgd_disp03" event=OnClick(row,colid)>
	if (row < 1)  ln_Enable("f");
	return;/////////////
</script>

<script language=JavaScript for=gcem_vendid event=OnKillFocus()>
	//����ڹ�ȣ && �ֹι�ȣ üũ
	if (gcds_code01.IsUpdated){
		var s_vendid = fn_trim(gcem_vendid.text);
		if(s_vendid.length==10){//����ڹ�ȣ
			if(gf_Wkresino(s_vendid)==true){
				for(var i=1;i<=gcds_temp01.countrow;i++){
					if(gcds_temp01.namevalue(i,"VEND_ID")==s_vendid){
						alert("�ߺ��� ����ڹ�ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
						return false;
					}
				}
			}else{
				return false;
			}
		}else if(s_vendid.length==13){//�ֹι�ȣ OR �ܱ��� ��ȣ
			if (s_vendid.substring(6,7)=="1"||s_vendid.substring(6,7)=="2"||s_vendid.substring(6,7)=="3"||s_vendid.substring(6,7)=="4"){
				if(gf_Resino(s_vendid)==true){
					for(var i=1;i<=gcds_temp01.countrow;i++){
						if(gcds_temp01.namevalue(i,"VEND_ID")==s_vendid){
							alert("�ߺ��� �ֹι�ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
							return false;
						}
					}
				}else{
					return false;
				}
			}else if (s_vendid.substring(6,7)=="5"||s_vendid.substring(6,7)=="6"||s_vendid.substring(6,7)=="7"||s_vendid.substring(6,7)=="8"){
				if(gn_FgResino(s_vendid)==true){
					for(var i=1;i<=gcds_temp01.countrow;i++){
						if(gcds_temp01.namevalue(i,"VEND_ID")==s_vendid){
							alert("�ߺ��� �ܱ��ι�ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
							return false;
						}
					}
				}else{
					return false;
				}
			}else{
				alert("��ȣ�� Ȯ���Ͻʽÿ�.");
				return false;
			}
		}else if(s_vendid.length<10&&s_vendid.length>0){
			alert("�ڸ����� ���� �ʽ��ϴ�.");
			return false;
		}
	}

</script> 

<script language=JavaScript for=gclx_bgtdept6_2 event=OnSelChange()>
	gcds_code06.namevalue(gcds_code06.rowposition,"BGTDPTNM")=gclx_bgtdept6_2.text;
</script>

<script language=JavaScript for=gclx_bgtdivcd6_2 event=OnSelChange()>
	gcds_code06.namevalue(gcds_code06.rowposition,"BGTDIVNM")=gclx_bgtdivcd6_2.text;
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code01" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code01" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
  alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");

</script>

<script language="javascript" for="gctr_code02" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code02" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_code02_1" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code02_1" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_code02_2" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code02_2" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_code03" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code03" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_code04" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code04" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_code05" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code05" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_code06" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_code06" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_code06.ErrorCode + "\n" + "Error Message : " + gctr_code06.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif"><img src="../img/a010003_head.gif"></td>
    <td background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252   VIEWASTEXT style="width:660px;height:20px;">
						<PARAM NAME="BackColor"		VALUE="#cccccc">
   						<PARAM NAME="titleHeight" VALUE="20px">
						<PARAM NAME="DisableBackColor" VALUE="#eeeeee">
						<PARAM NAME="Format"			VALUE="
								<T>divid=div_1		title=�ŷ�ó</T>
								<T>divid=div_2		title=����</T>
								<T>divid=div_3		title=�����</T>
								<T>divid=div_4		title=�μ��������ڵ�</T>
								<T>divid=div_5    title=����μ�</T>
								<T>divid=div_6    title=����������м���</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------- �ŷ�ó ----------------------------->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:487px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td align="center" colspan=2>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
				<tr> 				
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�ŷ�ó�ڵ�</td>
					<td class="tab23" style="width:98px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_cd_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('01');">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="#############">
							<param name=PromptChar    value="">
							<param name=maxlength     value="13">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
						<!-- <img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup03('fr','01');"> -->
					</td>
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
					<td class="tab23">
						<input id="txt_vend_nm_fr01" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query('01');" onBlur="bytelength(this,this.value,30);"> 
					</td>
					<td width="85" class="tab12" bgcolor="#eeeeee" align="center">��Ϲ�ȣ</td>
					<td><comment id="__NSID__">
						<object  id=gcem_svendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:6px;top:0px" onkeydown="if(event.keyCode==13) ln_Query('01');">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="#############">
							<param name=PromptChar    value="_">
							<param name=maxlength     value="13">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td width="1px" align=right>&nbsp;</td>
					<td width="263px" align="right" valign="bottom"  style="position:relative;right:0px;top:0px;">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel('01')">
						<!-- 	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('01')"> --> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('01')" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('01')" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('01')">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('01')">&nbsp;
					</td>
				</tr>
			</table>
		</td>
		</tr>
		
		<tr><td height="2px" colspan =2></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:400px;border:0 solid #708090;">
					<tr> 			
						<td>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:7px;width:400px; top:1px;height:421px; border:1 solid #708090;">
							<PARAM NAME="DataID"			VALUE="gcds_code01">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<param name="Editable"    value="true">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�ڵ�'					    ID=VEND_CD   		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center sort=true </C> 
								<C> Name='�ŷ�ó��'					ID=VEND_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=LEFT	sort=true </C> 
								<C> Name='��Ϲ�ȣ'					ID=VEND_ID	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	sort=true </C> 
								<C> Name='��ǥ��'						ID=VD_DIRECT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	sort=true</C> 
								<C> Name='����'							ID=BSNS_CND     HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	sort=true</C> 
								<C> Name='����'	    				ID=BSNS_KND     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	sort=true</C> 
								<C> Name='��ȭ��ȣ'	    		ID=VD_TELNO     HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='�ѽ���ȣ'	    		ID=VD_FAXNO     HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='�����ȣ'					ID=POST_NM    	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true Mask='XXX-XXX'</C> 
								<C> Name='�ּ�1'						ID=ADDRESS1   	HeadAlign=Center HeadBgColor=#B9D4DC Width=280	align=LEFT	sort=true</C> 
								<C> Name='�ּ�2'						ID=ADDRESS2  		HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true</C> 
								<C> Name='���������ڵ�'	    ID=C_BANKCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	sort=true	</C> 
								<C> Name='���ݰ��¹�ȣ'	    ID=C_ACCTNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true	</C> 
								<C> Name='���ݰ��¸�'		    ID=C_ACCTNO_NM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=LEFT	sort=true </C> 
								<C> Name='���ݰ��¿�����'		ID=C_ACCTNM 		HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true </C> 
								<C> Name='���������ڵ�'	    ID=B_BANKCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	sort=true	</C> 
								<C> Name='�������¹�ȣ'		  ID=B_ACCTNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true </C> 
								<C> Name='�������¸�'				ID=B_ACCTNO_NM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=LEFT	sort=true </C> 
								<C> Name='�������¿�����'		ID=B_ACCTNM 		HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true </C> 
								<C> Name='���ŷ�����'		    ID=O_VENDGB 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	sort=true </C> 
								<C> Name='���ŷ�ó�ڵ�'		  ID=O_VENDCD 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	sort=true </C> 
								<C> Name='������ȣ'					ID=VEND_MAG 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	sort=true </C> 
								<C> Name='�������'					ID=USE_TAG			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	sort=true </C> 
								<C> Name='���'							ID=REMARK				HeadAlign=Center HeadBgColor=#B9D4DC Width=290	align=LEFT	sort=true </C> 	<C> Name='���¾�ü�ڵ�'			ID=COCOMYN			HeadAlign=Center HeadBgColor=#B9D4DC Width=290	align=LEFT	sort=true </C> 	">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:402px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
						</fieldset>
				</td>
			</tr>
		</table>
		</td>

		<td>
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:10px;top:1px;width:460px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="width:75px;" bgcolor="#eeeeee" align=center >��ǥ�ŷ�ó</td>
			 	<td class="tab18">&nbsp; 
					<comment id="__NSID__"><object  id=gcem_h_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:-2px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#############">
						<param name=maxlength     value="13">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab18" style=" bgcolor="#eeeeee" align="center" >��ǥ�ŷ�ó��</td>
				<td class="tab18" style="height:25px;">
					<input id="txt_h_vend_nm" type="text" class="txtbox" style="width:140px;height:20px;position:relative;left:6px" maxlength="32">
				</td>
			</tr>
          <tr> 
             <td height="2px" style="border:1 solid #708090;border-right-width:1px;border-top-width:0px;" colspan="4"></td>
		  </tr> 

			 <tr>
				<td class="tab15" style="" bgcolor="#eeeeee" align=center ><font color="#ff0000">*</font>&nbsp;�ŷ�ó�ڵ�</td>
			 	<td class="tab18">&nbsp; 
				<!-- <td Style="height:30px;width:330px;border:0 solid #708090;border-bottom-width:1px"> -->
					<comment id="__NSID__"><object  id=gcem_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86	px;height:20px;position:relative;left:-2px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#############">
						<param name=maxlength     value="13">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab18" style="" bgcolor="#eeeeee" align=center>��Ϲ�ȣ</td>
				<td class="tab18" style="height:25px;"><comment id="__NSID__">
					<object  id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:6px;top:0px">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#############">
						<param name=PromptChar    value="_">
						<param name=maxlength     value="13">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr>
			<td class="tab17" style="" bgcolor="#eeeeee" align=center ><font color="#ff0000">*</font>&nbsp;�ŷ�ó��</td>
			<td class="tab19" style= "width:280px;" colspan="3" > 
				<input id="txt_vend_nm" type="text" class="txtbox" style="width:350px;height:20px;position:relative;left:6px" maxlength="32">
			</td>
			</tr>
			<tr>
				<td class="tab17" style="" bgcolor="#eeeeee" align=center ><font color="#ff0000">*</font>&nbsp;��ǥ�ڸ�</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
					 <input id="txt_vd_direct" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px;" maxlength="62" >
				</td>
			</tr>
			<tr>
				<td class="tab17" style="" bgcolor="#eeeeee" align=center class="txtbox"><font color="#ff0000">*</font>&nbsp;����</td>
				<td class="tab19"  >&nbsp;
					<input id="txt_bsns_cnd" type="text" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="22" onfocus ="bytelength(this,this.value,30);" >
				</td> 
				
				 <td class="tab19" style="" bgcolor="#eeeeee" align=center ><font color="#ff0000">*</font>&nbsp;����</td>
				<td class="tab19" style="height:25px;" >&nbsp; 
					 <input id="txt_bsns_knd" type="text" class="txtbox"  style= "width:94px; height:20px;position:relative;left:-2px" maxlength="22" > 
				</td>
				</tr>

				<tr>
				<td class="tab17" style="" bgcolor="#eeeeee" align=center>��ȭ��ȣ</td>
				<td class="tab19"  >&nbsp;
				<input id="txt_vd_telno" type="text" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="14" onBlur="bytelength(this,this.value,14);" >
					<!-- <comment id="__NSID__"><object  id=gcem_vd_telno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:96px;height:20px;position:relative;left:2px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="##############">
						<param name=maxlength     value="14">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
		
				<td class="tab19" style="" bgcolor="#eeeeee" align=center >�ѽ���ȣ</td>
				<td class="tab19"  > &nbsp;
					<input id="txt_vd_faxno" type="text" class="txtbox"  style= "width:94px; height:20px;position:relative;left:-2px" maxlength="14" > 	
				</td>
			</tr>

			<tr>
				<td class="tab17" style="" bgcolor="#eeeeee" align=center >�����ȣ</td>
				<td class="tab19" style= "width:280px;" colspan="3"  ><nobr>
				 <comment id="__NSID__"><object  id=gcem_post_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:5px;top:5px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=Enable	      value="true">
						<param name=PromptChar	  value="_">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp; 
				<!-- <img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="�����ȣ�� �˻��մϴ�" style="cursor:hand;position:relative;left:1px;top:1px" align=center onclick="ln_Popup('c')">&nbsp; -->			 
					 <input type="button" onclick="openDaumPostcode()"  style="position:relative;top:-2px;width:75px" value="�����ȣã��">&nbsp;
					
					 <input id="txt_address1" type="text" class="txtbox"  style= "width:222px; height:20px;position:relative;left:-1px;top:-2px" maxlength="75" onBlur="bytelength(this,this.value,200);" >
					<comment id="__NSID__"><object  id=gcem_post_no1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					 style="width:2px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Enable	      value="false">
						<param name=Border        value=true>
						<param name=format        value="000">
						<param name=maxlength     value="3">
						<param name=BackColor     value="#CCCCCC">
						<param name=Visible			  value="false">
					</object></comment><script>__ws__(__NSID__);</script>  &nbsp; 
					<comment id="__NSID__"><object  id=gcem_post_no2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="width:2px;height:20px;position:relative;left:0px;top:3px" >				
						<param name=Enable	      value="false">
						<param name=Border        value=true>
						<param name=format        value="000">
						<param name=maxlength     value="3">
						<param name=BackColor     value="#CCCCCC">
						<param name=Visible				value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			<tr>
				 <td class="tab17" style="" bgcolor="#eeeeee" align=center >��Ÿ�ּ�</td>
					<td class="tab19" style= "width:280px;" colspan="3" > 
					 <input id="txt_address2" type="text" class="txtbox"  style= "width:350px; height:20px;position:relative;left:6px" maxlength="200" onBlur="bytelength(this,this.value,200);"> 
				</td>
			</tr>

			<tr>
				<td class="tab17" style="; height:25px" bgcolor="#eeeeee" align=center>���������ڵ�</td>
				<td class="tab19"><nobr>
				  <comment id="__NSID__">
					<object  id=gcem_c_bankcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:25px;height:20px;position:relative;left:5px;top:2px">		
						<param name=Text					value="">
						<param name=Border          value=true>
						<param name=format           value="000">
						<param name=maxlength     value="5">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=false>
 					  <!-- <param name=Visible       value="false"> -->
					</object></comment><script>__ws__(__NSID__);</script>  
                         <input id="txt_c_banknm" class="txtbox" type="text" style="width:50px;position:relative;left:5px;top:-2px" maxlength="30">
					<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="������� �˻��մϴ�" style="cursor:hand;position:relative;left:3px;top:3px" onclick="ln_Popup_Bank('1');">
					</nobr>
				</td>
			
				<td class="tab19" style="" bgcolor="#eeeeee" align=center>���ݰ��¹�ȣ</td>
				<td class="tab19" >&nbsp;<comment id="__NSID__">
					<object  id=gcem_c_acctno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:145px;height:20px;position:relative;left:2px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="######################">
						<!-- <param name=GeneralEdit   value="true"> -->
						<param name=maxlength     value="22">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				</tr>

			 <tr>
				<td class="tab17" style="" bgcolor="#eeeeee" align=center >���ݰ��¸�</td>
				<td class="tab19"> 
				 <input id="txt_c_acctno_nm" type="text" class="txtbox"  style= "width:100px;height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);">
				</td>
				<td class="tab19" style="" bgcolor="#eeeeee" align=center>���ݿ�����</td>
				<td class="tab19"> 
				 <input id="txt_c_acctnm" type="text" class="txtbox"  style= "width:100px;height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);">
				</td>
			</tr>
			<tr>
				<td class="tab17" style="" bgcolor="#eeeeee" align=center>��ü����</td>
				<td class="tab19" style="width:380px;" colspan="3"><comment id="__NSID__">
					<object id=gcra_cocomyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="width:380">
						<param name=Cols		value="5">
						<param name=Format	value="N^�Ϲ�,Y^����,S^Ư������,T^���̰���,M^�鼼">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>
			<tr>
				<td class="tab17" style="" bgcolor="#eeeeee" align=center>���������ڵ�</td>
				<td class="tab19">&nbsp;<comment id="__NSID__">
					<object  id=gcem_b_bankcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:2px;top:2px">		
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#####">
						<param name=maxlength     value="5">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>  
				</td>

				<td class="tab19" style="" bgcolor="#eeeeee" align=center>�������¹�ȣ</td>
				<td class="tab19" >&nbsp;<comment id="__NSID__">
						<object  id=gcem_b_acctno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:145px;height:20px;position:relative;left:2px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="######################">
						<param name=maxlength     value="22">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

		    <tr>
				<td class="tab17" bgcolor="#eeeeee" align=center >�������¸�</td>
				<td class="tab19"><input id="txt_b_acctno_nm" type="text" class="txtbox"  style= "width:93px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);"></td>
				<td class="tab19" bgcolor="#eeeeee" align=center>�������¿�����</td>
				<td class="tab19"> 
				 <input id="txt_b_acctnm" type="text" class="txtbox"  style= "width:143px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);">
					<!-- <comment id="__NSID__"><object  id=gcem_atupnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:4px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
					<!-- <comment id="__NSID__"><object  id=gcem_atupnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:4px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
			</tr>

			<tr>
				 <td class="tab17" style="" bgcolor="#eeeeee" align=center >���ŷ�����</td>
					<td class="tab19" >&nbsp; 
					 <input id="txt_o_vendgb" type="text" class="txtbox"  style= "position:relative;left:-2px;;width:94px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" >
					
				</td>
			
				<td class="tab19" style="" bgcolor="#eeeeee" align=center >���ŷ�ó�ڵ�</td>
				<td class="tab19"  >&nbsp;
				<input id="txt_o_vendcd" type="text" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="13" onBlur="bytelength(this,this.value,13);" >
				</td> 
			</tr> 

			<tr>
				 <td class="tab17" style="" bgcolor="#eeeeee" align=center >������ȣ</td>
					<td class="tab19" >&nbsp; 
					 <input id="txt_vend_mag" type="text" class="txtbox"  style= "position:relative;left:-2px;;width:94px; height:20px;" maxlength="10" onBlur="bytelength(this,this.value,10);" >
				</td>
			
				<td class="tab19" style="" bgcolor="#eeeeee" align=center >�������</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__">
					<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
						<param name=Cols		value="2">
						<param name=Format	value="Y^���,N^�̻��">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td> 
				</tr>
				<tr>
				 <td class="tab17" style="" bgcolor="#eeeeee" align=center >���</td>
					<td class="tab19" style= "width:280px;" colspan="3" > 
					 <input id="txt_remark" type="text" class="txtbox"  style= "width:350px; height:20px;position:relative;left:6px" maxlength="66" onBlur="bytelength(this,this.value,66);"> 
 					 <input id="txt_msn"  type="hidden" class="txtbox"  style= "position:relative;left:-2px;;width:1px; height:20px;" maxlength="10" onBlur="bytelength(this,this.value,10);" >
                     <input id="txt_mpwd" type="hidden" class="txtbox"  style= "position:relative;left:-2px;width:1px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" >
				</td>
				</tr>
				<tr>
				 <td class="tab17" style="" bgcolor="#eeeeee" align=center >ä�Ǳ���</td>
					<td class="tab19" style= "width:280px;" colspan="3" > 
						<comment id="__NSID__">
							<object id=gclx_credgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;font-size:12px;width:150px;color:#FF0000">
								<param name=CBData			         value="1^ä��(��)�з�">
								<param name=CBDataColumns	 value="CODE,NAME">
								<param name=SearchColumn	     value=NAME>
								<param name=Sort			             value=false>
								<param name=ListExprFormat       value="NAME">								
								<param name=BindColumn		     value="CODE">
								<param name=InheritColor            value="true">
							</object>
							</comment><script>__ws__(__NSID__);</script> </nobr>
				</td>
				</tr>

			<!-- <tr>
				  <td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >���̵�</td>
					<td class="tab19" >&nbsp; 
					 <input id="txt_msn" type="hidden" class="txtbox"  style= "position:relative;left:-2px;;width:94px; height:20px;" maxlength="10" onBlur="bytelength(this,this.value,10);" >
				  </td>
			
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center >��й�ȣ</td>
				<td class="tab19"  >&nbsp;
				<input id="txt_mpwd" type="hidden" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" >
				</td> 
			</tr> -->
				
				<!-- <tr> -->
					<!-- <td height="3px" style="border:1 solid #708090;border-right-width:1px;border-top-width:0px;" colspan="4">&nbsp;
					</td> -->
					  <!--�ؿ� ���ĭ-->
					<!-- <td height="3px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td> -->
				<!-- </tr> -->
		</table> 
	  </td>
  </tr> 

</table> 

<!------------------------------ ���� ------------------------------>
<!--<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:485px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
	 <td align="center" colspan=2>
	
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
		<tr> 				
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
					<td class="tab23" style="width:40px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_fdcode1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('02');">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="##">
								<param name=PromptChar    value="">
								<param name=maxlength     value="2">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					
						<!-- <img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="������ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup04('fr','03');"> -->
					</td>
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">������</td>
					<td>
						<input id="txt_fdname1" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query('02');" onBlur="bytelength(this,this.value,30);"> 
						
						<!-- <comment id="__NSID__"><object  id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
							<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
				    </object></comment><script>__ws__(__NSID__);</script>  -->
					</td>
						<td width="1px" align=right>&nbsp;</td>
						<td align="right" valign="bottom"  style="position:relative;right:0px;top:0px;">
						  <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('02')">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('02')" >
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"   style="cursor:hand" onclick="ln_Save('02')">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('02')">&nbsp;
							</td>
					</tr>
				</table>
			</td>
		</tr>

	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:500px;border:0 solid #708090;">
				<tr> 			
					<td>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
							style="position:relative;left:7px;width:500px; top:1px;height:401px; border:1 solid #708090;">
              <PARAM NAME="DataID"			VALUE="gcds_code02">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="SortView"    value="Left">
							<param name="ColSizing"  value="true">
							<param name="FillArea"   value="True">
							<param name="IndWidth"   value="0">
							<PARAM NAME="Format"			VALUE="

								<C> Name='�ڵ�'				ID=FDCODE	HeadAlign=Centert HeadBgColor=#B9D4DC   Width=50  align=center sort=true suppress=1</C>
								<C> Name='������'			ID=FDNAME	HeadAlign=Center HeadBgColor=#B9D4DC	  Width=134  align=left  sort=true </C>
								<C> Name='�������'		ID=DSUDT HeadAlign=Center HeadBgColor=#B9D4DC     Width=100  align=center Edit=none  sort=true Mask='XXXX/XX/XX'  </C>
								<C> Name='���'		    ID=FDREMARK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=198 align=left Edit=none  sort=true </C> 
								
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:502px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
						</fieldset>
				</td>
			</tr>
		</table>
		</td>

		<td>
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:10px;top:1px;width:360px;border:0 solid #708090;">
				<tr>
					<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>�����ڵ�</nobr></td>
					    <td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
						<!-- <input id="txt_fdcode" type="text" class="txtbox" style= "width:200px; height:20px;position:relative;left:-6px"> -->  <!--maxlength="4" onBlur="bytelength(this,this.value,4);"> -->
						 <comment id="__NSID__"><object  id=gcem_fdcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:20px;position:relative;left:-6px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="##">
						<param name=maxlength     value="2">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					</td>									
				</tr>

				<tr>
					<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">�� �� ��</td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
						<input id="txt_fdname" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:-6px" maxlength="36" onBlur="bytelength(this,this.value,30);">
					</td>
				</tr>

				<tr>
					<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">�������</td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;padding-left:2px;">
						<comment id="__NSID__"><object  id=gcem_dsudt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:1px;left:4px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script> 

						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dsudt01', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;"> 
									
					</td>
				</tr>

				<tr>
					<td style="height:74px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
						<textarea id="txt_fdremark" class="txtbox"  style= "width:255px; height:68px; overflow:auto;position:relative;left:-6px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
					</td>
				</tr>

			<tr>
				<td height="272px" style="border:1 solid 
					#708090;border-right-width:0px;border-top-width:0px;">&nbsp;</td><!--�ؿ� ���ĭ-->
				<td height="272px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
			</tr>	
		</table> 
	</td>
	</tr> 
</table> 
							
<!------------------------------- ����� -------------------------------->
<!-- <fieldset id=field3 style="position:absolute;top:70px;left:4px;height:485px;width:875px;bacground-color:#708090"></fieldset> -->
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">

	<tr>
		<td align="center" colspan=2>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
				<tr> 				
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">������ڵ�</td>
					<td class="tab23" style="width:40px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_cocode_fr03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('03');">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="##">
								<param name=PromptChar    value="">
								<param name=maxlength     value="2">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					
						<!-- <img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="������ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup04('fr','03');"> -->
					</td>
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">������</td>
					<td>
						<input id="txt_cosang_to03" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query('03');" onBlur="bytelength(this,this.value,30);"> 
						
						<!-- <comment id="__NSID__"><object  id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
							<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
				    </object></comment><script>__ws__(__NSID__);</script>  -->
					</td>
					<td width="1px" align=right>&nbsp;</td>
					<td align="right" valign="bottom"  style="position:relative;right:0px;top:0px;">
						<!-- <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel('gcgd_disp01','�����ڵ�')">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('01')"> -->
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('03')" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('03')" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('03')">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('03')">&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr><td height="2px" colspan =2></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:400px;border:0 solid #708090;">
				<tr> 			
					<td>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
							style="position:relative;left:7px;width:400px; top:1px;height:401px; border:1 solid #708090;">
								<PARAM NAME="DataID"			VALUE="gcds_code03">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='�ڵ�'		    ID=COCODE   					HeadAlign=Center HeadBgColor=#B9D4DC Width=48	
								align=center sort=true </C> 
								<C> Name='���ι�ȣ'					ID=COROWNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=94	  align=CENTER	sort=true Mask='XXXXXX-XXXXXXX' </C> 
								<C> Name='������'					ID=COSANG		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=LEFT	sort=true</C> 
								<C> Name='��ǥ��'						ID=COMANAGER    HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=LEFT	sort=true</C> 
								<C> Name='����ڹ�ȣ'	 			ID=COID			    HeadAlign=Center HeadBgColor=#B9D4DC Width=86		align=CENTER 	sort=true Mask='XXX-XX-XXXXX'</C> 
								<C> Name='��ǥ��ȭ'	    		ID=COTEL		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='�ѽ���ȣ'	   			ID=COFAX		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='����'							ID=COUPTAI	   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=LEFT	  sort=true</C> 
								<C> Name='����'							ID=COJONMOCK   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='�����ȣ'					ID=COADDRNO  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=CENTER	sort=true Mask='XXX-XXX' </C> 
								<C> Name='�ּ�1'						ID=COADDR1			HeadAlign=Center HeadBgColor=#B9D4DC Width=250	align=LEFT sort=true	</C> 
								<C> Name='�ּ�2'						ID=COADDR2			HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=LEFT sort=true	</C> 
								<C> Name='��������'					ID=COSTRDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=CENTER sort=true	Mask='XXXX/XX/XX' </C> 
								<C> Name='��������'					ID=COTAXNAM		 	HeadAlign=Center HeadBgColor=#B9D4DC Width=95		align=LEFT	 sort=true </C> 
								
								">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:402px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
						</fieldset>
				</td>
			</tr>
		</table>
	</td>

	<!-- <td width="80%" height="0" valign="top"> -->
	<td valign="top">
		<table cellpadding="0" cellspacing="0" border="3"  style="position:relative;left:10px;top:1px;width:460px;border:0 solid #708090;">
			 <tr>
				<td class="tab15" style="width:90px;" bgcolor="#eeeeee" align=center >������ڵ�</td>
			 	<td class="tab18" style="width:140px;" >
				 <comment id="__NSID__"><object  id=gcem_cocode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:20px;height:20px;position:relative;left:6px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="##">
						<param name=maxlength     value="2">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;
			 <input id="txt_coname" type="text" class="txtbox"  style= "width:100px; height:20px;position:relative;left:4px;top:-1px" maxlength="20">
				</td>
			<td class="tab18" style="width:90px;" bgcolor="#eeeeee" align=center >���ι�ȣ</td>
			<td class="tab18" style="width:140px;" > 
			 <!-- <input id="txt_corowno" type="text" class="txtbox"  style= "width:96px; height:20px;position:relative;left:6px" maxlength="13" > -->
				 <comment id="__NSID__"><object  id=gcem_corowno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:92px;height:20px;position:relative;left:6px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="000000-0000000">
						<param name=maxlength     value="13">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>

		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >������</td>
			<td class="tab19" style="width:180px;" colspan="3"> 
			 <input id="txt_cosang" type="text" class="txtbox"  style= "width:174px; height:20px;position:relative;left:6px" maxlength="66" >

				<!-- <td class="tab19" colspan="3"  >&nbsp; 
					 <input id="txt_vend_nm" type="text" class="txtbox"  style= "width:94px;height:20px;position:relative;left:-2px" maxlength="32" onBlur="bytelength(this,this.value,30)";>   -->
					  <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param nam e=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>   -->
			</td>
		</tr>

		
		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >��ǥ��</td>
			<td class="tab19" style="width:180px;" colspan="3"> 
			 <input id="txt_comanager" type="text" class="txtbox"  style= "width:174px; height:20px;position:relative;left:6px" maxlength="66" >

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >����ڹ�ȣ</td>
			<td class="tab19"  style="width:180px;" colspan="3"> 
			<!--  <input id="txt_coid" type="text" class="txtbox"  style= "width:96px; height:20px;position:relative;left:6px" maxlength="10" > -->
			 <comment id="__NSID__"><object  id=gcem_coid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:6px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="000-00-00000">
						<param name=maxlength     value="10">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >��ǥ��ȭ</td>
			<td class="tab19" style="width:180px;" colspan="3"> 
				<input id="txt_cotel" type="text" class="txtbox"  style= "width:96px; height:20px;position:relative;left:6px" maxlength="15" >

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >�ѽ���ȣ</td>
			<td class="tab19" style="width:180px;" colspan="3"> 
			 <input id="txt_cofax" type="text" class="txtbox"  style= "width:96px; height:20px;position:relative;left:6px" maxlength="15" >

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >����</td>
			<td class="tab19" style="width:180px;" colspan="3"> 
			 <input id="txt_couptai" type="text" class="txtbox"  style= "width:174px; height:20px;position:relative;left:6px" maxlength="34" >

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >����</td>
			<td class="tab19" style="width:180px;" colspan="3"> 
			 <input id="txt_cojonmock" type="text" class="txtbox"  style= "width:174px; height:20px;position:relative;left:6px" maxlength="34" >

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
			</td>
		</tr>

		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >�����ȣ</td>
			<td class="tab19" style="width:180px;" colspan="3">
			 <comment id="__NSID__"><object  id=gcem_coaddrno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:6px;top:5px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="000-000">
					<param name=Enable	      value="false">
					<param name=PromptChar	  value="_">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;
				<!-- 	<img alt=�����ȣ��ȸ  id='img_search1' name='img_search1' style="position:relative;left:7px;top:2px;cursor:hand" src='<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_search.gif'  onclick="ln_Popup02('c')"> -->
				<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="�����ȣ�� �˻��մϴ�" style="cursor:hand;position:relative;left:1px;top:1px" align=center onclick="ln_Popup02('c')"> 

				</td> 
			</tr>

			<tr>
			 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >�ּ�1</td>
			 <td class="tab19"  style="width:180px;" colspan="3"> 
				  <input id="txt_coaddr1" type="text" class="txtbox"  style= "width:300px; height:20px;position:relative;left:6px" maxlength="66" onBlur="bytelength(this,this.value,66);" 
					readOnly>  
					<!--  <textarea id="txt_coaddr" class="txtbox"  style= "width:174px; height:35px; overflow:auto;position:relative;left:6px" maxlength="82" onBlur="bytelength(this,this.value,82);"></textarea> -->
					 <!-- <comment id="__NSID__"><object  id=gcem_atupnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:180px;height:20px;position:relative;left:4px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
			</tr>
			 <tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >�ּ�2</td>
					<td class="tab19" style= "width:180px;" colspan="3"> 
				
					 <input id="txt_coaddr2" type="text" class="txtbox"  style= "width:300px; height:20px;position:relative;left:6px" maxlength="66" onBlur="bytelength(this,this.value,66);">  
					 <!-- <comment id="__NSID__"><object  id=gcem_atupnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:180px;height:20px;position:relative;left:4px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
				 </td>
			</tr> 

			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >��������</td>
				<td class="tab19" style="width:140px;"> 
				<!--  <input id="txt_costrdat" type="text" class="txtbox"  style= "width:296px; height:20px;position:relative;left:6px" maxlength="72" > -->

					<comment id="__NSID__"><object  id=gcem_costrdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:3px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_costrdat', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;"> 
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center >ȸ����ۿ�</td>
				<td class="tab19"  style="width:140px;"> 
				<!--  <input id="txt_comon" type="text" class="txtbox"  style= "width:194px; height:20px;position:relative;left:6px" maxlength="2" > -->
				 <comment id="__NSID__"><object  id=gcem_comon classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:20px;height:20px;position:relative;left:6px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="##">
						<param name=maxlength     value="2">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
			</tr>
		
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >��������</td>
				<td class="tab19" style="width:180px;" colspan="3"> 
				 <input id="txt_cotaxnam" type="text" class="txtbox"  style= "width:174px; height:20px;position:relative;left:6px" maxlength="34" >

					 <!-- <comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >ȸ�踶����</td>
				<td class="tab19" style="width:180px;" colspan="3"> 
				 <!-- <input id="txt_coenddat" type="text" class="txtbox"  style= "width:296px; height:20px;position:relative;left:6px" maxlength="72" > -->

					<comment id="__NSID__"><object  id=gcem_coenddat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:3px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_coenddat', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;"> 
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >�������</td>
				<td class="tab19" style="width:180px;" colspan="3"> 
				<!--  <input id="txt_dsudt" type="text" class="txtbox"  style= "width:296px; height:20px;position:relative;left:6px" maxlength="72" > -->

					<comment id="__NSID__"><object  id=gcem_dsudt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:3px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dsudt', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;"> 
				</td>
			</tr>
			<!-- <fieldset style="position:relative;left:7px;width:280px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp; -->
			 <tr>
				 <td height="40px" style="border:1 solid 
				#708090;border-right-width:0px;border-top-width:0px;" colspan="3">&nbsp;</td><!--�ؿ� ���ĭ-->  
			  <td height="40px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td> 
			</tr>   
		</table> 
  </td>
 </tr> 
</table> 

<!------------------------------ �μ������� ------------------------------>
<table id="div_disp4" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
	 <td align="center" colspan=2>
	
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
		<tr> 				
			<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�μ��ڵ�</td>
			<td class="tab23" style="width:50px">&nbsp;<comment id="__NSID__">
				<object  id=gcem_deptcd1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('04');">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="####">
						<param name=PromptChar    value="">
						<param name=maxlength     value="4">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=UpperFlag     value=1>
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
			<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�μ���</td>
			<td class="tab23" style="width:150px;">
					<input id="txt_deptnm1" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="50" onkeydown="if(event.keyCode==13) ln_Query('04');" onBlur="bytelength(this,this.value,50);">
			</td>
			<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�μ�������</td>
			<td>
						<comment id="__NSID__"><object  id=gcem_deptyymm4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:4px;top:0px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
			</td>
			<td width="1px" align=right>&nbsp;</td>
			<td align="right" valign="bottom"  style="position:relative;right:0px;top:0px;">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"   style="cursor:hand" onclick="ln_Save('04')">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('04')">&nbsp;
			</td>
			</tr>
		</table>
	</td>
</tr>

	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:600px;border:0 solid #708090;">
				<tr> 			
					<td>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp04  
							style="position:relative;left:7px;width:600px; top:1px;height:401px; border:1 solid #708090;">
              <PARAM NAME="DataID"			VALUE="gcds_code04">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="SortView"    value="Left">
							<param name="ColSizing"  value="true">
							<param name="FillArea"   value="True">
							<param name="IndWidth"   value="0">
							<PARAM NAME="Format"			VALUE="

								<C> Name='�μ��ڵ�'	ID=DEPTCD	HeadAlign=Centert HeadBgColor=#B9D4DC   Width=70  align=center sort=true</C>
								<C> Name='�μ���'	ID=DEPTNM	HeadAlign=Center HeadBgColor=#B9D4DC	  Width=155  align=left  sort=true </C>
								<C> Name='�����ڵ�'	ID=FDCODE HeadAlign=Center HeadBgColor=#B9D4DC     Width=70  align=center sort=true </C>
								<C> Name='������'	ID=FDNAME	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left sort=true </C> 
								<C> Name='������ڵ�'	ID=COCODE HeadAlign=Center HeadBgColor=#B9D4DC	  Width=85 align=center  sort=true </C>
								<C> Name='������'	ID=CONAME HeadAlign=Center HeadBgColor=#B9D4DC     Width=70  align=left sort=true </C>
								<C> Name='�������'	ID=USEYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center  EditStyle='combo', data='T:���,F:�̻��' </C> 								
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:602px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt04 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
						</fieldset>
				</td>
			</tr>
		</table>
		</td>

		<td>
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:10px;top:1px;width:260px;border:0 solid #708090;">
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>�μ��ڵ�</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_deptcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="####">
						<param name=maxlength     value="4">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;
						<input id="txt_deptnm" type="text" class="txtbox"  style= "width:110px; height:20px;position:relative;left:-6px;top:-2px" maxlength="50" onBlur="bytelength(this,this.value,50);">
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>�����ڵ�</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gclx_fdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_code04_3">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value=FDNAME>
								<param name=Sort						value=TRUE>
								<param name=SortColumn  value="FDCODE">
								<param name=ListExprFormat	value="FDNAME^0^150">
								<param name=BindColumn			value=FDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>������ڵ�</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gclx_cocode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_code04_4">
								<param name=CBDataColumns		value="COCODE, CONAME">
								<param name=SearchColumn		value=CONAME>
								<param name=Sort						value=TRUE>
								<param name=SortColumn  value="COCODE">
								<param name=ListExprFormat	value="CONAME^0^150">
								<param name=BindColumn			value=COCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					</tr>
					<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>�������</nobr></td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
						<input id="txt_useyn" type="text" class="txtbox"  style= "width:20px; height:20px;position:relative;left:6px">
					</td>
					</tr>
			<tr>
				<td height="316px" style="border:1 solid 
					#708090;border-right-width:0px;border-top-width:0px;">&nbsp;</td><!--�ؿ� ���ĭ-->
				<td height="316px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
			</tr>	
		</table> 
	</td>
	</tr> 
</table> 

<!------------------------------ ����μ� ------------------------------>
<table id="div_disp5" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
	 <td align="center" colspan=2>
	
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
		<tr> 				
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�μ��ڵ�</td>
					<td class="tab23" style="width:50px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_deptcd3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('05');">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="####">
								<param name=PromptChar    value="">
								<param name=maxlength     value="4">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=UpperFlag     value=1>
						</object></comment><script>__ws__(__NSID__);</script> 
						</td>
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�μ���</td>
				<td class="tab23" style="width:150px;">
						<input id="txt_deptnm3" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="50" onkeydown="if(event.keyCode==13) ln_Query('05');" onBlur="bytelength(this,this.value,50);">
					</td>
         <td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�μ�������</td>
			   <td >
						<comment id="__NSID__"><object  id=gcem_deptyymm5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:4px;top:0px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
			    </td>

						<td width="1px" align=right>&nbsp;</td>
						<td align="right" valign="bottom"  style="position:relative;right:0px;top:0px;">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"   style="cursor:hand" onclick="ln_Save('05')">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('05')">&nbsp;
							</td>
					</tr>
				</table>
			</td>
		</tr>

	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:600px;border:0 solid #708090;">
				<tr> 			
					<td>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp05  
							style="position:relative;left:7px;width:600px; top:1px;height:401px; border:1 solid #708090;">
              <PARAM NAME="DataID"			VALUE="gcds_code05">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="SortView"    value="Left">
							<param name="ColSizing"  value="true">
							<param name="FillArea"   value="True">
							<param name="IndWidth"   value="0">
							<PARAM NAME="Format"			VALUE="
								<C> Name='�μ��ڵ�'	ID=DEPTCD	HeadAlign=Centert HeadBgColor=#B9D4DC   Width=70  align=center sort=true</C>
								<C> Name='�μ���'	ID=DEPTNMK	HeadAlign=Center HeadBgColor=#B9D4DC	  Width=230  align=left  sort=true </C>
								<C> Name='����μ�'	ID=BGTDEPT	HeadAlign=Center HeadBgColor=#B9D4DC Width=140 align=left sort=true EditStyle=Lookup Data='gcds_code05_2:CDCODE:CDNAM'</C> 
								<C> Name='���꺻��'	ID=BGTDIVCD HeadAlign=Center HeadBgColor=#B9D4DC     Width=140  align=left sort=true EditStyle=Lookup Data='gcds_code05_2:GBCD:CDREMARK'</C>
								">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:602px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt05 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
						</fieldset>
				</td>
			</tr>
		</table>
		</td>

		<td>
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:10px;top:1px;width:260px;border:0 solid #708090;">
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>�μ��ڵ�</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_deptcd4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="####">
						<param name=maxlength     value="4">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;
						<input id="txt_deptnm4" type="text" class="txtbox"  style= "width:110px; height:20px;position:relative;left:-6px;top:-2px" maxlength="50" onBlur="bytelength(this,this.value,50);">
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>����μ�</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gclx_bgtdept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_code05_2">
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=TRUE>
								<param name=SortColumn  value="CDCODE">
								<param name=ListExprFormat	value="CDNAM^0^150">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>���꺻��</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gclx_bgtdivcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_code05_3">
								<param name=CBDataColumns		value="GBCD,CDREMARK">
								<param name=SearchColumn		value=CDREMARK>
								<param name=Sort						value=TRUE>
								<param name=SortColumn  value="GBCD">
								<param name=ListExprFormat	value="CDREMARK^0^150">
								<param name=BindColumn			value=GBCD>
								<param name=Enable          value=false>

						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr>
				<td height="343px" style="border:1 solid 
					#708090;border-right-width:0px;border-top-width:0px;">&nbsp;</td><!--�ؿ� ���ĭ-->
				<td height="343px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
			</tr>	
		</table> 
	</td>
	</tr> 
</table> 		

<!------------------------------ ����������� ------------------------------>
<table id="div_disp6" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
	 <td align="center" colspan=2>
	
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
		<tr> 			
		    <td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�����������</td>
				<td class="tab23" style="width:100px">&nbsp;<comment id="__NSID__">
					<object id=gclx_bgtdivcd6 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
								<param name=ComboDataID			value="gcds_code06_1">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=TRUE>
								<param name=SortColumn      value="CDCODE">
								<param name=ListExprFormat	value="CDNAM^0^80">
								<param name=BindColumn			value=CDCODE>
					</object></comment><script>__ws__(__NSID__);</script> 
        </td>

				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">����μ��ڵ�</td>
				<td class="tab23" style="width:50px">&nbsp;<comment id="__NSID__">
					<object  id=gcem_deptcd6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('06');">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="####">
							<param name=PromptChar    value="">
							<param name=maxlength     value="4">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=UpperFlag     value=1>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">����μ���</td>
				<td class="tab23" style="width:150px;">
						<input id="txt_deptnm6" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="50" onkeydown="if(event.keyCode==13) ln_Query('06');" onBlur="bytelength(this,this.value,50);">
					</td>
         <td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">������</td>
			   <td >
						<comment id="__NSID__"><object  id=gcem_deptyymm6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:4px;top:0px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
			    </td>

					<td width="1px" align=right>&nbsp;</td>
					<td align="right" valign="bottom"  style="position:relative;right:0px;top:0px;">
					    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('06')" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"    style="cursor:hand" onclick="ln_Save('06')">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('06')">&nbsp;
					</td>
				</tr>
				</table>
			</td>
		</tr>

	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:600px;border:0 solid #708090;">
				<tr> 			
					<td>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp06  
							style="position:relative;left:7px;width:600px; top:1px;height:401px; border:1 solid #708090;">
				            <PARAM NAME="DataID"			VALUE="gcds_code06">
				            <PARAM NAME="Editable"		VALUE="false">
				            <PARAM NAME="BorderStyle" VALUE="0">
							<param name="SortView"    value="Left">
							<param name="ColSizing"  value="true">
							<param name="FillArea"   value="True">
							<param name="IndWidth"   value="0">
							<PARAM NAME="Format"			VALUE="
							  <G> name='����μ�' HeadAlign=Centert HeadBgColor=#B9D4DC
									<C> Name='�ڵ�'	    ID=BGTDPT	   HeadAlign=Center HeadBgColor=#B9D4DC	 Width=80   align=center sort=true </C>
									<C> Name='�ڵ��'	  ID=BGTDPTNM	 HeadAlign=Center HeadBgColor=#B9D4DC  Width=120  align=left   sort=true </C> 
								</G>
								<G> name='�����������' HeadAlign=Centert HeadBgColor=#B9D4DC
									<C> Name='�ڵ�' 	  ID=BGTDIV  	 HeadAlign=Center HeadBgColor=#B9D4DC  Width=80   align=center sort=true</C>
									<C> Name='�ڵ��'	  ID=BGTDIVNM	 HeadAlign=Center HeadBgColor=#B9D4DC  Width=120  align=left   sort=true</C>
								</G>
								<G> name='������' HeadAlign=Centert HeadBgColor=#B9D4DC
									<C> Name='�������'	ID=BGTFRYM  HeadAlign=Center  HeadBgColor=#B9D4DC  Width=90   align=center sort=true mask ='XXXX/XX' </C>
									<C> Name='��������'	ID=BGTTOYM  HeadAlign=Center  HeadBgColor=#B9D4DC  Width=90   align=center sort=true mask ='XXXX/XX' </C>
								</G> 
								">
                         </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:602px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt06 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
						</fieldset>
				</td>
			</tr>
		</table>
		</td>

		<td>
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:10px;top:1px;width:260px;border:0 solid #708090;">
			
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>����μ�</nobr></td>
					<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gclx_bgtdept6_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_code06_3">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=TRUE>
								<param name=SortColumn      value="CDCODE">
								<param name=ListExprFormat	value="CDNAM^0^150">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>�����������</nobr></td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gclx_bgtdivcd6_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_code06_2">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=TRUE>
								<param name=SortColumn      value="CDCODE">
								<param name=ListExprFormat	value="CDNAM^0^150">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>������۳��</nobr></td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_bgtfrym6_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:0px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="YYYY/MM">
						<param name=maxlength     value="6">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;
					</td>
				</tr>
				<tr>
					<td style="height:25px;width:90px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>����������</nobr></td>
					<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_bgttoym6_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:0px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="YYYY/MM">
						<param name=maxlength     value="6">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;
					</td>
				</tr>
				<tr>
				<td height="320px" style="border:1 solid #708090;border-right-width:0px;border-top-width:0px;">&nbsp;
				
				        <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"	style="cursor:hand" onClick="ln_Excel('06')" >
					    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('06')" >
				</td><!--�ؿ� ���ĭ-->
				<td height="320px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
			</tr>	
		</table> 
	</td>
	</tr> 
</table> 					

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code01>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=VEND_CD			 Ctrl=gcem_vend_cd				Param=text</C>
		<C>Col=VEND_NM			 Ctrl=txt_vend_nm					Param=value</C>
		<C>Col=VD_DIRECT		 Ctrl=txt_vd_direct 			Param=value</C>
		<C>Col=BSNS_CND			 Ctrl=txt_bsns_cnd				Param=value</C>
		<C>Col=BSNS_KND			 Ctrl=txt_bsns_knd				Param=value</C>
		<C>Col=VD_TELNO			 Ctrl=txt_vd_telno				Param=value</C>
		<C>Col=VD_FAXNO			 Ctrl=txt_vd_faxno				Param=value</C>
		<C>Col=POST_NM			 Ctrl=gcem_post_nm				Param=text</C>
		<C>Col=POST_NO1			 Ctrl=gcem_post_no1				Param=text</C>
		<C>Col=POST_NO2			 Ctrl=gcem_post_no2				Param=text</C>
		<C>Col=ADDRESS1			 Ctrl=txt_address1				Param=value</C>
		<C>Col=ADDRESS2			 Ctrl=txt_address2				Param=value</C>
		<C>Col=C_BANKCD			 Ctrl=gcem_c_bankcd				Param=text</C>
		<C>Col=C_ACCTNO			 Ctrl=gcem_c_acctno				Param=text</C>
		<C>Col=C_ACCTNO_NM	 Ctrl=txt_c_acctno_nm			Param=value</C>
		<C>Col=C_ACCTNM			 Ctrl=txt_c_acctnm				Param=value</C>
		<C>Col=B_BANKCD			 Ctrl=gcem_b_bankcd				Param=text</C>
		<C>Col=B_ACCTNO			 Ctrl=gcem_b_acctno				Param=text</C>
		<C>Col=B_ACCTNO_NM	 Ctrl=txt_b_acctno_nm			Param=value</C>
		<C>Col=B_ACCTNM			 Ctrl=txt_b_acctnm				Param=value</C>
		<C>Col=O_VENDGB			 Ctrl=txt_o_vendgb				Param=value</C>
		<C>Col=O_VENDCD			 Ctrl=txt_o_vendcd				Param=value</C>
		<C>Col=VEND_MAG			 Ctrl=txt_vend_mag				Param=value</C>
		<C>Col=USE_TAG			 Ctrl=gcra_useyn					Param=CodeValue</C>
		<C>Col=REMARK 			 Ctrl=txt_remark					Param=value</C>
		<C>Col=MSN 					 Ctrl=txt_msn							Param=value</C>
		<C>Col=MPWD 				 Ctrl=txt_mpwd						Param=value</C>
	    <C>Col=COCOMYN       Ctrl=gcra_cocomyn        Param=CodeValue</C>
		<C>Col=VEND_ID			 Ctrl=gcem_vendid					Param=text</C>
		<C>Col=H_VEND_CD		 Ctrl=gcem_h_vend_cd			Param=text</C>
		<C>Col=H_VEND_NM		 Ctrl=txt_h_vend_nm				Param=value</C>
		<C>Col=C_BANK_NM		 Ctrl=txt_c_banknm				Param=value</C>
		<C>Col=CREDGB      		 Ctrl=gclx_credgb				Param=bindcolval</C>
		
		
	
	'>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcbn_code02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code02>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=FDCODE    Ctrl=gcem_fdcode       Param=text</C>
		<C>Col=FDNAME		 Ctrl=txt_fdname       Param=value</C>
		<C>Col=DSUDT		 Ctrl=gcem_dsudt01		 Param=text</C>
		<C>Col=FDREMARK	 Ctrl=txt_fdremark		 Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcbn_code03 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code03>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=COCODE				 Ctrl=gcem_cocode					Param=text</C>
		<C>Col=CONAME				 Ctrl=txt_coname					Param=value</C>
		<C>Col=COROWNO			 Ctrl=gcem_corowno				Param=text</C>
		<C>Col=COSANG				 Ctrl=txt_cosang					Param=value</C>
		<C>Col=COMANAGER		 Ctrl=txt_comanager				Param=value</C>
		<C>Col=COID					 Ctrl=gcem_coid						Param=text/C>
		<C>Col=COTEL				 Ctrl=txt_cotel						Param=value</C>
		<C>Col=COFAX				 Ctrl=txt_cofax						Param=value</C>
		<C>Col=COUPTAI			 Ctrl=txt_couptai		  		Param=value</C>
		<C>Col=COJONMOCK		 Ctrl=txt_cojonmock			  Param=value</C>
		<C>Col=COADDRNO			 Ctrl=gcem_coaddrno				Param=text</C>
		<C>Col=COADDR1			 Ctrl=txt_coaddr1					Param=value</C>
		<C>Col=COADDR2			 Ctrl=txt_coaddr2					Param=value</C>
		<C>Col=COSTRDAT			 Ctrl=gcem_costrdat			  Param=text</C>
		<C>Col=COMON				 Ctrl=gcem_comon				  Param=text</C>
		<C>Col=COENDDAT			 Ctrl=gcem_coenddat			  Param=text</C>
		<C>Col=COTAXNAM			 Ctrl=txt_cotaxnam				Param=value</C>
		<C>Col=DSUDT				 Ctrl=gcem_dsudt					Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcbn_code04 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code04>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=DEPTCD    Ctrl=gcem_deptcd      Param=text</C>
		<C>Col=DEPTNM		 Ctrl=txt_deptnm       Param=value</C>
		<C>Col=FDCODE 	 Ctrl=gclx_fdcode1 		 Param=bindcolval</C>
		<C>Col=COCODE		 Ctrl=gclx_cocode1		 Param=bindcolval</C>
		<C>Col=USEYN		 Ctrl=txt_useyn				 Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcbn_code05 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code05>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=DEPTCD    Ctrl=gcem_deptcd4      Param=text</C>
		<C>Col=DEPTNMK	 Ctrl=txt_deptnm4       Param=value</C>
		<C>Col=BGTDIVCD  Ctrl=gclx_bgtdivcd	 	  Param=bindcolval</C>
		<C>Col=BGTDEPT	 Ctrl=gclx_bgtdept	 	  Param=bindcolval</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-- ����������� -->
<comment id="__NSID__"><object  id=gcbn_code06 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code06>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=BGTDPT    Ctrl=gclx_bgtdept6_2   Param=bindcolval</C>
		<C>Col=BGTDIV    Ctrl=gclx_bgtdivcd6_2	Param=bindcolval</C>
		<C>Col=BGTFRYM	 Ctrl=gcem_bgtfrym6_2	  Param=text</C>
		<C>Col=BGTTOYM	 Ctrl=gcem_bgttoym6_2	  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
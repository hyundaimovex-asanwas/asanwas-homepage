<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ڱݰ��� - �ڱݽ�û��
+ ���α׷� ID	:  a300060.jsp
+ �� �� �� ��	:  ������ �ʿ��� �ڱ��� ��û�ϴ� ȭ���̴�.  
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2016.12.07
+ �� �� �� ��	:  
+ ���콺 ����    :  5.2 
-----------------------------------------------------------------------------
+ �� �� �� ��     :	         
+ ��   ��  ��      : 
+ �� �� �� ��     : 
+ �� �� �� ��     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ڱݽ�û��</title>

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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//�����ڵ�


<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
}

<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){

	gcem_appdate.text = gs_date;
	//gcem_appdate.text = "20161001";
	//gcem_reqdate.text = gs_date;
	gcem_taxdat.text = gs_date;
	
	gcds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_taxknd.Reset();

	gclx_fdcode.bindcolval = gs_fdcode;
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
}

<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	if(e=="0"){  //������ �¸�....
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_s1?v_str1=999"
																			   +"&v_str2=99991231"
																			   +"&v_str3=99991231"
																			   +"&v_str4=6070001";
		 gcds_data01.Reset();	 
	}else{
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_s1?v_str1="+gclx_fdcode.bindcolval
		  																       +"&v_str2="+gcem_appdate.text
																			   +"&v_str3="+gcem_reqdate.text
																			   +"&v_str4="+gcem_appempno.text;	
         gcds_data01.Reset();
	}
    gcds_taxmst.ClearAll();
}

<%
/******************************************************************************************
	Description : ����
******************************************************************************************/
%>
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	else if (gcds_data01.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){	
			gctr_data.KeyValue   = "Account.a300060_t1(I:USER=gcds_data01)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data01.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}

<%
/******************************************************************************************
	Description : ���� üũ
******************************************************************************************/
%>
function ln_Chk_Save(){
	
	for(var i=1;i<=gcds_data01.countrow;i++){
		//�� ���� üũ 
		//����ó���� �����ϴµ�, SYSSTAUS <> 0  �ƴϸ� üũ
		if(gcds_data01.namevalue(i,"TAXNBR")!=""&& gcds_data01.SysStatus(i)!=0){
			alert("�̹� ���ݰ�꼭�� ����Ǿ����ϴ�." +i+" ���� ������ ������ �Ұ��մϴ�.");
			return false;
		}
		
		//��û��ǥ�� �����ϴµ�, SYSSTAUS <> 0  �ƴϸ� üũ
		if(gcds_data01.namevalue(i,"APPFSDAT")!=""&&gcds_data01.SysStatus(i)!=0){
			alert("�̹� ��û��ǥ�� ����Ǿ����ϴ�." +i+" ���� ������ ������ �Ұ��մϴ�.");
			return false;
		}
		
		//�ʼ��׸� üũ
		//��û����
		if(gcds_data01.namevalue(i,"APPDATE")==""){
			alert(i+"��° ���� ��û���ڰ� �ʿ��մϴ�.");
			return false;
		}
		
		//��������
		if(gcds_data01.namevalue(i,"PAYKND")==""){ 
			alert(i+"��° ���� ����������  �ʿ��մϴ�.");
			return false;
		}
		
		if(gcds_data01.namevalue(i,"PAYKND")=="1"){ //��������	
			if(gcds_data01.namevalue(i,"REQDATE")!=""){
				alert(i+"��° ���� ���޿�û���� �ԷºҰ� �Դϴ�.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="2"){ //��������
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"��° ���� ���������� ���޿�û���� �ʼ��׸� �Դϴ�.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="3"){ //�ڵ�����
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"��° ���� �ڵ������ ���޿�û���� �ʼ��׸� �Դϴ�.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="4"){ //���γ���
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"��° ���� ���γ����� ���޿�û���� �ʼ��׸� �Դϴ�.");
				return false;
			}
		}
		
		
		//���ޱ���
		if(gcds_data01.namevalue(i,"PAYGB")==""){
			alert(i+"��° ���� ���ޱ����� �ʿ��մϴ�.");
			return false;
		}
		
		
		//�ŷ�ó
		if(gcds_data01.namevalue(i,"VENDCD")==""){
			alert(i+"��° ���� �ŷ�ó�ڵ尡 �ʿ��մϴ�.");
			return false;
		}
		
		if(gcds_data01.namevalue(i,"VENDNM")==""){
			alert(i+"��° ���� �ŷ�ó���� �ʿ��մϴ�.");
			return false;
		}
		
		
		//�����ε� ���¹�ȣ�� ���� ���� üũ��.
		if(gcds_data01.namevalue(i,"PAYGB")=="1"||gcds_data01.namevalue(i,"PAYGB")=="3"){ //�����ϰ�츸 ���¹�ȣ �ʼ� üũ 
			if(gcds_data01.namevalue(i,"PAYACCTNO")==""){
				alert(i+"��° ���� ���¹�ȣ�� �ʿ��մϴ�.");
				return false;
			}
		}
		
		
		//����
		if(gcds_data01.namevalue(i,"REMARK")==""){
			alert(i+"��° ���� ���䰡 �ʿ��մϴ�.");
			return false;
		}
		
		//���ް���
		if(gcds_data01.namevalue(i,"SUPAMT")==0){
			alert(i+"��° ���� ���ް����� �ʿ��մϴ�.");
			return false;
		}
		
		
		
		//���ޱ��� ��ȭ
		if(gcds_data01.namevalue(i,"PAYGB")=="3"||gcds_data01.namevalue(i,"PAYGB")=="4"){
			//��ȭ��
			if(gcds_data01.namevalue(i,"CURUNIT")==""){
				alert(i+"��° ���� ��ȭ���� �ʿ��մϴ�.");
				return false;
			}
			//��ȭ
			if(gcds_data01.namevalue(i,"FOUTAMT")==""||gcds_data01.namevalue(i,"FOUTAMT")=="0"){
				alert(i+"��° ���� ��ȭ�� �ʿ��մϴ�.");
				return false;
			}
			//ȯ��
			if(gcds_data01.namevalue(i,"EXRATE")==""||gcds_data01.namevalue(i,"EXRATE")=="0"){
				alert(i+"��° ���� ȯ���� �ʿ��մϴ�.");
				return false;
			}
		}
		
		//�����ڵ�
		if(gcds_data01.namevalue(i,"ATCODE")==""){
			alert(i+"��° ���� �����ڵ尡 �ʿ��մϴ�.");
			return false;
		}
		
		//�����ڵ��
		if(gcds_data01.namevalue(i,"ATKORNAM")==""){
			alert(i+"��° ���� �������� �ʿ��մϴ�.");
			return false;
		}
		
		//�ΰ����� ����ó�� .. 
		if(gcds_data01.namevalue(i,"SUPVATAMT")>0 && (gcds_data01.namevalue(i,"PURGB")==""||gcds_data01.namevalue(i,"PURGB")=="F") ){
			alert(i+"��° ���� �ΰ����� �Ǵ� ����ó���� Ȯ���Ͻʽÿ�.");
			return false;
		}
	}
	return true;
}

<%
/******************************************************************************************
	Description : ����
*****************************************************************************************/
%>
function ln_Delete(){
	
	if(!ln_Chk_Delete(gcds_data01.rowposition))return;

	if (confirm("���� �Ͻðڽ��ϱ�?")){	
		gcds_data01.deleterow(gcds_data01.rowposition);
		gctr_data.KeyValue   = "Account.a300060_t1(I:USER=gcds_data01)";
		gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_t1?";
		gctr_data.Parameters = "v_str1="+gs_userid;
		gctr_data.post();
		ln_Query();			
	}	
}



function ln_Chk_Delete(srow){
	//���ݰ�꼭 üũ
	//��ǥüũ
	//������üũ
	if(gcds_data01.namevalue(srow,"TAXNBR")!=""){
		alert(srow+"��° ���� ��꼭��ȣ�� �����մϴ�. ���� �Ұ��մϴ�.");
		return false;
	}
	
	if(gcds_data01.namevalue(srow,"APPFSDAT")!=""){
		alert(srow+"��° ���� ��ǥ������ȣ�� �����մϴ�. ���� �Ұ��մϴ�.");
		return false;
	}
	
	if(gcds_data01.namevalue(srow,"PAYSTAT")!="1"){
		alert(srow+"��° ���� ���¸� Ȯ���Ͻʽÿ�. ���� �Ұ��մϴ�.");
		return false;
	}
	
	return true ;
}


/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
		
	if(gcds_data01.countrow<1){
		ln_Query("0");
	}	
		
	gcds_data01.addrow();
	gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE") = gs_fdcode;
	
	gcds_data01.namevalue(gcds_data01.rowposition,"APPDATE") = gcem_appdate.text;
	
	if(chkbox_reqdate.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"REQDATE") = gcem_reqdate0.text;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"REQDATE") = "";
	}
	
	if(chkbox_vendcd.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDCD")    = txt_vendcd0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM")    = txt_vendnm0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYACCTNO") = txt_payacctno0.value;
		//alert("txt_vendid0.value::"+txt_vendid0.value);
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDID")    = txt_vendid0.value;
		//alert("VENDID::"+gcds_data01.namevalue(gcds_data01.rowposition,"VENDID") );
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYGB") = gclx_paygb.bindcolval;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDCD")    = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM")    = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYACCTNO") = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDID")= "";
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYGB") = "";
	}
	
	if(chkbox_remark.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"REMARK") = gcem_remark0.text;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"REMARK") = "";
	}
	
	if(chkbox_atcode.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"ATCODE") = txt_atcode0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"ATKORNAM") = txt_atkornam0.value;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"ATCODE") = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"ATKORNAM") = "";
	}
	
	
	gcds_data01.namevalue(gcds_data01.rowposition,"APPEMPNO") = gs_userid;
	//gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM") = "";
	gcds_data01.namevalue(gcds_data01.rowposition,"PAYSTAT") = "1"; // ������
	
}


/******************************************************************************
Description : �����
******************************************************************************/
function ln_RowDel(){
	
	if(gcds_data01.countrow<1){
		alert("�� ������ ���� �������� �ʽ��ϴ�.");	
	}	
	
	if(!ln_Chk_Delete(gcds_data01.rowposition))return;
	
	gcds_data01.deleterow(gcds_data01.rowposition);

}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/


<%
/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
%>

function ln_Excel(){
	//gcgd_disp01.GridToExcel("���ں� �������� ��Ȳ","",2);
}


<%
/******************************************************************************
	Description : ��꼭 ������ ����
******************************************************************************/
%>

function ln_Create(){
	
	// ���ðǸ� ó�� 
	var dbltaxsum = 0;
	var dbltaxvatsum = 0;
	var dbltaxtot=0;
	var strCnt=0;
	var strPurgbCnt=0;
	var strRemark="";
	var strVendcd="";
	var strVendnm="";
	var strVendcd_Temp="";
	var strCOCOMYN="";
	
	//üũ�� ���� �� �ǵ� ���� ���
	
	// ��꼭 ���� üũ ������ ����
	if(gcem_taxdat.text==""){
		alert("��꼭���ڰ� �����Ǿ����ϴ�.Ȯ�ιٶ��ϴ�.");
		return false;
	}
	
	// üũ ���� ��ü�� �ƴ� ���� 2�� �̻� �����ϸ� üũ
	for(var j=1;j<=gcds_data01.countrow; j++){		
		if(gcds_data01.namevalue(j,"CHKBOX")=="T"){
			strCnt+=1;
			if(strCnt==1){
				strVendcd_Temp = gcds_data01.namevalue(j,"VENDCD");
			}else if(strCnt >1){
				if(strVendcd_Temp!=gcds_data01.namevalue(j,"VENDCD")){
					alert("���� �ŷ�ó�� ���Ի��� �����մϴ�.");
					return false;
				}
			}
		}
	}
	
	if(strCnt==0) {
		alert("�ڱݽ�û������ �����Ͻʽÿ�.");
		return false; 
	}
	
	
	// �μ�üũ 
	if(gdeptcd==""){
		alert("�μ��ڵ带 Ȯ���Ͻʽÿ�.");
		return false;
	}
	
	// EMPNO üũ
	if(gusrid==""){
		alert("ó���� ����� Ȯ���Ͻʽÿ�.");
		return false;
	}
	
	ln_Appno_SetDataHeader();
	strCnt=0;
	for(var i=1; i<=gcds_data01.countrow; i++){		
		if(gcds_data01.namevalue(i,"CHKBOX")=="T"){
			strCnt+=1;
			
			if(strCnt==1){
				strVendcd = gcds_data01.namevalue(i,"VENDCD");
				strRemark = gcds_data01.namevalue(i,"REMARK");
				strCOCOMYN = gcds_data01.namevalue(i,"COCOMYN");
			}
			
			//����ó�� üũ�� 
			if(gcds_data01.namevalue(i,"PURGB")=="T"){	
				strPurgbCnt+=1;
				gcds_appno.addrow();
				gcds_appno.namevalue(gcds_appno.rowposition,"APPNO")=gcds_data01.namevalue(i,"APPNO");  
				gcds_appno.namevalue(gcds_appno.rowposition,"UPDT")=gs_date;
				gcds_appno.namevalue(gcds_appno.rowposition,"UPID")=gs_userid;
				
				dbltaxsum +=gcds_data01.namevalue(i,"SUPAMT");
				dbltaxvatsum +=gcds_data01.namevalue(i,"SUPVATAMT") ;
				dbltaxtot = dbltaxtot+dbltaxsum+dbltaxvatsum;
			}
		}
	}
	
	if(strPurgbCnt==0){
		alert("����ó�� ���� �������� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.");
		return false;
	}
	
	ln_Taxmst_SetDataHeader();
	ln_Taxdtl_SetDataHeader();
	
	gcds_taxmst.Addrow();
	
	var row = 0;
	row = gcds_taxmst.rowposition;
	var strdat = gcem_taxdat.text; 
	var strtaxkidiv ="";

	if (strdat.substring(4,6) >='01' && strdat.substring(4,6) <='03') {
		strtaxkidiv="1";	//���[1]
	}else if(strdat.substring(4,6) >='04' && strdat.substring(4,6) <='06') {
		strtaxkidiv="2";	//���[2]
	}else if(strdat.substring(4,6) >='07' && strdat.substring(4,6) <='09') {
		strtaxkidiv="3";	//���[3]
	}else if(strdat.substring(4,6) >='10' && strdat.substring(4,6) <='12') {
		strtaxkidiv="4";	//���[4]
	}
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCODE")="02"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"DEPTCD")=gdeptcd; //�Է°�
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"EMPNO")=gusrid;  //�Է°� 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXIODIV")="A"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXDIV")="0001"; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND");  //�Է°�
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"VEND_CD")=strVendcd; //�Է°�
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXDAT")=gcem_taxdat.text;  //�Է°�
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXSUM")=dbltaxsum;    //�Է°�
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")=dbltaxvatsum; //�Է°� 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXTOT")=dbltaxtot;    //�Է°�
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK")=strRemark;     //�Է°�
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXCDNBR")="";  //�ſ�ī�� ����
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"ATCODE");     //�Է°�
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXPRTYN")="Y";  
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXCNT")="0"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"LASTPRT")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXTYPE")="N"; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"FSDAT");     //��ǥ������ ������Ʈ 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"FSNBR");     //��ǥ������ ������Ʈ
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKIDIV")=strtaxkidiv;  //�Է°� (��꼭���ڷ� ���) 1,2,3,4
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"FDCODE")=gclx_fdcode.bindcolval;     
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WORKTYPE")="A"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REPORT")=""; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRDT"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRID"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPDT"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPID"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SSDAT"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SSNBR"); 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SEQ")=0; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"CONVERSATION_ID")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SUPBUY_TYPE")=""; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"DIRECTION"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"GUBUN"); //�Է°�
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"AMEND_CODE")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"AMEND_REMARK")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"EXTCHK")="0"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK2")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK3")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"S_BIZPLACE")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"B_BIZPLACE")="0001"; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COSTCD"); //�Է°�
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCOMYN")=strCOCOMYN; 
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRDT")=gs_date ;
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRID")=gs_userid ;
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPDT")=gs_date ;
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPID")=gs_userid ;
	
	gcds_taxdtl.Addrow();
	
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSEQ")="001";
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")=strRemark;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")=dbltaxsum;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")=dbltaxvatsum;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRID")=gs_userid;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPID")=gs_userid;	
}

<%
/******************************************************************************
	Description : ��꼭 ������ ����  && ��꼭 ��ȣ ������Ʈ
******************************************************************************/
%>

function ln_Save_Tax(){
	var strParam="";
	//���� A-����, B-����  , ���� C-����, D-���� , �ݰ��� E-����, F-����
	if(gclx_fdcode.bindcolval =="02"){        // ���� 
		strParam ="A";
	}else if(gclx_fdcode.bindcolval =="03"){ //�ݰ���
		strParam ="E";
	}else if(gclx_fdcode.bindcolval =="04"){ //���� 
		strParam ="C";
	}else{
		alert("������ Ȯ���ϼ���.");
	} 
	strParam = strParam+gcem_taxdat.text.substring(0,6); //���а�+���:
		
	if(!ln_Chk_Tax())return;
	if (gcds_taxmst.IsUpdated) {	
		if (confirm("����[����]������ ���� �Ͻðڽ��ϱ�?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_t2";
			gctr_data.KeyValue = "Account.a300060_t2(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,I:USER3=gcds_appno)";	
			gctr_data.Parameters ="v_str1="+strParam;
			//prompt('',gcds_taxmst.text);
			//prompt('',gcds_taxdtl.text);
			gctr_data.post();
		}	
	}
}

<%
/******************************************************************************
Description : �ʼ��׸� üũ 
******************************************************************************/
%>
function ln_Chk_Tax(){

	 if (fn_trim(gs_date)=="")   { alert("������ �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");  return false; }
	 if (fn_trim(gs_userid)=="") { alert("ó���ڰ� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");  return false; }
	 
	 
	 //�������� üũ 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")==""){
		 alert("���������� �ʼ��׸��Դϴ�.");
		 return false;
	 }
	 
	 //ǰ������ üũ 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK")==""){
		 alert("ǰ�������� �ʼ��׸��Դϴ�.");
		 return false;
	 }
	 
	 //������ üũ 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"ATCODE")==""){
		 alert("������ �ʼ��׸��Դϴ�.");
		 return false;
	 }
	 
	 //�����ڵ� 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COSTCD")==""){
		 alert("�����ڵ�� �ʼ��׸��Դϴ�.");
		 return false;
	 }
	
	 //���� 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"GUBUN")==""){
		 alert("���ڹ��౸���� �ʼ��׸��Դϴ�.");
		 return false;
	 }
	  
	 //�����ϰ�� 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="1"){ 
		//0�̸� �ȵ�.
	 	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")==0){
	 		alert("�������а� �ΰ������� ���� �ʽ��ϴ�.Ȯ�� �ٶ��ϴ�.");
	 		return false;
	 	}	
	 }else if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="2"||gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="3"){ //���� �鼼�� ��� �ΰ����� üũ 
		//0�� �ƴϸ� �ȵ�.
	 	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")!=0){
	 		alert("�������а� �ΰ������� ���� �ʽ��ϴ�.Ȯ�� �ٶ��ϴ�2.");
	 		return false;
	 	}	
	 }
	 
    //���������� �ſ�ī�� �� ��� ���⼭�� ����.  
	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="8"){
		alert("�������� Ȯ�� �ٶ��ϴ�.");
		return false;
	}

    //�鼼��ü�ε�, ���������� �鼼�� �ƴϸ� üũ.
    if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCOMYN")=="M"){    	
    	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")!="3"){
    		alert("�鼼��ü�� ���������� [�鼼]�� �����մϴ�.");
    		return false;
    	}
    }
	 
    //���̰������� ��� �ΰ����� 0��  ( �� üũ )
    if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCOMYN")=="T" ){   
    	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")!=0){
    		alert("���̰��� ��ü�Դϴ�. �ΰ������� Ȯ�� �Ͻʽÿ�.");
    		return false;
    	}
    }
    
	return true;
}



<%
/******************************************************************************
	Description : ��꼭 ������ ���� ��� 
******************************************************************************/
%>

function ln_Cancel_Tax(){

	gcds_taxmst.undoAll();
}



<%
/******************************************************************************
Description : ���� / ����μ� �˾�
******************************************************************************/
%>
function ln_Popup_Costbgt(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(gcds_data01.namevalue(row,"COSTGB")=="1"){         //����
		
		arrParam[0] ="0030";
		arrParam[1] = "";
		arrParam[2]="";
		arrParam[3]="";
		arrParam[4]="02";
		
		
		strURL = "./commdtil_cost_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"COSTBGT")   = arrResult[0];  // �ڵ� 
			gcds_data01.namevalue(row,"COSTBGTNM") = arrResult[1];  // ������
		}else{
			gcds_data01.namevalue(row,"COSTBGT")   = "";
			gcds_data01.namevalue(row,"COSTBGTNM") = "";
		}
		
	}else if(gcds_data01.namevalue(row,"COSTGB")=="2"){  //����
		
		arrParam[0] ="0003";
		arrParam[1] = "";
		arrParam[2]="";
		arrParam[3]="";

		
		//strURL = "./commdtil_popup2.jsp";
		strURL = "./commdtil_popup_ifrm.jsp";
		
	    strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"COSTBGT")   = arrResult[0];  // �ڵ� 
			gcds_data01.namevalue(row,"COSTBGTNM") = arrResult[1];  // ����μ���
		}else{
			gcds_data01.namevalue(row,"COSTBGT")   = "";
			gcds_data01.namevalue(row,"COSTBGTNM") = "";
		}
		
	}
}



<%
/******************************************************************************
Description : ���� �˾�
******************************************************************************/
%>
function ln_Popup_Atcode0(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	arrParam[1]='';
	
	strURL = "./actcode_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		txt_atcode0.value   = arrResult[0];  // �ڵ� 
		txt_atkornam0.value = arrResult[1];  // �ŷ�ó��
	}else{
		txt_atcode0.value   = "";  // �ڵ� 
		txt_atkornam0.value = "";  // �ŷ�ó��
	}
}

<%
/******************************************************************************
Description : ���� �˾�
******************************************************************************/
%>
function ln_Popup_Atcode(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	arrParam[1]='';
	
	strURL = "./actcode_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_data01.namevalue(row,"ATCODE")   = arrResult[0];  // �ڵ� 
		gcds_data01.namevalue(row,"ATKORNAM") = arrResult[1];  // �ŷ�ó��
	}else{
		gcds_data01.namevalue(row,"ATCODE")   = "";
		gcds_data01.namevalue(row,"ATKORNAM") = "";
	}
}

<%
/******************************************************************************
Description : ���� �˾�
******************************************************************************/
%>
function ln_Popup_Atcode2(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	arrParam[1]='';
	
	strURL = "./actcode_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_taxmst.namevalue(row,"ATCODE")   = arrResult[0];  // �ڵ� 
		//gcds_taxmst.namevalue(row,"ATKORNAM") = arrResult[1];  // �ŷ�ó��
	}else{
		gcds_taxmst.namevalue(row,"ATCODE")   = "";
		//gcds_taxmst.namevalue(row,"ATKORNAM") = "";
	}
}


<%
/******************************************************************************
Description : ���� �˾�
******************************************************************************/
%>
function ln_Popup_Costcd2(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
		
	arrParam[0] ="0030";
	arrParam[1] = "";
	arrParam[2]="";
	arrParam[3]="";
	arrParam[4]="02";
	
	strURL = "./commdtil_cost_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_taxmst.namevalue(row,"COSTCD") = arrResult[0];  // �ڵ� 
		//gcds_taxmst.namevalue(row,"COSTNM") = arrResult[1];  // ������
	}else{
		gcds_taxmst.namevalue(row,"COSTCD") = "";
		//gcds_taxmst.namevalue(row,"COSTNM") = "";
	}
}

<%
/******************************************************************************
Description : �ŷ�ó ���� �˾�
******************************************************************************/
%>
function ln_Popup_Payacctno(row){
	
	if(gcds_data01.namevalue(row,"PAYGB")==""){
		alert(row+"��° ���� ���ޱ����� �ʿ��մϴ�.");
		return false;
	}
	
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	//arrParam[0]=gcds_data01.namevalue(row,"VENDNM");
	//arrParam[1]='B';
	
	if(gcds_data01.namevalue(row,"PAYGB")=="1"||gcds_data01.namevalue(row,"PAYGB")=="3"){ //����
	
		strURL = "./a300060_popup.jsp";
	    strPos = "dialogWidth:480px;dialogHeight:450px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"VENDCD")     = arrResult[0];  // �ڵ� 
			gcds_data01.namevalue(row,"VENDNM")     = arrResult[1];  // �ŷ�ó��
			gcds_data01.namevalue(row,"PAYACCTNO")  = arrResult[2];  // ����
			gcds_data01.namevalue(row,"VENDID")     = arrResult[3];  // ����ڹ�ȣ
		}else{
			gcds_data01.namevalue(row,"VENDCD")     = "";  // �ڵ� 
			gcds_data01.namevalue(row,"VENDNM")     = "";  // �ŷ�ó��
			gcds_data01.namevalue(row,"PAYACCTNO")  = "";  // ����
			gcds_data01.namevalue(row,"VENDID")     = "";  // ����ڹ�ȣ
		}
		
	}else if(gcds_data01.namevalue(row,"PAYGB")=="2"||gcds_data01.namevalue(row,"PAYGB")=="4"){ //����
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"VENDCD") = arrResult[0];
			gcds_data01.namevalue(row,"VENDNM") = arrResult[1];
			gcds_data01.namevalue(row,"PAYACCTNO") = "";
			gcds_data01.namevalue(row,"VENDID")    = arrResult[5];  // ����ڹ�ȣ
		} else {
			gcds_data01.namevalue(row,"VENDCD")="";
			gcds_data01.namevalue(row,"VENDNM")="";
			gcds_data01.namevalue(row,"PAYACCTNO")  = "";
			gcds_data01.namevalue(row,"VENDID")     = "";  // ����ڹ�ȣ
		}	
	}
}


<%
/******************************************************************************
Description : �ŷ�ó ���� �˾� 
******************************************************************************/
%>
function ln_Popup_Payacctno_0(){
	
	if(gclx_paygb.bindcolval==""){
		alert("���ޱ����� �����Ͻʽÿ�.");
		return false;
	}
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(gclx_paygb.bindcolval=="1"||gclx_paygb.bindcolval=="3"){//������ ��� ��������
	
		strURL = "./a300060_popup.jsp";
	    strPos = "dialogWidth:480px;dialogHeight:450px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			txt_vendcd0.value    = arrResult[0];  // �ڵ� 
			txt_vendnm0.value    = arrResult[1];  // �ŷ�ó��
			txt_payacctno0.value = arrResult[2];  // ����
			txt_vendid0.value    = arrResult[3];  // ����ڹ�ȣ
		}else{
			txt_vendcd0.value    = "";  // �ڵ� 
			txt_vendnm0.value    = "";  // �ŷ�ó��
			txt_payacctno0.value = "";  // ����
			txt_vendid0.value    = "";  // ����ڹ�ȣ
		}
	
	}else if(gclx_paygb.bindcolval=="2"||gclx_paygb.bindcolval=="4"){//�����ϰ�� �ŷ�ó ���� 
		
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
			arrResult = result.split(";");
			txt_vendcd0.value = arrResult[0];
			txt_vendnm0.value = arrResult[1];
			txt_payacctno0.value = "";
			txt_vendid0.value    = arrResult[5]; 
		} else {
			txt_vendcd0.value="";
			txt_vendnm0.value="";
			txt_payacctno0.value = "";
			txt_vendid0.value    = ""; 
		}	
	}
}

<%
/******************************************************************************
Description : ã�� - �ۼ��� 
******************************************************************************/
%>
function ln_Popup_Appempno(){

	if(gusrid=="6070001"){
		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
		strURL = "./empno_popup.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_appempno.text    = arrParam[1];
			gcem_appempnm.text    = arrParam[0];
		}else{
			gcem_appempno.text="";
			gcem_appempnm.text="";
		}
	}
}


<%
/******************************************************************************
Description : ã�� - ��ȭ 
******************************************************************************/
%>
function ln_Popup_Curunit(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]="1043";
	arrParam[1]="";
	arrParam[2]="";
	
	strURL = "./commdtil_popup_ifrm.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	
	if(result != null) {
		arrResult = result.split(";"); 
		gcds_data01.namevalue(row,"CURUNITCD")  = arrResult[0];  // ��ȭ���ڵ�
		gcds_data01.namevalue(row,"CURUNIT")    = arrResult[1];  // ��ȭ��
	}else{
		gcds_data01.namevalue(row,"CURUNITCD")  = ""; 
		gcds_data01.namevalue(row,"CURUNIT")    = "";
		
	}
}

<%
/******************************************************************************
Description : �ŷ�ó �ʱ�ȭ
******************************************************************************/
%>
function fnSelCostCleanup_0(){
	txt_vendcd0.value="";
	txt_vendnm0.value="";
	txt_payacctno0.value="";
	txt_vendid0.value="";
	gclx_paygb.bindcolval="";
}

<%
/******************************************************************************
Description : Report Head ���� - ���ݰ�꼭 �󼼳���
******************************************************************************/
%>
function ln_Taxmst_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,"
        	   + "TAXDIV:STRING,TAXKND:STRING,VEND_CD:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,"
			   + "TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,REMARK:STRING,TAXCDNBR:STRING,ATCODE:STRING,"
			   + "TAXPRTYN:STRING,TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,"
			   + "FSNBR:STRING,TAXKIDIV:STRING,FDCODE:STRING,WORKTYPE:STRING,REPORT:STRING,"
			   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING,"
			   + "SEQ:DECIMAL,CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,"
			   + "GUBUN:STRING,AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,"
			   + "REMARK3:STRING,S_BIZPLACE:STRING,B_BIZPLACE:STRING,COSTCD:STRING,COCOMYN:STRING,EBILLGB:STRING";
	gcds_taxmst.SetDataHeader(s_tmp1);
}

<%
/******************************************************************************
	Description : Report Head ���� - ���ݰ�꼭 �󼼳���
******************************************************************************/
%>
function ln_Taxdtl_SetDataHeader(){
	var s_tmp1 = "TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,TAXQTY:DECIMAL,"
			   + "TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MMDD:STRING,TAXTOT:DECIMAL";
	gcds_taxdtl.SetDataHeader(s_tmp1);
	
}

<%
/******************************************************************************
	Description : Report Head ���� - ���ݰ�꼭 �󼼳���
******************************************************************************/
%>
function ln_Appno_SetDataHeader(){
	var s_tmp1 = "APPNO:STRING,TAXNBR:STRING,UPDT:STRING,UPID:STRING";
	gcds_appno.SetDataHeader(s_tmp1);
}


<%
/******************************************************************************
	Description : ��ü����
******************************************************************************/
%>
function ln_CheckAll(){
	
	if(chkbox_all.checked==true){
		chkbox_reqdate.checked=true;
		chkbox_vendcd.checked=true;
		chkbox_remark.checked=true;
		chkbox_atcode.checked=true;
	}else{
		chkbox_reqdate.checked=false;
		chkbox_vendcd.checked=false;
		chkbox_remark.checked=false;
		chkbox_atcode.checked=false;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--�ڱݽ�û���� -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--���԰�꼭 -->
<object  id=gcds_taxmst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxdtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_fdcode classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_taxknd classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id=gcds_appno classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_temp01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_temp02 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
	
	if(row>0){
		
		if(colid=="VENDCD"){
			ln_Popup_Payacctno(row); 
		}
		if(colid=="COSTBGT"){
			ln_Popup_Costbgt(row);
		}
		
		if(colid=="ATCODE"){
			ln_Popup_Atcode(row);
		}
		
		if(colid=="CURUNIT"){
			ln_Popup_Curunit(row);
		}
	}
</script>


<script language="javascript"  for=gcgd_disp01  event=OnClick(row,colid)>

	if(row>0){
		if(colid =="CHKBOX"){
			//��꼭��ȣ Ȯ��
			if(gcds_data01.namevalue(row,"TAXNBR")!=""){
				alert("��꼭��ȣ�� �̹� �����մϴ�.");

				gcds_data01.namevalue(row,"CHKBOX")="F";
				return false;
			}
			
			//������ȣ �ִ��� Ȯ��
			if(gcds_data01.namevalue(row,"APPFSDAT")!=""){
				alert("��û��ǥ��  �̹� �����մϴ�.");
				gcds_data01.namevalue(row,"CHKBOX")="F";
				return false;
			}
			
			//������ ���°� Ȯ��.
			if(gcds_data01.namevalue(row,"PAYSTAT")=="2"||gcds_data01.namevalue(row,"PAYSTAT")=="3"){
				alert("���޻��¸� Ȯ���Ͻʽÿ�.");
				gcds_data01.namevalue(row,"CHKBOX")="F";
				return false;
			}
		}
	}
</script>

<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
    
	if(row>0){
		if(colid=="SUPVATAMT"){
			if(gcds_data01.namevalue(row,"SUPVATAMT")!=0){
				gcds_data01.namevalue(row,"PURGB")="T";   //����ó�� �ڵ� üũ
			}else{
				
			}
		}
	}
</script>



<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	
	if(row>0){	
		if(colid=="ATCODE"){
			ln_Popup_Atcode2(row);
		}
		
		if(colid=="COSTCD"){
			ln_Popup_Costcd2(row);
		}
	}
</script>

<script language=JavaScript for=gcds_data01 event=onColumnChanged(row,colid)>

	if(colid == "PAYKND") { //��������
		if(gcds_data01.namevalue(row,colid)=="1"){ //��������
			gcds_data01.namevalue(row,"REQDATE")="";
		}
	}else if(colid == "PAYGB") { // ���ޱ���
		if(gcds_data01.namevalue(row,colid)=="1"||gcds_data01.namevalue(row,colid)=="2"){ // ���뿹��, ���ݿ�ȭ
			gcds_data01.namevalue(row,"CURUNIT")="";
			gcds_data01.namevalue(row,"FOUTAMT")=0;
			gcds_data01.namevalue(row,"EXRATE")=0;
		}
	}

</script>
 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_delete.gif"	        style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Delete()">
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:0 solid #708090'>
				<tr>
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>����</nobr></td>
					<td class="tab24" style="width:120px">
						<comment id="__NSID__">
							<object  id=gclx_fdcode classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=ComboDataID      value="gcds_fdcode">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>��û��</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_appdate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_appdate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>���޿�û��</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_reqdate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
					
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>ó����</nobr></td>
					<td class="tab24" >
						<comment id="__NSID__">
						<object id=gcem_appempno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="#######">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Appempno()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_appempnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:80px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Enable		  value="false">
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
			    <tr>
			        <td><font size="2" color="blue" ><strong>&nbsp;[�ڱݽ�û����]</strong></font>&nbsp;
			        	<input type=checkbox  id=chkbox_all  style="width:15px;position:relative;left:0px;top:-3px"   onclick="ln_CheckAll()">&nbsp;��ü
			        </td>
				    <td align = right>
				    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Add()"></font>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_RowDel()"></font>
					</td>
				</tr>
				
			    <tr height='25px'>
			    	<td style="position:relative;left:6px;" colspan=2>
			    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
			    			<tr>                                                                     
			                    <td align="center" class="text" width="65">���޿�û��</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                        <input type=checkbox  id=chkbox_reqdate  style="width:15px;position:relative;left:0px;top:-3px">&nbsp;&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_reqdate0 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									</object>
									</comment><script>__ws__(__NSID__);</script>   
									<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate0', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
			                    </td>
			                    <td align="center" class="text" width="65">�ŷ�ó����</td>   
		                        <td bgcolor="#FFFFFF"  colspan=5 >&nbsp;
		                             <input type=checkbox  id=chkbox_vendcd    style="position:relative;left:0px;top:-3px;width:15px;">&nbsp;&nbsp;
		                             
		                             <comment id="__NSID__">
										<object  id=gclx_paygb classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:4px;top:5px;font-size:12px;width:98px;">
											<param name=CBData			        value="1^���뿹��,2^����,3^��ȭ���뿹��,4^����(��ȭ)">
											<param name=CBDataColumns	 		value="CODE,NAME">
											<param name=SearchColumn	     	value=NAME>
											<param name=Sort			        value=false>
											<param name=ListExprFormat       	value="NAME">								
											<param name=BindColumn		     	value="CODE">
										</object>
									 </comment><script>__ws__(__NSID__);</script>
		                             
		                             <input id="txt_vendcd0"    type=text      style= "position:relative;top:-2px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7;"  readOnly>
									 <img src="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:3px;top:5px" align=center onclick="ln_Popup_Payacctno_0();">
								     <input id="txt_vendnm0"    type="text"    style= "position:relative;top:-2px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" " readOnly>			
		                             <input id="txt_vendid0"    type="text"    style= "position:relative;top:-2px;left:4px;width:100px; height:20px;" class="txtbox"  maxlength="36" " readOnly>
		                             <input id="txt_payacctno0" type="text"    style= "position:relative;top:-2px;left:4px;width:130px; height:20px;" class="txtbox"  maxlength="36" " readOnly>
		                             <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="�� �����">
		                         </td>
			                 </tr>
			                 <tr>   
			                    <td align="center" class="text" width="65">����</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                        <input type=checkbox  id=chkbox_remark  style="width:15px;position:relative;left:0px;top:-3px;">&nbsp;&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_remark0 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:150px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="">
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									</object>
									</comment><script>__ws__(__NSID__);</script>   
			                    </td>
			                    <td align="center" class="text" width="65">��������</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                        <input type=checkbox     id=chkbox_atcode     style="width:15px;position:relative;left:0px;top:-3px">&nbsp;&nbsp;
		                            <input id="txt_atcode0"    type=text        style="position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7;"  readOnly>
									<img src="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup_Atcode0();">
								    <input id="txt_atkornam0"    type="text"    style="position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" " readOnly>			
			                    </td>
			    			</tr>
			       		</table>
			       	</td>
			 	</tr>
				
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:345px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data01">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<param name="GTitleHeight"  value=25>
							<param name="TitleHeight"   value="25">
							<param name=RowHeight       value="20">
							<param name="UsingOneClick" value="1">
							<PARAM NAME="Format"        VALUE="  
								<FC> Name='����'       ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </FC>
								<FC> Name='��û����'    ID=APPDATE        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' bgcolor='#eeeeee' </FC>
								<FG> Name='��������'    HeadAlign=Center  HeadBgColor=#B9D4DC
								<FC> Name='����'       ID=PAYKND         HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:��������,2:��������,3:�ڵ����,4:���γ���'</FC>
								<FC> Name='��û��'      ID=REQDATE	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  MASK='XXXX/XX/XX' bgcolor={Decode(PAYKND,2,'',3,'',4,'','#eeeeee')} edit={Decode(PAYKND,1,none,'')} </FC>    
								<FC> Name='���ޱ���'    ID=PAYGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:���뿹��,2:����,3:��ȭ���뿹��,4:����(��ȭ)'</FC>
								</FG>
								<FG> Name='�ŷ�ó����'   HeadAlign=Center HeadBgColor=#B9D4DC
								<FC> Name='�ڵ�'	      ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  EditStyle=Popup </FC>
								<FC> Name='��Ϲ�ȣ'	  ID=VENDID 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'  mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</FC>
								<FC> Name='�ŷ�ó��'	  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								<FC> Name='���¹�ȣ'    ID=PAYACCTNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								</FG>
								<C> Name='����'  	 ID=REMARK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	SumBgColor='#C3D0DB'  </C>
								<C> Name='���ް���'    ID=SUPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  SumText=@sum</C>
								<C> Name='�ΰ�����'    ID=SUPVATAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  SumText=@sum</C>
								
								<G> Name='��ȭ����'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��ȭ��'     ID=CURUNIT 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} EditStyle=Popup</</C>
								<C> Name='��ȭ'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} SumText=@sum</C>
								<C> Name='ȯ��'       ID=EXRATE  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} </C>
								</G>
								
								<G> Name='��������'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�ڵ�'	     ID=ATCODE 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	SumBgColor='#C3D0DB'  EditStyle=Popup</C>
								<C> Name='������'	     ID=ATKORNAM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	    align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								</G>
								<G> Name='����/��������' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����'	     ID=COSTGB  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=center 	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:����,2:����'</C>
								<C> Name='�ڵ�'	     ID=COSTBGT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='����/�����'	 ID=COSTBGTNM  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								</G>
								
								<G> Name='��������'    HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����ó��'    ID=PURGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=53    	align=center	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </C>
								<C> Name='��꼭��ȣ'   ID=TAXNBR 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none MASK='XXXXXXX-XXXX' bgcolor='#eeeeee'</C>
								</G>
								<G> Name='��û��ǥ����'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��������'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								<C> Name='������ȣ'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
							    </G>
								<C> Name='���޻���'    ID=PAYSTAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:������,2:����,3:����' bgcolor='#eeeeee'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				
				<tr><td colspan=2>&nbsp;</td></tr>
				<tr>
					<td><font size="2" color="blue" ><strong>&nbsp;[���԰�꼭 ���]</strong></font>&nbsp;
					    <font size="2" color="black" >&nbsp;* ��꼭����</font>			
						<comment id="__NSID__">
							<object  id=gcem_taxdat classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">
					</td>
					 <td align = right>
				    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_create.gif"	 style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Create()"></font>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_save.gif"	     style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Save_Tax()"></font>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"	 style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Cancel_Tax()"></font>
					</td>
				</tr>
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp02 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:100px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_taxmst">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1"> 
							<PARAM NAME="Format"        VALUE="  
								<C> Name='��꼭����'  ID=TAXDAT 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	    align=center  	SumBgColor='#C3D0DB'  edit=none mask='XXXX/XX/XX'</C>
								<C> Name='�ŷ�ó'	    ID=VEND_CD	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	   	align=left	    SumBgColor='#C3D0DB'  edit=none </C>    
								<C> Name='��������'	ID=TAXKND 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80   	align=center 	SumBgColor='#C3D0DB'  EditStyle=Lookup	Data='gcds_taxknd:CDCODE:CDNAM'</C>
								<C> Name='ǰ������'	ID=REMARK   	    HeadAlign=Center HeadBgColor=#B9D4DC Width=200    	align=left   	SumBgColor='#C3D0DB'  </C>
								<C> Name='���ް���'   ID=TAXSUM 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right	    SumBgColor='#C3D0DB'  edit=none  SumText=@sum</C>
								<C> Name='�ΰ�����'	ID=TAXVATAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none  SumText=@sum</C>
							    <C> Name='������'	ID=ATCODE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=center	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
							    <C> Name='�����ڵ�'	ID=COSTCD 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=center	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
							    <C> Name='����'	    ID=GUBUN 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:���ڹ���,2:�������' </C>
							    <C> Name='eBill����'	ID=EBILLGB 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:����Ʈ��,2:Ʈ������,9:��Ÿ' </C> 
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
						<font size="2" color="black" >&nbsp; 1.[�ڱݽ�û����]���� ����ó�� üũ �� ���Ի��� �����մϴ�.</font>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

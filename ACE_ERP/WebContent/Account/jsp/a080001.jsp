<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫���� - �����û
+ ���α׷� ID	:  A080001.html
+ �� �� �� ��	:  �����û ���,����,��ȸ �� ��� ȭ���̴�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 a080001_s1
------------------------------------------------------------------------------
+ �� �� �� �� :	���Ѻ���
+ ��   ��  �� : �̹���
+ �� �� �� �� : 2006.10.31
------------------------------------------------------------------------------
+ �� �� �� �� :	DB2 >> ORACLE
+ ��   ��  �� : ������
+ �� �� �� �� : 2013.12.18
------------------------------------------------------------------------------>
<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�����û</title>


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
var gs_date3  = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_vendcd = "";	//������������

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_DispChk(0);
	ln_Before();
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(e){
	if(e=="01") {
		if(ln_Chk()) {
		ln_DispChk3();	 // ��ư����
		var str1 = gclx_fdcode.BindColVal;	//��������
		var str2 = gcem_bgtyy.text;					//����⵵
		var str3 = gcem_bgtdept.text;	//��û�μ�
		var str4 = gclx_fsrefcd.BindColVal;	//�����׸�
		var str5 = gcem_atcode.text;				//�������
		var str6 = gclx_satcode.BindColVal;	//������
		var str7 = Number(str2-1);					//���⵵
		//var str8 = gclx_costcd.BindColVal;	//����з�

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s1?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
											//+"&v_str8="+str8;

		//prompt('',gcds_data1.DataID);
		gcds_data1.Reset();
		}
	}else if(e=="02") {
		var str1 = gclx_sfdcode5.BindColVal;	//����
		var str2 = gcem_bgtyy55.text;					//�⵵
		var str3 = gcem_bgtdept1.text;		//��û�μ�
		var str4 = gclx_bgtdiv5.BindColVal;		//��û����
		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s2?"
											+ "v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
		gcds_data5.Reset();
	}
}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./a080001_p1.jsp";
	strPos = "dialogWidth:395px;dialogHeight:120px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
    var term = 0;
    var temp = 0;
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		
        term = arrParam[1]-arrParam[0]+1;
        temp = arrParam[0];
        
	} else {
	
	}
  var tempmon = new Array();
  
  for(var i=0; i<gcds_data1.countrow;i++){
    tempmon[i] = gcds_data1.namevalue(i+1,"BGTMM");
  }
  
	gcds_data1.ClearData();

	for(var i=1;i<=term;i++){
		gcds_data1.AddRow();
		if(temp<10) {
      		gcds_data1.namevalue(i,"BGTMM")="0"+temp;
   		}else{
      		gcds_data1.namevalue(i,"BGTMM")=""+temp;
    	}
    
    	for(var j=0; j<tempmon.length;j++){
      		if(tempmon[j]==gcds_data1.namevalue(i,"BGTMM")){
	    		alert(tempmon[j]);
        		alert("�ߺ��� ���� �ֽ��ϴ�.");
        		ln_Query('01');
        		return false;
      		}
    	}

		gcds_data1.namevalue(i,"APPROVAL")="N";
	  //�߰�
		if(fn_trim(gclx_satcode.bindcolval)==""){
			gcds_data1.namevalue(i,"SATCODE")="00"; 
		}
    	temp++;
	}
}

/******************************************************************************************
	Description : ����
******************************************************************************************/
function ln_Save(){
	  if(gcds_data1.IsUpdated) {
	  	 if(ln_Chk()) {

	        if(gcem_bgtnam.text!="") {
	          gcds_depttempS.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s3?v_str1=&v_str2="+gcem_bgtnam.text;
	          gcds_depttempS.Reset();
	        }else if(gcem_bgtdept.text!="") {
	          gcds_depttempS.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s3?v_str1="+gcem_bgtdept.text+"&v_str2=";
	          gcds_depttempS.Reset();
	        }

      		//������ �߰� 20071221
			gcds_depttemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept.text+"&v_str2=";
     		gcds_depttemp.Reset();
			/////////////////////

			var row   = gcds_data1.rowposition;
			var row2  = gcds_bgtdpt.rowposition;
			var row4  = gcds_fsrefcd.rowposition;
			/*************** Primary Key **********************************/
			var str1  = gclx_fdcode.bindcolval;										//����
			var str2  = gcem_bgtyy.text;													//����⵵ 
			var str3  = gcds_data1.namevalue(row,"BGTMM");				//�����
			var str4  = gcds_depttemp.namevalue(1,"GBCD");		//��û����
			var str5  = gcem_bgtdept.text		//��û�μ�
			var str6  = gcem_atcode.text;													//��������
			var str7  = gcds_fsrefcd.namevalue(row4,"CDCODE");		//�����׸��ڵ�
      		var str8 ="";
			if(gclx_satcode.bindcolval==""){
        		str8="00";
			}else{
				str8  = gclx_satcode.bindcolval;										//����
			}
			/*************** Common key **********************************/
			var str9  = "";//gclx_costcd.bindcolval;							//��������
			var str10 = "1";																			//����Ÿ��
			var str11 = "01";																			//����Ÿ��
			var str12 = Number(str2-1);														//���⵵

			gctr_data1.KeyValue = "Account.a080001_t1(I:USER=gcds_data1)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_t1";
			gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3
													+ ",v_str4="+str4+",v_str5="+str5+",v_str6="+str6
													+ ",v_str7="+str7+",v_str8="+str8+",v_str9="+str9
													+ ",v_str10="+str10+",v_str11="+str11+",v_str12="+str12;
			//prompt('',gcds_data1.text);
			gctr_data1.post();
			ln_Query('01');
		}
	}else alert("�����Ͻ� ������ �����ϴ�.");
}

/******************************************************************************
	Description : �ʼ��׸� �Է�üũ 
******************************************************************************/
function ln_Chk() {
	if (fn_trim(gclx_fdcode.bindcolval)=="" ){
		alert("������ �Է��Ͻʽÿ�.");
		gclx_fdcode.focus();
		return false; 
	}

	if (fn_trim(gcem_bgtyy.text)==""){
		alert("�⵵�� �Է��Ͻʽÿ�.");
		gcem_bgtyy.focus();
		return false; 
	}

	if (fn_trim(gcem_bgtdept.text)==""){
		alert("��û�μ��� �Է��Ͻʽÿ�.");
		gcem_bgtdept.focus();
		return false; 
	}

	if (fn_trim(gcem_atcode.text)==""){
		alert("���������� �Է��Ͻʽÿ�.");
		txt_atcodenm.focus();
		return false; 
	}

	if(gcds_satcode.countrow==0){  
	}else{
		if (fn_trim(gclx_satcode.bindcolval)==""){
			alert("������ �Է��Ͻʽÿ�.");
			gclx_satcode.focus();
			return false; 
		}
	}
	return true;
}

/******************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Delete(){

	for(var i=1;i<gcds_data1.countrow;i++){
		if(gcds_data1.namevalue(i,"APPROVAL")=="Y"){
			alert("������ �Ϸ�� ���� ������ �� �����ϴ�.");
			return false;
		}
	}

	if (confirm("���� �Ͻðڽ��ϱ�?")){	
		/*************** Primary Key **********************************/
		var row  = gcds_data1.rowposition;
		var row2 = gcds_bgtdpt.rowposition;
		var row4 = gcds_fsrefcd.rowposition;
		var str1 = gclx_fdcode.bindcolval;									//����
		var str2 = gcem_bgtyy.text;													//����⵵
		var str3 = gcds_data1.namevalue(row,"BGTMM");				//�����
		var str4 = gcds_bgtdpt.namevalue(row2,"BGTDIVCD");	//��û����
		var str5 = gcds_bgtdpt.namevalue(row2,"BGTDEPT");		//��û�μ�
		var str6 = gcem_atcode.text;												//��������
		var str7 = gcds_fsrefcd.namevalue(row4,"CDCODE");		//�����׸��ڵ�
		var str8 = gclx_satcode.bindcolval;									//����
		/*************** Common key **********************************/
		gcds_data1.DeleteAll();
		gctr_data1.KeyValue   = "Account.a080001_t1(I:USER=gcds_data1)";
		gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_t1";
		gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3
													+ ",v_str4="+str4+",v_str5="+str5+",v_str6="+str6
													+ ",v_str7="+str7+",v_str8="+str8;
		gctr_data1.post();
		ln_Query('01');
	}
}

/******************************************************************************
	Description : �ϰ�
******************************************************************************/
function ln_Batch(p){
	if((gcds_data1.namevalue(1,"INITBGT")==""||gcds_data1.namevalue(1,"INITBGT")==0)&&(gcds_data1.namevalue(1,"REMARK")=="")){
		alert("�ϰ������� �ݾ� �Ǵ� ����ٰŰ� �����ϴ�.");
	}else{
    if(fn_trim(gclx_satcode.bindcolval)==""){
			gcds_data1.namevalue(1,"SATCODE")="00"; 
		}
		for(i=2;i<=12;i++){
			gcds_data1.namevalue(i,"INITBGT")=gcds_data1.namevalue(1,"INITBGT");
			gcds_data1.namevalue(i,"REMARK")=gcds_data1.namevalue(1,"REMARK");
			if(fn_trim(gclx_satcode.bindcolval)==""){
				gcds_data1.namevalue(i,"SATCODE")="00"; 
			}
		}
	}
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
	if(gcds_data5.countrow<1) {
		alert("����� ������ �����ϴ�.");
	}else{
		gcds_print.clearall();
		ln_SetDataHeader();
		gcds_print.ImportData(gcds_data5.ExportData(1,gcds_data5.countrow,false));
		if (gcds_print.countrow>0) {
			for(i=1;i<=gcds_print.countrow;i++){
				gcds_print.namevalue(i,"HTITLE") = gs_date;
				gcds_print.namevalue(i,"CURDT")  = gs_date;
				gcds_print.namevalue(i,"REQDT")  = gs_date;
				gcds_print.namevalue(i,"DEPTNM") = gcem_bgtdept1.text;
			}
		}
		gcrp_print.preview();
	}
}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "ATCODE:STRING,ATKORNAM:STRING,SATNM:STRING,"
				 + "BGTMM01:DECIMAL,CHGMM01:DECIMAL,BGTMM02:DECIMAL,CHGMM02:DECIMAL,"
				 + "BGTMM03:DECIMAL,CHGMM03:DECIMAL,BGTMM04:DECIMAL,CHGMM04:DECIMAL,"
				 + "BGTMM05:DECIMAL,CHGMM05:DECIMAL,BGTMM06:DECIMAL,CHGMM06:DECIMAL,"
				 + "BGTMM07:DECIMAL,CHGMM07:DECIMAL,BGTMM08:DECIMAL,CHGMM08:DECIMAL,"
				 + "BGTMM09:DECIMAL,CHGMM09:DECIMAL,BGTMM10:DECIMAL,CHGMM10:DECIMAL,"
				 + "BGTMM11:DECIMAL,CHGMM11:DECIMAL,BGTMM12:DECIMAL,CHGMM12:DECIMAL,"
				 + "BGTSUM:DECIMAL,CHGSUM:DECIMAL,"
				 + "HTITLE:STRING,CURDT:STRING,REQDT:STRING,DEPTNM:STRING";
	gcds_print.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('�����û');
	}else {
		if (gcds_data5.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp05.RunExcel('�����û��Ȳ');
	}
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_bgtyy.text = gs_date2;
	gclx_satcode.enable = false;
	gcem_bgtyy55.text= gs_date2;
	
	//alert("gs_deptcd::"+gs_deptcd);
	if(gs_deptcd==null){	//ȸ�谳����
		gs_deptcd = "C000";
	}

	if(gs_deptcd!="C000"){//����ںμ�
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str3="+gs_deptcd+"&v_str4=Y";
		//prompt('gcds_deptemp.DataID',gcds_deptemp.DataID);
		gcds_deptemp.Reset();
	}else{
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str3="+gs_deptcd+"&v_str4=N";
		//prompt('gcds_deptemp.DataID',gcds_deptemp.DataID);
		gcds_deptemp.Reset();
	}

	/*�����û �׸� ��ȸ**************************************************/

	//����[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	if(gs_vendcd!="1200"){//��û�μ�-�Ϲݺμ�
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt.Reset();
	}

	//����
	gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode.Reset();

	/*�����û��Ȳ �׸� ��ȸ**********************************************/
	
	//����[�˻�]
	gcds_sfdcode5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode5.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv5.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv5.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt5.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt5.Reset();
	}
}

/******************************************************************************************
	Description : ��ȸ - �����׸� �ڵ� ��ȸ
******************************************************************************************/
function ln_RefQuery(e){
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e+"&v_str2=B";
	gcds_fsrefcd.Reset();
}

/******************************************************************************************
	Description : ��ȸ - �����ڵ� ��ȸ
******************************************************************************************/
function ln_SatQuery(e){
	if(e!="0003"){
		gclx_satcode.enable = true;
		gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+e;
		gcds_satcode.Reset();
	}else{
		gclx_satcode.enable = false;
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="00";
		gcds_satcode.NameValue(1,"CDNAM")="00";
		gclx_satcode.index = 0;
	}
}

/***********************************************************************************************
	Description : �����ڵ� ã��
	parameter   : p2===> fr, to- �����ڵ� : apr- ���� : up - �������� : down - �����ڵ�
**********************************************************************************************/
function ln_Popup(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	arrParam[1]="B";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_atcode.text = arrParam[0];
		txt_atcodenm.value = arrParam[1];
		ln_RefQuery(arrParam[0]);	//�����׸� ��ȸ
	} else {
		gcem_atcode.text = "";
		txt_atcodenm.value ="";
	}
}

function ln_Popup1(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam.text;
	arrParam[1]=gcem_bgtdept.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam.text = arrParam[1];
		gcem_bgtdept.text = arrParam[0];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}

function ln_Popup2(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam1.text;
	arrParam[1]=gcem_bgtdept1.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam1.text = arrParam[1];
		gcem_bgtdept1.text = arrParam[0];
		gclx_bgtdiv5.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}

 // �����ڵ� �����ؼ� �߰��� �˾� �ڴϽ� ������ 2007-12-18
function ln_Popup3(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam.text;
	arrParam[1]=gcem_bgtdept.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam.text = arrParam[1];
		gcem_bgtdept.text = arrParam[0];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}
/******************************************************************************
	Description : �Ǳ���
	prameter    : 0-�Ϻ��ڵ�, 1-�����׸�
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2"); //��
  var div_cd = new Array("div_dis1","div_dis2");// ��ư
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cd[i]+".style.display='block';");
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cd[i]+".style.display='none';");
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************
	Description : ��ư����
******************************************************************************/
function ln_DispChk3(){
	document.all.btn_sel.style.display='none';
	document.all.div_dbtn.style.display='block';
	document.all.btn_se2.style.display='block';
	document.all.btn_exc.style.display='block';
	document.all.btn_del.style.display='block';
	document.all.btn_add.style.display='block';
	document.all.btn_sav.style.display='block';
	document.all.btn_bat.style.display='block';
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_costcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_satcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdpt5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_deptcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_deptemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_depttemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id=gcds_depttempS classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!-- ����� ��û�μ� �ѹ��� �θ��� ���� ���. -->


<comment id="__NSID__"><object  id=gcds_depttemp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��"; 
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}
</script>

<script language="javascript" for="gcds_data5" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��"; 
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_deptemp" event="onloadCompleted(row,colid)">
	gs_vendcd = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	if(gcds_deptemp.countrow>0){
		gcem_bgtnam.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
		gcem_bgtnam1.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept1.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
	}else {
  }
</script>

<script language="javascript" for="gcds_bgtdpt" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gclx_fsrefcd.index = 0;
	var str1 = gcds_fsrefcd.namevalue(row,"CDCODE");
	ln_SatQuery(str1);
</script>

<script language="javascript" for="gcds_satcode" event="onloadCompleted(row,colid)">
	if(row<1) {
		gclx_satcode.enable = false;
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="00";
		gcds_satcode.NameValue(1,"CDNAM")="00";
		gclx_satcode.index = 0;
	}else{
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="";
		gcds_satcode.NameValue(1,"CDNAM")="";
		gclx_satcode.index = 0;
		gclx_satcode.enable = true;
	}
</script>

<script language="javascript" for="gcds_sfdcode5" event="onloadCompleted(row,colid)">
	gcds_sfdcode5.InsertRow(1);
	gcds_sfdcode5.NameValue(1,"FDCODE")="";
	gcds_sfdcode5.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode5.index=2;
	}else{
		gclx_sfdcode5.bindcolval=gs_fdcode;
	}
</script>


<script language="javascript" for="gcds_bgtdiv5" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	gcds_bgtdiv5.InsertRow(1);
	gcds_bgtdiv5.NameValue(1,"BGTDIVCD")="";
	gcds_bgtdiv5.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv5.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv5.index = 0;
</script>


<script language="javascript" for="gcds_depttemp" event="onloadCompleted(row,colid)">
	if(gcds_depttemp.countrow>0){
    if(gcds_depttemp.countrow == '1'){
      gcem_bgtnam.text = gcds_depttemp.namevalue(1,"CDNAM");
      gcem_bgtdept.text = gcds_depttemp.namevalue(1,"CDCODE");
    }else{
      ln_Popup1();
    }
	}else{
    gcem_bgtnam.text = "";
    gcem_bgtdept.text = "";
  }
</script>
<script language="javascript" for="gcds_depttemp1" event="onloadCompleted(row,colid)">
	if(gcds_depttemp1.countrow>0){
	    if(gcds_depttemp1.countrow == '1'){
	      gcem_bgtnam1.text = gcds_depttemp1.namevalue(1,"CDNAM");
	      gcem_bgtdept1.text = gcds_depttemp1.namevalue(1,"CDCODE");
	      gclx_bgtdiv5.bindcolval = gcds_depttemp1.namevalue(1,"GBCD");
	    }else{
	      ln_Popup2();
	    }
	}else{
    gcem_bgtnam1.text = "";
    gcem_bgtdept1.text = "";
  }
</script>

<script language=JavaScript for=gclx_bgtdpt5 event=OnCloseUp()>
	gclx_bgtdiv5.bindcolval = gcds_bgtdpt5.namevalue(gcds_bgtdpt5.rowposition,"BGTDIVCD");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*�����û���*/
</script>

<script language="javascript" for="gcgd_disp01" event="OnSelChanged(index)">
	if (fn_trim(gcds_data1.namevalue(gcds_data1.rowposition,"APPROVAL"))=="Y"){
		alert("����ó���� �Ϸ�Ȱ��� �����Ҽ� �����ϴ�.");
		return false; 
	}
</script>

<script language=JavaScript for=gcem_bgtnam event=OnKillFocus()>
  if(gcem_bgtnam.text!=""){
    gcem_bgtdept.text = "";
    gcds_depttemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam.text;
    gcds_depttemp.Reset();
  }else{
    gcem_bgtdept.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept event=OnKillFocus()>
  if(gcem_bgtdept.text!=""){
    gcem_bgtnam.text="";
    gcds_depttemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept.text+"&v_str2=";
    gcds_depttemp.Reset();
  }else{
    gcem_bgtnam.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtnam1 event=OnKillFocus()>
  if(gcem_bgtnam1.text!=""){
    gcem_bgtdept1.text = "";
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam1.text;
    gcds_depttemp1.Reset();
  }else{
    gcem_bgtdept1.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept1 event=OnKillFocus()>
  if(gcem_bgtdept1.text!=""){
    gcem_bgtnam1.text="";
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept1.text+"&v_str2=";
    gcds_depttemp1.Reset();
  }else{
    gcem_bgtnam1.text="";
  }
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>

	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");


</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a080001_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align=right>
      <div id="div_dis1" style="display:none;">
      <table width="240px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
        <tr>
          <td>
            <table id="div_dbtn" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
              <tr>
                <td><nobr>
                  <img id="btn_bat" src="../../Common/img/btn/com_b_total.gif"   style="position:relative;left:-2px;top:0px;cursor:hand;display:none" onclick="ln_Batch('01')">
                </td>
                <td><nobr>
                  <img id="btn_exc" src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;left:0px;top:0px;cursor:hand;display:none" onclick="ln_Excel('01')">
                </td>
                <td>
                  <img id="btn_del" src="../../Common/img/btn/com_b_delete.gif"	 style="position:relative;left:2px;top:0px;cursor:hand;display:none" onClick="ln_Delete()">
                </td>
                <td>
                  <img id="btn_add" src="../../Common/img/btn/com_b_insert.gif"	 style="position:relative;left:4px;top:0px;cursor:hand;display:none" onClick="ln_Add()">
                </td>
                <td>
                  <img id="btn_sav" src="../../Common/img/btn/com_b_save.gif"		 style="position:relative;left:6px;top:0px;cursor:hand;display:none" onClick="ln_Save()">
                </td>
                <td>
                  <img id="btn_se2" src="../../Common/img/btn/com_b_query.gif"	 style="position:relative;left:8px;top:0px;cursor:hand;display:none" onclick="ln_Query('01')"></nobr>
                </td>
              </tr>
            </table>
            <img id="btn_sel" src="../../Common/img/btn/com_b_query.gif"		style="position:relative;left:200px;top:0px;cursor:hand;display:block" onclick="ln_Query('01')">
          </td>
        </tr>
      </table>
      </div>
      <div id="div_dis2"  style="display:none;">
      <table><tr>
				<td align=right>
					<img src="../../Common/img/btn/com_b_print.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Print()">
					<img src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Excel('02')">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('02')">
				</td>
      </tr></table>
      </div>
		</td>
  </tr>
	<tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						  <PARAM NAME="BackColor"					VALUE="#cccccc">
   					  	  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=�����û</T>									
							  	<T>divid=div_2		title=�����û��Ȳ</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- �����û ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:480px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:100px;height:110px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^100">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:40px;" bgcolor="#eeeeee">��&nbsp;&nbsp;��</td>
				<td class="tab21" width="50px">
					<comment id="__NSID__"><object  id=gcem_bgtyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:35px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:60px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="300px" colspan=3>
          <comment id="__NSID__"><object  id=gcem_bgtnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup1()">
					<comment id="__NSID__"><object  id=gcem_bgtdept classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="####">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
        </td>

			</tr>
			
			<tr> 				
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab23" width="250px" colspan="3"><nobr>
					<input id=txt_atcodenm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:120px;">
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup()">
					<comment id="__NSID__"><object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script> </nobr>
				</td>
				<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">��&nbsp;&nbsp;��</td>
				<td width="180px" >
					<comment id="__NSID__"><object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:10px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd"><!-- �����׸� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				value="false">
						<param name=ListExprFormat	    value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
					<comment id="__NSID__"><object  id=gclx_satcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:150px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode"><!-- ������ -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				value="true">
						<param name=ListExprFormat	    value="CDNAM^0^160">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>

				<!-- <td class="tab12" style="height:30px;width:50px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab23" width="250px">
          <comment id="__NSID__"><object  id=gcem_wonganm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:150px">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup1()">
					<comment id="__NSID__"><object  id=gcem_wongacd1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="####">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script> -->
        </td>


			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:3px;width:864px;height:379px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="true">
						<param name="ViewSummary" value="1">
						<PARAM NAME="Format"			VALUE="  
						<F> Name='��'				ID=BGTMM			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		BgColor='#f5f5f5' align=center SumBgColor=#C3D0DB SumText=''   Edit=none</F> 
						<F> Name='���⿹��'	ID=BINITBGT2	HeadAlign=Center HeadBgColor=#B9D4DC Width=170	BgColor='#f5f5f5' align=right	 SumBgColor=#C3D0DB SumText=@sum Edit=none</F> 
						<F> Name='�������'	ID=BRESULTS2 	HeadAlign=Center HeadBgColor=#B9D4DC Width=170	BgColor='#f5f5f5' align=right	 SumBgColor=#C3D0DB SumText=@sum Edit=none</F> 
						<C> Name='��û��'		ID=INITBGT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=right	 SumBgColor=#C3D0DB SumText=@sum  BgColor=#ffffcc </C> 
						<C> Name='������'		ID=BASICBGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=right  SumBgColor=#C3D0DB SumText=@sum	Edit=none</C> 
						<C> Name='���α���'	ID=APPROVAL		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center SumBgColor=#C3D0DB SumText=''		Edit=none EditStyle=Combo Data='Y:���οϷ�,N:���δ��,R:���ο�û,B:�ݼ�'</C> 
						<C> Name='����ٰ�'	ID=REMARK			HeadAlign=Center HeadBgColor=#B9D4DC Width=190	align=left	 SumBgColor=#C3D0DB SumText=''    BgColor=#ffffcc show=false</C> 
						">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <F> Name='��������'	ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=160	BgColor='#f5f5f5' align=left Edit=None SumText='�հ�' SumBgColor='#C3D0DB' Edit=none</F> 
						<F> Name='����'			ID=SATNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=130	BgColor='#f5f5f5' align=left Edit=None SumText='' SumBgColor='#C3D0DB' Edit=none</F> -->
					<fieldset style="position:relative;left:3px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset><!-- mask={decode(ACTDAT,'�����̿�','XXXX','XXXX/XX/XX')} -->
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-- �����û��Ȳ ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:480px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none;position:relative;left:0px">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:60px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:90px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:80px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode5">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^80">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="50px">
					<comment id="__NSID__"><object  id=gcem_bgtyy55 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:35px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:60px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="110px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv5">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
            <param name=Enable          value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDIVCD">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			
			<tr> 	
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab23" width="200px">
          <comment id="__NSID__"><object  id=gcem_bgtnam1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup2()">
					<comment id="__NSID__"><object  id=gcem_bgtdept1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="####">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
        </td>


					<td class="tab12" style="height:25px;width:70px;" bgcolor="#eeeeee">&nbsp;�����ڵ�</td>
				<td class="tab23" width="250px" colspan=3>
          <comment id="__NSID__"><object  id=gcem_wonganm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:150px">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup1()">
					<comment id="__NSID__"><object  id=gcem_wongacd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="####">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
        </td>

			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object id=gcgd_disp05 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:379px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data5">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="true">
						<param name="ColSizing"		value="true">
						<PARAM NAME="ViewSummary"	VALUE="1">
						<PARAM NAME="Format"			VALUE="  
						<F> Name='��������'	ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=158	BgColor='#f5f5f5' align=left Edit=None SumText='�հ�' SumBgColor='#C3D0DB' Edit=none</F> 
						<F> Name='����'			ID=SATNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=158	BgColor='#f5f5f5' align=left Edit=None SumText='' SumBgColor='#C3D0DB' Edit=none</F> 
						
						<G> Name='1��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='2��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM02 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM02 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='3��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM03 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM03 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='4��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM04 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM04 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='5��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM05 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM05 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='6��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM06 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM06 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='7��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM07 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM07 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='8��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM08 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM08 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='9��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM09 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM09 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='10��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM10 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM10 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='11��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM11 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM11 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='12��'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTMM12 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGMM12 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>

						<G> Name='��'				ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='��û��'	ID=BGTSUM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='������'	ID=CHGSUM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 


		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data2>
	<param name=BindInfo  value='
		<C>Col=FDCODE				Ctrl=gclx_fdcode				Param=bindcolval</C>
		<C>Col=BGTYY				Ctrl=gcem_bgtyy					Param=text</C>
		<C>Col=BGTDPT				Ctrl=gclx_bgtdpt				Param=bindcolval</C>
		<C>Col=ATCODE				Ctrl=gcem_atcode				Param=text</C>
		<C>Col=FSREFCD			Ctrl=gclx_fsrefcd				Param=bindcolval</C>
		<C>Col=SATCODE			Ctrl=gclx_satcode				Param=bindcolval</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!-- <C>Col=BGTGBCD			Ctrl=gclx_costcd				Param=bindcolval</C> -->

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print">
	<param name="DetailDataID"			value="gcds_print">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
		<B>id=Header ,left=0,top=0 ,right=2869 ,bottom=388 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��' ,left=1519 ,top=153 ,right=1588 ,bottom=231 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=378 ,right=2813 ,bottom=378 </L>
	<L> left=1591 ,top=162 ,right=2813 ,bottom=162 </L>
	<T>id='����' ,left=2572 ,top=103 ,right=2809 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=2328 ,top=103 ,right=2563 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ���' ,left=2084 ,top=103 ,right=2319 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1841 ,top=103 ,right=2075 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=1597 ,top=103 ,right=1831 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=97 ,right=2813 ,bottom=97 </L>
	<T>id='��������û�μ�������' ,left=1972 ,top=22 ,right=2416 ,bottom=84 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=200, top=331, right=1006, bottom=384, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� ��:' ,left=41 ,top=331 ,right=197 ,bottom=384 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û����:' ,left=41 ,top=275 ,right=197 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HTITLE', left=41, top=97, right=1009, bottom=175, align='left' ,mask='XXXX�� �μ��� �����û ��Ȳ(1��~12��)', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=41 ,top=178 ,right=916 ,bottom=178 </L>
	<L> left=41 ,top=184 ,right=916 ,bottom=184 </L>
	<T>id='��' ,left=1519 ,top=247 ,right=1588 ,bottom=325 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=97 ,right=1513 ,bottom=378 </L>
	<L> left=2566 ,top=97 ,right=2566 ,bottom=378 </L>
	<L> left=2322 ,top=97 ,right=2322 ,bottom=378 </L>
	<L> left=2078 ,top=97 ,right=2078 ,bottom=378 </L>
	<L> left=1834 ,top=97 ,right=1834 ,bottom=378 </L>
	<L> left=2813 ,top=97 ,right=2813 ,bottom=378 </L>
	<C>id='REQDT', left=200, top=275, right=450, bottom=328, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1591 ,top=97 ,right=1591 ,bottom=378 </L>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=103 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=41 ,top=3 ,right=2813 ,bottom=3 </L>
	<T>id='��������' ,left=47 ,top=9 ,right=391 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=41 ,top=3 ,right=41 ,bottom=100 </L>
	<L> left=394 ,top=3 ,right=394 ,bottom=100 </L>
	<L> left=866 ,top=3 ,right=866 ,bottom=100 </L>
	<L> left=1025 ,top=3 ,right=1025 ,bottom=100 </L>
	<L> left=1184 ,top=3 ,right=1184 ,bottom=100 </L>
	<L> left=1344 ,top=3 ,right=1344 ,bottom=100 </L>
	<L> left=1503 ,top=3 ,right=1503 ,bottom=100 </L>
	<L> left=1663 ,top=3 ,right=1663 ,bottom=100 </L>
	<L> left=1822 ,top=3 ,right=1822 ,bottom=100 </L>
	<L> left=1981 ,top=3 ,right=1981 ,bottom=100 </L>
	<L> left=2300 ,top=3 ,right=2300 ,bottom=100 </L>
	<L> left=2459 ,top=3 ,right=2459 ,bottom=100 </L>
	<L> left=2619 ,top=3 ,right=2619 ,bottom=100 </L>
	<L> left=2141 ,top=3 ,right=2141 ,bottom=100 </L>
	<L> left=2813 ,top=3 ,right=2813 ,bottom=100 </L>
	<L> left=41 ,top=100 ,right=2813 ,bottom=100 </L>
	<T>id='1��' ,left=713 ,top=9 ,right=863 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2625 ,top=9 ,right=2806 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=400 ,top=9 ,right=703 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=706 ,top=3 ,right=706 ,bottom=100 </L>
	<T>id='2��' ,left=872 ,top=9 ,right=1022 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3��' ,left=1031 ,top=9 ,right=1181 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4��' ,left=1191 ,top=9 ,right=1341 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5��' ,left=1350 ,top=9 ,right=1500 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6��' ,left=1509 ,top=9 ,right=1659 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7��' ,left=1669 ,top=9 ,right=1819 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8��' ,left=1828 ,top=9 ,right=1978 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9��' ,left=1988 ,top=9 ,right=2138 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10��' ,left=2147 ,top=9 ,right=2297 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12��' ,left=2466 ,top=9 ,right=2616 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11��' ,left=2306 ,top=9 ,right=2456 ,bottom=97 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=65 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=41 ,top=0 ,right=2813 ,bottom=0 </L>
	<C>id='ATKORNAM', left=47, top=6, right=391, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTSUM', left=2625, top=6, right=2806, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=394 ,top=0 ,right=394 ,bottom=66 </L>
	<L> left=1184 ,top=0 ,right=1184 ,bottom=66 </L>
	<L> left=1025 ,top=0 ,right=1025 ,bottom=66 </L>
	<L> left=866 ,top=0 ,right=866 ,bottom=66 </L>
	<L> left=1663 ,top=0 ,right=1663 ,bottom=66 </L>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 </L>
	<L> left=1344 ,top=0 ,right=1344 ,bottom=66 </L>
	<L> left=2459 ,top=0 ,right=2459 ,bottom=66 </L>
	<L> left=2300 ,top=0 ,right=2300 ,bottom=66 </L>
	<L> left=2141 ,top=0 ,right=2141 ,bottom=66 </L>
	<L> left=1981 ,top=0 ,right=1981 ,bottom=66 </L>
	<L> left=1822 ,top=0 ,right=1822 ,bottom=66 </L>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=66 </L>
	<L> left=2619 ,top=0 ,right=2619 ,bottom=66 </L>
	<L> left=41 ,top=0 ,right=41 ,bottom=66 </L>
	<C>id='SATNM', left=400, top=6, right=703, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=706 ,top=0 ,right=706 ,bottom=66 </L>
	<C>id='BGTMM01', left=713, top=6, right=863, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM02', left=872, top=6, right=1022, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM03', left=1031, top=6, right=1181, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM04', left=1191, top=6, right=1341, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM05', left=1350, top=6, right=1500, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM06', left=1509, top=6, right=1659, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM07', left=1669, top=6, right=1819, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM08', left=1828, top=6, right=1978, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM09', left=1988, top=6, right=2138, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM10', left=2147, top=6, right=2297, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM12', left=2466, top=6, right=2616, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM11', left=2306, top=6, right=2456, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2869 ,bottom=566 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=41 ,top=137 ,right=2813 ,bottom=137 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='���' ,left=1597 ,top=241 ,right=1831 ,bottom=297 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1841 ,top=241 ,right=2075 ,bottom=297 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ���' ,left=2084 ,top=241 ,right=2319 ,bottom=297 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=2328 ,top=241 ,right=2563 ,bottom=297 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2572 ,top=241 ,right=2809 ,bottom=297 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1591 ,top=300 ,right=2813 ,bottom=300 </L>
	<L> left=41 ,top=534 ,right=2813 ,bottom=534 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�� �� ��:' ,left=972 ,top=462 ,right=1128 ,bottom=516 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=1131, top=462, right=1381, bottom=516, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='��' ,left=1519 ,top=384 ,right=1588 ,bottom=462 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1519 ,top=291 ,right=1588 ,bottom=369 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=234 ,right=1513 ,bottom=516 </L>
	<L> left=1513 ,top=234 ,right=2813 ,bottom=234 </L>
	<L> left=1513 ,top=516 ,right=2813 ,bottom=516 </L>
	<L> left=2566 ,top=234 ,right=2566 ,bottom=516 </L>
	<L> left=2322 ,top=234 ,right=2322 ,bottom=516 </L>
	<L> left=2078 ,top=234 ,right=2078 ,bottom=516 </L>
	<L> left=1834 ,top=234 ,right=1834 ,bottom=516 </L>
	<T>id='�ؿ��� �ְ��μ� �ǰ�' ,left=41 ,top=147 ,right=478 ,bottom=209 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������� �ְ��μ�������' ,left=1913 ,top=156 ,right=2450 ,bottom=219 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2813 ,top=234 ,right=2813 ,bottom=516 </L>
	<L> left=41 ,top=0 ,right=41 ,bottom=66 </L>
	<L> left=41 ,top=0 ,right=2813 ,bottom=0 </L>
	<T>id='��           ��' ,left=47 ,top=6 ,right=703 ,bottom=62 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=41 ,top=66 ,right=2813 ,bottom=66 </L>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=66 </L>
	<L> left=1591 ,top=234 ,right=1591 ,bottom=516 </L>
	<L> left=706 ,top=0 ,right=706 ,bottom=66 </L>
	<L> left=866 ,top=0 ,right=866 ,bottom=66 </L>
	<L> left=1025 ,top=0 ,right=1025 ,bottom=66 </L>
	<L> left=1184 ,top=0 ,right=1184 ,bottom=66 </L>
	<L> left=1344 ,top=0 ,right=1344 ,bottom=66 </L>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 </L>
	<L> left=1663 ,top=0 ,right=1663 ,bottom=66 </L>
	<L> left=1822 ,top=0 ,right=1822 ,bottom=66 </L>
	<L> left=1981 ,top=0 ,right=1981 ,bottom=66 </L>
	<L> left=2141 ,top=0 ,right=2141 ,bottom=66 </L>
	<L> left=2300 ,top=0 ,right=2300 ,bottom=66 </L>
	<S>id='Sum(BGTSUM)' ,left=2625 ,top=6 ,right=2806 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=2619 ,top=0 ,right=2619 ,bottom=66 </L>
	<S>id='Sum(BGTMM12)' ,left=2466 ,top=6 ,right=2616 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=2459 ,top=0 ,right=2459 ,bottom=66 </L>
	<S>id='Sum(BGTMM11)' ,left=2306 ,top=6 ,right=2456 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM04)' ,left=1191 ,top=6 ,right=1341 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM05)' ,left=1350 ,top=6 ,right=1500 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM06)' ,left=1509 ,top=6 ,right=1659 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM07)' ,left=1669 ,top=6 ,right=1819 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM08)' ,left=1828 ,top=6 ,right=1978 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM09)' ,left=1988 ,top=6 ,right=2138 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM10)' ,left=2147 ,top=6 ,right=2297 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM03)' ,left=1031 ,top=6 ,right=1181 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM02)' ,left=872 ,top=6 ,right=1022 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='Sum(BGTMM01)' ,left=713 ,top=6 ,right=863 ,bottom=62 ,align='right' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - �����׸� Popup
+ ���α׷� ID	:  MTotalbal_popup.html
+ �� �� �� ��	:  �����׸� �˾�â.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 
------------------------------------------------------------------------------
+ �� �� �� ��  :	�������忡�� ��ǥ�˾����� �Ѿ�� ����.
                  (��ǥ��ȣ�� ������ȣ ȥ���Ͽ� ����� ==> ����)
+ ��   ��  ��  :  ������
+ �� �� �� ��  :  2007.05.17
----------------------------------------------------------------------------->
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�������� Popup</title>

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
var p_fdcod="";		//�����ڵ�
var p_atcod="";		//�����ڵ�
var p_frdat="";		//�˻����� from
var p_todat="";		//�˻����� to
var ref_cd1="";		//�����׸�1 �ڵ�
var ref_va1="";		//�����׸�1 ��
var ref_cd2="";		//�����׸�2 �ڵ�
var ref_va2="";		//�����׸�2 ��
var ref_cd3="";		//�����׸�3 �ڵ�
var ref_va3="";		//�����׸�3 ��
var ref_cnt="";		//�����׸� CNT
var chk_prt="";		//��±���
//get_cookdata();
var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam = window.dialogArguments;

	ln_SetDataHeader();
	
	p_fdcod = strParam[0];	//�����ڵ�
	p_atcod = strParam[1];	//�����ڵ�
	p_frdat = strParam[2];	//���� from
	p_todat = strParam[3];	//���� to
	ref_cd1 = strParam[4];	//�����׸�1 �ڵ�
	ref_va1 = strParam[5];	//�����׸�1 ��
	ref_cd2 = strParam[6];	//�����׸�2 �ڵ�
	ref_va2 = strParam[7];	//�����׸�2 ��
	ref_cd3 = strParam[8];	//�����׸�3 �ڵ�
	ref_va3 = strParam[9];	//�����׸�3 ��
	ref_chk = strParam[10];	//�ܾ���[A],����[B] ����
	ref_cnt = strParam[11]; //�����׸� CNT	
	
	ln_Before(ref_cnt);
	
	if (ref_chk == "A") {
		gclx_fsrefcd1.Enable = true;
		gclx_fsrefva1.Enable = true;
		gclx_fsrefcd2.Enable = false;
		gclx_fsrefva2.Enable = false;
		gclx_fsrefcd3.Enable = false;
		gclx_fsrefva3.Enable = false;
		gclx_fsrefcd1.BindColVal = ref_cd1;	//�����׸�1
		ref_cnt = '1';
	}else if (ref_chk == "B") {
		gclx_fsrefcd2.Enable = false;	
		gclx_fsrefva2.Enable = false;
		gclx_fsrefcd3.Enable = false;
		gclx_fsrefva3.Enable = false;
		if(ref_cnt=="1") {
			gclx_fsrefcd1.Enable = true;
			gclx_fsrefva1.Enable = true;
			gclx_fsrefcd1.BindColVal = ref_cd1;	//�����׸�1
		}else if(ref_cnt=="2") {
			gclx_fsrefcd1.Enable = true;
			gclx_fsrefva1.Enable = true;
			gclx_fsrefcd2.Enable = true;
			gclx_fsrefva2.Enable = true;
			gclx_fsrefcd1.BindColVal = ref_cd1;	//�����׸�1	
			gclx_fsrefcd2.BindColVal = ref_cd2;	//�����׸�2
		}else if(ref_cnt=="3") {
			gclx_fsrefcd1.Enable = true;
			gclx_fsrefva1.Enable = true;
			gclx_fsrefcd2.Enable = true;
			gclx_fsrefva2.Enable = true;
			gclx_fsrefcd3.Enable = true;
			gclx_fsrefva3.Enable = true;
			gclx_fsrefcd1.BindColVal = ref_cd1;	//�����׸�1
			gclx_fsrefcd2.BindColVal = ref_cd2;	//�����׸�2
			gclx_fsrefcd3.BindColVal = ref_cd3;	//�����׸�3	
		}
	}

	ln_RefValQuery(ref_cnt);

	gclx_sfdcode.BindColVal = p_fdcod;	//�����ڵ�
	gcem_staxdatfr.text = p_frdat;			//�Ⱓfr
	gcem_staxdatto.text = p_todat;			//�Ⱓto

	ln_CurActcode(p_atcod);
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){
  
	var str1  = gclx_sfdcode.BindColVal;	
	var str2  = gcem_staxdatfr.text;			
	var str3  = gcem_staxdatto.text;
	var str4  = gcem_curatcode_fr01.text;
	var str5  = str2.substring(0,4);
	var str6  = "";												//�����̿�
	var str7  = gclx_fsrefcd1.bindcolval;	//�����׸�1 �ڵ�
	var str8  = gclx_fsrefva1.bindcolval;	//�����׸�1 ��
	var str9  = gclx_fsrefcd2.bindcolval;	//�����׸�2 �ڵ�
	var str10 = gclx_fsrefva2.bindcolval;	//�����׸�2 ��
	var str11 = gclx_fsrefcd3.bindcolval;	//�����׸�3 �ڵ�
	var str12 = gclx_fsrefva3.bindcolval;	//�����׸�3 ��
	var str13 = "";												//�����׸� CNT

	if(str7!='' && str9=='' && str11==''){
		str13 = '1';
	}else if(str7!='' && str9!='' && str11=='') {
		str13 = '2';
	}else if(str7!='' && str9!='' && str11!='') {
		str13 = '3';
	}

	if (str2.substring(6,8) =="01") {
		str6 = Number(str2.substring(0,6)-1)+"31";
	}else{
		str6 = Number(str2-1);
	}

	if(str2 != "" && str3 != "" && str4 != "") {
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												  + "&v_str2="+str2
																												 + "&v_str3="+str3
																												 + "&v_str4="+str4
																												 + "&v_str5="+str5
																												 + "&v_str6="+str6
																												 + "&v_str7="+str7
																												 + "&v_str8="+str8
																												 + "&v_str9="+str9
																												 + "&v_str10="+str10
																												 + "&v_str11="+str11
																												 + "&v_str12="+str12
																												 + "&v_str13="+str13;
		gcds_data1.Reset();
	}else{
		alert("�����ڵ带 �����Ͻʽÿ�.");
	}
}

/******************************************************************************************
	Description : ��ȸ - ������ȸ
******************************************************************************************/
function ln_Query2(){
  
	var str1  = gclx_sfdcode.BindColVal;	
	var str2  = gcem_staxdatfr.text;			
	var str3  = gcem_staxdatto.text;
	var str4  = gcem_curatcode_fr01.text;
	var str5  = str2.substring(0,4);
	var str6  = "";												//�����̿�
	var str7  = gclx_fsrefcd1.bindcolval;	//�����׸�1 �ڵ�
	var str8  = ref_va1;									//�����׸�1 ��
	var str9  = gclx_fsrefcd2.bindcolval;	//�����׸�2 �ڵ�
	var str10 = ref_va2;									//�����׸�2 ��
	var str11 = gclx_fsrefcd3.bindcolval;	//�����׸�3 �ڵ�
	var str12 = ref_va3;									//�����׸�3 ��
	var str13 = ref_cnt;									//�����׸� CNT

	if (str2.substring(6,8) =="01") {
		str6 = Number(str2.substring(0,6)-1)+"31";
	}else{ str6 = Number(str2-1);	}

	if(str2 != "" && str3 != "" && str4 != "") {
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												 + "&v_str2="+str2
																												 + "&v_str3="+str3
																												 + "&v_str4="+str4
																												 + "&v_str5="+str5
																												 + "&v_str6="+str6
																												 + "&v_str7="+str7
																												 + "&v_str8="+str8
																												 + "&v_str9="+str9
																												 + "&v_str10="+str10
																												 + "&v_str11="+str11
																												 + "&v_str12="+str12
																												 + "&v_str13="+str13;
		//prompt('',gcds_data1.DataID)
		gcds_data1.Reset();
	}
}


/******************************************************************************************
	Description : ��ȸ - �����׸� �ڵ� ��ȸ
******************************************************************************************/
function ln_RefQuery(e){
	//�����׸�1[�˻�]
	gcds_fscd01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e;
	gcds_fscd01.Reset();

	//�����׸�2[�˻�]
	gcds_fscd02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e;
	gcds_fscd02.Reset();

	//�����׸�3[�˻�]
	gcds_fscd03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e;
	gcds_fscd03.Reset();
}

/******************************************************************************************
	Description : ��ȸ - �����׸� �� ��ȸ
	Parameter   : scnt:�׸񰹼�
******************************************************************************************/
function ln_RefValQuery(scnt){
	if(scnt>=1) {	//�����׸�1 ��[�˻�]
		gcds_fsva01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd1.bindcolval;
		gcds_fsva01.Reset();

		gclx_fsrefva1.bindcolval = ref_va1;	//�����׸�1��
	}

	if(scnt>=2) {	//�����׸�2 ��[�˻�]
		gcds_fsva02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd2.bindcolval;
		gcds_fsva02.Reset();
		
		gclx_fsrefva1.bindcolval = ref_va1;	//�����׸�1��
		gclx_fsrefva2.bindcolval = ref_va2;	//�����׸�1��
	}

	if(scnt>=3) {	//�����׸�3 ��[�˻�]
		gcds_fsva03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd3.bindcolval;
		gcds_fsva03.Reset();
		
		gclx_fsrefva1.bindcolval = ref_va1;	//�����׸�1��
		gclx_fsrefva2.bindcolval = ref_va2;	//�����׸�2��
		gclx_fsrefva3.bindcolval = ref_va3;	//�����׸�3��
	}
}

/******************************************************************************
	Description : Enable 
******************************************************************************/
function ln_Enable(e){
	gclx_fsrefcd1.enable = true;
	gclx_fsrefva1.enable = true;
	gclx_fsrefcd2.enable = false;
	gclx_fsrefva2.enable = false;
	gclx_fsrefcd3.enable = false;
	gclx_fsrefva3.enable = false;
	
	if(e=='1'){
		gclx_fsrefcd1.enable = true;
		gclx_fsrefva1.enable = true;
		
		gclx_fsrefva2.bindcolval = "";
		gclx_fsrefva3.bindcolval = "";
	}else if(e=='2') {
		gclx_fsrefcd1.enable = true;
		gclx_fsrefva1.enable = true;
		gclx_fsrefcd2.enable = true;
		gclx_fsrefva2.enable = true;
		
		gclx_fsrefva3.bindcolval = "";
	}else if(e>=3) {
		gclx_fsrefcd1.enable = true;
		gclx_fsrefva1.enable = true;
		gclx_fsrefcd2.enable = true;
		gclx_fsrefva2.enable = true;
		gclx_fsrefcd3.enable = true;
		gclx_fsrefva3.enable = true;
	}
}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : ����
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************************
	Description : ��ȸ - ���
******************************************************************************************/
function ln_BefoPrtQuery(){
	gcds_print.ClearData();
	for (var i=1;i<=gcds_temp.countrow;i++) {
		var str1  = gclx_sfdcode.BindColVal;	
		var str2  = gcem_staxdatfr.text;			
		var str3  = gcem_staxdatto.text;
		var str4  = gcds_temp.namevalue(i,"ATCODE");
		var str5  = str2.substring(0,4);
		var str6  = "";												//�����̿�
		var str7  = gclx_fsrefcd1.bindcolval;	//�����׸�1 �ڵ�
		var str8  = ref_va1;									//�����׸�1 ��
		var str9  = gclx_fsrefcd2.bindcolval;	//�����׸�2 �ڵ�
		var str10 = ref_va2;									//�����׸�2 ��
		var str11 = gclx_fsrefcd3.bindcolval;	//�����׸�3 �ڵ�
		var str12 = ref_va3;									//�����׸�3 ��
		var str13 = ref_cnt;									//�����׸� CNT

		if (str2.substring(6,8) =="01") {	
			str6 = Number(str2.substring(0,6)-1)+"31";
		}else{ str6 = Number(str2-1);	}
			
		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												 + "&v_str2=" +str2+ "&v_str3="+str3
																												 + "&v_str4=" +str4+ "&v_str5="+str5
																												 + "&v_str6=" +str6+ "&v_str7="+str7
																												 + "&v_str8=" +str8+ "&v_str9="+str9
																												 + "&v_str10="+str10+"&v_str11="+str11
																												 + "&v_str12="+str12+"&v_str13="+str13;
			gcds_data2.Reset();
		}
	}
	//chk_prt = "1";
}

/******************************************************************************************
	Description : ��ȸ - ���
******************************************************************************************/
function ln_PrtQuery(){
	gcds_print.ClearData();
	for (var i=1;i<=gcds_temp.countrow;i++) {
		var str1  = gclx_sfdcode.BindColVal;	
		var str2  = gcem_staxdatfr.text;			
		var str3  = gcem_staxdatto.text;
		var str4  = gcds_temp.namevalue(i,"ATCODE");
		var str5  = str2.substring(0,4);
		var str6  = "";												//�����̿�
		var str7  = gclx_fsrefcd1.bindcolval;	//�����׸�1 �ڵ�
		var str8  = gclx_fsrefva1.bindcolval;	//�����׸�1 ��
		var str9  = gclx_fsrefcd2.bindcolval;	//�����׸�2 �ڵ�
		var str10 = gclx_fsrefva2.bindcolval;	//�����׸�2 ��
		var str11 = gclx_fsrefcd3.bindcolval;	//�����׸�3 �ڵ�
		var str12 = gclx_fsrefva3.bindcolval;	//�����׸�3 ��
		var str13 = "";												//�����׸� CNT

		if(str7!='' && str9=='' && str11==''){
			str13 = '1';
		}else if(str7!='' && str9!='' && str11=='') {
			str13 = '2';
		}else if(str7!='' && str9!='' && str11!='') {
			str13 = '3';
		}

		if (str2.substring(6,8) =="01") {	str6 = Number(str2.substring(0,6)-1)+"31";
		}else{ str6 = Number(str2-1);	}
			
		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												 + "&v_str2=" +str2+ "&v_str3="+str3
																												 + "&v_str4=" +str4+ "&v_str5="+str5
																												 + "&v_str6=" +str6+ "&v_str7="+str7
																												 + "&v_str8=" +str8+ "&v_str9="+str9
																												 + "&v_str10="+str10+"&v_str11="+str11
																												 + "&v_str12="+str12+"&v_str13="+str13;
			gcds_data2.Reset();
		}
	}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){
	if(chk_prt=="1") {
		ln_PrtQuery();			//���
	}else{
		ln_BefoPrtQuery()		//�����
	}

	if(gcds_print.countrow<1) {
		alert("����� ������ �����ϴ�.");
	}else{
		gcds_print.namevalue(1,"ATKORNAM") = txt_curatkornam_to01.value;
		gcds_print.namevalue(1,"FDCODENM") = gclx_sfdcode.text;
		gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr.text + gcem_staxdatto.text;
		gcds_print.namevalue(1,"CURDT2")	 = gs_date;
		gcrp_print.preview(); 
	}
}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "ATDECR:STRING,ATCODE:STRING,ATKORNAM:STRING,ACTDAT:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVLA:DECIMAL,"
						 + "REMARK:STRING,VENDER:STRING,LEVELS:STRING,FDCODE:STRING,"
						 + "FSDAT:STRING,FSNBR:STRING,FSNBRDT:STRING,FDCODENM:STRING,"
						 + "CURDT:STRING,CURDT2:STRING;SSDAT:STRING,SSNBR:STRING";
	gcds_print.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("��������","",2);
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(e){
	//�����ڵ�[�˻�]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	//�����׸�1[�˻�]
	if(ref_cnt=="1" || ref_cnt=="2" || ref_cnt=="3") {
		gcds_fscd01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+p_atcod;
		gcds_fscd01.Reset();
	}

	//�����׸�2[�˻�]
	if(ref_cnt=="2" || ref_cnt=="3") {
		gcds_fscd02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+p_atcod;
		gcds_fscd02.Reset();
	}

	//�����׸�3[�˻�]
	if(ref_cnt=="3") {
		gcds_fscd03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+p_atcod;
		gcds_fscd03.Reset();
	}
}

/***********************************************************************************************
	Description : �����ڵ� ã��
	parameter   : p2===> fr, to- �����ڵ� : apr- ���� : up - �������� : down - �����ڵ�
**********************************************************************************************/
function ln_Popup(p2,p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrParam[0];
					txt_atkornam_fr01.value = arrParam[1];

					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					ln_CurActcode('1');				//������� ��ȸ
					ln_RefQuery(arrParam[0]);	//�����׸� ��ȸ
					ln_Enable(Number(gcds_fscd01.countrow-1));
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					ln_CurActcode('1');				//������� ��ȸ
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				txt_atkornam_fr01.value ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
			}
		}
	}
}

/******************************************************************************
	Description : ������� ��ȸ
******************************************************************************/
function ln_CurActcode(e){
	if(e=="1"){
		var str1 = gcem_atcode_fr01.text;	
		var str2 = gcem_atcode_to01.text;	
	}else{
		var str1 = p_atcod;	
		var str2 = p_atcod;	
	}
	gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s0?v_str1="+str1+"&v_str2="+str2;
	gcds_temp.Reset();
}

/***********************************************************************************************
	Description : ��ǥ ã��
	parameter   : fcod - �����ڵ�, fsdt - ��ǥ����, fnbr - ��ǥ��ȣ
**********************************************************************************************/
function ln_Popup2(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = fsdt;
	arrParam[2] = fnbr;

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:580px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Cumulative(){
	var row1 = gcds_data1.rowposition;
	var row  = gcds_data1.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*�ܾװ��*/
		if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//����:����
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;  //����:����
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}

		/*����-����*/			
		if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_data1.namevalue(i,"ACTDAT") = "�����̿�";
		}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*����*/
			if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_data1.namevalue(i,"ACTDAT") = "����";

			/*����*/
			}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_data1.namevalue(i,"ACTDAT") = "����";
				l_33 = l_33+gcds_data1.namevalue(i,"DETOT");	//��
				r_33 = r_33+gcds_data1.namevalue(i,"CRTOT");	//��
				gcds_data1.namevalue(i,"DETOT") = l_33;
				gcds_data1.namevalue(i,"CRTOT") = r_33;
				if(gcds_data1.namevalue(i,"ATDECR") == "1") {
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//�����ܾ�
				}else{
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//�����ܾ�
				}
				if(gcds_data1.namevalue(1,"ACTDAT") == "�����̿�") {
					gcds_data1.namevalue(i,"DETOT") = gcds_data1.namevalue(1,"DETOT")+gcds_data1.namevalue(i,"DETOT");
					gcds_data1.namevalue(i,"CRTOT") = gcds_data1.namevalue(1,"CRTOT")+gcds_data1.namevalue(i,"CRTOT");
					if(gcds_data1.namevalue(i,"ATDECR") == "1") {
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//�����ܾ�
					}else{
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//�����ܾ�
					}
				}
			}
		}
	}

	/*�����̿�*/	
	if (gcds_data1.namevalue(1,"ACTDAT") != "�����̿�") {	//�����̿� 0�϶�
		gcds_data1.InsertRow(1);
		gcds_data1.namevalue(1,"ACTDAT") = "�����̿�";
		gcds_data1.namevalue(1,"ATCODE") = gcds_data1.namevalue(2,"ATCODE");
		gcds_data1.namevalue(1,"DETOT")  = 0;
		gcds_data1.namevalue(1,"CRTOT")  = 0;
		gcds_data1.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Cumulative2(){
	var row1 = gcds_print.rowposition;
	var row  = gcds_print.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*�ܾװ��*/
		if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//����:����
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;  //����:����
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}

		/*����-����*/			
		if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_print.namevalue(i,"ACTDAT") = "�����̿�";
		}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*����*/
			if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_print.namevalue(i,"ACTDAT") = "����";

			/*����*/
			}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_print.namevalue(i,"ACTDAT") = "����";
				l_33 = l_33+gcds_print.namevalue(i,"DETOT");	//��
				r_33 = r_33+gcds_print.namevalue(i,"CRTOT");	//��
				gcds_print.namevalue(i,"DETOT") = l_33;
				gcds_print.namevalue(i,"CRTOT") = r_33;
				if(gcds_print.namevalue(i,"ATDECR") == "1") {
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//�����ܾ�
				}else{
					gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//�����ܾ�
				}
				if(gcds_print.namevalue(1,"ACTDAT") == "�����̿�") {
					gcds_print.namevalue(i,"DETOT") = gcds_print.namevalue(1,"DETOT")+gcds_print.namevalue(i,"DETOT");
					gcds_print.namevalue(i,"CRTOT") = gcds_print.namevalue(1,"CRTOT")+gcds_print.namevalue(i,"CRTOT");
					if(gcds_print.namevalue(i,"ATDECR") == "1") {
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//�����ܾ�
					}else{
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//�����ܾ�
					}
				}
			}
		}
	}

	/*�����̿�*/	
	if (gcds_print.namevalue(1,"ACTDAT") != "�����̿�") {	//�����̿� 0�϶�
		gcds_print.InsertRow(1);
		gcds_print.namevalue(1,"ACTDAT") = "�����̿�";
		gcds_print.namevalue(1,"ATCODE") = gcds_print.namevalue(2,"ATCODE");
		gcds_print.namevalue(1,"DETOT")  = 0;
		gcds_print.namevalue(1,"CRTOT")  = 0;
		gcds_print.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_data1.rowposition;
		window.returnValue = gcds_data1.namevalue(row,"ATCODE")  + ";" 
	                   	 + gcds_data1.namevalue(row,"ATKORNAM")+ ";" 
											 + gcds_data1.namevalue(row,"ATDECR")  + ";"
											 + gcds_data1.namevalue(row,"ATUPCODE");
		window.close();
	} else {
		window.close();
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<!-- <PARAM NAME="SubsumExpr"	VALUE="1:LEVELS,2:ACTDAT"> -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fscd01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fscd02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fscd03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsva01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsva02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsva03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a030022_t1(I:USER=gcds_data1)"> 
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
	}else{
		ln_Cumulative();	//����
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row>0) { 
		if (gcds_print.countrow<1) {
			for(i=1;i<=gcds_data2.countrow;i++){
				gcds_print.ImportData(gcds_data2.ExportData(i,1,false));
				gcds_print.namevalue(i,"FSNBRDT")  = gcds_data2.namevalue(i,"SSDAT")+gcds_data2.namevalue(i,"SSNBR");
			}
			ln_Cumulative2();	//����
		}else{
			gcds_print.ImportData(gcds_data2.ExportData(1,gcds_data2.CountRow,false));
			ln_Cumulative2();	//����
		}
	}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gclx_sfdcode.BindColVal = p_fdcod;
</script>

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	ln_Query2();
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="��ü";
	gclx_sfdcode.index=0;
</script>

<script language="javascript" for="gcds_fscd01" event="onloadCompleted(row,colid)">
	gcds_fscd01.InsertRow(1);
	gcds_fscd01.NameValue(1,"CDCODE")="";
	gcds_fscd01.NameValue(1,"CDNAM") ="";
	gclx_fsrefcd1.index=0;
</script>

<script language="javascript" for="gcds_fscd02" event="onloadCompleted(row,colid)">
	gcds_fscd02.InsertRow(1);
	gcds_fscd02.NameValue(1,"CDCODE")="";
	gcds_fscd02.NameValue(1,"CDNAM") ="";
	gclx_fsrefcd2.index=0;
</script>

<script language="javascript" for="gcds_fscd03" event="onloadCompleted(row,colid)">
	gcds_fscd03.InsertRow(1);
	gcds_fscd03.NameValue(1,"CDCODE")="";
	gcds_fscd03.NameValue(1,"CDNAM") ="";
	gclx_fsrefcd3.index=0;
</script>

<script language="javascript" for="gcds_fsva01" event="onloadCompleted(row,colid)">
	gcds_fsva01.InsertRow(1);
	gcds_fsva01.NameValue(1,"CDCODE")="";
	gcds_fsva01.NameValue(1,"CDNAM") ="";
	gclx_fsrefva1.index=0;
</script>

<script language="javascript" for="gcds_fsva02" event="onloadCompleted(row,colid)">
	gcds_fsva02.InsertRow(1);
	gcds_fsva02.NameValue(1,"CDCODE")="";
	gcds_fsva02.NameValue(1,"CDNAM") ="";
	gclx_fsrefva2.index=0;
</script>

<script language="javascript" for="gcds_fsva03" event="onloadCompleted(row,colid)">
	gcds_fsva03.InsertRow(1);
	gcds_fsva03.NameValue(1,"CDCODE")="";
	gcds_fsva03.NameValue(1,"CDNAM") ="";
	gclx_fsrefva3.index=0;
</script>

<script language=JavaScript for="gclx_fsrefcd1" event=OnCloseUp()>
	if (gclx_fsrefcd1.bindcolval!=""){
	gcds_fsva01.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd1.bindcolval;
	gcds_fsva01.Reset();
	}
</script>

<script language=JavaScript for="gclx_fsrefcd2" event=OnCloseUp()>
	if (gclx_fsrefcd2.bindcolval!=""){
	gcds_fsva02.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd2.bindcolval;
	gcds_fsva02.Reset();
	}
</script>

<script language=JavaScript for="gclx_fsrefcd3" event=OnCloseUp()>
	if (gclx_fsrefcd3.bindcolval!=""){
	gcds_fsva03.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd3.bindcolval;
	gcds_fsva03.Reset();
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">
	//ln_Close('A');
	var row = gcds_data1.rowposition;
	var p_fcod = gcds_data1.namevalue(row,"FDCODE");	//�����ڵ�
	var p_fsdt = gcds_data1.namevalue(row,"FSDAT");		//��������
	var p_fnbr = gcds_data1.namevalue(row,"FSNBR");		//������ȣ

	//var p_fsdt = gcds_data1.namevalue(row,"SSDAT");		//����
	//var p_fnbr = gcds_data1.namevalue(row,"SSNBR");		//��Ϲ�ȣ
	//alert("p_fsdt::"+p_fsdt);
	//alert("p_fnbr::"+p_fnbr);

	
	ln_Popup2(p_fcod,p_fsdt,p_fnbr);	//��ǥ Popup
</script>

<script language=JavaScript for="gcgd_disp01" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
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
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()">
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030022_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
	<tr><td colspan="2" height="1px"></td></tr>
</table>

<table cellpadding="0" cellspacing="0" border="0">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:865px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22" width="220px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
				</td>
			</tr>

			<tr> 				
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab23" colspan="5" width="490px">
					<comment id="__NSID__"><object id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:4px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:7px;top:1px" align=center onclick="ln_Popup('fr','01');">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;left:5;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
					~&nbsp;
				 <comment id="__NSID__"><object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>         
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('to','01');">
					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
				</td>
				<td class="tab12" width="60px" align=left>
					<img src="../../Common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,-1); ln_RefQuery(gcem_curatcode_fr01.text); ln_Enable(Number(gcds_fscd01.countrow-1));">
					<img src="../../Common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,1); ln_RefQuery(gcem_curatcode_fr01.text); ln_Enable(Number(gcds_fscd01.countrow-1));">
				</td>
				<td class="tab12" width="80px" bgcolor="#eeeeee">�������</td>
				<td width="170px">
					<comment id="__NSID__"><object  id=gcem_curatcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:3px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<input id="txt_curatkornam_to01" type="text" class="txtbox"  style= "position:relative;left:8px;top:-2px;width:105px;height:20px;" maxlength="36"  disabled>
				</td>
			</tr>
			</table>
				</td>
			</tr>
		<td>
		<tr>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;top:-3px;width:865px;border:1 solid #708090;">
			<tr> 				
				<td class="tab11" style="height:25px;width:75px;" bgcolor="#eeeeee">�����׸�1</td>
				<td class="tab21" colspan="2" width="206px">
					<comment id="__NSID__"><object  id=gclx_fsrefcd1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:4px;top:0px;font-size:12px;width:195px;">
						<param name=ComboDataID			value="gcds_fscd01">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value=CDNAM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value=CDCODE>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">�����׸�2</td>
				<td class="tab21" width="210px" align=left>
					<comment id="__NSID__"><object  id=gclx_fsrefcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fscd02">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">�����׸�3</td>
				<td class="tab22" width="211px">
					<comment id="__NSID__"><object  id=gclx_fsrefcd3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fscd03">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr> 				
				<td class="tab12" style="height:25px;width:75px;" bgcolor="#eeeeee">�����׸�1 ��</td>
				<td class="tab23" colspan="2" width="206px">
					<comment id="__NSID__"><object  id=gclx_fsrefva1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:4px;top:0px;font-size:12px;width:195px;">
						<param name=ComboDataID			value="gcds_fsva01">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value=CDNAM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value=CDCODE>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">�����׸�2 ��</td>
				<td class="tab23" width="210px" align=left>
					<comment id="__NSID__"><object  id=gclx_fsrefva2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fsva02">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">�����׸�3 ��</td>
				<td width="211px">
					<comment id="__NSID__"><object  id=gclx_fsrefva3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fsva03">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
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
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:280px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="false">
						<PARAM NAME="Format"			VALUE="  
						<C> Name='����'				ID=ACTDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center SumBgColor=#C3D0DB SumText='����' </C> 
						<C> Name='��ǥ��ȣ'		ID={IF(SSDAT='','',SSDAT&'-'&SSNBR)}			HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=center SumBgColor=#C3D0DB SumText=''   </C> 
						<C> Name='��������'		ID=FSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=center SumBgColor=#C3D0DB SumText=''   SHOW=FALSE</C> 
						<C> Name='������ȣ'		ID=FSNBR		HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=center SumBgColor=#C3D0DB SumText=''   SHOW=FALSE</C> 
						<C> Name='����'				ID=REMARK			HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left	 SumBgColor=#C3D0DB SumText=''   </C> 
						<C> Name='�ŷ�ó��'		ID=VENDER			HeadAlign=Center HeadBgColor=#B9D4DC Width=168	align=left	 SumBgColor=#C3D0DB SumText=''   </C> 
						<C> Name='����'				ID=DETOT 			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right	 SumBgColor=#C3D0DB SumText=@sum </C> 
						<C> Name='�뺯'				ID=CRTOT 			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right	 SumBgColor=#C3D0DB SumText=@sum </C> 
						<C> Name='�ܾ�'				ID=SLPVLA			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  SumBgColor=#C3D0DB SumText=@sum </C> 
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset><!-- mask={decode(ACTDAT,'�����̿�','XXXX','XXXX/XX/XX')} -->
					</td>
				</tr>

				<tr><td height="4px"></td></tr>
				<tr>
					<td height="30px;" align="center">
						<!-- <img name="btn_select" border="0" src="../../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')"> -->
						<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
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
	<param name=DataID    value=gcds_temp>
	<param name=BindInfo  value='  
		<C>Col=ATCODE				Ctrl=gcem_curatcode_fr01				Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_curatkornam_to01				Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="
	<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=372 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=859, top=119, right=2003, bottom=166 ,mask='(  �Ⱓ : XXXX�� XX�� XX��  ~  XXXX�� XX�� XX��  )', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��  ��  ��' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=72 ,top=372 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=72 ,top=284 ,right=2809 ,bottom=284 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=2447 ,top=291 ,right=2803 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=2078 ,top=291 ,right=2434 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=1709 ,top=291 ,right=2066 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=616 ,top=291 ,right=1272 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=78 ,top=291 ,right=278 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2809 ,top=284 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2441 ,top=284 ,right=2441 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2072 ,top=284 ,right=2072 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1703 ,top=284 ,right=1703 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=72 ,top=284 ,right=72 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=284 ,top=284 ,right=284 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=609 ,top=284 ,right=609 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=181, right=2806, bottom=228, align='right' ,mask='�������: XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2806 ,bottom=281 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=72, top=181, right=919, bottom=228, align='left' ,mask='��      ��: XXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��ǥ��ȣ' ,left=291 ,top=291 ,right=603 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1278 ,top=284 ,right=1278 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�ŷ�ó��' ,left=1284 ,top=291 ,right=1697 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='ATKORNAM', left=72, top=228, right=919, bottom=281, align='left' ,mask='��������: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=72 ,top=0 ,right=72 ,bottom=50 </L>
	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 </L>
	<C>id='SLPVLA', left=2447, top=0, right=2803, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2441 ,top=0 ,right=2441 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<C>id='CRTOT', left=2078, top=0, right=2434, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1709, top=0, right=2066, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1703 ,top=0 ,right=1703 ,bottom=50 </L>
	<C>id='ACTDAT', left=78, top=0, right=278, bottom=44, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=284 ,top=0 ,right=284 ,bottom=50 </L>
	<L> left=72 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='FSNBRDT', left=291, top=0, right=603, bottom=44, align='left' ,mask='XXXXXXXXX-XXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=609 ,top=0 ,right=609 ,bottom=50 </L>
	<C>id='VENDER', left=1284, top=0, right=1697, bottom=44, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1278 ,top=0 ,right=1278 ,bottom=50 </L>
	<C>id='REMARK', left=616, top=0, right=1272, bottom=44, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=72 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>
	<L> left=72 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
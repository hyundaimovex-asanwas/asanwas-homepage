<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫���� - ���꺯�����
+ ���α׷� ID	:  A080005.html
+ �� �� �� ��	:  ���꺯����� ��ȸ �� ��� ȭ���̴�.
+ ��   ��  �� :
+ �� �� �� ��	:	 a080005_s1
------------------------------------------------------------------------------
+ �� �� �� �� :	�˾��߰�, ���Ѻ���
+ ��   ��  �� : �̹���
+ �� �� �� �� : 2006.10.31
------------------------------------------------------------------------------>
<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���꺯�����</title>

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


var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_vendcd = "";	//������������
var gs_cntmsg = 0;
var gs_tolcnt = 0;


var approval = "F";
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_DispChk(0);
	ln_Before();
	ln_SetDataHeader1();
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){

	gcem_wrdt.text = gs_date2;
	gcem_bgtmmfr.text = gs_date4;
	gcem_bgtmmto.text = gs_date4;
	gclx_bgtrqst.bindcolval = "";

	gcem_bgtyy3.text = gs_date2;
	gcem_bgtyy4.text = gs_date4;
	gcem_bgtyy5.text = gs_date4;
	gclx_satcode.enable = false;

	gcem_bgtyy6.text = gs_date2;
	gcem_bgtmm4.text = gs_date4;
	gcem_bgtmm5.text = gs_date4;
	gclx_satcode4.enable = false;

	if(gs_deptcd==null){	//ȸ�谳����
		gs_deptcd = "C000";
	}

	if(gs_deptcd!="C000"){//����ںμ�
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str3="+gs_deptcd+"&v_str4=Y";
		gcds_deptemp.Reset();
	}else{
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str3="+gs_deptcd+"&v_str4=N";
		gcds_deptemp.Reset();
	}

	/*������� �׸� ��ȸ**************************************************/

	//�����ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	if(gs_vendcd!="1200"){//��û�μ�-�Ϲݺμ�
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt.Reset();
	}

	//�����û����
	gcds_bgtrqst.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2150"; 
	gcds_bgtrqst.Reset();

	//�����û����-�׸���
	gcds_bgtrqst1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2150"; 
	gcds_bgtrqst1.Reset();

	/*��������Ȳ �׸� ��ȸ**************************************************/
	
	//����[�˻�]
	gcds_sfdcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode3.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv3.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv3.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt3.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt3.Reset();
	}

	//����
	gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode.Reset();

	/*�μ�����Ȳ �׸� ��ȸ**************************************************/
	
	//����[�˻�]
	gcds_sfdcode4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode4.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv4.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv4.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt4.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt4.Reset();
	}

	//����
	gcds_satcode4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode4.Reset();
}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(e){
	if(e=="1") {
	
		var s_temp = "";
		gcds_print1.SetDataHeader(s_temp);

	} else if(e=="2") {

		var s_temp = "";
		gcds_print2.SetDataHeader(s_temp);

	} else if(e=="3") {
		var s_temp = "DEPTNM:STRING,ATKORNAM:STRING,SATNM:STRING,BGTMM:STRING,"
							+ "BASICBGT:DECIMAL,ADDBGT1:DECIMAL,REALBGT:DECIMAL,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING,DEPTNM2:STRING";
		gcds_print3.SetDataHeader(s_temp);
	} else if(e=="4") {
		var s_temp = "DEPTNM:STRING,ATKORNAM:STRING,SATNM:STRING,BGTMM:STRING,"
							+ "BASICBGT:DECIMAL,ADDBGT1:DECIMAL,REALBGT:DECIMAL,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING,DEPTNM2:STRING";
		gcds_print4.SetDataHeader(s_temp);
	}

}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader1(){
	var temp = "CHK:STRING,BGTRQNO:STRING,FDCODE:STRING,BGTYY:STRING,BGTMM:STRING,"
					 + "BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,FSREFCD:STRING,SATCODE:STRING,"
					 + "BGTRQDIV:STRING,BGTRQAMT:DECIMAL,CNT:DECIMAL,P_BGTMM:STRING,"
					 + "M_ATCODE:STRING,M_FSREFCD:STRING,M_SATCODE:STRING,P_BGTDEPT:STRING,P_BGTDIV:STRING,BGTRQSEQ:STRING";
	gcds_temp.SetDataHeader(temp);
}
function ln_SetDataHeader5(){
	var temp = "CHK:STRING,BGTRQNO:STRING,FDCODE:STRING,BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,FSREFCD:STRING,SATCODE:STRING,BGTRQST:STRING,ATKORNAM:STRING,SATNAM:STRING,DEPTNM:STRING,BGTRQDIV:STRING,BGTRQAMT:DECIMAL,M_ATCODE:STRING,M_FSREFCD:STRING,M_SATCODE:STRING,BGTFRMON:STRING,P_BGTDEPT:STRING,P_BGTDIV:STRING,DEPTNM2:STRING,EMPNMK:STRING,BGTRQSEQ:STRING";
	gcds_temp1.SetDataHeader(temp);
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(s){
 // alert("a");
	if(s=="01") {

	var str1 = gclx_fdcode.BindColVal;		//�����ڵ�
	var str2 = gclx_bgtrqst.BindColVal;		//���α���
	var str3 = gcem_wrdt.text;						//����⵵
	var str4 = gcem_bgtmmfr.text;					//�����fr  
	var str5 = gcem_bgtmmto.text;					//�����to
	var str6 = gclx_bgtrqdiv.BindColVal;	//��û����
	var str7 = gcem_bgtdept.text;		//��û�μ�
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080005_s1?v_str1="+str1
										+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4
										+ "&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
	//prompt('',gcds_data1.DataID);
	gcds_data1.Reset();

	}else if(s=="02") {    //���������ȸ

	}else if(s=="03") {
		var strs1 = gclx_sfdcode3.BindColVal;	//����  
		var strs2 = gcem_bgtyy3.text;					//����⵵fr
		var strs3 = gcem_bgtyy4.text;					//�����fr
		var strs4 = gcem_bgtyy5.text;					//�����to  
		var strs5 = gclx_bgtdiv3.BindColVal;	//���꺻��  
		var strs6 = gcem_bgtdept3.text;	//����μ�  
		var strs7 = txt_atcodenm.value;				//������    
		var strs8 = gcem_atcode.text;					//�����ڵ�  
		var strs9 = gclx_satcode.BindColVal;	//������    
		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080005_s4?"
											+ "&v_str1="+strs1+"&v_str2="+strs2+"&v_str3="+strs3
											+ "&v_str4="+strs4+"&v_str5="+strs5+"&v_str6="+strs6 
											+ "&v_str7="+strs7+"&v_str8="+strs8+"&v_str9="+strs9;
		gcds_data5.Reset();
	}else if(s=="04"){
		var strs1 = gclx_sfdcode4.BindColVal;	//����  
		var strs2 = gcem_bgtyy6.text;					//����⵵fr
		var strs3 = gcem_bgtmm4.text;					//�����fr
		var strs4 = gcem_bgtmm5.text;					//�����to  
		var strs5 = gclx_bgtdiv4.BindColVal;	//���꺻��  
		var strs6 = gcem_bgtdept4.text;	//����μ�  
		var strs7 = txt_atcodenm4.value;			//������    
		var strs8 = gcem_atcode4.text;				//�����ڵ�  
		var strs9 = gclx_satcode4.BindColVal;	//������    
		gcds_data6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080005_s6?"
											+ "&v_str1="+strs1+"&v_str2="+strs2+"&v_str3="+strs3
											+ "&v_str4="+strs4+"&v_str5="+strs5+"&v_str6="+strs6 
											+ "&v_str7="+strs7+"&v_str8="+strs8+"&v_str9="+strs9;
		gcds_data6.Reset();
	}
}

/******************************************************************************************
	Description : ��ȸ - [Detial]
******************************************************************************************/
function ln_Query2(e1,e2){
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080005_s2?v_str1="+e1+"&v_str2="+e2;
	gcds_data2.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ���� - ��û�ݾ� ���� ����(�����Ǹ� ��ȸ)
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(e){
	if(e=="1") {

	} else if(e=="2") {


	} else if(e=="3") {
		if(gcds_data5.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcds_print3.clearall();
			ln_SetDataHeader("3");
			gcds_print3.ImportData(gcds_data5.ExportData(1,gcds_data5.countrow,false));
			if (gcds_print3.countrow>0) {
				for(i=1;i<=gcds_print3.countrow;i++){
					gcds_print3.namevalue(i,"SFDCODE") = gclx_sfdcode3.ValueByColumn("FDCODE",
												gclx_sfdcode3.ValueOfIndex("FDCODE", gclx_sfdcode3.Index),"FDNAME");
					gcds_print3.namevalue(i,"BGTYY")  = gcem_bgtyy3.text;
					gcds_print3.namevalue(i,"BGTDIV")  = gclx_bgtdiv3.ValueByColumn("BGTDIVCD",
												gclx_bgtdiv3.ValueOfIndex("BGTDIVCD", gclx_bgtdiv3.Index),"BGTNAM");
					gcds_print3.namevalue(i,"BGTDPT") = gcem_bgtnam3.text;
					if(gcds_print3.namevalue(i,"ATKORNAM")!=gcds_print3.namevalue(i+1,"ATKORNAM")) {
						gcds_print3.namevalue(i,"ATKORNAM")="";
						gcds_print3.namevalue(i,"SATNM")="�Ұ�";
					}
				}
			}
			gcrp_print3.preview();
		}
	} else if(e=="4") {
		if(gcds_data6.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			ln_SetDataHeader("4");
			gcds_print4.ImportData(gcds_data6.ExportData(1,gcds_data6.countrow,false));
			if (gcds_print4.countrow>0) {
				for(i=1;i<=gcds_print4.countrow;i++){
					gcds_print4.namevalue(i,"SFDCODE") = gclx_sfdcode4.ValueByColumn("FDCODE",
												gclx_sfdcode4.ValueOfIndex("FDCODE", gclx_sfdcode4.Index),"FDNAME");
					gcds_print4.namevalue(i,"BGTYY")  = gcem_bgtyy6.text;
					gcds_print4.namevalue(i,"BGTDIV")  = gclx_bgtdiv4.ValueByColumn("BGTDIVCD",
												gclx_bgtdiv4.ValueOfIndex("BGTDIVCD", gclx_bgtdiv4.Index),"BGTNAM");
					gcds_print4.namevalue(i,"BGTDPT") = gcem_bgtnam4.text;
					if(gcds_print4.namevalue(i,"DEPTNM")!=gcds_print4.namevalue(i+1,"DEPTNM")) {
						gcds_print4.namevalue(i,"DEPTNM")="";
						gcds_print4.namevalue(i,"SATNM")="�Ұ�";
					}
				}
			}
			gcrp_print4.preview();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){

}

/******************************************************************************************
	Description : ��ȸ - �����׸� �ڵ� ��ȸ
******************************************************************************************/
function ln_RefQuery(e){
	//��������Ȳ
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e+"&v_str2=B";
	gcds_fsrefcd.Reset();
}

/******************************************************************************************
	Description : ��ȸ - �����׸� �ڵ� ��ȸ
******************************************************************************************/
function ln_RefQuery4(e){
	//�μ�����Ȳ
	gcds_fsrefcd4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e+"&v_str2=B";
	gcds_fsrefcd4.Reset();
}

/******************************************************************************************
	Description : ��ȸ - �����ڵ� ��ȸ
******************************************************************************************/
function ln_SatQuery(e){
	if(e!="0003"){
		gclx_satcode.enable = true;
		gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+e;
		gcds_satcode.Reset();
	} else{
		gclx_satcode.enable = false;
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="00";
		gcds_satcode.NameValue(1,"CDNAM")="00";
		gclx_satcode.index = 0;
	}
}

/*****************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Approval(){
	ln_SetDataHeader1();
	
	gs_cntmsg = 1;
	gs_tolcnt = 0;

	if(gcds_data1.countrow>0){
		if (!gcds_data1.IsUpdated) {
			alert("���õ� ������ �����ϴ�."); 
			return false;
		}
			
		var tolcnt = 0;
		for(var i=1;i<=gcds_data1.countrow;i++){
			if(gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQAMT")!=0 && gcds_data1.namevalue(i,"BGTRQST")=="R"){
				tolcnt++;
			}
		}

		gs_tolcnt=tolcnt;
	
		if(confirm("�����Ͻðڽ��ϱ�?")){
			for(i=1;i<=gcds_data1.countrow;i++){
				if(gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQAMT")!=0 && gcds_data1.namevalue(i,"BGTRQST")=="R"){
					gcds_temp.ClearData();
					/*�����û Detail�� ����� ����*/
					gcds_temp.AddRow();
					gcds_temp.namevalue(1,"CHK")		 = gcds_data1.namevalue(i,"CHK");
					gcds_temp.namevalue(1,"BGTRQNO")	 = gcds_data1.namevalue(i,"BGTRQNO");
					gcds_temp.namevalue(1,"FDCODE")		 = gcds_data1.namevalue(i,"FDCODE");
					gcds_temp.namevalue(1,"BGTYY")		 = gcds_data1.namevalue(i,"BGTYY");
					gcds_temp.namevalue(1,"BGTMM")		 = gcds_data1.namevalue(i,"BGTMM");
					gcds_temp.namevalue(1,"P_BGTMM")	 = gcds_data1.namevalue(i,"BGTFRMON");
					gcds_temp.namevalue(1,"BGTDIV")	   = gcds_data1.namevalue(i,"BGTDIV");
					gcds_temp.namevalue(1,"BGTDPT")	   = gcds_data1.namevalue(i,"BGTDPT");
					gcds_temp.namevalue(1,"ATCODE")	   = gcds_data1.namevalue(i,"ATCODE");
					gcds_temp.namevalue(1,"FSREFCD")	 = gcds_data1.namevalue(i,"FSREFCD");
					gcds_temp.namevalue(1,"SATCODE")	 = gcds_data1.namevalue(i,"SATCODE");
					gcds_temp.namevalue(1,"BGTRQDIV")  = gcds_data1.namevalue(i,"BGTRQDIV");
					gcds_temp.namevalue(1,"BGTRQAMT")  = gcds_data1.namevalue(i,"BGTRQAMT");
					gcds_temp.namevalue(1,"M_ATCODE")  = gcds_data1.namevalue(i,"M_ATCODE");
					gcds_temp.namevalue(1,"M_FSREFCD") = gcds_data1.namevalue(i,"M_FSREFCD");
					gcds_temp.namevalue(1,"M_SATCODE") = gcds_data1.namevalue(i,"M_SATCODE");
					gcds_temp.namevalue(1,"P_BGTDEPT") = gcds_data1.namevalue(i,"P_BGTDEPT");
					gcds_temp.namevalue(1,"P_BGTDIV")  = gcds_data1.namevalue(i,"P_BGTDIV");
					
					//prompt("",gcds_data1.text);
					//prompt("",gcds_temp.text);
				
					gctr_data1.KeyValue = "Account.a080005_t1(I:USER=gcds_temp)";
					gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080005_t1";
					gctr_data1.post();
					++gs_cntmsg;
					ln_Query();
				}else if (gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQAMT")==0 && gcds_data1.namevalue(i,"BGTRQST")=="R"){
					alert("�ݾ��� '0'�� ������ ������ �� �����ϴ�. ");
					return false;
				}else if (gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQAMT")!=0 && gcds_data1.namevalue(i,"BGTRQST")!="R"){
					alert("���ο�û�� �Ǹ� ���ΰ����մϴ�.");
					return false;
				}
        if(gcds_data1.countrow==i){
          approval="T";
        }
			}
      if(approval=="T"){
        alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
        approval="F";
      }
		}
	}else alert("������ ������ �����ϴ�.");
}


/*****************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_NApproval(){
	ln_SetDataHeader5();
	
	if(gcds_data1.countrow>0){
		if (!gcds_data1.IsUpdated) {
			alert("���õ� ������ �����ϴ�."); 
			return false;
		}

		if(confirm("������� �Ͻðڽ��ϱ�?")){
			gcds_temp1.ClearData();

			for(i=1;i<=gcds_data1.countrow;i++){
        /*�����û Detail�� ����� ����*/
//        if(gcds_data1.namevalue(i,"CHK")=="T"){
          gcds_temp1.AddRow();
          gcds_temp1.namevalue(i,"CHK"      )		   = gcds_data1.namevalue(i,"CHK"      );
          gcds_temp1.namevalue(i,"BGTRQNO"  )		   = gcds_data1.namevalue(i,"BGTRQNO"  );
          gcds_temp1.namevalue(i,"FDCODE"   )		   = gcds_data1.namevalue(i,"FDCODE"   );
          gcds_temp1.namevalue(i,"BGTYY"    )		   = gcds_data1.namevalue(i,"BGTYY"    );
          gcds_temp1.namevalue(i,"BGTMM"    )		   = gcds_data1.namevalue(i,"BGTMM"    );
          gcds_temp1.namevalue(i,"BGTDIV"   )		   = gcds_data1.namevalue(i,"BGTDIV"   );
          gcds_temp1.namevalue(i,"BGTDPT"   )		   = gcds_data1.namevalue(i,"BGTDPT"   );
          gcds_temp1.namevalue(i,"ATCODE"   )		   = gcds_data1.namevalue(i,"ATCODE"   );
          gcds_temp1.namevalue(i,"FSREFCD"  )		   = gcds_data1.namevalue(i,"FSREFCD"  );
          gcds_temp1.namevalue(i,"SATCODE"  )		   = gcds_data1.namevalue(i,"SATCODE"  );
          gcds_temp1.namevalue(i,"BGTRQST"  )		   = gcds_data1.namevalue(i,"BGTRQST"  );
          gcds_temp1.namevalue(i,"ATKORNAM" )		   = gcds_data1.namevalue(i,"ATKORNAM" );
          gcds_temp1.namevalue(i,"SATNAM"   )		   = gcds_data1.namevalue(i,"SATNAM"   );
          gcds_temp1.namevalue(i,"DEPTNM"   )		   = gcds_data1.namevalue(i,"DEPTNM"   );
          gcds_temp1.namevalue(i,"BGTRQDIV" )		   = gcds_data1.namevalue(i,"BGTRQDIV" );
          gcds_temp1.namevalue(i,"BGTRQAMT" )		   = gcds_data1.namevalue(i,"BGTRQAMT" );
          gcds_temp1.namevalue(i,"M_ATCODE" )		   = gcds_data1.namevalue(i,"M_ATCODE" );
          gcds_temp1.namevalue(i,"M_FSREFCD")		   = gcds_data1.namevalue(i,"M_FSREFCD");
          gcds_temp1.namevalue(i,"M_SATCODE")		   = gcds_data1.namevalue(i,"M_SATCODE");
          gcds_temp1.namevalue(i,"BGTFRMON" )		   = gcds_data1.namevalue(i,"BGTFRMON" );
          gcds_temp1.namevalue(i,"P_BGTDEPT")		   = gcds_data1.namevalue(i,"P_BGTDEPT");
          gcds_temp1.namevalue(i,"P_BGTDIV" )		   = gcds_data1.namevalue(i,"P_BGTDIV" );
          gcds_temp1.namevalue(i,"DEPTNM2"  )		   = gcds_data1.namevalue(i,"DEPTNM2"  );
          gcds_temp1.namevalue(i,"EMPNMK"   )		   = gcds_data1.namevalue(i,"EMPNMK"   );
          gcds_temp1.namevalue(i,"BGTRQSEQ" )		   = gcds_data1.namevalue(i,"BGTRQSEQ" );
//        }
      }
      gctr_data1.KeyValue = "Account.a080005_t4(I:USER=gcds_temp1)";
      gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080005_t4";
      gctr_data1.post();
      ln_Query('01');



		}
	}else{
    alert("��������� ������ �����ϴ�.");
  }
}


/*****************************************************************************************
	Description : ���α��� üũ
*****************************************************************************************/
function ln_Chk(){
	for(i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQST")!="R"){
			alert("���ο�û�Ǹ� ������ �����մϴ�.");
			return false;
		}else if(gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQST")!="Y"){
			ln_Query2(gcds_data1.namevalue(i,"FDCODE"),gcds_data1.namevalue(i,"BGTRQNO"));
		}
	}
	return true;
}

/*****************************************************************************************
	Description : �ݼ�
*****************************************************************************************/
function ln_SendBank(){
	if(ln_BChk()){	
		if(confirm("�ݼ� �Ͻðڽ��ϱ�?")){
			gctr_data1.KeyValue = "Account.a080005_t2(I:USER=gcds_data1)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080005_t2";
			gctr_data1.post();
			ln_Query();
		}
	}
}

/*****************************************************************************************
	Description : �ݼ۱��� üũ
*****************************************************************************************/
function ln_BChk(){
	for(i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQST")!="R"){
			alert("���ο�û�Ǹ� �ݼ��� �����մϴ�.");
			return false;
		}else if(gcds_data1.namevalue(i,"CHK")=="T" && gcds_data1.namevalue(i,"BGTRQST")!="Y"){
			ln_Query2(gcds_data1.namevalue(i,"FDCODE"),gcds_data1.namevalue(i,"BGTRQNO"));
		}
	}
	return true;
}

/******************************************************************************
	Description : ���ΰ� üũ
******************************************************************************/
function ln_AppCheck(e){

}

/***********************************************************************************************
	Description : ���꺯�� ã��
	parameter   : e1:�����ڵ�, e2:��û����ȣ, e3:����⵵, e4:��û�μ�, e5:�����׸��ڵ�
**********************************************************************************************/
function ln_DispControl(e1,e2,e3,e4,e5){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

		strURL = "./bgtdetail_popup1.jsp";
		arrParam[0]=e1;
		arrParam[1]=e2;
		arrParam[2]=e3;
		arrParam[3]=e4;
		arrParam[4]=e5;
		strPos = "dialogWidth:885px;dialogHeight:579px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

}


/***********************************************************************************************
	Description : �����ڵ� ã��
	parameter   : p2===> fr, to- �����ڵ� : apr- ���� : up - �������� : down - �����ڵ�
**********************************************************************************************/
function ln_Popup(e){
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
		if(e=="03"){
			gcem_atcode.text   = arrParam[0];
			txt_atcodenm.value = arrParam[1];
			ln_RefQuery(arrParam[0]);	//�����׸� ��ȸ
		}else if(e=="04"){
			gcem_atcode4.text   = arrParam[0];
			txt_atcodenm4.value = arrParam[1];
			ln_RefQuery4(arrParam[0]);	//�����׸� ��ȸ
		}
	} else {
		if(e=="03"){
			gcem_atcode.text = "";
			txt_atcodenm.value ="";
		}else if(e=="04"){
			gcem_atcode4.text = "";
			txt_atcodenm4.value ="";
		}
	}
}

/******************************************************************************
	Description : �Ǳ���
	prameter    : 0-�Ϻ��ڵ�, 1-�����׸�
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2","div_disp3");
  var div_cd = new Array("div_dbtn1","div_dbtn2","div_dbtn3");
	for(var i=0;i<=2;i++)	{
		if(i==index) {
			eval("document.all."+div_cd[i]+".style.display='block';");
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cd[i]+".style.display='none';");
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
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
//		gclx_bgtdiv5.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}


function ln_Popup3(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam3.text;
	arrParam[1]=gcem_bgtdept3.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam3.text = arrParam[1];
		gcem_bgtdept3.text = arrParam[0];
		gclx_bgtdiv3.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}


function ln_Popup4(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam4.text;
	arrParam[1]=gcem_bgtdept4.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam4.text = arrParam[1];
		gcem_bgtdept4.text = arrParam[0];
		gclx_bgtdiv4.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
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

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<PARAM NAME="SubsumExpr"	VALUE="1:ATKORNAM">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<PARAM NAME="SubsumExpr"	VALUE="1:DEPTNM">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data1_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtrqst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtrqst1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdpt3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdpt5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdiv3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fsrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fsrefcd4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object  id=gcds_temp01_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_tempamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temppam classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_deptemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id=gcds_depttemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��"; 
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">

</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">

</script>

<script language="javascript" for="gcds_data5" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + gcds_data5.RealCount(1,gcds_data5.CountRow) + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}
</script>

<script language="javascript" for="gcds_data6" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data6" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "��ȸ�Ǽ� : " +gcds_data6.RealCount(1,gcds_data6.CountRow) + " ��";
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

<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gclx_fsrefcd.index = 0;
	var str1 = gcds_fsrefcd.namevalue(row,"CDCODE");
	ln_SatQuery(str1);
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
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

<script language="javascript" for="gcds_sfdcode3" event="onloadCompleted(row,colid)">
	gcds_sfdcode3.InsertRow(1);
	gcds_sfdcode3.NameValue(1,"FDCODE")="";
	gcds_sfdcode3.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode3.index=2;
	}else{
		gclx_sfdcode3.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode4" event="onloadCompleted(row,colid)">
	gcds_sfdcode4.InsertRow(1);
	gcds_sfdcode4.NameValue(1,"FDCODE")="";
	gcds_sfdcode4.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode4.index=2;
	}else{
		gclx_sfdcode4.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_deptemp" event="onloadCompleted(row,colid)">
	gs_vendcd = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	if(gcds_deptemp.countrow>0){
		gcem_bgtnam4.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept4.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

		gcem_bgtnam.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

		gcem_bgtnam3.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept3.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

	}else {
  }
</script>

<script language="javascript" for="gcds_bgtdpt" event="OnLoadStarted()">
	//window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>




<script language="javascript" for="gcds_bgtdiv3" event="onloadCompleted(row,colid)">
	gcds_bgtdiv3.InsertRow(1);
	gcds_bgtdiv3.NameValue(1,"BGTDIVCD")="";
	gcds_bgtdiv3.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv3.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv3.index = 0;
</script>

<script language="javascript" for="gcds_bgtdiv4" event="onloadCompleted(row,colid)">
	gcds_bgtdiv4.InsertRow(1);
	gcds_bgtdiv4.NameValue(1,"BGTDIVCD")="";
	gcds_bgtdiv4.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv4.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv4.index = 0;
</script>


<script language="javascript" for="gcds_satcode" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode.enable = false;
		//gcds_satcode.InsertRow(1);
		//gcds_satcode.NameValue(1,"CDCODE")="00";
		//gcds_satcode.NameValue(1,"CDNAM")="00";
		gclx_satcode.index = 0;
	}else{ 
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="";
		gcds_satcode.NameValue(1,"CDNAM")="";
		gclx_satcode.index = 0;
		gclx_satcode.enable = true;
	}
</script>

<script language="javascript" for="gcds_satcode4" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode4.enable = false;
		/*
		gcds_satcode4.InsertRow(1);
		gcds_satcode4.NameValue(1,"CDCODE")="00";
		gcds_satcode4.NameValue(1,"CDNAM")="00";
		*/
		gclx_satcode4.index = 0;
	}else{ 
		gcds_satcode4.InsertRow(1);
		gcds_satcode4.NameValue(1,"CDCODE")="";
		gcds_satcode4.NameValue(1,"CDNAM")="";
		gclx_satcode4.index = 0;
		gclx_satcode4.enable = true;
	}
</script>


<script language="javascript" for="gcds_bgtrqst" event="onloadCompleted(row,colid)">
	gcds_bgtrqst.InsertRow(1);
	gcds_bgtrqst.NameValue(1,"CDCODE")="";
	gcds_bgtrqst.NameValue(1,"CDNAM")="";
	gclx_bgtrqdiv.index = 0;
</script>



<script language="javascript" for="gcds_depttemp" event="onloadCompleted(row,colid)">
	if(gcds_depttemp.countrow>0){
    if(gcds_depttemp.countrow == '1'){
      gcem_bgtnam.text = gcds_depttemp.namevalue(1,"CDNAM");
      gcem_bgtdept.text = gcds_depttemp.namevalue(1,"CDCODE");
      //gclx_bgtdiv.bindcolval = gcds_depttemp.namevalue(1,"GBCD");
    }else{
      ln_Popup1();
    }
	}else{
    gcem_bgtnam.text = "";
    gcem_bgtdept.text = "";
  }
</script>
<script language="javascript" for="gcds_depttemp3" event="onloadCompleted(row,colid)">
	if(gcds_depttemp3.countrow>0){
    if(gcds_depttemp3.countrow == '1'){
      gcem_bgtnam3.text = gcds_depttemp3.namevalue(1,"CDNAM");
      gcem_bgtdept3.text = gcds_depttemp3.namevalue(1,"CDCODE");
      gclx_bgtdiv3.bindcolval = gcds_depttemp3.namevalue(1,"GBCD");
    }else{
      ln_Popup3();
    }
	}else{
    gcem_bgtnam3.text = "";
    gcem_bgtdept3.text = "";
  }
</script>
<script language="javascript" for="gcds_depttemp4" event="onloadCompleted(row,colid)">
	if(gcds_depttemp4.countrow>0){
    if(gcds_depttemp4.countrow == '1'){
      gcem_bgtnam4.text = gcds_depttemp4.namevalue(1,"CDNAM");
      gcem_bgtdept4.text = gcds_depttemp4.namevalue(1,"CDCODE");
      gclx_bgtdiv4.bindcolval = gcds_depttemp4.namevalue(1,"GBCD");
    }else{
      ln_Popup4();
    }
	}else{
    gcem_bgtnam4.text = "";
    gcem_bgtdept4.text = "";
  }
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>

<script language=JavaScript for=gcgd_temp01_1 event=OnClick(row,colid)>
	/*���������Ѱ�ǥ*/
	/*
	if (row==1&&colid=="param37"&&gcds_temp01_1.namevalue(1,"param37")=="T"){
		for(var i=1;i<=37;i=i+3){
			gcds_temp01_1.namevalue(1,"param"+i) = "T";
		}
	}else if (row==1&&colid=="param37"&&gcds_temp01_1.namevalue(1,"param37")=="F"){
		for(var i=1;i<=37;i=i+3){
			gcds_temp01_1.namevalue(1,"param"+i) = "F";
		}
	}else if (row==2&&colid=="param37"&&gcds_temp01_1.namevalue(2,"param37")=="T"){
		for(var i=1;i<=37;i=i+3){
			gcds_temp01_1.namevalue(2,"param"+i) = "T";
		}
	}else if (row==2&&colid=="param37"&&gcds_temp01_1.namevalue(2,"param37")=="F"){
		for(var i=1;i<=37;i=i+3){
			gcds_temp01_1.namevalue(2,"param"+i) = "F";
		}
	}
	*/
</script>

<script language=javascript for=gcgd_temp01_1 event=OnScrolling(row,col,bymethod)>
	//if(!bymethod) {
	//	gcgd_disp01.SetScrolling(row,(col+1));
	//	gcgd_temp01.SetScrolling(row,(col));
	//}
</script>

<script language=JavaScript for=gcgd_disp05 event=OnClick(row,colid)>
	var strColid = colid;
	var strCol = strColid.substring(0,5);
	if(strCol =="CHGMM"){
		var strColnum= strColid.substring(5,7);
		if(gcds_data2.namevalue(row,"APPROVAL"+strColnum)=="Y"){
			alert("���ΰ��� ������ �� �����ϴ�.");
		}
	}
</script>

<script language=JavaScript for=gclx_bgtdpt3 event=OnCloseUp()>
	gclx_bgtdiv3.bindcolval = gcds_bgtdpt3.namevalue(gcds_bgtdpt3.rowposition,"BGTDIVCD");
</script>

<script language=JavaScript for=gclx_bgtdpt5 event=OnCloseUp()>
	//gclx_bgtdiv5.bindcolval = gcds_bgtdpt5.namevalue(gcds_bgtdpt5.rowposition,"BGTDIVCD");
</script>

<script language=JavaScript for=gclx_bgtdpt event=OnCloseUp()>
	//gclx_bgtdiv1.bindcolval = gcds_bgtdpt.namevalue(gcds_bgtdpt.rowposition,"BGTDIVCD");
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	//gcem_bgtrqno.enable = true;
	var f01 = gcds_data1.namevalue(row,"FDCODE");		//�����ڵ�      
	var f02 = gcds_data1.namevalue(row,"BGTRQNO");	//��û����ȣ    
	var f03 = gcds_data1.namevalue(row,"BGTYY");		//����⵵      
	var f04 = gcds_data1.namevalue(row,"BGTDPT");		//��û�μ�      
	var f05 = gcds_data1.namevalue(row,"FSREFCD");	//�����׸��ڵ�  
	ln_DispControl(f01,f02,f03,f04,f05);
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
<script language=JavaScript for=gcem_bgtnam3 event=OnKillFocus()>
  if(gcem_bgtnam3.text!=""){
    gcem_bgtdept3.text = "";
    gcds_depttemp3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam3.text;
    gcds_depttemp3.Reset();
  }else{
    gcem_bgtdept3.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept3 event=OnKillFocus()>
  if(gcem_bgtdept3.text!=""){
    gcem_bgtnam3.text="";
    gcds_depttemp3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept3.text+"&v_str2=";
    gcds_depttemp3.Reset();
  }else{
    gcem_bgtnam3.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtnam4 event=OnKillFocus()>
  if(gcem_bgtnam4.text!=""){
    gcem_bgtdept4.text = "";
    gcds_depttemp4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam4.text;
    gcds_depttemp4.Reset();
  }else{
    gcem_bgtdept4.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept4 event=OnKillFocus()>
  if(gcem_bgtdept4.text!=""){
    gcem_bgtnam4.text="";
    gcds_depttemp4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept4.text+"&v_str2=";
    gcds_depttemp4.Reset();
  }else{
    gcem_bgtnam4.text="";
  }
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	//alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data2 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a080005_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">
      <table id="div_dbtn1" width="240px" cellpadding="0" cellspacing="0" border="0" style="display:none;position:relative;left:0px">
        <tr>
          <td align=right>
            <img src="../../Common/img/btn/com_b_sendbak.gif"			style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_SendBank()">
            <img src="../../Common/img/btn/com_b_sungin.gif"      style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Approval()">
            <img src="../../Common/img/btn/com_b_appcan.gif"      style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_NApproval()">
            <img src="../../Common/img/btn/com_b_query.gif"				style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('01')">
          </td>
        </tr>
      </table>
      <table id="div_dbtn2" width="240px" cellpadding="0" cellspacing="0" border="0" style="display:none;position:relative;left:0px">
        <tr>
          <td align=right>
            <img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('3')">
            <IMG src="../../Common/img/btn/com_b_excel.gif"  style="position:relative;right:5px;top:2px;cursor:hand"  onclick="ln_Excel('3')">	
            <img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('03')">
          </td>
        </tr>
      </table>
      <table id="div_dbtn3" width="240px" cellpadding="0" cellspacing="0" border="0" style="display:none;position:relative;left:0px">
        <tr>
          <td align=right><nobr>
            <img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('4')">
            <IMG src="../../Common/img/btn/com_b_excel.gif"  style="position:relative;right:5px;top:2px;cursor:hand"  onclick="ln_Excel('4')">	
            <img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('04')">
          </td>

        </tr>
      </table>
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
								<T>divid=div_1		title=�������</T>									
							  <T>divid=div_2		title=��������Ȳ</T>
							  <T>divid=div_3		title=�μ�����Ȳ</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- �������� ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:485px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" style="display:block;position:relative;left:0px">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:105px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:95px;height:95px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^95">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr></td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">���α���</td>
				<td class="tab21" width="95px">
					<comment id="__NSID__"><object  id=gclx_bgtrqst classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:85px;">
						<param name=CBData			    value="^ ,Y^���οϷ�,R^���ο�û,N^�ۼ���,B^�ݼ�"><!-- C^�������,N^���δ��, -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script></td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="60px">
					<comment id="__NSID__"><object  id=gcem_wrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:1px;width:35px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script></td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;��&nbsp;��</td>
				<td class="tab22">
					<comment id="__NSID__"><object  id=gcem_bgtmmfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px;width:25px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmmto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:2px;width:25px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script></td>
			</tr>
			<tr> 				
				<td class="tab12" style="height:25px;width:70px;" bgcolor="#eeeeee">���걸��</td>
				<td class="tab23">
					<comment id="__NSID__"><object  id=gclx_bgtrqdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:95px;">
						<param name=ComboDataID			value="gcds_bgtrqst">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^95">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script></td>
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td width="200px" colspan="6">
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
						style="position:relative;left:8px;width:864px;height:387px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="TRUE">
						<!-- <param name="ViewSummary" value="1"> -->
						<PARAM NAME="Format"			VALUE="  
							<C> Name='����'					ID=CHK			HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumBgColor=#C3D0DB SumText=''			EditStyle='CheckBox' Pointer=Hand</C>
							<C> Name='�����'						ID=BGTMM		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumBgColor=#C3D0DB SumText=''			Edit=none</C>
							<C> Name='������'						ID=BGTFRMON		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumBgColor=#C3D0DB SumText=''			Edit=none</C> 

							<C> Name='���걸��'			ID=BGTRQDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center	SumBgColor=#C3D0DB SumText=''			EditStyle='lookup' Data='gcds_bgtrqst1:CDCODE:CDNAM' Edit=none</C> 
							<C> Name='��û�ݾ�'					ID=BGTRQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=right	SumBgColor=#C3D0DB SumText=''			Edit=none</C> 

							<C> Name='��û�μ�'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left		SumBgColor=#C3D0DB SumText=''			EditStyle='lookup' Data='gcds_bgtdpt:CDCODE:CDNAM'	Edit=none</C> 							
							<C> Name='��������'			ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left		SumBgColor=#C3D0DB SumText='�հ�'	EditStyle='lookup' Data='gcds_fdcode:FDCODE:FDNAME' Edit=none</C> 
							<C> Name='����'					ID=SATNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		SumBgColor=#C3D0DB SumText=''			EditStyle='lookup' Data='gcds_fdcode:FDCODE:FDNAME' Edit=none</C> 
							<C> Name='���α���'			ID=BGTRQST	HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=center	SumBgColor=#C3D0DB SumText=''			EditStyle='Combo'  Data='Y:���οϷ�,R:���ο�û,N:���δ��,B:�ݼ�,C:�������' Edit=none</C>
							<C> Name='��û����ȣ'		ID=BGTRQNO 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	SumBgColor=#C3D0DB SumText=''			Edit=none</C> 
						 <C> Name='�ۼ��μ�'		ID=DEPTNM2 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	SumBgColor=#C3D0DB SumText=''			Edit=none</C> 
						 <C> Name='�ۼ���'		ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	SumBgColor=#C3D0DB SumText=''			Edit=none</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-- ��������Ȳ ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:485px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:65px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:66px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode3">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^65">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="60px"><nobr>
					<comment id="__NSID__"><object  id=gcem_bgtyy3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:35px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="165px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:155px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv3">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="300px">

          <comment id="__NSID__"><object  id=gcem_bgtnam3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup3()">
          <comment id="__NSID__"><object  id=gcem_bgtdept3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
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
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab23" style="width:65px"><nobr>
					<comment id="__NSID__"><object  id=gcem_bgtyy4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtyy5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab23" colspan="3"><nobr>
					<input id=txt_atcodenm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:185px;">
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('03')">
					<comment id="__NSID__"><object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">����</td>
				<td colspan="2">
					<comment id="__NSID__"><object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd"><!-- �����׸��ڵ� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode"><!-- ������ -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^130">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px; height:387px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data5">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"   VALUE="true">
              <PARAM NAME="Editable"    VALUE="true">
							<PARAM NAME="Format"			VALUE="  
						<C> Name='��'				ID=BGTMM		HeadAlign=Center HeadBgColor=#B9D4DC Width=30	 align=center SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='��������'	ID=ATKORNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=left		SumText=''			SumBgColor='#C3D0DB' SubSumText=''  sumtextalign='center'</C> 
						<C> Name='����'			ID=SATNM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=170 align={decode(curlevel,1,center,right)}		SumText=''	SumBgColor='#C3D0DB' SubSumText='�Ұ�'<	/C> 
						<C> Name='�μ�'			ID=DEPTNM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=170 align=left		SumBgColor='#C3D0DB' </C> 
						<C> Name='������'		ID=BASICBGT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�����'		ID=ADDBGT1	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='���࿹��'		ID=REALBGT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  SumText=@sum	  SumBgColor='#C3D0DB'</C>
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

<!-- �μ�����Ȳ ===========================================================================================================-->
<fieldset id=field3 style="position:absolute;top:160px;left:18px;height:485px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:65px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:66px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode4">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^65">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="60px"><nobr>
					<comment id="__NSID__"><object  id=gcem_bgtyy6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:35px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="165px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:155px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv4">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="300px">

          <comment id="__NSID__"><object  id=gcem_bgtnam4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup4()">
          <comment id="__NSID__"><object  id=gcem_bgtdept4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
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
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab23" style="width:65px"><nobr>
					<comment id="__NSID__"><object  id=gcem_bgtmm4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmm5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab23" colspan="3"><nobr>
					<input id=txt_atcodenm4 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:185px;">
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('04')">
					<comment id="__NSID__"><object  id=gcem_atcode4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">����</td>
				<td colspan="2">
					<comment id="__NSID__"><object  id=gclx_fsrefcd4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd4"><!-- �����׸��ڵ� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode4"><!-- ������ -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^130">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px; height:387px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data6">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"   VALUE="true">
              <PARAM NAME="Editable"    VALUE="false">
							<PARAM NAME="Format"			VALUE="  
						<C> Name='��'				ID=BGTMM		HeadAlign=Center HeadBgColor=#B9D4DC Width=30	 align=center SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='��û�μ�'	ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=left		SumText='�հ�'  SumBgColor='#C3D0DB' SubSumText=''  sumtextalign='center'</C> 
						<C> Name='��������'	ID=ATKORNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=170 align=left		SumText=''			SumBgColor='#C3D0DB' SubSumText=''  sumtextalign='center'</C> 
						<C> Name='����'			ID=SATNM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=170 align={decode(curlevel,1,center,right)}		SumText=''			SumBgColor='#C3D0DB' SubSumText='�Ұ�'</C> 
						<C> Name='������'		ID=BASICBGT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�����'		ID=ADDBGT1	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='���࿹��'		ID=REALBGT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  SumText=@sum	  SumBgColor='#C3D0DB'</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_temp>
	<param name=BindInfo  value='  
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N - ���������Ѱ�ǥ
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print0 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print1">
	<param name="DetailDataID"			value="gcds_print1">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2868 ,bottom=389 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��' ,left=1519 ,top=153 ,right=1588 ,bottom=230 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=378 ,right=2813 ,bottom=378 </L>
	<L> left=1590 ,top=161 ,right=2813 ,bottom=161 </L>
	<T>id='����' ,left=2572 ,top=103 ,right=2810 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=2328 ,top=103 ,right=2564 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ���' ,left=2085 ,top=103 ,right=2318 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1842 ,top=103 ,right=2074 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=1598 ,top=103 ,right=1831 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=98 ,right=2813 ,bottom=98 </L>
	<T>id='��������û�μ�������' ,left=1971 ,top=21 ,right=2416 ,bottom=85 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=201, top=331, right=1005, bottom=384, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� ��:' ,left=40 ,top=331 ,right=196 ,bottom=384 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û����:' ,left=40 ,top=275 ,right=196 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=185 ,right=847 ,bottom=185 </L>
	<T>id='��' ,left=1519 ,top=246 ,right=1588 ,bottom=325 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=98 ,right=1513 ,bottom=378 </L>
	<L> left=2566 ,top=98 ,right=2566 ,bottom=378 </L>
	<L> left=2323 ,top=98 ,right=2323 ,bottom=378 </L>
	<L> left=2077 ,top=98 ,right=2077 ,bottom=378 </L>
	<L> left=1834 ,top=98 ,right=1834 ,bottom=378 </L>
	<L> left=2813 ,top=98 ,right=2813 ,bottom=378 </L>
	<C>id='REQDT', left=201, top=275, right=450, bottom=328, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1590 ,top=98 ,right=1590 ,bottom=378 </L>
	<L> left=40 ,top=177 ,right=847 ,bottom=177 </L>
	<C>id='HTITLE', left=40, top=98, right=849, bottom=175, align='left' ,mask='XXXX�� �������� ��Ȳ(1��~12��)', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2868 ,bottom=103 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=3 ,right=2813 ,bottom=3 </L>
	<T>id='��������' ,left=48 ,top=8 ,right=392 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=3 ,right=40 ,bottom=101 </L>
	<L> left=394 ,top=3 ,right=394 ,bottom=101 </L>
	<L> left=865 ,top=3 ,right=865 ,bottom=101 </L>
	<L> left=1024 ,top=3 ,right=1024 ,bottom=101 </L>
	<L> left=1183 ,top=3 ,right=1183 ,bottom=101 </L>
	<L> left=1344 ,top=3 ,right=1344 ,bottom=101 </L>
	<L> left=1503 ,top=3 ,right=1503 ,bottom=101 </L>
	<L> left=1664 ,top=3 ,right=1664 ,bottom=101 </L>
	<L> left=1823 ,top=3 ,right=1823 ,bottom=101 </L>
	<L> left=1982 ,top=3 ,right=1982 ,bottom=101 </L>
	<L> left=2299 ,top=3 ,right=2299 ,bottom=101 </L>
	<L> left=2458 ,top=3 ,right=2458 ,bottom=101 </L>
	<L> left=2619 ,top=3 ,right=2619 ,bottom=101 </L>
	<L> left=2140 ,top=3 ,right=2140 ,bottom=101 </L>
	<L> left=2813 ,top=3 ,right=2813 ,bottom=101 </L>
	<L> left=40 ,top=101 ,right=2813 ,bottom=101 </L>
	<T>id='1��' ,left=712 ,top=8 ,right=863 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2625 ,top=8 ,right=2807 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=400 ,top=8 ,right=704 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=706 ,top=3 ,right=706 ,bottom=101 </L>
	<T>id='2��' ,left=873 ,top=8 ,right=1021 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3��' ,left=1032 ,top=8 ,right=1180 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4��' ,left=1191 ,top=8 ,right=1341 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5��' ,left=1349 ,top=8 ,right=1500 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6��' ,left=1508 ,top=8 ,right=1659 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7��' ,left=1670 ,top=8 ,right=1818 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8��' ,left=1828 ,top=8 ,right=1979 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9��' ,left=1987 ,top=8 ,right=2138 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10��' ,left=2146 ,top=8 ,right=2297 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12��' ,left=2466 ,top=8 ,right=2617 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11��' ,left=2307 ,top=8 ,right=2455 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2868 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=0 ,right=2813 ,bottom=0 </L>
	<C>id='ATKORNAM', left=48, top=5, right=392, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTSUM', left=2625, top=5, right=2807, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=394 ,top=0 ,right=394 ,bottom=66 </L>
	<L> left=1183 ,top=0 ,right=1183 ,bottom=66 </L>
	<L> left=1024 ,top=0 ,right=1024 ,bottom=66 </L>
	<L> left=865 ,top=0 ,right=865 ,bottom=66 </L>
	<L> left=1664 ,top=0 ,right=1664 ,bottom=66 </L>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 </L>
	<L> left=1344 ,top=0 ,right=1344 ,bottom=66 </L>
	<L> left=2458 ,top=0 ,right=2458 ,bottom=66 </L>
	<L> left=2299 ,top=0 ,right=2299 ,bottom=66 </L>
	<L> left=2140 ,top=0 ,right=2140 ,bottom=66 </L>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=66 </L>
	<L> left=1823 ,top=0 ,right=1823 ,bottom=66 </L>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=66 </L>
	<L> left=2619 ,top=0 ,right=2619 ,bottom=66 </L>
	<L> left=40 ,top=0 ,right=40 ,bottom=66 </L>
	<C>id='SATNM', left=400, top=5, right=704, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=706 ,top=0 ,right=706 ,bottom=66 </L>
	<C>id='BGTMM01', left=712, top=5, right=863, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM02', left=873, top=5, right=1021, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM03', left=1032, top=5, right=1180, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM04', left=1191, top=5, right=1341, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM05', left=1349, top=5, right=1500, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM06', left=1508, top=5, right=1659, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM07', left=1670, top=5, right=1818, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM08', left=1828, top=5, right=1979, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM09', left=1987, top=5, right=2138, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM10', left=2146, top=5, right=2297, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM12', left=2466, top=5, right=2617, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM11', left=2307, top=5, right=2455, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2868 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=37 ,top=0 ,right=2813 ,bottom=0 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print2">
	<param name="DetailDataID"			value="gcds_print2">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2868 ,bottom=389 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��' ,left=1519 ,top=153 ,right=1588 ,bottom=230 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=378 ,right=2813 ,bottom=378 </L>
	<L> left=1590 ,top=161 ,right=2813 ,bottom=161 </L>
	<T>id='����' ,left=2572 ,top=103 ,right=2810 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=2328 ,top=103 ,right=2564 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ���' ,left=2085 ,top=103 ,right=2318 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1842 ,top=103 ,right=2074 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=1598 ,top=103 ,right=1831 ,bottom=159 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=98 ,right=2813 ,bottom=98 </L>
	<T>id='��������û�μ�������' ,left=1971 ,top=21 ,right=2416 ,bottom=85 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=201, top=331, right=1005, bottom=384, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� ��:' ,left=40 ,top=331 ,right=196 ,bottom=384 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û����:' ,left=40 ,top=275 ,right=196 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=185 ,right=847 ,bottom=185 </L>
	<T>id='��' ,left=1519 ,top=246 ,right=1588 ,bottom=325 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=98 ,right=1513 ,bottom=378 </L>
	<L> left=2566 ,top=98 ,right=2566 ,bottom=378 </L>
	<L> left=2323 ,top=98 ,right=2323 ,bottom=378 </L>
	<L> left=2077 ,top=98 ,right=2077 ,bottom=378 </L>
	<L> left=1834 ,top=98 ,right=1834 ,bottom=378 </L>
	<L> left=2813 ,top=98 ,right=2813 ,bottom=378 </L>
	<C>id='REQDT', left=201, top=275, right=450, bottom=328, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1590 ,top=98 ,right=1590 ,bottom=378 </L>
	<L> left=40 ,top=177 ,right=847 ,bottom=177 </L>
	<C>id='HTITLE', left=40, top=98, right=849, bottom=175, align='left' ,mask='XXXX�� ������� ��Ȳ(1��~12��)', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2868 ,bottom=103 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=3 ,right=2813 ,bottom=3 </L>
	<T>id='��������' ,left=48 ,top=8 ,right=392 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=3 ,right=40 ,bottom=101 </L>
	<L> left=394 ,top=3 ,right=394 ,bottom=101 </L>
	<L> left=865 ,top=3 ,right=865 ,bottom=101 </L>
	<L> left=1024 ,top=3 ,right=1024 ,bottom=101 </L>
	<L> left=1183 ,top=3 ,right=1183 ,bottom=101 </L>
	<L> left=1344 ,top=3 ,right=1344 ,bottom=101 </L>
	<L> left=1503 ,top=3 ,right=1503 ,bottom=101 </L>
	<L> left=1664 ,top=3 ,right=1664 ,bottom=101 </L>
	<L> left=1823 ,top=3 ,right=1823 ,bottom=101 </L>
	<L> left=1982 ,top=3 ,right=1982 ,bottom=101 </L>
	<L> left=2299 ,top=3 ,right=2299 ,bottom=101 </L>
	<L> left=2458 ,top=3 ,right=2458 ,bottom=101 </L>
	<L> left=2619 ,top=3 ,right=2619 ,bottom=101 </L>
	<L> left=2140 ,top=3 ,right=2140 ,bottom=101 </L>
	<L> left=2813 ,top=3 ,right=2813 ,bottom=101 </L>
	<L> left=40 ,top=101 ,right=2813 ,bottom=101 </L>
	<T>id='1��' ,left=712 ,top=8 ,right=863 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2625 ,top=8 ,right=2807 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=400 ,top=8 ,right=704 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=706 ,top=3 ,right=706 ,bottom=101 </L>
	<T>id='2��' ,left=873 ,top=8 ,right=1021 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3��' ,left=1032 ,top=8 ,right=1180 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4��' ,left=1191 ,top=8 ,right=1341 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5��' ,left=1349 ,top=8 ,right=1500 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6��' ,left=1508 ,top=8 ,right=1659 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7��' ,left=1670 ,top=8 ,right=1818 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8��' ,left=1828 ,top=8 ,right=1979 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9��' ,left=1987 ,top=8 ,right=2138 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10��' ,left=2146 ,top=8 ,right=2297 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12��' ,left=2466 ,top=8 ,right=2617 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11��' ,left=2307 ,top=8 ,right=2455 ,bottom=98 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2868 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=0 ,right=2813 ,bottom=0 </L>
	<C>id='ATKORNAM', left=48, top=5, right=392, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTSUM', left=2625, top=5, right=2807, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=394 ,top=0 ,right=394 ,bottom=66 </L>
	<L> left=1183 ,top=0 ,right=1183 ,bottom=66 </L>
	<L> left=1024 ,top=0 ,right=1024 ,bottom=66 </L>
	<L> left=865 ,top=0 ,right=865 ,bottom=66 </L>
	<L> left=1664 ,top=0 ,right=1664 ,bottom=66 </L>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 </L>
	<L> left=1344 ,top=0 ,right=1344 ,bottom=66 </L>
	<L> left=2458 ,top=0 ,right=2458 ,bottom=66 </L>
	<L> left=2299 ,top=0 ,right=2299 ,bottom=66 </L>
	<L> left=2140 ,top=0 ,right=2140 ,bottom=66 </L>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=66 </L>
	<L> left=1823 ,top=0 ,right=1823 ,bottom=66 </L>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=66 </L>
	<L> left=2619 ,top=0 ,right=2619 ,bottom=66 </L>
	<L> left=40 ,top=0 ,right=40 ,bottom=66 </L>
	<C>id='SATNM', left=400, top=5, right=704, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=706 ,top=0 ,right=706 ,bottom=66 </L>
	<C>id='BGTMM01', left=712, top=5, right=863, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM02', left=873, top=5, right=1021, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM03', left=1032, top=5, right=1180, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM04', left=1191, top=5, right=1341, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM05', left=1349, top=5, right=1500, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM06', left=1508, top=5, right=1659, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM07', left=1670, top=5, right=1818, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM08', left=1828, top=5, right=1979, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM09', left=1987, top=5, right=2138, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM10', left=2146, top=5, right=2297, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM12', left=2466, top=5, right=2617, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM11', left=2307, top=5, right=2455, bottom=66, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2868 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=37 ,top=0 ,right=2813 ,bottom=0 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print3">
	<param name="DetailDataID"			value="gcds_print3">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=436 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� �� �� �� Ȳ' ,left=1019 ,top=24 ,right=1844 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=53 ,top=437 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=61 ,top=381 ,right=177 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� :' ,left=53 ,top=230 ,right=148 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���࿹��' ,left=2561 ,top=381 ,right=2797 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=775 ,top=381 ,right=1461 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=53 ,top=368 ,right=53 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=185 ,top=370 ,right=185 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=370 ,right=2805 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=767 ,top=370 ,right=767 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2805 ,top=373 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⵵ :' ,left=53 ,top=283 ,right=148 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SFDCODE', left=159, top=233, right=400, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTYY', left=159, top=283, right=400, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û�μ� :' ,left=2260 ,top=283 ,right=2424 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTDIV', left=2434, top=233, right=2807, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTDPT', left=2434, top=283, right=2807, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2553 ,top=373 ,right=2553 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��û���� :' ,left=2260 ,top=233 ,right=2424 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2053 ,top=373 ,right=2053 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1471 ,top=376 ,right=1471 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2302 ,top=370 ,right=2302 ,bottom=431 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='������' ,left=2058 ,top=381 ,right=2294 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=2310 ,top=381 ,right=2545 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ�' ,left=1479 ,top=381 ,right=2045 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=193 ,top=381 ,right=759 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='BGTMM', left=61, top=0, right=175, bottom=48, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<C>id='REALBGT', left=2561, top=3, right=2797, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2805 ,top=0 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=185 ,top=0 ,right=185 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2553 ,top=0 ,right=2553 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SATNM', left=775, top=3, right=1461, bottom=45, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=767 ,top=0 ,right=767 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1471 ,top=0 ,right=1471 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ATKORNAM', left=193, top=0, right=759, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDBGT1', left=2310, top=3, right=2545, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2302 ,top=0 ,right=2302 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='BASICBGT', left=2058, top=3, right=2294, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2053 ,top=0 ,right=2053 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEPTNM', left=1479, top=3, right=2048, bottom=45, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1854 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print4 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print4">
	<param name="DetailDataID"			value="gcds_print4">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=436 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� �� �� �� Ȳ' ,left=1019 ,top=24 ,right=1844 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=53 ,top=437 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=61 ,top=381 ,right=177 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� :' ,left=53 ,top=230 ,right=148 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���࿹��' ,left=2561 ,top=381 ,right=2797 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=775 ,top=381 ,right=1461 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=53 ,top=368 ,right=53 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=185 ,top=370 ,right=185 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=370 ,right=2805 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=767 ,top=370 ,right=767 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2805 ,top=373 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⵵ :' ,left=53 ,top=283 ,right=148 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SFDCODE', left=159, top=233, right=400, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTYY', left=159, top=283, right=400, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û�μ� :' ,left=2260 ,top=283 ,right=2424 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTDIV', left=2434, top=233, right=2807, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTDPT', left=2434, top=283, right=2807, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2553 ,top=373 ,right=2553 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��û���� :' ,left=2260 ,top=233 ,right=2424 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2053 ,top=373 ,right=2053 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1471 ,top=376 ,right=1471 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2302 ,top=370 ,right=2302 ,bottom=431 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='������' ,left=2058 ,top=381 ,right=2294 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=2310 ,top=381 ,right=2545 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1479 ,top=381 ,right=2045 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û�μ�' ,left=193 ,top=381 ,right=759 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='BGTMM', left=61, top=0, right=175, bottom=48, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<L> left=2805 ,top=0 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=185 ,top=0 ,right=185 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2553 ,top=0 ,right=2553 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ATKORNAM', left=775, top=3, right=1461, bottom=45, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=767 ,top=0 ,right=767 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1471 ,top=0 ,right=1471 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEPTNM', left=193, top=0, right=759, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDBGT1', left=2310, top=3, right=2545, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2302 ,top=0 ,right=2302 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='BASICBGT', left=2058, top=3, right=2294, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2053 ,top=0 ,right=2053 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SATNM', left=1479, top=3, right=2048, bottom=45, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REALBGT', left=2561, top=3, right=2797, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1854 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ȸ����� - �ε��� �Ӵ� ���ް��� ����
+ ���α׷� ID	:  a050020.jsp
+ �� �� �� ��	:  �ε��� �Ӵ� ���ް��� ���� ���������� ���ε� �Ͽ� 
                              �ε��� �Ӵ� ���ް��� ����  ���̺� �����ϰ�, �� �����ͷ� ���� 
			      �ؽ�Ʈ ������ �����ϱ� ���� �����ޱ� �Ѵ�.
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2015.05.27
+ �� �� �� ��	:  excel_upload_t3, a050020_s1, a050020_t1
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
<title>�ε����Ӵ���ް��׸���</title>

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

var gs_frdt="";
var gs_todt="";
var gs_hf_gb="";  //�ݱⱸ��
var gs_hf_seq=""; //�ݱ⳻����



/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_saccyy.text    = gs_date2;	 //�⵵
	gclx_saccyyqt.index = 0;		 //���

	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
}

/******************************************************************************
	Description : ���� ���� ��ư �۾��� ����Data ==> Grid�� ���ε� ��               
******************************************************************************/
function ln_Excel_Apply(){
  	var s_temp = "";
	
	//������ �ʱ�ȭ ( ȭ�� Clear ) 
	gcds_head_a.clearAll();
	gcds_tail_b.clearAll();

   
	//����
	ln_Cnt_Setting();
	ln_SetDataHeader();

    //excel_upload ( grid�� ���� )
	gcds_excel.clearAll(); 
	gcds_excel_grid.clearAll();

    //dataSet head �����
    //���ϰ��
	s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
	gcds_excel.SetDataHeader(s_temp);

	gcds_excel.addrow();
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL")  = file_path.value;

	gctr_data_excel.KeyValue = "excel_upload_t3(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	//gctr_data_excel.Action = g_servlet+"/Account.excel_upload_t2?";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_t3?";
	gctr_data_excel.post();
	
}

/******************************************************************************************
	Description : ���̺� ������
******************************************************************************************/
function ln_Upload_Grid(){
	var strFDCODE=gclx_fdcode.bindcolval;
	var strRD_GB="ED";
	var strYYYY=gcem_saccyy.text;
	var strCO_CRNO="2218113834";
	var strRD_SEQ_GB="1";
 
    //EHDT002 �����̿� DATA �Է� 
	for(var i=1;i<=gcds_excel_grid.countrow;i++ ){
		gcds_excel_grid.namevalue(i,"FDCODE")=strFDCODE;
		gcds_excel_grid.namevalue(i,"RD_GB")=strRD_GB;
		gcds_excel_grid.namevalue(i,"YYYY")=strYYYY;
		gcds_excel_grid.namevalue(i,"HF_GB")=gs_hf_gb;
		gcds_excel_grid.namevalue(i,"HF_SEQ")=gs_hf_seq;
		gcds_excel_grid.namevalue(i,"CO_CRNO")=strCO_CRNO;
		gcds_excel_grid.namevalue(i,"RD_SEQ_GB")=strRD_SEQ_GB;
		gcds_excel_grid.namevalue(i,"RD_SEQ")=i;
		gcds_excel_grid.namevalue(i,"UND_YN")="";
		gcds_excel_grid.namevalue(i,"MINOR_NO")=gcem_s_bizplace.text;
	}

	//EHDT001 HEAD ���̺� �Է°� ����
	ln_Head_Setting(strFDCODE,"EH",strYYYY,strCO_CRNO );

	//EHDT003 Tail ���̺� �Է°� ����
    ln_Tail_Setting(strFDCODE,"ET",strYYYY,strCO_CRNO, strRD_SEQ_GB );
}


/******************************************************************************************
	Description : �б���� ���� �ͼӳ�� �ڵ�����
******************************************************************************************/
function ln_Cnt_Setting(){
	var gisu = gclx_saccyyqt.BindColVal;	//���
	var yyyy = gcem_saccyy.text;			//�⵵

	if(gisu=="1"){ 
		gs_frdt = yyyy+"0101";
		gs_todt = yyyy+"0331";
		gs_hf_gb ="1";
		gs_hf_seq="3";  //����
	}else if(gisu=="2"){
		gs_frdt = yyyy+"0401";
		gs_todt = yyyy+"0630";
		gs_hf_gb ="1";
		gs_hf_seq="6";  //Ȯ��
	}else if(gisu=="3"){
		gs_frdt = yyyy+"0701";
		gs_todt = yyyy+"0930";
		gs_hf_gb ="2";
		gs_hf_seq="3";  //����
	}else if(gisu=="4"){
		gs_frdt = yyyy+"1001";
		gs_todt = yyyy+"1231";
		gs_hf_gb ="2";
		gs_hf_seq="6";  //Ȯ��
	}
}

/******************************************************************************
	Description : Head(A,B ���̺�) ����  OK
******************************************************************************/
function ln_SetDataHeader(){
    var s_tmp1="";
	var s_tmp2="";
	var s_tmp3="";

	s_tmp1 = "FDCODE:STRING,RD_GB:STRING,YYYY:STRING,HF_GB:STRING,HF_SEQ:STRING,"
		   + "CO_CRNO:STRING,CO_NM:STRING,CO_RENM:STRING,CO_NO:STRING,CO_DT:STRING,"
		   + "PH_NO:STRING,SPACE:STRING,CREATE_ID:STRING,UPDATE_ID:STRING" ;
	gcds_head_a.SetDataHeader(s_tmp1);

	/** �� ������ ���� gcds_excel_grid�� ��ü�� 
	s_tmp2 = "FDCODE:STRING,RD_GB:STRING,YYYY:STRING,HF_GB:STRING,HF_SEQ:STRING,"
		   + "CO_CRNO:STRING,RD_SEQ_GB:DECIMAL,RD_SEQ:DECIMAL,FLOOR:STRING,FR_NO:STRING,"
		   + "AREA:DECIMAL,HI_NM:STRING,HI_CRNO:STRING,RE_IN_DT:STRING,RE_OUT_DT:STRING,"
		   + "RE_DEP_AMT:DECIMAL,RE_MON_AMT:DECIMAL,RE_SUM_AMT:DECIMAL,RE_DEP_INT_AMT:DECIMAL,RE_INCOME_AMT:DECIMAL,"
		   + "UND_YN:STRING,MINOR_NO:DECIMAL,COMPLEX:STRING,UP_DT:STRING,SPACE:STRING,"
		   + "CREATE_ID:STRING,UPDATE_ID:STRING";
	gcds_tail_b.SetDataHeader(s_tmp2);
	**/
	
	s_tmp3 = "FDCODE:STRING,RD_GB:STRING,YYYY:STRING,HF_GB:STRING,HF_SEQ:STRING,"
		   + "CO_CRNO:STRING,DATA_CNT:STRING,RD_SEQ_GB:STRING,RE_POSITION:STRING,RE_DEP_SUM:DECIMAL,"
		   + "RE_MON_SUM:DECIMAL,RE_SUM_SUM:DECIMAL,RE_DEP_INT_SUM:DECIMAL,RE_INCOME_SUM:DECIMAL,RE_CNT:DECIMAL,"
		   + "MINOR_NO:STRING,SPACE:STRING,CREATE_ID:STRING,UPDATE_ID:STRING" ;
	gcds_tail_b.SetDataHeader(s_tmp3);
 }


/******************************************************************************************
	Description : A ���̺� ����
	ln_Head_Setting(strFDCODE,"EH",strYYYY,strCO_CRNO );
******************************************************************************************/
function ln_Head_Setting(p1,p2,p3,p4){ 

	gcds_head_a.Addrow();
	gcds_head_a.namevalue(gcds_head_a.rowposition,"FDCODE")=p1;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"RD_GB")=p2;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"YYYY")=p3;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"HF_GB")=gs_hf_gb;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"HF_SEQ")=gs_hf_seq;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_CRNO")=p4;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_NM")="����ƻ� �ֽ�ȸ��";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_RENM")="�豹ȯ";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_NO")="1401110011714";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_DT")=gs_date;
    gcds_head_a.namevalue(gcds_head_a.rowposition,"PH_NO")="0236693921";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"SPACE")="";

}

/******************************************************************************************
	Description : B ���̺� ����
	ln_Tail_Setting(strFDCODE,"ET",strYYYY,strCO_CRNO, strRD_SEQ_GB );
******************************************************************************************/
function ln_Tail_Setting(p1,p2,p3,p4,p5){

	gcds_tail_b.Addrow();
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"FDCODE")=p1;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RD_GB")=p2;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"YYYY")=p3;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"HF_GB")=gs_hf_gb;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"HF_SEQ")=gs_hf_seq;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"CO_CRNO")=p4;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"DATA_CNT")=gcds_excel_grid.countrow;           // �ϴ� �Ѱ����� �ν� ( ���� Ȯ���ؾ���. )
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RD_SEQ_GB")=p5;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_POSITION")="�漺���� ȫ���� ȫ�ϸ� �泲��� 36 (���ش������ǽ���)";
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_DEP_SUM")=gcds_excel_grid.sum(10,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_MON_SUM")=gcds_excel_grid.sum(11,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_SUM_SUM")=gcds_excel_grid.sum(12,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_DEP_INT_SUM")=gcds_excel_grid.sum(13,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_INCOME_SUM")=gcds_excel_grid.sum(14,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_CNT")=gcds_excel_grid.countrow;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"MINOR_NO")=gcem_s_bizplace.text;
    gcds_tail_b.namevalue(gcds_tail_b.rowposition,"SPACE")="";
}

/******************************************************************************************
	Description : �ε����Ӵ���� DB INSERT
*****************************************************************************************/
function ln_Create(){

	if(gcds_head_a.IsUpdated) {	
		if (confirm("�ε����Ӵ���ް��׸���  �����͸� ���� �Ͻðڽ��ϱ�?")){	
			//gctr_data.KeyValue = "Account.a050020_t1(I:USER=gcds_head_a,I:USER2=gcds_tail_b,I:USER3=gcds_excel_grid)";
			
			gctr_data.KeyValue = "Account.a050020_t11(I:USER=gcds_head_a,I:USER2=gcds_tail_b,I:USER3=gcds_excel_grid)";
			
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_t11?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			
			//prompt('gcds_head_a',gcds_head_a.text);
            //prompt('gcds_tail_b',gcds_tail_b.text);
			//prompt('gcds_excel_grid',gcds_excel_grid.text);
			
			gctr_data.post();
		}
	}else{
		alert("�����Ͻ� ������ �����ϴ�.");
	}
}

/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
function ln_Query(e){
	var str1 = gclx_fdcode.bindcolval;		//�����
	var gisu = gclx_saccyyqt.BindColVal;	//���
	var stryy = gcem_saccyy.text;			//�⵵

	if(gcem_saccyy.text==""){
		alert("�⵵�� �Է��Ͻʽÿ�.");
		return;
	}
	 
	if(gisu=="1"){
		stryymm=stryy+"03";
		gs_hf_gb ="1";
		gs_hf_seq="3";  //����
	}else if(gisu=="2"){
    	stryymm=stryy+"06";
    	gs_hf_gb ="1";
		gs_hf_seq="6";  //Ȯ��
	}else if(gisu=="3"){
    	stryymm=stryy+"09";
    	gs_hf_gb ="2";
		gs_hf_seq="3";  //����
	}else if(gisu=="4"){
		stryymm=stryy+"12";
		gs_hf_gb ="2";
		gs_hf_seq="6";  //Ȯ��
	}

	//������ �ִ��� ��ȸ....������...�װ� ��ȸ ������ �����ؼ� ������..
	//head Record
	gcds_head_a.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s1?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;																																
	gcds_head_a.Reset();

	//tail Record
	gcds_tail_b.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s2?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;		
	gcds_tail_b.Reset();

	//data Recode 
    gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s3?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;		
	gcds_excel_grid.Reset();
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

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
 
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/


/******************************************************************************
	Description : �����ޱ�
******************************************************************************/
function ln_Download(){
  var strfilenm = "E2218113834.V120";
	if (gcds_data99.countrow<1) {
		alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	} else { 
		gcgd_data01.ExportFileEx(strfilenm,true,1,false);
 	}
}

/******************************************************************************
	Description : �����ޱ� ��ȸ 
******************************************************************************/
function ln_Down_Query(){
	var str1 = gclx_fdcode.bindcolval;		//����
	var gisu = gclx_saccyyqt.BindColVal;	//���
	var stryy = gcem_saccyy.text;			//�⵵
	var stryymm="";


	if(gcem_saccyy.text==""){
		alert("�⵵�� �Է��Ͻʽÿ�.");
		return;
	}

	if(gisu=="1"){
		stryymm=stryy+"03";
		gs_hf_gb ="1";
		gs_hf_seq="3";  //����
	}else if(gisu=="2"){
        stryymm=stryy+"06";
        gs_hf_gb ="1";
		gs_hf_seq="6";  //Ȯ��
	}else if(gisu=="3"){
        stryymm=stryy+"09";
        gs_hf_gb ="2";
		gs_hf_seq="3";  //����
	}else if(gisu=="4"){
		stryymm=stryy+"12";
		gs_hf_gb ="2";
		gs_hf_seq="6";  //Ȯ��
	}

    gcds_data99.clearAll();
	var s_temp = "DISKET:STRING";
	gcds_data99.SetDataHeader(s_temp);


	//������ �ִ��� ��ȸ....������...�װ� ��ȸ ������ �����ؼ� ������..

	//HEADER A(1��)
	gcds_down_head.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s1?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;	
	gcds_down_head.Reset();

	//TAIL SUM B(1��)
	gcds_down_tail.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s2?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;	
	gcds_down_tail.Reset();

    //DATA(N��)
	gcds_down_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s3?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;	
	gcds_down_data.Reset();

	ln_Display();
}


/******************************************************************************
	Description : �ڷ� �����ޱ� ȭ�� display
******************************************************************************/
function ln_Display(){

  for(i=1;i<=gcds_down_head.countrow;i++){
    ln_Forward_Batch_head(i);
  }
  
  for(i=1;i<=gcds_down_data.countrow;i++){
    ln_Forward_Batch_data(i);
  }

  for(i=1;i<=gcds_down_tail.countrow;i++){
    ln_Forward_Batch_tail(i);
  }
}

/******************************************************************************
	Description : head
******************************************************************************/
function ln_Forward_Batch_head(i){
	var DISKET = "";
	DISKET+=strStr(gcds_down_head.namevalue(i,"RD_GB")   ,"2");    //���ڵ汸��
	DISKET+=strStr(gcds_down_head.namevalue(i,"YYYY")    ,"4");    //�ͼӳ⵵
	DISKET+=strStr(gcds_down_head.namevalue(i,"HF_GB")   ,"1");    //�ݱⱸ��
	DISKET+=strStr(gcds_down_head.namevalue(i,"HF_SEQ")  ,"1");    //�ݱ⳻������
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_CRNO") ,"10");   //�����ڻ���ڵ�Ϲ�ȣ
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_NM")   ,"60");   //��ȣ(���θ�)
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_RENM") ,"30");   //����(��ǥ��)
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_NO")   ,"13");   //���ε�Ϲ�ȣ
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_DT")   ,"8");    //��������
	DISKET+=strStr(gcds_down_head.namevalue(i,"PH_NO")   ,"12");   //��������ȭ��ȣ
	DISKET+=strStr(gcds_down_head.namevalue(i,"SPACE")   ,"109");  //����

	gcds_data99.addrow();
	gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
Description :
             
******************************************************************************/
function ln_Forward_Batch_data(i){
	var DISKET = "";
	
	DISKET+=strStr(gcds_down_data.namevalue(i,"RD_GB")         ,"2");    //���ڵ汸��
	DISKET+=strStr(gcds_down_data.namevalue(i,"YYYY")          ,"4");    //�ͼӳ⵵
	DISKET+=strStr(gcds_down_data.namevalue(i,"HF_GB")         ,"1");    //�ݱⱸ��
	DISKET+=strStr(gcds_down_data.namevalue(i,"HF_SEQ")        ,"1");    //�ݱ⳻������
	DISKET+=strStr(gcds_down_data.namevalue(i,"CO_CRNO")       ,"10");   //�����ڻ���ڵ�Ϲ�ȣ  
	DISKET+=intStr(gcds_down_data.namevalue(i,"RD_SEQ_GB")     ,"6");    //�Ϸù�ȣ����
	DISKET+=intStr(gcds_down_data.namevalue(i,"RD_SEQ")        ,"6");    //�Ϸù�ȣ
	DISKET+=strStr(gcds_down_data.namevalue(i,"FLOOR")         ,"10");   //��
	DISKET+=strStr(gcds_down_data.namevalue(i,"FR_NO")         ,"10");   //ȣ��
	DISKET+=strStr(gcds_down_data.namevalue(i,"AREA")          ,"10");   //����
	DISKET+=strStr(gcds_down_data.namevalue(i,"HI_NM")         ,"30");   //�����λ�ȣ(����)
	DISKET+=strStr(gcds_down_data.namevalue(i,"HI_CRNO")       ,"13");   //�����λ���ڵ�Ϲ�ȣ
	DISKET+=strStr(gcds_down_data.namevalue(i,"RE_IN_DT")      ,"8");    //�Ӵ���������
	DISKET+=strStr(gcds_down_data.namevalue(i,"RE_OUT_DT")     ,"8");    //�Ӵ��������
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_DEP_AMT")    ,"13");   //�Ӵ��೻�뺸����
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_MON_AMT")    ,"13");   //�Ӵ��೻����Ӵ��
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_SUM_AMT")    ,"13");   //�Ӵ����Աݾװ�(����ǥ��)
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_DEP_INT_AMT"),"13");   //�Ӵ�Ẹ��������
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_INCOME_AMT") ,"13");   //�Ӵ����Աݿ��Ӵ��
	DISKET+=strStr(gcds_down_data.namevalue(i,"UND_YN")        ,"1");    //���Ͽ���
	DISKET+=intStr(gcds_down_data.namevalue(i,"MINOR_NO")      ,"4");    //��������Ϸù�ȣ
	DISKET+=strStr(gcds_down_data.namevalue(i,"COMPLEX")       ,"20");   //��
	DISKET+=strStr(gcds_down_data.namevalue(i,"UP_DT")         ,"8");    //������
	DISKET+=strStr(gcds_down_data.namevalue(i,"SPACE")         ,"33");   //����
	 
	gcds_data99.addrow();
	gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Forward_Batch_tail(i){
 
 	var DISKET = "";
 
 	DISKET+=strStr(gcds_down_tail.namevalue(i,"RD_GB")         ,"2");    //���ڵ汸��
	DISKET+=strStr(gcds_down_tail.namevalue(i,"YYYY")          ,"4");    //�ͼӳ⵵
	DISKET+=intStr(gcds_down_tail.namevalue(i,"HF_GB")         ,"1");    //�ݱⱸ��
	DISKET+=intStr(gcds_down_tail.namevalue(i,"HF_SEQ")        ,"1");    //�ݱ⳻������
	DISKET+=strStr(gcds_down_tail.namevalue(i,"CO_CRNO")       ,"10");   //�����ڻ���ڵ�Ϲ�ȣ  
	DISKET+=intStr(gcds_down_tail.namevalue(i,"DATA_CNT")      ,"7");    //Data�Ǽ�
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RD_SEQ_GB")     ,"6");    //�Ϸù�ȣ����
    DISKET+=strStr(gcds_down_tail.namevalue(i,"RE_POSITION")   ,"70");   //�ε��������
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_DEP_SUM")    ,"15");   //�Ӵ��೻�뺸�����հ�
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_MON_SUM")    ,"15");   //�Ӵ��೻��������հ�
    DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_SUM_SUM")    ,"15");   //�Ӵ����Աݾ��հ�
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_DEP_INT_SUM"),"15");   //�Դ����Ժ����������հ�
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_INCOME_SUM") ,"15");   //�Ӵ����Կ������հ�
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_CNT")        ,"6");    //�Ӵ�Ǽ�
	DISKET+=intStr(gcds_down_tail.namevalue(i,"MINOR_NO")      ,"4");    //��������Ϸù�ȣ
	DISKET+=strStr(gcds_down_tail.namevalue(i,"SPACE")         ,"64");   //����

	gcds_data99.addrow();
	gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}




/******************************************************************************
	Description : ����Ÿ�� ���� ó����.
******************************************************************************/
function strStr(a, b){
	 var returnVal = "";
	 if(a==null) a = "";
	 var alength = calculateBytes(a);
	 var tt = calculateBytesStr(a,b);
	
	 if(alength<=b){
	   returnVal+=a;
	   for(var i=0; i<b-alength; i++){
	     returnVal+=" ";
	   }
	 }else{
	   returnVal = tt;
	 }
	 return returnVal;
}

/******************************************************************************
	Description : ����Ÿ�� ���� 0���� ó����.
******************************************************************************/
function intStr(a, b){
 
	var tmpa = new String(a);
	var returnVal="";
	if(a==null) a="";
	var alength=tmpa.length;
	 
 	if(alength<b){
	    for(var i=0; i<b-alength; i++){
	       returnVal+="0";
	    }
	}
 	returnVal+=a;
 	return returnVal;
}

/******************************************************************************
	Description : �Ҽ��� ó����.

******************************************************************************/
function intDec(a, b, c){
  	var splitString="";
 	var tmpa = new String(a);
	var tmp="";
	var dec="";

	var returnVal="";
	if(a==null) a="";
  
	var alength=tmpa.length;
	splitString = tmpa.split('.');
	
    if(splitString[1]==undefined){ //alert("�Ҽ�����.");
		
		if(alength<b){
			for(var i=0; i<b-alength-c; i++){
				returnVal+="0";
			}
		}
		returnVal+=a;
		returnVal+="00"
	}else{  // alert("�Ҽ�����.");
  
		if(alength<=b){
			for(var i=0; i<b-alength+1; i++){
				returnVal+="0";
			}
		}
		returnVal+=splitString[0];
		returnVal+=splitString[1];
	}

  return returnVal;
}

/******************************************************************************
	Description : �Ҽ��� ó����.

******************************************************************************/
function intDec2(a, b, c){
    var splitString="";
 	
	var tmp="";
	var dec="";

  	var returnVal="";
  	if(a==null) a="";
 
  	var tmpa = new String(a);
  	var alength=tmpa.length;
  
 	splitString = tmpa.split('.');
  
  
	if(splitString[1]==undefined){
	   splitString[1]="0";
	} 
	
	
	if(splitString[1].length ==3){
	   a +="0";
	}else if(splitString[1].length ==2){
	   a +="00";
	}else if(splitString[1].length ==1){
	   a +="000";
	}else if(splitString[1].length ==0){
	   a +="0000"; 
	}

  
	tmpa = new String(a);
	alength=tmpa.length;
	 
	splitString = tmpa.split('.');
	if(splitString[1]==undefined){ //alert("�Ҽ�����.");
		if(alength<b){
			for(var i=0; i<b-alength-c; i++){
				returnVal+="0";
			}
		}
		returnVal+=a;
		returnVal+="00"
	}else{                                 // alert("�Ҽ�����.");  
	  		if(alength<=b){
			for(var i=0; i<b-alength+1; i++){
				returnVal+="0";
			}
		}
		returnVal+=splitString[0];
		returnVal+=splitString[1];
	}

  return returnVal;
}


/******************************************************************************
	Description : ����(-) ó�� ���
******************************************************************************/
function minorintStr(a, b){
  var returnVal="";
  if(a==null) a="";
  var temp = "";  
  var rst = "";
  if(a<0){
    a = strReplace(a, "-", "0");

    for(var k=0; k<a.length; k++){
      temp = a.charAt(k);
      if(k+1==a.length){
        temp=strReplace(temp, "0","}");
        temp=strReplace(temp, "1","J");
        temp=strReplace(temp, "2","K");
        temp=strReplace(temp, "3","L");
        temp=strReplace(temp, "4","M");
        temp=strReplace(temp, "5","N");
        temp=strReplace(temp, "6","O");
        temp=strReplace(temp, "7","P");
        temp=strReplace(temp, "8","Q");
        temp=strReplace(temp, "9","R");
      }
      rst += temp;
    }
  }else{
    rst = a;
  }

  var alength=rst.length;
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=rst;
  return returnVal;
}

/******************************************************************************
	Description : ����Ʈ ó�� 
******************************************************************************/
function calculateBytes(szValue){
  var tcount = 0;
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
    }
    else{
      tcount += 1;
    }
  }
  return tcount;
}

/******************************************************************************
	Description : ����Ʈ 
******************************************************************************/
function calculateBytesStr(szValue,b){
  var tcount = 0;
  var tstr = "";
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
      tstr += onechar;
    }
    else{
      tcount += 1;
      tstr += onechar;
    }
    if(tcount==b) break;
  }
  return tstr;
}

/******************************************************************************
	Description : ġȯ�ϱ�. 
******************************************************************************/
function strReplace(str, src, dest) {
  var reg = new RegExp(src, "gi");
  return str.replace(reg, dest);
}

/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("�ε����Ӵ���ް��׸���","",2);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--���� -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--���� -->
<object  id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�������ε� �� �׸��� DATA -->
<object  id=gcds_excel_grid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�׸��� Data�� Table�� insert HEAD -->
<object  id=gcds_head_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�׸��� Data�� Table�� insert Tail -->
<object  id=gcds_tail_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--��ȯ���� �����ޱ� -->
<object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_down_head classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_tail classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="gcds_head_a" event="onloadCompleted(row,colid)">
	//alert("gcds_head_a:row:"+row);
</script>

<script language="javascript" for="gcds_tail_b" event="onloadCompleted(row,colid)">
	//alert("gcds_tail_b:row:"+row);
</script>

<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	//alert("gcds_excel_grid:row:"+row);
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	
	gclx_fdcode.index =1;
	gclx_cocode.index =0;
	gcem_s_bizplace.text ="0003";
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("������ ������ ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("������ ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	ln_Upload_Grid();
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="950" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr><td height=20></td></tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:950px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="950px"> 
					<td width="100px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>��������</nobr></td>
					<td class="tab18" ><nobr>&nbsp;
							<input type="text" name="file_path" value="" style="width:630px;position:relative;top:-2px" >&nbsp;
							<comment id="__NSID__">
							<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="width:70;height:20;position:relative;top:2px;fontSize=8"  >
							<param name = "Text"		value="ã�ƺ���">
							</OBJECT>&nbsp;
							<img src="../../Common/img/btn/com_btn_exl_app.gif" style="cursor:hand;position:relative;top:2px"  onClick="ln_Excel_Apply()">
							<img src="../../Common/img/btn/com_b_create.gif"    style="cursor:hand;position:relative;top:2px"  onClick="ln_Create()">
							</comment><script>__ws__(__NSID__);</script>  
							</nobr>
					</td> 
				</tr>
			</table>
		</td>
	</tr>
  <tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object         id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
							    <param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
								<param name=Enable				value=false>
								<param name=ListExprFormat	    value="FDNAME^0^70">
								<param name=BindColumn			value="FDCODE">

							</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�����</nobr></td>
					<td class="tab23" style="width:190px">
						<comment id="__NSID__"><object          id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:1px;font-size:12px;width:50px;height:200px;">
								<param name=CBData				value="04^ȫ��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^70">
								<param name=BindColumn			value="CDCODE">
							</object>
							<font color="" style="position:relative;left:5px;top:-5px;" >�������</font>
							<object  id=gcem_s_bizplace classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:10px;top:2px">		
								<param name=Text		  value="0003">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;��</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�б��</nobr></td>
					<td style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1�⿹��,2^1��Ȯ��,3^2�⿹��,4^2��Ȯ��">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr><!--  ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��ȣ(���θ�)</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_co_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text			value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit     value="true">
									<param name=Language		value=1>
									<param name=ReadOnly        value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>����ڵ�Ϲ�ȣ</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_co_crno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:110px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=BackColor     value="#CCCCCC">
									<param name=Format			  value="000-00-00000">
									<param name=PromptChar	  value="_">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��ǥ�ڸ�</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object id=gcem_co_renm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text			value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit     value="true">
									<param name=Language		value=1>
									<param name=ReadOnly        value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>���ε�Ϲ�ȣ</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_co_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:110px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text		  value="">
									<param name=Border        value=true>
									<param name=PromptChar	  value="_">
									<param name=Format		  value="000000-0000000">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language	  value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><!-- ����2 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
						
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:948px;HEIGHT:335px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView        value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='�Ϸù�ȣ'	    ID=RD_SEQ	        HeadAlign=Center HeadBgColor=#B9D4DC Width=55	   	align=center	SumBgColor='#C3D0DB' SumText=@count	 </C> 
								<C> Name='��'  	        ID=COMPLEX 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30   	align=center	SumBgColor='#C3D0DB' SumText='��'	 </C>
								<C> Name='��'     	    ID=FLOOR  	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center	SumBgColor='#C3D0DB' SumText=''	     </C>
								<C> Name='ȣ��'	        ID=FR_NO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=30   	align=center	SumBgColor='#C3D0DB' </C>
								<C> Name='�Ӵ�\\����'	    ID=AREA  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB' </C>
							  <G> Name='������ �������� �� �Ӵ��� ��೻�� '          HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��ȣ'	    	ID=HI_NM 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumBgColor='#C3D0DB' SumText=''	 </C>
								<C> Name='����ڵ�Ϲ�ȣ'	ID=HI_CRNO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXX-XX-XXXXXX' </C>
								<C> Name='������'   	    ID=RE_IN_DT	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXXX-XX-XX' </C>
								<C> Name='������'     	ID=UP_DT            HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXXX-XX-XX' </C>
								<C> Name='�����'     	ID=RE_OUT_DT        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXXX-XX-XX' </C>
								<C> Name='������'	    	ID=RE_DEP_AMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
								<C> Name='���Ӵ��'	    ID=RE_MON_AMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
							  </G>
							  <G> Name='�Ӵ���Աݾ�(����ǥ��) '       HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�հ�'	    	ID=RE_SUM_AMT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
								<C> Name='���������ڰ�'	ID=RE_DEP_INT_AMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
								<C> Name='���Ӵ���'	    ID=RE_INCOME_AMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
							  </G>	
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:950px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	<tr>
    <td>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:173px;position:relative;left:5px;top:3px"><nobr><FONT SIZE="2" COLOR="blue"><B>[�����ޱ�]</B></FONT></nobr></td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_down.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Download()">
						<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Down_Query()"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td colspan =2>
						<comment id="__NSID__">
						<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:948px;height:220px;position:relative;left:5px;border:1 solid #777777;">
							<PARAM NAME="DataID"			VALUE="gcds_data99">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name=''	ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=920	align=left</C>
							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_head classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_head_a>
	<param name=BindInfo		value='  
		<C>Col=CO_NM			Ctrl=gcem_co_nm				Param=text</C>
		<C>Col=CO_CRNO			Ctrl=gcem_co_crno	    	Param=text</C>
		<C>Col=CO_RENM	        Ctrl=gcem_co_renm			Param=text</C>
		<C>Col=CO_NO	        Ctrl=gcem_co_no   			Param=text</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
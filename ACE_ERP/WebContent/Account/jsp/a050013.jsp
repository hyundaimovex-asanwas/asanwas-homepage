<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ȸ����� - �����������
+ ���α׷� ID	:  A050013.html
+ �� �� �� ��	:  ����������� ���������� ���ε� �Ͽ� 
                 ����������� ���̺� �����ϰ�, �� �����ͷ� ���� 
								 �ؽ�Ʈ ������ �����ϱ� ���� �����ޱ� �Ѵ�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 a050013_s1
-----------------------------------------------------------------------------
+ �� �� �� �� :	����������� �����ü�ۼ� ���� ( ��ȭ�ݾ� 13,2 -> 15,2 )         
+ ��   ��  �� : ��  ��  ��
+ �� �� �� �� :  2014.04.17
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�����������</title>

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
	gcem_saccyy.text    = gs_date2;	//�⵵
	gclx_saccyyqt.index = 0;				//���

	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
    gclx_sfdcode.index=0;

	if (gcds_data99.countrow<1){
    
  }
}

/******************************************************************************
	Description : ���� ���� ��ư �۾��� ����Data ==> Grid�� ���ε� ��               
******************************************************************************/
function ln_Excel_Apply(){
  var s_temp = "";
	
	//������ �ʱ�ȭ ( ȭ�� Clear ) 
	gcds_head_a.clearAll();
	gcds_data_b.clearAll();

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

	gctr_data_excel.KeyValue = "excel_upload_t2(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	//gctr_data_excel.Action = g_servlet+"/Account.excel_upload_t2?";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_t2?";

	gctr_data_excel.post();
}

/******************************************************************************************
	Description : C ���̺� ������
******************************************************************************************/
function ln_Upload_Grid(){
 var strFDCODE="02";
 var strDATADIV="C";
 var strACCYM=gs_todt.substring(0,6);
 var strRPTGB="3";
 var strVENDID="2218113834";
 
	for(var i=1;i<=gcds_excel_grid.countrow;i++ ){
		gcds_excel_grid.namevalue(i,"FDCODE")=strFDCODE;
		gcds_excel_grid.namevalue(i,"DATADIV")=strDATADIV;
		gcds_excel_grid.namevalue(i,"ACCYM")=strACCYM;
		gcds_excel_grid.namevalue(i,"RPTGB")=strRPTGB;
		gcds_excel_grid.namevalue(i,"VENDID")=strVENDID;
		gcds_excel_grid.namevalue(i,"SEQNO")=i;
	}

	//A ���̺� �Է°� ����
  ln_A_Setting(strFDCODE,"A",strACCYM,strRPTGB,strVENDID );

	//B ���̺� �Է°� ���� 
  ln_B_Setting(strFDCODE,"B",strACCYM,strRPTGB,strVENDID );
	//prompt('gcds_excel_grid',gcds_excel_grid.text);
	//prompt('gcds_head_a',gcds_head_a.text);
	//prompt('gcds_data_b',gcds_data_b.text);
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
	}else if(gisu=="2"){
		gs_frdt = yyyy+"0401";
		gs_todt = yyyy+"0630";
	}else if(gisu=="3"){
		gs_frdt = yyyy+"0701";
		gs_todt = yyyy+"0930";
	}else if(gisu=="4"){
		gs_frdt = yyyy+"1001";
		gs_todt = yyyy+"1231";
	}
}

/******************************************************************************
	Description : Head(A,B ���̺�) ����  OK
******************************************************************************/
function ln_SetDataHeader(){
    var s_tmp1="";
	var s_tmp2="";

	s_tmp1 = "FDCODE:STRING,DATADIV:STRING,ACCYM:STRING,RPTGB:STRING,VENDID:STRING,VENDNM:STRING,"
			    + "VDDIRECT:STRING,VDADDR:STRING,BSNSCND:STRING,BSNSKND:STRING,PERIOD:STRING,WRDT:STRING,FILLER:STRING";
	gcds_head_a.SetDataHeader(s_tmp1);

	s_tmp2 = "FDCODE:STRING,DATADIV:STRING,ACCYM:STRING,RPTGB:STRING,VENDID:STRING,"
			    + "CNT_SUM:DECIMAL,FOAMT_SUM:DECIMAL,KOAMT_SUM:DECIMAL,EXCNT:DECIMAL,EXFOAMT:DECIMAL,EXKOAMT:DECIMAL,"
				+ "ETCNT:DECIMAL,ETFOAMT:DECIMAL,ETKOAMT:DECIMAL,FILLER:STRING";
	gcds_data_b.SetDataHeader(s_tmp2);
 }


/******************************************************************************************
	Description : A ���̺� ����
******************************************************************************************/
function ln_A_Setting(p1,p2,p3,p4,p5){

	gcds_head_a.Addrow();
	gcds_head_a.namevalue(gcds_head_a.rowposition,"FDCODE")=p1;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"DATADIV")="A";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"ACCYM")=p3;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"RPTGB")=p4;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VENDID")=p5;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VENDNM")="����ƻ� �ֽ�ȸ��";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VDDIRECT")="�豹ȯ";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VDADDR")="���� ���� ������ ȭ�������� 10";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"BSNSCND")="���񽺰Ǽ���";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"BSNSKND")="��Ÿ������ϰ������»��";
    gcds_head_a.namevalue(gcds_head_a.rowposition,"PERIOD")=gs_frdt+gs_todt;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"WRDT")=gs_todt;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"FILLER")="";

}

/******************************************************************************************
	Description : B ���̺� ����
******************************************************************************************/
function ln_B_Setting(p1,p2,p3,p4,p5){

	gcds_data_b.Addrow();
	gcds_data_b.namevalue(gcds_data_b.rowposition,"FDCODE")=p1;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"DATADIV")="B";
	gcds_data_b.namevalue(gcds_data_b.rowposition,"ACCYM")=p3;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"RPTGB")=p4;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"VENDID")=p5;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"CNT_SUM")=gcds_excel_grid.countrow;           // �ϴ� �Ѱ����� �ν� ( ���� Ȯ���ؾ���. )
	gcds_data_b.namevalue(gcds_data_b.rowposition,"FOAMT_SUM")=gcds_excel_grid.sum(5,0,0);
	gcds_data_b.namevalue(gcds_data_b.rowposition,"KOAMT_SUM")=gcds_excel_grid.sum(6,0,0);
	gcds_data_b.namevalue(gcds_data_b.rowposition,"EXCNT")=gcds_excel_grid.countrow;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"EXFOAMT")=gcds_excel_grid.sum(5,0,0);
    gcds_data_b.namevalue(gcds_data_b.rowposition,"EXKOAMT")=gcds_excel_grid.sum(6,0,0);
    gcds_data_b.namevalue(gcds_data_b.rowposition,"ETCNT")=0;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"ETFOAMT")=0;
    gcds_data_b.namevalue(gcds_data_b.rowposition,"ETKOAMT")=0;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"FILLER")="";
}

/******************************************************************************************
	Description : ����������� DB INSERT
*****************************************************************************************/
function ln_Create(){

	if(gcds_head_a.IsUpdated) {	
		if (confirm("����������� �����͸� ���� �Ͻðڽ��ϱ�?")){	
			gctr_data.KeyValue = "Account.a050013_t1(I:USER=gcds_head_a,I:USER2=gcds_data_b,I:USER3=gcds_excel_grid)";
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_t1?";

			//prompt('gcds_head_a',gcds_head_a.text);
      //prompt('gcds_data_b',gcds_data_b.text);
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

	var str1 = gclx_sfdcode.BindColVal;		//�����
	var str21 = "A";					//�⵵
	var str22 = "B";					//�⵵
    var str23 = "C";					//�⵵
	var gisu = gclx_saccyyqt.BindColVal;	//���
	var stryy = gcem_saccyy.text;					//�⵵
	var stryymm="";


	if(gcem_saccyy.text==""){
		alert("�⵵�� �Է��Ͻʽÿ�.");
		return;
	}

	if(gisu=="1"){
		stryymm=stryy+"03";
	}else if(gisu=="2"){
    stryymm=stryy+"06";
	}else if(gisu=="3"){
    stryymm=stryy+"09";
	}else if(gisu=="4"){
		stryymm=stryy+"12";
	}


	//������ �ִ��� ��ȸ....������...�װ� ��ȸ ������ �����ؼ� ������..
	//A Record
	gcds_head_a.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s1?v_str1="+str1
																									        +"&v_str2="+str21
																									        +"&v_str3="+stryymm;			
  //prompt('',gcds_head_a.DataID);																													
	gcds_head_a.Reset();

	//B Record
	gcds_data_b.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s2?v_str1="+str1
																										      +"&v_str2="+str22
																										      +"&v_str3="+stryymm;
  //prompt('',gcds_data_b.DataID);
	gcds_data_b.Reset();

	//C Recode 
  gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s3?v_str1="+str1
																										          +"&v_str2="+str23
																										          +"&v_str3="+stryymm;
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
  var strfilenm = "A2218113.834";
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
	var str1 = gclx_sfdcode.BindColVal;		//�����
	var str21 = "A";				     
	var str22 = "B";	
	var str23 = "C";	//
	var gisu = gclx_saccyyqt.BindColVal;	//���
	var stryy = gcem_saccyy.text;					//�⵵
	var stryymm="";


	if(gcem_saccyy.text==""){
		alert("�⵵�� �Է��Ͻʽÿ�.");
		return;
	}

	if(gisu=="1"){
		stryymm=stryy+"03";
	}else if(gisu=="2"){
    stryymm=stryy+"06";
	}else if(gisu=="3"){
    stryymm=stryy+"09";
	}else if(gisu=="4"){
		stryymm=stryy+"12";
	}

  gcds_data99.clearAll();
	var s_temp = "DISKET:STRING";
	gcds_data99.SetDataHeader(s_temp);


	//������ �ִ��� ��ȸ....������...�װ� ��ȸ ������ �����ؼ� ������..

	//HEADER A(1��)
	gcds_down_head.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s1?v_str1="+str1+"&v_str2="+str21+"&v_str3="+stryymm;
	gcds_down_head.Reset();

	//SUM B(1��)
	gcds_down_b.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s2?v_str1="+str1+"&v_str2="+str22+"&v_str3="+stryymm;
	gcds_down_b.Reset();

  //DATA(N��)
	gcds_down_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s3?v_str1="+str1+"&v_str2="+str23+"&v_str3="+stryymm;
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

  for(i=1;i<=gcds_down_b.countrow;i++){
    ln_Forward_Batch_B(i);
  }

  for(i=1;i<=gcds_down_data.countrow;i++){
    ln_Forward_Batch_data(i);
  }
}


/******************************************************************************
	Description : head
******************************************************************************/
function ln_Forward_Batch_head(i){
  var DISKET = "";
	DISKET+=strStr(gcds_down_head.namevalue(i,"DATADIV") ,"1");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"ACCYM")   ,"6");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"RPTGB")   ,"1");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VENDID")  ,"10");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VENDNM")  ,"30");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VDDIRECT"),"15");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VDADDR")  ,"45");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"BSNSCND") ,"17");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"BSNSKND") ,"25");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"PERIOD")  ,"16");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"WRDT")    ,"8");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"FILLER")  ,"6");   //
  
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Forward_Batch_B(i){
 
  var DISKET = "";
 
  
	DISKET+=strStr(gcds_down_b.namevalue(i,"DATADIV")  ,"1");     //
	DISKET+=strStr(gcds_down_b.namevalue(i,"ACCYM")    ,"6");     //
    DISKET+=strStr(gcds_down_b.namevalue(i,"RPTGB")    ,"1");     //
	DISKET+=strStr(gcds_down_b.namevalue(i,"VENDID")   ,"10");    //
	DISKET+=intStr(gcds_down_b.namevalue(i,"CNT_SUM")  ,"7");     //
    DISKET+=intDec(gcds_down_b.namevalue(i,"FOAMT_SUM"),"15","2");//
	DISKET+=intStr(gcds_down_b.namevalue(i,"KOAMT_SUM"),"15");    //
	DISKET+=intStr(gcds_down_b.namevalue(i,"EXCNT")    ,"7");     //
	DISKET+=intDec(gcds_down_b.namevalue(i,"EXFOAMT")  ,"15","2");//
	DISKET+=intStr(gcds_down_b.namevalue(i,"EXKOAMT")  ,"15");    //
	DISKET+=intStr(gcds_down_b.namevalue(i,"ETCNT")    ,"7");     //
	DISKET+=intDec(gcds_down_b.namevalue(i,"ETFOAMT")  ,"15","2");//
	DISKET+=intStr(gcds_down_b.namevalue(i,"ETKOAMT")  ,"15");    //
	DISKET+=strStr(gcds_down_b.namevalue(i,"FILLER")   ,"51");    //

  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description :
	             
******************************************************************************/
function ln_Forward_Batch_data(i){
  var DISKET = "";
  
  
     //if(i>=132){
      //alert("i:::"+i+"::EXCHANGE::",gcds_down_data.namevalue(i,"EXCHANGE"));
      //intDec2(gcds_down_data.namevalue(i,"EXCHANGE"),"9","4");
    // }
    
	DISKET+=strStr(gcds_down_data.namevalue(i,"DATADIV") ,"1");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"ACCYM")   ,"6");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"RPTGB")   ,"1");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"VENDID")  ,"10");    //
	DISKET+=intStr(gcds_down_data.namevalue(i,"SEQNO")   ,"7");     //
	DISKET+=intStr(gcds_down_data.namevalue(i,"EXPTNO")  ,"15");    //
	DISKET+=strStr(gcds_down_data.namevalue(i,"SHIPDT")  ,"8");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"CURRCD")  ,"3");     //
	DISKET+=intDec2(gcds_down_data.namevalue(i,"EXCHANGE"),"9","4"); //
	DISKET+=intDec(gcds_down_data.namevalue(i,"FOAMT")   ,"15","2");//
	DISKET+=intStr(gcds_down_data.namevalue(i,"KOAMT")   ,"15");    //
	DISKET+=strStr(gcds_down_data.namevalue(i,"FILLER")  ,"90");    //
	 
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
  //var alength=a.length;
	
	var alength=tmpa.length;
  
  //alert("tmpa"+tmpa);
  
  //alert("alength::"+tmpa.length);

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
  //var alength=a.length;
	
	var alength=tmpa.length;
  
  // alert("tmpa"+tmpa);
 //  alert("alength::"+tmpa.length);
  
	splitString = tmpa.split('.');
	/**
    alert("splitString[0].length::"+splitString[0].length);
	//alert("splitString[1]::"+splitString[1]);
	
    if(splitString[0].length ==alength){
  	  a +="00";
    }else{
      if(splitString[1].length ==1){
        a +="0"; 
      }
    }
    **/
  	
  	
   // tmpa = new String(a);
   // alength=tmpa.length;
    
    //alert("222tmpa"+tmpa);
    
    //alert("222alength"+alength);
	
	

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


  /**
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;
	**/

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
  //var alength=a.length;
  
  //alert("a:::"+a);
	
  var tmpa = new String(a);
  var alength=tmpa.length;
  
  splitString = tmpa.split('.');
  //alert("splitString[0]::"+splitString[0]);
  //alert("splitString[1]::"+splitString[1]);
	
  
  //�Ҽ��� ���ڸ��� ��� �������� ��� 0�� ����.	
  
  
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
  
  //alert("tmpa22::"+tmpa);
  //alert("alength22::"+tmpa.length);
  
  
 
 //alert("2splitString[0]::"+splitString[0]);
 //alert("2splitString[1]::"+splitString[1]);
  
  //alert("b::"+b+"::alength::"+alength);

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


  /**
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;
	**/

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

	gcgd_disp01.GridToExcel("�ſ�ī��������","",2);
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

<object  id=gcds_excel_grid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>



<object  id=gcds_head_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data_c classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<!--�Է°���  -->
<object  id=gcds_ihead classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�����ޱ� -->
<object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_down_head classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<script language="javascript" for="gcds_data_c" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data_c" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
//		gclx_sfdcode.index=2;
	}else{
//		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
		if (fn_trim(gcip_file.value)!="") {
				//alert("gcip_file::::"+gcip_file.value);
				file_path.value = gcip_file.value;
		}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
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
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050013_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
	<tr><td height=4></td></tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:869px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="869px"> 
					<td width="102px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>��������</nobr></td>
					<td class="tab18" ><nobr>&nbsp;
							<input type="text" name="file_path" value="" style="width:556px;position:relative;top:-2px" >&nbsp;
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
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�����</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
								<param name=CBData					value="02^����,01^��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^70">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;��&nbsp;��&nbsp;</nobr></td>
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
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��ȣ(���θ�)</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit value="true">
									<param name=Language		value=1>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>����ڵ�Ϲ�ȣ</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
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
								<object  id=gcem_vddirect classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:230px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>����������</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vdaddr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:380px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
                  <param name=GeneralEdit   value="true">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><!-- ����2 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>�ŷ��Ǽ�</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;ȭ</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;ȭ</nobr></td>
							<td class="tab13" style="width:173px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;"><nobr>��&nbsp;��&nbsp;��</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_cnt_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_foamt_sum  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_koamt_sum  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							 <td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
             <tr>
              <td class="tab11" style="width:173px;"><nobr>�����ϴ���ȭ</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_excnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_exfoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_exkoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;"><nobr>��Ÿ������</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_etcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_etfoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_etkoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:220px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView  value="Left">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='�Ϸù�ȣ'	      ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	   	align=center	SumText=@count	SumBgColor='#C3D0DB' </C> 
								<C> Name='����Ű��ȣ'  	ID=EXPTNO 	HeadAlign=Center HeadBgColor=#B9D4DC Width=170  	align=center	SumText='��'	  SumBgColor='#C3D0DB' sort=true mask='XXX-XX-XX-XXXXXXXX'  </C>
								<C> Name='������'     		ID=SHIPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 	  align=center	SumText=''	    SumBgColor='#C3D0DB' sort=true mask='XXXX-XX-XX' </C>
								<C> Name='��ȭ����'	      ID=CURRCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=105  	align=center	SumBgColor='#C3D0DB' sort=true </C>
							  <G> Name='����ݾ�'       HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��ȭ'	    		  ID=FOAMT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=130		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='��ȭ'	    	    ID=KOAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=130		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='ȯ��'   	      ID=EXCHANGE	HeadAlign=Center HeadBgColor=#B9D4DC Width=130 		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true </C>
							  </G>
								<C> Name='����'   	      ID=FDCODE	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='�ڷᱸ��'	      ID=DATADIV  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='�ͼӳ��'   	  ID=ACCYM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='�Ű���'   	  ID=RPTGB	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='����ڵ�Ϲ�ȣ' ID=VENDID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='�Ϸù�ȣ'   	  ID=SEQNO	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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
						<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:867px;height:160px;position:relative;left:5px;border:1 solid #777777;">
							<PARAM NAME="DataID"			VALUE="gcds_data99">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name=''	ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=843	align=left</C>
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
		<C>Col=VENDNM			Ctrl=gcem_vendnm				Param=text</C>
		<C>Col=VENDID			Ctrl=gcem_vendid				Param=text</C>
		<C>Col=VDDIRECT	  Ctrl=gcem_vddirect			Param=text</C>
		<C>Col=VDADDR	    Ctrl=gcem_vdaddr  			Param=text</C>
	'>
</object>


<object  id=gcbn_data_b classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data_b>
	<param name=BindInfo		value='  
		<C>Col=CNT_SUM  			Ctrl=gcem_cnt_sum  				Param=text</C>
		<C>Col=FOAMT_SUM			Ctrl=gcem_foamt_sum				Param=text</C>
		<C>Col=KOAMT_SUM			Ctrl=gcem_koamt_sum				Param=text</C>
		<C>Col=EXCNT    			Ctrl=gcem_excnt    				Param=text</C>
		<C>Col=EXFOAMT  			Ctrl=gcem_exfoamt  				Param=text</C>
		<C>Col=EXKOAMT  			Ctrl=gcem_exkoamt  				Param=text</C>
		<C>Col=ETCNT    			Ctrl=gcem_etcnt    				Param=text</C>
		<C>Col=ETFOAMT  			Ctrl=gcem_etfoamt  				Param=text</C>
		<C>Col=ETKOAMT  			Ctrl=gcem_etkoamt  				Param=text</C>
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
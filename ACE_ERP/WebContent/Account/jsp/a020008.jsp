<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - ��ǥ����	
+ ���α׷� ID	:  A020001.html
+ �� �� �� ��	:  ��ǥ�� �Է�/��ȸ �ϴ� ȭ���̴�
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ��ǥ���� ����  
+ ��   ��  �� :  �� �� �� 
+ �� �� �� �� :  2010.
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ��ǥ��ȸ ���� ���� - �����ϴ� ���������� ����, ��� ������ ����.
                                      ������ ���� ��û���¿��� ����, �ڱ�, ȸ��� ���е�.
+ ��   ��  �� :  �� �� �� 
+ �� �� �� �� :  2010.11.19
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��ǥ��ȸ</title>

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

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
get_cookdata();
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var gs_InsGubun=""; //��ȸ�� ��� ����
var gs_dept2="";    //�渮���úμ�

var gstrempno="";
var gstrdeptcd="";
var gstrGubun ="";
var gstrAuthgr="";


function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
	//prompt('',gcds_dept.DataID);
	gcds_dept.Reset();
  
	ln_Before();
	gclx_fsstat.bindcolval="A";
	gcem_fsdat_fr.text=gs_date.substring(0,6)+"01";
	gcem_fsdat_to.text=gs_date; 
 
	
	//alert("gfdcode::"+gfdcode);
	//alert("gs_deptcd::::"+gs_deptcd);
	//�渮���úμ��� �������.
	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){
     		gclx_fdcode.bindcolval=gs_fdcode;
			gs_dept2="true";
	}else{
		    gclx_fdcode.bindcolval=gs_fdcode;
			gclx_fdcode.Enable=false;
			gs_dept2="false";
	}

  //2010.03.24 JYS ���� ��ȸ���� ( ������ȸ �ű����̺� ����)
	ln_Query_Authority2();
}


/******************************************************************************
 ��ȸ���� �ű�
******************************************************************************/
function ln_Query_Authority2(){
  //2010.03.24 JYS �μ��� ���� ���� ��Ŵ
  /*********************************************
	if(gs_dept2=="true"){
			//gstrGubun="A";  //ȸ�� or �繫���� ��츸 
     gstrGubun="";
	}else{
		 gstrGubun="";
	}
	*********************************************/
	gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2="+gs_userid+"&v_str3=a0200010&v_str4=Y";
	//prompt('',gcds_empno_chk.DataID);
	gcds_empno_chk.Reset();
}


/******************************************************************************
 ��ȸ���� ��� return 
******************************************************************************/
function ln_Authority_Result(row,colid){
  var cnt=0;
  gstrempno="'"+gs_userid+"',";

	if(row>0){
    //���ѱ׷�
		gstrAuthgr=gcds_empno_chk.namevalue(row,"AUTHGR");
    	//�μ�(6-14), ���(15-19)
		//�μ�(6-25), ���(26-30)
    	for(i=6;i<=30;i++){
			if(i<=25){		  
				if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //�μ����� 
					cnt+=1;
					gstrdeptcd+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}			
			}

			if(i>=26){
       			if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //������� 
					gstrempno+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"
				}
			}
		}

		if(cnt>0){
			gstrdeptcd=gstrdeptcd.substring(0,gstrdeptcd.length-1);
		}
	}
	
	gstrempno=gstrempno.substring(0,gstrempno.length-1);

	if(gstrAuthgr=="A"){
		gstrGubun = gstrAuthgr;
	}else{
		gstrGubun="";
	}
}

/******************************************************************************
	Description : ��ȸ
	parameter   : p - 01:��ǥ ��ȸ
	                  02:��ǥ DETAIL ��ȸ - ��ǥ��ȣ��
					  03:��ǥ �Է�ȭ�鿡�� Master�� Dtl ��ȸ

  ����        : ��ǥ DETAIL ��ȸ - ��ǥ��ȣ�� (������ȣ�� 000000 �� ���� ��������+��ǥ��ȣ�θ� ��ȸ��.)
******************************************************************************/
function ln_Query(p){

	 if (p=='01'){		
			gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s1?v_str1="+gs_fdcode
																				 +"&v_str2="+gcem_fsdat_fr.text
																				 +"&v_str3="+gcem_fsdat_to.text
																				 +"&v_str4="+gstrdeptcd
																				 +"&v_str5="+gstrGubun
																				 +"&v_str6="+gclx_fsstat.bindcolval
																				 +"&v_str7="+txt_remark.value
																				 +"&v_str8="+gclx_fdcode.bindcolval
																				 +"&v_str9="+gclx_togb.bindcolval
																				 +"&v_str10="+gstrempno;
			//prompt("",gcds_data01.DataID );																							
			gcds_data01.Reset();
	  }
}



/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : �ڵ� �۾�
******************************************************************************/
function ln_Before() {

  	//��������
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();

    //��������2
	gcds_comfield02.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield02.Reset();

	//��������(ȸ������ �����ڵ�)
	gcds_comcode01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=1155";
	//prompt("",gcds_comcode01.DataID);
	gcds_comcode01.Reset();

	//�����ڵ� �����ڵ�
	gcds_code01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s0?"; 
	//prompt("gcds_code01",gcds_code01.DataID);
	gcds_code01.Reset();

}



/******************************************************************************
	Description : ����� üũ�ڽ��� ��ȯ
	prameter : 
******************************************************************************/
function ln_Chkbox(){

}

/******************************************************************************
	Description : �����ڵ� ã��
	parameter   : p1 - ����,  01-��ǥ�ϰ� ����(���� ==> ��ǥ)
	                          02-����
														03-�����׸�
	              p2 - Data, row - grid�� rowposition
******************************************************************************/
function ln_Popup(p1,p2,row){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if ((p1=="01")) {
		strURL = "./commiface_popup.jsp";
		arrParam[0]="";
		strPos = "dialogWidth:878px;dialogHeight:490px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcds_data02.namevalue(row,"ATCODE")=arrResult[0];
			gcds_data02.namevalue(row,"ATKORNAM")=arrResult[1];
			gcds_data02.namevalue(row,"ATDECR")=arrResult[2];

		} else {
			gcds_data02.namevalue(row,"ATCODE")="";
			gcds_data02.namevalue(row,"ATKORNAM")="";
			gcds_data02.namevalue(row,"ATDECR")="";

			gcds_data02.namevalue(row,"REMARK")=""
			gcds_data02.namevalue(row,"CHAAMT")="0";
			gcds_data02.namevalue(row,"DAEAMT")="0";
		}

	}else if (p1=="02"){
		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN" 
		arrParam[1]=p2;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcds_data02.namevalue(row,"ATCODE")=arrResult[0];
			gcds_data02.namevalue(row,"ATKORNAM")=arrResult[1];
			gcds_data02.namevalue(row,"ATDECR")=arrResult[2];
		} else {
			gcds_data02.namevalue(row,"ATCODE")="";
			gcds_data02.namevalue(row,"ATKORNAM")="";
			gcds_data02.namevalue(row,"ATDECR")="";

			gcds_data02.namevalue(row,"REMARK")=""
			gcds_data02.namevalue(row,"CHAAMT")="0";
			gcds_data02.namevalue(row,"DAEAMT")="0";
		}

		//ln_Grid_Property("02",arrResult[2]);��ǥ�Է��� ���� ������� ������ ���� ����, �뺯 �������� ����.
	
	}else if(p1=="03"){
		strURL = "./slipref_popup.jsp";
		arrParam[0]=p2;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcds_data04.namevalue(row,"FSREFVAL")=arrResult[0];
			gcds_data04.namevalue(row,"FSREFVALNM")=arrResult[1];
		} else {
			gcds_data04.namevalue(row,"FSREFVAL")="";
			gcds_data04.namevalue(row,"FSREFVALNM")="";
		}
	}else if (p1=="09"){
		strURL = "./slipno_loca_popup.jsp";    
		if(gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE")!=undefined){
			arrParam[0]=gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE"); 
			arrParam[1]=gcds_data01.namevalue(gcds_data01.rowposition,"FSDAT"); 
			arrParam[2]=gcds_data01.namevalue(gcds_data01.rowposition,"FSNBR"); 	
		}else{
			arrParam[0]=gclx_fdcode02.bindcolval; 
			arrParam[1]=gcem_fs02.text+gcem_fsdat02.text; 
			arrParam[2]=gcem_fsnbr02.text; 	
		}

		strPos = "dialogWidth:800px;dialogHeight:425px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
   	

	}else if (p1=="ADD"){
	  arrParam[0]=gcds_data01.namevalue(row,"FDCODE");
		arrParam[1]=gcds_data01.namevalue(row,"FSDAT1");
		arrParam[2]=gcds_data01.namevalue(row,"FSDAT2");
		arrParam[3]=gcds_data01.namevalue(row,"FSNBR");

		strURL = "./a020009_popup.jsp";   
		strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
	}
}

/******************************************************************************
	Description : ���� �˾�
	parameter   : 
******************************************************************************/
function ln_Popup_Confirm(){

	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var row ="";

  	for(i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			row=i;
		}
	}

	if(row==""){
		alert("�����û �Ͻ� ����Ÿ�� �����Ͻʽÿ�.");
		return;
	}

	gcds_dtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s7f?v_str1="+gcds_data01.namevalue(row,"FDCODE")
																		 +"&v_str2="+gcds_data01.namevalue(row,"FSDAT")
																		 +"&v_str3="+gcds_data01.namevalue(row,"FSNBR")
																		 +"&v_str4="
																		 +"&v_str5=";																								 
	gcds_dtl.Reset(); 


  if(gcds_dtl.countrow<2){
	  alert("��ǥ���°� �����û �� �� �����ϴ�.");
		return false;
	}

	if (gcds_dtl.namevalue(1,"FSSTAT")!="B"&&gcds_dtl.namevalue(1,"FSSTAT")!="N"){ //Y-����Ϸ�,C-�������, N-������, R-�����û, B-�ݼ�
		alert("��ǥ���°� �����û �� �� �����ϴ�.");
		return;
	}

	strURL = "./confirm_popup_new.jsp";
	strPos = "dialogWidth:330px;dialogHeight:180px;status:no;scroll:no;resizable:no";

	result = showModalDialog(strURL,window,strPos);
	//return result;
	if (result != null) {
		arrResult = result.split(";");
		gcds_confirm.ClearData();
		if (arrResult[1]= "Y" ){ //���������
			ln_Confirm_Save(arrResult[0],arrResult[3],arrResult[4]); //������, ȸ��(����)���� 01 ȸ��, 02����, 03 �ڱ� ,  Y -ȸ������ ����
		}
	}
}


/******************************************************************************
	Description : �ָ�����
	parameter   : 
******************************************************************************/
function ln_Multi_Confirm(){
  
	  alert("�۾����Դϴ�.");
		return;
	  if(gcds_confirm.countrow<=0){
			ln_SetDataHeader("CONFIRM");
		}

		for(k=1;k<=gcds_data01.countrow;k++){
		  if(gcds_data01.namevalue(k,"CHK")=="T"){
				gcds_confirm.addrow();
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=gcds_data01.namevalue(k,"FDCODE"); 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=gcds_data01.namevalue(k,"FSDAT");  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=gcds_data01.namevalue(k,"FSNBR");  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=""; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")="";      //������
				gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= "";        //�۾���(�����û�ڿ� �Է��ڱ����ؾ���.)
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") ="";  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="01"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") =""; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"BGTGB")=""; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  

				if (confirm("�����û �Ͻðڽ��ϱ�?")){	
					gctr_data07.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t7?";
					//prompt("gcds_confirm",gcds_confirm.text);
					gctr_data07.post();
				}
		  }
		}
}

/******************************************************************************
	Description : ����� ����
	parameter   :  p - ������ ���
	               p1 - ȸ��/ ���� / �ڱ�  ���� 01/02/03   
								 p2 - ȸ������ ����� ��ǥ��Ͽ��� ��(Y)
******************************************************************************/
function ln_Confirm_Save(p,p1,p2){
		var row = gcds_data01.rowposition;
		var strfdcode="";
		var strfsdat="";
		var strfsnbr="";
		var strempno="";
    	var strtogb="";

		if (p1=="01"){        //ȸ��
			strtogb="03";       //�����ϰ��� 02 �� �����ؾ���.
    	}else if(p1=="02"){   //����
      		strtogb="02";
		}else if(p1=="03"){   //�ڱ�
      		strtogb="06";
		}

		ln_SetDataHeader("CONFIRM");

		//�α����ڿ� ����� ���ؾ���.
		if(gcds_data01.namevalue(row,"EMPNO")!=gs_userid){
			alert("����ڸ��� �����û �� �� �ֽ��ϴ�.");
      		return false;
		}

    	gcds_confirm.addrow();
    	gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=gcds_data01.namevalue(row,"FDCODE"); 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=gcds_data01.namevalue(row,"FSDAT");
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=gcds_data01.namevalue(row,"FSNBR");
		gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")=p;      //������
		gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= gcds_data01.namevalue(row,"EMPNO");  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") ="";  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="01"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") =strtogb; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BGTGB")=p2; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gs_date;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gs_date;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  

		if (confirm("�����û �Ͻðڽ��ϱ�?")){	
			gctr_data06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6?";
			gctr_data06.post();
			ln_Query('01');
    }
}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
  parameter   : p - dataset ����
	              02 : ��ǥ Detail ���̺�
                05 : �����׸� ���̺�
                01_1 : ��ǥ Master ���̺�
								02_2 : ��ǥ ���� ���̺�(��ǥ��Ͻ� ���)
								key : ȸ����ǥ��ȣ
******************************************************************************/
function ln_SetDataHeader(p){
	if(p=="02"){
		if (gcds_data02.countrow<1){
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:DECIAML,CHAAMT:DECIAML,"
								 + "ATCODE:STRING,ATKORNAM:STRING,DAEAMT:DECIAML,ATDECR:STRING,REMARK:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING ";
			gcds_data02.SetDataHeader(s_temp);
		}

	}else if(p=="05"){
		if (gcds_data04.countrow<1){
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:DECIAML,FSREFSEQ:STRING,"
								 + "FSREFCD:STRING,FSREFVAL:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING ";
			gcds_data04.SetDataHeader(s_temp);
		}
	}else if(p=="01_1"){
		if (gcds_data01_1.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSDAT1:STRING,FSDAT2:STRING,FSNBR:STRING,FSKND:STRING,"
			           + "FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,DEPTNM:STRING,EMPNO:STRING,EMPNMK:STRING,DIVCD:STRING,"
								 + "FSAMT:DECIMAL,FSVAT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,"
								 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,DIVNM:STRING,SSDAT:STRING,SSNBR:STRING,SSDAT1:STRING,SSDAT2:STRING ";

			gcds_data01_1.SetDataHeader(s_temp);
		}
  }else if(p=="key"){
		if (gcds_slipno.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
			gcds_slipno.SetDataHeader(s_temp);
		}
  }else if(p=="CONFIRM"){
		if (gcds_confirm.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,SEQ:STRING,ACCSGNID:STRING,EMPNO:STRING,"
								 + "ACCSGNDAT:STRING,ACCSGNEND:STRING,FROMGB:STRING,TOGB:STRING,BIGO:STRING,BGTGB:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
			gcds_confirm.SetDataHeader(s_temp);
		}
	}else if(p=="MASTER"){ //gcem_fsdat_fr
		if (gcds_master.countrow<1){                   
			var s_temp = "FDCODE:STRING,FDNAME:STRING,CURDT:STRING,CURTM:STRING";
			gcds_master.SetDataHeader(s_temp);
		}
	}
}


/******************************************************************************
	Description : �޷�
	prameter    :	    
******************************************************************************/
function ln_Calendar(){

	if(gclx_fsstat02.bindcolval=="Y"){
		alert("����Ϸ�� ��ǥ�Դϴ�.");
	}else{
		__GetCallCalendar('gcem_actdat02', 'Text');
	}
}

/******************************************************************************
	Description : Ȯ����ǥ List
	prameter    :	    
******************************************************************************/
function ln_Print(){

	 var strGubun ="";

		if(gs_dept2=="true"){
			strGubun="A";  //ȸ�� or �繫���� ��츸 
		}else{
            strGubun="";
		}
		
		//alert("gs_userid::"+gs_userid);
		//�ӽ�
		if(gs_userid=="6080002"||gs_userid=="2020009"||gs_userid=="2050053"||gs_userid=="2040080"||gs_userid=="6070001"||gs_userid=="2120002"||gs_userid=="2020029"||gs_userid=="3170009"||gs_userid=="2050004"){
				strGubun="A";  //ȸ�� or �繫���� ��츸 
				strempno="";
		}else{
				strGubun="";
				strempno=gs_userid;
		}
		
		gcds_datetime.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_datetime_s1?"									
		gcds_datetime.Reset();
		ln_SetDataHeader("MASTER");
		gcds_master.Addrow();
		gcds_master.namevalue(1,"FDCODE")= gclx_fdcode.bindcolval;
		gcds_master.namevalue(1,"FDNAME")= gclx_fdcode.text;
		gcds_master.namevalue(1,"CURDT")= gcds_datetime.namevalue(1,"DATES");
		gcds_master.namevalue(1,"CURTM")= gcds_datetime.namevalue(1,"TIMES");

		gcds_print.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s1?v_str1="+gs_fdcode
																			 +"&v_str2="+gcem_fsdat_fr.text
																			 +"&v_str3="+gcem_fsdat_to.text
																			 +"&v_str4="+txt_deptcd.value
																			 +"&v_str5="+strGubun
																			 +"&v_str6=Y"
																			 +"&v_str7="+txt_remark.value
																			 +"&v_str8="+gclx_fdcode.bindcolval
																			 +"&v_str9="+gclx_togb.bindcolval
																			 +"&v_str10="+strempno;				
																										 
        //prompt('',gcds_print.DataID );																										 																			
		gcds_print.Reset();
		gcrp_print.Preview();
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Master -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Detail -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �������� ȸ�����ڱ��� -->
<comment id="__NSID__"><object  id=gcds_comcode01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �������� -->
<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��������2 -->
<comment id="__NSID__"><object  id=gcds_comfield02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����ڵ� -->
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--��ǥMaster ���� -->
<comment id="__NSID__"><object  id=gcds_data01_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--��ǥMaster ��ȸ -->
<comment id="__NSID__"><object  id=gcds_data01_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--�μ��� �����ڵ� ã��-->
<comment id="__NSID__"><object  id=gcds_divcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ȣ ä���� ���� �ѱ�°� -->
<comment id="__NSID__"><object  id=gcds_input classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ȣ ä�� -->
<comment id="__NSID__"><object  id=gcds_slipno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ���� -->
<comment id="__NSID__"><object  id=gcds_confirm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �α��� �μ� üũ -->
<comment id="__NSID__"><object  id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Ȯ����ǥ����Ʈ -->
<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr"   value="+SSDAT+SSNBR">
	<Param Name="SubsumExpr" VALUE="100:SSDAT">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Ȯ����ǥ����Ʈ master -->
<comment id="__NSID__"><object  id=gcds_master classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������� -->
<comment id="__NSID__"><object  id=gcds_datetime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����û���� -->
<comment id="__NSID__"><object  id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ������ȣ ���� -->
<comment id="__NSID__"><object  id=gctr_slipno classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t4f(O:USER=gcds_slipno)">   
</object></comment><script>__ws__(__NSID__);</script> 


<!-- ����  -->
<comment id="__NSID__"><object  id=gctr_data06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6f(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  

<!-- multi ����  -->
<comment id="__NSID__"><object  id=gctr_data07 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t7(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>


<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	if (row>=1){
		txt_deptcd.value=gcds_dept.namevalue(row,"DEPTCD");
		txt_deptnm.value=gcds_dept.namevalue(row,"DEPTNM"); 
		gs_deptcd=gcds_dept.namevalue(row,"DEPTCD");
		gs_deptnm=gcds_dept.namevalue(row,"DEPTNM");
	}
</script>

<script language="javascript" for="gcds_comfield" event="onloadCompleted(row,colid)">
		gcds_comfield.insertrow(1);
		gcds_comfield.namevalue(1,"FDCODE") = "";
		gcds_comfield.namevalue(1,"FDNAME") = "��ü";
		//gclx_fdcode.index = 0;
</script>

<script language="javascript" for="gcds_comcode01" event="onloadCompleted(row,colid)">

		gcds_comcode01.insertrow(1);
		gcds_comcode01.namevalue(1,"CDCODE") = "";
		gcds_comcode01.namevalue(1,"CDNAM") = "��ü";
		//gclx_fsdat.index = 0;

		gclx_togb.index=0;
</script>

<script language="javascript" for="gcds_divcd" event="onloadCompleted(row,colid)">
		//alert("row::"+row+"::gcds_divcd::"+gcds_divcd.namevalue(gcds_divcd.rowposition,"DIVCD"));
</script>

<script language="javascript" for="gcds_empno_chk" event="onloadCompleted(row,colid)">
		ln_Authority_Result(row,colid);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
  //2007.05.20 ������ �߰�
	//1�ǿ� ���ؼ� ��ǥ ���� �����ϰ� ��.
	/***
	if((row==0) && (colid=="CHK")){
		if(gcds_data01.namevalue(1,"CHK")=="T"){
			for(i=1;i<=gcds_data01.countrow;i++){
        gcds_data01.namevalue(i,"CHK")="F";
			}
		}else{
			for(i=1;i<=gcds_data01.countrow;i++){
        gcds_data01.namevalue(i,"CHK")="T";
			}
		}
		return;
	}
  **/
  //alert("colid::"+colid);
	//alert("CHK::"+gcds_data01.namevalue(row,"CHK"));
	
	if(row!=0&&colid=="CHK") {
		//������ ����Ÿ�� üũ�� ���� �����ϸ� break;
		
		for(i=1;i<=gcds_data01.countrow;i++){
			if(row!=i){
			  if(gcds_data01.namevalue(i,"CHK")=="T"){
					gcds_data01.namevalue(i,"CHK")="F";
				}
			}
		}
		
		if(gcds_data01.namevalue(row,"FSSTAT")!="N"&&gcds_data01.namevalue(row,"FSSTAT")!="B"){ 
			alert("�����û ������ ���� �ƴմϴ�.");
			return;
		}

		if(gcds_data01.namevalue(row,"CHK")=="T"){
			gcds_data01.namevalue(row,"CHK")="F";
		}else{
			gcds_data01.namevalue(row,"CHK")="T";
		}
	}else{
	}

</script>


<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

  if(colid!="CHK"){
		ln_Popup('ADD','',row);
	}
</script>

<script language=JavaScript for=gcem_fsdat02 event=OnKillFocus()>
	//ln_Find_Slipno();
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_slipno event=OnSuccess()>
		//alert("fsnbr::"+gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR"));
		gcem_fsnbr02.text=gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
</script>

<script language=JavaScript for=gctr_data06 event=OnSuccess()>
		
</script>

<script language="javascript" for="gctr_data06" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	gcds_confirm.ClearData();
</script>

<script language="javascript" for="gctr_data06" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	//alert("Error Code : " + gcds_confirm.ErrorCode + "\n" + "Error Message : " + gcds_confirm.ErrorMsg + "\n");
	gcds_confirm.ClearData();
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a020001_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
					  <!-- <img src="../../common/img/btn/com_b_trans.gif"   style="cursor:hand" onclick="ln_Popup('00')"> -->
					  <img src="../../Common/img/btn/com_b_trans.gif"   style="cursor:hand" onclick="ln_Popup('01')">
						<img src="../../Common/img/btn/com_b_slipsts.gif"   style="cursor:hand" onclick="ln_Popup('09')">	
						<!-- <img src="../../common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Multi_Confirm()" >  -->
					  <!-- <img src="../../common/img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('01')">	 -->
					  <!-- <img src="../../common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('01')" > -->
						<img src="../../Common/img/btn/com_btn_sliplist.gif"   style="cursor:hand" onclick="ln_Print()">
						<img src="../../Common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Popup_Confirm()" > 
						<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('01')">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;ȸ������&nbsp;</nobr></td>
								<td class="tab18" style="width:150px;"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										~&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
         
                <td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;��ǥ����&nbsp;</nobr></td>
								<td class="tab18" style="width:145px;"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
											<param name=CBData			   value="A^��ü,Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME">								
											<param name=BindColumn		 value="CODE">

									</object></comment><script>__ws__(__NSID__);</script> 	
								</nobr>
								</td> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;��������</nobr></td>
								<td class="tab18" style="width:90px;" align=center><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=ComboDataID    value="gcds_comfield">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value=FDNAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;����</nobr></td>
								<td class="tab18" style="width:90px;" align=center><nobr>&nbsp;<comment id="__NSID__">
								  <object  id=gclx_togb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:-3px;top:2px;font-size:12px;width:80px;">
											<param name=CBData value="^��ü,02^����,03^ȸ��,06^�ڱ�,05^�Ϸ�">
											<param name=CBDataColumns	 value="CDCODE,CDNAM">
											<param name=SearchColumn	 value="CDNAM">
											<param name=Sort			     value="false">
											<param name=ListExprFormat value="CDNAM">								
											<param name=BindColumn		 value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
							<!-- 	<td class="tab18" style="width:90px;" align=center><nobr>&nbsp;<comment id="__NSID__">
								  <object  id=gclx_fsdat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:-3px;top:2px;font-size:12px;width:80px;">
											<param name=ComboDataID  value="gcds_comcode01">
											<param name=CBDataColumns	 value="CDCODE,CDNAM">
											<param name=SearchColumn	 value="CDNAM">
											<param name=Sort			     value="false">
											<param name=ListExprFormat value="CDNAM">								
											<param name=BindColumn		 value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td> -->
							</tr>

							 <tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;��    ��&nbsp;</nobr></td>
								<td class="tab19" style="width:547px;" colspan=5><nobr>&nbsp;
									<input id="txt_remark" type="text" class="txtbox"  style= "width:547px;height:20px;position:relative;left:-4px" maxlength=30 onkeydown="if(event.keyCode==13) ln_Query('01')";>
									</nobr>
								</td>

								<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;���μ�&nbsp;</nobr></td>
								<td class="tab19" style="width:160px;"><nobr>&nbsp;
									<input id="txt_deptcd" type="text" class="txtbox"  style= "width:50px;height:20px;position:relative;left:-4px;background-color:#d7d7d7"  readonly="true";>
									<input id="txt_deptnm" type="text" class="txtbox"  style= "width:110px;height:20px;position:relative;left:-4px;background-color:#d7d7d7"  readonly="true";>
									</nobr>
								</td>
							</tr>
					 </table>
					</td>
				</tr>  	
			</table>

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:b
;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data01">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value=1>
								<param name="ColSizing"   value="true">
								<param name="Editable"    value="false">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='����'		   ID=CHK 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center  sort=false SumBgColor=#C3D0DB EditStyle=CheckBox</C> 
								<C> Name='����'		   ID=FDCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=left	 edit=none sort=true SumBgColor=#C3D0DB EditStyle=Combo Data='01:����,02:����,03:�ݰ���,04:����' BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 
								<C> Name='���'		   ID=FSLOCK	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=center	 edit=none sort=true SumBgColor=#C3D0DB EditStyle=Combo Data='T:���,F:''' BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 
								<C> Name='����'		   ID=CDNAM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=left	 edit=none sort=true SumBgColor=#C3D0DB BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 
								<C> Name='�����'		 ID=EMPNMK	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left	 edit=none sort=true SumBgColor=#C3D0DB BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 								
								<C> Name='��ǥ��ȣ'	 ID=SSDTNB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=107	align=center edit=none sort=true SumBgColor=#C3D0DB BgColor={IF(FSLOCK='T','#FFCC66','#CCFFCC')}</C> 
								<C> Name='������ȣ'	 ID=FSDTNB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=107	align=center edit=none sort=true SumBgColor=#C3D0DB BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 
								<C> Name='����'			 ID=REMARK  HeadAlign=Center HeadBgColor=#B9D4DC Width=202	align=left	 edit=none sort=true SumBgColor=#C3D0DB  SumText='��   ��' BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 
								<C> Name='�ݾ�'		   ID=FSAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  edit=none sort=true SumBgColor=#C3D0DB  SumText=@sum BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 
								<C> Name='����'		   ID=TOGB 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=center edit=none sort=true SumBgColor=#C3D0DB  EditStyle=Combo Data='01:,02:����,03:ȸ��,05:�Ϸ�,06:�ڱ�' BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')}</C> 
								<C> Name='����'		   ID=FSSTAT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center edit=none SumBgColor=#C3D0DB  EditStyle=Combo Data='Y:����Ϸ�,R:�����û,N:������,C:�������,B:�ݼ�' BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} </C> 								">
						</object></comment><script>__ws__(__NSID__);</script>   
						<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>		



<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->


<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_master">
	<param name="DetailDataID"			    value="gcds_print">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="false">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<param name="SuppressColumns"	value="1:pageskip,SSDAT; ">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=539 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='Page : #p of #t' ,left=1461 ,top=384 ,right=1881 ,bottom=431 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ����' ,left=66 ,top=450 ,right=423 ,bottom=524 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=45 ,top=442 ,right=1889 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<X>left=569 ,top=191 ,right=1405 ,bottom=265 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=561 ,top=177 ,right=1394 ,bottom=254 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='Ȯ����ǥ����Ʈ' ,left=564 ,top=180 ,right=1389 ,bottom=243 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='��ǥ��ȣ' ,left=447 ,top=450 ,right=804 ,bottom=524 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ݾ�' ,left=839 ,top=450 ,right=1196 ,bottom=524 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='���' ,left=1238 ,top=450 ,right=1879 ,bottom=524 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=48 ,top=442 ,right=48 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=442 ,top=442 ,right=442 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=818 ,top=442 ,right=818 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1225 ,top=442 ,right=1225 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1889 ,top=442 ,right=1889 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=534 ,right=1889 ,bottom=534 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='ȸ������ : ' ,left=56 ,top=384 ,right=222 ,bottom=431 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ� : ' ,left=56 ,top=333 ,right=222 ,bottom=381 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDNAME', left=225, top=333, right=556, bottom=381, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACTDAT', left=225, top=384, right=804, bottom=431, align='left' ,mask='XXXX-XX-XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1889 ,top=0 ,right=1889 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=48 ,top=0 ,right=48 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=818 ,top=0 ,right=818 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=442 ,top=0 ,right=442 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1225 ,top=0 ,right=1225 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,100,\'�� ��\',SSDAT)}', left=66, top=0, right=423, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,100,SubRealCount(level=0)&\' ��\',SSNBR)}', left=450, top=0, right=807, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSAMT', left=841, top=0, right=1199, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=48 ,top=0 ,right=1889 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#C0C0C0 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=100 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=48 ,top=0 ,right=1889 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1511 ,top=3 ,right=1889 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=1897 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<!-- ��ǥ��� MASTER-->
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01_1>
	<param name=BindInfo  value='  
	<C>Col=FDCODE	      Ctrl=gclx_fdcode02	      Param=BindColVal</C>
	<C>Col=FSDAT1       Ctrl=gcem_fs02            Param=Text</C>
	<C>Col=FSDAT2       Ctrl=gcem_fsdat02         Param=Text</C>
	<C>Col=FSNBR	      Ctrl=gcem_fsnbr02		      Param=Text</C>
	<C>Col=FSSTAT	      Ctrl=gclx_fsstat02		    Param=BindColVal</C>
	<C>Col=DEPTCD	      Ctrl=txt_deptcd02	        Param=value</C>
  <C>Col=DEPTNM	      Ctrl=txt_deptnm02	        Param=value</C>
	<C>Col=EMPNO        Ctrl=txt_empno02          Param=value</C>
	<C>Col=EMPNMK       Ctrl=txt_empnmk02         Param=value</C>
	<C>Col=FSWRTDAT     Ctrl=gcem_fswrtdat02		  Param=Text</C>
	<C>Col=ACTDAT       Ctrl=gcem_actdat02		    Param=Text</C>
	<C>Col=FSAMT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=REMARK       Ctrl=gcem_remark02		    Param=Text</C>
	<C>Col=DETOT	      Ctrl=gcem_detot02		      Param=Text</C>
	<C>Col=CRTOT	      Ctrl=gcem_crtot02		      Param=Text</C>
	<C>Col=SSDAT1       Ctrl=gcem_ss02            Param=Text</C>
	<C>Col=SSDAT2       Ctrl=gcem_ssdat02         Param=Text</C>
	<C>Col=SSNBR	      Ctrl=gcem_ssnbr02		      Param=Text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ��� MASTER ��ȸ-->
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01_2>
	<param name=BindInfo  value='  
	<C>Col=FSSTAT	      Ctrl=gclx_fsstat02		    Param=BindColVal</C>
	<C>Col=DEPTCD	      Ctrl=txt_deptcd02	        Param=value</C>
  <C>Col=DEPTNM	      Ctrl=txt_deptnm02	        Param=value</C>
	<C>Col=EMPNO        Ctrl=txt_empno02          Param=value</C>
	<C>Col=EMPNMK       Ctrl=txt_empnmk02         Param=value</C>
	<C>Col=FSWRTDAT     Ctrl=gcem_fswrtdat02		  Param=Text</C>
	<C>Col=ACTDAT       Ctrl=gcem_actdat02		    Param=Text</C>
	<C>Col=FSAMT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=REMARK       Ctrl=gcem_remark02		    Param=Text</C>
	<C>Col=DETOT	      Ctrl=gcem_detot02		      Param=Text</C>
	<C>Col=CRTOT	      Ctrl=gcem_crtot02		      Param=Text</C>
	<C>Col=SSDAT1	      Ctrl=gcem_ss02		        Param=Text</C>
	<C>Col=SSDAT2	      Ctrl=gcem_ssdat02		      Param=Text</C>
	<C>Col=SSNBR	      Ctrl=gcem_ssnbr02		      Param=Text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
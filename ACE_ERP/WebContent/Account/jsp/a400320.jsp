<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ���ݰ��� - �����û ��ǥ���
+ ���α׷� ID	:  a400320.jsp
+ �� �� �� ��	:  �����û ��� �� ��ǥ ���� ȭ���̴�.  
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2017.11.03
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
<title>�����û ��ǥ���</title>

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

var acc_dirpath="<%=dirPath%>/Account/jsp";


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
	
	
	gcds_fdcode.DataID   ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gcds_fdcode02.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode02.Reset();
	
	gclx_fdcode.bindcolval   = gs_fdcode;
	
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
	
	gclx_fdcode02.bindcolval = gs_fdcode;
	gcem_fs02.text ="A";
	gcem_fsdat02.text =  gs_date;
	gcem_fsnbr02.text ="000000";      
	gcem_actdat02.text  = gs_date;	
	
	txt_deptcd.value= gdeptcd;
	txt_deptnm.value= gdeptnm;
	gclx_payknd.index=0;
	
}

<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	//�ڱݽ�û���� 
    gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_s1?v_str1="+gclx_fdcode.bindcolval
    		                                                              +"&v_str2="+gcem_appdate.text
    		                                                              +"&v_str3="+gcem_reqdate.text
    		                                                              +"&v_str4="+gcem_appempno.text
    		                                                              +"&v_str5="+gclx_payknd.bindcolval	
                                                                          +"&v_str6=3";	
    gcds_data01.Reset();
   
    ds_slipdtl.ClearData();
     
    gcgd_disp01.ColumnProp('CHKBOX','HeadCheck')="FALSE";
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
	Description : ��ǥ������ ����
******************************************************************************/
%>
function fnSlipCreate(){
	
	//DataSet Head ���� 
    //gs_rpt_mst.clearAll();

	//var s_temp = "TITLE:STRING,COST_NM:STRING,USRNAME:STRING,USEDATE:STRING";
	//gs_rpt_mst.SetDataHeader(s_temp);
	
	//��ǥ MST ���� 
    //��ǥ DTL ���� 		 
    //��ǥ REF ���� 
    
    //UPDATE -  �ⳳ���̺� ��ǥ��ȣ INSERT ( �ⳳ������ �ⳳ SID ������ ������ �־�� ��. ) 
    //�������� ��ȸ �Ͽ� �ϰ� UPDATE ĥ��??
    //�ʼ��׸� üũ 
    
	//if(!fnSlipChk()) return;
	//1.ȸ������ 
	//2.����1, ����2 
	//3.�ŷ�ó 
	//4.���� 
	//5.���ް���, �ΰ����� 
	//6.�������� �ϰ�� ���곻�� ���� 
	//7.���곻�� �ݾ��հ� �������� �ݾ� �� 
	//8.��ǥ��Ͽ��� �ݾ��� ���� / �뺯 ���ÿ� �������� ���ϰ� ��. 
	
	// �⺻���� 
	//���ް��� -> �����ڵ� 1
	//���ް���+�ΰ����� --> �����ڵ� 2    
	ds_slipdtl.clearall();

	//�׸��� ������ ���� 
	fnCreateSelect();
}

function fnCreateSelect() {
	
	  var strAppno="";
	  var intTaxnbrChk=0;
	
	  for(var i=1;i<=gcds_data01.countrow;i++){
		  if(gcds_data01.namevalue(i,"CHKBOX")=="T"){ //üũ 
			  
			  //����ó���� üũ �Ǿ��µ� ��꼭 ��ȣ�� ���� ��찡 �����ϸ� return
			  if(gcds_data01.namevalue(i,"PURGB")=="T"&&gcds_data01.namevalue(i,"TAXNBR")==""){
				  intTaxnbrChk+=1;
			  }
			  strAppno+="'"+gcds_data01.namevalue(i,"APPNO")+"',"
		  }
	  }
	  
	  if(strAppno==""){
		  alert("�ڱݽ�û������ �����Ͻʽÿ�.");
		  return false;
	  }else{
		  strAppno=strAppno.substring(0,strAppno.length-1);  
	  }
	  
	  if(intTaxnbrChk>0){
		  alert("��꼭 ��ȣ�� �������� �ʽ��ϴ�.");
		  return false;
	  }
	  
	  
	  
	  //���� ��ȸ�ؾ���		
	  ds_slipdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400320_s1?v_str1="+gclx_fdcode.bindcolval
																				    +"&v_str2="+gcem_appdate.text
																				    +"&v_str3="+gcem_reqdate.text
																				    +"&v_str4="+gcem_appempno.text
	 																			    +"&v_str5="+strAppno;	
	  ds_slipdtl.Reset();  
}    


<%//��ǥ��� �׸��� ������ �⺻����   %>
function fnSlipdtl_Display(row){
	
	var strPo="";
	var strAtcode="";
    
    //�ڵ������ϱ�
	for(var i=1;i<=row;i++){
		
		strAtcode =ds_slipdtl.namevalue(i,"ATCODE");
		
		ds_slipdtl.namevalue(i,"FSNUM") =ln_Seqno_Format(Number(i),3);
		ds_slipdtl.namevalue(i,"FSSEQ") =ln_Seqno_Format(Number(i),5);
			
		ds_slipdtl.namevalue(i,"FSREFVAL02") =ds_slipdtl.namevalue(i,"VENDCD") ;
		ds_slipdtl.namevalue(i,"FSRVALNM02") =ds_slipdtl.namevalue(i,"VENDNM") ;
		
		//�μ� ( �⺻���� �۾��� �μ� �ֱ� ) 
		ds_slipdtl.namevalue(i,"FSREFVAL01") = gdeptcd;
		ds_slipdtl.namevalue(i,"FSRVALNM01") = gdeptnm;
		
		
		//�����ڵ�� ��� �����ñ�????? ���
		//(��ΰŸ�....���� ó���ϴ� ����� ����??????) --> ���� �������� �Ǽ�������η� ó����. 
		
		//�����ڵ� �Ǵ� ����μ� 
		if(ds_slipdtl.namevalue(i,"COSTGB")=="1"){ // ����
			strPo="";
			strPo = fnRef_position_find(i,"0030");
			if(ds_slipdtl.namevalue(i,"FSREFCD"+strPo)=="0030"){
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"COSTBGT") ;
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = ds_slipdtl.namevalue(i,"COSTBGTNM") ;
			}
		}else if(ds_slipdtl.namevalue(i,"COSTGB")=="2") { //����
			strPo="";
			strPo = fnRef_position_find(i,"0003");
			if(ds_slipdtl.namevalue(i,"FSREFCD"+strPo)=="0003"){
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"COSTBGT") ;
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = ds_slipdtl.namevalue(i,"COSTBGTNM") ;
			}
		}
		
		////���޺ΰ���ġ�� �ڵ� ���� 
		if (strAtcode=="1112300"){ // ���޺ΰ���ġ��
			
			//������ �ֱ�
			if(ds_slipdtl.namevalue(i,"TAXKND")=="1"||ds_slipdtl.namevalue(i,"TAXKND")=="4"){ // ���� , �Ұ��� ���޺ΰ���ġ�� ������ ����.
				ds_slipdtl.namevalue(i,"DOCUMCD")="101";
				ds_slipdtl.namevalue(i,"DOCUVAL")=ds_slipdtl.namevalue(i,"TAXNBR")
			}
			
			
			//���޺ΰ���ġ�� 0998  � ������ ����???
			strPo="";
		    strPo = fnRef_position_find(i,"0998");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "03";
		    ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "���ݰ�꼭";		
			
			//��꼭 ���� 
			strPo="";
		    strPo = fnRef_position_find(i,"0970");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"TAXDAT");
		    ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = ds_slipdtl.namevalue(i,"TAXDAT");
		}else if(strAtcode.substring(0,2)=="43"||strAtcode.substring(0,2)=="44"){ // ������� �ǸŰ�����
			
			//������ �ֱ�
			if( ds_slipdtl.namevalue(i,"TAXKND")=="2"){ //���� - ���޺ΰ���ġ�� ������ ���� ���
				ds_slipdtl.namevalue(i,"DOCUMCD")="101";
				ds_slipdtl.namevalue(i,"DOCUVAL")=ds_slipdtl.namevalue(i,"TAXNBR");
			}
		    
		    //2017.02.06 JYS �鼼�κ� �߰� 
			if( ds_slipdtl.namevalue(i,"TAXKND")=="3"){ //�鼼 - ���޺ΰ���ġ�� ������ ���� ���
				ds_slipdtl.namevalue(i,"DOCUMCD")="102";
				ds_slipdtl.namevalue(i,"DOCUVAL")=ds_slipdtl.namevalue(i,"TAXNBR");
			}
		}
				 
		//����μ� LOCK
		//�������� LOCK 
		if(ds_slipdtl.namevalue(i,"ATCODE")=="2100110"||ds_slipdtl.namevalue(i,"ATCODE")=="2100510"){
			
			//���ޱ����� ��ȭ�ΰ��
			if(ds_slipdtl.namevalue(i,"PAYGB")=="3"||ds_slipdtl.namevalue(i,"PAYGB")=="4"){
				//��ȭ�� 
				strPo="";
				strPo = fnRef_position_find(i,"1043");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"CURUNITCD");
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = ds_slipdtl.namevalue(i,"CURUNIT");
				
				//��ȭ�ݾ� 
				strPo="";
				strPo = fnRef_position_find(i,"1045");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"FOUTAMT");
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = ds_slipdtl.namevalue(i,"FOUTAMT");
			}else{
				//��ȭ�� 
				strPo="";
				strPo = fnRef_position_find(i,"1043");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "01";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "WON";
				
				//��ȭ�ݾ� 
				strPo="";
				strPo = fnRef_position_find(i,"1045");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "0";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "0";
			}
		}else{
			
			//��ȭ�� 
			strPo="";
			strPo = fnRef_position_find(i,"1043");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "01";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "WON";
			
			//��ȭ�ݾ� 
			strPo="";
			strPo = fnRef_position_find(i,"1045");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "0";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "0";
		}
	
		//������ �ܻ���Ա� �ϰ�� 
		if (ds_slipdtl.namevalue(i,"ATCODE")=="2100110"){ //�ܻ���Ա�
			//�ܻ���Ա� 
			strPo="";
			strPo = fnRef_position_find(i,"1011");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "05";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "��Ÿ";
		}
		
		//������ �ܻ���Ա� �ϰ�� 
		if (ds_slipdtl.namevalue(i,"ATCODE")=="2100510"){ //�����ޱ�
			//�����ޱ�
			strPo="";
			strPo = fnRef_position_find(i,"1013");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "003";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "��Ÿ�����ޱ�";
		}
	}
}


<%//�����׸� ��ġã��%>
function fnRef_position_find(p,strValue){
	var strposition="";
	for(f=3;f<=9;f++){
		if (ds_slipdtl.namevalue(p,"FSREFCD0"+f)==strValue){  
				strposition ="0"+f;
				return strposition; 
	    }
	}//for f 
	return strposition; 
}


<%//�����׸� KillFocus�� �߻�  obj - �����׸��� gcem object��    p - �ڸ��� 0 %>
function fnonblur(obj, p){
  
    var row = ds_slipdtl.rowposition;
    if(obj=="gcem_fsrvalnm"+p){
		if(ds_slipdtl.namevalue(row,"TYPE"+p)=="C"){
			eval("txt_fsrefval"+p).value =eval("gcem_fsrvalnm"+p).text; 
		}	
		if(eval("gcem_fsrvalnm"+p).text==""){
			eval("txt_fsrefval"+p).value=""; 
		}
	}
}


<%//������ �⺻ ������ ��ȸ  %>
function fnSave() {
   
    gcds_appfund.clearall();
	fnAppnoSetDataHeader();
	fnAppnoSettting();
      	
   	gcds_slipdtl.clearall();
	fnSlipdtlSetDataHeader();
	fnSlipdtlSetting();
      	
   	gcds_slipmst.clearall();
	fnSlipmstSetDataHeader();   
	fnSlipmstSetting();
   
    //prompt('gcds_slipdtl',gcds_slipdtl.text);
    //prompt('gcds_slipmst',gcds_slipmst.text);
   
    if(fnSave_Chk()){
 		if (gcds_slipmst.IsUpdated) {
			if (confirm("���� �Ͻðڽ��ϱ�?")){	
				tr2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300065_t1"
				tr2.Parameters = "v_str1="+gusrid+",v_str2="+gfdcode;
			    //<param name="KeyValue"    value="Si050I_t1(I:USER1=gcds_slipmst,I:USER2=gcds_slipdtl,I:USER3=gcds_banjaemst,I:USER4=gcds_banjae,I:USER5=gcds_appfund,O:USER9=gcds_slipno )">    
			    //tr2.keyvalue="Si050I_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_appfund,O:USER5=gcds_slipno )"; 
				//prompt('gcds_slipmst',gcds_slipmst.text);
				//prompt('gcds_slipdtl',gcds_slipdtl.text);
				//prompt('gcds_banjaemst',gcds_banjaemst.text);
				//prompt('gcds_banjae',gcds_banjae.text);
				//prompt('gcds_appfund',gcds_appfund.text);
			
				tr2.post();
			}	
		}
	}
}


<%//��ǥdtl ������ ����%>
function fnSlipdtlSetting() {
	var strAtcode ="";
	    		
	for (var k=1;k<=ds_slipdtl.countrow;k++){
		strAtcode = ds_slipdtl.namevalue(k, "ATCODE" );
		ds_slipdtl.namevalue(k, "FDCODE") = gclx_fdcode02.bindcolval;
		ds_slipdtl.namevalue(k, "FSDAT" ) = gcem_fs02.text+gcem_fsdat02.text;
		
		gcds_slipdtl.addrow();
		
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FDCODE" ) = ds_slipdtl.namevalue(k, "FDCODE" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSDAT" )  = ds_slipdtl.namevalue(k, "FSDAT" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNBR" )  = ds_slipdtl.namevalue(k, "FSNBR" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSEQ" )  = ds_slipdtl.namevalue(k, "FSSEQ" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" ) = ds_slipdtl.namevalue(k, "ATCODE" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATDECR" ) = ds_slipdtl.namevalue(k, "ATDECR" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "REMARK" ) = ds_slipdtl.namevalue(k, "REMARK" );
   		
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DEAMT" )  = ds_slipdtl.namevalue(k, "DEAMT" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CRAMT" )  = ds_slipdtl.namevalue(k, "CRAMT" );
   		
   		for(var no=1;no<=9;no++){
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFSEQ0"+no ) = ds_slipdtl.namevalue(k, "FSREFSEQ0"+no );
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )  = ds_slipdtl.namevalue(k, "FSREFCD0"+no );
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no ) = ds_slipdtl.namevalue(k, "FSREFVAL0"+no );
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFNM0"+no )  = ds_slipdtl.namevalue(k, "FSREFNM0"+no );
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no ) = ds_slipdtl.namevalue(k, "FSRVALNM0"+no );
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "TYPE0"+no)      = ds_slipdtl.namevalue(k, "TYPE0"+no );
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ARBALDIV0"+no)  = ds_slipdtl.namevalue(k, "ARBALDIV0"+no );
   		}
   		
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )   = ds_slipdtl.namevalue(k, "DOCUMCD" );
   		
   		//**������ ���� ���� 44 �ǰ��� ������ 02 ���� �׿ܴ� 01 ������
   		if(strAtcode.substring(0,2)=="44"){
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )="02";	
   		}else{
   			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )="01";
   		}
   		
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRDT" )        = gs_date;
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRID" )        = gusrid;
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEYN" )    = ds_slipdtl.namevalue(k, "ATDEBTYN" );
   		
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSTAT" )      = "";
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUVAL" )     = ds_slipdtl.namevalue(k, "DOCUVAL" );
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNUM" )       = ds_slipdtl.namevalue(k, "FSNUM" );
   		
   		//**���δ� ã�ƾ�����
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DIVCD" )       ="II00";
   		
   		//����μ� ���� 
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BGTDIV" )      = "";
   		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEREF" )   = ds_slipdtl.namevalue(k, "BANJAEREF" );
   		
   	}
} 
  
<%//��ǥmst ������ ����%>
function fnSlipmstSetting() {
	var srow = 0;
	gcds_slipmst.addrow();
	
	srow = gcds_slipmst.rowposition; 
	
	gcds_slipmst.namevalue(srow,"FDCODE")= ds_slipdtl.namevalue(1, "FDCODE" );
	gcds_slipmst.namevalue(srow,"FSDAT") = ds_slipdtl.namevalue(1, "FSDAT" );
	gcds_slipmst.namevalue(srow,"FSNBR") ="000000";
	gcds_slipmst.namevalue(srow,"FSKND") = "A";    //�ڵ� - �ڱݽ�û    
	gcds_slipmst.namevalue(srow,"FSWRTDAT")= gs_date;
	gcds_slipmst.namevalue(srow,"COCODE")="02";
	gcds_slipmst.namevalue(srow,"DEPTCD")= gdeptcd;
	gcds_slipmst.namevalue(srow,"EMPNO")= gusrid;
	gcds_slipmst.namevalue(srow,"DIVCD")= "";
	gcds_slipmst.namevalue(srow,"FSAMT")= gcds_slipdtl.Sum(9,0,0);   //���� 
	gcds_slipmst.namevalue(srow,"FSVAT")= 0 ;
	gcds_slipmst.namevalue(srow,"DETOT")= gcds_slipdtl.Sum(9,0,0);   //���� 
	gcds_slipmst.namevalue(srow,"CRTOT")= gcds_slipdtl.Sum(10,0,0); //�뺯 
	gcds_slipmst.namevalue(srow,"REMARK")=gcds_slipdtl.namevalue(1,"REMARK"); //�뺯 
	gcds_slipmst.namevalue(srow,"SGNDAT")="";
	gcds_slipmst.namevalue(srow,"FSSTAT")="N";
	gcds_slipmst.namevalue(srow,"ACTDAT")= gcem_actdat02.text;
	gcds_slipmst.namevalue(srow,"SSDAT")= "";
	gcds_slipmst.namevalue(srow,"SSNBR")= "";
	gcds_slipmst.namevalue(srow,"WRDT")= gs_date;
	gcds_slipmst.namevalue(srow,"WRID")= gusrid;
} 


<%//������ �⺻ ������ ��ȸ  %>
function fnAppnoSettting() {
	for(var t=1;t<=gcds_data01.CountRow;t++){
	    if(gcds_data01.namevalue(t,"CHKBOX")=="T"){
    		gcds_appfund.addrow();
    		gcds_appfund.namevalue(gcds_appfund.rowposition,"APPNO")= gcds_data01.namevalue(t,"APPNO");
    	}
	}
}


<%
/******************************************************************************
Description : �ʼ��׸� üũ 
******************************************************************************/
%>
function fnSave_Chk(){

    if (fn_trim(gs_date)=="")   { alert("������ �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");   return false; }
    if (fn_trim(gs_userid)=="") { alert("ó���ڰ� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");  return false; }
	
    var intBanjaeDeamt=0;
    var intBanjaeCramt=0;
 
    //���� Ȯ�� 
	if(gcds_slipmst.namevalue(1,"FDCODE")==""){
		alert("������ Ȯ�� �Ͻʽÿ�");
		return false;
	}
			
	//�����հ� �� �뺯�հ� �� 
	if(gcds_slipmst.namevalue(1,"DETOT")!=gcds_slipmst.namevalue(1,"CRTOT")){
		alert("�����հ�� �뺯�հ� �ݾ���  Ȯ�� �Ͻʽÿ�");
		return false;
	}
	
	//ȸ������ Ȯ��
	if(gcds_slipmst.namevalue(1,"ACTDAT")==""){
		alert("ȸ�����ڸ� Ȯ�� �Ͻʽÿ�");
		return false;
	}		
	
	//��û���� üũ�� �� ��. JYS 2016.12.15
	/**
	if (gcds_slipmst.namevalue(1,"ACTDAT").substring(0,6)!=vt_fr_inout_dt.text.substring(0,6)){
		alert("�ⳳ����� ȸ������ �ٸ��ϴ�. Ȯ�ιٶ��ϴ�.");
		return false;
	}
	**/

 	for(var i=1;i<=gcds_slipdtl.countrow;i++){
 	     	
 	    if(gcds_slipdtl.namevalue(i,"ATCODE")==""){
			 gcds_slipdtl.rowposition = i;
			 alert("�����ڵ带 �Է��Ͻʽÿ�");
			 return false;
		}
		
		//�ݾ�
		if(gcds_slipdtl.namevalue(i,"DEAMT")==0&&gcds_slipdtl.namevalue(i,"CRAMT")==0){
			gcds_slipdtl.rowposition = i;
			alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ݾ��� �Է��Ͻʽÿ�");
			return false;
		}
		
		//���� �� �뺯 �ݾ� 
		if(gcds_slipdtl.namevalue(i,"DEAMT")!=0&&gcds_slipdtl.namevalue(i,"CRAMT")!=0){
			gcds_slipdtl.rowposition = i;
			alert(gcds_slipdtl.namevalue(i,"FSNUM")+ " �����ݾװ� �뺯�ݾ��� Ȯ�� �Ͻʽÿ�");
			return false;
		} 
		
		 //�ŷ�ó 
		if(gcds_slipdtl.namevalue(i,"ARBALDIV02")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL02")==""||gcds_slipdtl.namevalue(i,"FSRVALNM02")=="")){
			gcds_slipdtl.rowposition = i;
			alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ŷ�ó�� �ʼ��׸��Դϴ�.");
			return false;
		}
		
			//�μ� 
		if(gcds_slipdtl.namevalue(i,"ARBALDIV01")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL01")==""||gcds_slipdtl.namevalue(i,"FSRVALNM01")=="")){
			gcds_slipdtl.rowposition = i;
			alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �μ��� �ʼ��׸��Դϴ�.");
			return false;
		}

		//����
		if(gcds_slipdtl.namevalue(i,"REMARK")==""){
			gcds_slipdtl.rowposition = i;
			alert(gcds_slipdtl.namevalue(i,"FSNUM")+" ������ �Է��Ͻʽÿ�");
			return false;
		}
	
		
     	if(gcds_slipdtl.namevalue(i,"DOCUMCD")!=""&&gcds_slipdtl.namevalue(i,"DOCUVAL")==""){
     		alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �������� ���� ���� �ʽ��ϴ�.");
     		gcds_slipdtl.rowposition = i;
     		return false;
     	}
  
		for(var k=3;k<=9;k++){  
			if(gcds_slipdtl.namevalue(i,"ARBALDIV0"+k)=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)==""||gcds_slipdtl.namevalue(i,"FSRVALNM0"+k)=="")){	
				if(gcds_slipdtl.namevalue(i,"FSREFCD0"+k)!="0003"){
					if(gcds_slipdtl.namevalue(i,"TYPE0"+k)!="C"){ //�Է¾ƴѰ�� 
						tempnm = gcds_slipdtl.namevalue(i,"FSREFNM0"+k);
						alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �����׸� "+tempnm+"�� �ʼ��׸��Դϴ�2.");
						gcds_slipdtl.rowposition = i;
						return false;		
					}else{
						if(gcds_slipdtl.namevalue(i,"FSRVALNM0"+k)==""){
							tempnm = gcds_slipdtl.namevalue(i,"FSREFNM0"+k);
							alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �����׸� "+tempnm+"�� �ʼ��׸��Դϴ�3.");
							gcds_slipdtl.rowposition = i;
							return false;											
						}
					}
				}
			 }
		}//for k
		
		
		 // ���� ������ (-)�ݾ�  �Է� ���� 	
		if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //����
			 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //����
				if(gcds_slipdtl.namevalue(i,"DEAMT")<0){
					alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�. all ");
					gcds_slipdtl.rowposition = i;
					return false;
				}
			 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //�뺯
				if(gcds_slipdtl.namevalue(i,"CRAMT")<0){
					alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�. all ");
					gcds_slipdtl.rowposition = i;
					return false;
				}
			 }
		}
		
		  //�ſ�ī��(����), ���ݿ�����(����)�� ��� ���޺ΰ���ġ���� ��Ÿ�ΰ����� �ƴϸ� üũ 
		if(gcds_slipdtl.namevalue(i,"DOCUMCD")=="103"||gcds_slipdtl.namevalue(i,"DOCUMCD")=="104" ){ 
			for(var x=3;x<=9;x++){
				if(gcds_slipdtl.namevalue(i,"FSREFCD0"+x)=="0998"){ //���޺ΰ���ġ��
					if(gcds_slipdtl.namevalue(i,"FSREFVAL0"+x)!="04"){
					    gcds_slipdtl.rowposition = i;
						alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �������� �ſ�ī��(����), ���ݿ�����(����)�� ��� ���޺ΰ���ġ�� �׸��� ��Ÿ�ΰ����Դϴ�. ");
						return false;
					}
				}
			}//for x
		}	
		
		
		//�����ݾ� ����
		if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //����
			 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //�������� ( �뺯�ݾ� �հ� )
			 	intBanjaeCramt+=gcds_slipdtl.namevalue(i,"CRAMT");
			 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //�뺯���� ( �������� �հ� )
			 	intBanjaeDeamt+=gcds_slipdtl.namevalue(i,"DEAMT");
			 }
		}
		
		
		
		 //2015.02.25.JYS (������ ��û) 
		//�ܻ���Ա�, �����ޱ��� �Ϲݾ�ü �� ���� �߻��� ��� ������ �ʼ� - ��꼭 ��ȣ Ȯ��
		///////////////////////////////////////////////////////////////////////////////////////////////////////
	   if(gcds_slipdtl.namevalue(i,"ATCODE")=="2100110"&&gcds_slipdtl.namevalue(i,"CRAMT")!=0){
	    	m=0;
			for(k=3;k<=9;k++){
				if(gcds_slipdtl.namevalue(i,"FSREFCD0"+k)=="1011"&&gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)=="02"){
	        
					if(gcds_slipdtl.namevalue(i,"DOCUVAL")==""){
						gcds_slipdtl.rowposition = i;
						alert("�ܻ���Ա� �Ϲݾ�ü�� ������ȣ�� �ʼ��׸�ϴ�.Ȯ���Ͻʽÿ�");
						return false;
					}
			    }
	    	}
	    }	
    } //for i
    
    
    //alert("gcds_banjae.Sum(13,0,0):::"+gcds_banjae.Sum(13,0,0)+"::intBanjaeDeamt::"+intBanjaeDeamt);

    if (gcds_banjae.CountRow>0){
	    //�����ݾ� �հ�  üũ  ( �������� �հ� Vs ��ǥ����� ���� ���� �ݾ� �հ� )
	    if ( gcds_banjae.Sum(13,0,0)!=intBanjaeDeamt){
	    	alert( "���� ���� �ݾ��� Ʋ���ϴ�.");
	    	return false;
	    }  
	    if ( gcds_banjae.Sum(14,0,0)!=intBanjaeCramt){
	    	alert( "���� �뺯 �ݾ��� Ʋ���ϴ�.");
	    	return false;
	    }
	 }else{
	 	if ( intBanjaeDeamt !=0){
	    	alert( "���� ���� �ݾ��� Ʋ���ϴ�2.");
	    	return false;
	    }
	    if (intBanjaeCramt !=0){
	    	alert( "���� �뺯 �ݾ��� Ʋ���ϴ�2.");
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

	
}


<%
/******************************************************************************
Description : �ŷ�ó �˾�
******************************************************************************/
%>
function ln_Popup_Vend(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./gczm_vender_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_data01.namevalue(row,"VENDCD") = arrResult[0];  // �ڵ� 
		gcds_data01.namevalue(row,"VENDNM") = arrResult[1];  // �ŷ�ó��
	}else{
		gcds_data01.namevalue(row,"VENDCD") = "";
		gcds_data01.namevalue(row,"VENDNM") = "";
	}
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

		
		strURL = "./commdtil_popup2.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
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
function ln_Popup_Atcode(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	arrParam[1]='B';
	
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
	arrParam[1]='B';
	
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
Description : ���� / ����μ� �˾�
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
	Description :Head ���� - 
******************************************************************************/
%>
<%//��ǥ MST head����%>
function fnSlipmstSetDataHeader() {
	 var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
			     + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
			     + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
			     + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
			     + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
	  gcds_slipmst.SetDataHeader(s_temp);
 
}

<%//��ǥ DTL REF head����%>
function fnSlipdtlSetDataHeader() {
 	  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
 				 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,DEAMT:DECIMAL,CRAMT:DECIMAL,"
			  	 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
				 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09:STRING,"
				 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
				 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
				 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
				 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
				 + "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
				 + "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
				 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
				 + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
				 + "TYPE01:STRING,TYPE02:STRING,TYPE03:STRING,TYPE04:STRING,TYPE05:STRING,"
				 + "TYPE06:STRING,TYPE07:STRING,TYPE08:STRING,TYPE09:STRING,"
				 + "ARBALDIV01:STRING,ARBALDIV02:STRING,ARBALDIV03:STRING,ARBALDIV04:STRING,ARBALDIV05:STRING,"
				 + "ARBALDIV06:STRING,ARBALDIV07:STRING,ARBALDIV08:STRING,ARBALDIV09:STRING,"
				 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
				 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
				 + "BANJAEYN:STRING,FSSTAT:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,"
				 + "BGTDIV:STRING,FUNDDIV:STRING,BANJAEREF:STRING,LASTREF:STRING,BANJAEMOD:STRING,ATCURTYPE:STRING";
		gcds_slipdtl.SetDataHeader(s_temp);
}


 <%//�ڱݽ�û head����%>
function fnAppnoSetDataHeader() {
	 var s_temp = "APPNO:DECIAML,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
	 gcds_appfund.SetDataHeader(s_temp);
}


<%//����Ʈ head����%>
function fnReportSetDataHeader() {
	 var s_temp = "APPDT:STRING,EMPNMK:STRING,SLIPNO:STRING";
	 gcds_rptmst.SetDataHeader(s_temp);
}


<%
/******************************************************************************
Description : �ڱݽ�û�� Report Header ����
******************************************************************************/
%>
function ln_PrintHederSet(){

	var THeader1 = "FDCODE:STRING,ACDATE:STRING,DEPTCD:STRING,REMCODE:STRING,AMTDIV:STRING,AMTDIV1:STRING,"
				 + "PLAMT:DECIMAL,EXAMT:DECIMAL,REMARK:STRING,EXDATE:STRING,STATDIV:STRING,"
				 + "ATKORNAM:STRING,VENDCD:STRING,VENDNM:STRING,UPDT:STRING,UPID:STRING";
	gcds_temp01.SetDataHeader(THeader1);
	
	var THeader2 = "CURDT:STRING,KBUNAM:STRING,CURDT2:STRING";
	gcds_temp02.SetDataHeader(THeader2);

}


<%//�����׸� ã�� %>
function fnRef_Popup(p1,obj,strkeycode){

    var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strposition="";
	var strpo2="";
	var strpo3="";
	var strPopGubun ="";
	var strPo="";                  // �����׸���ġ
	var divcd="";
	var intp=0;                    //�����׸� ��ġ
	
	/////////////////////////////////////////////////////
	// �����׸� ������  ( �ŷ�ó ���� ) 
	/////////////////////////////////////////////////////
	intp = Number(p1);
	
	//alert(":::::::::::::::"+eval("txt_type0"+intp).value);
	if(eval("txt_type0"+intp).value=="C") return;
				
	arrParam[0] = eval("txt_fsrefcd"+p1).value;    //�����׸� �����ڵ�  
	arrParam[1] = eval("gcem_fsrvalnm"+p1).text;   //�����׸� �� 
		
	//ds_slipdtl.namevalue(row,"TYPE"+p)=="C"
	//alert("arrParam[0]::"+arrParam[0]+"::");
	//alert("arrParam[1]::"+arrParam[1]+"::");
		
	//�μ� 
	if (arrParam[0]=="0002"){
		arrParam[2]="A";
		arrParam[3]="";
		arrParam[4]=gclx_fdcode02.bindcolval;

		//2007.10.08.ȸ������ �߰�(�μ� CHGYM ����)
	    var stractdat = gcem_actdat02.text;
	    arrParam[5]=stractdat.substring(0,6);
	
	    strURL = acc_dirpath+"/hcdept_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";	   
	}else if (arrParam[0]=="0020"){
		strURL =  acc_dirpath+"/gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
	}else if (arrParam[0]=="0003"){//����μ� 
		arrParam[2]=hid_bgtdiv.value;
		strURL =  acc_dirpath+"/commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if (arrParam[0]=="0030"){ //����
		arrParam[2]="";
		strURL = acc_dirpath+"/commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if (arrParam[0]=="1113"){//ī���ȣ 
		 arrParam[2]="";
	     for(p=3;p<=9;p++){
				if(eval("txt_fsrefcd0"+p).value=="1134"){
					arrParam[2]=eval("txt_fsrefval0"+p).value;
					break;
				}
		 }
		 strURL =  acc_dirpath+"/commdtil_popup_card.jsp";
		 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if (arrParam[0]=="1135"){//�ڻ��ڵ��ȣ 
		arrParam[1]= gclx_fdcode02.bindcolval;   //����
		arrParam[2]= ds_slipdtl.namevalue(ds_slipdtl.rowposition,"ATCODE");         //�����ڵ�
		strURL =  acc_dirpath+"/commdtil_popup_astnbr.jsp";
		strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else{
		 if(arrParam[0]=="0997")arrParam[2]="A";
		 strURL =  acc_dirpath+"/commdtil_popup_ifrm.jsp";
		 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
	}

	result = showModalDialog(strURL,arrParam,strPos);	

	if(result != null) {
		arrResult = result.split(";");
		eval("txt_fsrefval"+p1).value =arrResult[0];
		eval("gcem_fsrvalnm"+p1).text =arrResult[1];
		
		//alert("01::"+gcem_fsrvalnm01.text);
		//alert("02::"+gcem_fsrvalnm02.text);
		
		if (arrParam[0]=="0002"){
			hid_divcd.value = arrResult[3]; //����
		}
    }	
}

<%
/******************************************************************************
Description : �ڱݽ�û�� ���
******************************************************************************/
%>
function ln_Print(){
	
	if(gcds_data01.countrow<1) {
		alert("����� ������ �����ϴ�.");
	}else{
		gcds_rptmst.clearall();
		gcds_rptdtl.clearall();
		
		
				
		gcds_rptdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300065_s3?v_str1="+gclx_fdcode.bindcolval
					                                                          +"&v_str2="+gcem_appdate.text
					                                                          +"&v_str3="+gcem_reqdate.text
					                                                          +"&v_str4="+gcem_appempno.text;	
		gcds_rptdtl.Reset();
		
		if(gcds_rptdtl.countrow>0){
			
			fnReportSetDataHeader();
			gcds_rptmst.addrow();
		
			gcds_rptmst.namevalue(gcds_rptmst.rowposition,"APPDT")= gcem_appdate.text;
			gcds_rptmst.namevalue(gcds_rptmst.rowposition,"EMPNMK")=gusrnm+"("+gusrid+")";
			gcds_rptmst.namevalue(gcds_rptmst.rowposition,"SLIPNO")=gcds_rptdtl.namevalue(1,"APPFSDAT")+gcds_rptdtl.namevalue(1,"APPFSNBR");
		}
		gcrp_print.preview();
	}
}


<%
/******************************************************************************
Description : �ڱݽ�û�� ���
******************************************************************************/
%>
function ln_Chkbox_All(){
	if(gcgd_disp01.ColumnProp('CHKBOX','HeadCheck')=="FALSE"){
	   //alert("false");
	   gcgd_disp01.ColumnProp('CHKBOX','HeadCheck')="TRUE";
	   //alert("true");
	   for(var i=1; i<=gcds_data01.countrow;i++){
	 		if(gcds_data01.namevalue(i,"APPFSDAT")!=""){
	 			gcds_data01.namevalue(i,"CHKBOX")="F";
	 		}else{
	 			gcds_data01.namevalue(i,"CHKBOX")="T";
	 		}
	 	}
	}else{
		//alert("2true");	
		//alert("2false");
		for(var i=1; i<=gcds_data01.countrow;i++){
	 		if(gcds_data01.namevalue(i,"APPFSDAT")!=""){
	 			gcds_data01.namevalue(i,"CHKBOX")="F";
	 		}else{
	 			gcds_data01.namevalue(i,"CHKBOX")="F";
	 		}
	 	}
		gcgd_disp01.ColumnProp('CHKBOX','HeadCheck')="FALSE";
	}
}


<%//��� %>
function fnCancel_All(){
	 ln_Query();
	 fnRepay_Cancel_All();
}


 <%//���� ��ü ���   %>
function fnRepay_Cancel_All(){
	gcds_banjae.clearAll();
	gcds_banjaemst.clearAll();
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--�ڱݽ�û���� -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=ds_slipdtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>    <!--��ǥ����ȸ ������ ��ȸ -->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipdtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>  <!--��ǥ�� ����-->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipmst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>  <!--��ǥmst ����-->
    <param name="SyncLoad"  value="false">
</object>


<!--����history -->
<object id=gcds_banjae classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_banjaemst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="+BTSSEQ">
</object>

<!--������ȣ -->
<object id=gcds_slipno classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
     <PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=gcds_fdcode classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_fdcode02 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=gcds_appfund classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_rptmst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_rptdtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name=SortExpr     value="+REQDATE+PAYGB">
    <param name=SubSumExpr   value="1:REQDATE:PAYGB">
	
</object> 


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>


<object  id="tr2"     classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5>
    <param name="KeyName"      value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"       value="">
    <param name="KeyValue"     value="a300065_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_appfund,O:USER5=gcds_slipno)"> 
    <param name="Parameters"   value="">
</object>


</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=javascript for="ds_slipdtl" event="OnLoadCompleted(row)">
    fnSlipdtl_Display(row);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
	//var str="namevalue("+row+",'MOVDATE')";
	
	if(row>0){
		
		if(colid=="VENDCD"){
			ln_Popup_Vend(row);
		}
		
		if(colid=="COSTBGT"){
			ln_Popup_Costbgt(row);
		}
		
		if(colid=="ATCODE"){
			ln_Popup_Atcode(row);
		}
		
		if(colid=="PAYACCTNO"){ //���¹�ȣ
			ln_Popup_Payacctno(row);
		}
	}
</script>


<script language="javascript"  for=gcgd_disp01 event=OnHeadCheckClick(Col,Colid,bCheck)>
    
	ln_Chkbox_All();
</script>

<script language="javascript"  for=gcgd_disp01  event=OnClick(row,colid)>

    //alert("row::"+row);
    if(row==0&&colid=="CHKBOX"){
    	ln_Chkbox_All();
    }else if(row>0){
		if(colid =="CHKBOX"){
			//������ȣ �ִ��� Ȯ��
			if(gcds_data01.namevalue(row,"APPFSDAT")!=""){
				alert("��û��ǥ�������ڰ���  �̹� �����մϴ�.");
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
    /*
	if(row>0){
		if(colid=="SUPVATAMT"){
			if(gcds_data01.namevalue(row,"SUPVATAMT")!=0){
				gcds_data01.namevalue(row,"PURGB")="T";   //����ó�� �ڵ� üũ
			}else{
				
			}
		}
	}
    */
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



<script language=JavaScript for=gcem_fsrvalnm01 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)fnRef_Popup('01','gcem_fsrvalnm01',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)fnRef_Popup('03','gcem_fsrvalnm03',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm04 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)fnRef_Popup('04','gcem_fsrvalnm04',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm05 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)fnRef_Popup('05','gcem_fsrvalnm05',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm06 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)fnRef_Popup('06','gcem_fsrvalnm06',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm07 event=onKeyDown(kcode,scode)>
	if(ds_slipdtl.namevalue(ds_slipdtl.rowposition,"ATCODE")=="2100520"){ //�����ޱ�(����ī��)
		if(gcem_fsrvalnm07.Text.length>=9) {
			alert("����ī�� �ŷ�ó���� 8�ڱ��� �Է°����մϴ�.");
      		gcem_fsrvalnm07.Text ="";
			gcem_fsrvalnm07.Focus();
  		} 
    }
	
	if (kcode==13||kcode==113)fnRef_Popup('07','gcem_fsrvalnm07',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm08 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)fnRef_Popup('08','gcem_fsrvalnm08',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)fnRef_Popup('09','gcem_fsrvalnm09',kcode);
</script>



<!-- �μ� / �ŷ�ó / �����׸� -->
<script language=JavaScript for=gcem_fsrvalnm01 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm01", '01');
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm03", '03');
</script>

<script language=JavaScript for=gcem_fsrvalnm04 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm04", '04');
</script>

<script language=JavaScript for=gcem_fsrvalnm05 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm05", '05');
</script>

<script language=JavaScript for=gcem_fsrvalnm06 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm06", '06');
</script>

<script language=JavaScript for=gcem_fsrvalnm07 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm07", '07');
</script>

<script language=JavaScript for=gcem_fsrvalnm08 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm08", '08');
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=OnKeyUp()>
  fnonblur("gcem_fsrvalnm09", '09');
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


<script language=JavaScript for=tr2 event=OnSuccess()>
      
	//alert("gcds_slipno.rowposition:::"+gcds_slipno.rowposition);
	//alert("FSNBR::"+gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR"));
	
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
																								
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	ln_Query();
</script>

<script language=JavaScript for=tr2 event=OnFail()>
	alert("������ ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
			
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Print()">
			
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
  	<tr><td height="2px"><td></tr>
	<tr>
		<td align=left style="position:relative;left:6px;top:-2px">
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
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>��������</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gclx_payknd classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			        value="^��ü,1^��������,2^��������,3^�ڵ����,4^���γ���">
								<param name=CBDataColumns	 		value="CODE,NAME">
								<param name=SearchColumn	     	value=NAME>
								<param name=Sort			        value=false>
								<param name=ListExprFormat       	value="NAME">								
								<param name=BindColumn		     	value="CODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
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
				</tr>
				
				<tr>
					<td class="tab30" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>ó����</nobr></td>
					<td class="tab28" colspan=7>
						<comment id="__NSID__">
						<object id=gcem_appempno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="#######">
							<param name=PromptChar	  value="_">
							<param name=ReadOnly      		value=true> 
							<param name=ReadOnlyBackColor   value="#d7d7d7">
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
							<param name=Language	  value=1>
							<param name=ReadOnly      		value=true> 
							<param name=ReadOnlyBackColor   value="#d7d7d7">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
			
			
	<tr>
		<td ALIGN=CENTER>
			<table width="1000" cellpadding="1" cellspacing="0" border="0">
			    <tr>
			        <td><font size="2" color="blue" ><strong>&nbsp;[�ڱݽ�û����]</strong></font></td>
				</tr>
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top >
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:245px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data01">
							
							<PARAM NAME="Editable"		VALUE="true">
							<param name=UsingOneClick   value="1">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<param name="GTitleHeight"  value=25>
							<param name="TitleHeight"   value="25">
							<param name=RowHeight       value="20">
							
							<PARAM NAME="Format"        VALUE="  
								<FC> Name=''          ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox   HeadCheckShow=true</FC>
								<FC> Name='��û����'    ID=APPDATE        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX'</FC>
								<FG> Name='��������'    HeadAlign=Center  HeadBgColor=#B9D4DC
								<FC> Name='����'       ID=PAYKND         HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:��������,2:��������,3:�ڵ����,4:���γ���'</FC>
								<FC> Name='��û��'     ID=REQDATE	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX'</FC>    
								</FG>    
								
								<FG> Name='�ŷ�ó����'  HeadAlign=Center HeadBgColor=#B9D4DC
								<FC> Name='�ڵ�'	     ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Popup </FC>
								<FC> Name='�ŷ�ó��'	 ID=VENDNM 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='���¹�ȣ'   ID=PAYACCTNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=120    	align=left  	SumBgColor='#C3D0DB'  edit=none </FC>
								</FG>
								<C> Name='����'  	 ID=REMARK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='��û�ݾ�'    ID=OUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='���ް���'    ID=SUPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='�ΰ�����'    ID=SUPVATAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='���ޱ���'    ID=PAYGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:���뿹��,2:����,3:��ȭ���뿹��,4:����(��ȭ)'</C>
								
								<G> Name='��ȭ����'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��ȭ��'     ID=CURUNIT 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} EditStyle=Popup</</C>
								<C> Name='��ȭ'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} SumText=@sum</C>
								<C> Name='ȯ��'       ID=EXRATE  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} </C>
								</G>
								
								<G> Name='��������'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�ڵ�'	     ID=ATCODE 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	SumBgColor='#C3D0DB'  edit=none EditStyle=Popup   show=false</C>
								<C> Name='������'	     ID=ATKORNAM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	    align=left  	SumBgColor='#C3D0DB'  edit=none  show = false</C>
								</G>
								<G> Name='����/��������' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����'	     ID=COSTGB  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=center 	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:����,2:����'  show=false</C>
								<C> Name='�ڵ�'	     ID=COSTBGT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  edit=none EditStyle=Popup  show=false</C>
								<C> Name='����/�����'	 ID=COSTBGTNM  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none show=false</C>
								</G>
								
								<G> Name='��������'    HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����ó��'    ID=PURGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=CheckBox  </C>
								<C> Name='��꼭��ȣ'   ID=TAXNBR 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none MASK='XXXXXXX-XXXX'</C>
								</G>
								<G> Name='��û��ǥ����'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��������'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none</C>
								<C> Name='������ȣ'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center	SumBgColor='#C3D0DB'  edit=none</C>
							    </G>
								<C> Name='�������'    ID=AP_STATUS_M    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:�ۼ���,2:��������,3:��������,4:�ΰ�' bgcolor='#eeeeee'</C>
								<C> Name='���޻���'    ID=PAYSTAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:������,2:����,3:����'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
		</tr>
		
		 <tr height='25px'>
            <td>
            	 <table border='0' cellpadding='0' cellspacing='2' width='1000px'>
                    <tr>
                        <td><b><font size="2" color="blue">[��ǥ���]</font></b></td> 
                        <td height='20px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:hand" onclick="fnSlipCreate()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		    style="cursor:hand" onclick="fnSave()">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		    style="cursor:hand" onclick="fnCancel_All()">                        
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='25px'>
	    	<td style="position:relative;left:6px;">
	    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
	    			<tr>
	                   <td align="center" class="text" width="70">����</td>                                                                     
	                   <td bgcolor='#ffffff'>&nbsp;&nbsp;<comment id="__NSID__">
							<object id=gclx_fdcode02 classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID      value=gcds_fdcode>
								<param name=BindColumn       value="FDCODE">
								<param name=BindColVal       value="FDCODE">
								<param name=ListExprFormat   value="FDNAME^0^90">
								<param name=Index            value="2">
								<param name=Enable           value="true">
							</object>
							</comment><script>__ws__(__NSID__);</script>
						</td>
	                    <td align="center" class="text" width="70">������ȣ</td>
	                    <td bgcolor="#FFFFFF">&nbsp;
	                      	<comment id="__NSID__">
							<object id=gcem_fs02 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:15px;height:20px;position:relative;left:0px;top:3px">				
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=Format        value="#">
								<param name=PromptChar    value="_">
								<param name=UpperFlag     value=1>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object>
							<object id=gcem_fsdat02 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70px;height:20px;position:relative;left:0px;top:3px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Format        value="YYYY/MM/DD">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object>
							-&nbsp;
							<object id=gcem_fsnbr02 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:50px;height:20px;position:relative;left:0px;top:3px">				
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Format        value="######">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object>
							</comment><script>__ws__(__NSID__);</script>   
	                    </td>
	                     <td align="center" class="text" width="70">ȸ������</td>                                                                     
	                    <td bgcolor="#FFFFFF" >&nbsp;
	                    	<comment id="__NSID__">
							<object id=gcem_actdat02 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:2px;width:70px;height:20px;">
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script>   
	                    </td>
	    			
	    			 	<td align="center" class="text" width="70">��ǥ�μ�</td>   
                        <td bgcolor="#FFFFFF"  colspan=5 >&nbsp;
                             <input id="txt_deptcd"   type=text    style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; onkeydown="ln_Popup_Find2('txt_MAKER','03');" readOnly>
							 <img SRC="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('01');">
						     <input id="txt_deptnm" type="text"  style= "position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" onBlur="bytelength(this,this.value,36);" readOnly>			
                             <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="�� �����">
                         </td>
	    			</tr>
	       		</table>
	       	</td>
	 	</tr>
		
		<tr>
		<td>
			<table width="1000" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="position:relative;top:3px" align=left valign=top colspan=9>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp02 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:170px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<param name="dataid"			 value="ds_slipdtl">
							<param name="indwidth"		     value ='0'>
							<param name="borderstyle"        value="0">
							<param name="fillarea"		     value="true">
							<param name="ViewSummary"	     value=1>
							<param name="ColSizing"          value="true">
							<param name="Editable"           value="true">
							<param name="ColSelect"		     value=false>
							<param name="Format"		  	 value=" 
							    <FC>Name='����'	   ID=FSNUM 	    HeadBgColor=#B9D4DC   Width=30	    align=center     edit=none    </FC> 
								<FC>Name='�����ڵ�'  ID=ATCODE 	    HeadBgColor=#B9D4DC   Width=51      align=left	     edit=none   </FC> 
								<FC>Name='������'	   ID=ATKORNAM	    HeadBgColor=#B9D4DC   Width=170	    align=left	     edit=none   SumText='��   ��'</FC> 
								<FC>Name='�����ݾ�'  ID=DEAMT 	    HeadBgColor=#B9D4DC   Width=95      align=right	     edit=none   SumText={sum(Number(DEAMT))}  color =#0000FF  sumcolor =#0000FF  Value={Number(DEAMT)} </FC> 
								<FC>Name='�뺯�ݾ�'  ID=CRAMT 	    HeadBgColor=#B9D4DC   Width=95	    align=right      edit=none   SumText={sum(Number(CRAMT))}  color =#FF0000  sumcolor =#FF0000  Value={Number(CRAMT)}</FC> 										
								<C> Name='����'	   ID=REMARK        HeadBgColor=#B9D4DC   Width=205	    align=left	     SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right </C> 
								<C> Name='������'	   ID=DOCUMCD 	    HeadBgColor=#B9D4DC   Width=60	    align=left       edit=none   SumText='����-�뺯'  EditStyle=Combo Data='000:,101:���ݰ�꼭,102:��꼭,103:�ſ�ī��(����),104:���ݿ�����(����),201:�ſ�ī��(�Ұ�),202:���ְ���,203:���̿�����'</C> 
								<C> Name='����'	   ID=DOCUVAL     	HeadBgColor=#B9D4DC   Width=60    	align=left       edit=none   </C> 
								<C> Name='����'	   ID=FSWRKDIV 	    HeadBgColor=#B9D4DC   Width=40	    align=center     edit=none   EditStyle=Combo Data='01:������,02:����'  show =false</C> 
								<C> Name='�ŷ�ó'	   ID=VENDNM     	HeadBgColor=#B9D4DC   Width=100 	align=left       edit=none   </C> 
								<C> Name='�μ�'	   ID=FSRVALNM01 	HeadBgColor=#B9D4DC   Width=100	    align=left       edit=none   </C> 
								<C> Name='�����׸�3' ID=FSRVALNM03 	HeadBgColor=#B9D4DC   Width=100 	align=left	     edit=none   </C> 
								<C> Name='�����׸�4' ID=FSRVALNM04 	HeadBgColor=#B9D4DC   Width=100 	align=left	     edit=none   </C> 
								<C> Name='�����׸�5' ID=FSRVALNM05 	HeadBgColor=#B9D4DC   Width=100 	align=left	     edit=none   </C> 
								<C> Name='�����׸�6' ID=FSRVALNM06 	HeadBgColor=#B9D4DC   Width=100 	align=left	     edit=none   </C> 
								<C> Name='�����׸�7' ID=FSRVALNM07 	HeadBgColor=#B9D4DC   Width=100 	align=left	     edit=none   </C> 
								<C> Name='�����׸�8' ID=FSRVALNM08	HeadBgColor=#B9D4DC   Width=100 	align=left	     edit=none   </C> 
								<C> Name='�����׸�9' ID=FSRVALNM09 	HeadBgColor=#B9D4DC   Width=100 	align=left	     edit=none   </C> 
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			 </table>
			 
		  </td>
		  </tr>	
				
		   <tr>
		   <td style="position:relative;left:6px;top:4px" >
		   	  <table width="1000" cellpadding="1" cellspacing="0" border="0">		
				<tr>
					    <td width="25px"   class="tab32"    align=center  bgcolor="#B9D4DC" style="height:20px;" >����</td>
					    <td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" >
					    	<input type=text    id=txt_fsrefnm01    name=txt_fsrefnm01  value="�μ�"       size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					        <input type=hidden  id=txt_fsrefcd01    value=''>
							<input type=hidden  id=txt_fsrefseq01   value=''>
							<input type=hidden  id=txt_type01       value=''>
							<input type=hidden  id=txt_arbaldiv01   value=''>
					    </td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
							<input type=text    id=txt_fsrefnm03   name=txt_fsrefnm03  value="�����׸�3"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd03   value=''>
							<input type=hidden  id=txt_fsrefseq03  value=''>
							<input type=hidden  id=txt_type03      value=''>
							<input type=hidden  id=txt_arbaldiv03  value=''>					
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm04   name=txt_fsrefnm04  value="�����׸�4"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd04   value=''>
							<input type=hidden  id=txt_fsrefseq04  value=''>
							<input type=hidden  id=txt_type04      value=''>
							<input type=hidden  id=txt_arbaldiv04  value=''>
						</td>
						
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm05   name=txt_fsrefnm05  value="�����׸�5"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd05   value=''>
							<input type=hidden  id=txt_fsrefseq05  value=''>
							<input type=hidden  id=txt_type05      value=''>
							<input type=hidden  id=txt_arbaldiv05  value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm06   name=txt_fsrefnm06  value="�����׸�6"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd06   value=''>
							<input type=hidden  id=txt_fsrefseq06  value=''>
							<input type=hidden  id=txt_type06      value=''>
							<input type=hidden  id=txt_arbaldiv06  value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm07   name=txt_fsrefnm07  value="�����׸�7"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd07   value=''>
							<input type=hidden  id=txt_fsrefseq07  value=''>
							<input type=hidden  id=txt_type07      value=''>
							<input type=hidden  id=txt_arbaldiv07  value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm08   name=txt_fsrefnm08  value="�����׸�8"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd08   value=''>
							<input type=hidden  id=txt_fsrefseq08  value=''>
							<input type=hidden  id=txt_type08      value=''>
							<input type=hidden  id=txt_arbaldiv08  value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm09   name=txt_fsrefnm09  value="�����׸�9"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd09   value=''>
							<input type=hidden  id=txt_fsrefseq09  value=''>
							<input type=hidden  id=txt_type09      value=''>
							<input type=hidden  id=txt_arbaldiv09  value=''>
							
							<input type=hidden  id=hid_banjaeref   value=''><!--��������-->
							<input type=hidden  id=hid_banjaeyn    value=''><!--��������-->
							<input type=hidden  id=hid_atdecr      value=''><!--���뱸��-->
							<input type=hidden  id=hid_bgtdiv      value=''><!--����-->
							<input type=hidden  id=hid_divcd       value=''><!--����-->
							<!--�ŷ�ó-->
							<input type=hidden  id=txt_fsrefcd02   value=''>
							<input type=hidden  id=txt_fsrefseq02  value=''>
							<input type=hidden  id=txt_type02      value=''>
							<input type=hidden  id=txt_arbaldiv02  value=''>
						</td>
					</tr>	
					<tr>
					    <td width="24px"   class="tab25"   align=center  style="height:22px;" >
					         <comment id="__NSID__">
					    	 <object id=gcem_fsnum         classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:24px;height:18;position:relative;top:3px;">				
								<param name=Text		   value="">
								<param name=Border         value=false>
							    <param name=Format         value="000">
								<param name=Enable         value=false>
								<param name=GeneralEdit    value="true">
								<param name=BackColor      value="#CCCCCC">
								<param name=InheritColor   value=false> 
							</object></comment><script>__ws__(__NSID__);</script>
					    </td>
					    <td width="117px" class="tab26"     align=center  >
					    	<comment id="__NSID__">
					   	    <object id=gcem_fsrvalnm01  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		   value="">
							<param name=Border         value=false>
							<param name=Format         value="">
							<param name=GeneralEdit    value="true">
							<param name=BackColor      value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type=hidden  id=txt_fsrefval01   value=''>
					    </td>
						<td width="117px" class="tab26"     align=center >
						    <comment id="__NSID__">
							<object id=gcem_fsrvalnm03  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		  value="">
							<param name=Border        value=false>
							<param name=Format        value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type=hidden  id=txt_fsrefval03   value=''>
						</td>
						<td width="117px" class="tab26"     align=center > 
						    <comment id="__NSID__">
						 	<object id=gcem_fsrvalnm04  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		    value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit     value="true">
							<param name=BackColor       value="#CCCCCC">
							<param name=InheritColor    value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type=hidden  id=txt_fsrefval04   value=''>
						</td>
						<td width="117px" class="tab26"     align=center >
						    <comment id="__NSID__">
							<object id=gcem_fsrvalnm05  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		    value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit     value="true">
							<param name=BackColor       value="#CCCCCC">
							<param name=InheritColor    value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type=hidden  id=txt_fsrefval05   value=''>
						</td>
						<td width="117px" class="tab26"     align=center >
						    <comment id="__NSID__"> 
							<object id=gcem_fsrvalnm06  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		    value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit     value="true">
							<param name=BackColor       value="#CCCCCC">
							<param name=InheritColor    value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type=hidden  id=txt_fsrefval06   value=''>
						</td>
						<td width="117px" class="tab26"     align=center >
						    <comment id="__NSID__">
							<object id=gcem_fsrvalnm07  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		    value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit     value="true">
							<param name=BackColor       value="#CCCCCC">
							<param name=InheritColor    value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type=hidden  id=txt_fsrefval07   value=''>
						</td>
						<td width="117px" class="tab26"     align=center >
			                <comment id="__NSID__">
							<object id=gcem_fsrvalnm08  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		    value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit     value="true">
							<param name=BackColor       value="#CCCCCC">
							<param name=InheritColor    value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type=hidden  id=txt_fsrefval08   value=''>
						</td>
						
						<td width="117px" class="tab26"     align=center>
						    <comment id="__NSID__">
							<object id=gcem_fsrvalnm09  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="color:#990000;width:115px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		    value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit     value="true">
							<param name=BackColor       value="#CCCCCC">
							<param name=InheritColor    value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							<input type="hidden"  id=txt_fsrefval09   value=''>
						</td>	
					</tr>
			</table>	
			
			<font size="2" color="black" >&nbsp;  [��������]�� ���������� �����ڱݽ�û�� ��� �� �˴ϴ�.</font>		
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


<comment id="__NSID__"><object id="gcrp_print" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<param name="MasterDataID"		value="gcds_rptmst">
	<param name="DetailDataID"		value="gcds_rptdtl">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"    value="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="Format"			value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=527 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=74 ,top=204 ,right=913 ,bottom=278 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=69 ,top=191 ,right=902 ,bottom=270 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� ��  �� ��  �� û ��' ,left=71 ,top=198 ,right=894 ,bottom=259 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=2400 ,top=11 ,right=2400 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=1987 ,top=69 ,right=2040 ,bottom=108 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1987 ,top=148 ,right=2040 ,bottom=191 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2143 ,top=212 ,right=2127 ,bottom=241 </L>
	<L> left=2320 ,top=212 ,right=2305 ,bottom=241 </L>
	<L> left=2492 ,top=212 ,right=2477 ,bottom=241 </L>
	<L> left=2678 ,top=212 ,right=2662 ,bottom=241 </L>
	<L> left=2760 ,top=11 ,right=2760 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2577 ,top=11 ,right=2577 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2225 ,top=11 ,right=2225 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=11 ,right=2045 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=251 ,right=2760 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=198 ,right=2760 ,bottom=198 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=8 ,right=2760 ,bottom=8 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=11 ,right=2760 ,bottom=11 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=69 ,right=2760 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=2585 ,top=16 ,right=2754 ,bottom=64 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ��' ,left=2408 ,top=16 ,right=2577 ,bottom=64 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2228 ,top=16 ,right=2397 ,bottom=64 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=2051 ,top=16 ,right=2223 ,bottom=64 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1982 ,top=11 ,right=1982 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=1987 ,top=278 ,right=2040 ,bottom=318 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1987 ,top=318 ,right=2040 ,bottom=357 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1987 ,top=357 ,right=2040 ,bottom=397 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1987 ,top=397 ,right=2040 ,bottom=439 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1987 ,top=439 ,right=2040 ,bottom=479 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2143 ,top=460 ,right=2127 ,bottom=489 </L>
	<L> left=2320 ,top=460 ,right=2305 ,bottom=489 </L>
	<L> left=2492 ,top=460 ,right=2477 ,bottom=489 </L>
	<L> left=2678 ,top=460 ,right=2662 ,bottom=489 </L>
	<L> left=2760 ,top=259 ,right=2760 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2577 ,top=259 ,right=2577 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2400 ,top=259 ,right=2400 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2225 ,top=259 ,right=2225 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=259 ,right=2045 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=500 ,right=2760 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=447 ,right=2760 ,bottom=447 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=257 ,right=2760 ,bottom=257 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=259 ,right=2760 ,bottom=259 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=318 ,right=2760 ,bottom=318 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=2585 ,top=265 ,right=2754 ,bottom=312 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ��' ,left=2408 ,top=265 ,right=2577 ,bottom=312 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2228 ,top=265 ,right=2397 ,bottom=312 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=2051 ,top=265 ,right=2223 ,bottom=312 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1982 ,top=259 ,right=1982 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�� û �� �� :' ,left=74 ,top=318 ,right=304 ,bottom=378 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��   �� :' ,left=74 ,top=381 ,right=304 ,bottom=434 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� ȣ :' ,left=74 ,top=439 ,right=304 ,bottom=500 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='APPDT', left=304, top=318, right=765, bottom=378, align='left' ,mask='XXXX/XX/XX', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='EMPNMK', left=304, top=384, right=765, bottom=437, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SLIPNO', left=304, top=442, right=765, bottom=503, align='left' ,mask='XXXXXXXXX-XXXXXX', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=101 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='����' ,left=82 ,top=50 ,right=151 ,bottom=90 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=64 ,top=3 ,right=64 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=265 ,top=3 ,right=265 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=3 ,right=265 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1725 ,top=3 ,right=1725 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=183 ,top=13 ,right=251 ,bottom=53 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2352 ,top=3 ,right=2352 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=5 ,right=468 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=709 ,top=5 ,right=709 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1032 ,top=5 ,right=1032 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=3 ,right=2765 ,bottom=3 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=98 ,right=2765 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=3 ,right=2765 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���ޱ���' ,left=278 ,top=21 ,right=458 ,bottom=85 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ޱ���' ,left=503 ,top=21 ,right=675 ,bottom=85 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=722 ,top=21 ,right=1021 ,bottom=85 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ŷ�ó' ,left=1048 ,top=21 ,right=1715 ,bottom=82 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1741 ,top=21 ,right=2342 ,bottom=85 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û�ݾ�' ,left=2373 ,top=21 ,right=2754 ,bottom=85 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=64 ,top=0 ,right=64 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=265 ,top=0 ,right=265 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=0 ,right=468 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='APPDATE', left=74, top=3, right=257, bottom=61 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{IF(curlevel=2,,IF(curlevel=1,,REQDATE))}', left=278, top=3, right=458, bottom=61 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'�Ұ�\',PAYGBNM)}', left=479, top=0, right=706, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=709 ,top=0 ,right=709 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ATKORNAM', left=720, top=0, right=1021, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCD', left=1048, top=0, right=1204, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDNM', left=1214, top=0, right=1715, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=64 ,top=66 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1032 ,top=0 ,right=1032 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1725 ,top=0 ,right=1725 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=1738, top=0, right=2339, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2352 ,top=0 ,right=2352 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='APPAMT', left=2373, top=3, right=2754, bottom=61, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=317 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=265 ,top=0 ,right=265 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=0 ,right=64 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�հ�' ,left=71 ,top=3 ,right=259 ,bottom=61 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=468 ,top=0 ,right=468 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=66 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=709 ,top=0 ,right=709 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1032 ,top=0 ,right=1032 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1725 ,top=0 ,right=1725 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2352 ,top=0 ,right=2352 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(APPAMT)}' ,left=2373 ,top=0 ,right=2754 ,bottom=58 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B>


">
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
  <comment id="__NSID__">  
    <object  id=gcbn_data02   classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID        value=ds_slipdtl>
	<param name=BindInfo      value='  
	<C>Col=FDCODE           Ctrl=hid_fdcode   	    Param=value</C>
	<C>Col=FSDAT            Ctrl=hid_fsdat          Param=value</C>
    <C>Col=FSNBR            Ctrl=hid_fsnbr          Param=value</C>
	<C>Col=FSSEQ            Ctrl=hid_fsseq          Param=value</C>
	<C>Col=ATCODE           Ctrl=gcem_atcode02      Param=Text</C>
	<C>Col=ATKORNAM         Ctrl=gcem_atkornam02	Param=Text</C>
	<C>Col=ATDECR           Ctrl=hid_atdecr	        Param=value</C>
	<C>Col=REMARK           Ctrl=gcem_remark02_1    Param=Text</C>
	<C>Col=CHAAMT           Ctrl=gcem_detot02  	    Param=Text</C>
	<C>Col=DAEAMT           Ctrl=gcem_crtot02       Param=Text</C>
	<C>Col=FSREFSEQ01       Ctrl=txt_fsrefseq01     Param=value</C>
	<C>Col=FSREFSEQ02       Ctrl=txt_fsrefseq02     Param=value</C>
	<C>Col=FSREFSEQ03       Ctrl=txt_fsrefseq03     Param=value</C>
	<C>Col=FSREFSEQ04       Ctrl=txt_fsrefseq04     Param=value</C>
	<C>Col=FSREFSEQ05       Ctrl=txt_fsrefseq05	    Param=value</C>
	<C>Col=FSREFSEQ06       Ctrl=txt_fsrefseq06     Param=value</C>
    <C>Col=FSREFSEQ07       Ctrl=txt_fsrefseq07     Param=value</C>
	<C>Col=FSREFSEQ08       Ctrl=txt_fsrefseq08     Param=value</C>
	<C>Col=FSREFSEQ09       Ctrl=txt_fsrefseq09     Param=value</C>
	<C>Col=FSREFCD01        Ctrl=txt_fsrefcd01		Param=value</C>
	<C>Col=FSREFCD02        Ctrl=txt_fsrefcd02	   	Param=value</C>
	<C>Col=FSREFCD03        Ctrl=txt_fsrefcd03     	Param=value</C>
	<C>Col=FSREFCD04        Ctrl=txt_fsrefcd04	   	Param=value</C>
	<C>Col=FSREFCD05        Ctrl=txt_fsrefcd05     	Param=value</C>
	<C>Col=FSREFCD06        Ctrl=txt_fsrefcd06     	Param=value</C>
	<C>Col=FSREFCD07        Ctrl=txt_fsrefcd07     	Param=value</C>
	<C>Col=FSREFCD08        Ctrl=txt_fsrefcd08     	Param=value</C>
	<C>Col=FSREFCD09        Ctrl=txt_fsrefcd09     	Param=value</C>
	<C>Col=FSREFVAL01       Ctrl=txt_fsrefval01     Param=value</C>
    <C>Col=FSREFVAL03       Ctrl=txt_fsrefval03     Param=value</C>
	<C>Col=FSREFVAL04       Ctrl=txt_fsrefval04     Param=value</C>
	<C>Col=FSREFVAL05       Ctrl=txt_fsrefval05     Param=value</C>
	<C>Col=FSREFVAL06       Ctrl=txt_fsrefval06		Param=value</C>
	<C>Col=FSREFVAL07       Ctrl=txt_fsrefval07	    Param=value</C>
	<C>Col=FSREFVAL08       Ctrl=txt_fsrefval08     Param=value</C>
	<C>Col=FSREFVAL09       Ctrl=txt_fsrefval09	    Param=value</C>
	<C>Col=FSREFNM01        Ctrl=txt_fsrefnm01		Param=value</C>
	<C>Col=FSREFNM03        Ctrl=txt_fsrefnm03		Param=value</C>
	<C>Col=FSREFNM04        Ctrl=txt_fsrefnm04		Param=value</C>
	<C>Col=FSREFNM05        Ctrl=txt_fsrefnm05		Param=value</C>
	<C>Col=FSREFNM06        Ctrl=txt_fsrefnm06		Param=value</C>
	<C>Col=FSREFNM07        Ctrl=txt_fsrefnm07		Param=value</C>
    <C>Col=FSREFNM08        Ctrl=txt_fsrefnm08		Param=value</C>
	<C>Col=FSREFNM09        Ctrl=txt_fsrefnm09		Param=value</C>
	<C>Col=FSRVALNM01       Ctrl=gcem_fsrvalnm01    Param=Text</C>
	<C>Col=FSRVALNM03       Ctrl=gcem_fsrvalnm03	Param=Text</C>
	<C>Col=FSRVALNM04       Ctrl=gcem_fsrvalnm04    Param=Text</C>
	<C>Col=FSRVALNM05       Ctrl=gcem_fsrvalnm05	Param=Text</C>
	<C>Col=FSRVALNM06       Ctrl=gcem_fsrvalnm06    Param=Text</C>
	<C>Col=FSRVALNM07       Ctrl=gcem_fsrvalnm07    Param=Text</C>
	<C>Col=FSRVALNM08       Ctrl=gcem_fsrvalnm08    Param=Text</C>
	<C>Col=FSRVALNM09       Ctrl=gcem_fsrvalnm09    Param=Text</C>
	<C>Col=TYPE01           Ctrl=txt_type01			Param=value</C>
	<C>Col=TYPE02           Ctrl=txt_type02			Param=value</C>
	<C>Col=TYPE03           Ctrl=txt_type03			Param=value</C>
    <C>Col=TYPE04           Ctrl=txt_type04			Param=value</C>
	<C>Col=TYPE05           Ctrl=txt_type05			Param=value</C>
	<C>Col=TYPE06           Ctrl=txt_type06			Param=value</C>
	<C>Col=TYPE07           Ctrl=txt_type07			Param=value</C>
	<C>Col=TYPE08           Ctrl=txt_type08			Param=value</C>
	<C>Col=TYPE09           Ctrl=txt_type09			Param=value</C>
	<C>Col=ARBALDIV1        Ctrl=txt_arbaldiv01	    Param=value</C>          
	<C>Col=ARBALDIV2        Ctrl=txt_arbaldiv02     Param=value</C>
	<C>Col=ARBALDIV3        Ctrl=txt_arbaldiv03     Param=value</C>
	<C>Col=ARBALDIV4        Ctrl=txt_arbaldiv04     Param=value</C>
	<C>Col=ARBALDIV5        Ctrl=txt_arbaldiv05     Param=value</C>
	<C>Col=ARBALDIV6        Ctrl=txt_arbaldiv06     Param=value</C>
	<C>Col=ARBALDIV7        Ctrl=txt_arbaldiv07	    Param=value</C>
	<C>Col=ARBALDIV8        Ctrl=txt_arbaldiv08     Param=value</C>
    <C>Col=ARBALDIV9        Ctrl=txt_arbaldiv09     Param=value</C>
	<C>Col=CNT              Ctrl=hid_cnt            Param=value</C>
	<C>Col=DOCUMCD          Ctrl=gclx_documcd02     Param=BindColVal</C>
	<C>Col=BANJAEYN         Ctrl=hid_banjaeyn       Param=value</C>
	<C>Col=FSSTAT           Ctrl=hid_fsstat         Param=value</C>
	<C>Col=DOCUVAL          Ctrl=hid_docuval        Param=value</C>
    <C>Col=FSNUM            Ctrl=gcem_fsnum	        Param=Text</C>
	<C>Col=DIVCD            Ctrl=hid_divcd          Param=value</C>
    <C>Col=BGTDIV           Ctrl=hid_bgtdiv         Param=value</C>
	<C>Col=FUNDDIV          Ctrl=hid_funddiv        Param=value</C>
	<C>Col=BANJAEREF        Ctrl=hid_banjaeref      Param=value</C>
	<C>Col=LASTREF          Ctrl=hid_lastref        Param=value</C>
	<C>Col=BANJAEMOD        Ctrl=hid_banjaemod      Param=value</C>
	<C>Col=ATCURTYPE        Ctrl=hid_atcurtype      Param=value</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

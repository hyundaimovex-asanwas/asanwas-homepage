<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - �̿�����Ÿ ����(������)	
+ ���α׷� ID	:  A020007.html
+ �� �� �� ��	: 
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2006.02.04
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� �� :	 1. ��ȭ ȯ����ȯ ���μ��� ����
                 ���� ==> ������, ����, ��� ȯ���� �޷��ݾ��� �ϰ������� ���ؼ� ����.
								 ���� ==> ������ ȯ�� �� ����ڻ�, ���޺��, �����ڻ�, �����ڻ�, �������� ����
								          �����׸� ��ȭ�ݾ� �ʵ忡 �Էµ� ����Ÿ�� ������.

+ ��   ��  �� :  ��  ��  ��
+ �� �� �� �� :  2006.11.16

-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��ǥ����</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

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
//get_cookdata();
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;

var gs_cashamt =0;        //���ݱݾ�
var gs_chadae_gubun="";   //���ݰ����� ���� ���� 1-��������, 2-���ݴ뺯
var gs_Eqcashamt =0;      //���ݵ���ݾ�
var gs_Eqchadae_gubun=""; //���ݵ�������� ���� ���� 1-���ݵ������, 2-���ݵ���뺯
var gs_decash=0;          //��������
var gs_Eqcrcash=0;        //�뺯���ݵ���ݾ�
var gs_Eqdecash=0;        //�������ݵ���ݾ�
var gs_crcash=0;        //�뺯����
var gs_totcnt=0;        //����� ���õ� ��� ��ǥ�� ����.(����)
var gs_Etotcnt=0;       //����� ���õ� ��� ��ǥ�� ����.(���ݵ��)
var gs_cnt=0;           //��ü�Ǽ�
var gs_failcnt=0;       //�� ���аǼ�
var gs_succcnt=0;       //�� �����Ǽ�

var gs_Total_cnt=0;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

 	ln_Before();
	gcem_fsdat_fr.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + '01';
	//gcem_fsdat_fr.text ='2006'+ gcurdate.substring(5,7) + '01';
	gcem_fsdat_to.text = gs_date;
  //gcem_date.text = gs_date;
  //alert("gs_userid"+gs_userid);
    txt_empno.value = gs_userid;
	txt_empnmk.value = gs_usernm;
    gclx_fsstat.index=2;
	//gclx_gubun.index=1;

	gclx_fdcode.bindcolval=gs_fdcode;

	ln_Count();
	
}

function ln_Count(){
  
  //gs_cnt+=1;
  //txt_count.value=gs_cnt+"/"+gs_Total_cnt;
	//setTimeout("ln_Count()", 100);

}

/******************************************************************************
	Description : �ε�
******************************************************************************/
function ln_Before(){
	 //����
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();

	//login �ڿ� ������ matchingȮ��
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0900&v_str2="+gs_userid;
	//prompt("",gcds_login.DataID);
	gcds_login.Reset();

  if( gcds_login.countrow>0){
		txt_gubun.value=gcds_login.namevalue(gcds_login.rowposition,"CDREMARK");
		hid_gubun.value=gcds_login.namevalue(gcds_login.rowposition,"GBCD");
	}else{
		alert("�����ڰ� �ƴմϴ�. Ȯ�ιٶ��ϴ�.");
		return;
	}

  //�ݰ��� �޷�ȯ��
  gcds_exrate.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_exrate_s1?v_str1=02&v_str2=";
	//prompt("",gcds_exrate.DataID);
	gcds_exrate.Reset();

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s1?v_str1="+gcem_fsdat_fr.text
																									 +"&v_str2="+gcem_fsdat_to.text
																									 +"&v_str3="+""
																									 +"&v_str4="+gclx_fsstat.bindcolval
																									 +"&v_str5="+''//gclx_gubun.bindcolval
																									 +"&v_str6="+gclx_fdcode.bindcolval
																									 +"&v_str7="+txt_remark.value
																									 +"&v_str8="+hid_gubun.value; //���� ���� 01 -ȸ��, 02-����																											
  //prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();									
	gs_cnt=0;
	gs_succcnt=0;
	gs_failcnt=0;
}


/******************************************************************************
	Description : ���� ���� �ݿ�
******************************************************************************/
function ln_Bgt_Result_Batch(){
	if (gcds_bgtresult.countrow<1){
			var s_temp = "SYEAR:STRING,SFRMM:STRING,STOMM:STRING";
			gcds_bgtresult.SetDataHeader(s_temp);
		}

		var strfryymmdd = gcem_fsdat_fr.text;
		var strtoyymmdd = gcem_fsdat_to.text;
    var stryy = strfryymmdd.substring(0,4);
		var strfrmm = strfryymmdd.substring(4,6);
		var strtomm = strtoyymmdd.substring(4,6);

    gcds_bgtresult.addrow();
    gcds_bgtresult.namevalue(gcds_bgtresult.rowposition,"SYEAR")=stryy;
		gcds_bgtresult.namevalue(gcds_bgtresult.rowposition,"SFRMM")=strfrmm;
		gcds_bgtresult.namevalue(gcds_bgtresult.rowposition,"STOMM")=strtomm;

    gctr_bgtresult.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_bgt_result_t1?";
		prompt("gcds_bgtresult",gcds_bgtresult.text);
		gctr_bgtresult.post();																 
    gcds_bgtresult.ClearAll();
}

/******************************************************************************
	Description : �̿� �ڷ� �߰�
******************************************************************************/
function ln_Forward_Batch(){

  ln_SetDataHeader("99");
	for(i=1;i<=gcds_data01.countrow;i++){
		if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="R")||(gcds_data01.namevalue(i,"ACCSGNEND")=="C"))){
			ln_Forward_Batch_Data(i);
			gctr_data99.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t3?";
		  //prompt("gcds_data03",gcds_data03.text);
			gctr_data99.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
			//prompt("gcds_data99",gcds_data99.text);
			gctr_data99.post();
			gcds_data99.ClearData();
		}	
	}
}

/******************************************************************************
	Description : ����Ÿ ����
******************************************************************************/
function ln_Forward_Batch_Data(i){
  gcds_data99.addrow();

  gcds_data99.namevalue(gcds_data99.countrow,"FDCODE") = gcds_data01.namevalue(i,"FDCODE");
	gcds_data99.namevalue(gcds_data99.countrow,"FSDAT") = gcds_data01.namevalue(i,"FSDAT");
	gcds_data99.namevalue(gcds_data99.countrow,"FSNBR") = gcds_data01.namevalue(i,"FSNBR");
	gcds_data99.namevalue(gcds_data99.countrow,"FSSEQ") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSNUM") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"ATCODE") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"ATDECR") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"DEAMT") =0;
	gcds_data99.namevalue(gcds_data99.countrow,"CRAMT") =0;
	gcds_data99.namevalue(gcds_data99.countrow,"COCODE") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"DIVCD") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"DEPTCD") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"DECASH") =0;
	gcds_data99.namevalue(gcds_data99.countrow,"CRCASH") =0;
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD01") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD02") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD03") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD04") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD05") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD06") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD07") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD08") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFCD09") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL01") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL02") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL03") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL04") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL05") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL06") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL07") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL08") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"FSREFVAL09") ="";
	gcds_data99.namevalue(gcds_data99.countrow,"DEUPAMT") =0;
	gcds_data99.namevalue(gcds_data99.countrow,"CRUPAMT") =0;
}
/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : üũ
	Parameter   :  p - ����  01 ����, 02, �������, 03 - �ݼ۰�
******************************************************************************/
function ln_Chk(p){
	
	if (p=='01'){
     
    if(hid_gubun.value=="02") {
			alert("������ ���� �� �� �����ϴ�.");
			return false;
    }

		for(a=1;a<=gcds_data01.countrow;a++){
			if(gcds_data01.namevalue(a,"CHK")=="T" && gcds_data01.namevalue(a,"ACCSGNEND")=="Y"){
			  alert("����Ϸ���� �����մϴ�. Ȯ���Ͻʽÿ�.");
				return false;
			}
		}
		return true;
	}

 if (p=='02'){
		if(hid_gubun.value=="02") {
			alert("������ ������� �� �� �����ϴ�.");
			return false;
    }
		
		for(a=1;a<=gcds_data01.countrow;a++){
			if(gcds_data01.namevalue(a,"CHK")=="T" && gcds_data01.namevalue(a,"ACCSGNEND")!="Y"){
			  alert("����Ϸ���� �ƴմϴ�. Ȯ���Ͻʽÿ�.");
				return false;
			}
		}
			return true;
	}

	if (p=='03'){
		for(a=1;a<=gcds_data01.countrow;a++){
			if(gcds_data01.namevalue(a,"CHK")=="T" && gcds_data01.namevalue(a,"ACCSGNEND")=="Y"){
			  alert("����Ϸ���Դϴ�. Ȯ���Ͻʽÿ�.");
				return false;
			}
		}
			return true;
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

  ln_SetDataHeader('01');
	ln_SetDataHeader('09');
	ln_SetDataHeader('10');
	gs_failcnt=0;       //�� ���аǼ�
  gs_succcnt=0;       //�� �����Ǽ�

	if(ln_Chk('01')){
		if(confirm("�����Ͻðڽ��ϱ�?")){

			ln_Detail();
			ln_Msg(); 
			ln_Query();
			gcds_data03.ClearData();
    
		}
	}
}

/******************************************************************************
	Description : ��ǥ��ȣ�� ��ǥ Detail����Ÿ�� ��ȸ �� ����Ÿ�� �ѱ�
	parameter   :
******************************************************************************/
function ln_Detail(){

	var tempDataSet="";
	var stractyymm = ""; //ȸ����
	var strexyymm ="";   //ȯ�����س��
	var strexrate ="";   //ȯ��	
  gs_Total_cnt=0;

  
/**
	for(i=1;i<=gcds_data01.countrow;i++){
		if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="R")||(gcds_data01.namevalue(i,"ACCSGNEND")=="C"))){
      gs_Total_cnt+=1;
		}
	}
**/
  document.all.LowerFrame2.style.visibility="visible";
	for(i=1;i<=gcds_data01.countrow;i++){
		gs_totcnt=0;
		gs_Etotcnt=0;
		tempDataSet="";

		if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="R")||(gcds_data01.namevalue(i,"ACCSGNEND")=="C"))){
			  gs_cnt+=1;
				
				//ln_Count();
				gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s2?v_str1="+gcds_data01.namevalue(i,"FDCODE")
																										     +"&v_str2="+gcds_data01.namevalue(i,"FSDAT")
																										 	   +"&v_str3="+gcds_data01.namevalue(i,"FSNBR");
       // prompt("",gcds_data02.DataID );																							
	      gcds_data02.Reset();
				
        tempDataSet = gcds_data02.ExportData(1,gcds_data02.CountRow,false);
				gcds_data03.ImportData(tempDataSet);
        
        if(ln_Chk_Cash()){//���ݰ���üũ  (���ݿ�ȭ, ���ݿ�ȭ)
					ln_Cash()
				}

        /* �ӽ÷� ����.
				if(ln_Chk_EqCash()){//���ݵ��
				  alert("���ݵ������");
          ln_EqCash()
				}
				*/
  
				ln_Date(i);   //��������
				ln_Exrate();  //�ݰ��� ȯ�� ����
        gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t1?";
   			//prompt("gcds_data03",gcds_data03.text);
				gctr_data01.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid+",v_str3=" + gs_fdcode;
				gctr_data01.post();
		}
	}
	document.all.LowerFrame2.style.visibility="hidden";
}

/******************************************************************************
	Description : �ݰ��� ������ ��� ȯ�� ����
	parameter   : 
	ref         : �������� ���� ȯ�� ������ �޸��Ѵ�.
	              <����>                        �����ڵ� ù�ڸ�
	              1. �ڻ�/��ä - ���� ȯ��       1 / 2 
								2. �ں�      - ������ ȯ��     3
								3. ����/��� - ���ȯ��        4
								����.�������̺����� ATCURTYPE = 'Y' �� ���� ������ȯ�� ������.
								==> ���� ATCURTYPE = 'Y' �� ��� �� ��ȭ�ݾ��� �״�� ������. EXRATEGB ='9'
******************************************************************************/
function ln_Exrate(i){
   var strAtcode=""; //�����ڵ�
	 var stryymm="";   //ȸ����
	 var temp="";
	 var tempval=0;
	 for(s=1;s<=gcds_data03.countrow;s++){
	    if(gcds_data03.namevalue(s,"FDCODE")=="03"){
        
				//�ݾ׺��� -- ��ȭ�� ��ȭ�� ����.///////////////////////////////////////////////////////////
        //�Ѱ�������
				/*
        gcds_data03.namevalue(s,"FODEAMT")=gcds_data03.namevalue(s,"DEAMT");     //����       DETOT
				gcds_data03.namevalue(s,"FOCRAMT")=gcds_data03.namevalue(s,"CRAMT");     //�뺯       CRTOT
        gcds_data03.namevalue(s,"FODECASH")=gcds_data03.namevalue(s,"DECASH");   //��������
				gcds_data03.namevalue(s,"FOCRCASH")=gcds_data03.namevalue(s,"CRCASH");   //�뺯����
				gcds_data03.namevalue(s,"FOEDECASH")=gcds_data03.namevalue(s,"EDECASH"); //�������ݵ�� 
				gcds_data03.namevalue(s,"FOECRCASH")=gcds_data03.namevalue(s,"ECRCASH"); //�뺯���ݵ��

        //����
				gcds_data03.namevalue(s,"FODEUPTOT")=gcds_data03.namevalue(s,"DEUPTOT");  //���������ݾ�
				gcds_data03.namevalue(s,"FOCRUPTOT")=gcds_data03.namevalue(s,"CRUPTOT");  //�뺯�����ݾ�
        gcds_data03.namevalue(s,"FODEUPCASH")=gcds_data03.namevalue(s,"DEUPCASH"); //������������
				gcds_data03.namevalue(s,"FOCRUPCASH")=gcds_data03.namevalue(s,"CRUPCASH"); //�뺯��������

				gcds_data03.namevalue(s,"DEAMT")=0;
				gcds_data03.namevalue(s,"CRAMT")=0;
				gcds_data03.namevalue(s,"DECASH")=0;
				gcds_data03.namevalue(s,"CRCASH")=0;
				gcds_data03.namevalue(s,"EDECASH")=0;
				gcds_data03.namevalue(s,"ECRCASH")=0;
				gcds_data03.namevalue(s,"DEUPTOT")=0;
				gcds_data03.namevalue(s,"CRUPTOT")=0;
				gcds_data03.namevalue(s,"DEUPCASH")=0;
				gcds_data03.namevalue(s,"CRUPCASH")=0;
			  */
				///////////////////////////////////////////////////////////////////////////////////////////  

        stryymm = gcds_data03.namevalue(s,"ACTDAT")
        stryymm = stryymm.substring(0,6) 
				//alert("ATCURTYPE"+gcds_data03.namevalue(s,"ATCURTYPE"));
        //��ȭ�ݾ��� �������� ������ ���� ����.

				 stryymm = gcds_data03.namevalue(s,"ACTDAT")
        stryymm = stryymm.substring(0,6) 
				//alert("ATCURTYPE"+gcds_data03.namevalue(s,"ATCURTYPE"));
				if(gcds_data03.namevalue(s,"ATCURTYPE")=="Y"){
					 gcds_data03.namevalue(s,"EXRATE")=1;      //ȯ���� �׻� 1�� ��.
					 gcds_data03.namevalue(s,"EXRATEDT")=stryymm||"00";    
					 gcds_data03.namevalue(s,"EXRATEGB")='9';  //��ȭ�ݾ��� �׷��� ������.
				}else{
				  strAtcode = gcds_data03.namevalue(s,"ATCODE");
					strAtcode=strAtcode.substring(0,1);
					if(strAtcode == "1"|| strAtcode =="2" ){ 
					  gcds_data03.namevalue(s,"EXRATE")= 0;   //����ȯ��
						//gcds_data03.namevalue(s,"EXRATE")= ln_Exrate_find('02',stryymm);   //����ȯ��
						gcds_data03.namevalue(s,"EXRATEDT")="";     
						gcds_data03.namevalue(s,"EXRATEGB")='1';                         //
					}else if(strAtcode == "3"){               
						gcds_data03.namevalue(s,"EXRATE")=ln_Exrate_find('01',stryymm);  //������ȯ��
						gcds_data03.namevalue(s,"EXRATEDT")=stryymm||"00";    
						gcds_data03.namevalue(s,"EXRATEGB")='3';                         //������ȯ�� ���
						ln_Exrate_Data(s,gcds_data03.namevalue(s,"EXRATE"));
					}else if(strAtcode == "4"){               
					  gcds_data03.namevalue(s,"EXRATE")=0;  //���ȯ��
						//gcds_data03.namevalue(s,"EXRATE")=ln_Exrate_find('03',stryymm);  //���ȯ��
						gcds_data03.namevalue(s,"EXRATEDT")="";    
						gcds_data03.namevalue(s,"EXRATEGB")='4';                         //
					}
				}
			}
	 }
}

/******************************************************************************
	Description : ������ ȯ���� ��ȭ�ݾ� ����
	parameter   : p1 - row
	              p2 - ȯ��
******************************************************************************/
function ln_Exrate_Data(p1, p2){
 // alert("row"+p1+"ȯ��"+p2);
 
	//�Ѱ�������
	gcds_data03.namevalue(s,"FODEAMT")=gcds_data03.namevalue(s,"CHAAMT")*p2;     //����       DETOT
	gcds_data03.namevalue(s,"FOCRAMT")=gcds_data03.namevalue(s,"DAEAMT")*p2;     //�뺯       CRTOT
	gcds_data03.namevalue(s,"FODECASH")=gcds_data03.namevalue(s,"DECASH")*p2;   //��������
	gcds_data03.namevalue(s,"FOCRCASH")=gcds_data03.namevalue(s,"CRCASH")*p2;   //�뺯����
	gcds_data03.namevalue(s,"FOEDECASH")=gcds_data03.namevalue(s,"EDECASH")*p2; //�������ݵ�� 
	gcds_data03.namevalue(s,"FOECRCASH")=gcds_data03.namevalue(s,"ECRCASH")*p2; //�뺯���ݵ��

	//����
	gcds_data03.namevalue(s,"FODEUPTOT")=gcds_data03.namevalue(s,"CHAUPAMT")*p2;  //���������ݾ�
	gcds_data03.namevalue(s,"FOCRUPTOT")=gcds_data03.namevalue(s,"DAEUPAMT")*p2;  //�뺯�����ݾ�
	gcds_data03.namevalue(s,"FODEUPCASH")=gcds_data03.namevalue(s,"DEUPCASH")*p2; //������������
	gcds_data03.namevalue(s,"FOCRUPCASH")=gcds_data03.namevalue(s,"CRUPCASH")*p2; //�뺯��������

	/*alert("FODEAMT"+gcds_data03.namevalue(s,"FODEAMT")+"CHAAMT"+gcds_data03.namevalue(s,"CHAAMT"));
	alert("FOCRAMT"+gcds_data03.namevalue(s,"FOCRAMT")+"DAEAMT"+gcds_data03.namevalue(s,"DAEAMT"));
	alert("FODECASH"+gcds_data03.namevalue(s,"FODECASH")+"DECASH"+gcds_data03.namevalue(s,"DECASH"));
	alert("FOCRCASH"+gcds_data03.namevalue(s,"FOCRCASH")+"CRCASH"+gcds_data03.namevalue(s,"CRCASH"));
	alert("FOEDECASH"+gcds_data03.namevalue(s,"FOEDECASH")+"EDECASH"+gcds_data03.namevalue(s,"EDECASH"));
	alert("FOECRCASH"+gcds_data03.namevalue(s,"FOECRCASH")+"ECRCASH"+gcds_data03.namevalue(s,"ECRCASH"));
	alert("FODEUPTOT"+gcds_data03.namevalue(s,"FODEUPTOT")+"CHAUPAMT"+gcds_data03.namevalue(s,"CHAUPAMT"));
	alert("FOCRUPTOT"+gcds_data03.namevalue(s,"FOCRUPTOT")+"DAEUPAMT"+gcds_data03.namevalue(s,"DAEUPAMT"));
	alert("FODEUPCASH"+gcds_data03.namevalue(s,"FODEUPCASH")+"DEUPCASH"+gcds_data03.namevalue(s,"DEUPCASH"));
	alert("FOCRUPCASH"+gcds_data03.namevalue(s,"FOCRUPCASH")+"CRUPCASH"+gcds_data03.namevalue(s,"CRUPCASH"));
	*/
}
/******************************************************************************
	Description : ȯ�� ã��
	parameter   : p1 - ���� 01 : ������,   02: ���� ,  03: ���ȯ��
	              p2 - ȸ����
******************************************************************************/
function ln_Exrate_find(p1, p2){
   var erstddat="";
	 var temp="";
	 //alert("p1:"+p1+"p2:"+p2);
	 for(g=1;g<=gcds_exrate.countrow;g++){
	    erstddat = gcds_exrate.namevalue(g,"ERSTDDAT");
      erstddat=erstddat.substring(0,6);
			//alert("g::"+g+":erstddat:"+erstddat);
	    if(erstddat==p2){
				if(p1=="01"){
				   temp = gcds_exrate.namevalue(g,"ERHIS"); 
				  // alert("ERHIStemp"+ temp);
           return temp ; 
				}else if(p1=="02"){
				   temp = gcds_exrate.namevalue(g,"ERMMLAST"); 
				  // alert("ERMMLASTtemp"+ temp);
           return temp ; 
				}else if(p1=="03"){
				   temp = gcds_exrate.namevalue(g,"ERAVG"); 
				  // alert("ERAVGtemp"+ temp);
           return temp ; 
				}
			}
	 }
}



/******************************************************************************
	Description : �������� & �ܾ׳ѱ�� & ȸ������ & ��ǥ��ȣ
	parameter   : i�� ���߿� ����
******************************************************************************/
function ln_Date(i){
	 for(s=1;s<=gcds_data03.countrow;s++){
	    gcds_data03.namevalue(s,"SSDAT")=gcds_data01.namevalue(i,"SSDAT");
			gcds_data03.namevalue(s,"SSNBR")=gcds_data01.namevalue(i,"SSNBR");

			gcds_data03.namevalue(s,"ACTDAT")=gcds_data01.namevalue(i,"ACTDAT");
	    gcds_data03.namevalue(s,"ACTDAT")=gcds_data01.namevalue(i,"ACTDAT");
			gcds_data03.namevalue(s,"SGNDAT")=gs_date;
			gcds_data03.namevalue(s,"CHAUPAMT")=gcds_data03.namevalue(s,"CHAAMT");
			gcds_data03.namevalue(s,"DAEUPAMT")=gcds_data03.namevalue(s,"DAEAMT");
			gcds_data03.namevalue(s,"DEUPCASH")=gcds_data03.namevalue(s,"DECASH");
			gcds_data03.namevalue(s,"CRUPCASH")=gcds_data03.namevalue(s,"CRCASH");
	 }
}

/******************************************************************************
	Description : ���ݰ��� Ȯ��  (���ݿ�ȭ -1110110, ���ݿ�ȭ - 1110120)
	parameter   :
******************************************************************************/
function ln_Chk_Cash(){
	for(j=1;j<=gcds_data02.countrow;j++){
		if((gcds_data02.namevalue(j,"ATCODE")=="1110101")||(gcds_data02.namevalue(j,"ATCODE")=="1110102")){
			gs_chadae_gubun=gcds_data02.namevalue(j,"ATDECR"); 
      if(gs_chadae_gubun=="1"){
        gs_cashamt =gcds_data02.namevalue(j,"CHAAMT");
			}else if(gs_chadae_gubun=="2"){
				gs_cashamt =gcds_data02.namevalue(j,"DAEAMT");   
			}
      //alert("gs_chadae_gubun::"+gs_chadae_gubun+":gs_cashamt:"+gs_cashamt);
			return true;
			break;
		}
	}
	return false;
}

/******************************************************************************
	Description : �հ��ܾ� ���̺��� �������ݰ� �뺯������ �����Ͽ� ����.
         ���� : 1.���ݰ����� ����
				        2.������ ��� ������ �����ʵ忡 ���ݱݾ� ����.
							��1)  ����    ����    �뺯        ����    ����   �뺯   ��������   �뺯����
								    =====================       =========================================
                    �޿�    1000       0        �޿�    1000      0         0        1000
									������    1000       0      ������    1000      0         0         500
										����       0    1500        ����       0   1500         0           0
								���뿹��       0     500    ���뿹��       0    500         0           0

							��2)  ����    ����    �뺯        ����    ����   �뺯   ��������   �뺯����
								    =====================       =========================================
                    �޿�    1000       0        �޿�    1000      0         0         500
										����       0     500        ����       0    500         0           0
								���¿���       0     500    ���¿���       0    500         0           0

                 3. �� 1���� ó�� ���ݻ������� ���ݺ��� ���� ��� ���� ������ �ݾ׺��� ���ݿ� �Է��Ѵ�.
	parameter   :
******************************************************************************/
function ln_Cash(){
  var tempamt=0; //�����ݾ�
	
	for(k=1;k<=gcds_data02.countrow;k++){
	  tempamt=0;
		gs_decash=0;
		gs_crcash=0;
		gs_totcnt+=1;
		gcds_data03.namevalue(gs_totcnt,"DECASH")=0;
    gcds_data03.namevalue(gs_totcnt,"CRCASH")=0;
		//alert("k::"+k+":gs_totcnt:" +gs_totcnt);
		if((gcds_data02.namevalue(k,"ATCODE")=="1110101")||(gcds_data02.namevalue(k,"ATCODE")=="1110102")){
		}else{
			if(gs_chadae_gubun!=gcds_data02.namevalue(k,"ATDECR")){
			  //alert("k::"+k+" :step1:");
				if(gcds_data02.namevalue(k,"ATDECR")=="1"){
				  //alert("k::"+k+" :step1_1:");
					tempamt =gcds_data02.namevalue(k,"CHAAMT");
				}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
					tempamt =gcds_data02.namevalue(k,"DAEAMT");   
					//alert("k::"+k+" :step1_2:");
				}

				// alert("k::"+k+" :tempamt:"+tempamt);
					
				if(gs_cashamt<=tempamt){  //���ݱݾ� <= ������
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_decash=gs_cashamt;
						//alert("k::"+k+" :step2_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_crcash=gs_cashamt;
						//alert("k::"+k+" :step2_2:");
					}
          gs_cashamt=0;
				}else{                     //���ݱݾ� > ������
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_decash=tempamt;  
						//	alert("k::"+k+" :step3_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_crcash=tempamt;
						//	alert("k::"+k+" :step3_2:");
					}
					gs_cashamt = Number(gs_cashamt)-Number(tempamt); //gs_decash
				}
			}
			gcds_data03.namevalue(gs_totcnt,"DECASH")=Number(gs_crcash);
      gcds_data03.namevalue(gs_totcnt,"CRCASH")=Number(gs_decash);
     // alert("k::"+k+" :gs_decash:"+gs_decash+" :gs_crcash:"+gs_crcash);
		 //alert("gs_totcnt"+gs_totcnt+" DECASH"+gcds_data03.namevalue(gs_totcnt,"DECASH")+" CRCASH"+gcds_data03.namevalue(gs_totcnt,"CRCASH"));
		}
	}//for

}

/******************************************************************************
	Description : ���ݵ�� ���� Ȯ�� (�����ڵ�-11101***)
	parameter   :
******************************************************************************/
function ln_Chk_EqCash(){
  var strAtcode="";
	for(j=1;j<=gcds_data02.countrow;j++){
	  strAtcode=gcds_data02.namevalue(j,"ATCODE");
		strAtcode = strAtcode.substring(0,5);
		if(strAtcode=="11101"){
			gs_Eqchadae_gubun=gcds_data02.namevalue(j,"ATDECR"); 
      if(gs_Eqchadae_gubun=="1"){
        gs_Eqcashamt =gcds_data02.namevalue(j,"CHAAMT");
			}else if(gs_chadae_gubun=="2"){
				gs_Eqcashamt =gcds_data02.namevalue(j,"DAEAMT");   
			}
      //alert("gs_Eqchadae_gubun"+gs_Eqchadae_gubun+"gs_Eqcashamt"+gs_Eqcashamt);
			return true;
			break;
		}
	}
	return false;
}

/******************************************************************************
	Description : �հ��ܾ� ���̺��� �������ݰ� �뺯������ �����Ͽ� ����.
         ���� : 1.���ݵ�������� ����
				        2.���ݵ���� ��� ������ �����ʵ忡 ���ݱݾ� ����.
							��1)  ����    ����    �뺯        ����    ����   �뺯   �������ݵ��  �뺯���ݵ��
								    =====================       ====================================================
                    �޿�    1000       0        �޿�    1000      0         0              1000
									������    1000       0      ������    1000      0         0               500
										����       0    1500        ����       0   1500         0                 0
								���뿹��       0     500    ���뿹��       0    500         0                 0

							��2)  ����    ����    �뺯        ����    ����   �뺯   �������ݵ��  �뺯���ݵ��
								    =====================       ====================================================
                    �޿�    1000       0        �޿�    1000      0         0               500
										����       0     500        ����       0    500         0                 0
								���¿���       0     500    ���¿���       0    500         0                 0

                 3. �� 1���� ó�� ���ݻ������� ���ݺ��� ���� ��� ���� ������ �ݾ׺��� ���ݿ� �Է��Ѵ�.
	parameter   :
******************************************************************************/
function ln_EqCash(){
  var tempamt=0; //�����ݾ�
  var strAtcode=""; //
 
//  alert("ln_EqCash");
	for(k=1;k<=gcds_data02.countrow;k++){
	 // alert("k::"+k);
	  strAtcode=gcds_data02.namevalue(k,"ATCODE");
		strAtcode = strAtcode.substring(0,5);
	  tempamt=0;
		gs_Eqdecash=0;
		gs_Eqcrcash=0;
		gs_Etotcnt+=1;
		gcds_data03.namevalue(gs_totcnt,"EDECASH ")=0;
    gcds_data03.namevalue(gs_totcnt,"ECRCASH")=0;
	//	alert("k::"+k+"strAtcode" +strAtcode);

		if(strAtcode="11101"){
		}else{
			if(gs_Eqchadae_gubun!=gcds_data02.namevalue(k,"ATDECR")){
			  //alert("k::"+k+" :step1:");
				if(gcds_data02.namevalue(k,"ATDECR")=="1"){
				  //alert("k::"+k+" :step1_1:");
					tempamt =gcds_data02.namevalue(k,"CHAAMT");
				}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
					tempamt =gcds_data02.namevalue(k,"DAEAMT");   
					//alert("k::"+k+" :step1_2:");
				}

				// alert("k::"+k+" :tempamt:"+tempamt);
					
				if(gs_Eqcashamt<=tempamt){  //���ݵ���ݾ� <= ������
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_Eqdecash=gs_Eqcashamt; 
						//alert("k::"+k+" :step2_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_Eqcrcash=gs_Eqcashamt;
						//alert("k::"+k+" :step2_2:");
					}
          gs_Eqcashamt=0;
				}else{                     //���ݵ���ݾ� > ������
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_Eqdecash=tempamt;  
						//alert("k::"+k+" :step3_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_Eqcrcash=tempamt;
						//alert("k::"+k+" :step3_2:");
					}
					gs_Eqcashamt = Number(gs_Eqcashamt)-Number(tempamt); //gs_decash
				}
			}
			gcds_data03.namevalue(gs_totcnt,"EDECASH")=Number(gs_Eqcrcash);
      gcds_data03.namevalue(gs_totcnt,"ECRCASH")=Number(gs_Eqdecash);
     // alert("k::"+k+" gs_Eqdecash"+gs_Eqdecash+" gs_Eqcrcash"+gs_Eqcrcash);
		  //alert("gs_totcnt"+gs_totcnt+" DECASH"+gcds_data03.namevalue(gs_totcnt,"DECASH")+" CRCASH"+gcds_data03.namevalue(gs_totcnt,"CRCASH"));
		}
	}//for
}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
  parameter   : ��ǥDTL
	             p - 01 ;���� 
							 p - 02 :�������
******************************************************************************/
function ln_SetDataHeader(p){

	if(p=='01'){
		if (gcds_data03.countrow<1){
   
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSNUM:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
							 + "ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,"
							 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
							 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
							 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
							 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
               
							 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
               + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"

							 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							 + "BANJAEYN:STRING,COCODE:STRING,DIVCD:STRING,DEPTCD:STRING,ACTDAT:STRING,"
							 + "ACTYYMM:STRING,ATCURTYPE:STRING,BGTDIV:STRING,BGTDEPT:STRING,TYPE_FSREFCD:STRING,"
							 + "TYPE_FSREFVAL:STRING,FUNDDIV:STRING,BJFSREFCD:STRING,"
							 
							 + "SGNDAT:STRING,DECASH:DECIMAL,CRCASH:DECIMAL,CHAUPAMT:DECIMAL,DAEUPAMT:DECIMAL,DEUPCASH:DECIMAL,CRUPCASH:DECIMAL,"
							 //�߰��κ�
							 + "SSDAT:STRING,SSNBR:STRING,EDECASH:DECIMAL,ECRCASH:DECIMAL,"
							 + "FODEAMT:DECIMAL,FOCRAMT:DECIMAL,FODECASH:DECIMAL,FOCRCASH:DECIMAL,FOEDECASH:DECIMAL,FOECRCASH:DECIMAL,"
							 + "FODEUPTOT:DECIMAL,FOCRUPTOT:DECIMAL,FODEUPCASH:DECIMAL,FOCRUPCASH:DECIMAL,"
							 + "EXRATE:DECIMAL,EXRATEDT:STRING,EXRATEGB:STRING";
			gcds_data03.SetDataHeader(s_temp);
		}
	}else if(p=='02'){
		if (gcds_data05.countrow<1){
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSNUM:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
							 + "ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,"
							
							 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
							 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
							 
							 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							 
							 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
							 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
							 
							 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
               + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"

							 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							 + "BANJAEYN:STRING,COCODE:STRING,DIVCD:STRING,DEPTCD:STRING,ACTDAT:STRING,"
							 + "ACTYYMM:STRING,ATCURTYPE:STRING,BGTDIV:STRING,BGTDEPT:STRING,TYPE_FSREFCD:STRING,"
							 + "TYPE_FSREFVAL:STRING,FUNDDIV:STRING,BJFSREFCD:STRING,"

							 + "SGNDAT:STRING,DECASH:DECIMAL,CRCASH:DECIMAL,CHAUPAMT:DECIMAL,DAEUPAMT:DECIMAL,DEUPCASH:DECIMAL,CRUPCASH:DECIMAL,"
							  //�߰��κ�
							 + "SSDAT:STRING,SSNBR:STRING,EDECASH:DECIMAL,ECRCASH:DECIMAL,"
							 + "FODEAMT:DECIMAL,FOCRAMT:DECIMAL,FODECASH:DECIMAL,FOCRCASH:DECIMAL,FOEDECASH:DECIMAL,FOECRCASH:DECIMAL,"
							 + "FODEUPTOT:DECIMAL,FOCRUPTOT:DECIMAL,FODEUPCASH:DECIMAL,FOCRUPCASH:DECIMAL,"
							 + "EXRATE:DECIMAL,EXRATEDT:STRING,EXRATEGB:STRING";
			gcds_data05.SetDataHeader(s_temp);
		}
	}else if (p=='06'){
		if (gcds_data06.countrow<1){
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,SEQ:STRING,ACCSGNID:STRING,"
							 + "EMPNO:STRING,ACCSGNDAT:STRING,ACCSGNEND:STRING,FROMGB:STRING,TOGB:STRING,"
							 + "BIGO:STRING,BGTGB,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";

			gcds_data06.SetDataHeader(s_temp);
		}
	}else if (p=='09'){
		if (gcds_outdata.countrow<1){
		  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
			gcds_outdata.SetDataHeader(s_temp);
		}
	
	}else if (p=='10'){
		if (gcds_faildata.countrow<1){
		  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
			gcds_faildata.SetDataHeader(s_temp);
		}

	}else if(p=="CONFIRM"){
		if (gcds_confirm.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,SEQ:STRING,ACCSGNID:STRING,EMPNO:STRING,"
								 + "ACCSGNDAT:STRING,ACCSGNEND:STRING,FROMGB:STRING,TOGB:STRING,BIGO:STRING,BGTGB:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
			gcds_confirm.SetDataHeader(s_temp);
		}
  }else if(p=="99"){
		if (gcds_data99.countrow<1){

		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSNUM:STRING,"
							 + "ATCODE:STRING,ATDECR:STRING,DEAMT:DECIMAL,CRAMT:DECIMAL,"
               + "ACTDAT:STRING,ACTYYMM:STRING,SSDAT:STRING,SSNBR:STRING,"
							 + "COCODE:STRING,DIVCD:STRING,DEPTCD:STRING,DECASH:DECIMAL,CRCASH:DECIMAL,"
							 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
							 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
							 + "DEUPAMT:DECIMAL,CRUPAMT:DECIMAL";
			gcds_data99.SetDataHeader(s_temp);
		}
	}
}
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : �������
******************************************************************************/
function ln_Cancel(){

  if(ln_Chk('02')){
		ln_SetDataHeader('02');
		ln_Cancel_Detail();
		if(confirm("������� �Ͻðڽ��ϱ�?")){	
			gctr_data02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t2?";
			//prompt("gcds_data05",gcds_data05.text);
			gctr_data02.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
			
			gctr_data02.post();
			ln_Query();
			gcds_data05.ClearData();
		}
	}
}

/******************************************************************************
	Description : ������Ұ� ��ǥ��ȣ�� ��ǥ Detail����Ÿ�� ��ȸ �� ����Ÿ�� �ѱ�
	parameter   :
******************************************************************************/
function ln_Cancel_Detail(){
  var tempDataSet ="";
	for(i=1;i<=gcds_data01.countrow;i++){
		if((gcds_data01.namevalue(i,"CHK")=="T")&&(gcds_data01.namevalue(i,"ACCSGNEND")=="Y")){
			
				gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s2?v_str1="+gcds_data01.namevalue(i,"FDCODE")
																										     +"&v_str2="+gcds_data01.namevalue(i,"FSDAT")
																										 	   +"&v_str3="+gcds_data01.namevalue(i,"FSNBR");
        //prompt("",gcds_data04.DataID );																							
	      gcds_data04.Reset();
				tempDataSet = gcds_data04.ExportData(1,gcds_data04.CountRow,false);
				gcds_data05.ImportData(tempDataSet);
        
				//ln_Date();//��������
		}
	}
}


/******************************************************************************
	Description : �ݼ�
******************************************************************************/
function ln_Back(){
  if(ln_Chk('03')){
		if(!ln_Back_Data()) return;
		if (confirm("�ݼ��Ͻðڽ��ϱ�?")){		
			gctr_data06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6?";
			//prompt("gcds_confirm",gcds_data06.text);
			gctr_data06.post();
			ln_Query();
		}
	}
}


/******************************************************************************
	Description : �ݼ۵���Ÿ ����
******************************************************************************/
function ln_Back_Data(){
    var strtogb = "";
		var strfromgb="";
		var cnt=0;
		var tempnbr="";
		ln_SetDataHeader('06');

		if(hid_gubun.value=="01"){        //ȸ��
			strfromgb="03";
		}else if(hid_gubun.value=="02"){  //����
			strfromgb="02";
		}

	  for(i=1;i<=gcds_data01.countrow;i++){
			if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="C")||(gcds_data01.namevalue(i,"ACCSGNEND")=="R"))){
			  cnt+=1;
				gcds_data06.addrow();
				var row =  gcds_data06.rowposition ; 
				tempnbr="";
				tempnbr = gcds_data01.namevalue(gcds_data01.rowposition,"FSNBR");
				tempnbr = tempnbr.substring(0,1);
        if (tempnbr=="9"){
					 strtogb ="04";
				}else{
					 strtogb ="01";
				}

				gcds_data06.namevalue(row,"FDCODE")=gcds_data01.namevalue(i,"FDCODE"); 
				gcds_data06.namevalue(row,"FSDAT")=gcds_data01.namevalue(i,"FSDAT");  
				gcds_data06.namevalue(row,"FSNBR")=gcds_data01.namevalue(i,"FSNBR");  
				gcds_data06.namevalue(row,"SEQ")=gcds_data01.namevalue(i,"SEQ"); 
				gcds_data06.namevalue(row,"ACCSGNID")=gcds_data01.namevalue(i,"ACCSGNID");      //������
				gcds_data06.namevalue(row,"EMPNO")= gcds_data01.namevalue(i,"EMPNO");  
				gcds_data06.namevalue(row,"ACCSGNDAT") =gcds_data01.namevalue(i,"ACCSGNDAT");  
				gcds_data06.namevalue(row,"ACCSGNEND") ="B"; 
				gcds_data06.namevalue(row,"FROMGB") =strfromgb; 
				gcds_data06.namevalue(row,"TOGB") =strtogb; 
				gcds_data06.namevalue(row,"BIGO") =gcds_data01.namevalue(i,"BIGO"); 
				gcds_data06.namevalue(row,"BGTGB") =""; 
				gcds_data06.namevalue(row,"WRDT") =gs_date;  
				gcds_data06.namevalue(row,"WRID") =gs_userid;  
				gcds_data06.namevalue(row,"UPDT") =gs_date;  
				gcds_data06.namevalue(row,"UPID") =gs_userid;  
			}//if
	 }//for

	 if(cnt==0){
			alert("�ݼ� �� �� �����ϴ�.");
			return false;
	 }else{
			return true;
	 }
}
/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : ������� ã��
	parameter   :
******************************************************************************/
function ln_Popup(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  arrParam[0]="0900";//������

	strURL =  "./commdtil_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_empno.value =arrResult[0];
		txt_empnmk.value = arrResult[1];
	}else{
    txt_empno.value="";
		txt_empnmk.value="";
	}
}

/******************************************************************************
	Description : Slipno popup
	parameter   :
******************************************************************************/
function ln_Popup_Slip_no(row){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
																									  
	arrParam[0] = gcds_data01.namevalue(row,"FDCODE");
	arrParam[1] = gcds_data01.namevalue(row,"FSDAT");
	arrParam[2] = gcds_data01.namevalue(row,"FSNBR");

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : �ٷ��� �Ǽ��� ���� ��ų�� 100�� ���� �����.
	parameter   : p1 - fdcode, p2-fsdat , p3 -fsnbr
******************************************************************************/
function ln_Fail_Data(p1,p2,p3){
  gcds_faildata.addrow();
	gcds_faildata.namevalue(gcds_faildata.rowposition,"FDCODE")=p1;
	gcds_faildata.namevalue(gcds_faildata.rowposition,"FSDAT")=p2;
	gcds_faildata.namevalue(gcds_faildata.rowposition,"FSNBR")=p3;
}


/******************************************************************************
	Description : msg
	parameter   : 
******************************************************************************/
function ln_Msg(){
  var strFail="";      //���г���
	var temp="";

	for (f=1;f<=gcds_faildata.countrow;f++){
		temp="";
    temp = gcds_faildata.namevalue(f,"FDCODE")+"-"
		     + gcds_faildata.namevalue(f,"FSDAT")+"-"
         + gcds_faildata.namevalue(f,"FSNBR")
				 ;
		temp+='\n';
		strFail += temp ;
	}

	alert("�۾��� �������ϴ�." +'\n'+
	      "��ü�Ǽ� : "+gs_cnt+'\n'+
	      "�����Ǽ� : "+gs_succcnt+'\n'+
				"���аǼ� : "+gs_failcnt+'\n'+
				"���г��� : "+'\n'+ strFail	);
}

/******************************************************************************
	Description : �ٷ��� �Ǽ��� ���� ��ų�� 100�� ���� �����.
	parameter   :
******************************************************************************/
function ln_Batch(){
  var tempcnt=0;
	var temptot=0;
	//txt_cnt.value=0;
	//txt_tot.value=0;

	if(confirm("�����Ͻðڽ��ϱ�?")){
		ln_SetDataHeader('01');
		
		var tempDataSet="";
		
		//txt_tot.value=gcds_data01.countrow; 
		for(i=1;i<=gcds_data01.countrow;i++){
			gs_totcnt=0;
			if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="R")||(gcds_data01.namevalue(i,"ACCSGNEND")=="C"))){
					
					tempcnt+=1; //100�Ǹ��� ó����.
          temptot+=1;
					gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s2?v_str1="+gcds_data01.namevalue(i,"FDCODE")
																													 +"&v_str2="+gcds_data01.namevalue(i,"FSDAT")
																													 +"&v_str3="+gcds_data01.namevalue(i,"FSNBR");
					//prompt("",gcds_data02.DataID );																							
					gcds_data02.Reset();
					
					tempDataSet = gcds_data02.ExportData(1,gcds_data02.CountRow,false);
					gcds_data03.ImportData(tempDataSet);
					
					//alert("CRCASH"+gcds_data03.namevalue(1,"CRCASH"));
					if(ln_Chk_Cash()){//���ݰ���üũ  (���ݿ�ȭ, ���ݿ�ȭ)
						//alert("��������");
						ln_Cash()
					}
					
					ln_Date2(i);//��������
          
					//txt_cnt.value=temptot;
			
				if(i==gcds_data01.countrow){
					  gctr_data09.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t1?";
						//prompt("gcds_data03",gcds_data03.text);
						gctr_data09.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
						gctr_data09.post();
						gcds_data03.ClearData();
						tempcnt=0;
						tempDataSet=""
				}else{
					if (tempcnt==1){
						gctr_data09.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t1?";
						//prompt("gcds_data03",gcds_data03.text);
						gctr_data09.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
						gctr_data09.post();
						gcds_data03.ClearData();
						tempcnt=0;
						tempDataSet=""
					}
				}
			}//if
		}//for
	}//if
}

/******************************************************************************
	Description : 
	parameter   :
******************************************************************************/
function ln_Date2(i){
	 for(s=1;s<=gcds_data03.countrow;s++){
	    gcds_data03.namevalue(s,"SGNDAT")=gcds_data01.namevalue(i,"ACCSGNDAT");
			//gcds_data03.namevalue(s,"SGNDAT")=gs_date;
			gcds_data03.namevalue(s,"CHAUPAMT")=gcds_data03.namevalue(s,"CHAAMT");
			gcds_data03.namevalue(s,"DAEUPAMT")=gcds_data03.namevalue(s,"DAEAMT");
			gcds_data03.namevalue(s,"DEUPCASH")=gcds_data03.namevalue(s,"DECASH");
			gcds_data03.namevalue(s,"CRUPCASH")=gcds_data03.namevalue(s,"CRCASH");
	 }
}

/******************************************************************************
	Description : ��������û
	parameter   :
******************************************************************************/
function ln_Popup_Confirm(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if(hid_gubun.value!="02"){ //
		alert("���길 �����û �����մϴ�.");
		return;
	}

	strURL = "./confirm_popup.jsp";
	strPos = "dialogWidth:330px;dialogHeight:180px;status:no;scroll:no;resizable:no";

	result = showModalDialog(strURL,arrParam,strPos);
	//return result;
	if (result != null) {
		arrResult = result.split(";");
		//alert("0"+arrResult[0]);
		//alert("1"+arrResult[1]);
		gcds_confirm.ClearData();
		if (arrResult[1]= "Y" ){ //���������
			ln_Confirm_Save(arrResult[0], arrResult[3],arrResult[4]); //������, ȸ��(����)���� 01 ȸ��, 02����, Y -ȸ������ ����
		}
	}
}

/******************************************************************************
	Description : ����� ����
	parameter   :  p - ������ ���
	               p1 - ȸ��/ ���� ����
								 p2 - ȸ������ ����� ��ǥ��Ͽ��� ��(Y)
******************************************************************************/
function ln_Confirm_Save(p, p1,p2){
		var strempno="";
    var strtogb="";

	//	alert("p1"+p1)

		ln_SetDataHeader("CONFIRM");

    for (i=1;i<=gcds_data01.countrow;i++){
			if((gcds_data01.namevalue(i,"CHK")=="T")&&(gcds_data01.namevalue(i,"ACCSGNEND")=="R")){
				gcds_confirm.addrow();

				gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=gcds_data01.namevalue(i,"FDCODE"); 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=gcds_data01.namevalue(i,"FSDAT");   
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=gcds_data01.namevalue(i,"FSNBR");  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=gcds_data01.namevalue(i,"SEQ");
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")=p;      //������
				gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= gcds_data01.namevalue(i,"EMPNO"); 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="02"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") ="03"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"BGTGB") =gcds_data01.namevalue(i,"BGTGB"); 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  
			}
		}
		if (confirm("�����û �Ͻðڽ��ϱ�?")){	
			gctr_data07.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6?";
			//prompt("gcds_confirm",gcds_confirm.text);
			gctr_data07.post();
			ln_Query();
    }
}

function ln_TEST(){
  var str1 ="01";     //�����ڵ�
	var str2 ="200602"; //���
	var str3 ="1110101"; //
	var str4 ="03";     //�����
	var str5 ="C000";   //����
  var temp ="1120100"; //�º�����. �캯����
  
	gf_array_val(gcds_name,str1,str2,str4,str5,temp);

	//alert("TOTALVALUE"+gcds_name2.namevalue(1,"TOTALVALUE"));

}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_name classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_name2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥDetail -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥDetail_temp -->
<comment id="__NSID__"><object  id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ҿ� ��ǥDetail -->
<comment id="__NSID__"><object  id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ҿ� ��ǥDetail  export -->
<comment id="__NSID__"><object  id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �ݼ� -->
<comment id="__NSID__"><object  id=gcds_data06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ���� -->
<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ���аǼ� -->
<comment id="__NSID__"><object  id=gcds_outdata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ���аǼ� ����-->
<comment id="__NSID__"><object  id=gcds_faildata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �α��� üũ -->
<comment id="__NSID__"><object  id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �ݰ��� ȯ�� -->
<comment id="__NSID__"><object  id=gcds_exrate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ���� -->
<comment id="__NSID__"><object  id=gcds_confirm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �̿�����Ÿ ���� -->
<comment id="__NSID__"><object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 


<!-- ������� update -->
<comment id="__NSID__"><object  id=gcds_bgtresult classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ��ǥ Detail �ѱ�� -->
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020004_t1(I:USER=gcds_data03,O:USER2=gcds_outdata)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������� -->
<comment id="__NSID__"><object  id=gctr_data02 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020004_t2(I:USER=gcds_data05)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �ݼ� -->
<comment id="__NSID__"><object  id=gctr_data06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6(I:USER=gcds_data06)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ Detail �ѱ�� -->
<comment id="__NSID__"><object  id=gctr_data09 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020004_t1(I:USER=gcds_data03)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����û  -->
<comment id="__NSID__"><object  id=gctr_data07 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6f(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  


<!-- ��ǥ Detail �ѱ�� -->
<comment id="__NSID__"><object  id=gctr_data99 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020004_t3(I:USER=gcds_data99)">  
	<param name=TimeOut       value=2400000>
</object></comment><script>__ws__(__NSID__);</script> 


<!-- ������� �ѱ�� -->
<comment id="__NSID__"><object  id=gctr_bgtresult classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="comm_bgt_result_t1(I:USER=gcds_bgtresult)">  
	<param name=TimeOut       value=2400000>
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
  
	gcds_data02.ClearData();
	gcds_data03.ClearData();
	gcds_data04.ClearData();
	gcds_data05.ClearData();
	gcds_data06.ClearData();
	gcds_outdata.ClearData();
	gcds_faildata.ClearData();
	
</script>


<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	
	//alert("onloadCompleted");

</script>


<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
	
	//alert("onloadCompleted");
//	alert("row:;"+row);

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
  gs_save_gubun="";
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
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
  
	if(row>0){
		if(colid!="CHK" && colid!="ACTDAT" && colid!="BIGO"){
			ln_Popup_Slip_no(row);
		}
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnExit(row,colid,olddata)>
   // alert("row"+row+"colid"+colid);
		if(colid=="ACTDAT"){
		  if(gv_date_check(gcds_data01.namevalue(gcds_data01.rowposition,"ACTDAT"))){
			}else{
			  gcgd_disp01.EnableTabKey(false);
				alert("��¥������ Ʋ�Ƚ��ϴ�.");
        //gcgd_disp01.SetColumn("ACTDAT");
			}
		}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="onsuccess()">
	//alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
  gs_succcnt+=1;       //�� �����Ǽ�
	gcds_data03.ClearData();
</script>

<script language="javascript" for="gctr_data01" event="onfail()">
	//alert("1�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
	gs_failcnt+=1;       //�� ���аǼ�

	ln_Fail_Data(gcds_outdata.namevalue(gcds_outdata.rowpotion,"FDCODE"),
	             gcds_outdata.namevalue(gcds_outdata.rowpotion,"FSDAT"),
							 gcds_outdata.namevalue(gcds_outdata.rowpotion,"FSNBR"));
	gcds_data03.ClearData();
</script>


<script language="javascript" for="gctr_data02" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data02" event="onfail()">
	alert("2�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data02.ErrorCode + "\n" + "Error Message : " + gctr_data02.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data06" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data06" event="onfail()">
	alert("3�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="test" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="test" event="onfail()">
	alert("4�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	//alert("Error Code : " + test.ErrorCode + "\n" + "Error Message : " + test.ErrorMsg + "\n");

	gcds_data03.ClearData();

</script>

<script language="javascript" for="gctr_data99" event="onfail()">
	alert("5�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data99.ErrorCode + "\n" + "Error Message : " + gctr_data99.ErrorMsg + "\n");

</script>



<script language="javascript" for=gctr_bgtresult event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_bgtresult" event="onfail()">
	alert("6�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_bgtresult.ErrorCode + "\n" + "Error Message : " + gctr_bgtresult.ErrorMsg + "\n");

</script>



</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a020007_head.gif"></td>
		<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
		  <img src="../../Common/img/btn/com_btn_bresult.gif"	style="cursor:hand" onClick="ln_Bgt_Result_Batch()" > 
		  <img src="../../Common/img/btn/com_b_total.gif"	style="cursor:hand" onClick="ln_Forward_Batch()" > 	
		  <!-- <img src="../../common/img/btn/com_b_sendbak.gif"	style="cursor:hand" onClick="ln_Back()" > 	
			<img src="../../common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Popup_Confirm()" > 
		  <img src="../../common/img/btn/com_b_sanctioncal.gif"	style="cursor:hand" onClick="ln_Cancel()" > 			
			<img src="../../common/img/btn/com_b_result.gif"	style="cursor:hand" onClick="ln_Save()" > -->
			<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="876px"> 
					<td width="70px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;ȸ������&nbsp;</nobr></td>
					<td class="tab18" style="width:250px;"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="####/##/##">
											<!--�ӽ� <param name=Format        value="YYYY/MM/DD"> -->
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
							~&nbsp;
						 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="####/##/##">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
							</nobr>
					</td>

          <td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>��������</nobr></td>
					<td class="tab18" style="width:200px;" align=left ><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
								<param name=ComboDataID    value="gcds_comfield">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			     value=false>
								<param name=ListExprFormat value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					 </td> 
          
					<td width="70px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;�������</nobr></td>
					<td class="tab31" width="63px">
						<input type="text" class="txt11" id="txt_empno"  style="position:relative;left:4px;width:60px;background-color:#d7d7d7" readOnly></td>
					<td class="tab31" width="35px">
						<img src="../../Common/img/btn/com_b_find.gif" alt="�ڵ� �� �ڵ���� �˻��մϴ�" style="cursor:hand;position:relative;left:3px" onclick="ln_Popup()"></td>
					<td class="tab18" width="100px"><nobr>
						<input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="position:relative;left:5px;width:90px;"></nobr></td>	
        </tr>

        <tr>
          <td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;��    ��&nbsp;</nobr></td>
					<td class="tab19" style="width:250px;"><nobr>&nbsp;
						<input id="txt_remark" type="text" class="txtbox"  style= "width:240px;height:20px;position:relative;left:-4px" maxlength=30 onkeydown="if(event.keyCode==13) ln_Query()";>
						</nobr>
					</td>

					<td width="70px" style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>&nbsp;&nbsp;��ǥ����</nobr></td>
          <td class="tab19" style="width:200px;" align=left><nobr>&nbsp;<comment id="__NSID__">
						 <object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
											<param name=CBData			   value="A^��ü,Y^����Ϸ�,R^�����û,C^�������">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME">								
											<param name=BindColumn		 value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> 
							</nobr>
					</td>

          <td width="70px" style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>&nbsp;���籸��</nobr></td>
					<td class="tab19" style="width:200px;" align=left colspan=3><nobr>&nbsp;
						<input type="text" class="txt11" id="txt_gubun"  style="position:relative;left:-4px;width:60px;background-color:#d7d7d7" readOnly>
						<input type="hidden" class="txt11" id="hid_gubun"  style="position:relative;left:-4px;width:60px;background-color:#d7d7d7" readOnly>
					<!-- 	<input type="text" class="txt11" id="txt_count"  style="position:relative;left:-4px;width:60px;background-color:#d7d7d7" readOnly> -->
						<!--   <comment id="__NSID__"><object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=CBData			   value="A^��ü,01^����,02^�����а�">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME">								
											<param name=BindColumn		 value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> 
							</nobr>
							<input type="text" class="txt11" id="txt_cnt"  style="position:relative;left:4px;top:-3px;width:40px;background-color:#d7d7d7" readOnly>
							&nbsp;/<input type="text" class="txt11" id="txt_tot"  style="position:relative;left:4px;top:-3px;width:40px;background-color:#d7d7d7" readOnly> -->
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
				style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data01">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ViewSummary"	value=1>
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<PARAM NAME="Format"			VALUE="  
					<C> Name='����'		    ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  SumBgColor=#C3D0DB align=center	EditStyle=CheckBox   </C> 
					<C> Name='����'		    ID=FDNAME	   HeadAlign=Center HeadBgColor=#B9D4DC Width=48	  SumBgColor=#C3D0DB edit=none align=center sort=true  </C> 
					<C> Name='��ǥ��ȣ'		ID=SSDATNBR	 HeadAlign=Center HeadBgColor=#B9D4DC Width=102	  SumBgColor=#C3D0DB edit=none align=center sort=true  </C> 
					<C> Name='������ȣ'		ID=FSDATNBR	 HeadAlign=Center HeadBgColor=#B9D4DC Width=102	  SumBgColor=#C3D0DB edit=none align=center sort=true  </C> 
					<C> Name='�����'		  ID=EMPNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=0  	  SumBgColor=#C3D0DB edit=none  align=center sort=true show=false</C> 
					<C> Name='�����'		  ID=EMPNMK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  SumBgColor=#C3D0DB edit=none  align=center sort=true </C> 
					<C> Name='����'			  ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=320	  SumBgColor=#C3D0DB edit=none  align=left	 sort=true  SumText='��   ��'</C> 
					<C> Name='�ݾ�'		  	ID=FSAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  SumBgColor=#C3D0DB edit=none  align=right  sort=true  SumText=@sum</C> 
					<C> Name='����'		    ID=ACCSGNEND HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  SumBgColor=#C3D0DB edit=none  align=center sort=true  EditStyle=Combo Data='Y:����Ϸ�,R:�����û,C:�������,B:�ݼ�' </C> 
					">
			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	</tr>
</table>

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->
<iframe id="LowerFrame2" name="work2" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../common/img/flash/ing_bar.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
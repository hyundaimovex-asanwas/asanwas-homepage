<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ȸ����� - �ΰ������� - ������
+ ���α׷� ID	:  a040120.jsp
+ �� �� �� ��	:  ������ 
+ ��   ��   ��     :  �� �� ��
+ �� �� �� ��     :  2014.05.02
+ �� �� �� ��	:  a040120_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>������</title>

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
var gs_deptcd = gdeptcd;	//�μ��ڵ�
var gs_deptnm = gdeptnm;


var gs_curdate = ln_Load_Date('c');
var gs_sm_call_status=""; // ȣ�� asp ����

<% String ss_userid  = (String)session.getAttribute("vusrid"); %>

var gstrempno="";
var gstrGubun ="";
var gstrdeptcd="";
var gstrAuthgr="";

var strParam = new Array();
strParam=window.dialogArguments;

/******************************************************************************
Description : ������ �ε�
******************************************************************************/
function ln_Start(tree_idx){
	ln_Before();
	ln_Initial();
	ln_Query_Authority2(); 
	gcem_taxnbr_s.text=strParam[0];
	
	//������ ��ȸ 
	ln_Query();	
}

/******************************************************************************
Description : ����ȸ
******************************************************************************/
function ln_Before(){
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
	
	//�ͼӱ���[����]
	gcds_taxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1215"; 
	gcds_taxdiv.Reset();
	
	//�ΰ�������[����]
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_taxknd.Reset();
}


/******************************************************************************
Description : ������ �ε�
******************************************************************************/
function ln_Initial(){
	
	var str_ori_taxdat=gcem_taxdat.text;         //��꼭����
	var str_ori_erp_remark = gcem_erp_remark.text;
		
	var str_ori_vendcd=gcem_vendcd.text;         //�ŷ�ó �ڵ� 
	var str_ori_vendnm=txt_vendnm.value;         //�ŷ�ó �� 
	var str_ori_vendid=gcem_vendid.text;         //��Ϲ�ȣ
	var str_ori_seq=gcem_seq.text;               //����� ���� 
	var str_ori_vend_empnm=gcem_vend_empnm.text; //�ŷ�ó����� 
	var str_ori_vend_email=gcem_vend_email.text; //�ŷ�ó����� �̸��� 
	var str_ori_vd_direct= gcem_vd_direct.text;  //��ǥ�ڸ�
	
	var str_ori_atcode=gcem_atcode.text;         //������
	var str_ori_atkornam=txt_atkornam.value;     //������
	var str_ori_atdecr=txt_atdecr.value;         //���뱸�� (hidden ) 
	var str_ori_costcd=gcem_costcd.text;         //�����ڵ�
	var str_ori_costnm=txt_costnm.value;         //������ 
	
	gcem_taxnbr_s.text="";
	
	ln_Taxmst_SetDataHeader();
	ln_Taxdtl_SetDataHeader();
	gcds_taxmst.addrow();
	gcds_taxdtl.addrow();
	gcds_data.clearAll();
	gcds_data2.clearAll();
	
	gclx_cocode.bindcolval ="02"; //����� ���� �⺻
	ln_Display_Cocode();          //��������ȣ display  
	
	gcem_deptnm.text=gs_deptnm;   //���μ���
	gcem_deptcd.text=gs_deptcd;   //���μ��ڵ� 
	gcem_empnm.text=gusrnm;       //����ڸ�
	gcem_empno.text=gs_userid;    //����ڻ��
	if(v_chk_date.checked==true){
		gcem_taxdat.text=str_ori_taxdat;
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD") = gcem_taxdat.text.substring(4,8);
	}else{
		gcem_taxdat.text="";          //��꼭����
	}
	
	//��������
	gclx_taxknd.bindcolval ="1";
	//�ͼӱ���
	gclx_taxdiv.bindcolval ="0001";
	
	//�ŷ�ó
	if(v_chk_vend.checked==true){
		gcem_vendcd.text=str_ori_vendcd;          //�ŷ�ó �ڵ� 
		txt_vendnm.value=str_ori_vendnm;          //�ŷ�ó �� 
		gcem_vendid.text=str_ori_vendid;          //��Ϲ�ȣ
		gcem_seq.text=str_ori_seq;                //����� ���� 
		gcem_vend_empnm.text=str_ori_vend_empnm;  //�ŷ�ó����� 
		gcem_vend_email.text=str_ori_vend_email;  //�ŷ�ó����� �̸��� 
		gcem_vd_direct.text=str_ori_vd_direct;    //��ǥ�ڸ�.
	}else{
		gcem_vendcd.text="";      //�ŷ�ó �ڵ� 
		txt_vendnm.value="";      //�ŷ�ó �� 
		gcem_vendid.text="";      //��Ϲ�ȣ
		gcem_seq.text="";         //����� ���� 
		gcem_vend_empnm.text="";  //�ŷ�ó����� 
		gcem_vend_email.text="";  //�ŷ�ó����� �̸��� 
		gcem_vd_direct.text="";   //��ǥ�ڸ�
	}
	
	//����
	if(v_chk_remark.checked==true){
		gcem_erp_remark.text=str_ori_erp_remark;
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM") =gcem_erp_remark.text; 
	}else{
		gcem_erp_remark.text="";
	}
	gcem_fsdat.text="";
	gcem_fsnbr.text="";       //��ǥ������ȣ
	gclx_fsstat.text="";      //��ǥ����
	
	//������
	if(v_chk_account.checked==true){
		gcem_atcode.text= str_ori_atcode;         //������
		txt_atkornam.value= str_ori_atkornam;     //������
		txt_atdecr.value= str_ori_atdecr;         //���뱸�� (hidden ) 
	}else{
		gcem_atcode.text="";      //������
		txt_atkornam.value="";    //������
		txt_atdecr.value="";      //���뱸�� (hidden ) 
	}
	
	
	//����
	if(v_chk_account.checked==true){
		gcem_costcd.text= str_ori_costcd;         //�����ڵ�
		txt_costnm.value= str_ori_costnm;         //������ 
	}else{
		gcem_costcd.text="";      //�����ڵ�
		txt_costnm.value="";      //������
    }
	
	//���ް���, �ΰ�����, �հ�, ��������
    gcem_sup_amount.text=0;
    gcem_tax_amount.text=0;
    gcem_total_amount.text=0;
        
    ln_Taxknd_Chg();
    
	//gcem_taxnbr_s.text ="A2014040005";
}

/******************************************************************************
��ȸ���� �ű�
******************************************************************************/
function ln_Query_Authority2(){
	gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2=<%=ss_userid%>&v_str3=1172&v_str4=Y";
	gcds_empno_chk.Reset();
}

/******************************************************************************
��ȸ���� ��� return 
******************************************************************************/
function ln_Authority_Result(row,colid){
	var cnt=0;
	gstrempno="'<%=ss_userid%>',";

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

			if(i>=16){
       			if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //������� 
					gstrempno+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}
			}
		}//for

		if(cnt>0){
			gstrdeptcd=gstrdeptcd.substring(0,gstrdeptcd.length-1);
		}
	}
	
	gstrempno=gstrempno.substring(0,gstrempno.length-1);
	
	if(gstrAuthgr=="A"){
		gstrGubun = gstrAuthgr;
		//2014.06.17.jys ȸ������ڴ� Ǯ����.  
		gcem_fsdat.enable=true;
		gcem_fsnbr.enable=true;
		gcem_fsdat.ReadOnly=false;
		gcem_fsnbr.ReadOnly=false;
	}else{
		gstrGubun="";
		gcem_fsdat.enable=false;
		gcem_fsnbr.enable=false;
		gcem_fsdat.ReadOnly=true;
		gcem_fsnbr.ReadOnly=true;
	}
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){
	
	//���Ѱ���
	var str1 = "";
	var str2 = gcem_taxnbr_s.text;
	var str3 = gstrGubun;  //����
	var str4 = gstrempno;  //�α���
	var str5 = gstrdeptcd; //�μ� 	
	
	//���� üũ 
	if(str2.substring(0,1)=="A"||str2.substring(0,1)=="C"||str2.substring(0,1)=="E"){
		alert("��꼭��ȣ�� ������� �ƴմϴ�.");
		return;
	}
	
    //��꼭 ��ȣ�� ���� ��� return 
    if (fn_trim(str2)==""){
    	alert("��꼭��ȣ�� �Է��ϼ���.");
    	return false;
    }
			
	gcds_taxmst.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_s1?v_str1="+str1
																	     +"&v_str2="+str2
																		 +"&v_str3="+str3
																		 +"&v_str4="+str4
																		 +"&v_str5="+str5;
	//prompt('',gcds_data.DataID);
	gcds_taxmst.Reset();
	
	gcds_taxdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_s2?v_str1="+gcem_taxnbr_s.text;	
	gcds_taxdtl.Reset(); 
	
	ln_A_Query(gcem_taxnbr_s.text);
	ln_B_Query(gcem_taxnbr_s.text);

}


/******************************************************************************
Description : �߰� - ���� ��� 
******************************************************************************/
function ln_Add(){
	ln_Initial();
	gclx_fdcode.bindcolval = gs_fdcode;
}

/******************************************************************************
Description : ������ 
******************************************************************************/
function ln_Save(){
		
	//���� A-����, B-����  , ���� C-����, D-���� , �ݰ��� E-����, F-����
	if(gclx_fdcode.bindcolval =="02"){        // ���� 
		strParam ="B";
	}else if(gclx_fdcode.bindcolval =="03"){ //�ݰ���
		strParam ="D";
	}else if(gclx_fdcode.bindcolval =="04"){ //���� 
		strParam ="F";
	}else{
		alert("������ Ȯ���ϼ���.");
	} 
	strParam = strParam+gcem_taxdat.text.substring(0,6); //���а�+���:
		
	ln_Data_Setting();
	if(!ln_Chk())return;	
	if (gcds_taxmst.IsUpdated) {
		if (confirm("����[����]������ ���� �Ͻðڽ��ϱ�?")){	
			gs_sm_call_status ="I"; //�������
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_t1";
			gctr_data.KeyValue = "Account.a040110_t1(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,O:USER7=gcds_return)";	
			gctr_data.Parameters ="v_str1="+strParam;
			//prompt('',gcds_taxmst.text);
			//prompt('',gcds_taxdtl.text);
			gctr_data.post();
		}	
	}
}


/******************************************************************************
Description : DataSet�� �ݿ�

******************************************************************************/
function ln_Data_Setting(){
			
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
	
	gcds_taxmst.namevalue(row,"TAXIODIV")="B" ;
	gcds_taxmst.namevalue(row,"TAXSUM")=gcem_sup_amount.text ;
	gcds_taxmst.namevalue(row,"TAXVATAMT")=gcem_tax_amount.text ;
	gcds_taxmst.namevalue(row,"TAXTOT")=gcem_total_amount.text ;
	gcds_taxmst.namevalue(row,"TAXPRTYN")="Y";
	gcds_taxmst.namevalue(row,"TAXTYPE")="N" ;
	gcds_taxmst.namevalue(row,"TAXKIDIV")=strtaxkidiv ;  //����ؼ� �ֱ� ( ��꼭 ���ڷ� )
	gcds_taxmst.namevalue(row,"WORKTYPE")="A" ;
	gcds_taxmst.namevalue(row,"WRDT")=gs_date ;
	gcds_taxmst.namevalue(row,"WRID")=gs_userid ;
	gcds_taxmst.namevalue(row,"UPDT")=gs_date ;
	gcds_taxmst.namevalue(row,"UPID")=gs_userid ;
		
	//2009.12.04 JYS ���ڼ��ݰ�꼭 ���ڹ��౸�� �߰�
    if(rdo_gubun1_1.checked==true){
    	gcds_taxmst.namevalue(row,"GUBUN")="1" ;  //���� 
	}else if(rdo_gubun1_2.checked==true){
		gcds_taxmst.namevalue(row,"GUBUN")="2" ;  //����
	}		
	
	//�ܺνý��� ������� 
	//2010.08.24 JYS �ܺ����ڼ��ݰ�꼭 �ý������� ��������Ͽ� ������ ��� 
	if(chk_ext.checked==true){
		gcds_taxmst.namevalue(row,"EXTCHK")="1";
	}else{
		gcds_taxmst.namevalue(row,"EXTCHK")="0";
	}
	
	
	//���γ���
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRID")=gs_userid;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPID")=gs_userid;
		
}

/******************************************************************************
Description : �ʼ��׸� üũ 
******************************************************************************/
function ln_Chk(){

	 if (fn_trim(gs_date)=="")   { alert("������ �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");  return false; }
	 if (fn_trim(gs_userid)=="") { alert("�ۼ��ڰ� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");  return false; }
	  
	 //�ʼ��׸� üũ 
	 if (gclx_fdcode.bindcolval=="") { alert("������ �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");  return false; } 
	 if (gclx_cocode.bindcolval=="") { alert("������� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;	 }	 
	 if (fn_trim(gcem_deptcd.text)=="")   { alert("���μ��ڵ尡  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (fn_trim(gcem_deptnm.text)=="")   { alert("���μ���  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (fn_trim(gcem_empno.text)=="")    { alert("����ڻ����  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (fn_trim(gcem_empnm.text)=="")    { alert("����ڸ���  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 
	 if (fn_trim(gcem_taxdat.text)=="")  { alert("��꼭 ���ڰ�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}    
	 if (gclx_taxknd.bindcolval=="") { alert("���������� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 if (gclx_taxdiv.bindcolval=="") { alert("�ͼӱ����� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 
	 if (fn_trim(gcem_vendcd.text)=="")  { alert("�ŷ�ó�ڵ尡 �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (fn_trim(txt_vendnm.value)=="")  { alert("�ŷ�ó���� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (fn_trim(gcem_vendid.text)=="")  { alert("����ڵ�Ϲ�ȣ��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }  
	 
	 if (fn_trim(gcem_vend_empnm.text)=="")   { alert("�ŷ�ó ��� ������  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }  
	 if (fn_trim(gcem_vend_email.text)=="")   { alert("�ŷ�ó Email��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;	 }  
	 if (fn_trim(gcem_vd_direct.text)=="")    { alert("��ǥ�ڸ��� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;	 }
	 if (fn_trim(gcem_erp_remark.text)=="")   { alert("���䰡  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; } 
	 
	 //������
	 if (fn_trim(gcem_atcode.text)=="")    { alert("�����ڵ尡 �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}   
	 if (fn_trim(txt_atkornam.value)=="")  { alert("�������� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}   
	 
	 if (fn_trim(gcem_costcd.text)=="")  { alert("�����ڵ尡 �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}   
	 if (fn_trim(txt_costnm.value)=="")  { alert("�������� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}   
		 
	 //���ް���, �ΰ�����, �հ�, �������� 
	 if (fn_trim(gcem_sup_amount.text)==""||gcem_sup_amount.text=="0")     { alert("���ް����� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (fn_trim(gcem_total_amount.text)==""||gcem_total_amount.text=="0") { alert("�հ����  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 	 
	 //���γ��� 
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")=="")     {alert("���γ��� ������ �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")==""){alert("���γ��� ǰ���� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")==0)    {alert("���γ��� ���ް����� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	
	 //Data cross check   
	 //��꼭���ڿ� ǰ�����ڰ� Ʋ����� üũ
	 if(gcem_taxdat.text.substring(4,8)!=gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")){
		 alert("���ڰ� ���� �ʽ��ϴ�. Ȯ�� �ٶ��ϴ�.");
		 return false;
	 }
	
	 //�����ϰ�� 
	 if(gclx_taxknd.bindcolval=="1"){ 
		//0�̸� �ȵ�.
	 	if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")==0){
	 		alert("�������а� �ΰ������� ���� �ʽ��ϴ�.Ȯ�� �ٶ��ϴ�.");
	 		return false;
	 	}	
	 }else if(gclx_taxknd.bindcolval=="2"||gclx_taxknd.bindcolval=="3"){ //���� �鼼�� ��� �ΰ����� üũ 
		//0�� �ƴϸ� �ȵ�.
	 	if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")!=0){
	 		alert("�ΰ������� �����մϴ�.");
	 		return false;
	 	}	
	 }
	   
	//DTI_STATUS üũ�Ͽ� null �Ǵ� ��ҿϷ�, ���Űź� �� ��츸 ��������.
	if(gclx_status.bindcolval!=""&&gclx_status.bindcolval!="O"&&gclx_status.bindcolval!="R"){
		alert("������¸� Ȯ���� �ֽʽÿ�. ������ �� �����ϴ�.");
		return false;
	} 
   
	//ǰ�� ����üũ
    //DTI_STATUS üũ�Ͽ� null �Ǵ� ��ҿϷ�, ���Űź� �� ��츸 ��������. �������Ǹ�....
    /**
	if(gclx_status.bindcolval!=""&&gclx_status.bindcolval!="O"&&gclx_status.bindcolval!="R"){
		alert("���¸� Ȯ���� �ֽʽÿ�. ������ �� �����ϴ�.");
		return false;
	}
	**/
	//��ǥ�� �����ϸ� �����Ұ�...................................................................
	return true;
}


/****************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Delete(){

	//���� �� üũ ����
	//0.����������
	//1.���ڼ��ݰ�꼭 ���°� Ȯ��
	//2.��ǥ��������
	
	if(gcds_taxmst.countrow<=0) return;
	if(gclx_status.bindcolval=="I"||gclx_status.bindcolval=="C"||gclx_status.bindcolval=="M"||gclx_status.bindcolval=="N"||
	   gclx_status.bindcolval=="V"){
	   alert("���ݰ�꼭�� ����Ǿ����ϴ�. ���� �Ұ��մϴ�."); return false;		
	}
	
	if(fn_trim(gcem_fsdat.text)!="") {
		alert("��ǥ������ �Ǿ����ϴ�. ���� �Ұ��մϴ�."); return false;
	}
		
    var strParam = gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXNBR");
		
	if (confirm("����[����]������ ���� �Ͻðڽ��ϱ�?")){	
		
		gcds_taxmst.deleterow(gcds_taxmst.rowposition);
		gcds_taxdtl.deleterow(gcds_taxdtl.rowposition);
		
		//alert("sysStatus::"+gcds_taxmst.SysStatus(gcds_taxmst.rowposition));
		//alert("sysStatus::"+gcds_taxdtl.SysStatus(gcds_taxdtl.rowposition));
					
		gctr_data3.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_t1";
		gctr_data3.KeyValue = "Account.a040110_t1(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,O:USER7=gcds_return)";
		gctr_data3.Parameters ="v_str1="+strParam;
		//prompt('',gcds_taxmst.text);
		//prompt('',gcds_taxdtl.text);
		gctr_data3.post();
	}	
}
/******************************************************************************
Description : ����� Display    
******************************************************************************/
function ln_Display_Cocode(){
	
	if(gclx_cocode.bindcolval=="02"){//����
		sp1.style.display = "";
		gcem_s_bizplace.text="0001"; //��������ȣ
		gcem_remark2.text="����ƻ��ֽ�ȸ��(����) ���� ���α� ����� 194";
	}else if(gclx_cocode.bindcolval=="03"){//���
		sp1.style.display = "";
		gcem_s_bizplace.text="0002"; //��������ȣ
		gcem_remark2.text="����ƻ��ֽ�ȸ�� ������ ��籺 �վ�� ��ȣ�� 545";
	}else{ //��
		sp1.style.display = "none"; //����
		gcem_s_bizplace.text="";
		gcem_remark2.text="";
	}
}
/******************************************************************************
Description : Report Head ���� - ���ݰ�꼭 �󼼳���
******************************************************************************/
function ln_Taxmst_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,"
        	   + "TAXDIV:STRING,TAXDIVNM:STRING,TAXKND:STRING,TAXKNDNM:STRING,VEND_CD:STRING,VEND_ID:STRING,"
			   + "VEND_NM:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,"
			   + "REMARK:STRING,TAXCDNBR:STRING,ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,TAXPRTYN:STRING,"
			   + "TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,FSNBR:STRING,"
			   + "TAXKIDIV:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
			   + "FDCODE:STRING,VD_DIRECT:STRING,BSNS_CND:STRING,BSNS_KND:STRING,ADDNM:STRING,"
			   + "FSSTAT:STRING,WORKTYPE:STRING,EMPNMK:STRING,DEPTNM:STRING,"
			   + "SEQ:DECIMAL,EMPNM:STRING,DEPTNM_2:STRING,HPNO:STRING,TELNO:STRING,EMAIL:STRING,"
			   + "DTI_STATUS:STRING,GUBUN:STRING,AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,"
			   + "REMARK3:STRING,S_BIZPLACE:STRING,B_BIZPLACE:STRING,COSTCD:STRING,COSTNM:STRING,"
			   + "CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING";
	gcds_taxmst.SetDataHeader(s_tmp1);
}

/******************************************************************************
	Description : Report Head ���� - ���ݰ�꼭 �󼼳���
******************************************************************************/
function ln_Taxdtl_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,TAXQTY:DECIMAL,"
			   + "TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MMDD:STRING,TAXTOT:DECIMAL";
	gcds_taxdtl.SetDataHeader(s_tmp1);
}

/******************************************************************************
Description : �ŷ�ó ã��
******************************************************************************/
function ln_Vend_Popup(){

	var arrVAT	= new Array(); 
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrVAT[0]="VAT";
	strURL = "./gczm_vender_popup33.jsp";
	strPos = "dialogWidth:700px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrVAT,strPos);
		
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(arrParam[16]=="10"){
  			gcem_vendid.Format="###-##-#####";  
  		}else if (arrParam[16]=="13"){
  			gcem_vendid.Format="######-#######"; 		 
  		}
		gcem_seq.text      = arrParam[0];  //����  
		gcem_vendcd.text   = arrParam[1];  //�ŷ�ó �ڵ�  
		txt_vendnm.value   = arrParam[2];  //�ŷ�ó��
		gcem_vendid.text   = arrParam[15]; //�ŷ�ó ����� ��Ϲ�ȣ 
		gcem_vend_empnm.text = arrParam[3];  //����ڼ���           
		gcem_vend_email.text = arrParam[5];  //Email    
		gcem_vd_direct.text  = arrParam[14]; //����
	} else {
		gcem_seq.text      = "";  //����  
		gcem_vendcd.text   = "";  //�ŷ�ó �ڵ�  
		txt_vendnm.value   = "";  //�ŷ�ó��
		gcem_vendid.text   = ""; //�ŷ�ó ����� ��Ϲ�ȣ 
		gcem_vend_empnm.text = "";  //����ڼ���           
		gcem_vend_email.text = "";  //Email    
		gcem_vd_direct.text  = ""; //����
	}
}

/******************************************************************************
Description : �޷� ��� ��������
******************************************************************************/
function ln_GetCallCalendar(){
	__GetCallCalendar('gcem_taxdat', 'Text');
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD") = gcem_taxdat.text.substring(4,8);
	//alert("gcem_taxdat::"+gcem_taxdat.text);
}
/******************************************************************************
Description : �ݾ��ڵ����
******************************************************************************/
function ln_Auto_Sum(){
	var row = gcds_taxdtl.rowposition;	//���γ��� �հ�[����]
  	gcem_sup_amount.text = parseFloat(gcds_taxdtl.namevalue(row,"TAXSUM"));
  	gcem_tax_amount.text = parseFloat(gcds_taxdtl.namevalue(row,"TAXVATAMT"));
  	gcem_total_amount.text = parseFloat(gcem_sup_amount.text) + parseFloat(gcem_tax_amount.text);
}
/******************************************************************************
Description : �����˾�
parameter   : 
******************************************************************************/
function ln_Costcd_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]="0030";//�����ڵ�
	arrParam[1]="";
	
	if(txt_costnm.value==""){
		 arrParam[2]="";
	}else{
	   arrParam[2]=txt_costnm.value;
	}
	
	if(gcem_costcd.text==""){
	 arrParam[3]="";
	}else{
	 arrParam[3]=gcem_costcd.text;
	}
	
	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		gcem_costcd.text =arrResult[0];
		txt_costnm.value = arrResult[1];
	}else{
		gcem_costcd.text="";
		txt_costnm.value="";
	}	
}	

/******************************************************************************
Description : ã�� - �����ڵ�
******************************************************************************/
function ln_Atcode_Popup(){
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode.text	=	arrResult[0];
		txt_atkornam.value	=	arrResult[1];
		txt_atdecr.value	=	arrResult[2];
	} else {
		gcem_atcode.text	="";
		txt_atkornam.value	="";
		txt_atdecr.value	="";
	}
}


/******************************************************************************
Description : ���� ��ư üũ
              2009.12.04 jys �߰�
******************************************************************************/
function ln_Rdo_Chk(param){

	if(param=="1"){
		rdo_gubun1_1.checked=true;
		rdo_gubun1_2.checked=false;
	}else if(param=="2"){
		rdo_gubun1_1.checked=false;
		rdo_gubun1_2.checked=true;
	}
}

/******************************************************************************
Description : ������ ���� ��꼭��ȣ ���а� ����
Param       : strFdcode - ����( 01:����, 02:����, 03:�ݰ���, 04:����)   
              g_gb - ����( A:���� , B:����)
******************************************************************************/
function ln_Taxnbr_Gb(strFdcode){

	if(strFdcode=="03"){ //�ݰ���
		if(g_gb=="A"){
			return "E";
		}else if(g_gb=="B"){
	  		return "F"; 
		}
	}else if(strFdcode=="04"){ //����
		if(g_gb=="A"){
		  	return "C";
		}else if(g_gb=="B"){
	  		return "D"; 
		}
	}else{ //����
		if(g_gb=="A"){
	  		return "A";
		}else if(g_gb=="B"){
		  	return "B";
		}
	}
}

/******************************************************************************
Description : �űԵ��[�ſ�ī��]
******************************************************************************/
function ln_CardPopup(){

	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	strURL = "./card_popup.jsp";
	strPos = "dialogWidth:450px;dialogHeight:420px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		gcem_canbr.text	=	arrResult[0];
	} else {
		gcem_canbr.text	=	"";
	}
}

/******************************************************************************
Description : ����
              ������������ ���ڹ��౸�� �ڵ� ���� 
******************************************************************************/
function ln_Taxknd_Chg(){
	if(gclx_taxknd.bindcolval=="1"||gclx_taxknd.bindcolval=="2"||gclx_taxknd.bindcolval=="4"){
		ln_Rdo_Chk('1');
	}else if(gclx_taxknd.bindcolval=="3"||gclx_taxknd.bindcolval=="7"||gclx_taxknd.bindcolval=="8"){
	    ln_Rdo_Chk('2');
	}
}

/******************************************************************************
Description : �ܺνý��� �������
              2010.08.24 jys �߰�
******************************************************************************/
function ln_ChkBox2(){

	if(chk_ext.checked==true){ 
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"EXTCHK")="1";
		alert("�ܺνý��� ���� ���θ� [ȸ����]�� �� Ȯ�� �� üũ�Ͽ� �ֽñ� �ٶ��ϴ�.(�� 3669-3638)");
	}else{
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"EXTCHK")="0";
	}	
}

/******************************************************************************
	Description : ������ ���� ������  ��ȸ
******************************************************************************/
function ln_B_Query(strTaxnbr){

  if(fn_trim(strTaxnbr)==""){
	alert("��꼭��ȣ�� �����ϴ�. Ȯ�� �ٶ��ϴ�.");  
	return; 
  }	
	
  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_s1?v_str1="+strTaxnbr        //����                                                                                   
  //prompt("",gcds_data.DataID);
  gcds_data.Reset();

}

/******************************************************************************
Description : ������ ���� ���� �� ��ȸ
******************************************************************************/
function ln_A_Query(strTaxnbr){

  if(fn_trim(strTaxnbr)==""){
	alert("��꼭��ȣ�� �����ϴ�. Ȯ�� �ٶ��ϴ�.");  
	return; 
  }	
	
  gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_s2?v_str1="+strTaxnbr        //����                                                                                   
  //prompt("",gcds_data.DataID);
  gcds_data2.Reset();

}

/******************************************************************************
Description : ������ ���� ����
******************************************************************************/
function ln_B_Save(){
	
	//�̵���� üũ 
	if(!ln_User_Chk()) return;
	
	//�ܺι������ ������� ����.
	if(chk_ext.checked==true){
		alert("�ܺι������ ������� �� �� �����ϴ�.");
		return false;
	}
	
	var strregno ="";
	
	if(!ln_B_Chk())return;
	
	if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;       
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	
	if(strregno==""){
		strregno="2218113834";
	}
	
	if(fn_trim(gusrid)==""){
		alert("����� Ȯ���Ͻʽÿ�.");
		return;
	}
	
	//�� �̷� ���� �߻��ϴ��� Ȯ���غ�����..........
	//JYS. �������� ����ڵ�Ϲ�ȣ�� Ʋ���ٰ� ����....����� ���̺� 2���� �Է��ؼ� �׷���???????
	if(gusrid=="6070001"){
		alert("gclx_cocode.bindcolval::"+gclx_cocode.bindcolval+"::strregno::"+strregno);
	}
	
	//2014.10.15 JYS �̰��� �Ϲ� ���� ��츸 �ش���.
	//���� ������� a040060_t1_ee_A �� �����ϸ� �� ��. --���°��� ������ؼ� ����...
	if(gcds_data.namevalue(gcds_data.rowposition,"DTI_STATUS")=="S"){ //��������
		if (gcds_data.IsUpdated) {
			if (confirm("������� �Ͻðڽ��ϱ�?")){	
			    gs_sm_call_status="I";
			    ln_Batch_id("gcds_data");
			}
		}	
	}else { //NULL
	
		if (gcds_data.IsUpdated) {
			if (confirm("���� �Ͻðڽ��ϱ�?")){	
				gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_t1_ee_A"
				gctr_data2.Parameters = "v_str1="+strregno+",v_str2="+gusrid;
				//prompt('',gcds_data.text);
				gctr_data2.post();
			}	
		}
	}
}


/******************************************************************************
Description : ��꼭 ����� ���üũ 
******************************************************************************/
function ln_User_Chk(){
	//��꼭 ����� ��� üũ && Email ��� üũ
	gcds_chk.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_sm_user_s1?v_str1="+gs_userid;
	gcds_chk.Reset();
	
	if(gcds_chk.countrow<=0){
		alert("�������ڼ��ݰ�꼭 ������ �ݵ�� [��꼭 ����ڰ���]�� ����ϼž� �մϴ�. ");
		return false;
	}
	
	if(gcds_chk.namevalue(gcds_chk.rowposition,"SMART_ID")==""){
		alert("smartbill.co.kr �� ����� ������ id�� ��꼭 ����ڰ����� ����ϼž� �մϴ�. ");
		return false;
	}
	
	if(gcds_chk.namevalue(gcds_chk.rowposition,"SMART_PASSWORD")==""){
		alert("smartbill.co.kr �� ����� ������ password�� ��꼭 ����ڰ����� ����ϼž� �մϴ�. ");
		return false;
	}
	
	if(gcds_chk.namevalue(gcds_chk.rowposition,"EMAIL")==""){
		alert("smartbill.co.kr�� ����� eMail�� ����ϼž� �մϴ�. ");
		return false;
	}
	
	return true;
}


/******************************************************************************
Description : üũ 
******************************************************************************/
function ln_B_Chk(){

	gcgd_xxsb.focus();
	
	//üũ�� ���� ���
	var intcnt = 0; 
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			intcnt+=1;
		}
	}
	
	if (intcnt==0){
		alert("���� ���� ���� �����Ͽ��� �մϴ�.");
		return false;
	}
	
	for (j=1;j<=gcds_data.countrow;j++){
		if(gcds_data.namevalue(j,"CHK")=="T"){
	
		    //2009.09.03
			//�������� ������ ���� ��ǥ��ȣ�� ������ ��찡 ����.
			if(gcds_data.namevalue(j,"FDCODE")=="04"){
	
			}else{
				//��ǥ��ȣ�� ������ ��� 
				//�ӽø���..2009.10.05 JYS
				if(gcds_data.namevalue(j,"SLIPNO")!=""){
					alert(j+" �࿡ ��ǥ��ȣ�� �����Ͽ� �� ������ �� �����ϴ�.");
					return false;
				}
			}
	
			//�ŷ�ó���� ���� ���
	  		if(gcds_data.namevalue(j,"VEND_NM")==""){
				alert(j+" ���� �ŷ�ó�� Ȯ�� �Ͻʽÿ�.");
				return false;
			}
	
			//����ڵ�Ϲ�ȣ�� ���� ���
			if(gcds_data.namevalue(j,"VEND_ID")==""){
				alert(j+" ���� ����ڵ�Ϲ�ȣ�� Ȯ�� �Ͻʽÿ�.");
				return false;
			}
	
			//���ް����� ���� ���
			if(gcds_data.namevalue(j,"TAXSUM")==0){
				alert(j+" ���� ���ް����� Ȯ�� �Ͻʽÿ�.");
				return false;
			}
	
			//�հ���� ���� ���
			if(gcds_data.namevalue(j,"TAXTOT")==0){
				alert(j+" ���� �հ���� Ȯ�� �Ͻʽÿ�.");
				return false;
			}
	
			//��꼭 ��ȣ�� ���� ���
			if(gcds_data.namevalue(j,"TAXNBR")==0){
				alert(j+" ���� ��꼭��ȣ�� Ȯ�� �Ͻʽÿ�.");
				return false;
			}
	
			//Email�� ���� ��� ���� ���� ����. ( Ư�� �������� �����)
			if(gcds_data.namevalue(j,"EMAIL")==""){
				alert(j+" ���� EMAIL�� Ȯ���Ͻʽÿ�.");
				return false;
			}
	
	
			//2009.12.09 JYS
			//�ۼ����� �� �������� ���ؼ� �ۼ�����>�������� ��� ����ȵ�.
	  		if(gcds_data.namevalue(j,"TAXDAT")>gs_curdate){
				alert(j+" ���� ��꼭 �ۼ����ڸ� Ȯ���Ͻʽÿ�.");
				return false;
			}
		}
	}
	
	return true;
}

/******************************************************************************
Description : ����Ʈ ��� ȣ�� 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){
	
	var url="";
	var v_left = (screen.width-300)/2;
	var v_top  = (screen.height-300)/2;
	
	if (gs_sm_call_status=="V"){         //���ݰ�꼭 ���� �� ���
		url=gs_url+"/callSB_V3/XXSB_DTI_PRINT.asp?BATCH_ID="+strBatchId+"&SORTFIELD=A&SORTORDER=1";		
		window.open(url,"", "status=1,  scrollbars=yes, width=300, height=280, left="+v_left+", top="+v_top );
	}else if (gs_sm_call_status=="R"){   //������ ����
		url=gs_url+"/callSB_V3/XXSB_DTI_RARISSUE.asp?CONVERSATION_ID="+gs_conversation_id+"&ID="+strId+"&PASS="+strPass;	
		window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );
	}else if (gs_sm_call_status=="I"){   //������ ���� 
		url=gs_url+"/callSB_V3/XXSB_DTI_ARISSUE.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
		window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );
		setTimeout("ln_Query()", 5000);   //5000(5���� ����: �ѹ���)
	}
}

/******************************************************************************
Description : ���ݰ�꼭 ����
parameter   :            
******************************************************************************/
function ln_Bill_View(){
	
	if(gcds_data2.namevalue(gcds_data2.rowposition,"CHK")=="T"){
		//���°��� ���Ź̽���, ���Ž��� �Ǹ� ���� 
		if(gclx_status.bindcolval=="I"||gclx_status.bindcolval=="C"){
			gs_sm_call_status="V"; // ��꼭���� tag
			ln_Batch_id("gcds_data2");	
		}else{
			alert("������¸� Ȯ���Ͻʽÿ�. [���Ź̽���],[���Ž���] �Ǹ� ��꼭 ���Ⱑ �����մϴ�.");
			return false;
		}
	}else{
		alert("���ݰ�꼭�� �� ����� üũ �� �ֽñ� �ٶ��ϴ�.");
		return false;
	}	
}
/******************************************************************************
Description : Interface_Batch_id ���� �� ������� id, pw ã��
parameter   :            
******************************************************************************/
function ln_Batch_id(strdataSet){      
   
	var strregno ="2218113834";
	
	if(strdataSet="gcds_data"){
		gctr_data4.KeyValue = "a040065_t1(I:USER=gcds_data,O:USER2=gcds_return2)";
	}else if(strdataSet="gcds_data2"){
		gctr_data4.KeyValue = "a040065_t1(I:USER=gcds_data2,O:USER2=gcds_return2)";
	}
	
	gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t1"
	gctr_data2.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
	
	gctr_data2.post();
}

/***********************************************************************************************
Description : ����[��ǥ��ȸ]
parameter   : fcod - �����ڵ�, fsdt - ��ǥ����, fnbr - ��ǥ��ȣ
**********************************************************************************************/
function ln_Slipno_Popup(){
	if(gcem_fsdat.text != "") {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
		arrParam[0] = gclx_fdcode.bindcolval;
		arrParam[1] = gcem_fsdat.text;
		arrParam[2] = gcem_fsnbr.text;
	
		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}else{
		alert("���� �� ��ǥ�� �����ϴ�.");
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxknd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxmst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name=ViewDeletedRow	value="true">
	
</object>

<object  id=gcds_taxdtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=ViewDeletedRow	value="true">
	
</object>

<object  id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_return2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<PARAM NAME="KeyValue"          VALUE="a040060_t1_ee_A(I:USER=gcds_data,O:USER2=gcds_return2)">
</object>

<object  id=gctr_data3 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data4 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	//gclx_fdcode.bindcolval=gs_fdcode;
</script>
<script language="javascript" for="gcds_taxmst" event="onloadCompleted(row,colid)">
	if (row<1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
		if(gcds_taxmst.namevalue(row,"GUBUN")=="1"){
			ln_Rdo_Chk('1');
		}else if(gcds_taxmst.namevalue(row,"GUBUN")=="2"){
		    ln_Rdo_Chk('2');
		}
	}
</script>

<script language="javascript" for="gcds_taxdtl" event="onloadCompleted(row,colid)">

	if (row<1) { 
		//alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
		ln_Auto_Sum();
	}
</script>

<script language="javascript" for="gcds_empno_chk" event="onloadCompleted(row,colid)">
		ln_Authority_Result(row,colid);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
	ln_Display_Cocode();
</script>

<script language=JavaScript for=gcds_taxdtl event=onColumnChanged(row,colid)>
	if (colid == "TAXVATAMT" || colid == "TAXSUM") {
		gcds_taxdtl.Namevalue(row,"TAXTOT") = parseFloat(gcds_taxdtl.NameValue(row,"TAXVATAMT")) + parseFloat(gcds_taxdtl.NameValue(row,"TAXSUM"));
	}

	if (colid == 'TAXSUM') {
		if(gclx_taxknd.bindcolval=="1"){ //������ ��� 
			gcds_taxdtl.NameValue(row,'TAXVATAMT')= Math.round(gcds_taxdtl.NameValue(row,'TAXSUM')*0.1);
		}else{
			gcds_taxdtl.NameValue(row,'TAXVATAMT')=0;
		}
	}
	if(colid=='TAXPDTNAM'&&gcds_taxdtl.NameValue(row,'TAXPDTNAM')!=""){
		if(gcds_taxdtl.NameValue(row,'TAXPDTNAM').length>34){
			alert("ǰ����� �ʹ� �� ������ ���� ���� ���� �ֽ��ϴ�.");
		}
	}
</script>

<script language=JavaScript for=gcgd_taxdtl event=onKeyPress()>
	ln_Auto_Sum();
</script>

<script language=JavaScript for=gcgd_taxdtl event=OnKillFocus()>
	ln_Auto_Sum();
</script>

<script language=JavaScript for=gcem_taxdat event=onKeyUp(kcode,scode)>
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD") = gcem_taxdat.text.substring(4,8);
</script>

<script language=JavaScript for=gclx_taxknd event=OnSelChange()>
	ln_Taxknd_Chg();
</script>
 
<script language=JavaScript for=gcem_erp_remark event=onKillFocus()>
	if(fn_trim(gcem_erp_remark.text)!=""){
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM") =gcem_erp_remark.text; 	
	}
</script>
 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	 alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	 gcem_taxnbr_s.text = gcds_return.namevalue(gcds_return.rowposition,"TAXNBR"); //������ ����.
	 
	 //������ ���� ������ ��ȸ(��ȸ������ ��꼭��ȣ)  
	 ln_B_Query(gcem_taxnbr_s.text);
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data2 event=OnSuccess()>

    ln_SM_Call(gcds_return2.namevalue(gcds_return2.rowposition,"BATCH_ID"),
               gcds_return2.namevalue(gcds_return2.rowposition,"ID"),
		       gcds_return2.namevalue(gcds_return2.rowposition,"PASS"));  
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("���ڼ��ݰ�꼭 ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data3 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	gcem_taxnbr_s.text = gcds_return.namevalue(gcds_return.rowposition,"TAXNBR"); //������ ����.
	 
	//������ ���� ������ ��ȸ(��ȸ������ ��꼭��ȣ)  
	ln_Query();
</script>

<script language=JavaScript for=gctr_data3 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data3.ErrorCode + "\n" + "Error Message : " + gctr_data3.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data4 event=OnSuccess()>
    /*
	if(gusrid=="2010012"){
		alert("BATCH_ID::"+gcds_return2.namevalue(gcds_return2.rowposition,"BATCH_ID"));
	}
    */

    ln_SM_Call(gcds_return2.namevalue(gcds_return2.rowposition,"BATCH_ID"),
               gcds_return2.namevalue(gcds_return2.rowposition,"ID"),
		       gcds_return2.namevalue(gcds_return2.rowposition,"PASS"));  
</script>

<script language=JavaScript for=gctr_data4 event=OnFail()>
	alert("���ڼ��ݰ�꼭 ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data4.ErrorCode + "\n" + "Error Message : " + gctr_data4.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<!-- ������ ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px" colspan=2><td></tr>
	<tr>
		<td align=left style="position:relative;left:6px;top:-2px" colspan=2>
			<table cellpadding="0" cellspacing="0" border="0" style='width:950px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:90px;" bgcolor="#eeeeee"><nobr>��꼭��ȣ</nobr></td>
					<td class="tab23" width ="100px">
						<comment id="__NSID__">
						<object id=gcem_taxnbr_s  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="#000000-0000">
							<param name=PromptChar	  value="_">
							<param name=UpperFlag     value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_taxselect.gif"  style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Slipno_Popup()">
						<img src="../../Common/img/btn/com_b_delete.gif"	 style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Delete()">
						<img src="../../Common/img/btn/com_b_insert.gif"	 style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Add()">
						<img src="../../Common/img/btn/com_b_save.gif"		 style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Save()">
						<img src="../../Common/img/btn/com_b_query.gif"	     style="cursor:hand;position:relative;top:0px;right:2px" onClick="ln_Query()"> 
					 </nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="30px" colspan=2>
			<b><font size="2" color="blue">&nbsp;�� ��������(ERP)</font></b>
		<td>
	</tr>
	<tr><!-- ERP����----------------------------------------------------------------------------------------->
	   	<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab21" width="100px">
						<comment id="__NSID__">
							<object  id=gclx_fdcode  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:70px;height:110px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
								<param name=Enable				value=true>
								<param name=ListExprFormat	    value="FDNAME^0^70">
								<param name=BindColumn			value="FDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>��&nbsp;��&nbsp;��</nobr></td>
					<td class="tab22" width="220px">
					    <comment id="__NSID__"> 
							<object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:2px;font-size:12px;width:60px;height:200px;">
								<param name=CBData				value="02^����,01^��,03^���">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^60">
								<param name=BindColumn			value="CDCODE">
								<param name=Enable              value=true>
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
             			<span id=sp1 style="display:none;">
						<font color="" style="position:relative;top:-5px;" >�������</font>&nbsp;
						<comment id="__NSID__"> 
							<object  id=gcem_s_bizplace classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						</span>
					</td>
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>���μ�</nobr></td>
					<td class="tab19" width="140px;">
						<comment id="__NSID__"> 
							<object  id=gcem_deptnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:105px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text		        value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							<object  id=gcem_deptcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:10px;height:20px;position:relative;left:0px;top:2px">		
								<param name=Text		        value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=Visible             value=false>	
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						 
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>�����</nobr></td>
					<td class="tab22" >
						 <comment id="__NSID__"> 
							<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:105px;height:20px;position:relative;left:5px;top:0px;">		
								<param name=Text		  value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							<object  id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:10px;height:20px;position:relative;left:0px;top:2px">		
								<param name=Text		        value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=Visible             value=false>	
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>	
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_date'  id='v_chk_date'  style="width:20px;" >��꼭����</nobr></td>
					<td class="tab21" width="100px"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_taxdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment	  value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable		  value="true">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
					    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1  OnClick="ln_GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:3px;top:2px;cursor:hand;">
					    </nobr>
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>�������</nobr></td>
					<td class="tab22" width="220px">
					   <comment id="__NSID__">
							<object id=gclx_status      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:2px;top:1px;width:100px;">
								<param name=CBData		    value="S^��������,I^���Ź̽���,C^���Ž���,R^���Űź�,O^��ҿϷ�,M^������ҿ�û(���޹޴���),N^������ҿ�û(������),V^�������û,T^������ź�,W^�������û ���">
								<param name=CBDataColumns	value="CODE,NAME">
								<param name=SearchColumn	value=NAME>
								<param name=Sort			value=false>
                                <param name=Enable 	        value=false>
								<param name=ListExprFormat	Value="CODE^0^30,NAME^0^100">								
								<param name=BindColumn		value="CODE">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>��������</nobr></td><!-- =�ΰ������� -->
					<td class="tab19" width="115px;">
						<comment id="__NSID__">
							<object  id=gclx_taxknd  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:150px;">
								<param name=ComboDataID			value="gcds_taxknd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat		value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>�ͼӱ���</nobr></td>
					<td class="tab22" >
						<comment id="__NSID__">
							<object  id=gclx_taxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:0px;font-size:12px;width:110px;height:200px;">
								<param name=ComboDataID			value="gcds_taxdiv">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^110">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>	
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_vend'  id='v_chk_vend'  style="width:20px;" >�ŷ�ó</nobr></td>
					<td class="tab22" width="860px;" colspan="7" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:5px;width:90px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
								<param name=ReadOnly        value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-2px;cursor:hand"	 onclick="ln_Vend_Popup()">
						<input id=txt_vendnm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:362px;height:18px" readOnly>
						<comment id="__NSID__">
							<object  id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:5px;width:115px;">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="###-##-#####">
								<param name=PromptChar	value="_">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							<object  id=gcem_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px;">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=visible			value=false>
								<param name=PromptChar	value="_">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				
				<tr>	
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>�ŷ�ó�������</nobr></td>
					<td class="tab21" width="100px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vend_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>���Email</nobr></td>
					<td class="tab21"  colspan=3  >
						<comment id="__NSID__">
							<object  id=gcem_vend_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:405px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text				value="">
								<param name=Alignment           value=0>
								<param name=Border              value=true>
								<param name=GeneralEdit         value=true>
								<param name=Language	        value=1>
								<param name=ReadOnly            value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>��ǥ�ڸ�</nobr></td>
					<td class="tab22"    >
						<comment id="__NSID__">
							<object  id=gcem_vd_direct classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text				value="">
								<param name=Alignment           value=0>
								<param name=Border              value=true>
								<param name=GeneralEdit         value=true>
								<param name=Language	        value=1>
								<param name=ReadOnly            value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_remark'  id='v_chk_remark'  style="width:20px;" >����</nobr></td>
					<td class="tab21" width="400px" colspan=3>
						<comment id="__NSID__">
							<object  id=gcem_erp_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:399px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>��ǥ������ȣ</nobr></td>
					<td class="tab21" >
					    <comment id="__NSID__"> 
							<object  id=gcem_fsdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:63px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="#########">
								<param name=PromptChar	    value="_">
								<param name=ReadOnly           value=true> 
								<param name=ReadOnlyBackColor  value="#CCFFCC">
							</object>&nbsp;-
							<object  id=gcem_fsnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:3px;top:2px;width:45px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="######">
								<param name=PromptChar	    value="_">
								<param name=ReadOnly            value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object></comment>
						<script>__ws__(__NSID__);</script> 
					</td>	
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>��ǥ����</nobr></td>
					<td class="tab22" >
						 <comment id="__NSID__">
							<object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:110px;height:100px;">
								<param name=CBData			    value="Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>	
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_account'  id='v_chk_account'  style="width:20px;" >������</nobr></td>
					<td class="tab21" width="400px" colspan=3><nobr>
						<comment id="__NSID__">
							<object id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#######">
								<param name=PromptChar	    value="_">
								<param name=Enable			value="false">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Atcode_Popup()">
						<input id=txt_atkornam type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:302px;height:18px" readOnly = true>
						<input id=txt_atdecr type="text" class="txt11" style="position:relative;left:5px;width:70px;display:none"></nobr> 
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>���ڹ��౸��</nobr></td>
					<td class="tab22" colspan =3 >						
            			<INPUT type="radio" id=rdo_gubun1_1 value="1" onclick="ln_Rdo_Chk('1')">���ڹ���
					    <INPUT type="radio" id=rdo_gubun1_2 value="2" onclick="ln_Rdo_Chk('2')">�������				
					</td>
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_cost'  id='v_chk_cost'  style="width:20px;" >����</nobr></td>
					<td class="tab22" colspan=7>
					<nobr>
						<comment id="__NSID__">
							<object id=gcem_costcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:5px;width:50px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="######">
								<param name=PromptChar	    value="_">
								<param name=Enable			value="false">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:3px" align=center onclick="ln_Costcd_Popup();">				
						<input id="txt_costnm" type="text" class="txtbox"  style= "position:relative;left:5px;top:-4px;width:302px;height:18px;" maxlength="36"  readOnly = true>			
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="blue" >* ���� ������� [�ǸŰ����� ��]���� �Է��ϼ���.</font>
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>���</nobr></td>
					<td class="tab21" colspan=3><nobr>
						<comment id="__NSID__">
							<object  id=gcem_remark2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:400px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		 value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					
					<td class="tab22" colspan=4><nobr>
						  <INPUT id=chk_ext type=checkbox  value='0' style="position:relative;top:0px" onclick="ln_ChkBox2()" > <font color="blue" >�ܺνý��� �������</font>
					<td>
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>���ް���</nobr></td>
					<td class="tab22" width="140px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>�ΰ�����</nobr></td>
					<td class="tab22"  ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_tax_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>�հ�</nobr></td>
					<td class="tab22"  colspan=3 ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_total_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>		
			</table>
		</td>
	</tr>
		
	<!-- ������ ǰ��----------------------------------------------------------------------------------------->
	<!-- ����(��/��), ǰ��, �԰�, ����, �ܰ�, ���ް���, ����, �հ�, ����, ��ǥ, ����, �ܻ���Ա�, ����, û��   -->
	<tr>
		<td height="30px" colspan=2 >
			<b><font size="2" color="blue">&nbsp;�� ���γ��� </font></b>
		<td>
	</tr>
    <tr>
		<td style="cursor:hand;position:relative;left:6px;" width="845px" colspan=2><nobr>
		 	<comment id="__NSID__">
		  		<object id=gcgd_taxdtl classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width='950px' height='41px' border='1'>
					<param name="dataid"		 value="gcds_taxdtl">
					<param name="borderstyle"    value="0">
					<param name="indwidth"       value="0">
					<param name="fillarea"		 value="true">
					<param name="colsizing"      value="true">
					<param name="editable"       value="true">
					<param name="format"		 value="  
					<C>  Name='����'			ID=MMDD                Width=80 	align=center   bgcolor=#CCFFCC  mask='XX/XX' edit=none </C>
					<C>  Name='ǰ��'         ID=TAXPDTNAM           Width=320 	align=left     bgcolor=yellow </C>			
					<C>  Name='�԰�'         ID=TAXSTD          	   Width=100	align=left     bgcolor=#CCFFCC edit=none </C>			  					
					<C>  Name='����'		    ID=TAXQTY          	   Width=30 	align=right    bgcolor=#CCFFCC edit=none </C>
					<C>  Name='�ܰ�'         ID=TAXPRIC             Width=100	align=right	   bgcolor=#CCFFCC edit=none </C>					
					<C>  Name='���ް���'      ID=TAXSUM              Width=100  	align=right	   bgcolor=yellow </C>					
					<C>  Name='�ΰ�����'      ID=TAXVATAMT           Width=100	align=right	   bgcolor=yellow </C>
					<C>  Name='�հ�'         ID=TAXTOT              Width=100	align=right	   bgcolor=#CCFFCC edit=none </C>							
				  	 ">
				</object>
			</comment><script>__ws__(__NSID__);</script></nobr>
		<td>			   
     </tr>	
     
    <tr>
		<td height="30px" >
			<b><font size="2" color="blue">&nbsp;�� ��������� (������) </font></b>
		</td>
		<td align =right  >
			<img src="../../Common/img/btn/com_b_sale.gif"    style="cursor:hand;position:relative;top:1px;right:2px" onClick="ln_B_Save()">
		</td>
	</tr> 
	
	 <tr>
		<td style="cursor:hand;position:relative;left:6px;" width="845px" colspan=2><nobr>
		 	<comment id="__NSID__">
		  		<object id=gcgd_xxsb classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width='950px' height='56px' border='1'>
					<param name="dataid"		 value="gcds_data">
					<param name="borderstyle"    value="0">
					<param name="indwidth"       value="0">
					<param name="fillarea"		 value="true">
					<param name="colsizing"      value="true">
					<param name="editable"       value="true">
					<param name="format"		 value="  
						<FC> Name='����'	          ID=CHK         	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	EditStyle=CheckBox </FC> 
						<FC> Name='�ŷ�ó��'		  ID=VEND_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		edit=none </FC>
						<FC> Name='����ڵ�Ϲ�ȣ'	  ID=VEND_ID   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=center    edit=none  mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')} </FC>
						<C>  Name='���ް���'		  ID=TAXSUM        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right		edit=none </C>
						<C>  Name='�ΰ�����'		  ID=TAXVATAMT        HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=right		edit=none </C>
						<C>  Name='�հ�'           ID=TAXTOT   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right  	edit=none </C>
						<C>  Name='����'           ID=REMARK        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left  	edit=none </C>
						<C>  Name='����'           ID=DTI_STATUS       HeadAlign=Center HeadBgColor=#B9D4DC Width=80	    align=left  	edit=none  EditStyle=Combo Data='S:��������,I:���Ź̽���,C:���Ž���,R:���Űź�,O:��ҿϷ�,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),V:�������û,T:������ź�,W:�������û ���'</C>
						<C>  Name='��꼭��ȣ'      ID=TAXNBR        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=85	    align=center 	edit=none  Mask='XXXXXXX-XXXX'</C>
						<C>  Name='���޹޴���Email' ID=EMAIL            HeadAlign=Center HeadBgColor=#B9D4DC Width=150	    align=left  	edit=none  </C>
						<C>  Name='��꼭����'    	  ID=TAXDAT    	      HeadAlign=Center HeadBgColor=#B9D4DC Width=80	    align=center    edit=none  Mask='XXXX-XX-XX'</FC>
				  	 ">
				</object>
			</comment><script>__ws__(__NSID__);</script></nobr>
		<td>			   
     </tr>	
     
     <tr>
		<td height="30px" >
			<b><font size="2" color="blue">&nbsp;�� ��������� (������) </font></b>
		</td>
		<td align =right  >
			<img src="../../Common/img/btn/com_b_bill_view.gif"  style="cursor:hand" onclick="ln_Bill_View()">
		</td>
	</tr> 
	
	 <tr>
		<td style="cursor:hand;position:relative;left:6px;" width="845px" colspan=2><nobr>
		 	<comment id="__NSID__">
		  		<object id=gcgd_xxsb2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width='950px' height='56px' border='1'>
					<param name="dataid"		 value="gcds_data2">
					<param name="borderstyle"    value="0">
					<param name="indwidth"       value="0">
					<param name="fillarea"		 value="true">
					<param name="colsizing"      value="true">
					<param name="editable"       value="true">
					<param name="format"		 value="  
						<FC> Name='����'	           ID=CHK         	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center	EditStyle=CheckBox </FC> 
						<FC> Name='�ŷ�ó��'		   ID=BYR_COM_NAME   	    HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		edit=none </FC>
						<FC> Name='����ڵ�Ϲ�ȣ'	   ID=BYR_COM_REGNO         HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center    edit=none  Mask='XXX-XX-XXXXX'</FC>
						<C>  Name='���ް���'		   ID=SUP_AMOUNT            HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right		edit=none </C>
						<C>  Name='�ΰ�����'		   ID=TAX_AMOUNT            HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right		edit=none </C>
						<C>  Name='�հ�'            ID=TOTAL_AMOUNT   	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90  	align=right  	edit=none </C>			
						<C>  Name='����'            ID=DTI_STATUS    	    HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  EditStyle=Combo Data='S:��������,I:���Ź̽���,C:���Ž���,R:���Űź�,O:��ҿϷ�,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),V:�������û,T:������ź�,W:�������û ���'</C>			  					
						<C>  Name='�����ڵ�'		   ID=RETURN_CODE  	        HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none </C>
						<C>  Name='�����ڵ峻��'      ID=RETURN_DESCRIPTION    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none Value={IF(RETURN_CODE=30000,'����',RETURN_DESCRIPTION)}</C>					
					    <C>  Name='����'            ID=SBDESCRIPTION         HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none </C>		
						<C>  Name='Email'		   ID=BYR_EMAIL   	        HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left		edit=none </C>
						<C>  Name='��꼭����'    	   ID=DTI_WDATE  	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center    edit=none </FC>
						<C>  Name='�����ڵ�'         ID=AMEND_CODE            HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none EditStyle=Combo Data='01:��������� ����������,02:���ް��� ����,03:ȯ��,04:����� ����,05:�����ſ��� ���� ����'</C>
						<C>  Name='�������'         ID=REMARK        	    HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none </C>
				  	 ">
				</object>
			</comment><script>__ws__(__NSID__);</script></nobr>
		<td>			   
     </tr>	
	 <tr>
     	<td style="width:865;height:20px;border:0 solid #708090;border-top-width:1px"  colspan=2> * ��) [�����] ���� �ܺνý��ۿ��� ���� �������� ��� <font color="red">[�ܺνý��� �������]</font>�� �ݵ�� üũ �� �ֽʽÿ�.
		</td>
     </tr>
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N   -  �� ��
------------------------------------------------------------------------------>
<comment id="__NSID__">
    <object  id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_taxmst">
	<PARAM NAME="ActiveBind"	VALUE="true">
	<PARAM NAME="BindInfo"		VALUE="
	<C>Col=COCODE     		Ctrl=gclx_cocode    		Param=bindcolval </C>
	<C>Col=DEPTCD     		Ctrl=gcem_deptcd    		Param=text       </C>
	<C>Col=EMPNO      		Ctrl=gcem_empno     		Param=text       </C>
	<C>Col=TAXDIV     		Ctrl=gclx_taxdiv    		Param=bindcolval </C>
	<C>Col=TAXKND     		Ctrl=gclx_taxknd    		Param=bindcolval </C>
	<C>Col=VEND_CD    		Ctrl=gcem_vendcd    		Param=text       </C>
	<C>Col=VEND_ID    		Ctrl=gcem_vendid    		Param=text       </C>
	<C>Col=VEND_NM    		Ctrl=txt_vendnm     		Param=value      </C>
	<C>Col=TAXDAT     		Ctrl=gcem_taxdat    		Param=text       </C>
	<C>Col=REMARK     		Ctrl=gcem_erp_remark		Param=text       </C>
	<C>Col=TAXCDNBR   		Ctrl=gcem_canbr     		Param=text       </C>
	<C>Col=ATCODE     		Ctrl=gcem_atcode    		Param=text       </C>
	<C>Col=ATKORNAM   		Ctrl=txt_atkornam   		Param=value      </C>
	<C>Col=ATDECR     		Ctrl=txt_atdecr     		Param=value      </C>
	<C>Col=FSDAT      		Ctrl=gcem_fsdat     		Param=text       </C>
	<C>Col=FSNBR      		Ctrl=gcem_fsnbr     		Param=text       </C>
	<C>Col=FDCODE     		Ctrl=gclx_fdcode    		Param=bindcolval </C>
	<C>Col=SEQ        		Ctrl=gcem_seq       		Param=text       </C>
	<C>Col=S_BIZPLACE 		Ctrl=gcem_s_bizplace		Param=text       </C>
	<C>Col=VD_DIRECT  		Ctrl=gcem_vd_direct 		Param=text       </C>
	<C>Col=FSSTAT     		Ctrl=gclx_fsstat    		Param=bindcolval </C>
	<C>Col=DEPTNM     		Ctrl=gcem_deptnm    		Param=text       </C>
	<C>Col=EMPNMK      		Ctrl=gcem_empnm     		Param=text       </C>
	<C>Col=COSTCD     		Ctrl=gcem_costcd    		Param=text       </C>
	<C>Col=COSTNM     		Ctrl=txt_costnm     		Param=value      </C>
	<C>Col=EMPNM    		Ctrl=gcem_vend_empnm     	Param=text       </C>
	<C>Col=EMAIL     		Ctrl=gcem_vend_email     	Param=text       </C>
	<C>Col=DTI_STATUS     	Ctrl=gclx_status        	Param=bindcolval </C>
    <C>Col=REMARK2     	    Ctrl=gcem_remark2        	Param=text       </C>
    <C>Col=EXTCHK     	    Ctrl=chk_ext	            Param=Checked    	</C> 
	">
	</object>
	
</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - �� �� �� �� �� �� ��
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="DetailDataID"			    VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
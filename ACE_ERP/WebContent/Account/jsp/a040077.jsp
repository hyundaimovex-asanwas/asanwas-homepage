<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ȸ����� - �������ݰ�꼭
+ ���α׷� ID	:  a040077.jsp
+ �� �� �� ��	:  �������ݰ�꼭 
+ ��   ��   ��     :  �� �� ��
+ �� �� �� ��	:  a040077_s1
------------------------------------------------------------------------------
+ �� �� �� ��     :  2017.06.22
+ ��   ��   ��     :  ������  
+ �� �� �� ��     :  �������ݰ�꼭  ���� �� �����û �߰�
                              ��������� ������ ���� �Ǵ� ����������� ó���ؾ� ��.
                              ���ʽ��ι�ȣ�� ������ �� �ŷ�ó ������ �Բ� ������. (�����Ұ�)          
               ---------------------------------------------------------------
                             ���� �������� ������ + ���ڼ��ݰ�꼭 ������ ���ÿ� �̷������ ���μ�����
                             
                             ������ ( ���ʽ��ι�ȣ�� ���� �����ؾ���. )
                             �������ݰ�꼭 ���� ���μ��� �ű�                  
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�������ݰ�꼭</title>

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

var gs_frdt="";
var gs_todt="";

var gs_position =0;


/******************************************************************************
Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	
	gcem_sup_com_regno.text ="2218113834";
	ln_Before();
	ln_Initial();
	ln_User_Chk();
}

function ln_Initial(){
	
	gclx_cocode.bindcolval ="02"; //����� ���� �⺻
	ln_Display_Cocode();
	ln_Taxmst_SetDataHeader();
	ln_Taxdtl_SetDataHeader();
	gcds_taxdtl.addrow();
	ln_sup_vend_info();	
	
	ln_Clear_Byr_Vend();   //���޹޴��� ���� 
	
	gcem_taxdat.text="";   //��꼭���� 
	
	//��������
	gcem_modify_reason.text="";
	gcem_modify_reason_nm1.text="";
	gcem_modify_reason_nm2.text="";
	
	//����
	gcem_erp_remark.text="";
	
	//���ް���, �ΰ�����, �հ�, ��������
    gcem_sup_amount.text=0;
    gcem_tax_amount.text=0;
    gcem_total_amount.text=0;
    gcem_amend_code.text="";
    gcem_amend_codenm.text="";
    
    //����
    txt_costcd.value="";
    txt_costnm.value="";
    
    gclx_taxsts.bindcolval="N";
    gcem_duedate.text ="";
    gcem_taxnbr.text ="";
    
    document.fileForm.reset();
    document.fileForm.fileList.options[0].text="";
    document.fileForm.fileList.options[0].value="";
}

/*
 ���޹޴��� ����
 */
function ln_Clear_Byr_Vend(){
	gcem_vendcd.text   = ""; //�ŷ�ó �ڵ�  
	txt_vendnm.value = ""; //�ŷ�ó��
	gcem_vendid.text   =""; //�ŷ�ó ����� ��Ϲ�ȣ 
	gcem_empnm.text    = ""; //����ڼ���           
	gcem_email.text    =""; //Email    
	gcem_byr_com_regno.text= ""; //��Ϲ�ȣ
	
	gcem_byr_com_name.text = ""; //��ȣ
	gcem_byr_rep_name.text = ""; //����
	gcem_byr_com_addr.text = "";//�ּ�
	gcem_byr_bizplace_code.text = ""; //�������
	gcem_byr_com_type.text = ""; //����
	gcem_byr_com_classify.text = ""; //����
	gcem_byr_emp_name.text = ""; //�����
	gcem_byr_tel_num.text  = ""; //����ó
	gcem_byr_email.text    = ""; //�̸��� 	
}

/******************************************************************************
Description : ����ȸ
******************************************************************************/
function ln_Before(){
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
	
	//�ͼӱ���[���ⱸ��]
	gcds_taxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1215"; 
	gcds_taxdiv.Reset();
	
	//�ΰ�������[����]
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_taxknd.Reset();
	
	//������ �ŷ�ó ����
	gcds_sup_vend.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s7?v_str1="+gcem_sup_com_regno.text+"&v_str2=&v_str3=";                           
	//prompt('',gcds_sup_vend.DataID);
	gcds_sup_vend.Reset();
}


/******************************************************************************
Description : ���ʽ��ι�ȣ ã��
******************************************************************************/
function ln_ori_issue_id_find(){
		
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./a040077_popup1.jsp";
	arrParam[0]="";
	strPos = "dialogWidth:900px;dialogHeight:600px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);	

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		
		if(arrParam[2].length==10){
			gcem_ori_byr_com_regno.Format="###-##-#####"; 
  		}else if (arrParam[2].length==13){
  			gcem_ori_byr_com_regno.Format="######-#######"; 		
  		}
		
		gcem_ori_issue_id.text = arrParam[0];
		gcem_ori_byr_com_regno.text =  arrParam[2];
		
		//���� ���´� ����� ������ ������.
		gcem_sup_tel_num.text=arrParam[3]; //����ó
		gcem_sup_emp_name.text=arrParam[4];//����� 
		gcem_sup_email.text=arrParam[5]; //�̸���
		gcem_ori_dti_wdate.text =arrParam[6]; //���� 
		
		gcem_ori_sup_amount.text=arrParam[7];   //���ް��� 
        gcem_ori_tax_amount.text=arrParam[8];   //�ΰ����� 
        gcem_ori_total_amount.text=arrParam[9]; //�հ�
        gcem_ori_dti_type_nm.text=arrParam[10]; //�ͼӱ���		
	} else {
		gcem_ori_issue_id.text ="";
		gcem_ori_byr_com_regno.text =  "";
		gcem_sup_tel_num.text=""; //����ó
		gcem_sup_emp_name.text="";//����� 
		gcem_sup_email.text=""; //�̸���		
		gcem_ori_dti_wdate.text=""; //���� 
		gcem_ori_sup_amount.text="";   //���ް��� 
        gcem_ori_tax_amount.text="";   //�ΰ����� 
        gcem_ori_total_amount.text=""; //�հ�
        gcem_ori_dti_type_nm.text="";
	}
}


/******************************************************************************
Description : ����� ��Ϲ�ȣ�� ������, ���޹޴��� ���� ã�� 
******************************************************************************/
function ln_sup_vend_info(){
	gcem_sup_com_name.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"VEND_NM");
	gcem_sup_rep_name.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"VD_DIRECT");
	gcem_sup_com_addr.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"ADDRESS1")+ gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"ADDRESS2");
	gcem_sup_com_type.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"BSNS_CND");
	gcem_sup_com_classify.text  = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"BSNS_KND");	
}

/******************************************************************************
Description : �������� ã��
******************************************************************************/
function ln_modify_reason_find(){
	
	//alert("�������� ã��");
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./a040077_popup2.jsp";
	arrParam[0]="";
	strPos = "dialogWidth:900px;dialogHeight:600px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);	

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_modify_reason.text = arrParam[0];
	} else {
		gcem_modify_reason.text="";
	}
	
	if(gcem_modify_reason.text=="01"){
		gcem_modify_reason_nm1.text="������� ���� ���� ��";
		gcem_modify_reason_nm2.text="���ʼ��ݰ�꼭";
	}else if(gcem_modify_reason.text=="011"){
		gcem_modify_reason_nm1.text="������� ���� ���� ��";
		gcem_modify_reason_nm2.text="������ ���ݰ�꼭";
	}else if(gcem_modify_reason.text=="06"){
		gcem_modify_reason_nm1.text="������ ���� ���߹߱� ��";
	}else if(gcem_modify_reason.text=="02"){
		gcem_modify_reason_nm1.text="���ް��� ����";
	}else if(gcem_modify_reason.text=="04"){
		gcem_modify_reason_nm1.text="����� ����";
	}else if(gcem_modify_reason.text=="03"){
		gcem_modify_reason_nm1.text="ȯ��";
	}else if(gcem_modify_reason.text=="05"){	
		gcem_modify_reason_nm1.text="�����ſ��� ���İ���";
		gcem_modify_reason_nm2.text="���ʼ��ݰ�꼭";
	}else if(gcem_modify_reason.text=="051"){	
		gcem_modify_reason_nm1.text="�����ſ��� ���İ���";
		gcem_modify_reason_nm2.text="������ ���ݰ�꼭";
	}else{
		gcem_modify_reason_nm1.text="";
		gcem_modify_reason_nm2.text="";
	}
	
	gcem_amend_code.text = gcem_modify_reason.text;
	gcem_amend_codenm.text = gcem_modify_reason_nm1.text;
	
	if (gcem_amend_code.text=="011"){
		gcem_amend_code.text="01";
	}else if (gcem_amend_code.text=="051"){
		gcem_amend_code.text="05";
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
	}else if(gclx_cocode.bindcolval=="04"){//ȫ��
		sp1.style.display = "";
		gcem_s_bizplace.text="0003"; //��������ȣ
		gcem_remark2.text="����ƻ��ֽ�ȸ�� ��û���� ȫ���� ȫ�ϸ� �泲��� 36(���ش������ǽ���)";
	}else{ //��
		sp1.style.display = "none"; //����
		gcem_s_bizplace.text="";
		gcem_remark2.text="";
	}
	
	gcem_sup_bizplace_code.text = gcem_s_bizplace.text;
}


/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(e){
  
}

/******************************************************************************
Description : ���� ����

�����͸� 
ACCOUNT.ATTAXMST, ACCOUNT.ATTAXDTL
HDASAN_EDI.XXSB_DTI_MAIN, XXSB_DTI_ITEM, XXSB_DTI_STATUS�� INSERT �ؾ���.
******************************************************************************/
function ln_Save(){
	
	//���°��� ��û�ϰ��� ����Ұ�...
	if(gclx_taxsts.bindcolval!="N"&&gclx_taxsts.bindcolval!="B"){
		alert("������¸� Ȯ���Ͻʽÿ�.");
		return false;
	}
	
	if(!ln_User_Chk()) return;
	
	ln_Data_Setting();
	if(!ln_Chk())return;	
	//alert("gcds_taxmst.IsUpdated:;"+gcds_taxmst.IsUpdated);
	if (gcds_taxmst.IsUpdated) {
		if (confirm("�������ݰ�꼭�� ���� �Ͻðڽ��ϱ�?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040077_t1";
			gctr_data.KeyValue = "Account.a040077_t1(I:USER01=gcds_taxmst,I:USER02=gcds_taxdtl,I:USER=gcds_issueid,O:USER7=gcds_return)";	
			gctr_data.Parameters = "v_str1="+gcem_sup_com_regno.text+",v_str2="+gusrid+",v_str3="+gcem_ori_issue_id.text;
			          
			//prompt('',gcds_taxmst.text);
			//prompt('',gcds_taxdtl.text);
			//prompt('',gcds_issueid.text);
			gctr_data.post();
		}	
	}
}



/******************************************************************************
Description : DataSet�� �ݿ�

******************************************************************************/
function ln_Data_Setting(){
			
	var row = 0;
	
	gcds_issueid.clearAll();
	gcds_taxmst.clearAll();
	ln_Taxmst_SetDataHeader();
	gcds_issueid.addrow();
	gcds_taxmst.addrow();
	row = gcds_taxmst.rowposition;
	gcds_issueid.namevalue(gcds_issueid.rowposition,"ORI_ISSUE_ID") = gcem_ori_issue_id.text;
		
	var strdat = gcem_taxdat.text; 
	var strtaxkidiv ="";
	//alert("strdat.substring(4,6):;"+strdat.substring(4,6));
	
	if (strdat.substring(4,6) >='01' && strdat.substring(4,6) <='03') {
		strtaxkidiv="1";	//���[1]
	}else if(strdat.substring(4,6) >='04' && strdat.substring(4,6) <='06') {
		strtaxkidiv="2";	//���[2]
	}else if(strdat.substring(4,6) >='07' && strdat.substring(4,6) <='09') {
		strtaxkidiv="3";	//���[3]
	}else if(strdat.substring(4,6) >='10' && strdat.substring(4,6) <='12') {
		strtaxkidiv="4";	//���[4]
	}
		
	gcds_taxmst.namevalue(row,"TAXNBR")="" ;  // ��������� ������.
	gcds_taxmst.namevalue(row,"COCODE")=gclx_cocode.bindcolval;
	gcds_taxmst.namevalue(row,"DEPTCD")=gs_deptcd ;  //�α��� ���� ���� ���� ���� ��� ....üũ 
	gcds_taxmst.namevalue(row,"EMPNO")=gs_userid ;   //�α��� ���� ���� ���� ���� ��� ....üũ
	gcds_taxmst.namevalue(row,"TAXIODIV")="B" ;
	gcds_taxmst.namevalue(row,"TAXDIV")=gclx_taxdiv.bindcolval;
	gcds_taxmst.namevalue(row,"TAXKND")=gclx_taxknd.bindcolval;
	gcds_taxmst.namevalue(row,"VEND_CD")=gcem_vendcd.text;
	gcds_taxmst.namevalue(row,"TAXDAT")=gcem_taxdat.text ;
	gcds_taxmst.namevalue(row,"TAXSUM")=gcem_sup_amount.text ;
	gcds_taxmst.namevalue(row,"TAXVATAMT")=gcem_tax_amount.text ;
	gcds_taxmst.namevalue(row,"TAXTOT")=gcem_total_amount.text ;
	gcds_taxmst.namevalue(row,"REMARK")=gcem_erp_remark.text ;
	gcds_taxmst.namevalue(row,"TAXCDNBR")="" ;//�н�
	gcds_taxmst.namevalue(row,"ATCODE")="1110110" ; //��������  Default ���߿� ��ǥĥ�� �ٲ��
	gcds_taxmst.namevalue(row,"TAXPRTYN")="Y";
	gcds_taxmst.namevalue(row,"TAXCNT")=0 ;
	gcds_taxmst.namevalue(row,"LASTPRT")="" ;
	gcds_taxmst.namevalue(row,"TAXTYPE")="N" ;
	gcds_taxmst.namevalue(row,"FSDAT")="" ;
	gcds_taxmst.namevalue(row,"FSNBR")="" ;
	gcds_taxmst.namevalue(row,"TAXKIDIV")=strtaxkidiv ;  //����ؼ� �ֱ� ( ��꼭 ���ڷ� )
	gcds_taxmst.namevalue(row,"FDCODE")=gclx_fdcode.bindcolval;
	gcds_taxmst.namevalue(row,"WORKTYPE")="A" ;
	gcds_taxmst.namevalue(row,"REPORT")="" ;
	gcds_taxmst.namevalue(row,"WRDT")=gs_date ;
	gcds_taxmst.namevalue(row,"WRID")=gs_userid ;
	gcds_taxmst.namevalue(row,"UPDT")="" ;
	gcds_taxmst.namevalue(row,"UPID")="" ;
	gcds_taxmst.namevalue(row,"SSDAT")="" ;
	gcds_taxmst.namevalue(row,"SSNBR")="" ;
	gcds_taxmst.namevalue(row,"SEQ")=gcem_seq.text ;                   //�ŷ�ó ������
	gcds_taxmst.namevalue(row,"CONVERSATION_ID")="" ;
	gcds_taxmst.namevalue(row,"SUPBUY_TYPE")="" ;
	gcds_taxmst.namevalue(row,"DIRECTION")="" ;
	gcds_taxmst.namevalue(row,"GUBUN")="1" ;  //���� �����Է¹޾ƾ���.
	gcds_taxmst.namevalue(row,"AMEND_CODE")=gcem_amend_code.text ;
	gcds_taxmst.namevalue(row,"AMEND_REMARK")=gcem_remark.text ;  //��� 1 ��..
	gcds_taxmst.namevalue(row,"EXTCHK")="0" ;
	gcds_taxmst.namevalue(row,"REMARK2")=gcem_remark2.text ;
	gcds_taxmst.namevalue(row,"REMARK3")=gcem_remark3.text ;
	gcds_taxmst.namevalue(row,"S_BIZPLACE")=gcem_s_bizplace.text ;
	gcds_taxmst.namevalue(row,"B_BIZPLACE")="" ;
	gcds_taxmst.namevalue(row,"COSTCD")=txt_costcd.value;
	
	//�߰�����.....
	gcds_taxmst.namevalue(row,"EBILLGB")="1";                         //����Ʈ��
	gcds_taxmst.namevalue(row,"DUEDATE")=gcem_duedate.text;           //�Աݿ�����
	gcds_taxmst.namevalue(row,"TAXSTS")=gclx_taxsts.bindcolval;       //������� - ���
	gcds_taxmst.namevalue(row,"ORI_ISSUE_ID")=gcem_ori_issue_id.text; //���ʽ��ι�ȣ 
	
	//�߰�����2...
	//VEND_NM
	//VEND_ID
	//VD_DIRECT 
	//TAXKNDNM
	
	gcds_taxmst.namevalue(row,"VEND_NM")=txt_vendnm.value;            //�ŷ�ó��
	gcds_taxmst.namevalue(row,"VEND_ID")=gcem_vendid.text;            //��Ϲ�ȣ
	gcds_taxmst.namevalue(row,"VD_DIRECT")=gcem_byr_rep_name.text;    //���޹޴��� ��ǥ
	gcds_taxmst.namevalue(row,"TAXKNDNM")=gclx_taxknd.text;           //����
	
	//���γ���
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSEQ")="001";
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRID")=gs_userid;
		
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
Description : �ʼ��׸� üũ 
******************************************************************************/
function ln_Chk(){

	 //�ʼ��׸� üũ 
	 if (gcem_ori_issue_id.text=="") { alert("���ʽ��ι�ȣ�� �����ϴ�. Ȯ���Ͻʽÿ�.");  return false; }
	 if (gcem_modify_reason.text==""){ alert("����������  �����ϴ�. Ȯ���Ͻʽÿ�.");	     return false; }
	 if (gclx_fdcode.bindcolval=="") { alert("������ �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");  return false; } 
	 if (gclx_cocode.bindcolval=="") { alert("������� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;	 }	 
	 if (gclx_taxdiv.bindcolval=="") { alert("�ͼӱ����� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 if (gclx_taxknd.bindcolval=="") { alert("���������� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 if (gcem_vendcd.text=="")  { alert("�ŷ�ó�ڵ尡 �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (txt_vendnm.value==""){ alert("�ŷ�ó���� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_vendid.text=="")  { alert("����ڵ�Ϲ�ȣ��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }  
	 if (gcem_empnm.text=="") { alert("�ŷ�ó ��� ������  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }  
	 if (gcem_email.text=="") { alert("�ŷ�ó Email��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;	 }  
	 if (gcem_erp_remark.text==""){ alert("���䰡  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }  
	 if (gcem_taxdat.text==""){ alert("��꼭 ���ڰ�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}   
	 if (txt_costcd.value==""){ alert("�����ڵ尡 �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}   
	 
	 //������ ���� 
	 if (gcem_sup_com_regno.text=="")     { alert("������ ��Ϲ�ȣ��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_sup_com_name.text=="")      { alert("������ ��ȣ��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_sup_rep_name.text=="")      { alert("������ ������  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_sup_com_addr.text=="")      { alert("������ �ּҰ�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_sup_com_type.text=="")      { alert("������ ���°�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_sup_com_classify.text=="")  { alert("������ ������  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_sup_emp_name.text=="")      { alert("������ ����ڰ�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 //if (gcem_sup_tel_num.text=="")       { alert("������ ����ó��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_sup_email.text=="")         { alert("������ �̸�����  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 
	 //���޹޴��� ���� 
	 if (gcem_byr_com_regno.text=="")     { alert("���޹޴��� ��Ϲ�ȣ��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_byr_com_name.text=="")      { alert("���޹޴��� ��ȣ��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_byr_rep_name.text=="")      { alert("���޹޴��� ������  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_byr_com_addr.text=="")      { alert("���޹޴��� �ּҰ�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_byr_com_type.text=="")      { alert("���޹޴��� ���°�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_byr_com_classify.text=="")  { alert("���޹޴��� ������  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_byr_emp_name.text=="")      { alert("���޹޴��� ����ڰ�  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 //if (gcem_sup_tel_num.text=="")       { alert("������ ����ó��  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_byr_email.text=="")         { alert("������ �̸�����  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 
	 //��� 
	 //���ް���, �ΰ�����, �հ�, �������� 
	 if (gcem_sup_amount.text==""||gcem_sup_amount.text=="0")     { alert("���ް����� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (gcem_total_amount.text==""||gcem_total_amount.text=="0") { alert("�հ����  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }

	 //��������
	 if (gcem_amend_code.text=="") { alert("���������� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 	 
	 //���γ���
	 
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")=="")     {alert("���γ��� ������ �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")==""){alert("���γ��� ǰ���� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")==0)    {alert("���γ��� ���ް����� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false;}
	 
	 
	 //�ʼ��׸�üũ 
	  
	 //Data cross check  
	 
	 //���������� ���� ��¥üũ
	 if(gcem_modify_reason.text=="01") { //��������������� ���ʼ��ݰ�꼭 
		 
	 	if(gcem_ori_dti_wdate.text !=gcem_taxdat.text){
	 		alert("��꼭���ڰ� �����ۼ����� �ƴմϴ�. Ȯ���Ͻʽÿ�.");		
	 		return false;
	 	} 
	 }else if (gcem_modify_reason.text=="06"){ //������ ���� ���߹߱� 
		if(gcem_ori_dti_wdate.text !=gcem_taxdat.text){
			alert("��꼭���ڰ� �����ۼ����� �ƴմϴ�. Ȯ���Ͻʽÿ�.");
			return false;
		}  
	 }else if (gcem_modify_reason.text=="05"||gcem_modify_reason.text=="051"  ){ //�����ſ��� ���İ��� 		 
		if(gcem_ori_dti_wdate.text !=gcem_taxdat.text){
			alert("��꼭���ڰ� �����ۼ����� �ƴմϴ�. Ȯ���Ͻʽÿ�.");
			return false;
		}  
	 }
	 
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
	 }else{ //���� �鼼�� ��� �ΰ����� üũ 
		//0�� �ƴϸ� �ȵ�.
	 	if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")!=0){
	 		alert("�������а� �ΰ������� ���� �ʽ��ϴ�.Ȯ�� �ٶ��ϴ�.");
	 		return false;
	 	}	
	 }
	 
	 //�Աݿ�����
	 if (fn_trim(gcem_duedate.text)=="")   { alert("�Աݿ�������  �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 if (fn_trim(gcem_duedate.text).length!=8) { alert("�Աݿ������� ��Ȯ���� �ʽ��ϴ�. Ȯ���Ͻʽÿ�."); return false; }
	 
	 //�Աݿ����� > ��꼭 ���� 
	 if(gcem_duedate.text<gcem_taxdat.text){
		 alert("�Աݿ������� Ȯ���Ͻʽÿ�");
		 return false;
	 }
	 
	 //��꼭��ȣ
	 if (fn_trim(gcem_taxnbr.text)!="")   { alert("��꼭 ��ȣ��  �����մϴ�. ���� �Ұ��մϴ�."); return false; }
	 
	 return true;
}


/******************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Delete(){

}

/******************************************************************************
Description : Report Head ���� - ���ݰ�꼭 �󼼳���
******************************************************************************/
function ln_Taxmst_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,TAXDIV:STRING,TAXKND:STRING,"
			   + "VEND_CD:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,REMARK:STRING,TAXCDNBR:STRING,"
			   + "ATCODE:STRING,TAXPRTYN:STRING,TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,FSNBR:STRING,"
			   + "TAXKIDIV:STRING,FDCODE:STRING,WORKTYPE:STRING,REPORT:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
			   + "SSDAT:STRING,SSNBR:STRING,SEQ:DECIMAL,CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,"
			   + "GUBUN:STRING,AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,REMARK3:STRING,S_BIZPLACE:STRING,B_BIZPLACE:STRING,COSTCD:STRING,"
			   + "EBILLGB:STRING,DUEDATE:STRING,TAXSTS:STRING,REAL_FILE:STRING,SYS_FILE:STRING,REAL_FILE2:STRING,SYS_FILE2:STRING,ORI_ISSUE_ID:STRING,"
			   + "VEND_NM:STRING,VEND_ID:STRING,VD_DIRECT:STRING,TAXKNDNM:STRING";
	gcds_taxmst.SetDataHeader(s_tmp1);
	
	var s_tmp2 = "ORI_ISSUE_ID:STRING";
	gcds_issueid.SetDataHeader(s_tmp2);
	
}


/******************************************************************************
	Description : Report Head ���� - ���ݰ�꼭 �󼼳���
******************************************************************************/
function ln_Taxdtl_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,TAXQTY:DECIMAL,"
			   + "TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MMDD:STRING";
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
		
	/*
	 gcds_code01.namevalue(row,"SEQ")  + ";" 
	1	+ gcds_code01.namevalue(row,"VEND_CD")  + ";" 
	2  	+ gcds_code01.namevalue(row,"VEND_NM")  + ";" 
	3	+ gcds_code01.namevalue(row,"EMPNM") + ";"
	4	+ gcds_code01.namevalue(row,"DEPTNM") + ";"
	5	+ gcds_code01.namevalue(row,"EMAIL")  + ";"
	6	+ gcds_code01.namevalue(row,"HPNO")  + ";"
	7	+ gcds_code01.namevalue(row,"TELNO")  + ";"
	8	+ gcds_code01.namevalue(row,"USEGB")  + ";"
	9	+ gcds_code01.namevalue(row,"VEND_ID")+ ";"
	10	+ gcds_code01.namevalue(row,"BSNS_CND")  + ";"
	11	+ gcds_code01.namevalue(row,"BSNS_KND")  + ";"
	12	+ gcds_code01.namevalue(row,"ADDRESS1")  + ";"
	13	+ gcds_code01.namevalue(row,"ADDRESS2")  + ";"
	14	+ gcds_code01.namevalue(row,"VD_DIRECT") + ";"
	15	+ gcds_code01.namevalue(row,"ORI_VEND_I");
	*/
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		
		if(arrParam[16]=="10"){
  			gcem_vendid.Format="###-##-#####"; 
  			gcem_byr_com_regno.Format="###-##-#####"; 
  		}else if (arrParam[16]=="13"){
  			gcem_vendid.Format="######-#######"; 		
  			gcem_byr_com_regno.Format="######-#######"; 
  		}
		
		gcem_seq.text      = arrParam[0]; //����  
		gcem_vendcd.text   = arrParam[1]; //�ŷ�ó �ڵ�  
		txt_vendnm.value = arrParam[2]; //�ŷ�ó��
		//gcem_vendid.text   = arrParam[9]; //�ŷ�ó ����� ��Ϲ�ȣ 
		gcem_vendid.text   = arrParam[15]; //�ŷ�ó ����� ��Ϲ�ȣ 
		gcem_empnm.text    = arrParam[3]; //����ڼ���      
		//gcem_deptnm2.text   = arrParam[4]; //�μ���          
		//gcem_hpno2.text     = arrParam[6]; //�ڵ���          
		//gcem_telno2.text    = arrParam[7]; //��ȭ        
		gcem_email.text       = arrParam[5]; //Email    
		gcem_byr_com_regno.text= arrParam[15]; //��Ϲ�ȣ
		
		gcem_byr_com_name.text = arrParam[2]; //��ȣ
		gcem_byr_rep_name.text = arrParam[14]; //����
    	gcem_byr_com_addr.text = arrParam[12]+arrParam[13]; //�ּ�
		gcem_byr_bizplace_code.text = ""; //�������
    	gcem_byr_com_type.text = arrParam[10]; //����
    	gcem_byr_com_classify.text = arrParam[11]; //����
  		gcem_byr_emp_name.text = arrParam[3]; //�����
  		gcem_byr_tel_num.text  = arrParam[7]; //����ó
  		gcem_byr_email.text    = arrParam[5]; //�̸��� 
  		
  		ln_Find_Ori_Auto_Settiong();
	} else {
		gcem_vendcd.text   = ""; //�ŷ�ó �ڵ�  
		txt_vendnm.value = ""; //�ŷ�ó��
		gcem_vendid.text   =""; //�ŷ�ó ����� ��Ϲ�ȣ 
		gcem_empnm.text    = ""; //����ڼ���           
		gcem_email.text    =""; //Email    
		gcem_byr_com_regno.text= ""; //��Ϲ�ȣ
		
		gcem_byr_com_name.text = ""; //��ȣ
		gcem_byr_rep_name.text = ""; //����
    	gcem_byr_com_addr.text = "";//�ּ�
		gcem_byr_bizplace_code.text = ""; //�������
    	gcem_byr_com_type.text = ""; //����
    	gcem_byr_com_classify.text = ""; //����
  		gcem_byr_emp_name.text = ""; //�����
  		gcem_byr_tel_num.text  = ""; //����ó
  		gcem_byr_email.text    = ""; //�̸��� 
	}
}

/******************************************************************************
Description : ���� ���� �ڵ� ����
                            ���������������, ������ ���� ���߹߱޸� �ڵ����� ��. 
******************************************************************************/
function ln_Find_Ori_Auto_Settiong (){
	
	if(gcem_modify_reason.text=="01"){ //������� ����, ���ʼ��ݰ�꼭  ���ʱݾ��� ���� �ݾ� ����
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")= parseFloat(gcem_ori_sup_amount.text)*-1;
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")=parseFloat(gcem_ori_tax_amount.text)*-1;
		ln_Auto_Sum();
	}else if(gcem_modify_reason.text=="06"){ //������ ���� ���߹߱�
		gcem_taxdat.text = gcem_ori_dti_wdate.text;  // �����ۼ�����
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD") = gcem_ori_dti_wdate.text.substring(4,8);  // �����ۼ�����
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")= parseFloat(gcem_ori_sup_amount.text)*-1;
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")=parseFloat(gcem_ori_tax_amount.text)*-1;
		ln_Auto_Sum();
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
Description : ����Ʈ ��� ȣ�� 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){
	
	var v_left = (screen.width-300)/2;
	var v_top  = (screen.height-300)/2;

	//���ݰ�꼭��
	url=gs_url+"/callSB_V3/XXSB_DTI_ARISSUE.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
	window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
    
	ln_Initial();
}


/******************************************************************************
Description : �������ݰ�꼭 �߱޹�� ��ũ 
******************************************************************************/
function ln_Menual(){

	var v_left = (screen.width-800)/2;
	var v_top  = (screen.height-800)/2;
    
	url="http://esero.go.kr.krweb.nefficient.co.kr/esero/data/is/form/�������ڼ��ݰ�꼭%20�߱޹��.pdf";

	window.open(url,"", "status=1, resizable=yes, width=1000, height=780, left="+v_left+", top="+v_top );
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
	
	if(txt_costcd.value==""){
	 arrParam[3]="";
	}else{
	 arrParam[3]=txt_costcd.value;
	}
	
	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		txt_costcd.value =arrResult[0];
		txt_costnm.value = arrResult[1];
	}else{
	    txt_costcd.value="";
		txt_costnm.value="";
	}	
}	


<%
/***********************************************************************************************
Description : �����û
parameter   : 
**********************************************************************************************/
%>
function ln_Request(){
	//��꼭 ��ȣ �ʼ��׸�
	if(!ln_Chk_Status()) return false;
	   
	if (confirm(" �ش� ���������� ���� ��û �Ͻðڽ��ϱ�?")){	
		gctr_data5.KeyValue = "Account.a040120_t1(I:USER=gcds_taxmst)";
		gctr_data5.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_t1";
		gctr_data5.Parameters = "v_str1="+gs_userid;
		
		//prompt('',gcds_taxmst.text);
		gctr_data5.post();
		//ln_Query();
	}else{
		gcds_taxmst.UndoAll();
	}	
}

<%
/******************************************************************************
Description : ���°� üũ 
******************************************************************************/
%>
function ln_Chk_Status(){
	//��꼭 ���� üũ ( ��� �Ǵ� null, �ݼ� ���¸� ����, ��û �Ǵ� ������ �Ұ�  )
	if(fn_trim(gcem_taxnbr.text)==""){
		alert("��꼭 ��ȣ�� �������� �ʽ��ϴ�. Ȯ�� �ٶ��ϴ�.");
		return false;
	}
	
	if(gclx_taxsts.bindcolval=="R"||gclx_taxsts.bindcolval=="Y"){
		alert("�ش� ���°��� �����û�� �Ұ��մϴ�.");
		return false;
	}
	
	f = document.fileForm;
	
	// alert(".options[0].text::::"+document.fileForm.fileList.options[0].text+"::");
	// alert(".options[0].value::::"+document.fileForm.fileList.options[0].value+"::");
	/*  
	if(f.fileList.options.selectedindex==-1){
		 alert("���");
		 return false;
	}else{
		if(f.fileList.options.length==1){
			alert("÷�������� 1���Դϴ�. Ȯ�� �ٶ��ϴ�.");
			return false;
		}
	} 
	*/
	    
	if(f.fileList.options[0].text==""||f.fileList.options[0].text==undefined){
		alert("������ ÷�� ���� �ʾҽ��ϴ�.");
		return false;
	}
	
	if(f.fileList.options[0].value==""||f.fileList.options[0].value==undefined){
		alert("������ ÷�� ���� �ʾҽ��ϴ�.");
		return false;
	}
	
	//alert("f.fileList.options[1].value::"+f.fileList.options[1].value);
	if(f.fileList.options[1].text==""||f.fileList.options[1].text==undefined){
		alert("������ ÷�� ���� �ʾҽ��ϴ�2.");
		return false;
	}
	
	if(f.fileList.options[1].value==""||f.fileList.options[1].value==undefined){
		alert("������ ÷�� ���� �ʾҽ��ϴ�2.");
		return false;
	}
	
	if(gcds_taxmst.namevalue(1,"TAXSTS")!="N"&&gcds_taxmst.namevalue(1,"TAXSTS")!="B"){
		alert(gcds_taxmst.namevalue(1,"VEND_NM")+"�� �����û ����  �ƴմϴ�.");
		return false;
	}else{
		gcds_taxmst.namevalue(1,"TAXSTS")="R"; 
		gclx_taxsts.bindcolval="R"; 
	}
	
	return true;
}

<%
//���� ÷��
%>
function fnFileUpload(){
	
	//�ŷ�ó �ڵ尡 �����ؾ߸� ���ε� ����.
  //alert("VEND_CD::"+gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD"));
	
	/*
	if(gcds_taxmst.namevalue(gcds_taxmst.rowpostion,"TAXNBR")==""||gcds_taxmst.namevalue(gcds_data.rowpostion,"TAXNBR")==undefined){
		alert("���ݰ�꼭 ��ȣ�� �����ؾ�  ���ε� �����մϴ�.");
	}
	*/
	
	//�����û�� ��� ���� ÷�� �Ұ�.
	if(gclx_taxsts.bindcolval=="R"||gclx_taxsts.bindcolval=="Y"){
		alert("�ش� ������°��� ����÷�� �Ұ��մϴ�.");
		return false;
	}
	
	//������ ������ ÷�� �Ǿ��� ���.....���� �� �ٽ� ÷�� �ؾ���.......
	//������ ���ϸ��� �����մϴ�.
	//���°� ��� �� �ݼ۸� �����մ�.
	//if(!ln_Chk_Status("����÷��")) return false;
	f = document.fileForm;
	
	if(f.filename1.value!=""){
		file_position ="1";
	}else if(f.filename2.value!=""){
		file_position ="2";
	}
	
	gs_position = file_position; 
	

	if(f.filename2.value==""){
		alert("������ο�û�� ÷���� ������ �����Ͻʽÿ�2.");
		return false;
	}
	
	if(f.filename1.value==""){
		alert("����ڵ�Ϲ�ȣ ÷���� ������ �����Ͻʽÿ�1.");	
		return false;
	}
		
	var realFileName = f.filename1.value;
	var idx = realFileName.lastIndexOf("\\");
	realFileName = realFileName.substring(idx+1);
	
	
	if(f.filename2.value.substring(f.filename2.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
		alert("������ο�û���� PDF���ϸ� ÷�� �����մϴ�. ");
		return false;
	}
	
	if(f.filename1.value.substring(f.filename1.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
		alert("����ڵ�Ϲ�ȣ�� PDF���ϸ� ÷�� �����մϴ�. ");
		return false;
	}
	
	//���� Ȯ���� üũ 
	/*
	if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
		alert("���۱� ������ ������ �ִ� mp3, wma, asf ������ �������� ÷�δ� ���� �ʽ��ϴ�.");
		return;
	}
	*/
	
	
  /*
	if(realFileName.toUpperCase().indexOf(".PDF") <0 ){
		alert(" PDF ���ϸ� ÷�� �����մϴ�. ");
		return false;
	}
	*/
	
	
	f.target="tempUpload";	               //���ε� ���� Ÿ���� iFrame !
	f.realFileName.value=realFileName;   
	f.mode.value="insert";
	
	f.action = "./a040120_fileUpload.jsp";  //�������� ���� ���ε�
	f.submit();
	
}

<%
//���� �߰� ����Ʈ  --> a010050_fileUpload���� ȣ�� 
//�������ε� �� ���ϸ��� ������ ��. 
%>
function addFileList(realName, virtualName, intTot, strfilename){
	
	f = document.fileForm;
	intTot = intTot - 1;

	if(realName!=""){
		f.fileList.options[intTot] = new Option(realName,virtualName);
	}
	
	//���ϸ� �������� ó��...
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")=realName;
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")=virtualName;
	
	if(strfilename=="filename2"){ //������ο�û��
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE2")=realName;
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE2")=virtualName;
	}else if(strfilename=="filename1"){ //��Ϲ�ȣ 
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")=realName;
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")=virtualName;
	}
	
	if (gs_position==strfilename.substring(8,9)){
		gctr_data5.KeyValue = "Account.a040120_t2(I:USER=gcds_taxmst)";
		gctr_data5.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_t2";
		gctr_data5.Parameters = "v_str1="+gs_userid;
		//prompt('fileupload::',gcds_taxmst.text);
		gctr_data5.post();
	}
	
	//f.file1.value ="÷���������ִ�10M���������մϴ�." ;  //f.file1.title;
}

<%
//��ȸ �� �׸��� Ŭ���ý� ÷�������� �����ϸ� ÷��list�� �־��.
%>
function fnFileList(row){
	var strReal_file="";
	var strSys_file ="";
	var ip =0;
	
	for(var i=2;i>=1; i--){
		if(i==1){        //��Ϲ�ȣ
			strReal_file = gcds_taxmst.namevalue(row,"REAL_FILE");
			strSys_file  = gcds_taxmst.namevalue(row,"SYS_FILE");
			//alert("strReal_file::"+strReal_file+"::strSys_file::"+strSys_file);
			if(strReal_file!=""){
				document.fileForm.fileList.options[ip] = new Option(strReal_file,strSys_file);
				ip=ip+1;
			}
			
		}else if(i==2){ //
			strReal_file = gcds_taxmst.namevalue(row,"REAL_FILE2");
			strSys_file  = gcds_taxmst.namevalue(row,"SYS_FILE2");
			
			//alert("strReal_file::"+strReal_file+"::strSys_file::"+strSys_file);
			if(strReal_file!=""){
				document.fileForm.fileList.options[ip] = new Option(strReal_file,strSys_file);
				ip=ip+1;
			}
		}
	}
}

<%
//���ϻ���
//���ϸ�Ͽ��� ���� 
%>
function fnFileDelete(){
	f = document.fileForm;
		
	//�����û�� ��� ���� ÷�� �Ұ�.
	if(gclx_taxsts.bindcolval=="R"||gclx_taxsts.bindcolval=="Y"){
		alert("�ش� ������°��� ���ϻ��� �Ұ��մϴ�.");
		return false;
	}
	
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
		alert('������ ������ ������ �ֽʽÿ�');
		f.fileList.focus();
		return;
	}	

	if(confirm('������ ���� �Ͻðڽ��ϱ�?')){
		var i = f.fileList.options.selectedIndex;
		var select_val  = f.fileList.options[i].value;
		var select_text = f.fileList.options[i].text;
		
		//����ã���ؼ� �����Ǹ� ���־� ��...
		//var realFileName = f.file1.value;
	    //var fileArray = oldFileNames.split(":");

		//alert(select_val);
		//alert(oldFileNames);

		//******** START ������ �ִ� �������� ���� ***********/
		var isNew = "i_del"; // �̰� �ݹ� �ø� ������ ���... insert_file
		//******** END  ������ �ִ� �������� ���� ***********/ 
		
		document.file_del.target="tempUpload";
		//document.file_del.realFileName.value=realFileName;
		document.file_del.realFileName.value=select_text;
		document.file_del.virtualFileName.value = select_val;
		//document.file_del.saveDir.value = "memGalleryUpload";
		document.file_del.mode.value=isNew;
		document.file_del.action = "./a040120_deleteFile.jsp";	//����� ����
		document.file_del.submit();
	}
}

<%
//���Ͼ��ε� 4
//������ �������� ���� �� ����Ʈ���� ����
%>
function delResult(realName, virtualName){
	
	//alert("delResult:realName:"+realName+"virtualName"+virtualName);
	
	f = document.fileForm;
	idx = f.fileList.selectedIndex;
	cnt = f.fileList.options.length;
	//f.fileList.options[0] = new Option(f.fileList.options[0].text,f.fileList.options[0].value);
	
	for(i=idx;i< f.fileList.options.length-1;i++){
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	
	f.fileList.options[cnt - 1] = null;
	
	//f.file1.value = "÷���������ִ�5M���������մϴ�.";
	//alert("gcds_data.rowposition::"+gcds_data.rowposition+"::del::realName"+realName+":virtualName:"+virtualName);
	/*
	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")==virtualName){
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")="";
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")="";
	}
	*/
	
	for(var j=2;j>=1; j--){
		if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE2")==virtualName){
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE2")="";
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE2")="";
		}else if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")==virtualName){
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")="";
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")="";
		}
	}
	
	//������Ʈ �Ŀ� DB���� ������Ʈ �ؾ���.
	gctr_data5.KeyValue = "Account.a040120_t3(I:USER=gcds_taxmst)";
	gctr_data5.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_t3";
	gctr_data5.Parameters = "v_str1="+gs_userid;
	//prompt('',gcds_taxmst.text);
	gctr_data5.post();
	
	//ln_Query();
}

<%
//���� ���ݰ�꼭 �߻� ���� ��û��
%>
function ln_Print(){
  
	//��꼭 ��ȣ üũ 
	if(gcem_taxnbr.text==""){
		alert("��꼭��ȣ�� �������� �ʽ��ϴ�.");
		//return false;
	}
	
	fnReportSetDataHeader();
	gcds_rptmst.addrow();
	gcds_rptmst.namevalue(gcds_rptmst.rowposition,"APP_TEAMNM")= gdeptnm;
	gcrp_print.preview();
}

function fnReportSetDataHeader() {
	 var s_temp = "APP_TEAMNM:STRING";
	 gcds_rptmst.SetDataHeader(s_temp);
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
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxdtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_issueid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_sup_vend classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_rptmst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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

<object  id=gctr_data5 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gclx_fdcode.bindcolval=gs_fdcode;
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
 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	 //alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	
	 //alert("BATCH_ID::"+gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"));
	 //alert("ID::"+gcds_return.namevalue(gcds_return.rowposition,"ID"));
	 //alert("PASS::"+gcds_return.namevalue(gcds_return.rowposition,"PASS"));
	 /*	
	 ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	           gcds_return.namevalue(gcds_return.rowposition,"ID"),
			   gcds_return.namevalue(gcds_return.rowposition,"PASS"));
	 */
	 gcem_taxnbr.text = gcds_return.namevalue(gcds_return.rowposition,"TAXNBR"); //������ ����.
	 gcds_taxmst.namevalue(1,"TAXNBR")=gcem_taxnbr.text; 
	 alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data5 event=OnSuccess()>
	 alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");

</script>

<script language=JavaScript for=gctr_data5 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data5.ErrorCode + "\n" + "Error Message : " + gctr_data5.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>


<!-- ���� ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px" colspan=2><td></tr>
	<tr>
		<td align=left style="position:relative;left:6px;top:-2px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1024px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:90px;" bgcolor="#eeeeee"><nobr>���ʽ��ι�ȣ</nobr></td>
					<td class="tab23" style="width:200px">
						<comment id="__NSID__">
						<object id=gcem_ori_issue_id  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px;width:150px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="########################">
							<param name=PromptChar	  value="_">
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../../Common/img/btn/com_b_find.gif"		style="cursor:hand;position:relative;top:2px;left:6px;"	onclick="ln_ori_issue_id_find()">
					</td>
					<td class="tab23" style="width:550px"> <nobr> 
						<comment id="__NSID__">
						 <object id=gcem_ori_byr_com_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:1px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="###-##-#####">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							
							<object id=gcem_ori_dti_wdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:1px;width:80px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="####-##-##">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;

							<object  id=gcem_ori_sup_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly        value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							
							<object  id=gcem_ori_tax_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly        value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							<object  id=gcem_ori_total_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly        value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							<object  id=gcem_ori_dti_type_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		   value="">
								<param name=Alignment      value=0>
								<param name=Border         value=false>
								<param name=GeneralEdit    value=true>
								<param name=Language	   value=1>
								<param name=ReadOnly       value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr> 
					</td>
					<td align="right">&nbsp;<nobr> 
					    <img src="../../Common/img/btn/com_b_appreq.gif"  style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Request()">&nbsp;     
					    <img src="../../Common/img/btn/com_b_insert.gif"       style="cursor:hand;position:relative;top:0px;right:2px" onClick="ln_Initial()">
					    <img src="../../Common/img/btn/com_b_save.gif"		   style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Save()">
						<!--<img src="../../Common/img/btn/com_b_sale.gif"    style="cursor:hand;position:relative;top:1px;right:2px" onClick="ln_Save()">--> 
						</nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><!-- �������� ----------------------------------------------------------------------------------------->
		<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1024px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:88px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td ><comment id="__NSID__">
						<object id=gcem_modify_reason classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Language		value=1>
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../../Common/img/btn/com_b_find.gif"		style="cursor:hand;position:relative;top:2px;left:6px;"	onclick="ln_modify_reason_find()">
					    <comment id="__NSID__">
						<object id=gcem_modify_reason_nm1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:200px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Language		value=1>
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=ReadOnlyForeColor   value="red">
						</object>
						<object id=gcem_modify_reason_nm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:200px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Language		value=1>
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=ReadOnlyForeColor   value="red">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;
						
						<img src="../../Common/img/btn/com_b_taxm.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Menual()"> 
					</td>
					<td class="tab41" width="70px" bgcolor="#eeeeee"><nobr>�������</nobr></td>
					<td><nobr>
						<comment id="__NSID__">
							<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="N^���,R^��û,Y^����,B^�ݼ�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					    </nobr>
					</td>
					<td align="right">&nbsp;<nobr> 
					    <img src="../../Common/img/btn/com_b_print.gif"	     style="cursor:hand;position:relative;top:0px;right:2px" onClick="ln_Print()">
						</nobr>
					</td>
					
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td height="25px" colspan=2>
			<b><font size="2" color="blue">&nbsp;�� ��������(ERP)</font></b>
		<td>
	</tr>
	<tr><!-- ERP����----------------------------------------------------------------------------------------->
	    <!-- ����, �����, �������, ȸ�豸��(���� : �����Է�), �ͼӱ���, ��������, �ŷ�ó , ����ڹ�ȣ, �ŷ�ó ����� ����, �ŷ�ó �����  EMAIL 
	                  ���ڹ��౸��, ����, ����������, �ۼ��� �μ�, �ۼ��� ���, �ܺνý��� �������üũ
	         �Աݿ�����, file÷��, �������
	     -->
		<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1024px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��꼭��ȣ</nobr></td>
					<td class="tab22" colspan=7>
						<comment id="__NSID__">
						<object id=gcem_taxnbr  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="#000000-0000">
							<param name=PromptChar	  value="_">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object>
					</comment><script>__ws__(__NSID__);</script>
					</td>
						
				</tr>
			
				<tr>
					<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab21" >
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
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��&nbsp;��&nbsp;��</nobr></td>
					<td class="tab22" width="250px">
					    <comment id="__NSID__"> 
							<object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:60px;height:200px;">
								<param name=CBData				value="02^����,01^��,04^ȫ��">
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
					<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>�ͼӱ���</nobr></td>
					<td class="tab19" width="149px;">
						<comment id="__NSID__">
							<object  id=gclx_taxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:0px;font-size:12px;width:140px;height:200px;">
								<param name=ComboDataID			value="gcds_taxdiv">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^130">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��������</nobr></td><!-- =�ΰ������� -->
					<td class="tab22" width="189px">
						<comment id="__NSID__">
							<object  id=gclx_taxknd  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:90px;height:150px;">
								<param name=ComboDataID			value="gcds_taxknd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat		value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>	
				</tr>
				
				<tr>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��&nbsp;��&nbsp;ó</nobr></td>
					<td class="tab22" width="924px;" colspan="7"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	value="_">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Vend_Popup()">
						<input id=txt_vendnm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:255px;" readOnly>
						<comment id="__NSID__">
							<object  id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:115px;">
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
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>�ŷ�ó�������</nobr></td>
					<td class="tab21" width="189px" ><nobr>
						<comment id="__NSID__">
						  <!-- ����ڸ� -->
							<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>�ŷ�ó Email</nobr></td><!--=�ŷ�ó Email-->
					<td class="tab22"  colspan=5  >
						<comment id="__NSID__">
							<object  id=gcem_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:273px;height:20px;position:relative;left:5px;top:0px">		
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
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab21"  width="500px" colspan="5"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_erp_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:500px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��꼭����</nobr></td>
					<td class="tab22"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_taxdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment	  value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable		  value="true">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_GetCallCalendar('gcem_taxdat2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">-->
					    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1  OnClick="ln_GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">
					    </nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" width="500px" colspan="5">
						<nobr>
						<input id="txt_costcd" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6"  readOnly=true>	
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Costcd_Popup();">				
						<input id="txt_costnm" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >			
						&nbsp; <font color="blue" >* ���� ������� [�ǸŰ����� ��]���� �Է��ϼ���.</font>
						</nobr>
					</td>
					<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>�Աݿ�����</nobr></td>
					<td ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_duedate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment	  value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable		  value="true">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_GetCallCalendar('gcem_taxdat2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">-->
					    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1  OnClick="__GetCallCalendar('gcem_duedate', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">
					    </nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td height="25px" colspan=2 >
			<b><font size="2" color="blue">&nbsp;�� ������ / ���޹޴��� ���� </font></b>
		<td>
	</tr>
	
	<!--������ : ���޹޴��� ����----------------------------------------------------------------------------------------->
	<!--������ : ��Ϲ�ȣ, ��ȣ, ��ǥ��, ������ּ�, �������,   ����, ����, �����, ����ó, ����� �̸���,  
          ���޹޴��� : ��Ϲ�ȣ, ��ȣ, ��ǥ��, ������ּ�, (�������), ����, ����, �����, ����ó, ����� �̸���,	
 	           ���� : ��������(����, ���� ) 
 	-->
 	
	<tr>
		<td style="position:relative;left:6px"  >
			<table cellpadding="1" cellspacing="0"  style='width:511px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab13" width="510px" bgcolor="#eeeeee" colspan=4><nobr>������</nobr></td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>��Ϲ�ȣ</nobr></td>
					<td class="tab22" width="430px" align="center" colspan=3><nobr>
						   <object id=gcem_sup_com_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:300px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="###-##-#####">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>��ȣ</nobr></td>
					<td class="tab21" width="175px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_com_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:160px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab22" width="175px"> 
						<comment id="__NSID__">
							<object  id=gcem_sup_rep_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>������ּ�</nobr></td>
					<td class="tab21" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_com_addr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>��������ȣ</nobr></td>
					<td class="tab22" > 
						<comment id="__NSID__">
							<object  id=gcem_sup_bizplace_code classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_com_type classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:160px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_sup_com_classify classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:160px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>�����</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_emp_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����ó</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_sup_tel_num classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" width="80px" bgcolor="#eeeeee"><nobr>�̸���</nobr></td>
					<td colspan=3><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:300px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
			</table>
		</td>
		
		<td style="position:relative;left:6px" >
			<table cellpadding="1" cellspacing="0"  style='width:512px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab13" width="510px" bgcolor="#eeeeee" colspan=4><nobr>���޹޴���</nobr></td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>��Ϲ�ȣ</nobr></td>
					<td class="tab22" width="430px" align="center" colspan=3><nobr>
						     <object id=gcem_byr_com_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:300px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="###-##-#####">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>��ȣ</nobr></td>
					<td class="tab21" width="175px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_com_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab22" width="175px"> 
						<comment id="__NSID__">
							<object  id=gcem_byr_rep_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>������ּ�</nobr></td>
					<td class="tab21" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_com_addr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>��������ȣ</nobr></td>
					<td class="tab22" > 
						<comment id="__NSID__">
							<object  id=gcem_byr_bizplace_code classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_com_type classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F     style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_byr_com_classify classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>�����</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_emp_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>����ó</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_byr_tel_num classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" width="80px" bgcolor="#eeeeee"><nobr>�̸���</nobr></td>
					<td colspan=3><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td style="position:relative;left:6px" colspan=2 >
			<table cellpadding="1" cellspacing="0"  style='width:1024px;height:30px;border:0 solid #708090'>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>���1</nobr></td>
					<td class="tab21" colspan=7><nobr>
						<comment id="__NSID__">
							<object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:900px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>���2</nobr></td>
					<td class="tab21" colspan=7><nobr>
						<comment id="__NSID__">
							<object  id=gcem_remark2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:900px;height:20px;position:relative;left:5px;top:1px">		
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
				</tr>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>���3</nobr></td>
					<td class="tab21" colspan=7><nobr>
						<comment id="__NSID__">
							<object  id=gcem_remark3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:900px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		 value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>���ް���</nobr></td>
					<td class="tab22" width="165px" align=right><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="79px" bgcolor="#eeeeee"><nobr>�ΰ�����</nobr></td>
					<td class="tab22" width="165px" align=right ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_tax_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="79px" bgcolor="#eeeeee"><nobr>�հ�</nobr></td>
					<td class="tab22" width="165px" align=right><nobr>
						<comment id="__NSID__">
							<object  id=gcem_total_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="79px" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" width="177px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_amend_code classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:20px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=Visible       value="true">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
 							</object>&nbsp;
							<object  id=gcem_amend_codenm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:145px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
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
	<!--����(��/��), ǰ��, �԰�, ����, �ܰ�, ���ް���, ����, �հ�, ����, ��ǥ, ����, �ܻ���Ա�, ����, û��   -->
	<tr>
		<td height="25px" colspan=2 >
			<b><font size="2" color="blue">&nbsp;�� ���γ��� </font></b>
		<td>
	</tr>
    <tr>
		<td style="cursor:hand;position:relative;left:6px;" width="845px" colspan=2><nobr>
		 	<comment id="__NSID__">
		  		<object id=gcgd_taxdtl classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width='1022px' height='41px' border='1'>
					<param name="dataid"		 value="gcds_taxdtl">
					<param name="borderstyle"    value="0">
					<param name="indwidth"       value="0">
					<param name="fillarea"		 value="true">
					<param name="colsizing"      value="true">
					<param name="editable"       value="true">
					<param name="format"		 value="  
					<C>  Name='����'			ID=MMDD                Width=80 	align=center   bgcolor=#CCFFCC  mask='XX/XX' edit=none </C>
					<C>  Name='ǰ��'         ID=TAXPDTNAM           Width=360 	align=left     bgcolor=yellow </C>			
					<C>  Name='�԰�'         ID=TAXSTD          	   Width=150	align=left     bgcolor=yellow </C>			  					
					<C>  Name='����'		    ID=TAXQTY          	   Width=50 	align=right    bgcolor=yellow </C>
					<C>  Name='�ܰ�'         ID=TAXPRIC             Width=120	align=right	   bgcolor=yellow </C>					
					<C>  Name='���ް���'      ID=TAXSUM              Width=120  	align=right	   bgcolor=yellow </C>					
					<C>  Name='�ΰ�����'      ID=TAXVATAMT           Width=120	align=right	   bgcolor=yellow </C>					
				  	 ">
				</object>
			</comment><script>__ws__(__NSID__);</script></nobr>
		<td>			   
     </tr>	
     
      <tr>
		<td  height="25px" colspan =2>
			<b><font size="2" color="blue">&nbsp;�� ����÷�� </font></b>
		</td>
	 </tr> 
	 
	<form name="fileForm" method="post" enctype="multipart/form-data" align="absmiddle"  >
	    <input type="hidden" name="realFileName">
		<input type="hidden" name="virtualFileName">
		<input type="hidden" name="mode"> 
		<input type="hidden" name="file_position"> 	     
	 <tr>
     	<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1022px;height:30px;border:1 solid #708090'>	
			     <tr>
			    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>������ο�û��</nobr> </td>
					<td class="tab22">
						<input type="file"  name="filename2"   style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
					</td>	
			     </tr>
			     <tr>
			    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>����ڵ�Ϲ�ȣ</nobr> </td>
					<td class="tab22">
						<input type="file"  name="filename1"   style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
					</td>	
			     </tr>
			     <tr>
			    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>÷������</nobr> </td>
					<td class="tab22" >
						<select multiple name="fileList" id="fileList" style="position:relative;left:4px;top:2px; width:450px;height:55px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
							 <option></option>
						</select>
						<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload()">
					    <img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">
					</td>    
			    </tr>
		     </table>
		 </td>
     </tr>
     
     </form>
     
      <!-- ���� ������ ��-->
	<form METHOD=POST NAME="file_del">
	<input type="hidden" name="realFileName">
	<input type="hidden" name="virtualFileName">
	<input type="hidden" name="saveDir">
	<input type="hidden" name="mode">
	</form> 
    
    <!-- ���� �ӽ� ���ε�� iFrame -->
	<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>
    
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [DATA2]
------------------------------------------------------------------------------>
<comment id="__NSID__">
    <object  id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_taxmst">
	<PARAM NAME="ActiveBind"	VALUE="true">
	<PARAM NAME="BindInfo"		VALUE="
	<C>Col=TAXNBR     		Ctrl=gcem_taxnbr    		Param=text </C>
	">
	</object>

</comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - �� �� �� �� �� �� ��
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="MasterDataID"		        value="gcds_rptmst">
	<param name="DetailDataID"		        value="gcds_taxmst">	
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="true">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
	<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=376 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=1897 ,top=95 ,right=2831 ,bottom=373 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='��  ��' ,left=1902 ,top=98 ,right=2127 ,bottom=151 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=2135 ,top=98 ,right=2360 ,bottom=151 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ  ��' ,left=2368 ,top=98 ,right=2593 ,bottom=151 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=2601 ,top=98 ,right=2826 ,bottom=151 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1897 ,top=153 ,right=2826 ,bottom=153 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1897 ,top=302 ,right=2826 ,bottom=302 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2006 ,top=310 ,right=1982 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2707 ,top=307 ,right=2683 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2482 ,top=310 ,right=2458 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2246 ,top=307 ,right=2223 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2365 ,top=95 ,right=2365 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2130 ,top=93 ,right=2130 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2596 ,top=93 ,right=2596 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���� ���ݰ�꼭 �߻� ���� ��û��' ,left=151 ,top=201 ,right=1884 ,bottom=325 ,face='HY�߰��' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=312 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='APP_TEAMNM', left=164, top=95, right=574, bottom=156, align='left', face='����', size=14, bold=false, underline=true, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=164 ,top=198 ,right=164 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=706 ,top=198 ,right=706 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1752 ,top=198 ,right=1752 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=198 ,right=2828 ,bottom=198 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=312 ,right=2828 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1976 ,top=198 ,right=1976 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2662 ,top=198 ,right=2662 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=198 ,right=2831 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=947 ,top=198 ,right=947 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�ۼ�����' ,left=1098 ,top=204 ,right=1259 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����(ǰ��)' ,left=1982 ,top=204 ,right=2659 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Աݿ�����' ,left=2667 ,top=204 ,right=2828 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�հ��' ,left=1757 ,top=204 ,right=1974 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1558 ,top=198 ,right=1558 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1336 ,top=198 ,right=1336 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1270 ,top=257 ,right=1334 ,bottom=299 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1270 ,top=214 ,right=1334 ,bottom=259 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1265 ,top=198 ,right=1265 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��ǥ��' ,left=953 ,top=204 ,right=1085 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڵ�Ϲ�ȣ' ,left=714 ,top=204 ,right=942 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ü��' ,left=169 ,top=204 ,right=701 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1090 ,top=198 ,right=1090 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���ް���' ,left=1341 ,top=204 ,right=1553 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1564 ,top=204 ,right=1749 ,bottom=307 ,face='HY�߰��' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=194 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=164 ,top=85 ,right=2828 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=0 ,right=164 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=0 ,right=2831 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VEND_NM', left=169, top=3, right=701, bottom=79, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=706 ,top=0 ,right=706 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=947 ,top=0 ,right=947 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VEND_ID', left=714, top=3, right=942, bottom=79, mask='XXXXXX-XXXXXXX',face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VD_DIRECT', left=953, top=3, right=1085, bottom=79, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1090 ,top=0 ,right=1090 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXDAT', left=1098, top=3, right=1259, bottom=79 ,mask='XXXX.XX.XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1265 ,top=0 ,right=1265 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXKNDNM', left=1270, top=3, right=1334, bottom=79, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1336 ,top=0 ,right=1336 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXSUM', left=1341, top=3, right=1553, bottom=79, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1558 ,top=0 ,right=1558 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXVATAMT', left=1564, top=3, right=1749, bottom=79, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1752 ,top=0 ,right=1752 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXTOT', left=1757, top=3, right=1974, bottom=79, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1976 ,top=0 ,right=1976 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DUEDATE', left=2667, top=3, right=2828, bottom=79 ,mask='XXXX.XX.XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2662 ,top=0 ,right=2662 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=1982, top=3, right=2659, bottom=79, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
	
">
</object></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
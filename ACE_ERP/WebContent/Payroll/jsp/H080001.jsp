<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�����/�ѱ��α⺻����
+ ���α׷� ID	: H080001.HTML
+ �� �� �� ��	: ��ȸ|����|���|����|���|����
+ �� �� �� ��	: ������ ( �������)
+ �� �� �� ��	: h080001_s0, h080001_s1, h080001_s2, h080001_s3,	h080001_s4, 
								h080001_s5, h080001_s6, h080001_s7, h080001_s8,	h080001_s9, 
								h080001_t1, h080001_t2, h080001_t3, h080001_t4, h080001_t5, 
								h080001_t6
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�ѱ��α⺻����</title>


<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>


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
var gs_level;
var gs_treecd;
get_cookdata();


gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_cdate = gcurdate.substring(0,4) + "/" + gcurdate.substring(5,7) + "/"+ gcurdate.substring(8,10);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	gclx_srh1.index = 0;
	gclx_srh2.index = 0;

	gcra_labuniyn.codevalue = '2';	//��������
	gcra_hitchyn.codevalue = 'N';		//��ֱ���
	gcra_gldiv.codevalue = '2';			//����/���
	gcra_gygb.codevalue = 'N';		//��౸��

	ln_Before();

}

/******************************************************************************
	Description : ����ȸ ����
******************************************************************************/
function ln_Before(){

	//��������
	gcds_srh1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1121";
	gcds_srh1.Reset();

	//�Ҽ��ڵ� ��ȸ����
	gcds_srh2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_srh2.Reset();
	
		//�Ҽ��ڵ� ��ȸ����
	gcds_srh3.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s3?v_str1=";
	gcds_srh3.Reset();
	

	//�Ҽ��ڵ�
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_dept.Reset();

	//�Ҽ�-�� ��ȸ
	gcds_deptlevel.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_deptlevel.Reset();

	//�����ڵ�
	gcds_deptlvl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_deptlvl.Reset();

	//�����ڵ�
	gcds_grddiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001";
	gcds_grddiv.Reset();

	//��å�ڵ�
	gcds_jobgrph.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2038";
	gcds_jobgrph.Reset();

	//�з��ڵ�
	gcds_edccd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1115";
	gcds_edccd.Reset();

	//�Ի��ڵ�
	gcds_empdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1119";
	gcds_empdiv.Reset();

	gcds_empdiv2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1119";
	gcds_empdiv2.Reset();

	//�����ڵ�
	gcds_rilign.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1117";
	gcds_rilign.Reset();

	//�����ڵ�
	gcds_paybnkcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1411";
	gcds_paybnkcd.Reset();

	//ȣ�ְ����ڵ�
	gcds_hdfamret.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	gcds_hdfamret.Reset();

	//�系���� �����ڵ�
	//gcds_relatgrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	//gcds_relatgrd.Reset();

	//��õ�� �����ڵ�
	//gcds_nomingrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	//gcds_nomingrd.Reset();

	//�系���� �����ڵ�
	//gcds_relatre.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	//gcds_relatre.Reset();

	//��õ�� �����ڵ�
	//gcds_nominre.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	//gcds_nominre.Reset();

	//���ƴ�����ڵ�
	gcds_mrtdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1135";
	gcds_mrtdiv.Reset();

	//ä�뱸��
	gcds_recdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2035";
	gcds_recdiv.Reset();

	//����
	gcds_jobkind.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2037";
	gcds_jobkind.Reset();

}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){
	photo.src="photo/00000.gif";
	gcte_disp.ActiveIndex = 1;
	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s1?"
									 + "v_str1=" + gclx_srh1.BindColVal
									 + "&v_str2=" + gclx_srh2.BindColVal
									 + "&v_str3=" + txt_empnm.value
									 + "&v_str4=" + gs_date
									 + "&v_str5=" + gs_level
									 + "&v_str6=" + gs_treecd
									 + "&v_str7=" + gclx_empdiv2.BindColVal
									 + "&v_str8=" + txt_empno1.value;
	gcds_data00.Reset();

}

/******************************************************************************
	Description : ����������ȸ
******************************************************************************/
function ln_FamQuery() {
	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s2?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data02.Reset();
}

/******************************************************************************
	Description : ��»�����ȸ
******************************************************************************/
function ln_CarQuery() {

	gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s3?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data03.Reset();
}

/******************************************************************************
	Description : �ڰ���������ȸ
******************************************************************************/
function ln_LicQuery() {

	if (gcds_lcstype.countrow<1) {
		//�ڰ�������
		gcds_lcstype.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1127";
		gcds_lcstype.Reset();

		//�ڰ������
		gcds_lcscd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1128";
		gcds_lcscd.Reset();
	}

	gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s4?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data04.Reset();
}

/******************************************************************************
	Description : �з»�����ȸ
******************************************************************************/
function ln_EduQuery() {

	if (gcds_hieduc.countrow<1) {
		//�з�
		gcds_hieduc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1115";
		gcds_hieduc.Reset();

		//����
		gcds_pieduc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1129";
		gcds_pieduc.Reset();

		//��������
		gcds_gieduc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1118";
		gcds_gieduc.Reset();
	}

	gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s5?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data05.Reset();

}

/******************************************************************************
	Description : ����+��ü
******************************************************************************/
function ln_AssQuery() {

	if (gcds_assret.countrow<1) {
		//�����ڵ�
		gcds_assret.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
		gcds_assret.Reset();

		//��ֱ���
		//gcds_disdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1135";
		//gcds_disdiv.Reset();

		//��ֵ��
		gcds_disgrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1146";
		gcds_disgrd.Reset();

		//����
		gcds_colblnyn.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2022";
		gcds_colblnyn.Reset();
	}

	gcds_data06.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s6?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno")
									 + "&v_str2=A";
	gcds_data06.Reset();

	if (gcds_milidiv.countrow<1) {
		//��������
		gcds_milidiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1168";
		gcds_milidiv.Reset();

		//����
		gcds_miliknd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1116";
		gcds_miliknd.Reset();

		//���
		gcds_miligrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1134";
		gcds_miligrd.Reset();

		//����
		gcds_milispec.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1116";
		gcds_milispec.Reset();

		//����
		gcds_militype.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1133";
		gcds_militype.Reset();

		//���뱸��
		gcds_militgbn.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2021";
		gcds_militgbn.Reset();
		
	}

	//��������
	gcds_data052.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s6?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno")
									 + "&v_str2=B";
	gcds_data052.Reset();

}

/******************************************************************************
	Description : ���л�����ȸ
******************************************************************************/
function ln_EngQuery() {
	//�������
	gcds_englvl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1149";
	gcds_englvl.Reset();
}

/******************************************************************************
	Description : �系��� ��ȸ
******************************************************************************/
function ln_OrdQuery() {

	if (gcds_ordcd.countrow<1) {
		//�߷ɱ���
		gcds_ordcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>ordcode_s1";
		gcds_ordcd.Reset();

		//ȣ��
		gcds_payseq.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1184";
		gcds_payseq.Reset();
	}

	gcds_data07.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s7?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data07.Reset();
}

/******************************************************************************
	Description : �������
******************************************************************************/
function ln_DeuQuery() {

	if(!ln_Chk_Save())return;
	gcds_data09.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s8?"
										 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data09.Reset();
}

/******************************************************************************
	Description : ��������
******************************************************************************/
function ln_ReqQuery() {
	gcds_data10.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s9?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data10.Reset();

	ln_EngQuery();	//[����/����]
}

/******************************************************************************
	Description : �������
******************************************************************************/
function ln_RewQuery() {
	if (gcds_rewgbn.countrow<1){
		//�������
		gcds_rewgbn.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2030";
		gcds_rewgbn.Reset();

		//�������
		gcds_rewkin.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2031";
		gcds_rewkin.Reset();
	}

	gcds_data11.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s11?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data11.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(e){
	eval("gcds_data"+e).addrow();

	gcra_labuniyn.codevalue = '2';	//��������
	gcra_hitchyn.codevalue = 'N';		//��ֱ���
	gcra_gldiv.codevalue = '2';			//����/���
	gcra_gygb.codevalue = 'N';		//��ֱ���
	if (e=="00") {
		photo.src = "photo/00000.gif";
		gcds_data00.namevalue(gcds_data00.rowposition,"USESTS") = "1";
	} else if (e=="10")	eval("gcds_data"+e).namevalue(eval("gcds_data"+e).rowposition,"REQDT") = gs_date;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(e){
	var obj = eval("gcds_data"+e);
	var empno = gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	
	if (!obj.IsUpdated ){
		alert("�����Ͻ� ������ �����ϴ�.");
	} else {
		if(ln_Chk()){
			//����� ���� ����
			for(i=1;i<=gcds_data00.countrow;i++) {
				if (gcds_data00.namevalue(i,"ENDDT") != '') {
					gcds_data00.namevalue(i,"USESTS") = '3';
				}
			}

			if (confirm("�ش� �Է������� �����ϰڽ��ϱ� ?")) {
				if (e=="00") {
					gctr_data.KeyValue = "Contract.h080001_t1(I:USER=gcds_data00)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t1";
					gctr_data.Parameters = "v_str1=" + gcurdate.substring(2,4)+",v_str2=" + gclx_empdiv.BindColVal;
					//gctr_data.Parameters = "v_str1=08,v_str2=" + gclx_empdiv.BindColVal;
        
				} else if (e=="052") {
					gctr_data.KeyValue = "Contract.h080001_t6(I:USER=gcds_data052)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t6";
					gctr_data.Parameters = "v_str1=" + empno;
				} else if (e=="09") {
					gctr_data.KeyValue = "Contract.h080001_t8(I:USER=gcds_data09)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t8";
					gctr_data.Parameters = "v_str1=" + empno;
				} else if (e=="10") {
					gctr_data.KeyValue = "Contract.h080001_t9(I:USER=gcds_data10)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t9";
					gctr_data.Parameters = "v_str1=" + empno;
				} else if (e=="05") {
					gctr_data.KeyValue = "Contract.h080001_t5(I:USER=gcds_data05)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t5";
					gctr_data.Parameters = "v_str1=" + empno;
				} else {
					gctr_data.KeyValue = "Contract.h080001_t"+parseInt(e)+"(I:USER=gcds_data"+e+")";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t"+parseInt(e);
					gctr_data.Parameters = "v_str1=" + empno;	
				}
				gctr_data.post();
			}
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(e){

	var obj = eval("gcds_data"+e);
	var row = obj.rowposition;
	
	if (obj.sysStatus(row)!="1") { 	
		obj.deleterow(row);
		
		var obj = eval("gcds_data"+e);
		var empno = gcds_data00.namevalue(gcds_data00.rowposition,"empno");
		
		if (confirm("�ش� ������ �����ϰڽ��ϱ�?")) {
				if (e=="00") {
					gctr_data.KeyValue = "Contract.h080001_t1(I:USER=gcds_data00)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t1";
					gctr_data.Parameters = "v_str1=" + gcurdate.substring(2,4);
				} else if (e=="052") {
					gctr_data.KeyValue = "Contract.h080001_t6(I:USER=gcds_data052)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t6";
					gctr_data.Parameters = "v_str1=" + empno;
				} else if (e=="09") {
					gctr_data.KeyValue = "Contract.h080001_t8(I:USER=gcds_data09)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t8";
					gctr_data.Parameters = "v_str1=" + empno;
				} else if (e=="10") {
					gctr_data.KeyValue = "Contract.h080001_t9(I:USER=gcds_data10)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t9";
					gctr_data.Parameters = "v_str1=" + empno;
				} else if (e=="05") {
					gctr_data.KeyValue = "Contract.h080001_t5(I:USER=gcds_data05)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t5";
					gctr_data.Parameters = "v_str1=" + empno;
				} else {
					gctr_data.KeyValue = "Contract.h080001_t"+parseInt(e)+"(I:USER=gcds_data"+e+")";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_t"+parseInt(e);
					gctr_data.Parameters = "v_str1=" + empno;	
				}
				gctr_data.post();
			}
	} else {
		obj.undo(row);
	}
}

/******************************************************************************
	Description : ����üũ
******************************************************************************/
function ln_Chk(){
	
	if (fn_trim(txt_empnmk.value) ==""){
		alert("������ �Է��� �ֽʽÿ�");
		return false;
	}

	if (fn_trim(gcem_resino.text) ==""){
	 alert("�ֹι�ȣ�� �Է��� �ֽʽÿ�");
	 gcem_resino.Focus();
	 return false;
	}

	if (gclx_deptcd.BindColVal ==""){
		alert("�ҼӸ� �Է��� �ֽʽÿ�");
		return false;
	}

	//if (gclx_deptlvl.BindColVal ==""){
	//	alert("������ �Է��� �ֽʽÿ�");
	//	return false;
	//}

	if (fn_trim(gcem_strtdt.text )==""){
		alert("�Ի����� �Է��� �ֽʽÿ�");
		gcem_strtdt.Focus();
		return false;
	}

	if (gclx_empdiv.BindColVal == "") {
		alert("�Ի縦 �Է��� �ֽʽÿ�");
		return false;
	}

		return true; 
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
		gclx_assgb.index = 0;
		gcem_afrdt.Text = "";
		gcem_atodt.Text = "";
		gcem_assamt.Text = "";
		txt_assinst.Value = "";
		gcem_assno.Text = "";
		gcem_recpamt.Text = "";
		txt_hospital.Value = "";
		gcem_hosdt.Text = "";
		txt_hosmemo.Value = "";
		gcem_height.Text = "";
		gcem_weight.Text = "";
		gcem_blood.Text = "";
		gcem_eyel.Text = "";
		gcem_eyer.Text = "";
		gclx_colblnyn.index = 0;
		gcra_hosrevit.index = 0;
		gclx_disdiv.index = 0;
		gclx_disgrd.index = 0;
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){
	if (gcds_data00.countrow<1){
		alert("����Ͻ� ������ �����ϴ�");
	} else {
		var ls_msdata = gcds_data00.namevalue(gcds_data00.rowposition,"empno");

		gcds_report0.ClearAll();

		gcds_report1.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s5?v_str1=" + ls_msdata;
		gcds_report1.Reset();

		gcds_report2.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s3?v_str1=" + ls_msdata;
		gcds_report2.Reset();

		gcds_report3.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s2?v_str1=" + ls_msdata;
		gcds_report3.Reset();

		gcds_report4.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s4?v_str1=" + ls_msdata;
		gcds_report4.Reset();

		gcds_report5.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s7?v_str1=" + ls_msdata;
		gcds_report5.Reset();

		gcds_report6.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s8?v_str1=" + ls_msdata;
		gcds_report6.Reset();

		gcds_report7.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s9?v_str1=" + ls_msdata;
		gcds_report7.Reset();

		gcds_report8.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s0?v_str1=" + ls_msdata;
		gcds_report8.Reset();

		gcds_report9.DataID = "<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s11?v_str1=" + ls_msdata;
		gcds_report9.Reset();

		var ls_temp = "";
		for (var i=1;i<=gcds_data00.countcolumn;i++) {
			if (i==1) ls_temp += gcds_data00.columnid(i) + ":" + gcds_data00.ColumnType(i);
			else {
				var col = gcds_data00.ColumnIndex(gcds_data00.columnid(i));
				col = gcds_data00.ColumnType(col)
				if (col==1) ls_temp += "," + gcds_data00.ColumnID(i) + ":STRING";
				else if (col==3) ls_temp += "," + gcds_data00.ColumnID(i) + ":DECIMAL";
				else if (col==5) ls_temp += "," + gcds_data00.ColumnID(i) + ":URL";
			}
		}

		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();

		for (var k=1;k<=gcds_data00.countcolumn;k++) {
			gcds_report0.namevalue(1,gcds_data00.columnid(k)) = gcds_data00.namevalue(gcds_data00.rowposition,gcds_data00.columnid(k));
		}

		ln_RptFor(ls_msdata);

		gcrp_print.preview();

	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
}

/******************************************************************************
	Description : ȭ�ϸ� üũ
******************************************************************************/
function ln_Divide(str, delim){
	var strArr=str.split(delim);
	var rtn="";
	var a=strArr.length;

	if(a>0){rtn=strArr[a-1];}
	strArr=null;
	return rtn;
}

/******************************************************************************
	Description : �ּ� ��ȸ
******************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "../../Common/jsp/com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval("gcem_"+e+"zipcd").text = arrParam[0];
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		eval("txt_"+e+"addr01").value = val;

	}
}


/******************************************************************************
	Description :  �����ȸ üũ
******************************************************************************/
function ln_Chk_Save(){
//gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

  var date = new Date();
  var year = gcurdate.substring(0,4);
  var month = gcurdate.substring(5,7);
  var date = gcurdate.substring(8,10);

	if (year == '2009' && month == '12' && date =='10'){	
			return true; 
//	}else if(year =='2009' && month =='1'){
//		return true;
//	}else if(year >='2010'){
//		return true;
	} else { 
		alert(" ��ȸ���� �Ⱓ�� �ƴմϴ�.");
		return false; 
	}
}
/******************************************************************************
	Description : ��¹� ���� �ۼ�
******************************************************************************/
function ln_RptFor(e){

	var ls_for = "";
	ls_for += "<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=840 ,face='����' ,size=10 ,penwidth=1																																																														";
	ls_for += "	<X>left=0 ,top=206	,right=336  ,bottom=527  ,border=true</X>                                                                                                                                                   ";
	//�⺻����
	ls_for += "	<X>left=0 ,top=561	,right=116  ,bottom=754  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
	//���ּ�
	ls_for += "	<X>left=114 ,top=561	,right=1909 ,bottom=627	 ,border=true</X>                                                                                                                                                 ";
	//�����ּ�
	ls_for += "	<X>left=114 ,top=624	,right=1909 ,bottom=689  ,border=true</X>                                                                                                                                                 ";
	//����ó
	ls_for += "	<X>left=114 ,top=688	,right=1909 ,bottom=754		,border=true</X>                                                                                                                                                ";
	ls_for += "	<X>left=114 ,top=561  ,right=299	,bottom=627		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	ls_for += "	<X>left=114 ,top=624  ,right=299	,bottom=691		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	ls_for += "	<X>left=114 ,top=688  ,right=299	,bottom=754		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	ls_for += "	<X>left=333 ,top=206	,right=519	,bottom=273		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	ls_for += "	<X>left=333 ,top=272	,right=519	,bottom=340		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	ls_for += "	<X>left=333 ,top=333	,right=519	,bottom=400		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	ls_for += "	<X>left=333 ,top=397	,right=519	,bottom=463		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	ls_for += "	<X>left=333 ,top=460	,right=519	,bottom=527		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	
	//����
	ls_for += "	<X>left=518 ,top=206 ,right=1909 ,bottom=273 ,border=true</X>                                                                                                                                                   ";
	//�ֹι�ȣ
	ls_for += "	<X>left=518 ,top=272 ,right=1909 ,bottom=340 ,border=true</X>                                                                                                                                                   ";
	//�Ҽ�
	ls_for += "	<X>left=518 ,top=333 ,right=1909 ,bottom=400 ,border=true</X>                                                                                                                                                   ";
	//�Ҽӹ߷�
	ls_for += "	<X>left=518 ,top=397 ,right=1909 ,bottom=463 ,border=true</X>                                                                                                                                                   ";
	//�׷��Ի���
	ls_for += "	<X>left=518 ,top=460 ,right=1909 ,bottom=527 ,border=true</X>                                                                                                                                                   ";
	
	//�������
	ls_for += "	<X>left=969 ,top=272  ,right=1156	,bottom=334  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
	//����
	ls_for += "	<X>left=969 ,top=333	,right=1156	,bottom=400		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>																																																	";
	//������
	ls_for += "	<X>left=969 ,top=397  ,right=1156	,bottom=461  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
	//�Ի���
	ls_for += "	<X>left=969 ,top=460  ,right=1156	,bottom=527  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
	
	//e-mail
	ls_for += "	<X>left=1304,top=688  ,right=1490	,bottom=754  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>																																																	";
	ls_for += "	<X>left=1416 ,top=206 ,right=1601 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	//����
	ls_for += "	<X>left=1416 ,top=272 ,right=1601 ,bottom=340 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>																																																		";
//  ���� �Ʒ���!
	ls_for += "	<X>left=1416 ,top=333 ,right=1601 ,bottom=398 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	ls_for += "	<X>left=1416 ,top=397 ,right=1601 ,bottom=461 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	ls_for += "	<X>left=1416 ,top=460 ,right=1601 ,bottom=527 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>   ";
    //������
	//ȣ�� �� 
	ls_for += " <X>left=1685 ,top=272 ,right=1806 ,bottom=334 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>																									 ";
	ls_for += "	<I>id='"+rDOMAIN+"<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s0?v_str1="+e+"' ,left=1 ,top=207 ,right=332 ,bottom=526</I>																																																	";
	ls_for += "	<T>id='"+gs_cdate+"', left=1688, top=156, right=1974, bottom=206, align='left' , face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                      ";
	ls_for += "	<C>id='EMPNMK',  left=529, top=212, right=757, bottom=267, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                              ";
	ls_for += "	<C>id='NMC',     left=762, top=212, right=990, bottom=267, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                              ";
	ls_for += "	<C>id='NME',     left=995, top=212, right=1408,bottom=267, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                              ";
	ls_for += "	<C>id='EMPNO', left=1606, top=211, right=1835, bottom=266, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                              ";
	ls_for += "	<C>id='RESINO',  left=529, top=275, right=863, bottom=331, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>       ";
	ls_for += "	<C>id='DPOFFDT', left=529, top=402, right=863, bottom=458, align='left', mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
	ls_for += "	<C>id='STRTDT',		 left=529, top=466, right=863, bottom=521, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
	ls_for += "	<C>id='TODT',  left=1169,top=466, right=1409,bottom=521, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
	ls_for += "	<C>id='ENDDT', left=1606, top=467, right=1835, bottom=522, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
	//������
	//ls_for += "	<C>id='ORDDT',	left=1169, top=402, right=1409, bottom=458, align='left' ,mask='XXXX/XX/XX', face='����', size=10, //bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          ";
	ls_for += "	<C>id='LAMDT',	left=1169, top=402, right=1409, bottom=458, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          ";
	//var ls_t = "";		//��å
	//ls_t += gclx_jobgrph.ValueByColumn("MINORCD", gclx_jobgrph.ValueOfIndex("MINORCD", gclx_jobgrph.Index), "MINORNM");
	//ls_for += "	<T>id='" + ls_t + "', left=1609, top=402, right=1837, bottom=458, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>    ";

	var ls_t = "";			//����
	ls_t += gclx_jobkind.ValueByColumn("MINORCD", gclx_jobkind.ValueOfIndex("MINORCD", gclx_jobkind.Index), "MINORNM");
	ls_for += "	<T>id='" + ls_t + "', left=1606 ,top=401 ,right=1896 ,bottom=459 ,align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>    ";

	var ls_val0 = "";		//����
	if (gcds_report0.namevalue(1,"SEX") =="1") ls_val0 += "����"; else ls_val0 += "����";
	ls_for += "	<T>id='"+ls_val0+"', left=1606 ,top=274 ,right=1641 ,bottom=332 ,align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>												";
	//��౸��
	ls_for += "	<C>id='GYGB' ,left=1606 ,top=340 ,right=1835 ,bottom=393 ,align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>		";

	//�������
	ls_for += "	<C>id='BIRDT', left=1169, top=275, right=1409, bottom=331, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";

	var ls_val1 = "";		//�ҼӺ�
	var ls_va14 = gclx_deptcd.ValueByColumn("DEPTCD", gclx_deptcd.ValueOfIndex("DEPTCD", gclx_deptcd.Index), "DEPTNM");
	ls_val1 += txt_dlevel.value;
	if (ls_va14 != "����ƻ�") {
		ls_val1 += "/";
		ls_val1 += gclx_deptcd.ValueByColumn("DEPTCD", gclx_deptcd.ValueOfIndex("DEPTCD", gclx_deptcd.Index), "DEPTNM")+ "/";
		ls_val1 += gclx_grddiv.ValueByColumn("MINORCD", gclx_grddiv.ValueOfIndex("MINORCD", gclx_grddiv.Index), "MINORNM");
		ls_for += "<T>id='" + ls_val1 + "' ,left=529 ,top=339 ,right=957 ,bottom=394, align=left ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>												";
		
	}else{
		ls_for += "<T>id='" + ls_val1 + "' ,left=529 ,top=339 ,right=957 ,bottom=394, align=left ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>												";
	}

	var ls_val2 = "";		//ȣ��
	ls_val2 = gcem_payseq.text + " ȣ";
	ls_for += "<T>id='" + ls_val2 + "' ,left=1811 ,top=274 ,right=1898 ,bottom=332 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>											";

	var ls_val3 = "";		//����
	ls_val3 = gclx_deptlvl.ValueByColumn("MINORCD", gclx_deptlvl.ValueOfIndex("MINORCD", gclx_deptlvl.Index), "MINORNM");
	ls_for += "<T>id='" + ls_val3 + "' ,left=1169 ,top=337 ,right=1409 ,bottom=393 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>											";

	//���ּҿ����ȣ
	ls_for += "	<C>id='CZIPCD', left=307, top=566, right=482, bottom=622, align='left' ,mask='XXX-XXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>               ";
	//���������ȣ
	ls_for += "	<C>id='OZIPCD', left=307, top=630, right=482, bottom=685, align='left' ,mask='XXX-XXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>               ";	
	//���ּ�
	ls_for += "	<C>id='CADDRNM', left=487, top=566, right=1891, bottom=622, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                             ";
	//�����ּ� OADDRNM
	ls_for += "	<C>id='OADDRNM', left=487, top=630, right=1891, bottom=685, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                             ";

	//����ó
	ls_for += "	<C>id='TELNO',	left=413, top=693, right=659, bottom=749, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               ";
	//�޴�����ȣ
	ls_for += "	<C>id='HPNO',		left=1036, top=693, right=1294, bottom=749, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                             ";
	//email
	ls_for += "	<C>id='EMAIL',	left=1498		,top=693	,right=1895	,bottom=749	,align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                             ";
	ls_for += "	<T>id='TEL)'		,left=307		,top=693	,right=402	,bottom=749 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                 ";
	ls_for += "	<T>id='HP)'			,left=944		,top=693	,right=1038 ,bottom=749 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                 ";
	ls_for += "	<T>id='��  ��' ,left=1422 ,top=211 ,right=1572 ,bottom=266 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>																	 ";
	ls_for += "	<T>id='��  ��' ,left=1422 ,top=274 ,right=1572 ,bottom=332 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>																";	
	ls_for += "	<I>id='"+rDOMAIN+"/Common/img/iconlogo.jpg' ,left=703 ,top=63 ,right=776 ,bottom=123</I>																																																												";
	ls_for += " <T>id='ȣ  ��' ,left=1693 ,top=274 ,right=1796 ,bottom=332 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>															 " ;
	ls_for += "	<T>id='�� �� �� �� ��'	,left=25 ,top=19 ,right=1999 ,bottom=122 ,face='����' ,size=22 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                 ";
	ls_for += "	<T>id='��'					,left=5			,top=580 ,right=111		,bottom=615 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                     ";
	ls_for += "	<T>id='��'					,left=5			,top=618 ,right=111		,bottom=662 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                     ";
	ls_for += "	<T>id='��'					,left=5			,top=667 ,right=111		,bottom=692 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                     ";
	ls_for += "	<T>id='��'					,left=5			,top=690 ,right=111		,bottom=746 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                     ";
	ls_for += "	<T>id='���ּ�'			,left=119		,top=566 ,right=294		,bottom=622 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='�����ּ�'		,left=119		,top=630 ,right=294		,bottom=685 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='����ó'			,left=119		,top=693 ,right=294		,bottom=749 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='��  ��'			,left=339		,top=212 ,right=513		,bottom=267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='�������� :'	,left=1453	,top=156 ,right=1691	,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,align='right' </T>                     ";
	ls_for += "	<T>id='�Ի���'	,left=339		,top=466 ,right=513		,bottom=521 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='�������'		,left=975		,top=275 ,right=1150	,bottom=331 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='��  ��'			,left=975		,top=337 ,right=1150	,bottom=394 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>																		";
	ls_for += "	<T>id='������'			,left=975		,top=402 ,right=1150	,bottom=458 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='��  ��' ,left=1422 ,top=401 ,right=1572 ,bottom=459 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>				                                    ";
	ls_for += "	<T>id='��ุ����'			,left=975		,top=466 ,right=1150	,bottom=521 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='��  ��'			,left=339		,top=339 ,right=513		,bottom=394 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='email'				,left=1310	,top=693 ,right=1484	,bottom=749 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
	ls_for += "	<T>id='������' ,left=1422 ,top=340 ,right=1572 ,bottom=393 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>															  ";
	ls_for += "	<T>id='�����' ,left=1422 ,top=467 ,right=1572 ,bottom=522 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>								                                 ";
	ls_for += "	<T>id='�ֹι�ȣ' ,left=339 ,top=275 ,right=513 ,bottom=331 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
	ls_for += "	<T>id='�Ҽӹ߷�' ,left=339 ,top=402 ,right=513 ,bottom=458 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
	ls_for += "	<T>id='�� �� �� �� ��' ,left=0 ,top=740 ,right=1691 ,bottom=880 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>										";
	ls_for += "	<L> left=703 ,top=134 ,right=1241 ,bottom=134 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>                                                                                                                ";
	ls_for += "</B>																																																																																																							";
  //prompt('',ls_for);
	gcrp_print.format = ls_for + gcrp_print.format;

}

/******************************************************************************
	Description : ������ ����
******************************************************************************/
function ln_ChkLev(e){
	var ls_va = parseInt(gcds_data09.namevalue(e,"SCR"));
	if (ls_va>90) gcds_data09.namevalue(e,"SCRGBN") = "A";
	else if (ls_va>80 && ls_va<91) gcds_data09.namevalue(e,"SCRGBN") = "B";
	else if (ls_va>70 && ls_va<81) gcds_data09.namevalue(e,"SCRGBN") = "C";
	else if (ls_va>60 && ls_va<71) gcds_data09.namevalue(e,"SCRGBN") = "D";
	else if (ls_va<61) gcds_data09.namevalue(e,"SCRGBN") = "E";
}

/******************************************************************************
	Description : ����-��-�� [Default : LEVEL-3]
******************************************************************************/
function ln_DeptLevel(){

	if (gcds_data00.countrow<1) {
	} else {
	
	var row = gcds_data00.rowposition;
	var row2 = gcds_deptlevel.rowposition;

		if (gcds_data00.namevalue(row,"DEPTCD") == 'A000') {
			txt_dlevel.value  =  "����ƻ�";
		}else if (gcds_data00.namevalue(row,"LEVEL") =='2') {
			txt_dlevel.value  =  "����ƻ�";
		/********** [ 3 ] L E V E L   S T A R T *******************************************************************************/
		}else if (gcds_data00.namevalue(row,"LEVEL") =='3') {
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,2);	//LEVEL [ 2 ] CHECK
			var tree03 = gcds_data00.namevalue(row,"TREECD").substring(2,4);	//LEVEL [ 3 ] CHECK
			
			for(i=1;i<=gcds_deptlevel.countrow;i++) {				
				if (tree03 == gcds_deptlevel.namevalue(i,"TREECD").substring(2,4) && gcds_deptlevel.namevalue(i,"LEVEL") == '3'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,2)) {
					var level03 = gcds_data00.namevalue(row,"TREECD").substring(0,2) + "000000";
					for(j=1;j<=gcds_deptlevel.countrow;j++) {
						if (level03 == gcds_deptlevel.namevalue(j,"TREECD")) {		
							var re_deptnm = gcds_deptlevel.namevalue(j,"DEPTNM");
						}
					}
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);	// RESULT
		/********** [ 3 ] L E V E L   E N D ***********************************************************************************/
		
		/********** [ 4 ] L E V E L   S T A R T *******************************************************************************/
		}else if (gcds_data00.namevalue(row,"LEVEL") =='4') {
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,2);	//LEVEL [ 2 ] CHECK
			var tree04 = gcds_data00.namevalue(row,"TREECD").substring(4,6);	//LEVEL [ 4 ] CHECK

			for(i=1;i<=gcds_deptlevel.countrow;i++) {				
				if (tree04 == gcds_deptlevel.namevalue(i,"TREECD").substring(4,6) && gcds_deptlevel.namevalue(i,"LEVEL") == '4'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,2)) {
					var level04 = gcds_data00.namevalue(row,"TREECD").substring(0,4) + "0000";
					for(j=1;j<=gcds_deptlevel.countrow;j++) {
						if (level04 == gcds_deptlevel.namevalue(j,"TREECD")) {		
							var re_deptnm = gcds_deptlevel.namevalue(j,"DEPTNM");
						}
					}
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);	// RESULT
		/********** [ 4 ] L E V E L   E N D ***********************************************************************************/
		
		/********** [ 5 ] L E V E L   S T A R T *******************************************************************************/
		}else if (gcds_data00.namevalue(row,"LEVEL") =='5') {
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,2);	//LEVEL [ 2 ] CHECK
			var tree05 = gcds_data00.namevalue(row,"TREECD").substring(6,8);	//LEVEL [ 4 ] CHECK

			for(i=1;i<=gcds_deptlevel.countrow;i++) {				
				if (tree05 == gcds_deptlevel.namevalue(i,"TREECD").substring(6,8) && gcds_deptlevel.namevalue(i,"LEVEL") == '5'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,2)) {
					var level05 = gcds_data00.namevalue(row,"TREECD").substring(0,6) + "00";
					for(j=1;j<=gcds_deptlevel.countrow;j++) {
						if (level05 == gcds_deptlevel.namevalue(j,"TREECD")) {		
							var re_deptnm = gcds_deptlevel.namevalue(j,"DEPTNM");
						}
					}
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);	// RESULT
		/********** [ 5 ] L E V E L   E N D ***********************************************************************************/
		}else{
			txt_dlevel.value  =  fn_trim(gcds_data00.namevalue(row,"DEPTNM"));	// �׿� ������ RESULT
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data052 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data07 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+ORDDT">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data09 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="-EVAYM">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="-FRDT-TODT">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+treecd">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_srh1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_srh2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+treecd">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_srh3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+treecd">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_relatgrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_nomingrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grddiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobgrph classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_edccd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_empdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_empdiv2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rilign classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_paybnkcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hdfamret classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_relatre classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_assret classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_nominre classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_mrtdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcstype classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcscd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hieduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_pieduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_gieduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_colblnyn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_milidiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_miliknd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_miligrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_milispec classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_militype classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_militgbn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_englvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_ordcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_payseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_disdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_disgrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rewgbn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rewkin classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_recdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobkind classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlevel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �Ҽ�-�� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_disdiv" event="onloadCompleted(row,colid)">
	gcds_disdiv.insertrow(1);
	gcds_disdiv.namevalue(1,"MINORCD") = "";
	gcds_disdiv.namevalue(1,"MINORNM") = "";
</script>

<script language="javascript" for="gcds_disgrd" event="onloadCompleted(row,colid)">
	gcds_disgrd.insertrow(1);
	gcds_disgrd.namevalue(1,"MINORCD") = "";
	gcds_disgrd.namevalue(1,"MINORNM") = "";
</script>

<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";

	ln_DeptLevel();

	if (gcds_data00.countrow>0){
		if (gcds_data00.namevalue(1,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data00.namevalue(1,"empno");
			photo.src="<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s0?v_str1="+str1;
		}
	} else {
		if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	}

</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
	ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
	ft_cnt4.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data05" event="onloadCompleted(row,colid)">
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data06" event="onloadCompleted(row,colid)">
	if (row <1) gcds_data06.addrow();
</script>

<script language="javascript" for="gcds_data07" event="onloadCompleted(row,colid)">
	ft_cnt7.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");

		//�⺻���� -> �系��»��� �߰�
		gcds_data07.AddRow();
		var row00 = gcds_data00.rowposition;
		gcds_data07.namevalue(1,"ORDDT")  = gcds_data00.namevalue(row00,"STRTDT");
		gcds_data07.namevalue(1,"DEPTCD") = gcds_data00.namevalue(row00,"DEPTCD");
		gcds_data07.namevalue(1,"PAYGRD") = gcds_data00.namevalue(row00,"PAYGRD");
		gcds_data07.namevalue(1,"PAYSEQ") = gcds_data00.namevalue(row00,"PAYSEQ");
		gcds_data07.namevalue(1,"GRDDIV") = gcds_data00.namevalue(row00,"GRDDIV");
	}
</script>

<script language="javascript" for="gcds_data09" event="onloadCompleted(row,colid)">
	ft_cnt9.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data10" event="onloadCompleted(row,colid)">
	ft_cnt10.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data052" event="onloadCompleted(row,colid)">
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	if (row<1) gcds_data052.addrow();
</script>

<script language="javascript" for="gcds_jobgrph" event="onloadCompleted(row,colid)">
	if (row >0)	gcds_jobgrph.deleterow(1);
	gclx_jobgrph.index = 0;
</script>

<script language="javascript" for="gcds_srh1" event="onloadCompleted(row,colid)">
	gcds_srh1.insertrow(1);
	gcds_srh1.namevalue(1,"MINORCD") = "";
	gcds_srh1.namevalue(1,"MINORNM") = "��ü";
	gclx_srh1.index = 1;
</script>

<script language="javascript" for="gcds_srh2" event="onloadCompleted(row,colid)">
	gcds_srh2.insertrow(1);
	gcds_srh2.namevalue(1,"DEPTCD") = "";
	gcds_srh2.namevalue(1,"DEPTNM") = "��ü";
	gclx_srh2.index = 0;
</script>

<!-- <script language="javascript" for="gcds_empdiv" event="onloadCompleted(row,colid)">
	gcds_empdiv.DeleteRow(1);	//������
	gcds_empdiv.DeleteRow(2);	//������	
	gcds_empdiv.DeleteRow(1);	//���ߵ��������
	gclx_empdiv.index = 0;
</script> -->


<script language="javascript" for="gcds_empdiv2" event="onloadCompleted(row,colid)">
	//�Ի籸��
	if (row>0) {
	gcds_empdiv2.Deleterow(1);
	gcds_empdiv2.Deleterow(1);
	gcds_empdiv2.Deleterow(1);
  gcds_empdiv2.insertrow(1);
	gcds_empdiv2.namevalue(1,"MINORCD") = "";
	gcds_empdiv2.namevalue(1,"MINORNM") = "��ü";
	gclx_empdiv2.index = 0;
	}
</script>

<script language=JavaScript for=gclx_srh2 event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_srh2.ValueOfIndex ("level", gclx_srh2.Index);
	gs_treecd = gclx_srh2.ValueOfIndex ("treecd", gclx_srh2.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="onselChanged(index)">
	if (gcds_data00.countrow>0) {
		if (index=="2") ln_OrdQuery(); 
		else if (index=="3")	ln_FamQuery();	
		else if (index=="4")	ln_CarQuery();	
		else if (index=="5")	ln_EduQuery();  
		else if (index=="6")	ln_LicQuery();
		else if (index=="7")	ln_DeuQuery();
		else if (index=="8")	ln_ReqQuery();	//ln_EngQuery();
		else if (index=="9")	ln_AssQuery();
		else if (index=="10") ln_RewQuery();
	}
</script>

<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">
		gcte_disp.ActiveIndex = 1;

		ln_DeptLevel();	//�Ҽ�-����ȸ

		if (gcds_data00.namevalue(row,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data00.namevalue(row,"empno");
			photo.src="<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s0?v_str1="+str1;
		}
</script>

<script language=JavaScript for=gcgd_disp event="onKeyPress()">
		gcte_disp.ActiveIndex = 1;
			
		ln_DeptLevel();	//�Ҽ�-����ȸ
		var row = gcds_data00.rowposition;
		if (gcds_data00.namevalue(row,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data00.namevalue(row,"empno");
			photo.src="<%=dirPath%><%=HDConstant.PATH_CONTRACT%>h080001_s0?v_str1="+str1;
		}
</script>

<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!=""){
		txt_file.value = gcip_file.value;
		photo.src = gcip_file.value;
		var tfile = txt_file.value;
		var tfilename = ln_Divide(txt_file.value, "\\");
		gcds_data00.namevalue(gcds_data00.rowposition,"PICTURE") = tfilename;
	}
</script>

<script language="javascript" for="gcem_resino" event="OnKillFocus()">
	if (fn_trim(gcem_resino.text).length==13) {
		var ls_ck = gcem_resino.text.substring(6,7);
		if (ls_ck<3) gcem_birdt.text = "19"+gcem_resino.text.substring(0,6);
		else gcem_birdt.text = "20"+gcem_resino.text.substring(0,6);

		if (ls_ck==1 || ls_ck==3) gclx_sex.index = 0;
		else gclx_sex.index = 1;
	}
</script>

<script language="javascript" for="gcds_data07" event="onRowPosChanged(row)">
	if (gcds_data07.sysStatus(row)=="1") gcgd_disp07.columnProp("ORDDT","edit") = "";
	else gcgd_disp07.columnProp("ORDDT","edit") = "none";
</script>

<script language="javascript" for="gcgd_disp09" event="CanColumnPosChange(row,colid)">
	if (colid=="SCR") ln_ChkLev(row);
</script>

<script language="javascript" for="gcgd_disp09" event="OnKillFocus()">
	ln_ChkLev(gcds_data09.rowposition);
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	//�Ҽ�
	if (gcds_data00.countrow<1) {
		gcds_dept.insertrow(1);
		gcds_dept.namevalue(1,"DEPTCD") = "";
		gcds_dept.namevalue(1,"DEPTNM") = "";
		gclx_deptcd.index = 0;
	}
</script>

<script language="javascript" for="gcds_deptlvl" event="onloadCompleted(row,colid)">
	//����
	if (gcds_data00.countrow<1) {
	gcds_deptlvl.insertrow(1);
	gcds_deptlvl.namevalue(1,"MINORCD") = "";
	gcds_deptlvl.namevalue(1,"MINORNM") = "";
	gclx_deptlvl.index = 0;
	}
</script>

<script language="javascript" for="gcds_grddiv" event="onloadCompleted(row,colid)">
	//����
	if (gcds_data00.countrow<1) {
	gcds_grddiv.insertrow(1);
	gcds_grddiv.namevalue(1,"MINORCD") = "";
	gcds_grddiv.namevalue(1,"MINORNM") = "";
	gclx_grddiv.index = 0;
	}
</script>

<script language="javascript" for="gcds_jobgrph" event="onloadCompleted(row,colid)">
	//��å
	if (gcds_data00.countrow<1) {
	gcds_jobgrph.insertrow(1);
	gcds_jobgrph.namevalue(1,"MINORCD") = "";
	gcds_jobgrph.namevalue(1,"MINORNM") = "";
	gclx_jobgrph.index = 0;
	}
</script>

<!-- <script language="javascript" for="gcds_empdiv" event="onloadCompleted(row,colid)">
	//�Ի�
	if (gcds_data00.countrow<1) {
	gcds_empdiv.insertrow(1);
	gcds_empdiv.namevalue(1,"MINORCD") = "";
	gcds_empdiv.namevalue(1,"MINORNM") = "";
	gclx_empdiv.index = 2;
	}
</script> -->


<script language="javascript" for="gcds_recdiv" event="onloadCompleted(row,colid)">
	//�Ի籸��
	if (gcds_data00.countrow<1) {
	gcds_recdiv.insertrow(1);
	gcds_recdiv.namevalue(1,"MINORCD") = "";
	gcds_recdiv.namevalue(1,"MINORNM") = "";
	gclx_recdiv.index = 0;
	}
</script>

<script language="javascript" for="gcds_jobkind" event="onloadCompleted(row,colid)">
	//����
	if (gcds_data00.countrow<1) {
	gcds_jobkind.insertrow(1);
	gcds_jobkind.namevalue(1,"MINORCD") = "";
	gcds_jobkind.namevalue(1,"MINORNM") = "";
	gclx_jobkind.index = 0;
	}
</script>

<script language="javascript" for="gcds_rilign" event="onloadCompleted(row,colid)">
	//����
	if (gcds_data00.countrow<1) {
	gcds_rilign.insertrow(1);
	gcds_rilign.namevalue(1,"MINORCD") = "";
	gcds_rilign.namevalue(1,"MINORNM") = "";
	gclx_rilign.index = 0;
	}
</script>

<script language="javascript" for="gcds_mrtdiv" event="onloadCompleted(row,colid)">
	//���ƴ��
	if (gcds_data00.countrow<1) {
	gcds_mrtdiv.insertrow(1);
	gcds_mrtdiv.namevalue(1,"MINORCD") = "";
	gcds_mrtdiv.namevalue(1,"MINORNM") = "";
	gclx_mrtdiv.index = 0;
  }
</script>

<script language="javascript" for="gcds_paybnkcd" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	//����
	if (gcds_data00.countrow<1) {
	gcds_paybnkcd.insertrow(1);
	gcds_paybnkcd.namevalue(1,"MINORCD") = "";
	gcds_paybnkcd.namevalue(1,"MINORNM") = "";
	gclx_paybnkcd.index = 0;
	}
</script>

<script language="javascript" for="gcds_milidiv" event="onloadCompleted(row,colid)">
	//����
	gcds_milidiv.insertrow(1);
	gcds_milidiv.namevalue(1,"MINORCD") = "";
	gcds_milidiv.namevalue(1,"MINORNM") = "";
	gclx_milidiv.index = 0;
</script>

<script language="javascript" for="gcds_militgbn" event="onloadCompleted(row,colid)">
	//����
	gcds_militgbn.insertrow(1);
	gcds_militgbn.namevalue(1,"MINORCD") = "";
	gcds_militgbn.namevalue(1,"MINORNM") = "";
	gclx_militgbn.index = 0;
</script>


<script language="javascript" for="gcds_miligrd" event="onloadCompleted(row,colid)">
	//���
	gcds_miligrd.insertrow(1);
	gcds_miligrd.namevalue(1,"MINORCD") = "";
	gcds_miligrd.namevalue(1,"MINORNM") = "";
	gclx_miligrd.index = 0;
</script>


<script language="javascript" for="gcds_militype" event="onloadCompleted(row,colid)">
	//����
	gcds_militype.insertrow(1);
	gcds_militype.namevalue(1,"MINORCD") = "";
	gcds_militype.namevalue(1,"MINORNM") = "";
	gclx_militype.index = 0;
</script>

<script language="javascript" for="gcds_milispec" event="onloadCompleted(row,colid)">
	//����
	gcds_milispec.insertrow(1);
	gcds_milispec.namevalue(1,"MINORCD") = "";
	gcds_milispec.namevalue(1,"MINORNM") = "";
	gclx_milispec.index = 0;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<!-- <script language="javascript" for="gcds_mrtdiv" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_mrtdiv" event="onloadError()">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script> -->

<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	gcte_disp.ActiveIndex = 1;
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gctr_data.ErrorMsg);
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876", height="0" border="0" cellpadding="0" cellspacing="0">
	<tr height="30px">
		<td colspan="2">
			<div id=top_btn_visible style="display:block">
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
			  <tr> 
					<td width="215" background="../../Common/img/com_t_bg.gif"><IMG height=47 src="../img/h080001_head.gif" width=197></td>
					<td width="661" align="right"  valign=middle background="../../Common/img/com_t_bg.gif">
						<img name="btn_print" src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print('00')">
						<img name="btn_del" border="0" src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete('00')">
						<img name="btn_add" SRC="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Add('00')">
						<img name="btn_save" src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save('00')">
						<img name="btn_query" src="../../Common/img/btn/com_b_query.gif" style="cursor:hand;" onclick="ln_Query()">
					</td>
				</tr>
			</table>
			</div>
		  <div id=top_btn_hidden style="display:none">
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
				<tr> 
					<td width="215" background="../../Common/img/com_t_bg.gif"><img height=47 src="../img/h080001_head.gif" width=197></td>
					<td width="661" align="right"  valign=middle background="../../Common/img/com_t_bg.gif">
						<img name="btn_photo" src="../../Common/img/btn/com_b_photo.gif"  style="cursor:hand" onclick="ln_Photo()">
						<img name="btn_print" src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
					</td>
				</tr>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td cellpadding="0" cellspacing="0" valign="top" style="padding-left:3px;">
			<table height="0" border="0" cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-left-width:1px;border-top-width:1px">
				<tr height="40px">
					<td width="120px;" class="tab11" bgcolor="#eeeeee">����<br>����</td>
					<td width="100px;" class="tab21">
						<comment id="__NSID__">
						<OBJECT id=gclx_srh1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
							<param name=ComboDataID			value="gcds_srh1">
							<param name=CBDataColumns		value="MINORCD, MINORNM">
							<param name=SearchColumn		value=MINORNM>
							<param name=Sort				value=false>
							<param name=ListExprFormat		value="MINORNM^0^150">
							<param name=BindColumn			value=MINORCD>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
		  		</td>
				</tr>
				<tr height="40px">
					<td width="120px;" class="tab11" bgcolor="#eeeeee">�Ҽ�<br>����</td>
					<td width="100px;" class="tab21">
						<comment id="__NSID__"><OBJECT id=gclx_srh2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_srh2">
								<param name=CBDataColumns		value="DEPTCD, DEPTNM">
								<param name=SearchColumn		value=DEPTNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="DEPTNM^0^150">
								<param name=BindColumn			value=DEPTCD>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
		  		</td>
				</tr>

				<tr height="40px">
					<td width="120px;" class="tab11" bgcolor="#eeeeee">�Ի�<br>����</td>
					<td width="100px;" class="tab21">
						<comment id="__NSID__"><OBJECT id=gclx_empdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_empdiv2">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value=MINORCD>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
		  		</td>
				</tr>
				<tr height="35px">
					<td class="tab11" bgcolor="#eeeeee">�����</td>
					<td class="tab21"><input type="text" id=txt_empnm class="txt11" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
				</tr>
				<tr height="35px">
					<td class="tab11" bgcolor="#eeeeee">���</td>
					<td class="tab21"><input type="text" id=txt_empno1 class="txt11" onkeydown="if(event.keyCode==13) ln_Query();" style="width:100px;" ></td>
				</tr>
				<tr>
					<td colspan="2" class="tab21">
						<comment id="__NSID__"><OBJECT id="gcgd_disp"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:313;width:170" >
		            <param name=dataid					value=gcds_data00>
								<param Name=BorderStyle			value=0> 
								<param name=indwidth        value=0>
								<param name=fillarea        value=true>
								<param name=headlinecolor   value=#999999>
								<param name=Sortview				value=left>
     						<param name=format          value='
									<C>ID=EMPNMK,	Name="����",  width=55,	 HeadBgColor=#B9D4DC,	HeadAlign=center, sort=true</C>
									<C>ID=DEPTNM, Name="�Ҽ�",  width=100, HeadBgColor=#B9D4DC,	HeadAlign=center, sort=true</C>
									<C>ID=PAYGNM, Name="����",  width=100, HeadBgColor=#B9D4DC,	HeadAlign=center, sort=true</C>
									<C>ID=EMPNO,	Name="���",  width=53,  HeadBgColor=#B9D4DC,	HeadAlign=center, sort=true</C>
								'>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:170;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset><BR><a href="javascript:document.all.gcgd_disp.RunExcel('��������ȸ');	//��Ʈ���� �Է��մϴ�.">�׼�</a>
					</td>
        </tr>
      </table>
	  </td>
		<td width=80%  height="0" valign="top">
			<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:4px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
				<tr>
					<td class="tab12">
						<table border=0 cellpadding=0 cellspacing=0 width="125px">
							<tr>
								<td class="tab13" style="height:99px;"><img id="photo" src="photo/00000.gif" border=0 width="85px" height="99px"></td></tr>
							<tr>
								<td class="tab13" style="height:25px;">
									<input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
								  <comment id="__NSID__"><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
						        style="position:relative;left:0px;top:0px;width:80; height:20;">
								      <param name="Text"		value="ã�ƺ���">
						          <param name="Enable"  value="true">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table border="0" cellpadding=0 cellspacing=0>
										<tr>
											<td class="tab22" style="height:26px;width:125px" align=center><input type="text" id="txt_dlevel" class="txtbox" style="position:relative;top:3px;width:120px;height:19px;text-align:center;border:0px"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table border="0" cellpadding=0 cellspacing=0 style="border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;">
							<tr> 
								<td class="tab11" width="80px;" bgcolor="#eeeeee">����</td>
								<td class="tab21" width="300px;">
									<input type="text" id=txt_empnmk class="txt11" style="width:80px;" maxlength="20" onBlur="bytelength(this,this.value,20);">
									<input type="text" id=txt_empnmc class="txt11" style="width:80px;" maxlength="20" onBlur="bytelength(this,this.value,20);">
									<input type="text" id=txt_empnme class="txt11" style="width:110px;" maxlength="40" onBlur="bytelength(this,this.value,40);">
								</td>
								<td class="tab11" width="80px;" bgcolor="#eeeeee">���</td>
								<td class="tab22" width="110px"><input type="text" id=txt_empno class="txt11" style="width:80px;" readonly></td>
							</tr> 
							<tr>
								<td colspan="4">
									<table border="0" cellpadding=0 cellspacing=0>
										<tr>
				              <td class="tab11" width="80px;" bgcolor="#eeeeee">�ֹι�ȣ</td>
					            <td class="tab21" width="120px">
												<comment id="__NSID__"><OBJECT id=gcem_resino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
													style="position:relative; left:8px;top:1px; width:92px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="000000-0000000">
														<param name=PromptChar	  value="_">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
		                  <td class="tab11" width="80px" bgcolor="#eeeeee">�������</td>
			                <td class="tab22" width="75px">
												<comment id="__NSID__"><OBJECT id=gcem_birdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														<param name=Enable				value="false">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab22" width="10px">&nbsp;</td>
											<td class="tab22" width="205px">
												<comment id="__NSID__"><OBJECT id=gcra_gldiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
													style="position:relative;left:0px;top:0px;height:20;width:100;cursor:hand;">
														<param name=Cols     value="2">
														<param name=Format   value="1^����,2^���">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
												<comment id="__NSID__"><OBJECT id=gclx_sex classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:70px;">
														<param name=CBData					value="1^����^,2^����">
														<param name=CBDataColumns		value="minorcd,minornm">
														<param name=SearchColumn		value="minornm">
														<param name=ListExprFormat	value="minornm^0^70">								
														<param name=BindColumn			value="minorcd">
														<param name=Enable					value="false">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="tab11" bgcolor="#eeeeee">�Ҽ�����</td>
                <td class="tab21">
									<comment id="__NSID__"><OBJECT id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:120px;">
											<param name=ComboDataID			value="gcds_dept">
											<param name=CBDataColumns		value="DEPTCD, DEPTNM">
											<param name=SearchColumn		value=DEPTNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="DEPTNM^0^150">
											<param name=BindColumn			value=DEPTCD>
 									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<comment id="__NSID__"><OBJECT id=gclx_deptlvl classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_deptlvl">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^100">
											<param name=BindColumn			value=MINORCD>
	 								</OBJECT></comment><script>__ws__(__NSID__);</script>
									<comment id="__NSID__"><OBJECT id=gclx_grddiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:70px;">
											<param name=ComboDataID			value="gcds_grddiv">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^70">
											<param name=BindColumn			value=MINORCD>
	 								</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td>
                <td class="tab11" bgcolor="#eeeeee">ȣ��</td>
                <td class="tab22">
									<comment id="__NSID__"><OBJECT id=gcem_payseq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:80px; height:20px;" class=txtbox>
											<param name=Alignment			value=2>
											<param name=Border	      value=true>
											<param name=Numeric	      value="true">
											<param name=Maxlength     value="9">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<table border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">�Ҽӹ߷�</td>
                      <td class="tab21" width="120px">
												<comment id="__NSID__"><OBJECT id=gcem_dpoffdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">������</td>
                      <td class="tab21" width="98px">
												<comment id="__NSID__"><OBJECT id=gcem_lamdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" width="80px;" bgcolor="#eeeeee">��å</td>
											<td class="tab22" width="109px">
												<comment id="__NSID__"><OBJECT id=gclx_jobgrph classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
													style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
														<param name=ComboDataID			value="gcds_jobgrph">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^90">
														<param name=BindColumn			value=MINORCD>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                    </tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">�Ի�</td>
											<td class="tab21" width="120px">
												<comment id="__NSID__"><OBJECT id=gclx_empdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
														<!-- <param name=ComboDataID			value="gcds_empdiv"> -->
														<param name=CBData					value=" ^ ,3^�ѱ��ΰ����,4^�İ߰����,6^�İ�,7^�İ߰����-�Ƹ�����Ʈ">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=true>
														<param name=ListExprFormat	value="MINORNM^0^150">
														<param name=BindColumn			value=MINORCD>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">�Ի籸��</td>
                      <td class="tab21" width="98px">
												<comment id="__NSID__"><OBJECT id=gclx_recdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_recdiv">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^100">
														<param name=BindColumn			value=MINORCD>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">����</td>
											<td class="tab22" width="109px">
												<comment id="__NSID__"><OBJECT id=gclx_jobkind classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
														<param name=ComboDataID			value="gcds_jobkind">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^100">
														<param name=BindColumn			value=MINORCD>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
                      <td class="tab12" width="80px;" bgcolor="#eeeeee">�Ի���</td>
											<td class="tab23" width="120px">
												<comment id="__NSID__"><OBJECT id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab12" width="80px;" bgcolor="#eeeeee">��ุ����</td>
                      <td class="tab23" width="98px">
												<comment id="__NSID__"><OBJECT id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab12" width="80px;" bgcolor="#eeeeee">�����</td>
											<td width="102px">
												<comment id="__NSID__"><OBJECT id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0" style="position:relative;top:18px;left:4px;">
				<tr>
					<td>
						<comment id="__NSID__"><OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 
							style="width:660px;height:20px">
								<PARAM NAME="BackColor"					VALUE="#cccccc">
								<PARAM NAME="titleHeight"				VALUE="20px">
		            <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
								<PARAM NAME="Format"						VALUE="
									<T>divid=layer1  title='�⺻'</T>									
									<T>divid=layer7  title='�系���'</T>
									<T>divid=layer2  title='����'</T>
									<T>divid=layer3  title='�Ի������'</T>
									<T>divid=layer5  title='�з�'</T>
									<T>divid=layer4  title='�ڰݸ���'</T>
									<T>divid=layer9  title='���'</T>
								  <T>divid=layer10 title='����(����/����)'</T>
								  <T>divid=layer6  title='����/��ü/����'</T>
								  <T>divid=layer11 title='�������'</T>
									<T>divid=layer8  title='����/����' show=false</T>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!---------[TAB 1] left:200px;�⺻���� ----------->
<div id="layer1" style="position:absolute; top:330px; left:350px; width:720px;">
  <table style="border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td class="tab11" width="72px" bgcolor="#eeeeee">�����ȣ</td>
  	  <td class="tab21" width="100px">
				<comment id="__NSID__"><OBJECT id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="position:relative; left:5px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=Enable	      value="false">
						<param name=PromptChar	  value="_">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<img alt=�����ȣ��ȸ  id='img_search1' name='img_search1' style="position:relative;left:7px;top:2px;cursor:hand" src='../../Common/img/btn/com_b_search.gif'  onclick="ln_Popup('c')">
			</td>
			<td class="tab11" width="76px" bgcolor="#eeeeee">���ּ�</td>
  	  <td class="tab22">
				<input type="text" id=txt_caddr01 class="txt11" style="width:350px;" disabled>
			</td>
  	</tr>
		<tr>
			<td class="tab22" width="72px">&nbsp;</td>
  	  <td class="tab21" width="100px">&nbsp;</td>
			<td class="tab11" width="76px" bgcolor="#eeeeee">���ּ�</td>
  	  <td class="tab22" width="436px">
				<input type="text" id=txt_caddr02 class="txt11" style="width:350px;" maxlength="70" onBlur="bytelength(this,this.value,70);">
			</td>
  	</tr>
		<tr>
			<td class="tab11" bgcolor="#eeeeee">�����ȣ</td>
  	  <td class="tab21">
				<comment id="__NSID__"><OBJECT id=gcem_ozipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="position:relative; left:5px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=Enable	      value="false">
						<param name=PromptChar	  value="_">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<IMG alt=�����ȣ��ȸ  id='img_search2' name='img_search2' style="position:relative;left:7px;top:2px;cursor:hand" 	src='../../Common/img/btn/com_b_search.gif'  onclick="ln_Popup('o')">
			</td>
			<td class="tab11" bgcolor="#eeeeee">�����ּ�</td>
  	  <td class="tab22">
				<input type="text" id=txt_oaddr01 class="txt11" style="width:350px;" disabled>
			</td>
  	</tr>
		</tr>
			<tr>
			<td class="tab22" width="76px">&nbsp;</td>
  	  <td class="tab21" width="93px">&nbsp;</td>
			<td class="tab11" width="76px" bgcolor="#eeeeee">���ּ�</td>
  	  <td class="tab22" width="436px">
				<input type="text" id=txt_oaddr02 class="txt11" style="width:350px;" maxlength="70" onBlur="bytelength(this,this.value,70);">
			</td>
  	</tr>
		<tr>
			<td colspan="4">
				<table cellpadding=0 cellspacing=0 border=0>
					<tr>
					  <td class="tab11" width="75px" bgcolor="#eeeeee">����ó</td>
					  <td class="tab22">&nbsp;(TEL)</td>
						<td class="tab22"><input type="text" id=txt_telno class="txt11" style="width:90px;" maxlength="15" onBlur="bytelength(this,this.value,15);"></td>
						<td class="tab22">&nbsp;&nbsp;(�系)</td>
						<td class="tab22"><input type="text" id=txt_offtelno class="txt11" style="width:65px;" maxlength="4" onBlur="bytelength(this,this.value,4);"></td>
						<td class="tab22">&nbsp;&nbsp;(H/P)</td>
						<td class="tab21" width="95px"><input type="text" id=txt_hpno class="txt11" style="width:85px;" maxlength="15" onBlur="bytelength(this,this.value,15);"></td>
		  		  <td class="tab11" width="75px" bgcolor="#eeeeee">eMail</td>
					  <td class="tab22" width="162px"><input type="text" id=txt_email class="txt11" style="width:140px;" maxlength="30" onBlur="bytelength(this,this.value,30);"></td>
					</tr>
				</table>
			</td>
		</tr>
			<!--	</table>
			</td>
		</tr> -->
	</table>
	<table style="position:relative;top:4px;border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td class="tab11" width="75px" bgcolor="#eeeeee">��Ÿ����</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">���</td>
			<td class="tab21" width="130px"><input type="text" id=txt_hobby class="txt11" style="width:100px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">Ư��</td>
			<td class="tab21" width="115px"><input type="text" id=txt_special class="txt11" style="width:100px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
			<td class="tab11" width="81px" bgcolor="#eeeeee">����</td>
			<td class="tab22" width="140px">
				<comment id="__NSID__"><OBJECT id=gclx_rilign classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
						<param name=ComboDataID			value="gcds_rilign">
						<param name=CBDataColumns		value="MINORCD, MINORNM">
						<param name=SearchColumn		value=MINORNM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="MINORNM^0^100">
						<param name=BindColumn			value=MINORCD>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		<tr>
			<td class="tab12">&nbsp;</td>
			<td class="tab11" bgcolor="#eeeeee">��ȥ���</td>
			<td class="tab21">
				<comment id="__NSID__"><OBJECT id=gcem_mrydt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
		    </OBJECT></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_mrydt', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
			</td>
			<td class="tab11" bgcolor="#eeeeee">�ǰ�����</td>
			<td class="tab21">
				<comment id="__NSID__"><OBJECT id=gcem_inscod classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="position:relative; left:8px;top:2px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
						<param name=Alignment			value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Maxlength     value="5">
		    </OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;���
			</td>
			<td class="tab11" bgcolor="#eeeeee">���ο���</td>
			<td class="tab22">
				<comment id="__NSID__"><OBJECT id=gcem_pencod classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="position:relative; left:8px;top:2px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
						<param name=Alignment			value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Maxlength     value="5">
		    </OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;���
			</td>
		</tr>
		<tr>
			<td class="tab11">&nbsp;</td>
			<td class="tab11" bgcolor="#eeeeee">��������</td>
			<td class="tab21">
				<comment id="__NSID__"><OBJECT id=gcra_labuniyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="position:relative;left:4px;top:0px;height:20;width:120;cursor:hand;">
						<param name=Cols     value="2">
	          <param name=Format   value="1^����,2^�����">
        </OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" bgcolor="#eeeeee">���ƴ��</td>
			<td class="tab21">
				<comment id="__NSID__"><OBJECT id=gclx_mrtdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
						<param name=ComboDataID			value="gcds_mrtdiv">
						<param name=CBDataColumns		value="MINORCD, MINORNM">
						<param name=SearchColumn		value=MINORNM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="MINORNM^0^100">
						<param name=BindColumn			value=MINORCD>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" bgcolor="#eeeeee">��ֱ���</td>
			<td class="tab22">
				<comment id="__NSID__"><OBJECT id=gcra_hitchyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="position:relative;left:4px;top:0px;height:20;width:120;cursor:hand;">
						<param name=Cols     value="2">
	          <param name=Format   value="Y^��,N^�ƴϿ�">
        </OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
	</table>

	<table style="position:relative;top:8px;border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td class="tab11" width="75px" bgcolor="#eeeeee">�޿�</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">����</td>
			<td class="tab21" width="130px;">
				<comment id="__NSID__"><OBJECT id=gclx_paybnkcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
						<param name=ComboDataID			value="gcds_paybnkcd">
						<param name=CBDataColumns		value="MINORCD, MINORNM">
						<param name=SearchColumn		value=MINORNM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="MINORNM^0^100">
						<param name=BindColumn			value=MINORCD>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">���¹�ȣ</td>
			<td class="tab21" width="115px">
				<comment id="__NSID__"><OBJECT id=gcem_payacnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="position:relative; left:8px;top:1px; width:100px; height:20px; font-family:����; fontsize:9pt;z-index:2; " class=txtbox>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00000000000000000000">
						<param name=PromptChar	  value="_">
		    </OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" width="80px" bgcolor="#eeeeee">������</td>
			<td class="tab22"width="141px">
				<comment id="__NSID__"><OBJECT id=gcra_gygb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="position:relative;left:4px;top:0px;height:20;width:120;cursor:hand;">
						<param name=Cols     value="2">
	          <param name=Format   value="Y^��,N^�ƴϿ�">
        </OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 2] �������� �׸���----------->
<div id="layer2" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_2" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('02')">
				<img name="btn_add_2" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('02')">
				<img name="btn_save_2" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('02')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:239">
            <param name=dataid					value=gcds_data02>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=true>
						<param name=AllShowEdit     value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	align=right </F> 
							<C> Name=����			ID=REFCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=67,	align=left,		EditStyle=Lookup, Data="gcds_hdfamret:minorcd:minornm"</C> 
							<C> Name=����			ID=FAMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=74,	align=left</C> 
							<F> Name=�ֹι�ȣ ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=100, align=center	MASK="XXXXXX-XXXXXXX"</F> 
						 	<C> Name=�з�			ID=LSTEDC		HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	align=left,		EditStyle=Lookup, Data="gcds_edccd:minorcd:minornm" </C> 
							<C> Name=����			ID=CMPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=87,	align=left</C> 
							<C> Name=����			ID=LIVEYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=57,	align=center,	EditStyle=combo,	Data="1:����,2:�񵿰�"</C> 
							<C> Name=�ξ�			ID=SPTYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=57,	align=center,	EditStyle=combo,	Data="1:�ξ�,2:�Ǻξ�"</C> 
							<C> Name=���			ID=DISYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=47,	align=center,	EditStyle=combo,	Data="1:��,2:��"</C> 
							<C> Name=�Ǻ�			ID=MEDINYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=42,	align=center,	EditStyle=combo,	Data="1:��,2:��"</C> 
							<C> Name=����			ID=PAYYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=42		align=center,	EditStyle=combo,	Data="1:��,2:��"</C> 
						'>
			  </OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 3] ��»��� �׸���----------->
<div id="layer3" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_3" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('03')">
				<img name="btn_add_3" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('03')">
				<img name="btn_save_3" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('03')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:239">
            <param name=dataid					value=gcds_data03>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=true>
						<param name=AllShowEdit     value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC  Align=right Width=30 </F> 
							<G> Name="�ٹ��Ⱓ ex)20000101" HeadBgColor=#B9D4DC
		 						<C> Name=�Ի���		ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75 Align=center Mask="XXXX/XX/XX"</C> 
								<C> Name=�����		ID=ENDDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=75 Align=center Mask="XXXX/XX/XX"</C> 
	            </G>
							<C> Name=ȸ���			ID=CAPLACE	HeadAlign=Center HeadBgColor=#B9D4DC Width=154 Align=left</C> 
							<C> Name=������			ID=POSINM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  Align=left</C> 
							<C> Name=������		ID=DUTYNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=150 Align=left</C>
							<C> Name=��������		ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Align=left</C>
						'> 
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt3 style="position:relative;top:4px;"></font>
				</fieldset>
		  </td>
		</tr>
  </table>
</div>

<!---------[TAB 4] �ڰݸ������ �׸���----------->
<div id="layer4" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_4" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('04')">
				<img name="btn_add_4" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('04')">
				<img name="btn_save_4" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('04')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:239">
            <param name=dataid					value=gcds_data04>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=true>
						<param name=AllShowEdit     value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	align=right </F> 
							<C> Name=������� ID=GETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center, Mask="XXXX/XX/XX"</C> 
							<C> Name=�ڰݱ��� ID=LCSCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left,		EditStyle=Lookup, Data="gcds_lcscd:minorcd:minornm"</C> 
							<C> Name=�ڰ����� ID=LCSTYPE	HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left,		EditStyle=Lookup, Data="gcds_lcstype:minorcd:minornm"</C> 
							<C> Name=����ȣ   ID=LCSNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center </C> 
							<C> Name=����ó   ID=ISSPART	HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=left </C> 
              <C> Name=����			ID=APPYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=45,	align=center,	EditStyle=combo,	Data="0:��,3:��,1:1��,2:2��,6:Ư��,4:����,5:�Ϲ�"</C> 
            '>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt4 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

  <!---------[TAB 5] �з»��� �׸���----------->
<div id="layer5" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_5" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('05')">
				<img name="btn_add_5" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('05')">
				<img name="btn_save_5" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('05')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:239">
            <param name=dataid					value=gcds_data05>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=true>
						<param name=AllShowEdit     value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
				 			<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30, align=right</F>
							<G> Name=�����Ⱓ HeadBgColor=#B9D4DC
								<C> Name=���г⵵ ID=STRYY	HeadAlign=Center HeadBgColor=#B9D4DC Width=80, align=center</C> 
								<C> Name=�����⵵ ID=GRAYY	HeadAlign=Center HeadBgColor=#B9D4DC Width=80, align=center</C> 
							</G>
							<C> Name=�б���		ID=SCHNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=195 </C> 
							<C> Name=�з�			ID=EDCCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=95		EditStyle=Lookup, data="gcds_hieduc:minorcd:minornm" </C> 
							<C> Name=����			ID=PGCCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=119	Editstyle=LookUp, data="gcds_pieduc:minorcd:minornm"</C> 
							<C> Name=����			ID=EDCDIV HeadAlign=Center HeadBgColor=#B9D4DC Width=85		Editstyle=LookUp, data="gcds_gieduc:minorcd:minornm"</C> 
            '>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt4 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 6] �ſ�����/��ü����/���� ----------->
<div id="layer6" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td width="100px;">&nbsp;<b>����/��ü����</b></td>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_5" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Cancel()">
				<img name="btn_save_5" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('06')">
		  </td>
			<td width="4px;"></td>
		</tr>
		<tr>	
			<td colspan="3">
				<table border="0" cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-top-width:1px">
					<tr>
						<!--
						<td class="tab11" width="75px" bgcolor="#eeeeee">��������</td>
						<td class="tab21" width="100px;">
	 						<comment id="__NSID__"><OBJECT id=gclx_assgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
									<param name=CBData					value="1^�κ���,2^��������">
									<param name=CBDataColumns		value="Code, Parm">
									<param name=SearchColumn		value="Parm">
									<param name=Sort						value="false">
									<param name=ListExprFormat	value="Parm^0^100">
									<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						-->
						<td class="tab11" width="75px" bgcolor="#eeeeee">�����Ⱓ</td>
						<td class="tab21" width="230px;">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="100px;" height="25px">&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_afrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
												<param name=Alignment			value=0>
												<param name=Border	      value=true>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
										<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_afrdt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
									</td>
									<td align=center>&nbsp;~&nbsp;</td>
									<td>
										<comment id="__NSID__"><OBJECT id=gcem_atodt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
												<param name=Alignment			value=0>
												<param name=Border	      value=true>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
										<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_atodt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
									</td>
								</tr>
							</table>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">�����ݾ�</td>
						<td class="tab22" width="318px;">
							<comment id="__NSID__"><OBJECT id=gcem_assamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Maxlength     value="9">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
				</table>				
				<table border="0" cellpadding="0" cellspacing="0">
					<!--
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">�κ���</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">����</td>
						<td class="tab21" width="149px;"><input type="text" id=txt_assname class="txt11" style="width:100px;"></td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">����</td>
						<td class="tab21" width="125px;">
	 						<comment id="__NSID__"><OBJECT id=gclx_assrela classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
									<param name=ComboDataID			value="gcds_assret">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">�ֹι�ȣ</td>
						<td class="tab22" width="120px;">
							<comment id="__NSID__"><OBJECT id=gcem_assresino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:1px; width:92px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="000000-0000000">
									<param name=PromptChar	  value="_">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td class="tab11" >&nbsp;</td>
						<td class="tab11" bgcolor="#eeeeee">����ó</td>
						<td class="tab21"><input type="text" id=txt_asstelno class="txt11" style="width:100px;"></td>
						<td class="tab11" bgcolor="#eeeeee">�ּ�</td>
						<td class="tab22" colspan="3">
							<comment id="__NSID__"><OBJECT id=gcem_asspostno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:3px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="000-000">
									<param name=PromptChar	  value="_">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
							<input type="text" id=txt_assaddr class="txt11" style="position:relative;top:-3px;left:10px;width:250px;">
						</td>
					</tr>
					-->
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">�������</td>
						<td class="tab21" width="230px" ><input type="text" id=txt_assinst class="txt11" style="width:200px;" maxlength="50" onBlur="bytelength(this,this.value,50);"></td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">���ǹ�ȣ</td>
						<td class="tab21" width="145px" >
							<comment id="__NSID__"><OBJECT id=gcem_assno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:1px; width:128px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="00000000000000000000">
									<param name=PromptChar	  value="_">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="75" bgcolor="#eeeeee">���αݾ�</td>
						<td class="tab22" width="95px">
							<comment id="__NSID__"><OBJECT id=gcem_recpamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:1px; width:82px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Maxlength     value="14">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  <table cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;border:1 solid #708090;border-bottom-width:0px;">
		<tr>	
			<td colspan="3">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">�������</td>
						<td class="tab21" width="150px;"><input type="text" id=txt_hospital class="txt11" style="width:130px;" maxlength="20" onBlur="bytelength(this,this.value,20);"></td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">��������</td>
						<td class="tab22" width="100px;" colspan="3">
							<comment id="__NSID__"><OBJECT id=gcem_hosdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_hosdt', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
					</tr>
					<tr>
						<td class="tab11" bgcolor="#eeeeee">�Ұ�</td>
						<td class="tab22" width="220px;" colspan="5"><input type="text" id=txt_hosmemo class="txt11" style="width:205px;" maxlength="50" onBlur="bytelength(this,this.value,50);"></td>
					</tr>
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">����/ü��</td>
						<td class="tab21" width="150px;">
							<comment id="__NSID__"><OBJECT id=gcem_height classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:2px; width:25px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Maxlength     value="3">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:8px;top:0px;">Cm</span>
							<comment id="__NSID__"><OBJECT id=gcem_weight classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:20px;top:2px; width:25px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Maxlength     value="3">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:22px;top:0px;">Kg</span>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">������</td>
						<td class="tab21" width="100px;">
							<comment id="__NSID__"><OBJECT id=gcem_blood classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:2px; width:25px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="AA">
									<param name=PromptChar	  value="_">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:10px;top:-2px;">��</span>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">�÷�</td>
						<td class="tab22" width="220px;">
							<span style="position:relative;left:8px;top:-3px;">��</span>
							<comment id="__NSID__"><OBJECT id=gcem_eyel classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:12px;top:2px; width:25px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment				value=0>
									<param name=Border					value=true>
									<param name=PromptChar			value="_">
									<param name=MaxLength       value=2>
                  <param name=MaxDecimalPlace value=1>
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:16px;top:-3px;">��</span>
							<comment id="__NSID__"><OBJECT id=gcem_eyer classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:21px;top:2px; width:25px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment				value=0>
									<param name=Border					value=true>
									<param name=PromptChar			value="_">
									<param name=MaxLength       value=2>
                  <param name=MaxDecimalPlace value=1>
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">����</td>
						<td class="tab21" width="150px;">
	 						<comment id="__NSID__"><OBJECT id=gclx_colblnyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
									<param name=ComboDataID			value="gcds_colblnyn">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">�������</td>
						<td class="tab21" width="100px;">
							<comment id="__NSID__"><OBJECT id=gcra_hosrevit classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:20;width:90;cursor:hand;">
									<param name=Cols     value="2">
						      <param name=Format   value="1^Y,2^N">
			        </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">��ֵ��</td>
						<td class="tab22" width="220px;">
	 						<!-- <comment id="__NSID__"><OBJECT id=gclx_disdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:115px;height:200px;">
									<param name=ComboDataID			value="gcds_disdiv">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script> -->
	 						<comment id="__NSID__"><OBJECT id=gclx_disgrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:80px;height:200px;">
									<param name=ComboDataID			value="gcds_disgrd">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  <table style="position:relative;top:5px;border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td width="100px;">&nbsp;<b>��������</b></td>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_save_5" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('052')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="border:0 solid #708090;border-top-width:1px" colspan="3">
				<table border="0" cellpadding=0 cellspacing=0>
					<tr>
						<td class="tab11" width="80px" bgcolor="#eeeeee">����</td>
            <td class="tab21" width="100px">
	 						<comment id="__NSID__"><OBJECT id=gclx_milidiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
								<param name=ComboDataID			value="gcds_milidiv">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="90px" bgcolor="#eeeeee">��������</td>
            <td class="tab21" width="240px"><INPUT type="text" id=txt_nmreason class="txt11" style="width:170px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
						<td class="tab11" width="80px" bgcolor="#eeeeee">����</td>
						<td class="tab22" width="110px">
	 						<comment id="__NSID__"><OBJECT id=gclx_militgbn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
									<param name=ComboDataID			value="gcds_militgbn">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
          </tr>
					<tr>
						<td class="tab11" bgcolor="#eeeeee">���</td>
            <td class="tab21">
	 						<comment id="__NSID__"><OBJECT id=gclx_miligrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
								<param name=ComboDataID			value="gcds_miligrd">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" bgcolor="#eeeeee">�����Ⱓ</td>
            <td class="tab21" >
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="100px;" height="25px">&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_milifrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
												<param name=Alignment			value=0>
												<param name=Border	      value=true>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
										<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_milifrdt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"> -->
									</td>
									<td align=center>&nbsp;~&nbsp;</td>
									<td>
										<comment id="__NSID__"><OBJECT id=gcem_militodt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
												<param name=Alignment			value=0>
												<param name=Border	      value=true>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
										<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_militodt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"> -->
									</td>
									<td width="100%">&nbsp;</td>
								</tr>
							</table>
						</td>
						<td class="tab11" bgcolor="#eeeeee">����</td>
						<td class="tab22" >
	 						<comment id="__NSID__"><OBJECT id=gclx_militype classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
								<param name=ComboDataID			value="gcds_militype">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td class="tab11" width="80px" bgcolor="#eeeeee">����</td>
            <td class="tab21" width="100px">
	 						<comment id="__NSID__"><OBJECT id=gclx_milispec classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
								<param name=ComboDataID			value="gcds_milispec">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="90px" bgcolor="#eeeeee">��������</td>
            <td class="tab22" width="430px" colspan="3">
							<comment id="__NSID__"><OBJECT id=gcra_miligbn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:20;width:350;cursor:hand;">
									<param name=Cols     value="3">
						      <param name=Format   value="1^���� �����,2^�ι��� �����,3^�� �����">
			        </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<!--
						<td class="tab11" width="90px" bgcolor="#eeeeee">����</td>
            <td class="tab22" width="430px" colspan="3">
							<comment id="__NSID__"><OBJECT id=gcem_milino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:8px;top:2px; width:130px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=txtbox>
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="000000000000000">
									<param name=PromptChar	  value="_">
					    </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						-->
          </tr>
				</table>
			</td>
		</tr>
	</table>

</div>

<!---------[TAB 7] �系��� �׸���----------->
<div id="layer7" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_7" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('07')">
				<img name="btn_add_7" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('07')">
				<img name="btn_save_7" src="../../Common/img/btn/com_b_save.gif"  style="position:relative;top:2px;cursor:hand" onclick="ln_Save('07')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;" style="border:0 solid #708090;border-top-width:1px;" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp07 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:240">
            <param name=dataid					value=gcds_data07>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=1>
						<param name=Editable        value=1>
						<param name=AllShowEdit     value=1>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO ID={CurRow}				HeadAlign=Center HeadBgColor=#B9D4DC Width=30,  align=right </F> 
							<F> Name=�߷�����		ID=ORDDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=68,	align=center,			MASK="XXXX/XX/XX"</F> 
						 	<C> Name=�߷ɱ���		ID=ORDCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=85,	EditStyle=Lookup, Data="gcds_ordcd:ordcd:ordnm" </C> 
							<C> Name=�Ҽ�				ID=DEPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=120 </C> 
							<C> Name=����				ID=PAYGRD HeadAlign=Center HeadBgColor=#B9D4DC Width=80,  EditStyle=Lookup, Data="gcds_deptlvl:minorcd:minornm"</C>
							<C> Name=ȣ��				ID=PAYSEQ HeadAlign=Center HeadBgColor=#B9D4DC Width=40,	EditStyle=Lookup, Data="gcds_payseq:minorcd:minornm" </C>
							<C> Name=����				ID=GRDDIV HeadAlign=Center HeadBgColor=#B9D4DC Width=55,	EditStyle=Lookup, Data="gcds_grddiv:minorcd:minornm"</C>
							<C> Name=������			ID=ENDDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=68,	align=center,			Mask="XXXX/XX/XX" show=false </C>
							<C> Name=�λ�������	ID=APPDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=68,	align=center,			Mask="XXXX/XX/XX" </C>
							<C> Name=���	      ID=ETC	  HeadAlign=Center HeadBgColor=#B9D4DC Width=138,	align=left,			</C>
						'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<!-- Data="gcds_dept:deptcd:deptnm"</C> -->
<!--
							<C> Name=����			ID= HeadAlign=Center HeadBgColor=#B9D4DC Width=70 </C>
					    <C> Name=�߷ɻ��� ID= HeadAlign=Center HeadBgColor=#B9D4DC Width=170 </C>
-->
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt7 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 8] ����+����----------->
<div id="layer8" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td width="100px;">&nbsp;</td>
			<td height="25px" align="right" valign="bottom">
				<!--
				<img name="btn_del_8" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="">
				<img name="btn_save_8" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="">
				-->
		  </td>
			<td width="4px;"></td>
		</tr>
		<tr>
			<td colspan="3">
				<table border=0 cellspacing=0 cellpadding=0>
					<tr>
						<td>
							<table border="0" cellpadding=0 cellspacing=0  border=0 style="border:0 solid #708090;border-top-width:1px;">
								<tr>
									<td class="tab11" width="100px" bgcolor="#eeeeee">�� 1 �ܱ���</td>
									<td class="tab11" width="100px" bgcolor="#eeeeee">����</td>
									<td class="tab21" width="80px;">
										<comment id="__NSID__"><OBJECT id=gcem_toescr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<param name=Maxlength		  value="4">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="100px" bgcolor="#eeeeee">����</td>
									<td class="tab22" width="316px;">
										<comment id="__NSID__"><OBJECT id=gcem_tofscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<param name=Maxlength		  value="4">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td class="tab11" bgcolor="#eeeeee">�� 2 �ܱ���</td>
									<td class="tab11" bgcolor="#eeeeee">JPT</td>
									<td class="tab21">
										<comment id="__NSID__"><OBJECT id=gcem_jptscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<param name=Maxlength		  value="4">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" bgcolor="#eeeeee">HSK</td>
									<td class="tab22">
										<comment id="__NSID__"><OBJECT id=gcem_hskscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<param name=Maxlength		  value="4">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>	
									<td class="tab11" bgcolor="#eeeeee">��Ÿ �ܱ���</td>
									<td class="tab22" colspan=4><input id="txt_etclng" name="txt_etclng" type="text" class="txt11" style="width:580px;" maxlength="50" onBlur="bytelength(this,this.value,50);"></td>
								</tr>

								<!--
								<tr>
									<td class="tab11" width="100px" bgcolor="#eeeeee">����</td>
									<td class="tab21" width="100px;">
										<comment id="__NSID__"><OBJECT id=gclx_englvl classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
												<param name=ComboDataID			value="gcds_englvl">
												<param name=CBDataColumns		value="MINORCD, MINORNM">
												<param name=SearchColumn		value=MINORNM>
												<param name=Sort						value=false>
												<param name=ListExprFormat	value="MINORNM^0^100">
												<param name=BindColumn			value=MINORCD>
				 						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="85px" bgcolor="#eeeeee">����</td>
									<td class="tab21" width="80px;">
										<comment id="__NSID__"><OBJECT id=gcem_toescr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="0000">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="85px" bgcolor="#eeeeee">JPT</td>
									<td class="tab21" width="80px;">
										<comment id="__NSID__"><OBJECT id=gcem_jptscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="0000">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="85px" bgcolor="#eeeeee">DELF</td>
									<td class="tab22" width="80px;">
										<comment id="__NSID__"><OBJECT id=gcem_delfscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="0000">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td class="tab11" bgcolor="#eeeeee">����</td>
									<td class="tab21">
										<comment id="__NSID__"><OBJECT id=gcem_tofscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="0000">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" bgcolor="#eeeeee">DALF</td>
									<td class="tab21">
										<comment id="__NSID__"><OBJECT id=gcem_dalfscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="0000">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" bgcolor="#eeeeee">TEPS</td>
									<td class="tab22" colspan="3">
										<comment id="__NSID__"><OBJECT id=gcem_tepsscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="0000">
												<param name=PromptChar	  value="_">
								    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td class="tab11" bgcolor="#eeeeee">��Ÿ �ܱ���</td>
									<td class="tab22" colspan=7><input id="txt_etclng" name="txt_etclng" type="text" class="txt11" style="width:300px;"></td>
								</tr>
								-->
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  <table  cellpadding=0 cellspacing=0 border=0 style="position:relative;top:5px;border:1 solid #708090;border-bottom-width:0px;">
		<tr>
			<td>
				<table border=0 cellspacing=0 cellpadding=0>
					<tr>
						<td>
							<table cellpadding=0 cellspacing=0  border=0>
								<tr>
									<td class="tab11" width="70px;" bgcolor="#eeeeee">�ѱ�</td>
									<td class="tab21" width="100px;">
			   						<comment id="__NSID__"><OBJECT id=gclx_hwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			  						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="75px;" bgcolor="#eeeeee">����</td>
									<td class="tab21" width="100px;">
			   						<comment id="__NSID__"><OBJECT id=gclx_exgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			  								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			   						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="75px;" bgcolor="#eeeeee">�Ŀ�����Ʈ</td>
									<td class="tab21" width="100px;">
			   						<comment id="__NSID__"><OBJECT id=gclx_pwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			   						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="75px;" bgcolor="#eeeeee">������</td>
									<td class="tab22" width="100px;">
			  						<comment id="__NSID__"><OBJECT id=gclx_acgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			   						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr><td class="tab22" height="154px;">&nbsp;</td></tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 9] �系����+�λ���----------->
<div id="layer9" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_9" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('09')">
				<img name="btn_add_9" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('09')">
				<img name="btn_save_9" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('09')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp09 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:240">
            <param name=dataid					value=gcds_data09>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value="
							<F> Name=NO ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right  </F> 
							<C> Name=������ ID=EVAYM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 Mask='XXXX/XX', align=center </C> 
							<C> Name=�Ҽ�			ID=DEPTNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=230,  </C> 
						 	<C> Name=�Ҽ�			ID=DEPTCD  HeadAlign=Center HeadBgColor=#B9D4DC Width=250, EditStyle=lookup, Data='gcds_dept:deptcd:deptnm'  show=false</C> 
							<C> Name=����			ID=PAYGRD HeadAlign=Center HeadBgColor=#B9D4DC Width=80, EditStyle=lookup, Data='gcds_deptlvl:minorcd:minornm' </C>
							<C> Name=����			ID=TOTAVG HeadAlign=Center HeadBgColor=#B9D4DC Width=80, align=right, show=false</C> 							
									<C> Name=������		ID=GRADE3 HeadAlign=Center HeadBgColor=#B9D4DC Width=160 ,align=center</C>
									
						">

 <!-- 1/20�� ��� �Ⱥ��̰� ����, �� ID=AVG1 , ID=AVG2, ID=AVG3,  ID=GOGAGB -->

				</OBJECT></comment><script>__ws__(__NSID__);</script>
       
			 	<!-- <C> Name=�Ҽ�			ID=DEPTCD HeadAlign=Center HeadBgColor=#B9D4DC Width=250, EditStyle=lookup, Data="gcds_dept:deptcd:deptnm" </C> 
 -->
				<!--
							<C> Name=������		ID=WRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 Mask="XXXX/XX/XX", align=center</C>
				-->
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt9 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 10] ��������----------->
<div id="layer10" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_10" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('10')">
				<img name="btn_add_10" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('10')">
				<img name="btn_save_10" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('10')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp10 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:100">
            <param name=dataid					value=gcds_data10>
						<param Name=Editable				value=true> 
						<param Name=AllShowEdit			value=true> 
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO					ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,  align=right </F> 
							<C> Name=������			ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	align=center, MASK="XXXX/XX/XX"</C>
							<C> Name=������			ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	align=center, MASK="XXXX/XX/XX"</C>
							<C> Name=�����ϼ�,	ID=EDUDAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=50,	align=right </C>
							<F> Name=��������		ID=SUBJECT	HeadAlign=Center HeadBgColor=#B9D4DC Width=160,	align=left</F> 
						 	<C> Name=�������		ID=EDUINST	HeadAlign=Center HeadBgColor=#B9D4DC Width=135,	align=left </C> 
							<C> Name=������		ID=EDUPLC		HeadAlign=Center HeadBgColor=#B9D4DC Width=150, align=left </C> 
						'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt10 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>

<!---------[TAB 10] (����/����)----------->
	<table border=0 cellspacing=0 cellpadding=0>
	<tr><td height="10px">&nbsp;</td></tr>
	<tr>
		<td class="tab32" height="29px">&nbsp;<b>����/����</b></td>
	</tr>
		<tr>
			<td>
				<table border="0" cellpadding=0 cellspacing=0  border=0 style="border:0 solid #708090;border-top-width:1px;">
					<tr>
						<td class="tab33" width="100px" bgcolor="#eeeeee">�� 1 �ܱ���</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee">����</td>
						<td class="tab21" width="80px;">
							<comment id="__NSID__"><OBJECT id=gcem_toescr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value=true>
									<param name=Maxlength		  value="4">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee">����</td>
						<td class="tab11" width="316px;">
							<comment id="__NSID__"><OBJECT id=gcem_tofscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value=true>
									<param name=Maxlength		  value="4">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td class="tab33" bgcolor="#eeeeee">�� 2 �ܱ���</td>
						<td class="tab11" bgcolor="#eeeeee">JPT</td>
						<td class="tab21">
							<comment id="__NSID__"><OBJECT id=gcem_jptscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value=true>
									<param name=Maxlength		  value="4">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" bgcolor="#eeeeee">HSK</td>
						<td class="tab11">
							<comment id="__NSID__"><OBJECT id=gcem_hskscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:����; font-size:9pt;">
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value=true>
									<param name=Maxlength		  value="4">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>	
						<td class="tab33" bgcolor="#eeeeee">��Ÿ �ܱ���</td>
						<td class="tab11" colspan=4><input id="txt_etclng" name="txt_etclng" type="text" class="txt11" style="width:580px;position:relative;left:-3px" maxlength="50" onBlur="bytelength(this,this.value,50);"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
		
  <table  cellpadding=0 cellspacing=0 border=0 style="position:relative;top:5px;border:1 solid #708090;border-bottom-width:0px;">
		<tr>
			<td>
				<table border=0 cellspacing=0 cellpadding=0>
					<tr>
						<td>
							<table cellpadding=0 cellspacing=0  border=0>
								<tr>
									<td class="tab11" width="70px;" bgcolor="#eeeeee">�ѱ�</td>
									<td class="tab21" width="100px;">
			   						<comment id="__NSID__"><OBJECT id=gclx_hwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			  						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="75px;" bgcolor="#eeeeee">����</td>
									<td class="tab21" width="100px;">
			   						<comment id="__NSID__"><OBJECT id=gclx_exgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			  								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			   						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="75px;" bgcolor="#eeeeee">�Ŀ�����Ʈ</td>
									<td class="tab21" width="100px;">
			   						<comment id="__NSID__"><OBJECT id=gclx_pwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			   						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="75px;" bgcolor="#eeeeee">������</td>
									<td class="tab22" width="100px;">
			  						<comment id="__NSID__"><OBJECT id=gclx_acgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^��,2^��,3^��">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
			   						</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 11] ������� ----------->
<div id="layer11" style="position:absolute; top:330px; left:350px; width:700px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_del_11" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('11')">
				<img name="btn_add_11" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('11')">
				<img name="btn_save_11" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('11')">
		  </td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp11 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:240">
            <param name=dataid					value=gcds_data11>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=Editable				value=true>
						<param name=AllShowEdit     value=true>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO					ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=50,  align=right </F> 
							<C> Name=��������		ID=RECDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=120,	align=center, MASK="XXXX/XX/XX"</C>
							<C> Name=�������		ID=REWGB		HeadAlign=Center HeadBgColor=#B9D4DC Width=250,	align=left, editstyle="Lookup" data="gcds_rewgbn:minorcd:minornm"</C>
							<C> Name=�������,	ID=REWKIND	HeadAlign=Center HeadBgColor=#B9D4DC Width=265,	align=left, editstyle="Lookup" data="gcds_rewkin:minorcd:minornm" </C>
						'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:700;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt11 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!-- <comment id="__NSID__"><OBJECT id=gcbn_data07 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data07">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=DEPTCD		Ctrl=gclx_deptcd	Param=BindColVal</C>
		<C>Col=PAYGRD		Ctrl=gclx_deptlvl	Param=BindColVal</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>
 -->

<!-- ����Ÿ���ε� ���Ǻκ� -->    
<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data00">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=EMPNMK		Ctrl=txt_empnmk				Param=Value</C>
		<C>Col=NMC			Ctrl=txt_empnmc				Param=Value</C>
		<C>Col=NME			Ctrl=txt_empnme				Param=Value</C>
		<C>Col=EMPNO		Ctrl=txt_empno				Param=Value</C>
		<C>Col=RESINO		Ctrl=gcem_resino			Param=Text</C>
		<C>Col=BIRDT		Ctrl=gcem_birdt				Param=Text</C>
		<C>Col=GLDIV		Ctrl=gcra_gldiv				Param=CodeValue</C>
		<C>Col=DEPTCD		Ctrl=gclx_deptcd			Param=BindColVal</C>
		<C>Col=PAYGRD		Ctrl=gclx_deptlvl			Param=BindColVal</C>
		<C>Col=GRDDIV		Ctrl=gclx_grddiv			Param=BindColVal</C>
		<C>Col=LAMDT 		Ctrl=gcem_lamdt  			Param=Text</C>
		<C>Col=JOBDTY		Ctrl=gclx_jobgrph			Param=BindColVal</C>
		<C>Col=OZIPCD		Ctrl=gcem_ozipcd			Param=Text</C>
		<C>Col=CZIPCD		Ctrl=gcem_czipcd			Param=Text</C>
		<C>Col=OADDR01	Ctrl=txt_oaddr01			Param=Value</C>
		<C>Col=OADDR02	Ctrl=txt_oaddr02			Param=Value</C>
		<C>Col=CADDR01	Ctrl=txt_caddr01			Param=Value</C>
		<C>Col=CADDR02	Ctrl=txt_caddr02			Param=Value</C>
		<C>Col=TELNO		Ctrl=txt_telno				Param=Value</C>
		<C>Col=HPNO			Ctrl=txt_hpno					Param=Value</C>
		<C>Col=OFFTELNO	Ctrl=txt_offtelno			Param=Value</C>
		<C>Col=EMAIL		Ctrl=txt_email				Param=Value</C>

		<C>Col=DPOFFDT	Ctrl=gcem_dpoffdt			Param=Text</C>
		<C>Col=TODT			Ctrl=gcem_todt				Param=Text</C>
		<C>Col=STRTDT		Ctrl=gcem_strtdt			Param=Text</C>
		<C>Col=ENDDT		Ctrl=gcem_enddt				Param=Text</C>
		<C>Col=HITCHYN	Ctrl=gcra_hitchyn			Param=CodeValue</C>

		<C>Col=HDFAMNM 	Ctrl=txt_hdfamnm  		Param=Value</C>
		<C>Col=HDFAMRET	Ctrl=gclx_hdfamret 		Param=BindColVal</C>
		<C>Col=HDFAMJOB	Ctrl=txt_hdfamjob 		Param=Value</C>
		<C>Col=EDCCD   	Ctrl=gclx_edccd   		Param=BindColVal</C>
		<C>Col=EMPDIV  	Ctrl=gclx_empdiv  		Param=BindColVal</C>
		<C>Col=RECDIV 	Ctrl=gclx_recdiv 			Param=BindColVal</C>
		<C>Col=HOBBY   	Ctrl=txt_hobby    		Param=Value</C>
		<C>Col=SPECIAL 	Ctrl=txt_special  		Param=Value</C>
		<C>Col=RILIGN  	Ctrl=gclx_rilign  		Param=BindColVal</C>
		<C>Col=MRYDT   	Ctrl=gcem_mrydt   		Param=Text</C>
		<C>Col=INSCOD		Ctrl=gcem_inscod 			Param=Text</C>
		<C>Col=PENCOD		Ctrl=gcem_pencod 			Param=Text</C>
		<C>Col=LABUNIYN	Ctrl=gcra_labuniyn		Param=codevalue</C>
		<C>Col=MRTDIV  	Ctrl=gclx_mrtdiv  		Param=BindColVal</C>
		<C>Col=PAYBNKCD	Ctrl=gclx_paybnkcd		Param=BindColVal</C>
		<C>Col=PAYACNT 	Ctrl=gcem_payacnt  		Param=Text</C>

		<C>Col=ENGLVL		Ctrl=gclx_englvl			Param=BindColVal</C>
		<C>Col=TOESCR 	Ctrl=gcem_toescr  		Param=Text</C>
		<C>Col=JPTSCR 	Ctrl=gcem_jptscr  		Param=Text</C>
		<C>Col=DELFSCR 	Ctrl=gcem_delfscr  		Param=Text</C>
		<C>Col=TOFSCR 	Ctrl=gcem_tofscr  		Param=Text</C>
		<C>Col=DALFSCR 	Ctrl=gcem_dalfscr  		Param=Text</C>
		<C>Col=TEPSSCR 	Ctrl=gcem_tepsscr  		Param=Text</C>
		<C>Col=ETCLNG 	Ctrl=txt_etclng  			Param=Value</C>
		<C>Col=HSKSCR 	Ctrl=gcem_hskscr  		Param=Text</C>

		<C>Col=HWGRDCD 	Ctrl=gclx_hwgrdcd			Param=BindColVal</C>
		<C>Col=EXGRDCD 	Ctrl=gclx_exgrdcd			Param=BindColVal</C>
		<C>Col=PWGRDCD 	Ctrl=gclx_pwgrdcd			Param=BindColVal</C>
		<C>Col=ACGRDCD 	Ctrl=gclx_acgrdcd			Param=BindColVal</C>
		<C>Col=PICFILE 	Ctrl=txt_file		  		Param=Value</C>

		<C>Col=ORDDT 		Ctrl=gcem_orddt  			Param=Text</C>
		<C>Col=RELATNM 	Ctrl=txt_relatnm  		Param=Value</C>
		<C>Col=RELATGRD	Ctrl=gclx_relatgrd  	Param=BindColVal</C>
		<C>Col=RELATRE 	Ctrl=gclx_relatre  		Param=BindColVal</C>
		<C>Col=NOMINNM 	Ctrl=txt_nominnm	 		Param=Value</C>
		<C>Col=NOMINGRD	Ctrl=gclx_nomingrd  	Param=BindColVal</C>
		<C>Col=NOMINRE	Ctrl=gclx_nominre  		Param=BindColVal</C>
		<C>COL=PAYSEQ		Ctrl=gcem_payseq 			Param=Text</C>

		<C>Col=SEX			Ctrl=gclx_sex		  		Param=BindColVal</C>
		<C>Col=JOBKIND	Ctrl=gclx_jobkind			Param=BindColVal</C>
		<C>Col=GYGB		Ctrl=gcra_gygb			Param=CodeValue</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcbn_data052 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_data052">
	<PARAM NAME="BindInfo"	VALUE="
		<C>Col=MILIDIV 		Ctrl=gclx_milidiv			Param=BindColVal</C>
		<C>Col=NMREASON 	Ctrl=txt_nmreason			Param=Value</C>
		<C>Col=MILITGBN		Ctrl=gclx_militgbn		Param=BindColVal</C>
		<C>Col=MILIGRD		Ctrl=gclx_miligrd			Param=BindColVal</C>
		<C>Col=MILIFRDT		Ctrl=gcem_milifrdt		Param=Text</C>
		<C>Col=MILITODT		Ctrl=gcem_militodt		Param=Text</C>
		<C>Col=MILITYPE		Ctrl=gclx_militype		Param=BindColVal</C>
		<C>Col=MILIKND		Ctrl=gclx_milispec		Param=BindColVal</C>
		<C>Col=MILINO			Ctrl=gcem_milino			Param=Text</C>
		<C>Col=MILIGBN		Ctrl=gcra_miligbn			Param=Codevalue</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcbn_data06 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_data06">
	<PARAM NAME="BindInfo"	VALUE="
		<C>Col=ASSGB 			Ctrl=gclx_assgb			Param=BindColVal</C>
		<C>Col=AFRDT 			Ctrl=gcem_afrdt			Param=Text</C>
		<C>Col=ATODT 			Ctrl=gcem_atodt			Param=Text</C>
		<C>Col=ASSAMT			Ctrl=gcem_assamt		Param=Text</C>
		<C>Col=ASSINST		Ctrl=txt_assinst		Param=Value</C>
		<C>Col=ASSNO 			Ctrl=gcem_assno			Param=Text</C>
		<C>Col=ASSNAME 		Ctrl=txt_assname		Param=Value</C>
		<C>Col=ASSRELA		Ctrl=gclx_assrela		Param=BindColVal</C>
		<C>Col=ASSRESINO	Ctrl=gcem_assresino	Param=Text</C>
		<C>Col=ASSTELNO 	Ctrl=txt_asstelno		Param=Value</C>
		<C>Col=ASSPOSTNO	Ctrl=gcem_assno			Param=Text</C>
		<C>Col=ASSADDR 		Ctrl=txt_assaddr		Param=Value</C>
		<C>Col=RECPAMT		Ctrl=gcem_recpamt		Param=Text</C>
		<C>Col=HOSPITAL		Ctrl=txt_hospital		Param=Value</C>
		<C>Col=HOSDT 			Ctrl=gcem_hosdt			Param=Text</C>
		<C>Col=HOSMEMO		Ctrl=txt_hosmemo		Param=Value</C>
		<C>Col=HEIGHT			Ctrl=gcem_height		Param=Text</C>
		<C>Col=WEIGHT			Ctrl=gcem_weight		Param=Text</C>
		<C>Col=BLOOD 			Ctrl=gcem_blood			Param=Text</C>
		<C>Col=EYEL 			Ctrl=gcem_eyel			Param=Text</C>
		<C>Col=EYER 			Ctrl=gcem_eyer			Param=Text</C>
		<C>Col=COLBLNYN		Ctrl=gclx_colblnyn	Param=BindColVal</C>
		<C>Col=HOSREVIT		Ctrl=gcra_hosrevit	Param=CodeValue</C>
		<C>Col=DISDIV			Ctrl=gclx_disdiv		Param=BindColVal</C>
		<C>Col=DISGRD			Ctrl=gclx_disgrd		Param=BindColVal</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!------------------------------------------------------------------------
����Ʈ
-------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="

<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=135 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='education.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID=gcds_report1
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=129 ,face='����' ,size=10 ,penwidth=1
			<X>left=0			,top=0	,right=1909		,bottom=128		,border=true</X>
			<X>left=0			,top=0	,right=106		,bottom=128		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=0	,right=472		,bottom=66		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=62 ,right=288		,bottom=128		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=288		,top=62 ,right=472		,bottom=128		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=469		,top=0	,right=1238		,bottom=128		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1234	,top=0	,right=1469		,bottom=128		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1466	,top=0	,right=1784		,bottom=128		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1781	,top=0	,right=1909		,bottom=128		,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='No' ,left=6 ,top=6 ,right=100 ,bottom=125	,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�����Ⱓ'	,left=109		,top=6	,right=466	,bottom=62	,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='���г⵵'	,left=109		,top=69 ,right=284	,bottom=125 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�����⵵'	,left=291		,top=69 ,right=466	,bottom=125 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�б���'		,left=475		,top=6	,right=1231 ,bottom=125 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'		,left=1238	,top=6	,right=1463 ,bottom=125 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'		,left=1472	,top=6	,right=1778 ,bottom=125 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'		,left=1788	,top=6	,right=1906 ,bottom=125 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=63 ,face='����' ,size=10 ,penwidth=1
			<L> left=0		,top=0	,right=0			,bottom=62 </L>
			<L> left=0		,top=62 ,right=1909		,bottom=62 </L>
			<L> left=103	,top=0	,right=103		,bottom=62 </L>
			<L> left=288	,top=0	,right=288		,bottom=62 </L>
			<L> left=469	,top=0	,right=469		,bottom=62 </L>
			<L> left=1234 ,top=0	,right=1234		,bottom=62 </L>
			<L> left=1466 ,top=0	,right=1466		,bottom=62 </L>
			<L> left=1781 ,top=0	,right=1781		,bottom=62 </L>
			<L> left=1909 ,top=0	,right=1909		,bottom=62 </L>
			<C>id='{CURROW}', left=6,			top=3, right=100,		bottom=59, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='GRAYY',		left=291,		top=3, right=466,		bottom=59, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='STRYY',		left=109,		top=3, right=284,		bottom=59, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SCHNM',		left=475,		top=3, right=1231,	bottom=59, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDCNM',		left=1238,	top=3, right=1463,	bottom=59, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='PGCNM',		left=1472,	top=3, right=1778,	bottom=59, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDIVNM',		left=1788,	top=3, right=1909,	bottom=59, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area5 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='hdcareer.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report5
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=150 ,face='����' ,size=10 ,penwidth=1
			<X>left=0 ,top=90 ,right=106 ,bottom=151 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103 ,top=90 ,right=312 ,bottom=151 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=310 ,top=90 ,right=619 ,bottom=151 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=616 ,top=90 ,right=1143 ,bottom=151 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=32 ,right=1691 ,bottom=90 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=5 ,top=95 ,right=101 ,bottom=151 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��' ,left=622 ,top=95 ,right=1138 ,bottom=151 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�߷ɱ���' ,left=315 ,top=95 ,right=614 ,bottom=151 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�߷�����' ,left=108 ,top=95 ,right=307 ,bottom=151 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1140 ,top=90 ,right=1400 ,bottom=151 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='����' ,left=1148 ,top=95 ,right=1397 ,bottom=151 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1394 ,top=90 ,right=1529 ,bottom=151 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='ȣ  ��' ,left=1400 ,top=93 ,right=1524 ,bottom=148 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1527 ,top=90 ,right=1910 ,bottom=151 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� ��' ,left=1532 ,top=95 ,right=1905 ,bottom=151 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='����' ,size=10 ,penwidth=1
			<L> left=0 ,top=0 ,right=0 ,bottom=53 </L>
			<L> left=103 ,top=0 ,right=103 ,bottom=53 </L>
			<L> left=310 ,top=0 ,right=310 ,bottom=53 </L>
			<L> left=616 ,top=0 ,right=616 ,bottom=53 </L>
			<L> left=1140 ,top=0 ,right=1140 ,bottom=53 </L>
			<L> left=1527 ,top=0 ,right=1527 ,bottom=53 </L>
			<L> left=1910 ,top=0 ,right=1910 ,bottom=53 </L>
			<C>id='DEPTNM', left=622, top=0, right=1138, bottom=53, align='left'</C>
			<C>id='ORDNM', left=315, top=0, right=614, bottom=53</C>
			<C>id='ORDDT', left=108, top=0, right=307, bottom=53 ,mask='XXXX/XX/XX'</C>
			<C>id='{CURROW}', left=5, top=0, right=101, bottom=53</C>
			<L> left=0 ,top=53 ,right=1910 ,bottom=53 </L>
			<C>id='GRDDIVNM', left=1148, top=0, right=1397, bottom=53, align='left'</C>
			<L> left=1394 ,top=0 ,right=1394 ,bottom=53 </L>
			<C>id='PAYSEQ', left=1402, top=0, right=1527, bottom=53 ,mask='XXȣ��'</C>
			<C>id='ETC', left=1529, top=0, right=1905, bottom=53, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=165 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='career.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=162 ,DetailDataID=gcds_report2
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=219 ,face='����' ,size=10 ,penwidth=1
	<X>left=0 ,top=91 ,right=1909 ,bottom=219 ,border=true</X>
	<X>left=0 ,top=91 ,right=106 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=103 ,top=91 ,right=503 ,bottom=156 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=103 ,top=153 ,right=313 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=306 ,top=153 ,right=503 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=500 ,top=91 ,right=1038 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1034 ,top=91 ,right=1303 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1300 ,top=91 ,right=1606 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1606 ,top=91 ,right=1909 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� �� �� �� �� �� �� ��' ,left=0 ,top=31 ,right=1691 ,bottom=91 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ��Ⱓ' ,left=109 ,top=94 ,right=497 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='No' ,left=6 ,top=94 ,right=100 ,bottom=212 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�Ի���' ,left=109 ,top=159 ,right=303 ,bottom=212 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�����' ,left=309 ,top=159 ,right=497 ,bottom=212 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='ȸ���' ,left=506 ,top=94 ,right=1031 ,bottom=212 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='������' ,left=1041 ,top=94 ,right=1297 ,bottom=212 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='������' ,left=1306 ,top=94 ,right=1603 ,bottom=212 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��������' ,left=1609 ,top=94 ,right=1906 ,bottom=212 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=59 ,face='����' ,size=10 ,penwidth=1
	<C>id='REMARK', left=1609, top=0, right=1906, bottom=56, align='left'</C>
	<C>id='DUTYNM', left=1306, top=0, right=1603, bottom=56, align='left'</C>
	<C>id='POSINM', left=1041, top=0, right=1297, bottom=56</C>
	<C>id='CAPLACE', left=506, top=0, right=1031, bottom=56, align='left'</C>
	<C>id='ENDDT', left=309, top=0, right=497, bottom=56 ,mask='XXXX/XX/XX'</C>
	<C>id='FRDT', left=109, top=0, right=303, bottom=56 ,mask='XXXX/XX/XX'</C>
	<C>id='{CURROW}', left=6, top=0, right=100, bottom=56</C>
	<L> left=1909 ,top=0 ,right=1909 ,bottom=59 </L>
	<L> left=1606 ,top=0 ,right=1606 ,bottom=59 </L>
	<L> left=1300 ,top=0 ,right=1300 ,bottom=59 </L>
	<L> left=1034 ,top=0 ,right=1034 ,bottom=59 </L>
	<L> left=500 ,top=0 ,right=500 ,bottom=59 </L>
	<L> left=306 ,top=0 ,right=306 ,bottom=59 </L>
	<L> left=103 ,top=0 ,right=103 ,bottom=59 </L>
	<L> left=0 ,top=59 ,right=1909 ,bottom=59 </L>
	<L> left=0 ,top=0 ,right=0 ,bottom=59 </L>
</B>
	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='family.sbt'	,left=0			,top=0			,right=2000 ,bottom=68 ,DetailDataID=gcds_report3
		<B>id=DHeader			,left=0			,top=0			,right=2000 ,bottom=154 ,face='����' ,size=10 ,penwidth=1
			<X>left=925			,top=91			,right=1250 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��  ��'	,left=931		,top=94			,right=1244 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=397			,top=91			,right=691	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=250			,top=91			,right=400	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=691			,top=91			,right=928	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1772		,top=91			,right=1909 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��'			,left=9 ,top=31 ,right=1700 ,bottom=91 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=0 ,top=91 ,right=103 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1634 ,top=91 ,right=1772 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='No'				,left=6			,top=94			,right=100	,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����'			,left=1775	,top=94			,right=1906 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�Ǻ�'			,left=1638	,top=94			,right=1769 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'		,left=694		,top=94			,right=922	,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ֹι�ȣ'	,left=403		,top=94			,right=684	,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'		,left=256		,top=94			,right=394	,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=103				,top=91			,right=250	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��  ��'		,left=109		,top=94			,right=250	,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1509			,top=91			,right=1641 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��  ��'		,left=1513	,top=94			,right=1634 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1378			,top=91			,right=1509 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��  ��'		,left=1384	,top=94			,right=1506 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1247			,top=91			,right=1381 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��  ��'		,left=1253	,top=94			,right=1375 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=56 ,face='����' ,size=10 ,penwidth=1
			<L> left=1247 ,top=0 ,right=1247 ,bottom=56 </L>
			<C>id={IF (PAYYN=1,'��','��')}, left=1775, top=0, right=1906, bottom=53</C>
			<C>id={IF (MEDINYN=1,'��','��')}, left=1644, top=0, right=1769, bottom=53</C>
			<C>id='CMPNM',	left=931, top=0, right=1244,	bottom=53, align='left'</C>
			<C>id='REFNM',	left=109, top=0, right=247,		bottom=53</C>
			<C>id='FAMNM',	left=256, top=0, right=394,		bottom=53</C>
			<C>id={CURROW}, left=6,		top=0, right=100,		bottom=53</C>
			<C>id='LSTNM',	left=694, top=0, right=922,		bottom=53</C>
			<C>id='RESINO', left=403, top=3, right=684,		bottom=56 ,mask='XXXXXX-XXXXXXX'</C>
			<C>id={IF (LIVEYN=1,'����','�񵿰�')}, left=1253, top=0, right=1375, bottom=53</C>
			<C>id={IF (SPTYN=1,'�ξ�','�Ǻξ�')}, left=1384, top=0, right=1506, bottom=53</C>
			<C>id={IF (DISYN=1,'��','��')}, left=1516, top=0, right=1634, bottom=53</C>
			<L> left=0		,top=0	,right=0		,bottom=56 </L>
			<L> left=0		,top=59 ,right=1909 ,bottom=56 </L>
			<L> left=103	,top=0	,right=103	,bottom=56 </L>
			<L> left=250	,top=0	,right=250	,bottom=56 </L>
			<L> left=400	,top=0	,right=400	,bottom=56 </L>
			<L> left=691	,top=0	,right=691	,bottom=56 </L>
			<L> left=928	,top=0	,right=928	,bottom=56 </L>
			<L> left=1381 ,top=0	,right=1381 ,bottom=56 </L>
			<L> left=1509 ,top=0	,right=1509 ,bottom=56 </L>
			<L> left=1641 ,top=0	,right=1641 ,bottom=56 </L>
			<L> left=1772 ,top=0	,right=1772 ,bottom=56 </L>
			<L> left=1909 ,top=0	,right=1909	,bottom=56 </L>
		</B>
	</R>
</A>

<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='license.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report4
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=154 ,face='����' ,size=10 ,penwidth=1
			<X>left=0			,top=91 ,right=106	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=91 ,right=366	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=363		,top=91 ,right=759	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=756		,top=91 ,right=1125 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1122	,top=91 ,right=1428 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1428	,top=91 ,right=1909 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=31 ,right=1691 ,bottom=91 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=6 ,top=94 ,right=100 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�������'	,left=109		,top=94 ,right=359	,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ڰݱ���'	,left=369		,top=94 ,right=753	,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ڰ�����'	,left=763		,top=94 ,right=1119 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����ȣ'		,left=1128	,top=94 ,right=1425 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����ó'		,left=1431	,top=94 ,right=1906 ,bottom=150 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=56 ,face='����' ,size=10 ,penwidth=1
			<L> left=756			,top=0	,right=756	,bottom=56 </L>
			<L> left=363			,top=0	,right=363	,bottom=56 </L>
			<L> left=103			,top=0	,right=103	,bottom=56 </L>
			<L> left=0				,top=0	,right=0		,bottom=56 </L>
			<L> left=0				,top=56 ,right=1909 ,bottom=56 </L>
			<L> left=1428			,top=0	,right=1428 ,bottom=56 </L>
			<L> left=1122			,top=0	,right=1122 ,bottom=56 </L>
			<L> left=1909			,top=0	,right=1909 ,bottom=56 </L>
			<C>id='LCSCNM',		left=369,		top=0, right=753,		bottom=53, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{CURROW}', left=6,			top=0, right=100,		bottom=53, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='GETDT',		left=109,		top=0, right=359,		bottom=53 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCSTNM',		left=763,		top=0, right=1119,	bottom=53, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCSNO',		left=1128,	top=0, right=1425,	bottom=53, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ISSPART',	left=1431,	top=0, right=1906,	bottom=53, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area6 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='hdorder.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report6
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=150 ,face='����' ,size=10 ,penwidth=1
			<X>left=0			,top=91 ,right=106	,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=91 ,right=364	,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=363		,top=91 ,right=995	,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=994		,top=91 ,right=1284 ,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1281	,top=91 ,right=1586 ,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1584	,top=91 ,right=1909 ,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=34 ,right=1691 ,bottom=94 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='������'	,left=1591	,top=97			,right=1906		,bottom=150		,face='����'	,size=10		,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>			
			<T>id='��  ��'		,left=1288	,top=97			,right=1584		,bottom=150		,face='����'	,size=10		,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'		,left=1000	,top=97			,right=1278		,bottom=150		,face='����'	,size=10		,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'		,left=369		,top=97			,right=991		,bottom=150		,face='����'	,size=10		,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='No' ,left=6 ,top=97		,right=100	,bottom=150		,face='����'	,size=10			,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������' ,left=109		,top=97			,right=359		,bottom=150		,face='����'	,size=10		,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=50 ,face='����' ,size=10 ,penwidth=1
			<L> left=363	,top=0	,right=363	,bottom=50 </L>
			<L> left=103	,top=0	,right=103	,bottom=50 </L>
			<L> left=0		,top=0	,right=0		,bottom=50 </L>
			<L> left=0		,top=50 ,right=1909 ,bottom=50 </L>
			<L> left=1584 ,top=0	,right=1584 ,bottom=50 </L>
			<L> left=1281 ,top=0	,right=1281 ,bottom=50 </L>
			<L> left=994	,top=0	,right=994	,bottom=50 </L>
			<L> left=1909 ,top=0	,right=1909 ,bottom=50 </L>
			<C>id='DEPTNM',		left=369,		top=0, right=991,		bottom=50, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SCRGBN',		left=1591,	top=0, right=1906,	bottom=50, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SCR',			left=1288,	top=0, right=1584,	bottom=50, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='PAYGNM',		left=1000,	top=0, right=1278,	bottom=50, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EVAYM',		left=109,		top=0, right=359,		bottom=50 ,mask='XXXX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{CURROW}', left=6,			top=0, right=100,		bottom=50, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area8 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='hdreward.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report9
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=154 ,face='����' ,size=10 ,penwidth=1
			<X>left=0			,top=91 ,right=106 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=91 ,right=625 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=622		,top=91 ,right=1253 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1250	,top=91 ,right=1909 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=31 ,right=1691 ,bottom=91 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No'				,left=6 ,top=91 ,right=100 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��������' ,left=109 ,top=91 ,right=619 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�������' ,left=628 ,top=91 ,right=1250 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�������' ,left=1256 ,top=91 ,right=1906 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=56 ,face='����' ,size=10 ,penwidth=1
			<L> left=0				,top=56			,right=1909 ,bottom=56 </L>
			<L> left=1250			,top=0			,right=1250 ,bottom=56 </L>
			<L> left=622			,top=0			,right=622	,bottom=56 </L>
			<L> left=103			,top=0			,right=103	,bottom=56 </L>
			<L> left=0				,top=0			,right=0		,bottom=56 </L>
			<L> left=1909			,top=0			,right=1909 ,bottom=56 </L>
			<C>id='REWKNM',		left=1256,	top=0, right=1906,	bottom=56, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REWGNM',		left=628,		top=0, right=1250,	bottom=56, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RECDT',		left=109,		top=0, right=619,		bottom=56 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{CURROW}', left=6,			top=0, right=100,		bottom=56, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area7 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='hdeduc.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report7
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=154 ,face='����' ,size=10 ,penwidth=1
			<X>left=0			,top=91 ,right=106	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=91 ,right=366	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=363		,top=91 ,right=625	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=622		,top=91 ,right=884	,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=881		,top=91 ,right=1253 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1250	,top=91 ,right=1600 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1600	,top=91 ,right=1909 ,bottom=153 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=31 ,right=1691 ,bottom=91 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=6 ,top=91 ,right=100 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������'		,left=109		,top=91 ,right=359 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������'		,left=369		,top=91 ,right=619 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�����ϼ�'	,left=628		,top=91 ,right=878 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��������'	,left=888		,top=91 ,right=1250 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�������'	,left=1256	,top=91 ,right=1597 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������'	,left=1603	,top=91 ,right=1906 ,bottom=153 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='����' ,size=10 ,penwidth=1
			<L> left=0		,top=0	,right=0			,bottom=53 </L>
			<L> left=103	,top=0	,right=103		,bottom=53 </L>
			<L> left=363	,top=0	,right=363		,bottom=53 </L>
			<L> left=622	,top=0	,right=622		,bottom=53 </L>
			<L> left=881	,top=0	,right=881		,bottom=53 </L>
			<L> left=1250 ,top=0	,right=1250		,bottom=53 </L>
			<L> left=1600 ,top=0	,right=1600		,bottom=53 </L>
			<L> left=1909 ,top=0	,right=1909		,bottom=53 </L>
			<L> left=0		,top=53 ,right=1909		,bottom=53 </L>
			<C>id='{CURROW}', left=6,			top=0, right=100,		bottom=53, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FRDT',			left=109,		top=0, right=359,		bottom=53 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='TODT',			left=369,		top=0, right=619,		bottom=53 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDUDAY',		left=628,		top=0, right=878,		bottom=53, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SUBJECT',	left=888,		top=0, right=1250,	bottom=53, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDUINST',	left=1256,	top=0, right=1597,	bottom=53, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDUPLC',		left=1603,	top=0, right=1906,	bottom=53, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area9 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='baseinfo.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_data00
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=679 ,face='����' ,size=10 ,penwidth=1
			<X>left=0 ,top=53 ,right=109 ,bottom=178 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1000 ,top=459 ,right=1225 ,bottom=519 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=0 ,top=459 ,right=109 ,bottom=641 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=0 ,top=266 ,right=109 ,bottom=447 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=384 ,right=363 ,bottom=447 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=0 ,top=191 ,right=109 ,bottom=253 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=728 ,top=53 ,right=984 ,bottom=116 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=106 ,top=112 ,right=1909 ,bottom=112 </L>
			<L> left=106 ,top=53 ,right=1909 ,bottom=53 </L>
			<X>left=1313 ,top=53 ,right=1569 ,bottom=116 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��Ÿ' ,left=6 ,top=59 ,right=100 ,bottom=112 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=106 ,top=191 ,right=363 ,bottom=253 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=728 ,top=191 ,right=984 ,bottom=253 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=106 ,top=191 ,right=1909 ,bottom=191 </L>
			<X>left=1313 ,top=191 ,right=1569 ,bottom=253 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��ü' ,left=6 ,top=197 ,right=100 ,bottom=250 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=106 ,top=266 ,right=363 ,bottom=328 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=728 ,top=266 ,right=984 ,bottom=328 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=106 ,top=266 ,right=1909 ,bottom=266 </L>
			<X>left=1313 ,top=266 ,right=1569 ,bottom=328 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=53 ,right=363 ,bottom=116 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�Ի籸��' ,left=116 ,top=59 ,right=356 ,bottom=109 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=106 ,top=112 ,right=363 ,bottom=178 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�Ի籸��' ,left=734 ,top=59 ,right=975 ,bottom=109 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=728 ,top=112 ,right=984 ,bottom=178 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� ��' ,left=1319 ,top=59 ,right=1559 ,bottom=109 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1313 ,top=112 ,right=1569 ,bottom=178 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=1909 ,top=191 ,right=1909 ,bottom=253 </L>
			<T>id='����/ü��' ,left=116 ,top=197 ,right=356 ,bottom=247 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������' ,left=734 ,top=197 ,right=975 ,bottom=247 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� ��' ,left=1319 ,top=197 ,right=1559 ,bottom=247 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� ��' ,left=116 ,top=272 ,right=356 ,bottom=322 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=106 ,top=325 ,right=363 ,bottom=387 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� ��' ,left=116 ,top=391 ,right=356 ,bottom=441 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� ��' ,left=116 ,top=331 ,right=356 ,bottom=381 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<L> left=359 ,top=387 ,right=728 ,bottom=387 </L>
			<T>id='��' ,left=6 ,top=356 ,right=100 ,bottom=412 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��' ,left=6 ,top=297 ,right=100 ,bottom=350 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=728 ,top=384 ,right=984 ,bottom=447 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=728 ,top=325 ,right=984 ,bottom=387 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��������' ,left=734 ,top=331 ,right=975 ,bottom=381 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��������' ,left=734 ,top=272 ,right=975 ,bottom=322 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�����Ⱓ' ,left=734 ,top=391 ,right=975 ,bottom=441 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1313 ,top=325 ,right=1569 ,bottom=387 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� ��' ,left=1319 ,top=272 ,right=1559 ,bottom=322 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� ��' ,left=1319 ,top=331 ,right=1559 ,bottom=381 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<C>id='SPECIAL', left=991, top=122, right=1306, bottom=169, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RECDIVNM', left=991, top=59, right=1306, bottom=106, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='BLOOD', left=991, top=200, right=1306, bottom=247, align='left', ,mask='XX ��', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='NMREASON', left=991, top=275, right=1306, bottom=322, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={decode(MILIGBN,1,'���� �����',2,'�ι��� �����',3,'�� �����')}, left=991, top=334, right=1306, bottom=381, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RILIGNNM', left=1575, top=122, right=1894, bottom=169, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILTNM', left=1575, top=334, right=1894, bottom=381, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JOBKINDNM', left=1575, top=59, right=1894, bottom=106, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILHNM', left=1575, top=275, right=1894, bottom=322, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1909 ,top=266 ,right=1909 ,bottom=444 </L>
			<X>left=1431 ,top=459 ,right=1656 ,bottom=519 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=569 ,top=459 ,right=794 ,bottom=519 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=106 ,top=459 ,right=1909 ,bottom=459 </L>
			<X>left=106 ,top=459 ,right=363 ,bottom=522 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=519 ,right=363 ,bottom=581 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=578 ,right=363 ,bottom=641 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� ��' ,left=116 ,top=466 ,right=356 ,bottom=516 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��Ÿ�ܱ���' ,left=116 ,top=525 ,right=356 ,bottom=575 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� ��' ,left=116 ,top=584 ,right=356 ,bottom=634 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����' ,left=6 ,top=575 ,right=100 ,bottom=628 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='/' ,left=6 ,top=519 ,right=100 ,bottom=572 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����' ,left=6 ,top=466 ,right=100 ,bottom=516 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<L> left=106 ,top=519 ,right=1909 ,bottom=519 </L>
			<L> left=109 ,top=578 ,right=1909 ,bottom=578 </L>
			<L> left=109 ,top=641 ,right=1909 ,bottom=641 </L>
			<X>left=569 ,top=578 ,right=794 ,bottom=641 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� ��' ,left=575 ,top=466 ,right=784 ,bottom=516 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� ��' ,left=575 ,top=584 ,right=784 ,bottom=634 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<C>id='TOFSCR', left=800, top=466, right=994, bottom=512, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<X>left=1000 ,top=578 ,right=1225 ,bottom=641 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�Ŀ�����Ʈ' ,left=1003 ,top=584 ,right=1222 ,bottom=634 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<C>id='PWGRDCD', left=1231, top=584, right=1425, bottom=634, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JPTSCR', left=1231, top=466, right=1425, bottom=512, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='HSKSCR', left=1663, top=466, right=1888, bottom=512, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1909 ,top=459 ,right=1909 ,bottom=641 </L>
			<L> left=359 ,top=253 ,right=728 ,bottom=253 </L>
			<L> left=981 ,top=253 ,right=1313 ,bottom=253 </L>
			<L> left=1566 ,top=253 ,right=1909 ,bottom=253 </L>
			<L> left=106 ,top=325 ,right=1909 ,bottom=325 </L>
			<L> left=981 ,top=447 ,right=1909 ,bottom=447 </L>
			<T>id='JPT' ,left=1003 ,top=466 ,right=1222 ,bottom=516 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='HSK' ,left=1434 ,top=466 ,right=1653 ,bottom=516 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����' ,left=6 ,top=116 ,right=100 ,bottom=172 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='Ư ��' ,left=734 ,top=122 ,right=975 ,bottom=172 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� ��' ,left=116 ,top=122 ,right=356 ,bottom=172 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<L> left=360 ,top=177 ,right=726 ,bottom=177 </L>
			<T>id='�� ��' ,left=1319 ,top=122 ,right=1559 ,bottom=172 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<L> left=981 ,top=177 ,right=1313 ,bottom=177 </L>
			<L> left=1566 ,top=177 ,right=1909 ,bottom=177 </L>
			<L> left=1909 ,top=53 ,right=1909 ,bottom=175 </L>
			<L> left=981 ,top=387 ,right=1313 ,bottom=387 </L>
			<L> left=1566 ,top=387 ,right=1909 ,bottom=387 </L>
			<L> left=359 ,top=447 ,right=728 ,bottom=447 </L>
			<T>id='�� :' ,left=1578 ,top=200 ,right=1631 ,bottom=247 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=1713 ,top=200 ,right=1753 ,bottom=247 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='EYEL', left=1816, top=200, right=1891, bottom=247, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
			<C>id='EYER', left=1631, top=200, right=1706, bottom=247, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
			<T>id='�� :' ,left=1763 ,top=200 ,right=1816 ,bottom=247 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='~' ,left=1191 ,top=397 ,right=1225 ,bottom=444 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='MILIFRDT', left=991, top=397, right=1184, bottom=444, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='MILITODT', left=1231, top=397, right=1425, bottom=444, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='EXGRDCD',	left=800,	top=584, right=994, bottom=634, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='HWGRDCD',	left=369, top=584, right=563, bottom=634, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ETCLNG',		left=369, top=525, right=1428, bottom=572, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='TOESCR',		left=369, top=466, right=563, bottom=512, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILKNM',		left=369, top=394, right=719, bottom=441, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILGNM',		left=369, top=334, right=719, bottom=381, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILDNM',		left=369, top=275, right=719, bottom=322, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='HEIGHT',		left=369, top=200, right=428, bottom=247, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id=' Cm'		,		left=428 ,top=200 ,right=491 ,bottom=247 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Kg'		,		left=631 ,top=200 ,right=716 ,bottom=247 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='WEIGHT',		left=572, top=200, right=631, bottom=247, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='HOBBY',		left=369, top=122, right=719, bottom=169, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EMPDIVNM', left=369, top=59, right=719, bottom=106, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<B>id=Footer ,left=0,top=2550 ,right=2000 ,bottom=2600 ,face='����' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1574 ,top=230 ,right=1954 ,bottom=330</I>
	<L> left=0 ,top=220	,right=1964 ,bottom=220, penstyle=solid, penwidth=2 </L>
	<T> id='#p/#t' left=0 ,top=230 ,right=1974 ,bottom=310</T>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

 

</BODY>
</HTML>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
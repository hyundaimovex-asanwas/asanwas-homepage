<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	����������� - ������������Է�
+ ���α׷� ID	: P030002.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: 
+ �� �� �� ��	:  p030005_s1, (�������곻����ȸ�� ������ �������� �����.)
                 p030002_t1 : 
------------------------------------------------------------------------------
+ �� �� �� ��  :	�������� ����   
+ ��   ��  ��  :   �̹���
+ �� �� �� ��  :  2007. 1
------------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>


<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>������������Է�</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

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
get_cookdata();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);
var gs_date3 = gcurdate.substr(0,4);
var gs_date4 = gcurdate.substr(0,4)+ "��   " +gcurdate.substr(5,2)+ "��   " +gcurdate.substr(8,2)+ "��";
var gs_level;
var gs_treecd;
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	
	txt_empnmk1.focus();
	gcem_curdt.text = gcurdate.substr(0,4);	//�ͼӳ⵵
	ln_Before();	//����ȸ

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	if (gcem_curdt.text=="") {
		alert("�ͼӳ⵵�� �ʼ��׸��Դϴ�.");
		gcem_curdt.setFocus();
	}

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s1?v_str1="+ gcem_curdt.text+"12"
																	 + "&v_str2=" + gclx_deptcd.bindcolval
																 	 + "&v_str3=" + fn_trim(txt_empnmk1.value)
																	 + "&v_str4=" + gs_level
																	 + "&v_str5=" + gs_treecd;
	 //prompt('',gcds_data.DataID);
	gcds_data.Reset();

	


	ln_Print2_1();  //�Ƿ�� ��������
	ln_Print3_1();	//��α� ��������

}

function ln_Query02(p){

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s3?v_str1="+p;
	//prompt('',gcds_data2.DataID );
	
	gcds_data2.Reset();

  	//gcds_code02.DataID = g_servlet+"/Account.a010001_s2?v_str1="+p; 
	//	gcds_code02.Reset();
	//	ln_Enable02("f");
}

/******************************************************************************
	Description : ����ȸ ����
******************************************************************************/
function ln_Before(){

	//�Ҽ��ڵ�[�˻�]
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_dept1.Reset();

	//�Ҽ��ڵ�
	gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";
	gcds_dept2.Reset();
	
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (gcds_data.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {		
		ln_Chk2();
		if(ln_Chk()){
			if (confirm("�����Ͻðڽ��ϱ�?")) {
				gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_t1";
				gctr_data.post();
			}
		}
	}
}

function ln_Save2(){
	if (gcds_data2.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {		
		//ln_Chk2();
		//if(ln_Chk()){
			if (confirm("�����Ͻðڽ��ϱ�?")) {
				gctr_data2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_t2";
				gctr_data2.post();
			//}
		}
	}
}


/******************************************************************************
	Description : �ξ簡�� �ϰ�����
******************************************************************************/
function ln_Sort(){
	//for (var i=1;i<=5;i++) ln_Chk4();
}

/******************************************************************************
	Description : �ξ簡�� ��������
******************************************************************************/
function ln_Chk4(){

	if(fn_trim(txt_relat1.value) == "" && fn_trim(txt_famnm1.value) == "") {	//����1 - check
		//����1
		txt_relat1.value			= txt_relat2.value;
		txt_famnm1.value			= txt_famnm2.value;
		gcem_resino1.text			= gcem_resino2.text;
		gclx_ref11.BindColVal = gclx_ref21.BindColVal;

		ln_Chk_1();

		//����2
		txt_relat2.value			=	"";
		txt_famnm2.value			=	"";
		gcem_resino2.text			= "";
		gclx_ref21.BindColVal = "";
		txt_ref22.checked			= false;
		txt_ref23.checked			= false;
		txt_ref24.checked			= false;
		txt_ref25.checked			= false;
		txt_ref26.checked			= false;
		txt_ref27.checked			= false;
		txt_ref28.checked			= false;
	}
	
	if(fn_trim(txt_relat2.value) == "" && fn_trim(txt_famnm2.value) == "") {	//����2 - check
		//����2
		txt_relat2.value			= txt_relat3.value;
		txt_famnm2.value			= txt_famnm3.value;
		gcem_resino2.text			= gcem_resino3.text;
		gclx_ref21.BindColVal = gclx_ref31.BindColVal;

		ln_Chk_2();

		//����3
		txt_relat3.value			=	"";
		txt_famnm3.value			=	"";
		gcem_resino3.text			= "";
		gclx_ref31.BindColVal = "";
		txt_ref32.checked			= false;
		txt_ref33.checked			= false;
		txt_ref34.checked			= false;
		txt_ref35.checked			= false;
		txt_ref36.checked			= false;
		txt_ref37.checked			= false;
		txt_ref38.checked			= false;
	}
	
	if(fn_trim(txt_relat3.value) == "" && fn_trim(txt_famnm3.value) == "") {	//����3 - check
		//����3
		txt_relat3.value			= txt_relat4.value;
		txt_famnm3.value			= txt_famnm4.value;
		gcem_resino3.text			= gcem_resino4.text;
		gclx_ref31.BindColVal = gclx_ref41.BindColVal;

		ln_Chk_3();

		//����4
		txt_relat4.value			=	"";
		txt_famnm4.value			=	"";
		gcem_resino4.text			= "";
		gclx_ref41.BindColVal = "";
		txt_ref42.checked			= false;
		txt_ref43.checked			= false;
		txt_ref44.checked			= false;
		txt_ref45.checked			= false;
		txt_ref46.checked			= false;
		txt_ref47.checked			= false;
		txt_ref48.checked			= false;
	}

	if(fn_trim(txt_relat4.value) == "" && fn_trim(txt_famnm4.value) == "") {	//����4 - check
		//����4
		txt_relat4.value			= txt_relat5.value;
		txt_famnm4.value			= txt_famnm5.value;
		gcem_resino4.text			= gcem_resino5.text;
		gclx_ref41.BindColVal = gclx_ref51.BindColVal;

		ln_Chk_4();

		//����5
		txt_relat5.value			=	"";
		txt_famnm5.value			=	"";
		gcem_resino5.text			= "";
		gclx_ref51.BindColVal = "";
		txt_ref52.checked			= false;
		txt_ref53.checked			= false;
		txt_ref54.checked			= false;
		txt_ref55.checked			= false;
		txt_ref56.checked			= false;
		txt_ref57.checked			= false;
		txt_ref58.checked			= false;
	}

	if(fn_trim(txt_relat5.value) == "" && fn_trim(txt_famnm5.value) == "") {	//����5 - check
		//����5
		txt_relat5.value			= txt_relat6.value;
		txt_famnm5.value			= txt_famnm6.value;
		gcem_resino5.text			= gcem_resino6.text;
		gclx_ref51.BindColVal = gclx_ref61.BindColVal;

		ln_Chk_5();

		//����6
		txt_relat6.value			=	"";
		txt_famnm6.value			=	"";
		gcem_resino6.text			= "";
		gclx_ref61.BindColVal = "";
		txt_ref62.checked			= false;
		txt_ref63.checked			= false;
		txt_ref64.checked			= false;
		txt_ref65.checked			= false;
		txt_ref66.checked			= false;
		txt_ref67.checked			= false;
		txt_ref68.checked			= false;
	}
	
	if(fn_trim(txt_relat6.value) == "" && fn_trim(txt_famnm6.value) == "") {	//����6 - check
		//����6
		txt_relat6.value			= txt_relat7.value;
		txt_famnm6.value			= txt_famnm7.value;
		gcem_resino6.text			= gcem_resino7.text;
		gclx_ref61.BindColVal = gclx_ref71.BindColVal;

		ln_Chk_6();

		//����7
		txt_relat7.value			=	"";
		txt_famnm7.value			=	"";
		gcem_resino7.text			= "";
		gclx_ref71.BindColVal = "";
		txt_ref72.checked			= false;
		txt_ref73.checked			= false;
		txt_ref74.checked			= false;
		txt_ref75.checked			= false;
		txt_ref76.checked			= false;
		txt_ref77.checked			= false;
		txt_ref78.checked			= false;
	}

	if(fn_trim(txt_relat7.value) == "" && fn_trim(txt_famnm7.value) == "") {	//����7 - check
		//����7
		txt_relat7.value			= txt_relat8.value;
		txt_famnm7.value			= txt_famnm8.value;
		gcem_resino7.text			= gcem_resino8.text;
		gclx_ref71.BindColVal = gclx_ref81.BindColVal;

		ln_Chk_7();

		//����8
		txt_relat8.value			=	"";
		txt_famnm8.value			=	"";
		gcem_resino8.text			= "";
		gclx_ref81.BindColVal = "";
		txt_ref82.checked			= false;
		txt_ref83.checked			= false;
		txt_ref84.checked			= false;
		txt_ref85.checked			= false;
		txt_ref86.checked			= false;
		txt_ref87.checked			= false;
		txt_ref88.checked			= false;
	}

	if(fn_trim(txt_relat8.value) == "" && fn_trim(txt_famnm8.value) == "") {	//����8 - check
		//����8
		txt_relat8.value			= txt_relat9.value;
		txt_famnm8.value			= txt_famnm9.value;
		gcem_resino8.text			= gcem_resino9.text;
		gclx_ref81.BindColVal = gclx_ref91.BindColVal;

		ln_Chk_8();

		//����9
		txt_relat9.value			=	"";
		txt_famnm9.value			=	"";
		gcem_resino9.text			= "";
		gclx_ref91.BindColVal = "";
		txt_ref92.checked			= false;
		txt_ref93.checked			= false;
		txt_ref94.checked			= false;
		txt_ref95.checked			= false;
		txt_ref96.checked			= false;
		txt_ref97.checked			= false;
		txt_ref98.checked			= false;
	}
}

/******************************************************************************
	Description : ����1 checked
******************************************************************************/
function ln_Chk_1(){
	//����1
	if (txt_ref22.checked) {
		txt_ref12.value = "T";
		txt_ref12.checked = true;
	}else{ 
		txt_ref12.value = "";
		txt_ref12.checked = false;
	}

	if (txt_ref23.checked) {
		txt_ref13.value = "T";
		txt_ref13.checked = true;
	}else{ 
		txt_ref13.value = "";
		txt_ref13.checked = false;
	}

	if (txt_ref24.checked) {
		txt_ref14.value = "T";
		txt_ref14.checked = true;
	}else{ 
		txt_ref14.value = "";
		txt_ref14.checked = false;
	}

	if (txt_ref25.checked) {
		//txt_ref15.value = "T";
		//txt_ref15.checked = true;
	}else{ 
		txt_ref15.value = "";
		txt_ref15.checked = false;
	}

	if (txt_ref26.checked) {
		txt_ref16.value = "T";
		txt_ref16.checked = true;
	}else{ 
		txt_ref16.value = "";
		txt_ref16.checked = false;
	}

	if (txt_ref27.checked) {
		txt_ref17.value = "T";
		txt_ref17.checked = true;
	}else{ 
		txt_ref17.value = "";
		txt_ref17.checked = false;
	}

	if (txt_ref28.checked) {
		txt_ref18.value = "T";
		txt_ref18.checked = true;
	}else{ 
		txt_ref18.value = "";
		txt_ref18.checked = false;
	}
}

/******************************************************************************
	Description : ����2 checked
******************************************************************************/
function ln_Chk_2(){
	//����2
	if (txt_ref32.checked) {
		txt_ref22.value = "T";
		txt_ref22.checked = true;
	}else{ 
		txt_ref22.value = "";
		txt_ref22.checked = false;
	}

	if (txt_ref33.checked) {
		txt_ref23.value = "T";
		txt_ref23.checked = true;
	}else{ 
		txt_ref23.value = "";
		txt_ref23.checked = false;
	}

	if (txt_ref34.checked) {
		txt_ref24.value = "T";
		txt_ref24.checked = true;
	}else{ 
		txt_ref24.value = "";
		txt_ref24.checked = false;
	}

	if (txt_ref35.checked) {
		txt_ref25.value = "T";
		txt_ref25.checked = true;
	}else{ 
		txt_ref25.value = "";
		txt_ref25.checked = false;
	}

	if (txt_ref36.checked) {
		txt_ref26.value = "T";
		txt_ref26.checked = true;
	}else{ 
		txt_ref26.value = "";
		txt_ref26.checked = false;
	}

	if (txt_ref37.checked) {
		txt_ref27.value = "T";
		txt_ref27.checked = true;
	}else{ 
		txt_ref27.value = "";
		txt_ref27.checked = false;
	}

	if (txt_ref38.checked) {
		txt_ref28.value = "T";
		txt_ref28.checked = true;
	}else{ 
		txt_ref28.value = "";
		txt_ref28.checked = false;
	}
}

/******************************************************************************
	Description : ����3 checked
******************************************************************************/
function ln_Chk_3(){
	//����3
	if (txt_ref42.checked) {
		txt_ref32.value = "T";
		txt_ref32.checked = true;
	}else{ 
		txt_ref32.value = "";
		txt_ref32.checked = false;
	}

	if (txt_ref43.checked) {
		txt_ref33.value = "T";
		txt_ref33.checked = true;
	}else{ 
		txt_ref33.value = "";
		txt_ref33.checked = false;
	}

	if (txt_ref44.checked) {
		txt_ref34.value = "T";
		txt_ref34.checked = true;
	}else{ 
		txt_ref34.value = "";
		txt_ref34.checked = false;
	}

	if (txt_ref45.checked) {
		txt_ref35.value = "T";
		txt_ref35.checked = true;
	}else{ 
		txt_ref35.value = "";
		txt_ref35.checked = false;
	}

	if (txt_ref46.checked) {
		txt_ref36.value = "T";
		txt_ref36.checked = true;
	}else{ 
		txt_ref36.value = "";
		txt_ref36.checked = false;
	}

	if (txt_ref47.checked) {
		txt_ref37.value = "T";
		txt_ref37.checked = true;
	}else{ 
		txt_ref37.value = "";
		txt_ref37.checked = false;
	}

	if (txt_ref48.checked) {
		txt_ref38.value = "T";
		txt_ref38.checked = true;
	}else{ 
		txt_ref38.value = "";
		txt_ref38.checked = false;
	}
}

/******************************************************************************
	Description : ����4 checked
******************************************************************************/
function ln_Chk_4(){
	//����4
	if (txt_ref52.checked) {
		txt_ref42.value = "T";
		txt_ref42.checked = true;
	}else{ 
		txt_ref42.value = "";
		txt_ref42.checked = false;
	}

	if (txt_ref53.checked) {
		txt_ref43.value = "T";
		txt_ref43.checked = true;
	}else{ 
		txt_ref43.value = "";
		txt_ref43.checked = false;
	}

	if (txt_ref54.checked) {
		txt_ref44.value = "T";
		txt_ref44.checked = true;
	}else{ 
		txt_ref44.value = "";
		txt_ref44.checked = false;
	}

	if (txt_ref55.checked) {
		txt_ref45.value = "T";
		txt_ref45.checked = true;
	}else{ 
		txt_ref45.value = "";
		txt_ref45.checked = false;
	}

	if (txt_ref56.checked) {
		txt_ref46.value = "T";
		txt_ref46.checked = true;
	}else{ 
		txt_ref46.value = "";
		txt_ref46.checked = false;
	}

	if (txt_ref57.checked) {
		txt_ref47.value = "T";
		txt_ref47.checked = true;
	}else{ 
		txt_ref47.value = "";
		txt_ref47.checked = false;
	}

	if (txt_ref58.checked) {
		txt_ref48.value = "T";
		txt_ref48.checked = true;
	}else{ 
		txt_ref48.value = "";
		txt_ref48.checked = false;
	}
}

/******************************************************************************
	Description : ����5 checked
******************************************************************************/
function ln_Chk_5(){
	//����5
	if (txt_ref62.checked) {
		txt_ref52.value = "T";
		txt_ref52.checked = true;
	}else{ 
		txt_ref52.value = "";
		txt_ref52.checked = false;
	}

	if (txt_ref63.checked) {
		txt_ref53.value = "T";
		txt_ref53.checked = true;
	}else{ 
		txt_ref53.value = "";
		txt_ref53.checked = false;
	}

	if (txt_ref64.checked) {
		txt_ref54.value = "T";
		txt_ref54.checked = true;
	}else{ 
		txt_ref54.value = "";
		txt_ref54.checked = false;
	}

	if (txt_ref65.checked) {
		txt_ref55.value = "T";
		txt_ref55.checked = true;
	}else{ 
		txt_ref55.value = "";
		txt_ref55.checked = false;
	}

	if (txt_ref66.checked) {
		txt_ref56.value = "T";
		txt_ref56.checked = true;
	}else{ 
		txt_ref56.value = "";
		txt_ref56.checked = false;
	}

	if (txt_ref67.checked) {
		txt_ref57.value = "T";
		txt_ref57.checked = true;
	}else{ 
		txt_ref57.value = "";
		txt_ref57.checked = false;
	}

	if (txt_ref68.checked) {
		txt_ref58.value = "T";
		txt_ref58.checked = true;
	}else{ 
		txt_ref58.value = "";
		txt_ref58.checked = false;
	}
}

/******************************************************************************
	Description : ����6 checked
******************************************************************************/
function ln_Chk_6(){
	//����6
	if (txt_ref72.checked) {
		txt_ref62.value = "T";
		txt_ref62.checked = true;
	}else{ 
		txt_ref62.value = "";
		txt_ref62.checked = false;
	}

	if (txt_ref73.checked) {
		txt_ref63.value = "T";
		txt_ref63.checked = true;
	}else{ 
		txt_ref63.value = "";
		txt_ref63.checked = false;
	}

	if (txt_ref74.checked) {
		txt_ref64.value = "T";
		txt_ref64.checked = true;
	}else{ 
		txt_ref64.value = "";
		txt_ref64.checked = false;
	}

	if (txt_ref75.checked) {
		txt_ref65.value = "T";
		txt_ref65.checked = true;
	}else{ 
		txt_ref65.value = "";
		txt_ref65.checked = false;
	}

	if (txt_ref76.checked) {
		txt_ref66.value = "T";
		txt_ref66.checked = true;
	}else{ 
		txt_ref66.value = "";
		txt_ref66.checked = false;
	}

	if (txt_ref77.checked) {
		txt_ref67.value = "T";
		txt_ref67.checked = true;
	}else{ 
		txt_ref67.value = "";
		txt_ref67.checked = false;
	}

	if (txt_ref78.checked) {
		txt_ref68.value = "T";
		txt_ref68.checked = true;
	}else{ 
		txt_ref68.value = "";
		txt_ref68.checked = false;
	}
}

/******************************************************************************
	Description : ����7 checked
******************************************************************************/
function ln_Chk_7(){
	//����7
	if (txt_ref82.checked) {
		txt_ref72.value = "T";
		txt_ref72.checked = true;
	}else{ 
		txt_ref72.value = "";
		txt_ref72.checked = false;
	}

	if (txt_ref83.checked) {
		txt_ref73.value = "T";
		txt_ref73.checked = true;
	}else{ 
		txt_ref73.value = "";
		txt_ref73.checked = false;
	}

	if (txt_ref84.checked) {
		txt_ref74.value = "T";
		txt_ref74.checked = true;
	}else{ 
		txt_ref74.value = "";
		txt_ref74.checked = false;
	}

	if (txt_ref85.checked) {
		txt_ref75.value = "T";
		txt_ref75.checked = true;
	}else{ 
		txt_ref75.value = "";
		txt_ref75.checked = false;
	}

	if (txt_ref86.checked) {
		txt_ref76.value = "T";
		txt_ref76.checked = true;
	}else{ 
		txt_ref76.value = "";
		txt_ref76.checked = false;
	}

	if (txt_ref87.checked) {
		txt_ref77.value = "T";
		txt_ref77.checked = true;
	}else{ 
		txt_ref77.value = "";
		txt_ref77.checked = false;
	}

	if (txt_ref88.checked) {
		txt_ref78.value = "T";
		txt_ref78.checked = true;
	}else{ 
		txt_ref78.value = "";
		txt_ref78.checked = false;
	}
}

/******************************************************************************
	Description : ����8 checked
******************************************************************************/
function ln_Chk_8(){
	//����8
	if (txt_ref92.checked) {
		txt_ref82.value = "T";
		txt_ref82.checked = true;
	}else{ 
		txt_ref82.value = "";
		txt_ref82.checked = false;
	}

	if (txt_ref93.checked) {
		txt_ref83.value = "T";
		txt_ref83.checked = true;
	}else{ 
		txt_ref83.value = "";
		txt_ref83.checked = false;
	}

	if (txt_ref94.checked) {
		txt_ref84.value = "T";
		txt_ref84.checked = true;
	}else{ 
		txt_ref84.value = "";
		txt_ref84.checked = false;
	}

	if (txt_ref95.checked) {
		txt_ref85.value = "T";
		txt_ref85.checked = true;
	}else{ 
		txt_ref85.value = "";
		txt_ref85.checked = false;
	}

	if (txt_ref96.checked) {
		txt_ref86.value = "T";
		txt_ref86.checked = true;
	}else{ 
		txt_ref86.value = "";
		txt_ref86.checked = false;
	}

	if (txt_ref97.checked) {
		txt_ref87.value = "T";
		txt_ref87.checked = true;
	}else{ 
		txt_ref87.value = "";
		txt_ref87.checked = false;
	}

	if (txt_ref98.checked) {
		txt_ref88.value = "T";
		txt_ref88.checked = true;
	}else{ 
		txt_ref88.value = "";
		txt_ref88.checked = false;
	}
}

/******************************************************************************
	Description : �ξ簡�� ����
******************************************************************************/
function ln_Chk2(){

	//����1
	if (txt_ref12.checked) txt_ref12.value = "T";
	else txt_ref12.value = "";

	if (txt_ref13.checked) txt_ref13.value = "T";
	else txt_ref13.value = "";

	if (txt_ref14.checked) txt_ref14.value = "T";
	else txt_ref14.value = "";

	/*if (txt_ref15.checked) txt_ref15.value = "T";
	else txt_ref15.value = "";

	if (txt_ref16.checked) txt_ref16.value = "T";
	else txt_ref16.value = "";

	if (txt_ref17.checked) txt_ref17.value = "T";
	else txt_ref17.value = "";

	if (txt_ref18.checked) txt_ref18.value = "T";
	else txt_ref18.value = "";
*/
	//����2
	if (txt_ref22.checked) txt_ref22.value = "T";
	else txt_ref22.value = "";

	if (txt_ref23.checked) txt_ref23.value = "T";
	else txt_ref23.value = "";

	if (txt_ref24.checked) txt_ref24.value = "T";
	else txt_ref24.value = "";

/*	if (txt_ref25.checked) txt_ref25.value = "T";
	else txt_ref25.value = "";

	if (txt_ref26.checked) txt_ref26.value = "T";
	else txt_ref26.value = "";

	if (txt_ref27.checked) txt_ref27.value = "T";
	else txt_ref27.value = "";

	if (txt_ref28.checked) txt_ref28.value = "T";
	else txt_ref28.value = "";
*/
	//����3
	if (txt_ref32.checked) txt_ref32.value = "T";
	else txt_ref32.value = "";

	if (txt_ref33.checked) txt_ref33.value = "T";
	else txt_ref33.value = "";

	if (txt_ref34.checked) txt_ref34.value = "T";
	else txt_ref34.value = "";

/*	if (txt_ref35.checked) txt_ref35.value = "T";
	else txt_ref35.value = "";

	if (txt_ref36.checked) txt_ref36.value = "T";
	else txt_ref36.value = "";

	if (txt_ref37.checked) txt_ref37.value = "T";
	else txt_ref37.value = "";

	if (txt_ref38.checked) txt_ref38.value = "T";
	else txt_ref38.value = "";
*/
	//����4
	if (txt_ref42.checked) txt_ref42.value = "T";
	else txt_ref42.value = "";

	if (txt_ref43.checked) txt_ref43.value = "T";
	else txt_ref43.value = "";

	if (txt_ref44.checked) txt_ref44.value = "T";
	else txt_ref44.value = "";

/*	if (txt_ref45.checked) txt_ref45.value = "T";
	else txt_ref45.value = "";

	if (txt_ref46.checked) txt_ref46.value = "T";
	else txt_ref46.value = "";

	if (txt_ref47.checked) txt_ref47.value = "T";
	else txt_ref47.value = "";

	if (txt_ref48.checked) txt_ref48.value = "T";
	else txt_ref48.value = "";
*/
	//����5
	if (txt_ref52.checked) txt_ref52.value = "T";
	else txt_ref52.value = "";

	if (txt_ref53.checked) txt_ref53.value = "T";
	else txt_ref53.value = "";

	if (txt_ref54.checked) txt_ref54.value = "T";
	else txt_ref54.value = "";

/*	if (txt_ref55.checked) txt_ref55.value = "T";
	else txt_ref55.value = "";

	if (txt_ref56.checked) txt_ref56.value = "T";
	else txt_ref56.value = "";

	if (txt_ref57.checked) txt_ref57.value = "T";
	else txt_ref57.value = "";

	if (txt_ref58.checked) txt_ref58.value = "T";
	else txt_ref58.value = "";
*/
	//����6
	if (txt_ref62.checked) txt_ref62.value = "T";
	else txt_ref62.value = "";

	if (txt_ref63.checked) txt_ref63.value = "T";
	else txt_ref63.value = "";

	if (txt_ref64.checked) txt_ref64.value = "T";
	else txt_ref64.value = "";

/*	if (txt_ref65.checked) txt_ref65.value = "T";
	else txt_ref65.value = "";

	if (txt_ref66.checked) txt_ref66.value = "T";
	else txt_ref66.value = "";

	if (txt_ref67.checked) txt_ref67.value = "T";
	else txt_ref67.value = "";

	if (txt_ref68.checked) txt_ref68.value = "T";
	else txt_ref68.value = "";
*/
	//����7
	if (txt_ref72.checked) txt_ref72.value = "T";
	else txt_ref72.value = "";

	if (txt_ref73.checked) txt_ref73.value = "T";
	else txt_ref73.value = "";

	if (txt_ref74.checked) txt_ref74.value = "T";
	else txt_ref74.value = "";

/*	if (txt_ref75.checked) txt_ref75.value = "T";
	else txt_ref75.value = "";

	if (txt_ref76.checked) txt_ref76.value = "T";
	else txt_ref76.value = "";

	if (txt_ref77.checked) txt_ref77.value = "T";
	else txt_ref77.value = "";

	if (txt_ref78.checked) txt_ref78.value = "T";
	else txt_ref78.value = "";
*/
	//����8
	if (txt_ref82.checked) txt_ref82.value = "T";
	else txt_ref82.value = "";

	if (txt_ref83.checked) txt_ref83.value = "T";
	else txt_ref83.value = "";

	if (txt_ref84.checked) txt_ref84.value = "T";
	else txt_ref84.value = "";

/*	if (txt_ref85.checked) txt_ref85.value = "T";
	else txt_ref85.value = "";

	if (txt_ref86.checked) txt_ref86.value = "T";
	else txt_ref86.value = "";

	if (txt_ref87.checked) txt_ref87.value = "T";
	else txt_ref87.value = "";

	if (txt_ref88.checked) txt_ref88.value = "T";
	else txt_ref88.value = "";
*/
}

/******************************************************************************
	Description : üũ
******************************************************************************/
function ln_Chk3(){


	//����1
	if (gcds_data.namevalue(gcds_data.rowposition,"REF12") == "T") txt_ref12.checked = true;
	else txt_ref12.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF13") == "T") txt_ref13.checked = true;
	else txt_ref13.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF14") == "T") txt_ref14.checked = true;
	else txt_ref14.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF15") == "T") txt_ref15.checked = true;
	//else txt_ref15.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF16") == "T") txt_ref16.checked = true;
	//else txt_ref16.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF17") == "T") txt_ref17.checked = true;
	//else txt_ref17.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF18") == "T") txt_ref18.checked = true;
	//else txt_ref18.checked = false;

	//����2
	if (gcds_data.namevalue(gcds_data.rowposition,"REF22") == "T") txt_ref22.checked = true;
	else txt_ref22.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF23") == "T") txt_ref23.checked = true;
	else txt_ref23.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF24") == "T") txt_ref24.checked = true;
	else txt_ref24.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF25") == "T") txt_ref25.checked = true;
	//else txt_ref25.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF26") == "T") txt_ref26.checked = true;
	//else txt_ref26.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF27") == "T") txt_ref27.checked = true;
	//else txt_ref27.checked = false;

	//if (gcds_data.namevalue(gcds_data.rowposition,"REF28") == "T") txt_ref28.checked = true;
	//else txt_ref28.checked = false;

	//����3
	if (gcds_data.namevalue(gcds_data.rowposition,"REF32") == "T") txt_ref32.checked = true;
	else txt_ref32.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF33") == "T") txt_ref33.checked = true;
	else txt_ref33.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF34") == "T") txt_ref34.checked = true;
	else txt_ref34.checked = false;

	/*if (gcds_data.namevalue(gcds_data.rowposition,"REF35") == "T") txt_ref35.checked = true;
	else txt_ref35.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF36") == "T") txt_ref36.checked = true;
	else txt_ref36.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF37") == "T") txt_ref37.checked = true;
	else txt_ref37.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF38") == "T") txt_ref38.checked = true;
	else txt_ref38.checked = false;
*/
	//����4
	if (gcds_data.namevalue(gcds_data.rowposition,"REF42") == "T") txt_ref42.checked = true;
	else txt_ref42.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF43") == "T") txt_ref43.checked = true;
	else txt_ref43.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF44") == "T") txt_ref44.checked = true;
	else txt_ref44.checked = false;

	/*if (gcds_data.namevalue(gcds_data.rowposition,"REF45") == "T") txt_ref45.checked = true;
	else txt_ref45.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF46") == "T") txt_ref46.checked = true;
	else txt_ref46.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF47") == "T") txt_ref47.checked = true;
	else txt_ref47.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF48") == "T") txt_ref48.checked = true;
	else txt_ref48.checked = false;
*/
	//����5
	if (gcds_data.namevalue(gcds_data.rowposition,"REF52") == "T") txt_ref52.checked = true;
	else txt_ref52.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF53") == "T") txt_ref53.checked = true;
	else txt_ref53.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF54") == "T") txt_ref54.checked = true;
	else txt_ref54.checked = false;

	/*if (gcds_data.namevalue(gcds_data.rowposition,"REF55") == "T") txt_ref55.checked = true;
	else txt_ref55.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF56") == "T") txt_ref56.checked = true;
	else txt_ref56.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF57") == "T") txt_ref57.checked = true;
	else txt_ref57.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF58") == "T") txt_ref58.checked = true;
	else txt_ref58.checked = false;
*/
	//����6
	if (gcds_data.namevalue(gcds_data.rowposition,"REF62") == "T") txt_ref62.checked = true;
	else txt_ref62.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF63") == "T") txt_ref63.checked = true;
	else txt_ref63.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF64") == "T") txt_ref64.checked = true;
	else txt_ref64.checked = false;

	/*if (gcds_data.namevalue(gcds_data.rowposition,"REF65") == "T") txt_ref65.checked = true;
	else txt_ref65.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF66") == "T") txt_ref66.checked = true;
	else txt_ref66.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF67") == "T") txt_ref67.checked = true;
	else txt_ref67.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF68") == "T") txt_ref68.checked = true;
	else txt_ref68.checked = false;
*/
	//����7
	if (gcds_data.namevalue(gcds_data.rowposition,"REF72") == "T") txt_ref72.checked = true;
	else txt_ref72.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF73") == "T") txt_ref73.checked = true;
	else txt_ref73.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF74") == "T") txt_ref74.checked = true;
	else txt_ref74.checked = false;

/*	if (gcds_data.namevalue(gcds_data.rowposition,"REF75") == "T") txt_ref75.checked = true;
	else txt_ref75.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF76") == "T") txt_ref76.checked = true;
	else txt_ref76.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF77") == "T") txt_ref77.checked = true;
	else txt_ref77.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF78") == "T") txt_ref78.checked = true;
	else txt_ref78.checked = false;
*/
	//����8
	if (gcds_data.namevalue(gcds_data.rowposition,"REF82") == "T") txt_ref82.checked = true;
	else txt_ref82.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF83") == "T") txt_ref83.checked = true;
	else txt_ref83.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF84") == "T") txt_ref84.checked = true;
	else txt_ref84.checked = false;

/*	if (gcds_data.namevalue(gcds_data.rowposition,"REF85") == "T") txt_ref85.checked = true;
	else txt_ref85.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF86") == "T") txt_ref86.checked = true;
	else txt_ref86.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF87") == "T") txt_ref87.checked = true;
	else txt_ref87.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF88") == "T") txt_ref88.checked = true;
	else txt_ref88.checked = false;
*/
	//����9
	if (gcds_data.namevalue(gcds_data.rowposition,"REF92") == "T") txt_ref92.checked = true;
	else txt_ref92.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF93") == "T") txt_ref93.checked = true;
	else txt_ref93.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF94") == "T") txt_ref94.checked = true;
	else txt_ref94.checked = false;

/*	if (gcds_data.namevalue(gcds_data.rowposition,"REF95") == "T") txt_ref95.checked = true;
	else txt_ref95.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF96") == "T") txt_ref96.checked = true;
	else txt_ref96.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF97") == "T") txt_ref97.checked = true;
	else txt_ref97.checked = false;

	if (gcds_data.namevalue(gcds_data.rowposition,"REF98") == "T") txt_ref98.checked = true;
	else txt_ref98.checked = false;
*/
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_t1";
		gctr_data.post();
	}
}

function ln_Delete2(){
	if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
		gcds_data2.deleterow(gcds_data2.rowposition);
		gctr_data2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_t2";
		gctr_data2.post();
	}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ��� - �ҵ��ں��ٷμҵ��õ¡��
******************************************************************************/
function ln_PrintLevy() {

	var str1 = fn_trim(txt_empnmk1.value);	//���
	var str2 = gcem_curdt.text;							//�ͼӳ⵵

	if (gcds_data.countrow<1) {	alert("����Ͻ� �ڷᰡ �����ϴ�");
	}else{
		gcds_print.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_s3?v_str1="+str1
																													+"&v_str2="+str2
																													+"&v_str3="+gs_date
																													+"&v_str4="+gclx_deptcd.bindcolval;
		gcds_print.Reset();
	}
}

/******************************************************************************
	Description : ��� - �Ƿ�� ������
******************************************************************************/
function ln_Print2() {
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";

	var str1 = fn_trim(txt_empnmk1.value);	//����
	var str2 = gcem_curdt.text;							//�ͼӳ⵵

	gcds_print2.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_s4?v_str1="+str1
																												 +"&v_str2="+str2
																												 +"&v_str3="+gs_date;
	gcds_print2.Reset();

}

/******************************************************************************
	Description : ��� - �Ƿ�� ������(�ҵ��� ��������)
******************************************************************************/
function ln_Print2_1() {

	var str1 = fn_trim(txt_empnmk1.value);	//���
	var str2 = gcem_curdt.text;							//�ͼӳ⵵
	var str3 = gclx_deptcd.bindcolval;			//�μ�

	gcds_print2_1.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_s7?v_str1="+str1
																												 +"&v_str2="+str2
																												 +"&v_str3="+str3
																												 +"&v_str4="+gs_date;
	gcds_print2_1.Reset();

}

/******************************************************************************
	Description : ��� - ��α� ������
******************************************************************************/
function ln_Print3() {
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";

	var str1 = fn_trim(txt_empnmk1.value);	//���
	var str2 = gcem_curdt.text;							//�ͼӳ⵵
	//var str3 = gclx_deptcd.bindcolval;			//�μ�

	gcds_print3.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_s5?v_str1="+str1
																												 +"&v_str2="+str2
																												 +"&v_str3="+gs_date;
	gcds_print3.Reset();
}

/******************************************************************************
	Description : ��� - ��α� ������(�ҵ��� ��������)
******************************************************************************/
function ln_Print3_1() {
	
	var str1 = fn_trim(txt_empnmk1.value);	//���
	var str2 = gcem_curdt.text;							//�ͼӳ⵵
	var str3 = gclx_deptcd.bindcolval;			//�μ�

	gcds_print3_1.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030002_s6?v_str1="+str1
																												 +"&v_str2="+str2
																												 +"&v_str3="+str3
																												 +"&v_str4="+gs_date;
	gcds_print3_1.Reset();

}	

/******************************************************************************
	Description : ��� - �Ƿ�� ������
******************************************************************************/
function ln_RptFormat(e) {

	var ls_for = "";

	ls_for += "<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2731 ,face='Arial' ,size=10 ,penwidth=1																																																																																																					";
	ls_for += "	<X>left=31 ,top=69 ,right=338 ,bottom=147 ,border=true</X>																																																																																																																			";
	ls_for += "		<T>id='����� ���α� �赿 ������� 140-2' ,left=250 ,top=366 ,right=1669 ,bottom=456 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																									";
	ls_for += "		<T>id='101-85-10695'				,left=994 ,top=266	,right=1669	,bottom=356	,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																			";
	ls_for += "		<T>id='����ƻ�(��)'				,left=250 ,top=266	,right=613	,bottom=356 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																				";
	ls_for += "		<T>id='2)����ڵ�Ϲ�ȣ'		,left=622 ,top=266	,right=969	,bottom=356 ,face='����'	,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																									";
	ls_for += "		<T>id='��. �Ƿ�� ���޳���' ,left=13	,top=762	,right=1872	,bottom=844 ,align='left' ,face='HY�߰���' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																															";
	ls_for += "		<T>id='(�ܱ���Ȯ�ι�ȣ)'		,left=622 ,top=612	,right=969	,bottom=653 ,face='����'	,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																									";
	ls_for += "		<T>id='5)�ֹε�Ϲ�ȣ'			,left=622 ,top=562	,right=969	,bottom=606 ,face='����'	,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																										";
	ls_for += "		<T>id='6)��   ��'						,left=13	,top=662	,right=225	,bottom=753 ,face='����'	,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																													";
	ls_for += "		<T>id='4)��   ��'						,left=13	,top=562	,right=225	,bottom=653 ,face='����'	,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																													";
	ls_for += "		<T>id='1)��ü��'						,left=13	,top=266	,right=225	,bottom=356 ,face='����'	,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																													";
	ls_for += "		<T>id='3)������'						,left=13	,top=366	,right=225	,bottom=456 ,face='����'	,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																													";
	ls_for += "		<T>id='�ͼӿ���'						,left=38	,top=75		,right=181	,bottom=141 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																							";
	ls_for += "		<T>id='��. �ҵ���(�������� ��û��) ��������' ,left=13 ,top=466 ,right=1872 ,bottom=547 ,align='left' ,face='HY�߰���' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																						";
	ls_for += "		<T>id='��. ��õ¡���ǹ��� ��������' ,left=13 ,top=169 ,right=1872 ,bottom=250 ,align='left' ,face='HY�߰���' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																											";
	ls_for += "		<T>id='��  ��  ��  ��  ��  ��  ��  ��' ,left=356 ,top=56 ,right=1872 ,bottom=131 ,face='HY�߰���' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																";
	ls_for += "		<T>id='���� ��' ,left=1713 ,top=947 ,right=1869 ,bottom=991 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																												";
	ls_for += "		<T>id='�ش翩��' ,left=1713 ,top=987 ,right=1869 ,bottom=1031 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																											";
	ls_for += "		<T>id='��   ��   ��' ,left=13 ,top=947 ,right=369 ,bottom=991 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																												";
	ls_for += "		<T>id='�� �� �� ȣ' ,left=13 ,top=987 ,right=369 ,bottom=1031 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																													";
	ls_for += "		<T>id='�� �� �� �� �� ȣ' ,left=1378 ,top=941 ,right=1703 ,bottom=1031 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																							";
	ls_for += "		<T>id='����' ,left=1275 ,top=941 ,right=1369 ,bottom=1031 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																													";
	ls_for += "		<T>id='��           ��           ��' ,left=1275 ,top=866 ,right=1869 ,bottom=931 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																";
	ls_for += "		<T>id='�� �� �� ��' ,left=731 ,top=866 ,right=1047 ,bottom=931 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																											";
	ls_for += "		<T>id='��           ��           ó' ,left=13 ,top=866 ,right=722 ,bottom=931 ,face='����' ,size=11,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																													";
	ls_for += "		<T>id='�Ǽ�' ,left=731 ,top=941 ,right=834 ,bottom=1031 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																														";
	ls_for += "		<T>id='��  ��' ,left=847 ,top=941 ,right=1047 ,bottom=1031 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																												";
	ls_for += "		<C>id='YYYY', left=191, top=75, right=331, bottom=141 ,mask='XXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																																																									";
	ls_for += "		<C>id='RESINO', left=994, top=562, right=1872, bottom=653, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																																											";
	ls_for += "		<C>id='EMPNMK', left=250, top=562, right=613, bottom=653, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																																																							";
	ls_for += "		<C>id='ADDNM', left=250, top=662, right=1872, bottom=753, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																																																						";
	
	var hitemp = 72;
	
if (e<=10) {	//TAB-1
	ls_for += "	<C>id='INDNO_1',	left=13, top="+Number(1040)+", right=369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_2',	left=13, top="+Number(1040+hitemp*1)+", right=369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_3',	left=13, top="+Number(1040+hitemp*2)+", right=369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_4',	left=13, top="+Number(1040+hitemp*3)+", right=369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_5',	left=13, top="+Number(1040+hitemp*4)+", right=369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_6',	left=13, top="+Number(1040+hitemp*5)+", right=369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_7',	left=13, top="+Number(1040+hitemp*6)+", right=369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_8',	left=13, top="+Number(1040+hitemp*7)+", right=369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_9',	left=13, top="+Number(1040+hitemp*8)+", right=369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_10',	left=13, top="+Number(1040+hitemp*9)+", right=369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='INDNAME_1',	align='left',	left=378, top="+Number(1040)+", right=722, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_2',	align='left',	left=378, top="+Number(1040+hitemp*1)+", right=722, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_3',	align='left',	left=378, top="+Number(1040+hitemp*2)+", right=722, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_4',	align='left',	left=378, top="+Number(1040+hitemp*3)+", right=722, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_5',	align='left',	left=378, top="+Number(1040+hitemp*4)+", right=722, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_6',	align='left',	left=378, top="+Number(1040+hitemp*5)+", right=722, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_7',	align='left',	left=378, top="+Number(1040+hitemp*6)+", right=722, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_8',	align='left',	left=378, top="+Number(1040+hitemp*7)+", right=722, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_9',	align='left',	left=378, top="+Number(1040+hitemp*8)+", right=722, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_10',	align='left',	left=378, top="+Number(1040+hitemp*9)+", right=722, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	
	ls_for += "	<C>id={decode(CARDCNT_1,0,'',CARDCNT_1)},		left=731, top="+Number(1040)+", right=834, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_2,0,'',CARDCNT_2)},		left=731, top="+Number(1040+hitemp*1)+", right=834, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_3,0,'',CARDCNT_3)},		left=731, top="+Number(1040+hitemp*2)+", right=834, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_4,0,'',CARDCNT_4)},		left=731, top="+Number(1040+hitemp*3)+", right=834, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_5,0,'',CARDCNT_5)},		left=731, top="+Number(1040+hitemp*4)+", right=834, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_6,0,'',CARDCNT_6)},		left=731, top="+Number(1040+hitemp*5)+", right=834, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_7,0,'',CARDCNT_7)},		left=731, top="+Number(1040+hitemp*6)+", right=834, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_8,0,'',CARDCNT_8)},		left=731, top="+Number(1040+hitemp*7)+", right=834, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_9,0,'',CARDCNT_9)},		left=731, top="+Number(1040+hitemp*8)+", right=834, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_10,0,'',CARDCNT_10)},	left=731, top="+Number(1040+hitemp*9)+", right=834, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id={decode(CARDAMT_1,0,'',CARDAMT_1)},		align='right',	left=847, top="+Number(1040)+", right=1047, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_2,0,'',CARDAMT_2)},		align='right',	left=847, top="+Number(1040+hitemp*1)+", right=1047, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_3,0,'',CARDAMT_3)},		align='right',	left=847, top="+Number(1040+hitemp*2)+", right=1047, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_4,0,'',CARDAMT_4)},		align='right',	left=847, top="+Number(1040+hitemp*3)+", right=1047, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_5,0,'',CARDAMT_5)},		align='right',	left=847, top="+Number(1040+hitemp*4)+", right=1047, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_6,0,'',CARDAMT_6)},		align='right',	left=847, top="+Number(1040+hitemp*5)+", right=1047, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_7,0,'',CARDAMT_7)},		align='right',	left=847, top="+Number(1040+hitemp*6)+", right=1047, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_8,0,'',CARDAMT_8)},		align='right',	left=847, top="+Number(1040+hitemp*7)+", right=1047, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_9,0,'',CARDAMT_9)},		align='right',	left=847, top="+Number(1040+hitemp*8)+", right=1047, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_10,0,'',CARDAMT_10)},	align='right',	left=847, top="+Number(1040+hitemp*9)+", right=1047, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='RELATION_1',	left=1275, top="+Number(1040)+", right=1369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_2',	left=1275, top="+Number(1040+hitemp*1)+", right=1369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_3',	left=1275, top="+Number(1040+hitemp*2)+", right=1369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_4',	left=1275, top="+Number(1040+hitemp*3)+", right=1369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_5',	left=1275, top="+Number(1040+hitemp*4)+", right=1369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_6',	left=1275, top="+Number(1040+hitemp*5)+", right=1369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_7',	left=1275, top="+Number(1040+hitemp*6)+", right=1369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_8',	left=1275, top="+Number(1040+hitemp*7)+", right=1369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_9',	left=1275, top="+Number(1040+hitemp*8)+", right=1369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_10',	left=1275, top="+Number(1040+hitemp*9)+", right=1369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='JUMINNO_1',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040)+", right=1703, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_2',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*1)+", right=1703, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_3',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*2)+", right=1703, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_4',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*3)+", right=1703, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_5',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*4)+", right=1703, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_6',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*5)+", right=1703, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_7',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*6)+", right=1703, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_8',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*7)+", right=1703, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_9',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*8)+", right=1703, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_10',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*9)+", right=1703, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='EMPCHK_1',	left=1713, top="+Number(1040)+", right=1869, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_2',	left=1713, top="+Number(1040+hitemp*1)+", right=1869, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_3',	left=1713, top="+Number(1040+hitemp*2)+", right=1869, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_4',	left=1713, top="+Number(1040+hitemp*3)+", right=1869, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_5',	left=1713, top="+Number(1040+hitemp*4)+", right=1869, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_6',	left=1713, top="+Number(1040+hitemp*5)+", right=1869, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_7',	left=1713, top="+Number(1040+hitemp*6)+", right=1869, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_8',	left=1713, top="+Number(1040+hitemp*7)+", right=1869, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_9',	left=1713, top="+Number(1040+hitemp*8)+", right=1869, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_10',	left=1713, top="+Number(1040+hitemp*9)+", right=1869, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
}//End TAB-1

	if (e>10 && e<=20) {	//TAB-2
	ls_for += "	<C>id='INDNO_11',	left=13, top="+Number(1040)+", right=369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_12',	left=13, top="+Number(1040+hitemp*1)+", right=369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_13',	left=13, top="+Number(1040+hitemp*2)+", right=369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_14',	left=13, top="+Number(1040+hitemp*3)+", right=369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_15',	left=13, top="+Number(1040+hitemp*4)+", right=369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_16',	left=13, top="+Number(1040+hitemp*5)+", right=369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_17',	left=13, top="+Number(1040+hitemp*6)+", right=369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_18',	left=13, top="+Number(1040+hitemp*7)+", right=369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_19',	left=13, top="+Number(1040+hitemp*8)+", right=369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_20',	left=13, top="+Number(1040+hitemp*9)+", right=369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='INDNAME_11',	align='left',	left=378, top="+Number(1040)+", right=722, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_12',	align='left',	left=378, top="+Number(1040+hitemp*1)+", right=722, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_13',	align='left',	left=378, top="+Number(1040+hitemp*2)+", right=722, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_14',	align='left',	left=378, top="+Number(1040+hitemp*3)+", right=722, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_15',	align='left',	left=378, top="+Number(1040+hitemp*4)+", right=722, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_16',	align='left',	left=378, top="+Number(1040+hitemp*5)+", right=722, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_17',	align='left',	left=378, top="+Number(1040+hitemp*6)+", right=722, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_18',	align='left',	left=378, top="+Number(1040+hitemp*7)+", right=722, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_19',	align='left',	left=378, top="+Number(1040+hitemp*8)+", right=722, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_20',	align='left',	left=378, top="+Number(1040+hitemp*9)+", right=722, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id={decode(CARDCNT_11,0,'',CARDCNT_11)},	left=731, top="+Number(1040)+", right=834, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_12,0,'',CARDCNT_12)},	left=731, top="+Number(1040+hitemp*1)+", right=834, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_13,0,'',CARDCNT_13)},	left=731, top="+Number(1040+hitemp*2)+", right=834, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_14,0,'',CARDCNT_14)},	left=731, top="+Number(1040+hitemp*3)+", right=834, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_15,0,'',CARDCNT_15)},	left=731, top="+Number(1040+hitemp*4)+", right=834, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_16,0,'',CARDCNT_16)},	left=731, top="+Number(1040+hitemp*5)+", right=834, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_17,0,'',CARDCNT_17)},	left=731, top="+Number(1040+hitemp*6)+", right=834, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_18,0,'',CARDCNT_18)},	left=731, top="+Number(1040+hitemp*7)+", right=834, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_19,0,'',CARDCNT_19)},	left=731, top="+Number(1040+hitemp*8)+", right=834, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_20,0,'',CARDCNT_20)},	left=731, top="+Number(1040+hitemp*9)+", right=834, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	
	ls_for += "	<C>id={decode(CARDAMT_11,0,'',CARDAMT_11)},	align='right',	left=847, top="+Number(1040)+", right=1047, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_12,0,'',CARDAMT_12)},	align='right',	left=847, top="+Number(1040+hitemp*1)+", right=1047, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_13,0,'',CARDAMT_13)},	align='right',	left=847, top="+Number(1040+hitemp*2)+", right=1047, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_14,0,'',CARDAMT_14)},	align='right',	left=847, top="+Number(1040+hitemp*3)+", right=1047, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_15,0,'',CARDAMT_15)},	align='right',	left=847, top="+Number(1040+hitemp*4)+", right=1047, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_16,0,'',CARDAMT_16)},	align='right',	left=847, top="+Number(1040+hitemp*5)+", right=1047, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_17,0,'',CARDAMT_17)},	align='right',	left=847, top="+Number(1040+hitemp*6)+", right=1047, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_18,0,'',CARDAMT_18)},	align='right',	left=847, top="+Number(1040+hitemp*7)+", right=1047, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_19,0,'',CARDAMT_19)},	align='right',	left=847, top="+Number(1040+hitemp*8)+", right=1047, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_20,0,'',CARDAMT_20)},	align='right',	left=847, top="+Number(1040+hitemp*9)+", right=1047, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='RELATION_11',	left=1275, top="+Number(1040)+", right=1369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_12',	left=1275, top="+Number(1040+hitemp*1)+", right=1369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_13',	left=1275, top="+Number(1040+hitemp*2)+", right=1369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_14',	left=1275, top="+Number(1040+hitemp*3)+", right=1369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_15',	left=1275, top="+Number(1040+hitemp*4)+", right=1369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_16',	left=1275, top="+Number(1040+hitemp*5)+", right=1369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_17',	left=1275, top="+Number(1040+hitemp*6)+", right=1369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_18',	left=1275, top="+Number(1040+hitemp*7)+", right=1369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_19',	left=1275, top="+Number(1040+hitemp*8)+", right=1369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_20',	left=1275, top="+Number(1040+hitemp*9)+", right=1369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='JUMINNO_11',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040)+", right=1703, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_12',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*1)+", right=1703, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_13',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*2)+", right=1703, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_14',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*3)+", right=1703, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_15',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*4)+", right=1703, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_16',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*5)+", right=1703, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_17',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*6)+", right=1703, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_18',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*7)+", right=1703, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_19',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*8)+", right=1703, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_20',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*9)+", right=1703, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='EMPCHK_11',	left=1713, top="+Number(1040)+", right=1869, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_12',	left=1713, top="+Number(1040+hitemp*1)+", right=1869, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_13',	left=1713, top="+Number(1040+hitemp*2)+", right=1869, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_14',	left=1713, top="+Number(1040+hitemp*3)+", right=1869, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_15',	left=1713, top="+Number(1040+hitemp*4)+", right=1869, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_16',	left=1713, top="+Number(1040+hitemp*5)+", right=1869, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_17',	left=1713, top="+Number(1040+hitemp*6)+", right=1869, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_18',	left=1713, top="+Number(1040+hitemp*7)+", right=1869, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_19',	left=1713, top="+Number(1040+hitemp*8)+", right=1869, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_20',	left=1713, top="+Number(1040+hitemp*9)+", right=1869, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
}//End TAB-2

	if (e>20 && e<=30) {	//TAB-3
	ls_for += "	<C>id='INDNO_21',	left=13, top="+Number(1040)+", right=369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_22',	left=13, top="+Number(1040+hitemp*1)+", right=369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_23',	left=13, top="+Number(1040+hitemp*2)+", right=369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_24',	left=13, top="+Number(1040+hitemp*3)+", right=369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_25',	left=13, top="+Number(1040+hitemp*4)+", right=369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_26',	left=13, top="+Number(1040+hitemp*5)+", right=369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_27',	left=13, top="+Number(1040+hitemp*6)+", right=369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_28',	left=13, top="+Number(1040+hitemp*7)+", right=369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_29',	left=13, top="+Number(1040+hitemp*8)+", right=369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_30',	left=13, top="+Number(1040+hitemp*9)+", right=369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='INDNAME_21',	align='left',	left=378, top="+Number(1040)+", right=722, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_22',	align='left',	left=378, top="+Number(1040+hitemp*1)+", right=722, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_23',	align='left',	left=378, top="+Number(1040+hitemp*2)+", right=722, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_24',	align='left',	left=378, top="+Number(1040+hitemp*3)+", right=722, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_25',	align='left',	left=378, top="+Number(1040+hitemp*4)+", right=722, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_26',	align='left',	left=378, top="+Number(1040+hitemp*5)+", right=722, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_27',	align='left',	left=378, top="+Number(1040+hitemp*6)+", right=722, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_28',	align='left',	left=378, top="+Number(1040+hitemp*7)+", right=722, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_29',	align='left',	left=378, top="+Number(1040+hitemp*8)+", right=722, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_30',	align='left',	left=378, top="+Number(1040+hitemp*9)+", right=722, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id={decode(CARDCNT_21,0,'',CARDCNT_21)},	left=731, top="+Number(1040)+", right=834, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_22,0,'',CARDCNT_22)},	left=731, top="+Number(1040+hitemp*1)+", right=834, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_23,0,'',CARDCNT_23)},	left=731, top="+Number(1040+hitemp*2)+", right=834, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_24,0,'',CARDCNT_24)},	left=731, top="+Number(1040+hitemp*3)+", right=834, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_25,0,'',CARDCNT_25)},	left=731, top="+Number(1040+hitemp*4)+", right=834, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_26,0,'',CARDCNT_26)},	left=731, top="+Number(1040+hitemp*5)+", right=834, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_27,0,'',CARDCNT_27)},	left=731, top="+Number(1040+hitemp*6)+", right=834, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_28,0,'',CARDCNT_28)},	left=731, top="+Number(1040+hitemp*7)+", right=834, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_29,0,'',CARDCNT_29)},	left=731, top="+Number(1040+hitemp*8)+", right=834, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_30,0,'',CARDCNT_30)},	left=731, top="+Number(1040+hitemp*9)+", right=834, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	
	ls_for += "	<C>id={decode(CARDAMT_21,0,'',CARDAMT_21)},	align='right',	left=847, top="+Number(1040)+", right=1047, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_22,0,'',CARDAMT_22)},	align='right',	left=847, top="+Number(1040+hitemp*1)+", right=1047, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_23,0,'',CARDAMT_23)},	align='right',	left=847, top="+Number(1040+hitemp*2)+", right=1047, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_24,0,'',CARDAMT_24)},	align='right',	left=847, top="+Number(1040+hitemp*3)+", right=1047, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_25,0,'',CARDAMT_25)},	align='right',	left=847, top="+Number(1040+hitemp*4)+", right=1047, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_26,0,'',CARDAMT_26)},	align='right',	left=847, top="+Number(1040+hitemp*5)+", right=1047, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_27,0,'',CARDAMT_27)},	align='right',	left=847, top="+Number(1040+hitemp*6)+", right=1047, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_28,0,'',CARDAMT_28)},	align='right',	left=847, top="+Number(1040+hitemp*7)+", right=1047, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_29,0,'',CARDAMT_29)},	align='right',	left=847, top="+Number(1040+hitemp*8)+", right=1047, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_30,0,'',CARDAMT_30)},	align='right',	left=847, top="+Number(1040+hitemp*9)+", right=1047, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	
	ls_for += "	<C>id='RELATION_21',	left=1275, top="+Number(1040)+", right=1369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_22',	left=1275, top="+Number(1040+hitemp*1)+", right=1369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_23',	left=1275, top="+Number(1040+hitemp*2)+", right=1369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_24',	left=1275, top="+Number(1040+hitemp*3)+", right=1369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_25',	left=1275, top="+Number(1040+hitemp*4)+", right=1369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_26',	left=1275, top="+Number(1040+hitemp*5)+", right=1369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_27',	left=1275, top="+Number(1040+hitemp*6)+", right=1369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_28',	left=1275, top="+Number(1040+hitemp*7)+", right=1369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_29',	left=1275, top="+Number(1040+hitemp*8)+", right=1369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_30',	left=1275, top="+Number(1040+hitemp*9)+", right=1369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='JUMINNO_21',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040)+", right=1703, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_22',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*1)+", right=1703, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_23',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*2)+", right=1703, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_24',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*3)+", right=1703, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_25',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*4)+", right=1703, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_26',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*5)+", right=1703, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_27',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*6)+", right=1703, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_28',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*7)+", right=1703, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_29',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*8)+", right=1703, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_30',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*9)+", right=1703, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='EMPCHK_21',	left=1713, top="+Number(1040)+", right=1869, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_22',	left=1713, top="+Number(1040+hitemp*1)+", right=1869, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_23',	left=1713, top="+Number(1040+hitemp*2)+", right=1869, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_24',	left=1713, top="+Number(1040+hitemp*3)+", right=1869, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_25',	left=1713, top="+Number(1040+hitemp*4)+", right=1869, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_26',	left=1713, top="+Number(1040+hitemp*5)+", right=1869, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_27',	left=1713, top="+Number(1040+hitemp*6)+", right=1869, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_28',	left=1713, top="+Number(1040+hitemp*7)+", right=1869, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_29',	left=1713, top="+Number(1040+hitemp*8)+", right=1869, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_30',	left=1713, top="+Number(1040+hitemp*9)+", right=1869, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
}//End TAB-3

	if (e>30 && e<=40) {	//TAB-4
	ls_for += "	<C>id='INDNO_31',	left=13, top="+Number(1040)+", right=369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_32',	left=13, top="+Number(1040+hitemp*1)+", right=369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_33',	left=13, top="+Number(1040+hitemp*2)+", right=369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_34',	left=13, top="+Number(1040+hitemp*3)+", right=369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_35',	left=13, top="+Number(1040+hitemp*4)+", right=369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_36',	left=13, top="+Number(1040+hitemp*5)+", right=369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_37',	left=13, top="+Number(1040+hitemp*6)+", right=369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_38',	left=13, top="+Number(1040+hitemp*7)+", right=369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_39',	left=13, top="+Number(1040+hitemp*8)+", right=369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNO_40',	left=13, top="+Number(1040+hitemp*9)+", right=369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	
	ls_for += "	<C>id='INDNAME_31',	align='left',	left=378, top="+Number(1040)+", right=722, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_32',	align='left',	left=378, top="+Number(1040+hitemp*1)+", right=722, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_33',	align='left',	left=378, top="+Number(1040+hitemp*2)+", right=722, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_34',	align='left',	left=378, top="+Number(1040+hitemp*3)+", right=722, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_35',	align='left',	left=378, top="+Number(1040+hitemp*4)+", right=722, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_36',	align='left',	left=378, top="+Number(1040+hitemp*5)+", right=722, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_37',	align='left',	left=378, top="+Number(1040+hitemp*6)+", right=722, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_38',	align='left',	left=378, top="+Number(1040+hitemp*7)+", right=722, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_39',	align='left',	left=378, top="+Number(1040+hitemp*8)+", right=722, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='INDNAME_40',	align='left',	left=378, top="+Number(1040+hitemp*9)+", right=722, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id={decode(CARDCNT_31,0,'',CARDCNT_31)},	left=731, top="+Number(1040)+", right=834, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_32,0,'',CARDCNT_32)},	left=731, top="+Number(1040+hitemp*1)+", right=834, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_33,0,'',CARDCNT_33)},	left=731, top="+Number(1040+hitemp*2)+", right=834, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_34,0,'',CARDCNT_34)},	left=731, top="+Number(1040+hitemp*3)+", right=834, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_35,0,'',CARDCNT_35)},	left=731, top="+Number(1040+hitemp*4)+", right=834, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_36,0,'',CARDCNT_36)},	left=731, top="+Number(1040+hitemp*5)+", right=834, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_37,0,'',CARDCNT_37)},	left=731, top="+Number(1040+hitemp*6)+", right=834, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_38,0,'',CARDCNT_38)},	left=731, top="+Number(1040+hitemp*7)+", right=834, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_39,0,'',CARDCNT_39)},	left=731, top="+Number(1040+hitemp*8)+", right=834, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDCNT_40,0,'',CARDCNT_40)},	left=731, top="+Number(1040+hitemp*9)+", right=834, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	
	ls_for += "	<C>id={decode(CARDAMT_31,0,'',CARDAMT_31)},	align='right',	left=847, top="+Number(1040)+", right=1047, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_32,0,'',CARDAMT_32)},	align='right',	left=847, top="+Number(1040+hitemp*1)+", right=1047, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_33,0,'',CARDAMT_33)},	align='right',	left=847, top="+Number(1040+hitemp*2)+", right=1047, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_34,0,'',CARDAMT_34)},	align='right',	left=847, top="+Number(1040+hitemp*3)+", right=1047, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_35,0,'',CARDAMT_35)},	align='right',	left=847, top="+Number(1040+hitemp*4)+", right=1047, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_36,0,'',CARDAMT_36)},	align='right',	left=847, top="+Number(1040+hitemp*5)+", right=1047, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_37,0,'',CARDAMT_37)},	align='right',	left=847, top="+Number(1040+hitemp*6)+", right=1047, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_38,0,'',CARDAMT_38)},	align='right',	left=847, top="+Number(1040+hitemp*7)+", right=1047, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_39,0,'',CARDAMT_39)},	align='right',	left=847, top="+Number(1040+hitemp*8)+", right=1047, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id={decode(CARDAMT_40,0,'',CARDAMT_40)},	align='right',	left=847, top="+Number(1040+hitemp*9)+", right=1047, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='RELATION_31',	left=1275, top="+Number(1040)+", right=1369, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_32',	left=1275, top="+Number(1040+hitemp*1)+", right=1369, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_33',	left=1275, top="+Number(1040+hitemp*2)+", right=1369, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_34',	left=1275, top="+Number(1040+hitemp*3)+", right=1369, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_35',	left=1275, top="+Number(1040+hitemp*4)+", right=1369, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_36',	left=1275, top="+Number(1040+hitemp*5)+", right=1369, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_37',	left=1275, top="+Number(1040+hitemp*6)+", right=1369, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_38',	left=1275, top="+Number(1040+hitemp*7)+", right=1369, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_39',	left=1275, top="+Number(1040+hitemp*8)+", right=1369, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='RELATION_40',	left=1275, top="+Number(1040+hitemp*9)+", right=1369, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='JUMINNO_31',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040)+", right=1703, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_32',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*1)+", right=1703, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_33',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*2)+", right=1703, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_34',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*3)+", right=1703, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_35',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*4)+", right=1703, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_36',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*5)+", right=1703, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_37',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*6)+", right=1703, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_38',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*7)+", right=1703, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_39',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*8)+", right=1703, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='JUMINNO_40',	mask='XXXXXX-XXXXXXX',	left=1378, top="+Number(1040+hitemp*9)+", right=1703, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";

	ls_for += "	<C>id='EMPCHK_31',	left=1713, top="+Number(1040)+", right=1869, bottom="+Number(1112)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_32',	left=1713, top="+Number(1040+hitemp*1)+", right=1869, bottom="+Number(1112+hitemp*1)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_33',	left=1713, top="+Number(1040+hitemp*2)+", right=1869, bottom="+Number(1112+hitemp*2)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_34',	left=1713, top="+Number(1040+hitemp*3)+", right=1869, bottom="+Number(1112+hitemp*3)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_35',	left=1713, top="+Number(1040+hitemp*4)+", right=1869, bottom="+Number(1112+hitemp*4)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_36',	left=1713, top="+Number(1040+hitemp*5)+", right=1869, bottom="+Number(1112+hitemp*5)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_37',	left=1713, top="+Number(1040+hitemp*6)+", right=1869, bottom="+Number(1112+hitemp*6)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_38',	left=1713, top="+Number(1040+hitemp*7)+", right=1869, bottom="+Number(1112+hitemp*7)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_39',	left=1713, top="+Number(1040+hitemp*8)+", right=1869, bottom="+Number(1112+hitemp*8)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
	ls_for += "	<C>id='EMPCHK_40',	left=1713, top="+Number(1040+hitemp*9)+", right=1869, bottom="+Number(1112+hitemp*9)+", face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                                                           ";
}//End TAB-4

	ls_for += "		<T>id='��       ȣ' ,left=378 ,top=941 ,right=722 ,bottom=1031 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																											";
	ls_for += "		<T>id='�� �Ƿ�� ���޳������� ������ ������ ������ �ۼ��մϴ�.' ,left=13 ,top=2519 ,right=1872 ,bottom=2572 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																													";
	ls_for += "		<T>id='�� ���� �� �ش翩�� : ���Ρ�����Ρ���ο���� \'1\' ǥ��, �� �̿��� �⺻��������� \'2\' ǥ��' ,left=13 ,top=2462 ,right=1872 ,bottom=2516 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>											";
	ls_for += "		<T>id='             (4,5,6�� ��� �ҵ��ڿ� ������� ������ ���� ������)' ,left=13 ,top=2406 ,right=1872 ,bottom=2459 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																									";
	ls_for += "		<T>id='�� ���� : ����=0, �ҵ��ڿ� ��������=1, ���������������=2, �����=3, ������=4, �����ڸ�=5, ��Ÿ=6' ,left=13 ,top=2350 ,right=1872 ,bottom=2403 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>								";
	ls_for += "		<T>id='    ��õ¡���ǹ��ڰ� �������� �ۼ��Ͽ� �����ϴ� �����Դϴ�.]' ,left=13 ,top=2294 ,right=1872 ,bottom=2347 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																											";
	ls_for += "		<T>id='    [�� ������  �ٷμҵ��ڰ� �ٷμҵ濬������ �ҵ������û���� �����ϰ�, �������� Ȯ�ε� ���׸���' ,left=13 ,top=2237 ,right=1872 ,bottom=2291 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>								";
	ls_for += "		<T>id='�� �Ƿ�����޳��� �� �Ƿ�� ������ ������ ���븸�� �����մϴ�.' ,left=13 ,top=2181 ,right=1872 ,bottom=2234 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																										";
	ls_for += "		<T>id='   ���񼭷� :  �Ƿ�����޿�����       ��' ,left=13 ,top=2125 ,right=1872 ,bottom=2178 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																					";
	ls_for += "		<T>id='  �ҵ漼�� ��52�� �� �ҵ漼������� ��110�� ��3�װ� ��113����1���� ������ ���Ͽ� �Ƿ�� ���� �ް��� ' ,left=44 ,top=1766 ,right=1872 ,bottom=1819 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>						";
	ls_for += "		<T>id=' �Ƿ�����޸������� �����մϴ�.' ,left=13 ,top=1822 ,right=1872 ,bottom=1875 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																									";
	ls_for += "		<T>id='����' ,left=416 ,top=2050 ,right=519 ,bottom=2109 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																							";
	ls_for += "		<T>id='�� �� ��' ,left=731 ,top=1984 ,right=928 ,bottom=2031 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																					";
	ls_for += "		<T>id='����ƻ�(��)' ,left=966 ,top=1984 ,right=1225 ,bottom=2031 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																		";
	ls_for += "		<T>id='(���� �Ǵ� ����)' ,left=1266 ,top=1984 ,right=1588 ,bottom=2031 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																";
	ls_for += "		<T>id='210mm x 297mm(�Ź����� 54g/��)' ,left=884 ,top=2594 ,right=1875 ,bottom=2634 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																									";
	ls_for += "		<T>id='�Ƿ����' ,left=1059 ,top=909 ,right=1266 ,bottom=953 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																												";
	ls_for += "		<T>id='��      ��' ,left=1059 ,top=950 ,right=1266 ,bottom=994 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																																																											";
	ls_for += "		<C>id='EMPNMK', left=175, top=2050, right=381, bottom=2109, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																																																						";
	ls_for += "		<T>id='"+gs_date4+"', left=697, top=1903, right=1103, bottom=1950, align='left' ,mask='XXXX��  XX��  XX��', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>																																					";
	ls_for += "		<L> left=6		,top=556 ,right=1881 ,bottom=556 </L>																																																																																																																						";
	ls_for += "		<L> left=184	,top=69  ,right=184  ,bottom=144 </L>																																																																																																																						";
	ls_for += "		<L> left=228	,top=262 ,right=228  ,bottom=459 </L>																																																																																																																						";
	ls_for += "		<L> left=975	,top=262 ,right=975  ,bottom=359 </L>																																																																																																																						";
	ls_for += "		<L> left=616	,top=262 ,right=616  ,bottom=359 </L>																																																																																																																						";
	ls_for += "		<L> left=3		,top=459 ,right=1878 ,bottom=459 </L>																																																																																																																						";
	ls_for += "		<L> left=3		,top=359 ,right=1878 ,bottom=359 </L>																																																																																																																						";
	ls_for += "		<L> left=3		,top=259 ,right=1878 ,bottom=259 </L>																																																																																																																						";
	ls_for += "		<L> left=3		,top=162 ,right=1878 ,bottom=162 </L>																																																																																																																						";
	ls_for += "		<L> left=3		,top=47  ,right=1878 ,bottom=47 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																																																															";
	ls_for += "		<L> left=3		,top=853 ,right=1878 ,bottom=853 </L>																																																																																																																						";
	ls_for += "		<L> left=1269 ,top=934 ,right=1878 ,bottom=934 </L>																																																																																																																						";
	ls_for += "		<L> left=1706 ,top=934 ,right=1706 ,bottom=1031 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=934 ,right=1053 ,bottom=934 </L>																																																																																																																						";
	ls_for += "		<L> left=3		,top=1034 ,right=1878 ,bottom=1034 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=934	,right=372	,bottom=1034 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=934	,right=1372 ,bottom=1031 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=853	,right=1053 ,bottom=1037 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=853	,right=1269 ,bottom=1034 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=934	,right=841	,bottom=1034 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=853	,right=725	,bottom=1034 </L>																																																																																																																					";
	ls_for += "		<L> left=0		,top=2119 ,right=1878 ,bottom=2119 </L>																																																																																																																					";
	ls_for += "		<L> left=0		,top=2581 ,right=1878 ,bottom=2581 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																																																														";
	ls_for += "		<L> left=1878 ,top=50		,right=1878 ,bottom=2581 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																																																														";
	ls_for += "		<L> left=3		,top=50		,right=3		,bottom=2581 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																																																														";
	ls_for += "		<L> left=3		,top=656	,right=1878 ,bottom=656 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=756	,right=1878 ,bottom=756 </L>																																																																																																																					";
	ls_for += "		<L> left=975	,top=556	,right=975	,bottom=656 </L>																																																																																																																					";
	ls_for += "		<L> left=616	,top=556	,right=616	,bottom=656 </L>																																																																																																																					";
	ls_for += "		<L> left=228	,top=556	,right=228	,bottom=756 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1681 ,right=1706 ,bottom=1753 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1681 ,right=372	,bottom=1753 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1681 ,right=1372 ,bottom=1753 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1681 ,right=1269 ,bottom=1753 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1681 ,right=1053 ,bottom=1753 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1681 ,right=841	,bottom=1753 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1609 ,right=1706 ,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1609 ,right=372	,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1681 ,right=1878 ,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1609 ,right=1372 ,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1609 ,right=1269 ,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1609 ,right=1053 ,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1609 ,right=841	,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1537 ,right=841	,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1537 ,right=1053 ,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1537 ,right=1269 ,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1537 ,right=1372 ,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1609 ,right=1878 ,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1537 ,right=372	,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1537 ,right=1706 ,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1466 ,right=1706 ,bottom=1537 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1466 ,right=372	,bottom=1537 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1537 ,right=1878 ,bottom=1537 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1466 ,right=1372 ,bottom=1537 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1466 ,right=1269 ,bottom=1537 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1466 ,right=1053 ,bottom=1537 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1466 ,right=841	,bottom=1537 </L>																																																																																																																				  ";
	ls_for += "		<L> left=841	,top=1394 ,right=841	,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1394 ,right=1053 ,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1394 ,right=1269 ,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1394 ,right=1372 ,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1466 ,right=1878 ,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1394 ,right=372	,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1394 ,right=1706 ,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1322 ,right=1706 ,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1322 ,right=372	,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1394 ,right=1878 ,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1322 ,right=1372 ,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1322 ,right=1269 ,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1322 ,right=1053 ,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1322 ,right=841	,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1250 ,right=841	,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1250 ,right=1053 ,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1250 ,right=1269 ,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1250 ,right=1372 ,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1322 ,right=1878 ,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1250 ,right=372	,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1250 ,right=1706 ,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1178 ,right=1706 ,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1178 ,right=372	,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1250 ,right=1878 ,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1178 ,right=1372 ,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1178 ,right=1269 ,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1178 ,right=1053 ,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1178 ,right=841	,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1106 ,right=841	,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1106 ,right=1053 ,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1106 ,right=1269 ,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1106 ,right=1372 ,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1178 ,right=1878 ,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1106 ,right=372	,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1106 ,right=1706 ,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=841	,top=1034 ,right=841	,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=1053 ,top=1034 ,right=1053	,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=1269 ,top=1034 ,right=1269 ,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=1372 ,top=1034 ,right=1372 ,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1106 ,right=1878 ,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=372	,top=1034 ,right=372	,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=1706 ,top=1034 ,right=1706 ,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=3		,top=1753 ,right=1878 ,bottom=1753 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1034 ,right=725	,bottom=1106 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1106 ,right=725	,bottom=1178 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1178 ,right=725	,bottom=1250 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1250 ,right=725	,bottom=1322 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1322 ,right=725	,bottom=1394 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1394 ,right=725	,bottom=1466 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1466 ,right=725	,bottom=1537 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1537 ,right=725	,bottom=1609 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1609 ,right=725	,bottom=1681 </L>																																																																																																																					";
	ls_for += "		<L> left=725	,top=1681 ,right=725	,bottom=1753 </L>																																																																																																																					";
	ls_for += "</B>																																																																																																																																															";

	gcrp_print2.format = ls_for + gcrp_print2.format;
																																																																																																																																												
}


/******************************************************************************																																																																																																					
	Description : ����																																																																																																																																		
******************************************************************************/																																																																																																					
function ln_Excel(){																																																																																																																																		
																																																																																																																																												
}																																																																																																																																												
																																																																																																																																												
/******************************************************************************																																																																																																					
	Description : Check																																																																																																																																		
******************************************************************************/																																																																																																					
function ln_Chk(){																																																																																																																																			
	if (gcds_data.IsUpdated) {																																																																																																																														
		return true; 																																																																																																																																				
	}else{																																																																																																																																								
		alert("����� ������ �����ϴ�");																																																																																																																										
		return false;																																																																																																																																				
	}																																																																																																																																											
}																																																																																																																																												
																																																																																																																																												
/******************************************************************************																																																																																																					
	Description : �Է��׸� ǥ������
******************************************************************************/
function ln_Disp(Obj,e){

/*	if (e=="gcds_humanst" && gcds_humanst.countrow<1) ln_SerHuman();					//��������
	else if (e=="gcds_specialst" && gcds_specialst.countrow<1) ln_SerSpe();	    //Ư������
	else if (e=="gcds_aninsur" && gcds_aninsur.countrow<1) ln_SerAnnu();		    //���ݺ������
	else if (e=="gcds_income" && gcds_income.countrow<1) ln_Income();			  		//��Ÿ�ҵ����
	else if (e=="gcds_assess" && gcds_assess.countrow<1) ln_Assess();				    //���װ��� �� ���װ���
*/
	if(Obj.style.display=="none") Obj.style.display="block";
	else Obj.style.display="none";
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD"	VALUE="false">
	<PARAM NAME="SortExpr"	VALUE="EMPNO">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD"	VALUE="false">
	<!-- <PARAM NAME="SortExpr"	VALUE="EMPNO"> -->
</object></comment><script>__ws__(__NSID__);</script>


<!-- ���� -->
<comment id="__NSID__"><object id="gcds_data02" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� [�˻�]-->
<comment id="__NSID__"><OBJECT id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� -->
<comment id="__NSID__"><OBJECT id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ���� -->
<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
<!-- 	<PARAM NAME="SortExpr"	VALUE="EMPNO"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �Ƿ�� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print2_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �Ƿ��(��������) -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print2_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false"><!-- �Ƿ��(cross) -->												 
	<PARAM NAME="Logical"		VALUE=true>																									 
  <PARAM NAME="DataID"		VALUE=gcds_print2>
	<PARAM NAME="GroupExpr"	VALUE="YYYY:EMPNMK:RESINO:ADDNM,INDNO,INDNO:INDNAME:CARDCNT:CARDAMT:RELATION:JUMINNO:EMPCHK">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��α� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print3_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��α�(��������) -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print3_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false"><!-- ��α�(cross) -->												 
	<PARAM NAME="Logical"		VALUE=true>																									 
  <PARAM NAME="DataID"		VALUE=gcds_print3>
	<PARAM NAME="GroupExpr"	VALUE="YYYY:EMPNMK:RESINO,GIVSAUP,GIVSAUP:GIVCOMP:GIVTYPE:GIVCOD:GIVCNT:GIVAMT">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print2h classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p030002_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p030002_t2(I:USER=gcds_data2)">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>

	if (rowcount>0)	;//''ln_Chk3();
  window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0)	alert("�˻��� ����Ÿ�� �����ϴ�.");
</script>

<!-- <script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	ft_cnt2.innerText="����Ÿ ��ȸ���Դϴ�.";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(rowcount)>

	if (rowcount>0)	;//''ln_Chk3();
  window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";
//	if (rowcount ==0)	alert("�˻��� ����Ÿ�� �����ϴ�.");
</script>
 -->

<script language="javascript" for="gcds_print" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_print" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if (gcds_print.countrow<1) {	alert("����Ͻ� �ڷᰡ �����ϴ�");
	}else{ gcrp_print.preview(); }//'�ҵ��ں��ٷμҵ��õ¡����' REPORT �̸�����
</script>

<script language="javascript" for="gcds_print2_2" event="onloadcompleted(row,colid)">	
	//�Ƿ�� ������
	if (gcds_print2_2.countrow<1) {	
		window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		//document.all.LowerFrame.style.visibility="hidden";
		alert("����Ͻ� �ڷᰡ �����ϴ�");
	}else{
		var pram  = new Array();
		var k = 0;
		var c = 0;
		var temp = "";
		for (var i=1;i<=gcds_print2_2.countrow;i++){	
			pram[c] = new Array();
			var Rod = Number((gcds_print2_2.countcolumn/11));
			for (var j=Math.round(Rod);j<=gcds_print2_2.countcolumn;j++){	
				if(gcds_print2_2.namevalue(i,gcds_print2_2.columnid(j)) == "") {
				}else{
					pram[c][k] = new Array()
					pram[c][k] = gcds_print2_2.namevalue(i,gcds_print2_2.columnid(j));
					k++;					
				}//End If
			}//End For J
			c++;
			k=0;
		}//End For I
		
		gcds_temp.ClearAll();
		var ls_temp = "";

		for (var i=Math.round(Rod);i<=gcds_print2_2.countcolumn;i++){	
			ls_temp+=gcds_print2_2.columnid(i)+":";
			if(gcds_print2_2.ColumnType(i)==1)			ls_temp+="STRING";
			else if(gcds_print2_2.ColumnType(i)==2)	ls_temp+="INTEGER";
			else if(gcds_print2_2.ColumnType(i)==3)	ls_temp+="DECIMAL";
			else if(gcds_print2_2.ColumnType(i)==4)	ls_temp+="DATE";
			else if(gcds_print2_2.ColumnType(i)==5)	ls_temp+="URL";
		
			if(gcds_print2_2.countcolumn != i) ls_temp+=",";
		}
			gcds_temp.SetDataHeader(ls_temp);

		for(var s=1;s<=pram.length;s++) {
			gcds_temp.addRow();
			for(var t=1;t<=pram[k].length;t++) {
				if(t==75 || t==145 || t==215 || t==285) {	
					var row = gcds_temp.rowposition;
					gcds_temp.addRow();
					gcds_temp.namevalue(row+1,"YYYY")		= gcds_temp.namevalue(row,"YYYY");
					gcds_temp.namevalue(row+1,"EMPNMK")	= gcds_temp.namevalue(row,"EMPNMK");
					gcds_temp.namevalue(row+1,"RESINO") = gcds_temp.namevalue(row,"RESINO");
					gcds_temp.namevalue(row+1,"ADDNM")	= gcds_temp.namevalue(row,"ADDNM");
					gcds_temp.namevalue(gcds_temp.rowposition,gcds_temp.columnid(t)) = pram[s-1][t-1];	
				}else{
					gcds_temp.namevalue(gcds_temp.rowposition,gcds_temp.columnid(t)) = pram[s-1][t-1];
				}
			}//End For T
			k++;
		}//End For S		

		ln_RptFormat(Math.round(Rod));	//�Ƿ�� Format
		
		window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		//document.all.LowerFrame.style.visibility="hidden";

		gcrp_print2.preview();
		
	}//END IF
</script>

<script language="javascript" for="gcds_print3_2" event="onloadcompleted(row,colid)">
	//��α� ������
	if (gcds_print3_2.countrow<1) {	
		window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		//document.all.LowerFrame.style.visibility="hidden";
		alert("����Ͻ� �ڷᰡ �����ϴ�");
	}else{	
		var pram  = new Array();	
		var k = 0;
		var c = 0;
		var temp = "";
		for (var i=1;i<=gcds_print3_2.countrow;i++){	
			pram[c] = new Array();

			var Rod = Number((gcds_print3_2.countcolumn/9));
		//alert("Rod:"+Math.round(Rod+2)+"/Col:"+gcds_print3_2.countcolumn+"/Row:"+row);
			for (var j=Math.round(Rod+2);j<=gcds_print3_2.countcolumn;j++){	
				if(gcds_print3_2.namevalue(i,gcds_print3_2.columnid(j)) == "") {
				}else{
					pram[c][k] = new Array()
					pram[c][k] = gcds_print3_2.namevalue(i,gcds_print3_2.columnid(j));
					k++;					
				}//End If
			}//End For J
			c++;
			k=0;
		}//End For I
	
	gcds_temp.ClearAll();
	var ls_temp = "";

	for (var i=Math.round(Rod+2);i<=gcds_print3_2.countcolumn;i++){	
		ls_temp+=gcds_print3_2.columnid(i)+":";
		if(gcds_print3_2.ColumnType(i)==1)			ls_temp+="STRING";
		else if(gcds_print3_2.ColumnType(i)==2)	ls_temp+="INTEGER";
		else if(gcds_print3_2.ColumnType(i)==3)	ls_temp+="DECIMAL";
		else if(gcds_print3_2.ColumnType(i)==4)	ls_temp+="DATE";
		else if(gcds_print3_2.ColumnType(i)==5)	ls_temp+="URL";
	
		if(gcds_print3_2.countcolumn != i) ls_temp+=",";
	}
		gcds_temp.SetDataHeader(ls_temp);

	for(var s=1;s<=pram.length;s++) {
		gcds_temp.addRow();
		for(var t=1;t<=pram[k].length;t++) {
			if(t==64 || t==124 || t==184 || t==244) {	
				var row = gcds_temp.rowposition;
				gcds_temp.addRow();
				gcds_temp.namevalue(row+1,"YYYY")		= gcds_temp.namevalue(row,"YYYY");
				gcds_temp.namevalue(row+1,"EMPNMK")	= gcds_temp.namevalue(row,"EMPNMK");
				gcds_temp.namevalue(row+1,"RESINO") = gcds_temp.namevalue(row,"RESINO");
				gcds_temp.namevalue(gcds_temp.rowposition,gcds_temp.columnid(t)) = pram[s-1][t-1];	
			}else{
				gcds_temp.namevalue(gcds_temp.rowposition,gcds_temp.columnid(t)) = pram[s-1][t-1];
			}
		}//End For T
		k++;
	}//End For S
	
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	gcrp_print3.preview();
}
</script>

<script language="javascript" for="gcds_data02" event="onloadcompleted(row,colid)">
	//�ξ簡�������� ����
	var refcd01 = new Array("1","2","5","6","7","8");								//1:�ҵ����� ��������
	var refcd02 = new Array("3","4","31","32","33","34","45","46");	//2:������� ��������
	var refcd03 = new Array("10","11");															//3:�����
	var refcd04 = new Array("12","13","16","17","18","19");					//4:������
	var refcd05 = new Array("20","21","22","23");										//5:�����ڸ�
	var refcd06 = new Array("9","14","15","24","25","26","27",			//6:�׿�
													"28","29","30","35","36","37","38",
													"39","40","41","42","43","44","47","99");
	var refcd07 = new Array("");

	for (var i=1;i<=row;i++){
		eval("txt_famnm"+i).value  = gcds_data02.namevalue(i,"FAMNM");
		eval("gcem_resino"+i).text = gcds_data02.namevalue(i,"RESINO");
		for(var j=0;j<=21;j++) {
			if (gcds_data02.namevalue(i,"RESINO") != "" && gcds_data02.namevalue(i,"REFCD") == refcd01[j]) { 
				eval("txt_relat"+i).value  = "1";
			}else if (gcds_data02.namevalue(i,"RESINO") != "" && gcds_data02.namevalue(i,"REFCD") == refcd02[j]) { 
				eval("txt_relat"+i).value  = "2";
			}else if (gcds_data02.namevalue(i,"RESINO") != "" && gcds_data02.namevalue(i,"REFCD") == refcd03[j]) { 
				eval("txt_relat"+i).value  = "3";
			}else if (gcds_data02.namevalue(i,"RESINO") != "" && gcds_data02.namevalue(i,"REFCD") == refcd04[j]) { 
				eval("txt_relat"+i).value  = "4";
			}else if (gcds_data02.namevalue(i,"RESINO") != "" && gcds_data02.namevalue(i,"REFCD") == refcd05[j]) { 
				eval("txt_relat"+i).value  = "5";
			}else if (gcds_data02.namevalue(i,"RESINO") != "" && gcds_data02.namevalue(i,"REFCD") == refcd06[j]) { 
				eval("txt_relat"+i).value  = "6";
			}else if (gcds_data02.namevalue(i,"RESINO") == "") {
				eval("txt_relat"+i).value  = "";
			}
			if (gcds_data02.namevalue(i,"FAMNM") != "") {
				eval("gclx_ref"+i+"1").BindColVal = "1";
			}
		}		
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gcds_dept2.insertrow(1);
	gcds_dept2.namevalue(1,"DEPTCD") = "";
	gcds_dept2.namevalue(1,"DEPTNM") = "��ü";
	gclx_deptcd.index = 0;
</script>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
	gs_level	= '';
	gs_treecd =	'';
	gs_level	= gclx_deptcd.ValueOfIndex("level", gclx_deptcd.Index);
	gs_treecd = gclx_deptcd.ValueOfIndex("treecd", gclx_deptcd.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-- <script language="javascript" for="gcgd_create" event="OnClick()">
	//gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030001_s2?v_str1="+gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
	//gcds_data02.Reset();
	ln_Chk3();
</script>
 -->
<script language=JavaScript for=gcgd_create event=OnClick(row,colid)>
	if(row>0){
		ln_Query02(gcds_data.namevalue(row,"EMPNO"));
	}
</script>



<script language="javascript" for="gcgd_create" event="onKeyPress(keycode)">
	//gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030001_s2?v_str1="+gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
	//gcds_data02.Reset();
	//ln_Chk3();
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------> 
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gctr_data.ErrorMsg);
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query();
	//ln_Query02();
</script>

<script language="javascript" for="gctr_data2" event="onfail()">
	alert(gctr_data2.ErrorMsg);
</script>


</head>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p030002_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
			<img src="../../Common/img/btn/com_b_levy.gif"				style="cursor:hand" onclick="ln_PrintLevy()">
			<img src="../../Common/img/btn/com_b_mediexp.gif"			style="cursor:hand" onclick="ln_Print2()">
			<img src="../../Common/img/btn/com_b_contribute.gif"	style="cursor:hand" onclick="ln_Print3()">
			<img src="../../Common/img/btn/com_b_delete.gif"			style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_save.gif"				style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"				style="cursor:hand" onclick="ln_Query()"></nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;�ͼӳ⵵&nbsp;&nbsp;</nobr>
					</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:1px;top:2px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2;">
							<param name=Text          value="">
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY">
							<param name=MaxLength     value=4>
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>	
					<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;&nbsp;�� ��&nbsp;&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
							<param name=ComboDataID			value="gcds_dept2">
							<param name=CBDataColumns		value="DEPTCD, DEPTNM">
							<param name=SearchColumn		value=DEPTNM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DEPTNM^0^150">
							<param name=BindColumn			value=DEPTCD>
 						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
					<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;&nbsp;�� ��&nbsp;&nbsp;&nbsp;</nobr></td>
					<td><nobr>&nbsp;
						<input id="txt_empnmk1" name="txt_empnmk1" type="text" class="txtbox" style="width:70px; height:18px;position:relative;top:0px;left:-5px" onKeydown="if(event.keyCode==13) ln_Query()">
					</nobr></td>
						<td width="100%" align=RIGHT >&nbsp;&nbsp;</td>
					<td style="padding-top:4px;"></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:376px" valign=top>
						<comment id="__NSID__"><OBJECT id=gcgd_create  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   style="WIDTH: 230px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM name="Fillarea"		VALUE="true">
              <PARAM name="SortView"    value="Left">
							<PARAM name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�ͼӳ⵵' ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=60	align=center  mask='XXXX' </C> 
								<C> Name='�Ҽ�'			ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=left		sort=true</C> 
								<C> Name='����'			ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC	Width=65	align=left		sort=true</C>
								<C> Name='���'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=50	align=center	sort=true</C> 
								<C> Name='����'			ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC	Width=80	align=LEFT		sort=true</C> 
								<C> Name='ȣ��'			ID=PAYSEQNM HeadAlign=Center HeadBgColor=#B9D4DC	Width=50	align=center	sort=true</C> 
								<C> Name='�Ի���'		ID=STRTDT		HeadAlign=Center HeadBgColor=#B9D4DC	Width=65	align=center	sort=true  mask='XXXX/XX/XX' </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:232px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
						</fieldset>
					</td>
          <td>&nbsp;</td>
					<td STYLE="PADDING-TOP:0px;" valign=top>
			<table width="500" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td valign=top>
						<table border= "0"  cellpadding=0 cellspacing=0  border=0  style='width:638px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
							<tr>
								<td style="height:25px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;�ͼӳ⵵</td>
								<td style="border:1 solid #708090;border-left-width:0px;padding-top:0px;padding-left:6px" colspan=2>
									<comment id="__NSID__"><object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="width:40px; height:20px; font-family:����; font-size:9pt;z-index:2;">
										<param name=Text          value="">
										<param name=Border	      value=True>
										<param name=Format	      value="YYYY">
										<param name=MaxLength     value=4>
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=enable				value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="height:25px;border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;���</td>
								<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
									<comment id="__NSID__"><object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt; "   > 
		            		<param name=Text          value="">
		            		<param name=Alignment			value=1>
	            			<param name=Border	      value=true>
				            <param name=Numeric	      value=false>
				            <param name=Format	      value="0000000">
				            <param name=MaxLength     value=7>
				            <param name=PromptChar	  value="_">
				            <param name=IsComma	      value=false>
				            <param name=BackColor     value="#CCCCCC">
				      	    <param name=enable				value=false>
			            </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="border:1 solid #708090;border-left-width:0px; " bgcolor="#eeeeee">&nbsp;����</td>
								<td style="border:1 solid #708090;border-left-width:0px; "  colspan=2>&nbsp;
									<input id="txt_empnmk2" name="txt_empnmk2" type="text" class="txtbox" style="position:relative; left:-6px; width:70px; height:18px;" value="" maxlength=16 readonly>
								</td>
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�Ի�����</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;
									<comment id="__NSID__"><object id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:0px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=enable				value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�������</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;padding-left:6px;" colspan=2>
									<comment id="__NSID__"><object id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:0px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=enable				value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ҵ���޿���</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;padding-left:6px;" colspan=2><nobr>
									<comment id="__NSID__"><object id=gcem_pb10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:0px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
    		            <param name=Text          value="">
		            		<param name=Alignment			value=2>
	            			<param name=Border	      value=true>
  			            <param name=Numeric	      value=true>
				            <param name=Format	      value="000,000,000">
				            <param name=MaxLength     value=9>
				            <param name=IsComma	      value=true>
				            <param name=BackColor     value="#CCCCCC">
				            <param name=enable				value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ٷμҵ����</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
									<comment id="__NSID__"><object id=gcem_pb20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:6px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	 > 
		            		<param name=Text          value="">
		            		<param name=Alignment			value=2>
	            			<param name=Border	      value=true>
  			            <param name=Numeric	      value=true>
				            <param name=Format	      value="000,000,000">
				            <param name=MaxLength     value=9>
				            <param name=IsComma	      value=true>
				            <param name=BackColor     value="#CCCCCC">
										<param name=enable				value=false>
			            </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ٷμҵ�ݾ�</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
									<comment id="__NSID__"><object id=gcem_pb30000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:6px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
		            		<param name=Text          value="">
		            		<param name=Alignment			value=2>
	            			<param name=Border	      value=true>
				            <param name=Numeric	      value=true>
				            <param name=Format	      value="000,000,000">
				            <param name=MaxLength     value=9>
				            <param name=IsComma	      value=true>
				            <param name=BackColor     value="#CCCCCC">
										<param name=enable				value=false>
			            </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�ⳳ�μҵ漼</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
									<comment id="__NSID__"><object id=gcem_pb61000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:6px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
		            		<param name=Text          value="">
		            		<param name=Alignment			value=2>
	            			<param name=Border	      value=true>
				            <param name=Numeric	      value=true>
				            <param name=Format	      value="000,000,000">
				            <param name=MaxLength     value=9>
				            <param name=IsComma	      value=true>
				            <param name=BackColor     value="#CCCCCC">
										<param name=enable				value=false>
			            </object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr><td style="height:5px;border:0 solid #708090;" colspan=6></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height=3></td></tr>
				<tr> 
					<td colspan="2"> 
<!--------------------------------------------------------------------------------------------
	+ �������� ���� TAB[1] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_humanst,'gcds_humanst');" background="../../Common/img/com_cont_subtxt_bg.gif" height=31><b>��������(*)</b></td>
				</tr>
				<tr>
					<td>

<div id=gcgd_humanst style="position:relative;display:none">
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  style='width:512x;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
					<tr>
						<td style="height:25px;border:1 solid #708090; border-top-width:0px;border-left-width:0px;border-right-width:1px;border-bottom-width:1px; " bgcolor="#B9D4DC" ><nobr>&nbsp;-�⺻����&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;����� ����</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:0px;" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gclx_ba0101yn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:3px;font-size:12px;width:70px;height:120px;">
								<param name=CBData					value="1^��,0^�ƴϿ�">
								<param name=CBDataColumns		value="Seq,Seqnm">
								<param name=SearchColumn	  value="Seqnm">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Seqnm^0^69">								
								<param name=BindColumn			value="Seq">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee">
							<nobr>&nbsp;</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;;border-top-width:0px;border-right-width:0px;" colspan=2>&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
							<nobr>&nbsp;��������&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ba0102cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
						<td width="150" style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�ξ��ڳ�(20������)&nbsp;</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ba0103cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
							<nobr>&nbsp;�����ڸ�<br>(20������,�� 60���̻�,�� 55���̻�)&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ba0104cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;��Ÿ&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ba0105cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#B9D4DC">&nbsp;-�߰�����&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;��ο���ڼ�(65~69��)&nbsp;</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-left-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ad0101cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;��ο���ڼ�(70���̻�)</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ad0102cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;����ڼ�</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ad0103cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;�γ�������</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;border-bottom-width:0px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gclx_ad0104yn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:3px;font-size:12px;width:70px;height:120px;">
								<param name=CBData					value="1^��,0^�ƴϿ�">
								<param name=CBDataColumns		value="Seq,Seqnm">
								<param name=SearchColumn		value="Seqnm">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Seqnm^0^69">								
								<param name=BindColumn			value="Seq">
							</object></comment><script>__ws__(__NSID__);</script>	
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:1px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-top-width:1px" bgcolor="#eeeeee">&nbsp;�ڳ�����ο�</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-top-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ad0105cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input width="30" name="won" type=text value=" ��" class="txtbox" style="width:30px;border=0;"></nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-top-width:1px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:1px;border-right-width:0px;border-bottom-width:0px" colspan=2>&nbsp;</td>
					</tr>
					<!-- <tr>
						<td style="height:5px;border:0 solid #708090;" colspan=6></td>
					</tr> -->
				</table>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
<!--------------------------------------------------------------------------------------------
	+ ���ݺ������� ���� TAB[3] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_aninsur,'gcds_aninsur')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31"><b>���ݺ�������(*)</b>
					</td>
				</tr>
				<tr>
					<td>
						<div id=gcgd_aninsur style="position:relative;display:none">

				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:512x;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
					<tr>
						<td style="height:22px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC"><nobr>&nbsp;-���ݺ�������&nbsp;</nobr></td>
						<td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;���ݺ������Ծ�&nbsp;</nobr></td>
						<td width="110" style="border:0 solid #708090;border-right-width:0px;border-bottom-width:0px;;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pensum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	 > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp; 	</nobr>
						</td>
						<td width="70" style="border:0 solid #708090;border-right-width:0px;border-bottom-width:0px;border-top-width:0px;" bgcolor="#ffffff"><nobr>&nbsp;</nobr></td>
						<td width="100%" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;border-right-width:0px" colspan=2><nobr>
							&nbsp;</nobr>
						</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
<!--------------------------------------------------------------------------------------------
	+ Ư������ ���� TAB[2] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_specialst,'gcds_specialst')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31"><b>Ư������(*)</b>
					</td>
				</tr>
				<tr>
					<td>

<div id=gcgd_specialst style="position:relative;display:none">
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:600x;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
					<tr>
						<td style="height:25px;width:103px; border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#B9D4DC"><nobr>&nbsp;-�� �� ��&nbsp;</nobr></td>
						<td style="height:25px;width:180px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;���ΰǰ������&nbsp;</nobr>
						</td>
						<td width="90px" style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_insamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="width:190; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee" colspan=2><nobr>&nbsp;���뺸���</nobr></td>
						<td style="width:90;border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gcem_insamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  " > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
							<nobr>&nbsp;��Ÿ ���强�����&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_insamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" colspan=2><nobr>&nbsp;��������뺸�强�����&nbsp;</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobR>
							<comment id="__NSID__"><object id=gcem_insamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "  > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#B9D4DC">&nbsp;-�� �� ��</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����/�����/������Ƿ��&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_medamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;"  > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" colspan=2>&nbsp;��Ÿ�Ƿ��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gcem_medamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
				
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#B9D4DC">&nbsp;-�� �� ��</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;���� ������</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-left-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_eduamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-left-width:0px" bgcolor="#eeeeee"  colspan=2 >&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>&nbsp; </nobr>
							</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee">&nbsp;�������Ƶ�</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:60px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input  name="won" type=text value="��" class="txtbox" style="width:12px;border=0;">&nbsp;&nbsp;&nbsp;
							
							<comment id="__NSID__"><object id=gcem_eduatm021 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm022 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm023 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>

						<td class = "tab28" ><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm024 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>

						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm025 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;��/��/�� &nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:60px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input  name="won" type=text value="��" class="txtbox" style="width:12px;border=0;"> &nbsp;&nbsp;&nbsp;
							
							<comment id="__NSID__"><object id=gcem_eduatm031 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:0px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm032 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm033 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td class="tab28"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm034 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm035 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee">&nbsp;���л�</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:60px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input  name="won" type=text value="��" class="txtbox" style="width:12px;border=0;">&nbsp;&nbsp;&nbsp;
							
							<comment id="__NSID__"><object id=gcem_eduatm041 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm042 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm043 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td class="tab28" ><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm044 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm045 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;����� ������</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:60px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="00">
								<param name=MaxLength     value=2>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<input  name="won" type=text value="��" class="txtbox" style="width:12px;border=0;">&nbsp;&nbsp;&nbsp;
							
							<comment id="__NSID__"><object id=gcem_eduatm051 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm052 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
				  			<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; &nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm053 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td class="tab28" ><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm054 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
				  		</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gcem_eduatm055 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#B9D4DC">&nbsp;-�����ڱ�&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�����ڱݸ��������</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-left-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"  colspan=2>&nbsp;���� ���� ���Ա� ��ȯ</td>
						<td style="border:0 solid #708090;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;������� �������Ա�(600)&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" colspan=2><nobr>&nbsp;������� �������Ա�(1000)&nbsp;<nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gcem_houamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr></td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#B9D4DC">&nbsp;-��α�&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;���װ���</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-left-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_conamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-left-width:0px" bgcolor="#eeeeee"  colspan=2>&nbsp;Ư�ʱ�α�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px"><nobr>
							<comment id="__NSID__"><object id=gcem_conamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�츮�������ձ�α�&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_conamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
  						</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"  colspan=2><nobr>&nbsp;������α�&nbsp;<nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gcem_conamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
		  					<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr></td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;��Ÿ��α�&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_conamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:0px; width:70px; height:20px; font-family:����; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"  colspan=2><nobr>&nbsp;&nbsp;<nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<!-- <comment id="__NSID__"><object id=gcem_conamt06 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "   > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script> -->&nbsp;</nobr></td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#B9D4DC"><nobr>&nbsp;-ȥ��, &nbsp;<br>&nbsp;&nbsp;���,�̻��&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;ȥ�ο���&nbsp;</nobr></td>
						<td  style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gclx_marcnt01 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:6px;top:0px;font-size:12px;width:70px;height:120px;">
										<param name=CBData						value="0^0 ȸ,1^1 ȸ,2^2 ȸ,3^3 ȸ,4^4 ȸ,5^5 ȸ">
										<param name=CBDataColumns			value="Seq,Seqnm">
										<param name=SearchColumn			value="Seqnm">
										<param name=Sort							value="false">
										<param name=ListExprFormat		value="Seqnm^0^69">								
										<param name=BindColumn				value="Seq">
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr>
						</td>

						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"  colspan=2><nobr>&nbsp;��ʿ���&nbsp;<nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ><nobr>
							<comment id="__NSID__"><object id=gclx_marcnt02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:6px;top:0px;font-size:12px;width:70px;height:120px;">
										<param name=CBData					value="0^0 ȸ,1^1 ȸ,2^2 ȸ,3^3 ȸ,4^4 ȸ,5^5 ȸ">
										<param name=CBDataColumns		value="Seq,Seqnm">
										<param name=SearchColumn	  value="Seqnm">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="Seqnm^0^69">								
										<param name=BindColumn			value="Seq">
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;border-left-width:0px" bgcolor="#eeeeee">&nbsp;�̻翩��</td>
						<td  style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gclx_marcnt03 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:6px;top:0px;font-size:12px;width:70px;height:120px;">
										<param name=CBData					value="0^0 ȸ,1^1 ȸ,2^2 ȸ,3^3 ȸ,4^4 ȸ,5^5 ȸ">
										<param name=CBDataColumns		value="Seq,Seqnm">
										<param name=SearchColumn	  value="Seqnm">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="Seqnm^0^69">								
										<param name=BindColumn			value="Seq">
							</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"   colspan=2>&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;border-right-width:0px">&nbsp;</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
<!--------------------------------------------------------------------------------------------
	+ ��Ÿ �ҵ���� TAB[4] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_income,'gcds_imcome')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31"><b>��Ÿ �ҵ����(*)</b>
					</td>
				</tr>
				<tr>
					<td>

<div id=gcgd_income style="position:relative;display:none">
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:512x;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#B9D4DC"><nobr>&nbsp;-��Ÿ�ҵ����&nbsp;&nbsp;&nbsp;</nobr></td>
						<td  style="height:25px; width:185px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;���ο��������</nobr></td>
						<td style="width:90px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt011 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	 > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td width="167px" style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;���������</nobr></td>
						<td width="90px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	 > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�����������ھ�</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�츮���������⿬��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�������ݼҵ����</nobr></td>
						<td style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;" colspan=5><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  "> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<!-- <td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td> -->
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#B9D4DC"><nobr>&nbsp;-�ſ�ī��&nbsp;</nobr></td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�ſ롤���ҡ�����ī��</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt031 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  " > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;���ݿ�����</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt032 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  " > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
										<param name=IsComma	  value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-bottom-width:0px;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;�п��� ���γ���</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt033 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;�Ƿ�� �ߺ����� �ݾ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;border-right-width:0px;border-top-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt034 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:����; font-size:9pt;  " > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>

				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
<!--------------------------------------------------------------------------------------------
	+ ���װ��� �� ���װ��� TAB[5] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_assess,'gcds_assess')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31"><b>���װ��� �� ���װ���(*)</b>
					</td>
				</tr>
				<tr>
					<td>

<div id=gcgd_assess style="position:relative;display:none">
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:512x;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
					<tr>
						<td style="height:25px;width:125px; border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#B9D4DC"><nobr>&nbsp;-���鼼��&nbsp;</nobr></td>
						<td  style="height:25px;width:230px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;�ҵ漼��</nobr></td>
						<td style="width:80px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_redamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
									<param name=Numeric			value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; &nbsp;</nobr>
						</td>
						<td style="width:185px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;����Ư�����ѹ�&nbsp;</nobr></td>
						<td  style="width:95px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_redamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#B9D4DC">&nbsp;-��������&nbsp;</td>
						<td width="180" style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;���ٳ������հ���</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td width="180" style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;��ġ�ڱݱ�α� ���װ���</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�������Ա�����</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" colspan=2>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;�ܱ����μ���<!-- �ٷμҵ� --></nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							
							<!-- <comment id="__NSID__"><object id=gcem_dedamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;display:none"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script> -->&nbsp; </nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;<!-- �ܱ����μ��� --></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;border-right-width:0px" colspan=2><nobr>
							<!-- <comment id="__NSID__"><object id=gcem_dedamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;  " 	> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric				value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength			value=9>
								<param name=IsComma				value=true>
								<param name=BackColor			value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script> -->&nbsp; </nobr>
							</td>
					</tr>
				</table>
			</div>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
<!--------------------------------------------------------------------------------------------
	+ �ξ簡�������� ���� TAB[6] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_depenfam,'gcds_depenfam')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31" valign="center"><b>�ξ簡�������� ����(*)</b>
					</td>
				</tr>
				<tr>
					<td>
							
<div id=gcgd_depenfam style="position:relative;display:none">
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:512x;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
					<tr>
						<td colspan="11" style="border:0 solid #708090;border-bottom-width:1px;">
							<img id="img_chk" value="2" src="../../Common/img/btn/com_b_save.gif"	style="position:relative;top:2px;left:590px;cursor:hand" onclick="ln_Save2()">
							<img src="../../Common/img/btn/com_b_delete.gif"			style="position:relative;top:2px;left:500px;cursor:hand" onclick="ln_Delete2()">
						</td>
					</tr>
					<tr>
					<!-- <tr style="border-right-width:0px;">  -->
					
           <td style="width:628px" valign=top> 
						<comment id="__NSID__"><OBJECT id=gcgd_ycprsn  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   style="WIDTH: 628px;HEIGHT: 220px;border:0 solid #777777;display:block;border-right-width:0px;border-bottom-width:0px;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data2">
              <PARAM NAME="Editable"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM name="Fillarea"		VALUE="true">
              <PARAM name="SortView"    value="Left">
							<PARAM name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<F> Name='����'	     	    ID=SEQ 		  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center    	Value={ToString(CurRow)}</F>
								<C> Name='����' ID=RELAT1  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=60	align=center  </C> 
								<C> Name='���ܱ���'			ID=REF1  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=left		sort=false EditStyle=Combo Data='T:������,F:�ܱ���'</C> 
								<C> Name='����'					ID=FAMNM1		HeadAlign=Center HeadBgColor=#B9D4DC	Width=65	align=left		sort=false</C>
								<C> Name='�ֹε�Ϲ�ȣ'		ID=RESINO1  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=96	align=center mask='XXXXXX-XXXXXXX'	sort=false</C> 
								<C> Name='�⺻����'			ID=REF2			HeadAlign=Center HeadBgColor=#B9D4DC	Width=80	align=center		sort=false EditStyle=Combo Data='T:��,F:�ƴϿ�'</C> 
								<C> Name='�����'				ID=REF3 HeadAlign=Center HeadBgColor=#B9D4DC	Width=50	align=center		sort=false EditStyle=Combo Data='T:��,F:�ƴϿ�'</C> 
								<C> Name='�ڳ������'			ID=REF4		HeadAlign=Center HeadBgColor=#B9D4DC	Width=65	align=center 	sort=false EditStyle=Combo Data='T:��,F:�ƴϿ�'</C>
								<G> Name='����û �ڷ�', HeadBgColor=#B9D4DC, align=center 
								<C> Name='�����'				ID=REF11  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='�Ƿ��'				ID=REF12  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='������'				ID=REF13  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='�ſ�ī���'			ID=REF14  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='���ݿ�����'			ID=REF15  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								</G>
								<G> Name='�׹��� �ڷ�', HeadBgColor=#B9D4DC, align=center 
								<C> Name='�����'				ID=REF21  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='�Ƿ��'				ID=REF22  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='������'				ID=REF23  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='�ſ�ī���'			ID=REF24  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								<C> Name='���ݿ�����'			ID=REF25  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=right	sort=false</C>
								</G>
								

							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:622px;height:20px;border:0 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;	<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;</font>
						</fieldset>
					</td>
          <td>&nbsp;</td>
		  </tr> 




					
				</table>
				</div>
					<tr><td height="50px">&nbsp;</td></tr>
					</table>
						</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPDT				Ctrl=gcem_yyyy					Param=Text</C>
		<C>Col=EMPNO				Ctrl=gcem_empno					Param=Text</C>
		<C>Col=EMPNMK				Ctrl=txt_empnmk2				Param=Value</C>
		<C>Col=PB10000			Ctrl=gcem_pb10000				Param=Text</C>
		<C>Col=PB20000			Ctrl=gcem_pb20000				Param=Text</C>
		<C>Col=PB30000			Ctrl=gcem_pb30000				Param=Text</C>
		<C>Col=BA0101YN			Ctrl=gclx_ba0101yn			Param=BindColVal</C>
		<C>Col=BA0102CNT		Ctrl=gcem_ba0102cnt			Param=Text</C>
		<C>Col=BA0103CNT		Ctrl=gcem_ba0103cnt			Param=Text</C>
		<C>Col=BA0104CNT		Ctrl=gcem_ba0104cnt			Param=Text</C>
		<C>Col=BA0105CNT		Ctrl=gcem_ba0105cnt			Param=Text</C>
		<C>Col=AD0101CNT		Ctrl=gcem_ad0101cnt			Param=Text</C>
		<C>Col=AD0102CNT		Ctrl=gcem_ad0102cnt			Param=Text</C>
		<C>Col=AD0103CNT		Ctrl=gcem_ad0103cnt			Param=Text</C>
		<C>Col=AD0104YN			Ctrl=gclx_ad0104yn			Param=BindColVal</C>
		<C>Col=AD0105CNT		Ctrl=gcem_ad0105cnt			Param=Text</C>
		<C>Col=PENSUM				Ctrl=gcem_pensum				Param=Text</C>
		<C>Col=INSAMT01			Ctrl=gcem_insamt01			Param=Text</C>
		<C>Col=INSAMT02			Ctrl=gcem_insamt02			Param=Text</C>
		<C>Col=INSAMT03			Ctrl=gcem_insamt03			Param=Text</C>
		<C>Col=INSAMT04			Ctrl=gcem_insamt04			Param=Text</C>
		<C>Col=MEDAMT01			Ctrl=gcem_medamt01			Param=Text</C>
		<C>Col=MEDAMT02			Ctrl=gcem_medamt02			Param=Text</C>
		<C>Col=EDUAMT01			Ctrl=gcem_eduamt01			Param=Text</C>
		<C>Col=EDUAMT02			Ctrl=gcem_eduatm02			Param=Text</C>
		<C>Col=EDUAMT021		Ctrl=gcem_eduatm021			Param=Text</C>
		<C>Col=EDUAMT022		Ctrl=gcem_eduatm022			Param=Text</C>
		<C>Col=EDUAMT023		Ctrl=gcem_eduatm023			Param=Text</C>
		<C>Col=EDUAMT024		Ctrl=gcem_eduatm024			Param=Text</C>
		<C>Col=EDUAMT025		Ctrl=gcem_eduatm025			Param=Text</C>
		<C>Col=EDUAMT03			Ctrl=gcem_eduatm03			Param=Text</C>
		<C>Col=EDUAMT031		Ctrl=gcem_eduatm031			Param=Text</C>
		<C>Col=EDUAMT032		Ctrl=gcem_eduatm032			Param=Text</C>
		<C>Col=EDUAMT033		Ctrl=gcem_eduatm033			Param=Text</C>
		<C>Col=EDUAMT034		Ctrl=gcem_eduatm034			Param=Text</C>
		<C>Col=EDUAMT035		Ctrl=gcem_eduatm035			Param=Text</C>
		<C>Col=EDUAMT04			Ctrl=gcem_eduatm04			Param=Text</C>
		<C>Col=EDUAMT041		Ctrl=gcem_eduatm041			Param=Text</C>
		<C>Col=EDUAMT042		Ctrl=gcem_eduatm042			Param=Text</C>
		<C>Col=EDUAMT043		Ctrl=gcem_eduatm043			Param=Text</C>
		<C>Col=EDUAMT044		Ctrl=gcem_eduatm044			Param=Text</C>
		<C>Col=EDUAMT045		Ctrl=gcem_eduatm045			Param=Text</C>
		<C>Col=EDUAMT05			Ctrl=gcem_eduatm05			Param=Text</C>
		<C>Col=EDUAMT051		Ctrl=gcem_eduatm051			Param=Text</C>
		<C>Col=EDUAMT052		Ctrl=gcem_eduatm052			Param=Text</C>
		<C>Col=EDUAMT053		Ctrl=gcem_eduatm053			Param=Text</C>
		<C>Col=EDUAMT054		Ctrl=gcem_eduatm054			Param=Text</C>
		<C>Col=EDUAMT055		Ctrl=gcem_eduatm055			Param=Text</C>
		<C>Col=HOUAMT01			Ctrl=gcem_houamt01			Param=Text</C>
		<C>Col=HOUAMT02			Ctrl=gcem_houamt02			Param=Text</C>
		<C>Col=HOUAMT03			Ctrl=gcem_houamt03			Param=Text</C>
		<C>Col=HOUAMT04			Ctrl=gcem_houamt04			Param=Text</C>
		<C>Col=CONAMT01			Ctrl=gcem_conamt01			Param=Text</C>
		<C>Col=CONAMT02			Ctrl=gcem_conamt02			Param=Text</C>
		<C>Col=CONAMT03			Ctrl=gcem_conamt03			Param=Text</C>
		<C>Col=CONAMT04			Ctrl=gcem_conamt04			Param=Text</C>
		<C>Col=CONAMT05			Ctrl=gcem_conamt05			Param=Text</C>
		
		<C>Col=MARCNT01			Ctrl=gclx_marcnt01			Param=BindColVal</C>
		<C>Col=MARCNT02			Ctrl=gclx_marcnt02			Param=BindColVal</C>
		<C>Col=MARCNT03			Ctrl=gclx_marcnt03			Param=BindColVal</C>
		<C>Col=ETCAMT011		Ctrl=gcem_etcamt011			Param=Text</C>
		<C>Col=ETCAMT01			Ctrl=gcem_etcamt01			Param=Text</C>
		<C>Col=ETCAMT02			Ctrl=gcem_etcamt02			Param=Text</C>
		<C>Col=ETCAMT031		Ctrl=gcem_etcamt031			Param=Text</C>
		<C>Col=ETCAMT032		Ctrl=gcem_etcamt032			Param=Text</C>
		<C>Col=ETCAMT033		Ctrl=gcem_etcamt033			Param=Text</C>
		<C>Col=ETCAMT034		Ctrl=gcem_etcamt034			Param=Text</C>
		<C>Col=ETCAMT04			Ctrl=gcem_etcamt04			Param=Text</C>
		<C>Col=ETCAMT05			Ctrl=gcem_etcamt05			Param=Text</C>
		<C>Col=REDAMT01			Ctrl=gcem_redamt01			Param=Text</C>
		<C>Col=REDAMT02			Ctrl=gcem_redamt02			Param=Text</C>
		<C>Col=DEDAMT01			Ctrl=gcem_dedamt01			Param=Text</C>
		<C>Col=DEDAMT02			Ctrl=gcem_dedamt02			Param=Text</C>
		<C>Col=DEDAMT03			Ctrl=gcem_dedamt03			Param=Text</C>
		<C>Col=DEDAMT04			Ctrl=gcem_dedamt04			Param=Text</C>
		<C>Col=DEDAMT05			Ctrl=gcem_dedamt05			Param=Text</C>
		<C>Col=PB61000			Ctrl=gcem_pb61000				Param=Text</C>
		<C>Col=STRTDT				Ctrl=gcem_strtdt				Param=Text</C>
		<C>Col=ENDDT				Ctrl=gcem_enddt					Param=Text</C>

		<C>Col=RELAT1				Ctrl=txt_relat1					Param=Value</C>
		
		<C>Col=REF11				Ctrl=gclx_ref11					Param=BindColVal</C>
		<C>Col=FAMNM1				Ctrl=txt_famnm1					Param=Value</C>
		<C>Col=RESINO1			Ctrl=gcem_resino1				Param=Text</C>
		<C>Col=REF12				Ctrl=txt_ref12					Param=Value</C>
		<C>Col=REF13				Ctrl=txt_ref13					Param=Value</C>
		<C>Col=REF14				Ctrl=txt_ref14					Param=Value</C>
		<C>Col=REF15				Ctrl=txt_ref15					Param=Value</C>
		<C>Col=REF16				Ctrl=txt_ref16					Param=Value</C>
		<C>Col=REF17				Ctrl=txt_ref17					Param=Value</C>
		<C>Col=REF18				Ctrl=txt_ref18					Param=Value</C>

		<C>Col=REF11				Ctrl=gcem_ref11					Param=Text</C>
		<C>Col=REF12				Ctrl=gcem_ref12					Param=Text</C>
		<C>Col=REF13				Ctrl=gcem_ref13					Param=Text</C>
		<C>Col=REF14				Ctrl=gcem_ref14					Param=Text</C>
		<C>Col=REF15				Ctrl=gcem_ref15					Param=Text</C>








		<C>Col=RELAT2				Ctrl=txt_relat2					Param=Value</C>
		<C>Col=REF21				Ctrl=gclx_ref21					Param=BindColVal</C>
		<C>Col=FAMNM2				Ctrl=txt_famnm2					Param=Value</C>
		<C>Col=RESINO2			Ctrl=gcem_resino2				Param=Text</C>
		<C>Col=REF22				Ctrl=txt_ref22					Param=Value</C>
		<C>Col=REF23				Ctrl=txt_ref23					Param=Value</C>
		<C>Col=REF24				Ctrl=txt_ref24					Param=Value</C>
		<C>Col=REF25				Ctrl=txt_ref25					Param=Value</C>
		<C>Col=REF26				Ctrl=txt_ref26					Param=Value</C>
		<C>Col=REF27				Ctrl=txt_ref27					Param=Value</C>
		<C>Col=REF28				Ctrl=txt_ref28					Param=Value</C>

		<C>Col=RELAT3				Ctrl=txt_relat3					Param=Value</C>
		<C>Col=REF31				Ctrl=gclx_ref31					Param=BindColVal</C>
		<C>Col=FAMNM3				Ctrl=txt_famnm3					Param=Value</C>
		<C>Col=RESINO3			Ctrl=gcem_resino3				Param=Text</C>
		<C>Col=REF32				Ctrl=txt_ref32					Param=Value</C>
		<C>Col=REF33				Ctrl=txt_ref33					Param=Value</C>
		<C>Col=REF34				Ctrl=txt_ref34					Param=Value</C>
		<C>Col=REF35				Ctrl=txt_ref35					Param=Value</C>
		<C>Col=REF36				Ctrl=txt_ref36					Param=Value</C>
		<C>Col=REF37				Ctrl=txt_ref37					Param=Value</C>
		<C>Col=REF38				Ctrl=txt_ref38					Param=Value</C>

		<C>Col=RELAT4				Ctrl=txt_relat4					Param=Value</C>
		<C>Col=REF41				Ctrl=gclx_ref41					Param=BindColVal</C>
		<C>Col=FAMNM4				Ctrl=txt_famnm4					Param=Value</C>
		<C>Col=RESINO4			Ctrl=gcem_resino4				Param=Text</C>
		<C>Col=REF42				Ctrl=txt_ref42					Param=Value</C>
		<C>Col=REF43				Ctrl=txt_ref43					Param=Value</C>
		<C>Col=REF44				Ctrl=txt_ref44					Param=Value</C>
		<C>Col=REF45				Ctrl=txt_ref45					Param=Value</C>
		<C>Col=REF46				Ctrl=txt_ref46					Param=Value</C>
		<C>Col=REF47				Ctrl=txt_ref47					Param=Value</C>
		<C>Col=REF48				Ctrl=txt_ref48					Param=Value</C>

		<C>Col=RELAT5				Ctrl=txt_relat5					Param=Value</C>
		<C>Col=REF51				Ctrl=gclx_ref51					Param=BindColVal</C>
		<C>Col=FAMNM5				Ctrl=txt_famnm5					Param=Value</C>
		<C>Col=RESINO5			Ctrl=gcem_resino5				Param=Text</C>
		<C>Col=REF52				Ctrl=txt_ref52					Param=Value</C>
		<C>Col=REF53				Ctrl=txt_ref53					Param=Value</C>
		<C>Col=REF54				Ctrl=txt_ref54					Param=Value</C>
		<C>Col=REF55				Ctrl=txt_ref55					Param=Value</C>
		<C>Col=REF56				Ctrl=txt_ref56					Param=Value</C>
		<C>Col=REF57				Ctrl=txt_ref57					Param=Value</C>
		<C>Col=REF58				Ctrl=txt_ref58					Param=Value</C>

		<C>Col=RELAT6				Ctrl=txt_relat6					Param=Value</C>
		<C>Col=REF61				Ctrl=gclx_ref61					Param=BindColVal</C>
		<C>Col=FAMNM6				Ctrl=txt_famnm6					Param=Value</C>
		<C>Col=RESINO6			Ctrl=gcem_resino6				Param=Text</C>
		<C>Col=REF62				Ctrl=txt_ref62					Param=Value</C>
		<C>Col=REF63				Ctrl=txt_ref63					Param=Value</C>
		<C>Col=REF64				Ctrl=txt_ref64					Param=Value</C>
		<C>Col=REF65				Ctrl=txt_ref65					Param=Value</C>
		<C>Col=REF66				Ctrl=txt_ref66					Param=Value</C>
		<C>Col=REF67				Ctrl=txt_ref67					Param=Value</C>
		<C>Col=REF68				Ctrl=txt_ref68					Param=Value</C>

		<C>Col=RELAT7				Ctrl=txt_relat7					Param=Value</C>
		<C>Col=REF71				Ctrl=gclx_ref71					Param=BindColVal</C>
		<C>Col=FAMNM7				Ctrl=txt_famnm7					Param=Value</C>
		<C>Col=RESINO7			Ctrl=gcem_resino7				Param=Text</C>
		<C>Col=REF72				Ctrl=txt_ref72					Param=Value</C>
		<C>Col=REF73				Ctrl=txt_ref73					Param=Value</C>
		<C>Col=REF74				Ctrl=txt_ref74					Param=Value</C>
		<C>Col=REF75				Ctrl=txt_ref75					Param=Value</C>
		<C>Col=REF76				Ctrl=txt_ref76					Param=Value</C>
		<C>Col=REF77				Ctrl=txt_ref77					Param=Value</C>
		<C>Col=REF78				Ctrl=txt_ref78					Param=Value</C>

		<C>Col=RELAT8				Ctrl=txt_relat8					Param=Value</C>
		<C>Col=REF81				Ctrl=gclx_ref81					Param=BindColVal</C>
		<C>Col=FAMNM8				Ctrl=txt_famnm8					Param=Value</C>
		<C>Col=RESINO8			Ctrl=gcem_resino8				Param=Text</C>
		<C>Col=REF82				Ctrl=txt_ref82					Param=Value</C>
		<C>Col=REF83				Ctrl=txt_ref83					Param=Value</C>
		<C>Col=REF84				Ctrl=txt_ref84					Param=Value</C>
		<C>Col=REF85				Ctrl=txt_ref85					Param=Value</C>
		<C>Col=REF86				Ctrl=txt_ref86					Param=Value</C>
		<C>Col=REF87				Ctrl=txt_ref87					Param=Value</C>
		<C>Col=REF88				Ctrl=txt_ref88					Param=Value</C>

		<C>Col=RELAT9				Ctrl=txt_relat9					Param=Value</C>
		<C>Col=REF91				Ctrl=gclx_ref91					Param=BindColVal</C>
		<C>Col=FAMNM9				Ctrl=txt_famnm9					Param=Value</C>
		<C>Col=RESINO9			Ctrl=gcem_resino9				Param=Text</C>
		<C>Col=REF92				Ctrl=txt_ref92					Param=Value</C>
		<C>Col=REF93				Ctrl=txt_ref93					Param=Value</C>
		<C>Col=REF94				Ctrl=txt_ref94					Param=Value</C>
		<C>Col=REF95				Ctrl=txt_ref95					Param=Value</C>
		<C>Col=REF96				Ctrl=txt_ref96					Param=Value</C>
		<C>Col=REF97				Ctrl=txt_ref97					Param=Value</C>
		<C>Col=REF98				Ctrl=txt_ref98					Param=Value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-- �����ʵ�
<C>Col=CONAMT06			Ctrl=gcem_conamt06			Param=Text</C> 
-->

<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� : �ҵ��ں��ٷμҵ��õ¡����  -  R E P O R T
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2778 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='[���� �� 25ȣ����(1)] (2009.4.14 ����)' ,left=16 ,top=0 ,right=767 ,bottom=45 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=24 ,top=69 ,right=431 ,bottom=122 ,border=true</X>
	<T>id='�� �� �� �� �� �� �� �� �� õ ¡ �� ��' ,left=471 ,top=61 ,right=1635 ,bottom=138 ,face='HY�߰���' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=254 ,top=69 ,right=254 ,bottom=119 </L>
	<T>id='(1)�ͼӿ���' ,left=32 ,top=74 ,right=246 ,bottom=116 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��   ��' ,left=8 ,top=249 ,right=259 ,bottom=347 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(5)�ֹε�Ϲ�ȣ' ,left=947 ,top=249 ,right=1230 ,bottom=294 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��  ��  ��   ��  ��  ��  ��' ,left=13 ,top=357 ,right=1873 ,bottom=402 ,face='HY�߰���' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=405 ,right=1879 ,bottom=405 </L>
	<L> left=3 ,top=349 ,right=1879 ,bottom=349 </L>
	<L> left=3 ,top=243 ,right=1879 ,bottom=243 </L>
	<L> left=3 ,top=48 ,right=1879 ,bottom=48 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='��                              ��                              ��' ,left=296 ,top=413 ,right=1545 ,bottom=452 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FAMCNT', left=1431, top=304, right=1479, bottom=347, align='right' ,mask='XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO', left=1275, top=249, right=1712, bottom=294, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=656, top=249, right=844, bottom=294, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='YYYY', left=259, top=74, right=426, bottom=116, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1238 ,top=243 ,right=1238 ,bottom=349 </L>
	<T>id='��' ,left=1482 ,top=304 ,right=1548 ,bottom=347 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(6)������� ������ �� (����,����ڸ� ���� 1������ ��)' ,left=296 ,top=304 ,right=1230 ,bottom=347 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(4)��               ��' ,left=296 ,top=249 ,right=614 ,bottom=294 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(3)����ڵ�Ϲ�ȣ' ,left=296 ,top=204 ,right=614 ,bottom=243 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=148 ,right=1879 ,bottom=148 </L>
	<L> left=616 ,top=148 ,right=616 ,bottom=296 </L>
	<L> left=945 ,top=243 ,right=945 ,bottom=296 </L>
	<L> left=910 ,top=455 ,right=910 ,bottom=1119 </L>
	<L> left=1617 ,top=405 ,right=1617 ,bottom=1119 </L>
	<L> left=482 ,top=455 ,right=482 ,bottom=1119 </L>
	<L> left=696 ,top=455 ,right=696 ,bottom=1119 </L>
	<C>id='SCOL004', left=672, top=2574, right=915, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02004', left=672, top=2093, right=915, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03004', left=672, top=2138, right=915, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04004', left=672, top=2180, right=915, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05004', left=672, top=2225, right=915, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06004', left=672, top=2270, right=915, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07004', left=672, top=2312, right=915, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08004', left=672, top=2355, right=915, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09004', left=672, top=2400, right=915, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10004', left=672, top=2445, right=915, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11004', left=672, top=2487, right=915, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12004', left=672, top=2532, right=915, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01004', left=672, top=2051, right=915, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2051, right=1868, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2093, right=1868, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2138, right=1868, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2180, right=1868, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2225, right=1868, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2270, right=1868, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2312, right=1868, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2355, right=1868, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2400, right=1868, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2445, right=1868, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2487, right=1868, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2532, right=1868, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1746, top=2574, right=1868, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12008', left=1556, top=2532, right=1733, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11008', left=1556, top=2487, right=1733, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10008', left=1556, top=2445, right=1733, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09008', left=1556, top=2400, right=1733, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08008', left=1556, top=2355, right=1733, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07008', left=1556, top=2312, right=1733, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06008', left=1556, top=2270, right=1733, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05008', left=1556, top=2225, right=1733, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04008', left=1556, top=2180, right=1733, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03008', left=1556, top=2138, right=1733, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02008', left=1556, top=2093, right=1733, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01008', left=1556, top=2051, right=1733, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL008', left=1556, top=2574, right=1733, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02007', left=1347, top=2093, right=1545, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03007', left=1347, top=2138, right=1545, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04007', left=1347, top=2180, right=1545, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05007', left=1347, top=2225, right=1545, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06007', left=1347, top=2270, right=1545, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07007', left=1347, top=2312, right=1545, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08007', left=1347, top=2355, right=1545, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09007', left=1347, top=2400, right=1545, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10007', left=1347, top=2445, right=1545, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11007', left=1347, top=2487, right=1545, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12007', left=1347, top=2532, right=1545, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01007', left=1347, top=2051, right=1545, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL007', left=1347, top=2574, right=1545, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02006', left=1124, top=2093, right=1334, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03006', left=1124, top=2138, right=1334, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04006', left=1124, top=2180, right=1334, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05006', left=1124, top=2225, right=1334, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06006', left=1124, top=2270, right=1334, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07006', left=1124, top=2312, right=1334, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08006', left=1124, top=2355, right=1334, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09006', left=1124, top=2400, right=1334, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10006', left=1124, top=2445, right=1334, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11006', left=1124, top=2487, right=1334, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12006', left=1124, top=2532, right=1334, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01006', left=1124, top=2051, right=1334, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL006', left=1124, top=2574, right=1334, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01005', left=929, top=2051, right=1114, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12005', left=929, top=2532, right=1114, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11005', left=929, top=2487, right=1114, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10005', left=929, top=2445, right=1114, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09005', left=929, top=2400, right=1114, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08005', left=929, top=2355, right=1114, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07005', left=929, top=2312, right=1114, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06005', left=929, top=2270, right=1114, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05005', left=929, top=2225, right=1114, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04005', left=929, top=2180, right=1114, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03005', left=929, top=2138, right=1114, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02005', left=929, top=2093, right=1114, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL005', left=929, top=2574, right=1114, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01003', left=484, top=2051, right=664, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12003', left=484, top=2532, right=664, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11003', left=484, top=2487, right=664, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10003', left=484, top=2445, right=664, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09003', left=484, top=2400, right=664, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08003', left=484, top=2355, right=664, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07003', left=484, top=2312, right=664, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06003', left=484, top=2270, right=664, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05003', left=484, top=2225, right=664, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04003', left=484, top=2180, right=664, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03003', left=484, top=2138, right=664, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02003', left=484, top=2093, right=664, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL003', left=484, top=2574, right=664, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(25)�ֹμ�' ,left=484 ,top=2000 ,right=664 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SCOL002', left=296, top=2574, right=476, bottom=2609, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01002', left=296, top=2051, right=476, bottom=2085, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02002', left=296, top=2093, right=476, bottom=2127, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03002', left=296, top=2138, right=476, bottom=2172, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04002', left=296, top=2180, right=476, bottom=2217, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05002', left=296, top=2225, right=476, bottom=2260, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06002', left=296, top=2270, right=476, bottom=2302, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07002', left=296, top=2312, right=476, bottom=2347, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08002', left=296, top=2355, right=476, bottom=2392, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09002', left=296, top=2400, right=476, bottom=2434, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10002', left=296, top=2445, right=476, bottom=2479, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11002', left=296, top=2487, right=476, bottom=2521, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12002', left=296, top=2532, right=476, bottom=2566, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3 ,top=2524 ,right=1879 ,bottom=2524 </L>
	<L> left=3 ,top=2482 ,right=1879 ,bottom=2482 </L>
	<L> left=3 ,top=2437 ,right=1879 ,bottom=2437 </L>
	<L> left=3 ,top=2394 ,right=1879 ,bottom=2394 </L>
	<L> left=3 ,top=2350 ,right=1879 ,bottom=2350 </L>
	<L> left=3 ,top=2307 ,right=1879 ,bottom=2307 </L>
	<L> left=3 ,top=2262 ,right=1879 ,bottom=2262 </L>
	<L> left=3 ,top=2220 ,right=1879 ,bottom=2220 </L>
	<L> left=3 ,top=2175 ,right=1879 ,bottom=2175 </L>
	<L> left=3 ,top=2130 ,right=1879 ,bottom=2130 </L>
	<L> left=3 ,top=2088 ,right=1879 ,bottom=2088 </L>
	<L> left=3 ,top=2611 ,right=1879 ,bottom=2611 </L>
	<L> left=3 ,top=2045 ,right=1879 ,bottom=2045 </L>
	<L> left=3 ,top=2569 ,right=1879 ,bottom=2569 </L>
	<T>id='(24)�ҵ漼' ,left=296 ,top=2000 ,right=476 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(26)�����Ư����' ,left=672 ,top=2000 ,right=915 ,bottom=2040 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(27)���ݺ���' ,left=929 ,top=2000 ,right=1114 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(28)�ǰ�����' ,left=1124 ,top=2000 ,right=1334 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(29)���뺸��' ,left=1347 ,top=2000 ,right=1545 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(30)��α�' ,left=1556 ,top=2000 ,right=1733 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=1746 ,top=2000 ,right=1868 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��   ��   õ   ¡   ��   ��' ,left=296 ,top=1950 ,right=918 ,bottom=1992 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1945 ,right=1876 ,bottom=1945 </L>
	<T>id='¡���ǹ��� ��ü ���� �����(�ҵ����)' ,left=929 ,top=1950 ,right=1873 ,bottom=1992 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210mm x 297mm(�Ź����� 54g/��)' ,left=889 ,top=2736 ,right=1879 ,bottom=2778 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=2731 ,right=1876 ,bottom=2731 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1879 ,top=50 ,right=1879 ,bottom=2731 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3 ,top=50 ,right=3 ,bottom=2731 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='����ƻ�(��)' ,left=656 ,top=153 ,right=910 ,bottom=193 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='101-85-10695' ,left=656 ,top=204 ,right=942 ,bottom=241 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��  ��  ��  ��  õ  ¡  ��  ��' ,left=13 ,top=1894 ,right=1873 ,bottom=1942 ,face='HY�߰���' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=8 ,top=2051 ,right=71 ,bottom=2085 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=8 ,top=2093 ,right=71 ,bottom=2127 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=8 ,top=2138 ,right=71 ,bottom=2172 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4' ,left=8 ,top=2180 ,right=71 ,bottom=2217 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5' ,left=8 ,top=2225 ,right=71 ,bottom=2260 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=8 ,top=2270 ,right=71 ,bottom=2302 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=8 ,top=2312 ,right=71 ,bottom=2347 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=8 ,top=2355 ,right=71 ,bottom=2392 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9' ,left=8 ,top=2400 ,right=71 ,bottom=2434 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10' ,left=8 ,top=2445 ,right=71 ,bottom=2479 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11' ,left=8 ,top=2487 ,right=71 ,bottom=2521 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12' ,left=8 ,top=2532 ,right=71 ,bottom=2566 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=77 ,top=1945 ,right=77 ,bottom=2569 </L>
	<T>id='����' ,left=8 ,top=1950 ,right=71 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(23)���鼼��' ,left=82 ,top=1950 ,right=262 ,bottom=2040 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COL01001', left=82, top=2051, right=262, bottom=2085, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02001', left=82, top=2093, right=262, bottom=2127, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03001', left=82, top=2138, right=262, bottom=2172, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04001', left=82, top=2180, right=262, bottom=2217, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05001', left=82, top=2225, right=262, bottom=2260, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06001', left=82, top=2270, right=262, bottom=2302, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07001', left=82, top=2312, right=262, bottom=2347, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08001', left=82, top=2355, right=262, bottom=2392, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09001', left=82, top=2400, right=262, bottom=2434, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10001', left=82, top=2445, right=262, bottom=2479, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11001', left=82, top=2487, right=262, bottom=2521, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12001', left=82, top=2532, right=262, bottom=2566, align='right' ,mask='XXXX�� XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��' ,left=13 ,top=2574 ,right=262 ,bottom=2609 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=267 ,top=405 ,right=267 ,bottom=1119 </L>
	<T>id='¡���ǹ���' ,left=8 ,top=151 ,right=259 ,bottom=243 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=267 ,top=148 ,right=267 ,bottom=349 </L>
	<T>id='(2)�� �� �� (�� ȣ)' ,left=296 ,top=153 ,right=614 ,bottom=196 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=270 ,top=196 ,right=1879 ,bottom=196 </L>
	<L> left=270 ,top=296 ,right=1879 ,bottom=296 </L>
	<C>id='YYYY', left=82, top=1035, right=262, bottom=1069 ,mask='XXXX�� 12��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=990, right=262, bottom=1024 ,mask='XXXX�� 11��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=945, right=262, bottom=982 ,mask='XXXX�� 10��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=902, right=262, bottom=937 ,mask='XXXX�� 09��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=860, right=262, bottom=892 ,mask='XXXX�� 08��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=815, right=262, bottom=849 ,mask='XXXX�� 07��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=770, right=262, bottom=807 ,mask='XXXX�� 06��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=728, right=262, bottom=762 ,mask='XXXX�� 05��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=683, right=262, bottom=717 ,mask='XXXX�� 04��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=640, right=262, bottom=675 ,mask='XXXX�� 03��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=595, right=262, bottom=630 ,mask='XXXX�� 02��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=553, right=262, bottom=587 ,mask='XXXX�� 01��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='12' ,left=8 ,top=1035 ,right=71 ,bottom=1069 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11' ,left=8 ,top=990 ,right=71 ,bottom=1024 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10' ,left=8 ,top=945 ,right=71 ,bottom=982 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9' ,left=8 ,top=902 ,right=71 ,bottom=937 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=8 ,top=860 ,right=71 ,bottom=892 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=8 ,top=815 ,right=71 ,bottom=849 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=8 ,top=770 ,right=71 ,bottom=807 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5' ,left=8 ,top=728 ,right=71 ,bottom=762 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4' ,left=8 ,top=683 ,right=71 ,bottom=717 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=8 ,top=640 ,right=71 ,bottom=675 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=8 ,top=595 ,right=71 ,bottom=630 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=8 ,top=553 ,right=71 ,bottom=587 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=13 ,top=1077 ,right=262 ,bottom=1111 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='INC01005', left=1622, top=553, right=1873, bottom=587, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3 ,top=590 ,right=1879 ,bottom=590 </L>
	<L> left=3 ,top=635 ,right=1879 ,bottom=635 </L>
	<L> left=3 ,top=677 ,right=1879 ,bottom=677 </L>
	<L> left=3 ,top=720 ,right=1879 ,bottom=720 </L>
	<L> left=3 ,top=810 ,right=1879 ,bottom=810 </L>
	<L> left=3 ,top=852 ,right=1879 ,bottom=852 </L>
	<L> left=3 ,top=897 ,right=1879 ,bottom=897 </L>
	<L> left=3 ,top=939 ,right=1879 ,bottom=939 </L>
	<L> left=3 ,top=984 ,right=1879 ,bottom=984 </L>
	<L> left=3 ,top=1027 ,right=1879 ,bottom=1027 </L>
	<L> left=3 ,top=1072 ,right=1879 ,bottom=1072 </L>
	<L> left=3 ,top=548 ,right=1879 ,bottom=548 </L>
	<T>id='(7)���޿���' ,left=82 ,top=413 ,right=262 ,bottom=545 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=8 ,top=413 ,right=71 ,bottom=545 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=77 ,top=407 ,right=77 ,bottom=1072 </L>
	<C>id='INC01001', left=275, top=553, right=476, bottom=587, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02001', left=275, top=595, right=476, bottom=630, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03001', left=275, top=640, right=476, bottom=675, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04001', left=275, top=683, right=476, bottom=717, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05001', left=275, top=728, right=476, bottom=762, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06001', left=275, top=770, right=476, bottom=807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07001', left=275, top=815, right=476, bottom=849, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08001', left=275, top=860, right=476, bottom=892, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09001', left=275, top=902, right=476, bottom=937, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10001', left=275, top=945, right=476, bottom=982, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11001', left=275, top=990, right=476, bottom=1024, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12001', left=275, top=1035, right=476, bottom=1069, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC001', left=275, top=1077, right=476, bottom=1111, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(8)�޿���' ,left=275 ,top=463 ,right=476 ,bottom=542 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(9)�󿩾�' ,left=489 ,top=463 ,right=691 ,bottom=542 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(10)������' ,left=704 ,top=463 ,right=905 ,bottom=542 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(11)��' ,left=1381 ,top=463 ,right=1611 ,bottom=542 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='INC01002', left=489, top=553, right=691, bottom=587, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02002', left=489, top=595, right=691, bottom=630, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03002', left=489, top=640, right=691, bottom=675, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04002', left=489, top=683, right=691, bottom=717, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05002', left=489, top=728, right=691, bottom=762, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06002', left=489, top=770, right=691, bottom=807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07002', left=489, top=815, right=691, bottom=849, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08002', left=489, top=860, right=691, bottom=892, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09002', left=489, top=902, right=691, bottom=937, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10002', left=489, top=945, right=691, bottom=982, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11002', left=489, top=990, right=691, bottom=1024, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12002', left=489, top=1035, right=691, bottom=1069, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC002', left=489, top=1077, right=691, bottom=1111, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC01003', left=704, top=553, right=905, bottom=587, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02003', left=704, top=595, right=905, bottom=630, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03003', left=704, top=640, right=905, bottom=675, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04003', left=704, top=683, right=905, bottom=717, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05003', left=704, top=728, right=905, bottom=762, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06003', left=704, top=770, right=905, bottom=807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07003', left=704, top=815, right=905, bottom=849, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08003', left=704, top=860, right=905, bottom=892, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09003', left=704, top=902, right=905, bottom=937, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10003', left=704, top=945, right=905, bottom=982, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11003', left=704, top=990, right=905, bottom=1024, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12003', left=704, top=1035, right=905, bottom=1069, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC003', left=704, top=1077, right=905, bottom=1111, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���ñ��������' ,left=918 ,top=503 ,right=1148 ,bottom=542 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1151 ,top=455 ,right=1151 ,bottom=1119 </L>
	<T>id='(10-1)�ֽĸż�' ,left=918 ,top=466 ,right=1148 ,bottom=505 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(10-2)�츮����' ,left=1156 ,top=466 ,right=1376 ,bottom=505 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=765 ,right=1879 ,bottom=765 </L>
	<T>id='���������' ,left=1156 ,top=503 ,right=1376 ,bottom=542 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(12)���̼���ǥ' ,left=1622 ,top=431 ,right=1871 ,bottom=471 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='� ���� �ҵ漼' ,left=1622 ,top=476 ,right=1871 ,bottom=519 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='INC02005', left=1622, top=595, right=1873, bottom=630, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03005', left=1622, top=640, right=1873, bottom=675, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04005', left=1622, top=683, right=1873, bottom=717, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05005', left=1622, top=728, right=1873, bottom=762, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06005', left=1622, top=770, right=1873, bottom=807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07005', left=1622, top=815, right=1873, bottom=849, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08005', left=1622, top=860, right=1873, bottom=892, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09005', left=1622, top=902, right=1873, bottom=937, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10005', left=1622, top=945, right=1873, bottom=982, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11005', left=1622, top=990, right=1873, bottom=1024, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12005', left=1622, top=1035, right=1873, bottom=1069, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC005', left=1622, top=1077, right=1873, bottom=1111, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC01004', left=1381, top=553, right=1611, bottom=587, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02004', left=1381, top=595, right=1611, bottom=630, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03004', left=1381, top=640, right=1611, bottom=675, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04004', left=1381, top=683, right=1611, bottom=717, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05004', left=1381, top=728, right=1611, bottom=762, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06004', left=1381, top=770, right=1611, bottom=807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07004', left=1381, top=815, right=1611, bottom=849, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08004', left=1381, top=860, right=1611, bottom=892, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09004', left=1381, top=902, right=1611, bottom=937, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10004', left=1381, top=945, right=1611, bottom=982, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11004', left=1381, top=990, right=1611, bottom=1024, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12004', left=1381, top=1035, right=1611, bottom=1069, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC004', left=1381, top=1077, right=1611, bottom=1111, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1376 ,top=455 ,right=1376 ,bottom=1119 </L>
	<L> left=270 ,top=455 ,right=1617 ,bottom=455 </L>
	<T>id='��' ,left=13 ,top=1849 ,right=262 ,bottom=1884 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='YYYY', left=82, top=1804, right=262, bottom=1839 ,mask='XXXX�� 12��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1762, right=262, bottom=1797 ,mask='XXXX�� 11��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1717, right=262, bottom=1752 ,mask='XXXX�� 10��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1672, right=262, bottom=1709 ,mask='XXXX�� 09��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1630, right=262, bottom=1664 ,mask='XXXX�� 08��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1588, right=262, bottom=1619 ,mask='XXXX�� 07��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1543, right=262, bottom=1577 ,mask='XXXX�� 06��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1498, right=262, bottom=1535 ,mask='XXXX�� 05��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1455, right=262, bottom=1490 ,mask='XXXX�� 04��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1410, right=262, bottom=1445 ,mask='XXXX�� 03��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1368, right=262, bottom=1402 ,mask='XXXX�� 02��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=82, top=1323, right=262, bottom=1357 ,mask='XXXX�� 01��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='(13)���޿���' ,left=82 ,top=1273 ,right=259 ,bottom=1315 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12' ,left=8 ,top=1804 ,right=71 ,bottom=1839 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11' ,left=8 ,top=1762 ,right=71 ,bottom=1797 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10' ,left=8 ,top=1717 ,right=71 ,bottom=1752 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9' ,left=8 ,top=1672 ,right=71 ,bottom=1709 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=8 ,top=1630 ,right=71 ,bottom=1664 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=8 ,top=1588 ,right=71 ,bottom=1619 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=8 ,top=1543 ,right=71 ,bottom=1577 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5' ,left=8 ,top=1498 ,right=71 ,bottom=1535 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4' ,left=8 ,top=1455 ,right=71 ,bottom=1490 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=8 ,top=1410 ,right=71 ,bottom=1445 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=8 ,top=1368 ,right=71 ,bottom=1402 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=8 ,top=1323 ,right=71 ,bottom=1357 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1842 ,right=1879 ,bottom=1842 </L>
	<L> left=3 ,top=1318 ,right=1879 ,bottom=1318 </L>
	<L> left=3 ,top=1363 ,right=1879 ,bottom=1363 </L>
	<L> left=3 ,top=1405 ,right=1879 ,bottom=1405 </L>
	<L> left=3 ,top=1447 ,right=1879 ,bottom=1447 </L>
	<L> left=3 ,top=1492 ,right=1879 ,bottom=1492 </L>
	<L> left=3 ,top=1537 ,right=1879 ,bottom=1537 </L>
	<L> left=3 ,top=1580 ,right=1879 ,bottom=1580 </L>
	<L> left=3 ,top=1625 ,right=1879 ,bottom=1625 </L>
	<L> left=3 ,top=1667 ,right=1879 ,bottom=1667 </L>
	<L> left=3 ,top=1712 ,right=1879 ,bottom=1712 </L>
	<L> left=3 ,top=1754 ,right=1879 ,bottom=1754 </L>
	<L> left=3 ,top=1799 ,right=1879 ,bottom=1799 </L>
	<T>id='��      ��      ��      ��      ��' ,left=13 ,top=1122 ,right=1873 ,bottom=1169 ,face='HY�߰���' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1172 ,right=1881 ,bottom=1172 </L>
	<L> left=77 ,top=1172 ,right=77 ,bottom=1842 </L>
	<T>id='(13-1)��   ȭ' ,left=275 ,top=1273 ,right=476 ,bottom=1315 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FRE02001', left=275, top=1368, right=476, bottom=1402, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03001', left=275, top=1410, right=476, bottom=1445, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04001', left=275, top=1455, right=476, bottom=1490, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05001', left=275, top=1498, right=476, bottom=1535, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06001', left=275, top=1543, right=476, bottom=1577, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07001', left=275, top=1588, right=476, bottom=1619, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08001', left=275, top=1630, right=476, bottom=1664, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09001', left=275, top=1672, right=476, bottom=1709, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10001', left=275, top=1717, right=476, bottom=1752, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11001', left=275, top=1762, right=476, bottom=1797, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12001', left=275, top=1804, right=476, bottom=1839, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE001', left=275, top=1849, right=476, bottom=1884, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE01001', left=275, top=1323, right=476, bottom=1357, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(13-2)��  ȭ' ,left=489 ,top=1273 ,right=691 ,bottom=1315 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FRE01002', left=489, top=1323, right=691, bottom=1357, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02002', left=489, top=1368, right=691, bottom=1402, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03002', left=489, top=1410, right=691, bottom=1445, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04002', left=489, top=1455, right=691, bottom=1490, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05002', left=489, top=1498, right=691, bottom=1535, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06002', left=489, top=1543, right=691, bottom=1577, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07002', left=489, top=1588, right=691, bottom=1619, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08002', left=489, top=1630, right=691, bottom=1664, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09002', left=489, top=1672, right=691, bottom=1709, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10002', left=489, top=1717, right=691, bottom=1752, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11002', left=489, top=1762, right=691, bottom=1797, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12002', left=489, top=1804, right=691, bottom=1839, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE002', left=489, top=1849, right=691, bottom=1884, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� �� �� �� ��' ,left=98 ,top=1222 ,right=691 ,bottom=1265 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=693 ,top=1217 ,right=693 ,bottom=1889 </L>
	<L> left=77 ,top=1267 ,right=693 ,bottom=1267 </L>
	<T>id='����' ,left=8 ,top=1180 ,right=71 ,bottom=1315 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(14)�߰��ٷ�' ,left=699 ,top=1225 ,right=900 ,bottom=1267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=699 ,top=1273 ,right=900 ,bottom=1315 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=902 ,top=1217 ,right=902 ,bottom=1889 </L>
	<C>id='FRE01003', left=699, top=1323, right=900, bottom=1357, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02003', left=699, top=1368, right=900, bottom=1402, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03003', left=699, top=1410, right=900, bottom=1445, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04003', left=699, top=1455, right=900, bottom=1490, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05003', left=699, top=1498, right=900, bottom=1535, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06003', left=699, top=1543, right=900, bottom=1577, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07003', left=699, top=1588, right=900, bottom=1619, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08003', left=699, top=1630, right=900, bottom=1664, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09003', left=699, top=1672, right=900, bottom=1709, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10003', left=699, top=1717, right=900, bottom=1752, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11003', left=699, top=1762, right=900, bottom=1797, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12003', left=699, top=1804, right=900, bottom=1839, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE003', left=699, top=1849, right=900, bottom=1884, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(22) �����' ,left=1622 ,top=1207 ,right=1871 ,bottom=1249 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�հ�' ,left=1622 ,top=1251 ,right=1871 ,bottom=1294 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FRE01005', left=1381, top=1323, right=1611, bottom=1357, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02005', left=1381, top=1368, right=1611, bottom=1402, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03005', left=1381, top=1410, right=1611, bottom=1445, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04005', left=1381, top=1455, right=1611, bottom=1490, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05005', left=1381, top=1498, right=1611, bottom=1535, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06005', left=1381, top=1543, right=1611, bottom=1577, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07005', left=1381, top=1588, right=1611, bottom=1619, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08005', left=1381, top=1630, right=1611, bottom=1664, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10005', left=1381, top=1717, right=1611, bottom=1752, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11005', left=1381, top=1762, right=1611, bottom=1797, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12005', left=1381, top=1804, right=1611, bottom=1839, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE005', left=1381, top=1849, right=1611, bottom=1884, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1376 ,top=1172 ,right=1376 ,bottom=1889 </L>
	<T>id='(16)�ܱ���' ,left=1156 ,top=1225 ,right=1376 ,bottom=1267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷ���' ,left=1156 ,top=1273 ,right=1376 ,bottom=1315 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1151 ,top=1217 ,right=1151 ,bottom=1889 </L>
	<T>id='(15)���' ,left=918 ,top=1225 ,right=1148 ,bottom=1267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� ��' ,left=918 ,top=1273 ,right=1148 ,bottom=1315 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1617 ,top=1172 ,right=1617 ,bottom=1889 </L>
	<T>id='�����' ,left=1381 ,top=1267 ,right=1611 ,bottom=1310 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����' ,left=1381 ,top=1228 ,right=1611 ,bottom=1270 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(21)���޸�����' ,left=1381 ,top=1188 ,right=1611 ,bottom=1230 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=79 ,top=1217 ,right=1376 ,bottom=1217 </L>
	<T>id='�� �� �� �� ��  �� ��  �� ��  �� �� ��' ,left=101 ,top=1175 ,right=1371 ,bottom=1217 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=921 ,top=1945 ,right=921 ,bottom=2611 </L>
	<L> left=667 ,top=1995 ,right=667 ,bottom=2611 </L>
	<L> left=1119 ,top=1995 ,right=1119 ,bottom=2611 </L>
	<L> left=1341 ,top=1995 ,right=1341 ,bottom=2611 </L>
	<L> left=1556 ,top=1995 ,right=1556 ,bottom=2611 </L>
	<L> left=1741 ,top=1995 ,right=1741 ,bottom=2611 </L>
	<T>id='2010��02��28��' ,left=370 ,top=2648 ,right=640 ,bottom=2696 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡���ǹ��� : ' ,left=770 ,top=2648 ,right=1114 ,bottom=2696 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �Ǵ� ��)' ,left=1516 ,top=2648 ,right=1797 ,bottom=2696 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1119 ,right=1881 ,bottom=1119 </L>
	<L> left=3 ,top=1889 ,right=1879 ,bottom=1889 </L>
	<L> left=267 ,top=1270 ,right=267 ,bottom=1889 </L>
	<L> left=479 ,top=1270 ,right=479 ,bottom=1889 </L>
	<L> left=479 ,top=1995 ,right=479 ,bottom=2611 </L>
	<L> left=267 ,top=1945 ,right=267 ,bottom=2611 </L>
	<T>id='�ۼ����� :' ,left=191 ,top=2648 ,right=370 ,bottom=2696 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��)' ,left=1048 ,top=2648 ,right=1289 ,bottom=2696 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=267 ,top=1995 ,right=1879 ,bottom=1995 </L>
	<C>id='FRE01_SUM', left=1622, top=1323, right=1876, bottom=1357, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09005', left=1378, top=1672, right=1609, bottom=1709, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02_SUM', left=1622, top=1368, right=1876, bottom=1402, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03_SUM', left=1622, top=1410, right=1876, bottom=1445, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04_SUM', left=1622, top=1455, right=1876, bottom=1490, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05_SUM', left=1622, top=1498, right=1876, bottom=1532, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06_SUM', left=1622, top=1543, right=1876, bottom=1577, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07_SUM', left=1622, top=1588, right=1876, bottom=1622, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08_SUM', left=1622, top=1630, right=1876, bottom=1664, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09_SUM', left=1622, top=1672, right=1876, bottom=1707, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10_SUM', left=1622, top=1717, right=1876, bottom=1752, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11_SUM', left=1622, top=1762, right=1876, bottom=1797, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12_SUM', left=1622, top=1804, right=1876, bottom=1839, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE_SUM', left=1622, top=1849, right=1876, bottom=1884, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script>
<!-- <B>id=Footer ,left=0 ,top=2770 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=9 ,top=19 ,right=1875 ,bottom=97</T>
	<I>id='../../Common/img/icon.jpg' ,left=1503 ,top=0 ,right=1884 ,bottom=94</I>
	<L> left=3 ,top=0 ,right=1875 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B> -->

<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� : �Ƿ�����޸�����  -  R E P O R T 
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print2_2"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_temp">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"						VALUE="

	">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ� : ��αݸ�����  -  R E P O R T
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_temp"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_temp">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2584 ,face='����' ,size=10 ,penwidth=1
	<X>left=31 ,top=69 ,right=338 ,bottom=147 ,border=true</X>
	<L> left=3 ,top=47 ,right=1888 ,bottom=47 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3 ,top=162 ,right=1888 ,bottom=162 </L>
	<L> left=3 ,top=259 ,right=1888 ,bottom=259 </L>
	<L> left=3 ,top=359 ,right=1888 ,bottom=359 </L>
	<L> left=709 ,top=262 ,right=709 ,bottom=359 </L>
	<L> left=1100 ,top=262 ,right=1100 ,bottom=359 </L>
	<T>id='��  ��  ��  ��  ��  ��' ,left=356 ,top=56 ,right=1872 ,bottom=131 ,face='HY�߰���' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��. ��õ¡���ǹ��� ��������' ,left=13 ,top=169 ,right=1872 ,bottom=250 ,align='left' ,face='HY�߰���' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ͼӿ���' ,left=38 ,top=75 ,right=181 ,bottom=141 ,align='left'</T>
	<T>id='2)����ڵ�Ϲ�ȣ' ,left=716 ,top=266 ,right=1094 ,bottom=356 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��)' ,left=331 ,top=266 ,right=706 ,bottom=356 ,align='left'</T>
	<T>id='101-85-10695' ,left=1119 ,top=266 ,right=1638 ,bottom=356 ,align='left'</T>
	<T>id='(�ܱ���Ȯ�ι�ȣ)' ,left=716 ,top=512 ,right=1094 ,bottom=553 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4)�ֹε�Ϲ�ȣ' ,left=716 ,top=462 ,right=1094 ,bottom=506 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=556 ,right=1888 ,bottom=556 </L>
	<L> left=6 ,top=456 ,right=1888 ,bottom=456 </L>
	<T>id='��. �ҵ���(�������� ��û��) ��������' ,left=13 ,top=366 ,right=1872 ,bottom=447 ,align='left' ,face='HY�߰���' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1100 ,top=456 ,right=1100 ,bottom=556 </L>
	<L> left=709 ,top=456 ,right=709 ,bottom=556 </L>
	<L> left=184 ,top=69 ,right=184 ,bottom=144 </L>
	<T>id='��. ��α� ���޳���' ,left=13 ,top=562 ,right=1872 ,bottom=644 ,align='left' ,face='HY�߰���' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=0 ,top=1459 ,right=1888 ,bottom=1459 </L>
	<L> left=0 ,top=1397 ,right=1888 ,bottom=1397 </L>
	<L> left=0 ,top=1334 ,right=1888 ,bottom=1334 </L>
	<L> left=0 ,top=1272 ,right=1888 ,bottom=1272 </L>
	<L> left=0 ,top=1209 ,right=1888 ,bottom=1209 </L>
	<L> left=0 ,top=1147 ,right=1888 ,bottom=1147 </L>
	<L> left=0 ,top=1084 ,right=1888 ,bottom=1084 </L>
	<L> left=0 ,top=1022 ,right=1888 ,bottom=1022 </L>
	<L> left=0 ,top=959 ,right=1888 ,bottom=959 </L>
	<C>id='GIVSAUP_1', left=16, top=841, right=306, bottom=894</C>
	<L> left=0 ,top=897 ,right=1888 ,bottom=897 </L>
	<C>id='GIVCOD_1', left=1334, top=841, right=1466, bottom=894</C>
	<L> left=0 ,top=834 ,right=1888 ,bottom=834 </L>
	<L> left=0 ,top=834 ,right=1888 ,bottom=834 </L>
	<T>id='�� ��' ,left=1475 ,top=659 ,right=1606 ,bottom=828 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1334 ,top=659 ,right=1466 ,bottom=828 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=797 ,top=659 ,right=1325 ,bottom=828 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ��ȣ' ,left=13 ,top=737 ,right=309 ,bottom=828 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=6 ,top=653 ,right=1888 ,bottom=653 </L>
	<L> left=0 ,top=1522 ,right=1888 ,bottom=1522 </L>
	<C>id={decode(GIVCNT_1,0,'',GIVCNT_1)}, left=1475, top=841, right=1606, bottom=894</C>
	<T>id='���ó ��������' ,left=13 ,top=659 ,right=788 ,bottom=725 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��       ȣ' ,left=319 ,top=737 ,right=788 ,bottom=828 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=0 ,top=731 ,right=791 ,bottom=731 </L>
	<C>id='GIVCOMP_1', left=319, top=841, right=788, bottom=894, align='left'</C>
	<T>id='�� ��' ,left=1616 ,top=659 ,right=1878 ,bottom=828 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(GIVAMT_1,0,'',GIVAMT_1)}, left=1616, top=841, right=1878, bottom=894, align='right'</C>
	<C>id='GIVTYPE_1', left=797, top=841, right=1325, bottom=894, align='left'</C>
	<L> left=0 ,top=1647 ,right=1888 ,bottom=1647 </L>
	<L> left=0 ,top=1584 ,right=1888 ,bottom=1584 </L>
	<L> left=0 ,top=1709 ,right=1888 ,bottom=1709 </L>
	<L> left=313 ,top=731 ,right=313 ,bottom=1709 </L>
	<L> left=791 ,top=656 ,right=791 ,bottom=1709 </L>
	<L> left=1328 ,top=653 ,right=1328 ,bottom=1709 </L>
	<L> left=1469 ,top=653 ,right=1469 ,bottom=1709 </L>
	<L> left=1609 ,top=656 ,right=1609 ,bottom=1709 </L>
	<T>id=' ������ ' ,left=203 ,top=1775 ,right=328 ,bottom=1828 ,align='left'</T>
	<T>id='�� �����մϴ�.' ,left=600 ,top=1775 ,right=866 ,bottom=1828 ,align='left'</T>
	<T>id='\'��α� ������\'' ,left=331 ,top=1775 ,right=597 ,bottom=1828 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ҵ漼������52�� �� �ҵ漼������� 112���� 2�� ������ ���Ͽ� ��������� ��α��� ' ,left=266 ,top=1719 ,right=1859 ,bottom=1772 ,align='left'</T>
	<C>id='CURDT', left=859, top=1831, right=1266, bottom=1878, align='left' ,mask='XXXX��  XX��  XX��'</C>
	<L> left=0 ,top=2003 ,right=1888 ,bottom=2003 </L>
	<T>id='�ڵ�' ,left=1259 ,top=2009 ,right=1363 ,bottom=2062 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     ��     ��' ,left=13 ,top=2009 ,right=1250 ,bottom=2062 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=0 ,top=2066 ,right=1888 ,bottom=2066 </L>
	<T>id='42' ,left=1259 ,top=2409 ,right=1363 ,bottom=2462</T>
	<T>id='41' ,left=1259 ,top=2353 ,right=1363 ,bottom=2406</T>
	<T>id='40' ,left=1259 ,top=2297 ,right=1363 ,bottom=2350</T>
	<T>id='30' ,left=1259 ,top=2241 ,right=1363 ,bottom=2294</T>
	<T>id='21' ,left=1259 ,top=2184 ,right=1363 ,bottom=2237</T>
	<T>id='20' ,left=1259 ,top=2128 ,right=1363 ,bottom=2181</T>
	<T>id='10' ,left=1259 ,top=2072 ,right=1363 ,bottom=2125</T>
	<T>id='50' ,left=1263 ,top=2466 ,right=1366 ,bottom=2519</T>
	<L> left=1366 ,top=2006 ,right=1366 ,bottom=2525 </L>
	<L> left=1253 ,top=2006 ,right=1253 ,bottom=2525 </L>
	<T>id=' (�츮�������� ��α�)' ,left=1372 ,top=2409 ,right=1881 ,bottom=2462 ,align='left'</T>
	<T>id=' (������ü��α�)' ,left=1372 ,top=2353 ,right=1881 ,bottom=2406 ,align='left'</T>
	<T>id=' (������α�)' ,left=1372 ,top=2297 ,right=1881 ,bottom=2350 ,align='left'</T>
	<T>id=' (Ư�ʱ�α�)' ,left=1372 ,top=2241 ,right=1881 ,bottom=2294 ,align='left'</T>
	<T>id=' (��ȭ���������� ��α�)' ,left=1372 ,top=2184 ,right=1881 ,bottom=2237 ,align='left'</T>
	<T>id=' (��Ư�� 76 ��ġ�ڱ�)' ,left=1372 ,top=2128 ,right=1881 ,bottom=2181 ,align='left'</T>
	<T>id=' (������α�)' ,left=1372 ,top=2072 ,right=1881 ,bottom=2125 ,align='left'</T>
	<T>id=' (��Ÿ��α�)' ,left=1372 ,top=2466 ,right=1881 ,bottom=2519 ,align='left'</T>
	<T>id='�츮����' ,left=19 ,top=2409 ,right=191 ,bottom=2462 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=19 ,top=2353 ,right=191 ,bottom=2406 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=19 ,top=2297 ,right=191 ,bottom=2350 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��' ,left=19 ,top=2241 ,right=191 ,bottom=2294 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=19 ,top=2184 ,right=191 ,bottom=2237 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ġ�ڱ�' ,left=19 ,top=2128 ,right=191 ,bottom=2181 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=19 ,top=2072 ,right=191 ,bottom=2125 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(����Ư�����ѹ� ��88����4 �츮�������տ� ������ ��α�)' ,left=203 ,top=2409 ,right=1250 ,bottom=2462 ,align='left'</T>
	<T>id='(�ҵ漼�� ��34�� ��1�� ��α� �� ������ü��α�)' ,left=203 ,top=2353 ,right=1250 ,bottom=2406 ,align='left'</T>
	<T>id='(�ҵ漼�� ��34�� ��1�� ��α�)' ,left=203 ,top=2297 ,right=1250 ,bottom=2350 ,align='left'</T>
	<T>id='(����Ư�����ѹ� ��73�� ��1�� ��α�, ��1ȣ ����)' ,left=203 ,top=2241 ,right=1250 ,bottom=2294 ,align='left'</T>
	<T>id='(����Ư�����ѹ� ��73�� ��1�� ��1ȣ ��α�)' ,left=203 ,top=2184 ,right=1250 ,bottom=2237 ,align='left'</T>
	<T>id='(����Ư�����ѹ� ��76�� ��α�)' ,left=203 ,top=2128 ,right=1250 ,bottom=2181 ,align='left'</T>
	<T>id='(�ҵ漼�� ��34�� ��2�� ��α�)' ,left=203 ,top=2072 ,right=1250 ,bottom=2125 ,align='left'</T>
	<T>id='��Ÿ' ,left=19 ,top=2466 ,right=191 ,bottom=2519 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��� �̿��� ��Ÿ��α�)' ,left=203 ,top=2466 ,right=1250 ,bottom=2519 ,align='left'</T>
	<T>id='����' ,left=422 ,top=1937 ,right=525 ,bottom=1997 ,align='left'</T>
	<C>id='EMPNMK', left=181, top=1937, right=388, bottom=1997, align='left'</C>
	<T>id='(��)' ,left=1747 ,top=1900 ,right=1850 ,bottom=1947 ,align='left'</T>
	<T>id='����ƻ�(��)' ,left=1438 ,top=1900 ,right=1697 ,bottom=1947 ,align='left'</T>
	<T>id='�� �� ��' ,left=1191 ,top=1900 ,right=1388 ,bottom=1947 ,align='left'</T>
	<L> left=0 ,top=2525 ,right=1888 ,bottom=2525 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3 ,top=50 ,right=3 ,bottom=2525 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1888 ,top=50 ,right=1888 ,bottom=2525 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210mm x 297mm(�Ź����� 54g/��)' ,left=894 ,top=2537 ,right=1884 ,bottom=2578 ,align='right'</T>
	<C>id='YYYY', left=191, top=75, right=331, bottom=141 ,mask='XXXX'</C>
	<T>id='��     ��' ,left=1372 ,top=2009 ,right=1881 ,bottom=2062 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=313 ,top=456 ,right=313 ,bottom=556 </L>
	<L> left=313 ,top=262 ,right=313 ,bottom=359 </L>
	<T>id='3)��   ��' ,left=13 ,top=462 ,right=309 ,bottom=553 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1)��ü��' ,left=13 ,top=266 ,right=309 ,bottom=356 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=331, top=462, right=706, bottom=553, align='left'</C>
	<C>id='RESINO', left=1119, top=462, right=1716, bottom=553, align='left' ,mask='XXXXXX-XXXXXXX'</C>
	<C>id='GIVSAUP_2', left=16, top=903, right=306, bottom=956</C>
	<C>id='GIVCOMP_2', left=319, top=903, right=788, bottom=956, align='left'</C>
	<C>id='GIVTYPE_2', left=797, top=903, right=1325, bottom=956, align='left'</C>
	<C>id='GIVCOD_2', left=1334, top=903, right=1466, bottom=956</C>
	<C>id={decode(GIVCNT_2,0,'',GIVCNT_2)}, left=1475, top=903, right=1606, bottom=956</C>
	<C>id={decode(GIVAMT_2,0,'',GIVAMT_2)}, left=1616, top=903, right=1878, bottom=956, align='right'</C>
	<C>id={decode(GIVAMT_3,0,'',GIVAMT_3)}, left=1616, top=966, right=1878, bottom=1019, align='right'</C>
	<C>id={decode(GIVCNT_3,0,'',GIVCNT_3)}, left=1475, top=966, right=1606, bottom=1019</C>
	<C>id='GIVCOD_3', left=1334, top=966, right=1466, bottom=1019</C>
	<C>id='GIVTYPE_3', left=797, top=966, right=1325, bottom=1019, align='left'</C>
	<C>id='GIVCOMP_3', left=319, top=966, right=788, bottom=1019, align='left'</C>
	<C>id='GIVSAUP_3', left=16, top=966, right=306, bottom=1019</C>
	<C>id='GIVSAUP_4', left=16, top=1028, right=306, bottom=1081</C>
	<C>id='GIVCOMP_4', left=319, top=1028, right=788, bottom=1081, align='left'</C>
	<C>id='GIVTYPE_4', left=797, top=1028, right=1325, bottom=1081, align='left'</C>
	<C>id='GIVCOD_4', left=1334, top=1028, right=1466, bottom=1081</C>
	<C>id={decode(GIVCNT_4,0,'',GIVCNT_4)}, left=1475, top=1028, right=1606, bottom=1081</C>
	<C>id={decode(GIVAMT_4,0,'',GIVAMT_4)}, left=1616, top=1028, right=1878, bottom=1081, align='right'</C>
	<C>id={decode(GIVAMT_5,0,'',GIVAMT_5)}, left=1616, top=1091, right=1878, bottom=1144, align='right'</C>
	<C>id={decode(GIVCNT_5,0,'',GIVCNT_5)}, left=1475, top=1091, right=1606, bottom=1144</C>
	<C>id='GIVCOD_5', left=1334, top=1091, right=1466, bottom=1144</C>
	<C>id='GIVTYPE_5', left=797, top=1091, right=1325, bottom=1144, align='left'</C>
	<C>id='GIVCOMP_5', left=319, top=1091, right=788, bottom=1144, align='left'</C>
	<C>id='GIVSAUP_5', left=16, top=1091, right=306, bottom=1144</C>
	<C>id='GIVSAUP_6', left=16, top=1153, right=306, bottom=1206</C>
	<C>id='GIVCOMP_6', left=319, top=1153, right=788, bottom=1206, align='left'</C>
	<C>id='GIVTYPE_6', left=797, top=1153, right=1325, bottom=1206, align='left'</C>
	<C>id='GIVCOD_6', left=1334, top=1153, right=1466, bottom=1206</C>
	<C>id={decode(GIVCNT_6,0,'',GIVCNT_6)}, left=1475, top=1153, right=1606, bottom=1206</C>
	<C>id={decode(GIVAMT_6,0,'',GIVAMT_6)}, left=1616, top=1153, right=1878, bottom=1206, align='right'</C>
	<C>id={decode(GIVAMT_7,0,'',GIVAMT_7)}, left=1616, top=1216, right=1878, bottom=1269, align='right'</C>
	<C>id={decode(GIVCNT_7,0,'',GIVCNT_7)}, left=1475, top=1216, right=1606, bottom=1269</C>
	<C>id='GIVCOD_7', left=1334, top=1216, right=1466, bottom=1269</C>
	<C>id='GIVTYPE_7', left=797, top=1216, right=1325, bottom=1269, align='left'</C>
	<C>id='GIVCOMP_7', left=319, top=1216, right=788, bottom=1269, align='left'</C>
	<C>id='GIVSAUP_7', left=16, top=1216, right=306, bottom=1269</C>
	<C>id='GIVSAUP_8', left=16, top=1278, right=306, bottom=1331</C>
	<C>id='GIVCOMP_8', left=319, top=1278, right=788, bottom=1331, align='left'</C>
	<C>id='GIVTYPE_8', left=797, top=1278, right=1325, bottom=1331, align='left'</C>
	<C>id='GIVCOD_8', left=1334, top=1278, right=1466, bottom=1331</C>
	<C>id={decode(GIVCNT_8,0,'',GIVCNT_8)}, left=1475, top=1278, right=1606, bottom=1331</C>
	<C>id={decode(GIVAMT_8,0,'',GIVAMT_8)}, left=1616, top=1278, right=1878, bottom=1331, align='right'</C>
	<C>id={decode(GIVAMT_9,0,'',GIVAMT_9)}, left=1616, top=1341, right=1878, bottom=1394, align='right'</C>
	<C>id={decode(GIVCNT_9,0,'',GIVCNT_9)}, left=1475, top=1341, right=1606, bottom=1394</C>
	<C>id='GIVCOD_9', left=1334, top=1341, right=1466, bottom=1394</C>
	<C>id='GIVTYPE_9', left=797, top=1341, right=1325, bottom=1394, align='left'</C>
	<C>id='GIVCOMP_9', left=319, top=1341, right=788, bottom=1394, align='left'</C>
	<C>id='GIVSAUP_9', left=16, top=1341, right=306, bottom=1394</C>
	<C>id='GIVSAUP_10', left=16, top=1403, right=306, bottom=1456</C>
	<C>id='GIVCOMP_10', left=319, top=1403, right=788, bottom=1456, align='left'</C>
	<C>id='GIVTYPE_10', left=797, top=1403, right=1325, bottom=1456, align='left'</C>
	<C>id='GIVCOD_10', left=1334, top=1403, right=1466, bottom=1456</C>
	<C>id={decode(GIVCNT_10,0,'',GIVCNT_10)}, left=1475, top=1403, right=1606, bottom=1456</C>
	<C>id={decode(GIVAMT_10,0,'',GIVAMT_10)}, left=1616, top=1403, right=1878, bottom=1456, align='right'</C>
	<C>id={decode(GIVAMT_11,0,'',GIVAMT_11)}, left=1616, top=1466, right=1878, bottom=1519, align='right'</C>
	<C>id={decode(GIVCNT_11,0,'',GIVCNT_11)}, left=1475, top=1466, right=1606, bottom=1519</C>
	<C>id='GIVCOD_11', left=1334, top=1466, right=1466, bottom=1519</C>
	<C>id='GIVTYPE_11', left=797, top=1466, right=1325, bottom=1519, align='left'</C>
	<C>id='GIVCOMP_11', left=319, top=1466, right=788, bottom=1519, align='left'</C>
	<C>id='GIVSAUP_11', left=16, top=1466, right=306, bottom=1519</C>
	<C>id='GIVSAUP_12', left=16, top=1528, right=306, bottom=1581</C>
	<C>id='GIVCOMP_12', left=319, top=1528, right=788, bottom=1581, align='left'</C>
	<C>id='GIVTYPE_12', left=797, top=1528, right=1325, bottom=1581, align='left'</C>
	<C>id='GIVCOD_12', left=1334, top=1528, right=1466, bottom=1581</C>
	<C>id={decode(GIVCNT_12,0,'',GIVCNT_12)}, left=1475, top=1528, right=1606, bottom=1581</C>
	<C>id={decode(GIVAMT_12,0,'',GIVAMT_12)}, left=1616, top=1528, right=1878, bottom=1581, align='right'</C>
	<C>id={decode(GIVAMT_13,0,'',GIVAMT_13)}, left=1616, top=1591, right=1878, bottom=1644, align='right'</C>
	<C>id={decode(GIVCNT_13,0,'',GIVCNT_13)}, left=1475, top=1591, right=1606, bottom=1644</C>
	<C>id='GIVCOD_13', left=1334, top=1591, right=1466, bottom=1644</C>
	<C>id='GIVTYPE_13', left=797, top=1591, right=1325, bottom=1644, align='left'</C>
	<C>id='GIVCOMP_13', left=319, top=1591, right=788, bottom=1644, align='left'</C>
	<C>id='GIVSAUP_13', left=16, top=1591, right=306, bottom=1644</C>
	<C>id='GIVSAUP_14', left=16, top=1653, right=306, bottom=1706</C>
	<C>id='GIVCOMP_14', left=319, top=1653, right=788, bottom=1706, align='left'</C>
	<C>id='GIVTYPE_14', left=797, top=1653, right=1325, bottom=1706, align='left'</C>
	<C>id='GIVCOD_14', left=1334, top=1653, right=1466, bottom=1706</C>
	<C>id={decode(GIVCNT_14,0,'',GIVCNT_14)}, left=1475, top=1653, right=1606, bottom=1706</C>
	<C>id={decode(GIVAMT_14,0,'',GIVAMT_14)}, left=1616, top=1653, right=1878, bottom=1706, align='right'</C>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
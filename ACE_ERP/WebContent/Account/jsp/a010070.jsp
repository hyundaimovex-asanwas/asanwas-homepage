<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�Ҽ���������
+ ���α׷� ID	: a010070
+ �� �� �� ��	: ��ȸ|���|����|����|���
+ �� �� �� ��	: �λ�  �ҼӰ����� ȸ�迡�� �����. 
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
+ �� �� �� �� : 				
+ �� �� �� ��	: h010003_s1,h010003_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>�Ҽ���������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Luxequery();		    //�����ڵ�[�ٹ���]
}

/******************************************************************************
	Description : �Ҽ��ڵ� - ��ȸ
******************************************************************************/
function ln_Query(){
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	var str1 = txt_deptcd1.value;
	var str2 = txt_deptnmk1.value;
	
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str1="+str1 +"&v_str2="+str2;
	gcds_dept.Reset();
	
	gcem_deptcd.enabled = false;

	if (gcds_dept.namevalue(gcds_dept.rowposition,"USEYN") == "T") {
		txt_useyn.checked		= true;
	} else {
		txt_useyn.checked		= false;
	}

	if (gcds_dept.namevalue(gcds_dept.rowposition,"REDTAXYN") == "T") {
		txt_useyn2.checked	= true;
	} else {
		txt_useyn2.checked	= false;
	}

	if (gcds_dept.namevalue(gcds_dept.rowposition,"DEPTGB") == "3"||
	    gcds_dept.namevalue(gcds_dept.rowposition,"DEPTGB") == "6"||
		gcds_dept.namevalue(gcds_dept.rowposition,"DEPTGB") == "8" ) {
		gclx_site.enable	= true;
	} else {
		gclx_site.enable	= false;
	}

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	if (gcds_dept.countrow < 1) {	
		alert("��ȸ �� �����͸� ����� �ֽʽÿ�");
	}else{
		gcds_dept.addrow();
		ln_site();
		gcem_deptcd.enabled	= true;
		txt_useyn.checked	= false;
		txt_useyn2.checke	= false;
		gclx_site.enable    = true;
		txt_treecd.value='99999999';
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (!ln_ValchkS()) return;
	if (txt_useyn.checked == true) {
		gcds_dept.namevalue(gcds_dept.rowposition, "USEYN") = "T";
	} else {
		gcds_dept.namevalue(gcds_dept.rowposition, "USEYN") = "F";
	}

	if (txt_useyn2.checked == true) {
		gcds_dept.namevalue(gcds_dept.rowposition, "REDTAXYN") = "T";
	} else {
		gcds_dept.namevalue(gcds_dept.rowposition, "REDTAXYN") = "F";
	}

	var row = gcds_dept.rowposition;
	var level_1 = gcds_dept.namevalue(row, "TREECD");
	var level_2 = gcds_dept.namevalue(row, "TREECD");
	var level_3 = gcds_dept.namevalue(row, "TREECD");

	level_1 = level_1.substring(0,8);		//LEVEL 1 - '00000000'
	level_2 = level_2.substring(4,8);		//LEVEL 2 - '0000'
	level_3 = level_3.substring(6,8);		//LEVEL 3 - '00'
	//level_33 = level_1.substring(0,4);	
	//level_44 = level_1.substring(4,6);

	/*
	if (level_1 == '00000000' && gcds_dept.namevalue(row, "DEPT_LEVEL") != "") {		
			gcds_dept.namevalue(row, "DEPT_LEVEL") = '1';
	} else if (level_2 == '0000' && level_1 != '00000000' && gcds_dept.namevalue(row, "DEPT_LEVEL") != "") {		
			gcds_dept.namevalue(row, "DEPT_LEVEL") = '2';
	} else if (level_3 == '00' && level_2 != '0000' && level_1 != '00000000' && gcds_dept.namevalue(row, "DEPT_LEVEL") != "") {	
			gcds_dept.namevalue(row, "DEPT_LEVEL") = '3';
	} else if (level_3 == '00' && level_2 != '0000' && level_1 != '00000000' && gcds_dept.namevalue(row, "DEPT_LEVEL") != "") {	
			gcds_dept.namevalue(row, "DEPT_LEVEL") = '3';
	}
	*/
	
	if (gcds_dept.IsUpdated) {	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_dept.KeyValue = "h010003_t1(I:USER=gcds_dept)";
			gctr_dept.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_t1";
			prompt('',gcds_dept.text);
			
			gctr_dept.post();
			ln_Query();
		} else gcds_dept.undo(gcds_dept.rowposition);
	}
}


/******************************************************************************
	Description : ������ �̹��� �ҷ�����
******************************************************************************/
function CallMonth(){ // ����˾� ȣ�� �Լ�

	__calMonthRtn = window.showModalDialog("../../Common/jsp/com_month.jsp","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");

}

//��ü�� ��¥���� ����˾����� ���� �� �ֱ� =====
function __GetCallMonth(objNameHead, objValueProp){

	CallMonth();

	if (__calMonthRtn!=null && __calMonthRtn.length>=4 ){

		eval( objNameHead+"."+objValueProp+" = __calMonthRtn" );
		__calMonthRtn=null;
	}

} 

/******************************************************************************
	Description : �Է°� üũ[�߷��ڵ�]
******************************************************************************/
function ln_ValchkS() {
	if (gcem_deptcd.text == "") {			
		alert("��Ȯ�� �Ҽ��ڵ带 �Է��� �ֽʽÿ�");
		gcem_deptcd.focus();
		return false;
	}
	if (txt_deptnmk.value == "") {			
		alert("��Ȯ�� �Ҽ��ڵ���� �Է��� �ֽʽÿ�");
		txt_deptnmk.focus();
		return false;
	}
	return true;
}

/******************************************************************************
	Description : ��ȸ[Tree��������Ʈ]
******************************************************************************/
function ln_Query22(e){
		
	//alert("e::"+e);	
	var str1 = "F";
	var str9 = '99999999';
	if(e==""){
		gcds_dept11.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str1+"&v_str9="+str9;	//Tree��������Ʈ
		gcds_dept11.Reset();
	}else if(e=="2") {
		gcds_dept11.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str1+"&v_str9="+str9;	//Tree��������Ʈ
		gcds_dept11.Reset();

		gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4=F&v_str5=1";		        //�����Ҽ�
		gcds_dept2.Reset();
	}else if(e=="3"){
		gcds_dept11.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str1+"&v_str9="+str9;	//Tree��������Ʈ
		prompt("",gcds_dept11.DataID);
		
		gcds_dept11.Reset();
	}
}

/******************************************************************************
	Description : ��ȸ[�����Ҽ�]
******************************************************************************/
function ln_Query2(e,e2){
	var str1 = "F";
	if(e==""){
		gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str1;		//�����Ҽ�
		gcds_dept2.Reset();
	}else if(e!=""&&e2!="") {
		if(e!="0000") {
			if(e2=="2") {
				gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str5=2&v_str6="+e.substring(0,4);		
				gcds_dept2.Reset();
			}else if(e2=="3") {//3���� ��ȸ
				var str4 = 'F';	
				var str5 = "2";
				var str6 = level_1.substring(0,2);
				gcds_dept2.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str4
											   +"&v_str5="+str5+"&v_str6="+str6;
				gcds_dept2.Reset();
			}else if(e2=="4") {//4���� ��ȸ
				var str4 = 'F';
				var str5 = "3";
				var str6 = level_1.substring(0,2);
				var str7 = level_3;	
				gcds_dept2.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str4
												 +"&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
				gcds_dept2.Reset();
			}else if(e2=="5") {//5���� ��ȸ
				var str4  = 'F';	
				var str5  = "4";
				var str6  = e.substring(0,2);
				var str7  = e.substring(2,4);
				var str12 = e.substring(4,6);
				gcds_dept2.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?&v_str4="+str4
												 +"&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7+"&v_str12="+str12;
				gcds_dept2.Reset();
			}else{
				gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str10="+e+"&v_str11="+e2;		
				gcds_dept2.Reset();
			}
		}else{
			gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4=F&v_str5=1";
			gcds_dept2.Reset();
		}
	}else{
		gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4=F&v_str5=1";
		gcds_dept2.Reset();
	}
}

/******************************************************************************
	Description : ��ȸ[��ü�Ҽ�]
******************************************************************************/
function ln_Query3(){
	var str1 = "F";
	gcds_dept3.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str1;
	gcds_dept3.Reset();
}

/******************************************************************************
	Description : ��ȸ - ������ ��ü ��ȸ
******************************************************************************/
function ln_QueryAll(){
	ln_Query22();	//��������[Tree����]
	ln_Query3();	//��������[��ü�Ҽ�]
}

/******************************************************************************
	Description : ���� - �����Ҽ�[LEFE] �ڵ� ����
******************************************************************************/
function ln_SaveLeft(){
	if (gcds_dept2.IsUpdated) {
		gctr_dept3.KeyValue = "h010003_t3(I:USER=gcds_dept3)";
		gctr_dept3.Action   = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_t3";
		gctr_dept3.post();
		var s_tree  = gcds_dept11.namevalue(gcds_dept11.rowposition,"TREECD");
		var s_level = gcds_dept11.namevalue(gcds_dept11.rowposition,"DEPT_LEVEL");
		if(s_level==2){
			ln_Query2(s_tree.substring(0,2),s_level);
		}else if(s_level==3){
			ln_Query2(s_tree.substring(0,2),"3");
		}else if(s_level==4){
			ln_Query2(s_tree.substring(0,4),"4");
		}else if(s_level==5){
			ln_Query2(s_tree.substring(0,6),"5");
		}
	}
}

/******************************************************************************
	Description : ���� - ��ü�Ҽ�[RIGHT] �ڵ� ����
******************************************************************************/
function ln_SaveRight(){
	if (gcds_dept3.IsUpdated) {
		gctr_dept2.KeyValue = "h010003_t2(I:USER=gcds_dept3)";//gcds_dept2
		gctr_dept2.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_t2";	
		gctr_dept2.post();
		var s_tree  = gcds_dept11.namevalue(gcds_dept11.rowposition,"TREECD");
		var s_level = gcds_dept11.namevalue(gcds_dept11.rowposition,"DEPT_LEVEL");
		if(s_level==2){
			ln_Query2(s_tree.substring(0,2),s_level);
		}else if(s_level==3){
			ln_Query2(s_tree.substring(0,2),"3");
		}else if(s_level==4){
			ln_Query2(s_tree.substring(0,4),"4");
		}else if(s_level==5){
			ln_Query2(s_tree.substring(0,6),"5");
		}
	}
}

/******************************************************************************
	Description : ���� �̵�
******************************************************************************/
function ln_Move(arg){
	if (arg =='GORIGHT') {	//�����Ҽ� --(RIGHT)----> ��ü�Ҽ�
		var row11 = gcds_dept11.rowposition;
		var row02 = gcds_dept2.rowposition;
		var cnt11 = 0;
		
		/* �����μ��� �����ϴ� ��� �̵� ���� */
		if(gcds_dept11.namevalue(row11,"DEPT_LEVEL") == "2" && gcds_dept2.countrow>0) {
			for(var i=1;i<=gcds_dept3.countrow;i++) {
				if(gcds_dept2.namevalue(row02,"TREECD").substring(0,6) == gcds_dept3.namevalue(i,"TREECD").substring(0,6) 
				&& gcds_dept3.namevalue(i,"DEPT_LEVEL") == "4") {
					cnt11 = cnt11+1;
				}
			}
			if(cnt11>0) {
				return false;
			}
		}

		if (gcds_dept2.countrow > 0) {
			//���� �Ҽӹ�ȣ�� ���� �� ���
			//�������� ���ǰ� 99(0,2)�� �ְ� �����Ѵ�.
			for(var i=1;i<=gcds_dept3.countrow;i++)  {	//�����Ҽӿ� ��ü�Ҽ��ڵ尡 ������ �����Ҽ��ڵ��� ROW����		
				if (gcds_dept3.namevalue(i,"DEPTCD") == gcds_dept2.namevalue(gcds_dept2.rowposition,"DEPTCD")) {
					gcds_dept2.namevalue(gcds_dept2.rowposition,"TREECD") = '99999999';
					gcds_dept3.namevalue(i,"TREECD")	= '99999999';
					gcds_dept3.namevalue(i,"DEPT_LEVEL")		= '';
					gcds_dept2.namevalue(gcds_dept2.rowposition,"TREECD") = gcds_dept3.namevalue(i,"TREECD");

					ln_Setheader();	//Temp Header ����
					gcds_temp2.addRow();

					var temp2 = gcds_temp2.rowposition;
					var dept2 = gcds_dept2.rowposition;

					gcds_temp2.namevalue(temp2,"DEPTCD")		= gcds_dept2.namevalue(dept2,"DEPTCD");
					gcds_temp2.namevalue(temp2,"DEPTNM")		= gcds_dept2.namevalue(dept2,"DEPTNM");
					gcds_temp2.namevalue(temp2,"DEPTNMK")		= gcds_dept2.namevalue(dept2,"DEPTNMK");
					gcds_temp2.namevalue(temp2,"DEPTNME")		= gcds_dept2.namevalue(dept2,"DEPTNME");
					gcds_temp2.namevalue(temp2,"DEPTPRT")		= gcds_dept2.namevalue(dept2,"DEPTPRT");
					gcds_temp2.namevalue(temp2,"TREECD")		= '99999999';
					gcds_temp2.namevalue(temp2,"FRDT")			= gcds_dept2.namevalue(dept2,"FRDT");
					gcds_temp2.namevalue(temp2,"TODT")			= gcds_dept2.namevalue(dept2,"TODT");
					gcds_temp2.namevalue(temp2,"USEYN")			= gcds_dept2.namevalue(dept2,"USEYN");
					gcds_temp2.namevalue(temp2,"REDTAXYN")	= gcds_dept2.namevalue(dept2,"REDTAXYN");
					gcds_temp2.namevalue(temp2,"DEPT_LEVEL")			= "";
					gcds_temp2.namevalue(temp2,"DEPTGB")	  = gcds_dept2.namevalue(dept2,"DEPTGB");
					gcds_temp2.namevalue(temp2,"CHGYM")		= gcds_dept2.namevalue(dept2,"CHGYM");
					gcds_dept2.deleterow(gcds_dept2.rowposition);
					ln_SaveRight();
					return false;

					gcds_dept3.addrow(); 
					var lpos = gcds_dept2.rowposition;			//�����Ҽ�
					var rpos = gcds_dept3.rowposition;			//��ü�Ҽ�

					gcds_dept3.namevalue(rpos,"DEPTCD")		=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTCD"));		//�Ҽ��ڵ�
					gcds_dept3.namevalue(rpos,"DEPTNM")		=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTNM"));		//�ҼӾ�Ī
					gcds_dept3.namevalue(rpos,"DEPTNMK")	=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTNMK"));	//�ҼӸ�
					gcds_dept3.namevalue(rpos,"DEPTNME")	=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTNME"));	//�����ҼӸ�
					gcds_dept3.namevalue(rpos,"DEPTPRT")	=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTPRT"));	//�ٹ����ڵ�
					gcds_dept3.namevalue(rpos,"TREECD")		=		"99999999";		//��������
					gcds_dept3.namevalue(rpos,"FRDT")			=		ln_Trim(gcds_dept2.namevalue(lpos,"FRDT"));			//������
					gcds_dept3.namevalue(rpos,"TODT")			=		ln_Trim(gcds_dept2.namevalue(lpos,"TODT"));			//������
					gcds_dept3.namevalue(rpos,"USEYN")		=		ln_Trim(gcds_dept2.namevalue(lpos,"USEYN"));		//�������
					gcds_dept3.namevalue(rpos,"REDTAXYN")	=		ln_Trim(gcds_dept2.namevalue(lpos,"REDTAXYN"));	//���ױ���
					gcds_dept3.namevalue(rpos,"DEPT_LEVEL")		=		"";
					gcds_dept3.namevalue(rpos,"DEPTGB")		=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTGB"));		//��뱸��
					gcds_temp2.namevalue(temp2,"CHGYM")		= gcds_dept2.namevalue(dept2,"CHGYM");
					gcds_dept2.deleterow(lpos);

				}else{
					if (gcds_dept3.namevalue(i,"DEPTCD") == gcds_dept2.namevalue(gcds_dept2.rowposition,"DEPTCD")) {
						gcds_dept3.addrow(); 
				
						var lpos = gcds_dept2.rowposition;			//�����Ҽ�
						var rpos = gcds_dept3.rowposition;			//��ü�Ҽ�

						gcds_dept3.namevalue(rpos,"DEPTCD")		=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTCD"));		//�Ҽ��ڵ�
						gcds_dept3.namevalue(rpos,"DEPTNM")		=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTNM"));		//�ҼӾ�Ī
						gcds_dept3.namevalue(rpos,"DEPTNMK")	=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTNMK"));	//�ҼӸ�
						gcds_dept3.namevalue(rpos,"DEPTNME")	=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTNME"));	//�����ҼӸ�
						gcds_dept3.namevalue(rpos,"DEPTPRT")	=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTPRT"));	//�ٹ����ڵ�
						gcds_dept3.namevalue(rpos,"TREECD")		=		"99999999";		//��������
						gcds_dept3.namevalue(rpos,"FRDT")			=		ln_Trim(gcds_dept2.namevalue(lpos,"FRDT"));			//������
						gcds_dept3.namevalue(rpos,"TODT")			=		ln_Trim(gcds_dept2.namevalue(lpos,"TODT"));			//������
						gcds_dept3.namevalue(rpos,"USEYN")		=		ln_Trim(gcds_dept2.namevalue(lpos,"USEYN"));		//�������
						gcds_dept3.namevalue(rpos,"REDTAXYN")	=		ln_Trim(gcds_dept2.namevalue(lpos,"REDTAXYN"));	//���ױ���
						gcds_dept3.namevalue(rpos,"DEPT_LEVEL")		=		"";
						gcds_dept3.namevalue(rpos,"DEPTGB")		=		ln_Trim(gcds_dept2.namevalue(lpos,"DEPTGB"));		//��뱸��
					  gcds_temp2.namevalue(temp2,"CHGYM")		= gcds_dept2.namevalue(dept2,"CHGYM");
						gcds_dept2.deleterow(lpos);
						ln_SaveRight();
					}
				}
			}		
		} 
		
	}else{
		if (gcds_dept3.countrow>0) {	//�����Ҽ� <----(LEFT)-- ��ü�Ҽ�
			for(var i=1;i<=gcds_dept2.countrow;i++)  {
				if (gcds_dept3.namevalue(gcds_dept3.rowposition,"DEPTCD") == gcds_dept2.namevalue(i,"DEPTCD")) {
					alert("������ �Ҽ��ڵ尡 �����մϴ�");
					return false;
				} else if (gcds_dept3.namevalue(gcds_dept3.rowposition,"DEPTCD") == gcds_dept11.namevalue(gcds_dept11.rowposition,"DEPTCD")) {
					alert("���������� ���� �ҼӴ� �߰��� �� �����ϴ�");
					return false;
				}
			}

			var all_dept = gcds_dept3.namevalue(gcds_dept3.rowposition,"TREECD");		//��ü�μ�
			var sub_tree = gcds_dept2.namevalue(gcds_dept2.rowposition,"TREECD");		//�����μ�
			var man_tree = gcds_dept11.namevalue(gcds_dept11.rowposition,"TREECD");	//������
			var man_lvel = gcds_dept11.namevalue(gcds_dept11.rowposition,"DEPT_LEVEL");	//����
			var suc_tree = "";	//�Ϸ� ������
			var suc_lvel = "";	//�Ϸ� ����

			var sub_cnt = gcds_dept2.countrow;	//�����μ� row
			var man_cnt = gcds_dept11.countrow;	//������ row

			//[������]�� �ڸ��� üũ
			var m_tree01 = man_tree.substring(0,8);	//����1
			var m_tree02 = man_tree.substring(0,2);	//����2
			var m_tree03 = man_tree.substring(2,4);	//����3
			var m_tree04 = man_tree.substring(4,6);	//����4
			var m_tree05 = man_tree.substring(6,8);	//����5

			//[������]�� �ڸ��� üũ
			var m_jari6 = man_tree.substring(2,8);	//2����-��6�ڸ�
			var m_jari4 = man_tree.substring(4,8);	//3����-��4�ڸ�
			var m_jari2 = man_tree.substring(6,8);	//4����-��2�ڸ�

			//[�����μ�]�� �ڸ��� üũ
			if(sub_cnt>0){
			var s_tree02 = sub_tree.substring(0,2);	//����2
			var s_tree03 = sub_tree.substring(2,4);	//����3
			var s_tree04 = sub_tree.substring(4,6);	//����4
			var s_tree05 = sub_tree.substring(6,8);	//����5
			}

			// [row == 0 ���] - (�����μ�üũ�� �� ���ʵ��)
			if (sub_cnt==0 && m_tree01=='00000000') {	//�����μ��� ����1�ϰ��
				suc_tree = "01000000";
				suc_lvel = "2";
			} else if (sub_cnt==0 && m_jari6=='000000' && m_tree01!='00000000') {	//�����μ� 2����
				suc_tree = m_tree02 +"010000";
				suc_lvel = "3";
			} else if (sub_cnt==0 && m_jari4=='0000' && m_jari6!='000000' && m_tree01!='00000000') {	//�����μ� 3����
				suc_tree = m_tree02 + m_tree03 + "0100";
				suc_lvel = "4";
			} else if (sub_cnt==0 && m_jari2=='00' && m_jari4!='0000' && m_jari6!='000000' && m_tree01!='00000000'){	//�����μ� 4����
				suc_tree = m_tree02 + m_tree03 + m_tree04 + "01";
				suc_lvel = "5";
			}
			
			//[row >= 1] - (�����μ�üũ�� �� ���(+1))
			if (sub_cnt>0 && m_tree01=='00000000') {	//�����μ��� ����1�ϰ��
				if (sub_cnt<=8){
					suc_tree = "0"+Number(parseInt(sub_cnt)+1)+"000000";
					suc_lvel = "2";
				}else if(sub_cnt>=9){
					suc_tree = Number(parseInt(sub_cnt)+1)+"000000";
					suc_lvel = "2";
				}
			} else if (sub_cnt>0 && m_jari6=='000000' && m_tree01!='00000000') {	//�����μ� 2����
				if (sub_cnt<=8){
					suc_tree = m_tree02 +"0"+Number(parseInt(sub_cnt)+1)+"0000";
					suc_lvel = "3";
				}else if(sub_cnt>=9){
					suc_tree = m_tree02+Number(parseInt(sub_cnt)+1)+"0000";
					suc_lvel = "3";
				}
			} else if (sub_cnt>0 && m_jari4=='0000' && m_jari6!='000000' && m_tree01!='00000000') {	//�����μ� 3����
				if (sub_cnt<=8){
					suc_tree = m_tree02 + m_tree03 + "0" + Number(parseInt(sub_cnt)+1) + "00";
					suc_lvel = "4";
				}else if(sub_cnt>=9){
					suc_tree = m_tree02 + m_tree03 + Number(parseInt(sub_cnt)+1) + "00";
					suc_lvel = "4";
				}
			} else if (sub_cnt>0 && m_jari2=='00' && m_jari4!='0000' && m_jari6!='000000' && m_tree01!='00000000'){	//�����μ� 4����
				if (sub_cnt<=8){
					suc_tree = m_tree02 + m_tree03 + m_tree04 + "0" + Number(parseInt(sub_cnt)+1);
					suc_lvel = "5";
				}else if(sub_cnt>=9){
					suc_tree = m_tree02 + m_tree03 + m_tree04 + Number(parseInt(sub_cnt)+1);
					suc_lvel = "5";
				}
			}

			gcds_dept2.addrow();
			var lpos = gcds_dept2.rowposition;	//�����Ҽ�
			var rpos = gcds_dept3.rowposition;	//��ü�Ҽ�

			gcds_dept2.namevalue(lpos,"DEPTCD")		=		ln_Trim(gcds_dept3.namevalue(rpos,"DEPTCD"));		//�Ҽ��ڵ�  
			gcds_dept2.namevalue(lpos,"DEPTNM")		=		ln_Trim(gcds_dept3.namevalue(rpos,"DEPTNM"));		//�ҼӾ�Ī  
			gcds_dept2.namevalue(lpos,"DEPTNMK")	=		ln_Trim(gcds_dept3.namevalue(rpos,"DEPTNMK"));	//�ҼӸ�   																																												            
			gcds_dept2.namevalue(lpos,"DEPTNME")	=		ln_Trim(gcds_dept3.namevalue(rpos,"DEPTNME"));	//�����ҼӸ�
			gcds_dept2.namevalue(lpos,"DEPTPRT")	=		ln_Trim(gcds_dept3.namevalue(rpos,"DEPTPRT"));	//�ٹ����ڵ�

			gcds_dept2.namevalue(lpos,"TREECD")		=		suc_tree;	//��������
			gcds_dept3.namevalue(rpos,"TREECD")   =   suc_tree;	//��ü�Ҽӵ� ����� ������������ ����
			gcds_dept2.namevalue(lpos,"DEPT_LEVEL")		=		suc_lvel;	//����
			gcds_dept3.namevalue(rpos,"DEPT_LEVEL")    =   suc_lvel;	//��ü�Ҽӵ� ����� ������ ����

			gcds_dept2.namevalue(lpos,"FRDT")			=		ln_Trim(gcds_dept3.namevalue(rpos,"FRDT"));			//������    
			gcds_dept2.namevalue(lpos,"TODT")			=		ln_Trim(gcds_dept3.namevalue(rpos,"TODT"));			//������    
			gcds_dept2.namevalue(lpos,"USEYN")		=		ln_Trim(gcds_dept3.namevalue(rpos,"USEYN"));		//�������  
			gcds_dept2.namevalue(lpos,"REDTAXYN")	=		ln_Trim(gcds_dept3.namevalue(rpos,"REDTAXYN"));	//���ױ���  
			gcds_dept2.namevalue(lpos,"DEPTGB")		=		ln_Trim(gcds_dept3.namevalue(rpos,"DEPTGB"));		//��뱸��
	   	gcds_dept2.namevalue(lpos,"CHGYM")		=		ln_Trim(gcds_dept3.namevalue(rpos,"CHGYM"));		//������
		}
		ln_SaveLeft();
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if (gcds_dept.countrow <1) {	
		alert("�����Ͻ� �����Ͱ� �����ϴ�.");
	}else{
		if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			gcds_dept.deleterow(gcds_dept.rowposition);
			gctr_dept.KeyValue = "h010003_t1(I:USER=gcds_dept)";
			gctr_dept.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_t1";
			gctr_dept.post();
			ln_Query();
		}else{ gcds_dept.undo(gcds_dept.rowposition); }
	}
	ln_Query();
	ln_Query22();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Level(){
	var row = gcds_dept11.rowposition;
	var level_1 = gcds_dept11.namevalue(row, "TREECD");
	var level_2 = gcds_dept11.namevalue(row, "TREECD");
	var level_3 = gcds_dept11.namevalue(row, "TREECD");

	level_1 = level_1.substring(0,8);		//LEVEL 1 - '00000000'
	level_2 = level_2.substring(4,8);		//LEVEL 2 - '0000'
	level_3 = level_3.substring(6,8);		//LEVEL 3 - '00'
	//level_33 = level_1.substring(0,4);	
	//level_44 = level_1.substring(4,6);

	if (level_1=='00000000' && gcds_dept11.namevalue(row, "DEPT_LEVEL") != "") {			
		gcds_dept11.namevalue(row, "DEPT_LEVEL") = '1';
	}else if (level_2 == '0000' && level_1 != '00000000' && gcds_dept11.namevalue(row, "DEPT_LEVEL") != "") {		
		gcds_dept11.namevalue(row, "DEPT_LEVEL") = '2';
	}else if (level_3 == '00' && level_2 != '0000' && level_1 != '00000000' && gcds_dept11.namevalue(row, "DEPT_LEVEL") != "") {	
		gcds_dept11.namevalue(row, "DEPT_LEVEL") = '3';
	}else if (level_3 == '00' && level_2 != '0000' && level_1 != '00000000' && gcds_dept11.namevalue(row, "DEPT_LEVEL") != "") {	
		gcds_dept11.namevalue(row, "DEPT_LEVEL") = '3';
	}
	return;
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

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
	Description : �� ����
******************************************************************************/
function ln_Tabset(index){
	var div_cm=new Array("div_buhistory","div_information");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}	else 	{
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************
	Description : �����ڵ� ��ȸ
******************************************************************************/
function ln_Luxequery(){
	//�Ҽ��ڵ�[ �ٹ���]
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1111"; 
	gcds_dept1.Reset();

	//�Ҽ��ڵ�[ �ٹ�������]
	gcds_deptgb.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2050"; 
	gcds_deptgb.Reset();

	//��¼�_�ٹ����׷�[ �ٹ�������]
	gcds_groupid.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2051"; 
	gcds_groupid.Reset();

		//������
	gcds_site.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2062"; 
	gcds_site.Reset();

}

/******************************************************************************
	Description : CheckBox[�������]
******************************************************************************/
function ln_Valchk(e,a) {
	var row = gcds_dept.rowposition;
	if (e.checked == true) { 
		gcds_dept.namevalue(row,a) = "T"; 
	} else {
		gcds_dept.namevalue(row,a) = "F";
	}
}

/******************************************************************************
	Description : CheckBox[���ױ���]
******************************************************************************/
function ln_Valchk2(e,a) {
	var row = gcds_dept.rowposition;
	if (e.checked == true) { 
		gcds_dept.namevalue(row,a) = "T"; 
	} else {
		gcds_dept.namevalue(row,a) = "F";
	}
}

/******************************************************************************
	Description : ������ index = 0 
******************************************************************************/

function ln_site(){
	if (gcds_dept.countrow<1) {
	gcds_site.insertrow(1);
	gcds_site.namevalue(1,"MINORCD") = "";
	gcds_site.namevalue(1,"MINORNM") = "";
	gclx_site.index = 0;
	}
}

/******************************************************************************
	Description : ��������
******************************************************************************/
function ln_Trim(str){
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
}

/******************************************************************************
	Description : dataset header ����
******************************************************************************/
function ln_Setheader(){
	var THeader = "DEPTCD:STRING(4),DEPTNM:STRING(50),DEPTNMK:STRING(70),DEPTNME:STRING(50),DEPTPRT:STRING(4),"
				+ "TREECD:STRING(8),FRDT:STRING(8),TODT:STRING(8),USEYN:STRING(1),REDTAXYN:STRING(1),"
				+ "DEPT_LEVEL:STRING(1), DEPTGB:STRING(1), CHGYM:STRING(6), SITE:STRING(1)";
	gcds_temp2.SetDataHeader(THeader);	//Header Set
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!--�Ҽ��ڵ�-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--�����ڵ�[�ٹ���]-->
	<PARAM NAME="SortExpr" VALUE="+MINORNM">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_deptgb" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--�����ڵ�[�ٹ�������]-->
	<PARAM NAME="SortExpr" VALUE="+MINORNM">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept11" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!--��������[TREE]-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!--��������[�����Ҽ�]-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_temp2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--��������[�����Ҽ�] TEMP-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!--��������[��ü�Ҽ�]-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_groupid" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--��¼�_�ٹ����׷�-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_site" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--������-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_dept classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
    <PARAM NAME="KeyValue" VALUE="hdasan_h010003_t1(I:USER=gcds_dept)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_dept2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�����Ҽ� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_dept3 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--��ü�Ҽ� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gs_tab event=OnSelChanged(index)>
	ln_Tabset((index-1));
	ln_Query22(3);
	ln_Query3();
</script>

<script language="javascript" for="gcds_dept2" event=OnLoadStarted()>	//�����ڵ�
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_dept2 event=OnLoadCompleted(rowcount)>//�����Ҽ� �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	lbl_search2.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
	if (rowcount ==0){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 
	gcds_dept11.rowposition = 0;
</script>

<script language="javascript" for="gcgd_dept" event="onClick()">
	if (gcds_dept.namevalue(gcds_dept.rowposition,"USEYN") == "T") {
		txt_useyn.checked		= true;
	} else {
		txt_useyn.checked		= false;
	}

	if (gcds_dept.namevalue(gcds_dept.rowposition,"REDTAXYN") == "T") {
		txt_useyn2.checked	= true;
	} else {
		txt_useyn2.checked	= false;
	}

	if (gcds_dept.namevalue(gcds_dept.rowposition,"DEPTGB") == "3"||
	    gcds_dept.namevalue(gcds_dept.rowposition,"DEPTGB") == "6"||
			gcds_dept.namevalue(gcds_dept.rowposition,"DEPTGB") == "8" ) {
			//alert(gcds_dept.namevalue(gcds_dept.rowposition,"DEPTGB"));
		gclx_site.Enable	= true;
	} else {
		gclx_site.Enable	= false;
	}
</script>

<script language=JavaScript  for=gcds_dept event=OnLoadCompleted(rowcount)>//�Ҽ��ڵ� �� �˻� �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	lbl_search1.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
	if (rowcount ==0 ){ alert("�˻��� ����Ÿ�� �����ϴ�."); } 

	if (rowcount > 1 && gcds_dept.namevalue(gcds_dept.rowposition,"USEYN") == "T") {
		txt_useyn.checked		= true;
	} else {
		txt_useyn.checked		= false;
	}

	if (rowcount > 1 && gcds_dept.namevalue(gcds_dept.rowposition,"REDTAXYN") == "T") {
		txt_useyn2.checked	= true;
	} else {
		txt_useyn2.checked	= false;
	}
</script>

<script language=JavaScript  for=gcds_site event=OnLoadCompleted(rowcount)>
	ln_site();
</script>

<script language="javascript" for="gcds_dept11" event=OnLoadStarted()>	//�����ڵ�
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_dept11 event=OnLoadCompleted(rowcount)>//tree
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	txt_treenm.value = gcds_dept11.namevalue(gcds_dept11.rowposition,"DEPTNMK");	//�����ҼӸ�Ī
	gcds_dept11.rowposition = 0;
</script>

<script language=javascript for=Tb_TreeView event="onClick()">//Tree����
	//�����ҼӸ�Ī
	txt_treenm.value = gcds_dept11.namevalue(gcds_dept11.rowposition,"DEPTNMK");	
	
	var row = gcds_dept11.rowposition;
	var level_1 = gcds_dept11.namevalue(row, "TREECD");
	level_1 = level_1.substring(0,8);	//1����
	level_2 = level_1.substring(0,2);	//2����
	level_3 = level_1.substring(2,4);	//3����
	level_4 = level_1.substring(4,6);	//4����
	level_5 = level_1.substring(6,8);	//5����

	jari_6 = level_1.substring(2,8);	//�� 6�ڸ�
	jari_4 = level_1.substring(4,8);	//�� 4�ڸ�
	jari_2 = level_1.substring(6,8);	//�� 2�ڸ�
	jari04 = level_1.substring(0,4);	//�� 4�ڸ�

	if (level_1=='00000000') {	//���� 1���� �������� ���
		var str4 = "F";	//2���� ��ȸ
		var str5 = "1";
		gcds_dept2.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str4+"&v_str5="+str5;
		gcds_dept2.Reset();
	}else if (jari_6=='000000' && level_1!='00000000') {	//���� 2���� �������� ���
		var str4 = 'F';	//3���� ��ȸ
		var str5 = "2";
		var str6 = level_1.substring(0,2);
		gcds_dept2.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6;
		gcds_dept2.Reset();
	}else if (jari_4=='0000' && jari_6!='000000' && level_1!='00000000') {	//���� 3���� �������� ���
		var str4 = 'F';	//4���� ��ȸ
		var str5 = "3";
		var str6 = level_1.substring(0,2);
		var str7 = level_3;	
		gcds_dept2.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
		gcds_dept2.Reset();
	}else if (jari_2=='00' && jari_4!='0000' && jari_6!='000000' && level_1!='00000000') {	//���� 4���� ����	
		var str4  = 'F';	//5���� ��ȸ
		var str5  = "4";
		var str6  = level_1.substring(0,2);
		var str7  = level_3;	//0000'00'00 
		var str12 = level_4;	//0000'00'00 
		gcds_dept2.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?&v_str4="+str4
		                 +"&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7+"&v_str12="+str12;
		gcds_dept2.Reset();
	}
</script>

<script language=javascript for=gcgd_dept event="OnKeyPress(kcode)">
	if(kcode=="40" || kcode=="38") {
		if(gcds_dept.namevalue(gcds_dept.rowposition, "USEYN") =="T" || 
		   gcds_dept.namevalue(gcds_dept.rowposition, "REDTAXYN") =="T") {
			txt_useyn.checked = true;
			txt_useyn2.checked = true;
		}else{
			txt_useyn.checked = false;
			txt_useyn2.checked = false;
		}
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_dept" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_dept" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_dept.ErrorCode + "\n" + "Error Message : " + gctr_dept.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_dept2" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_dept2" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_dept3" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_dept3" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>


</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td COLSPAN=2 ALING=LEFT>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td width="0" align=RIGHT><NOBR>          
 			<comment id="__NSID__">
 			  <OBJECT id=gs_tab classid=clsid:ED382953-E907-11D3-B694-006097AD7252   VIEWASTEXT style="width:660px;height:20px">	
              	<PARAM NAME="BackColor"       VALUE="#cccccc">
              	<PARAM NAME="titleHeight"      VALUE="30px">
              	<PARAM NAME="DisableBackColor" VALUE="#eeeeee">
              	<PARAM NAME="Format" VALUE="
                	<T>divid=div_buhistory	  title=�Ҽ��ڵ�</T>
                	<T>divid=div_information  title=��������</T>                                  
               ">
			  </OBJECT>
			 </comment><script>__ws__(__NSID__);</script></NOBR>
		  </td>
		</tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td COLSPAN=2>

	<div id="div_buhistory" >
	  <table width="877" cellpadding="1" cellspacing="0" border="0">
	    <tr> 
			<td colspan=8 align=center>
				<table  cellpadding="1" cellspacing="0" border="0" style='width:875px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
			        <tr> 
			          <td style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" >
						  <nobr>&nbsp;�Ҽ��ڵ�&nbsp;</nobr>
					  </td>
			          <td width =260>  &nbsp;
						  <input type=text id =txt_deptcd1 class="txtbox"  width=70 height=18 style="position:relative;left:-5px" maxlength="4" onBlur="bytelength(this,this.value,4);" onkeydown="if(event.keyCode==13) ln_Query();">
					  </td>
			          <td style="border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" class="txtbox" >
				    	<nobr>&nbsp;�� �� ��&nbsp;</nobr>
					  </td>
			          <td width =260> &nbsp;
						  <input type=text id =txt_deptnmk1 class="txtbox" width=70 height=18 style="position:relative;left:-5px" maxlength="70" onBlur="bytelength(this,this.value,70);" onkeydown="if(event.keyCode==13) ln_Query();">
					  </td>
			          <td width=100%>&nbsp;</td>
			          <td><nobr>      
			            <img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:0px" onClick="ln_Delete()" >
			            <img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:0px" onClick="ln_Add()"    >
			            <img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:0px" onClick="ln_Save()"   >
			            <img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:0px" onClick="ln_Query()"  > 
			            </nobr>
					  </td>
        			</tr>
      			</table>
		    </td>
		</tr>
  		<tr><td align=center valign=top>
		    <table cellpadding="1" cellspacing="0" border="0"  style="width:875px;" >
		      <tr> 
		        <td style="width:875" align=center valign=top>
		          <comment id="__NSID__"><OBJECT id=gcgd_dept classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:645px;HEIGHT:479px;border:1 solid #777777;display:block;" viewastext>
		            <PARAM NAME="DataID"          VALUE="gcds_dept">
		            <PARAM NAME="Editable"		  VALUE="false">
		            <PARAM NAME="BorderStyle"	  VALUE="0">
		            <PARAM name="Fillarea"		  VALUE="true">
		            <param name=ColSizing  value="true">
					<param name="sortview"		  VALUE=left>
		            <PARAM NAME="Format"          VALUE="  
		              <FC>Name='�ڵ�'	   ID=DEPTCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	align=CENTER,   sort = true </FC> 
		              <C> Name='�ҼӸ�'	   ID=DEPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=129	align=LEFT,		sort = true </C>
		              <C> Name='������'	   ID=FRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=CENTER	Mask='XXXX/XX/XX'</C>
				   	  <C> Name='������'	   ID=TODT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=CENTER	SHOW=FALSE</C>
		              <C> Name='�ٹ���'	   ID=DEPTPRT	HeadAlign=Center HeadBgColor=#B9D4DC Width=125	align=LEFT		EditStyle=Lookup   Data='gcds_dept1:MINORCD:MINORNM',  sort = true show=false</C>
					  <C> Name='����'	   ID=DEPTGB	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	align=CENTER	EditStyle=Lookup   Data='gcds_deptgb:MINORCD:MINORNM', sort = true </C>
		              <C> Name='���'	   ID=USEYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=CENTER	EditStyle=combo    Data='T:���,F:�̻��' , sort = true</C>
					  <C> Name='��¼�'	   ID=GROUPID	HeadAlign=Center HeadBgColor=#B9D4DC Width=114	align=LEFT	    EditStyle=Lookup   Data='gcds_GROUPID:MINORCD:MINORNM', sort = true show=false</C>
					  <C> Name='������'    ID=CHGYM     HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=CENTER	Mask='XXXX/XX' </C>
					  <C> Name='������'    ID=SITE      HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=LEFT	    EditStyle=Lookup   Data='gcds_site:MINORCD:MINORNM', sort = true show=falSe</C>
					  <C> Name='������'     ID=TREECD     HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=CENTER	sort = true</C>
					  <C> Name='����'      ID=DEPT_LEVEL HeadAlign=Center HeadBgColor=#B9D4DC Width=40	align=CENTER	</C>
		              "><!-- CheckBoxText='USEYN' -->
		            </OBJECT></comment><script>__ws__(__NSID__);</script>
		          </td>
         		  <TD align=left>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:227px;height:479px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
				                <td style="height:25px;Width:105px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >�Ҽ��ڵ�</td>
				                <td style="border:0 solid #708090;border-bottom-width:1px;">
									<comment id="__NSID__">
									  <object id=gcem_deptcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						                style="position:relative; left:5px;top:1px; width:40px;height:20px;" class=txtbox
						                validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="####">
										<param name=MaxLength     value=4>
										<param name=UpperFlag			value=1>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									  </object>
								   </comment><script>__ws__(__NSID__);</script>
								</td>
				              </tr>
				              <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >��&nbsp;��&nbsp;��</td>
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_deptnm"  class="txtbox" name="txt_deptnm" type="text" style= "width:137px;position:relative;left:5px;"  maxlength="50" onBlur="bytelength(this,this.value,50);">
								</td>
				              </tr>
				              <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >��&nbsp;&nbsp;&nbsp;&nbsp;Ī</td>
				                <td  Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_deptnmk"  class="txtbox" name="txt_deptnmk" type="text" style= "width:137px; height:20px;position:relative;left:5px;" maxlength="70" onBlur="bytelength(this,this.value,70);">
								</td>
				              </tr>
							  <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >��&nbsp;��&nbsp;��</td>
				                <td  Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_deptnme" class="txtbox" name="txt_deptnme" type="text" style= "width:137px; height:20px;position:relative;left:5px;" maxlength="50" onBlur="bytelength(this,this.value,50);">
								</td>
				              </tr>
							  <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >��������</td>
				                <td  Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_treecd"  class="txtbox" name="txt_treecd" type="text" style= "width:137px; height:20px;position:relative;left:5px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
								</td>
				              </tr>
				              <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" ><nobr>��&nbsp;��&nbsp;��</nobr></td>
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<comment id="__NSID__">
										<object id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
							                validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="YYYY/MM/DD">
											<param name=MaxLength     value=8>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>	
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
								</td>
				              </tr>
				              <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" ><nobr>��&nbsp;��&nbsp;��</nobr></td>
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>
									<comment id="__NSID__">
										<object id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							                style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
							                validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="YYYY/MM/DD">
											<param name=MaxLength     value=8>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object>
								   </comment><script>__ws__(__NSID__);</script>
							 	   <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
								</td>
				              </tr>
				              <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >��&nbsp;��&nbsp;��</td>
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>
									<comment id="__NSID__"><object id=gclx_deptprt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=138 style="position:relative;left:5px;" class="txtbox" >
										<param name=ComboDataID			value=gcds_dept1>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort				value="false">
										<param name=ListExprFormat	    value="MINORNM^0^140">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
				              </tr>
							  <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >�ٹ��� ����</td>
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<comment id="__NSID__"><object id=gclx_deptgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=138 style="position:relative;left:5px;" class="txtbox" >
										<param name=ComboDataID			value=gcds_deptgb>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort				value="false">
										<param name=ListExprFormat	    value="MINORNM^0^140">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
				              </tr>
				              <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox">�������</td>                        
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>
									<input id="txt_useyn" name="txt_useyn" type="checkbox"  style="width:15px;height:15px;position:relative;left:5px;" onClick="ln_Valchk(this, 'USEYN')">&nbsp;</nobr>
								</td>
				              </tr>
							<tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >���ױ���</td>                        
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>
									<input id="txt_useyn2" name="txt_useyn2" type="checkbox"  style="width:15px;height:15px;position:relative;left:5px;" onClick="ln_Valchk2(this, 'REDTAXYN')" maxlength="1" onBlur="bytelength(this,this.value,1);"><input type=text STYLE="BORDER:0px;position:relative;top:2.2px;left:6px" style="font-size:9pt;" value=" �鼼 �� ���� ���">&nbsp;</nobr>
								</td>
				            </tr>
							<tr>
								<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox">��¼�</td>                        
								<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<comment id="__NSID__"><object id=gclx_groupid classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=108 width=138 style="position:relative;left:5px;" class="txtbox" >
										<param name=ComboDataID			value=gcds_groupid>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort				value="false">
										<param name=ListExprFormat	    value="MINORNM^0^140">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              				</tr>
							<tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >������</td>
				                <td Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<comment id="__NSID__"><object id=gcem_chgym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   tabindex="1"
						                style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
						                validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true> 
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar6 OnClick="__GetCallMonth('gcem_chgym', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
								</td>
              				</tr>
							<tr>
								<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox">������</td>                        
								<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<comment id="__NSID__"><object id=gclx_site classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=108 width=138 style="position:relative;left:5px;" class="txtbox" >
										<param name=ComboDataID			value=gcds_site>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort				value="false">
										<param name=Enable				value="true">
										<param name=ListExprFormat	    value="MINORNM^0^140">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              				</tr>
              				<tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >����</td>
				                <td  Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_dept_level" class="txtbox" name="txt_dept_level" type="text" style= "width:137px; height:20px;position:relative;left:5px;" maxlength="50" onBlur="bytelength(this,this.value,1);">
								</td>
				            </tr>
				            <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >����</td>
				                <td  Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_fdcode" class="txtbox" name="txt_fdcode" type="text" style= "width:137px; height:20px;position:relative;left:5px;" maxlength="50" onBlur="bytelength(this,this.value,50);">
								</td>
				            </tr>
				            <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >����μ�</td>
				                <td  Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_bgtdept" class="txtbox" name="txt_bgtdept" type="text" style= "width:137px; height:20px;position:relative;left:5px;" maxlength="50" onBlur="bytelength(this,this.value,50);">
								</td>
				            </tr>
				            <tr>
				                <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER class="txtbox" >�����μ�</td>
				                <td  Style="height:25px;border:0 solid #708090;border-bottom-width:1px">
									<input id="txt_deptcd_m" class="txtbox" name="txt_deptcd_m" type="text" style= "width:137px; height:20px;position:relative;left:5px;" maxlength="50" onBlur="bytelength(this,this.value,50);">
								</td>
				            </tr>
						    <tr>
                				<td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;
                				</td>
              				</tr>
            			</table>
           			</TD>
       			 </tr>
      		</table>
    	</td>
  	</tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">��ȸ�Ǽ� : <label id="lbl_search1"></label></td>
	 </tr>
</table>
</div>

<div id="div_information" style="display:none">
	<table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr><td  align=center>
		
		<table width="847" cellpadding="1" cellspacing="0" border="0">
			<tr>
				<TD ROWSPAN=3 VALIGN=TOP>	
					<comment id="__NSID__"><object id="Tb_TreeView" classid="clsid:4401B994-DD33-11D2-B539-006097ADB678" width="150" height="100%" style="border:1 solid #708090; WIDTH: 150px; HEIGHT: 410px;font-size:9pt"> 
						<Param Name="DataID"			value="gcds_dept11">
						<Param Name="TextColumn"		value="DEPTNMK">
						<Param Name="LevelColumn"		value="DEPT_LEVEL">
						<Param Name="BorderStyle"		value="0">
						<param name="UseImage"			value="false">
						<param name="ExpandLevel"		value="1">
						<param name="ItemEnable"        value="Enable">
						<param name="SingleExpand"      value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</TD>
			    <td align=LEFT VALIGN=TOP>
	    			<table width="694" cellpadding="0" cellspacing="0" border="0" style='height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;'>
				      <tr> 
				        <td style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;�����ҼӸ�Ī&nbsp;</nobr></td>
				        <td style="height:30px;border:0 solid #708090;">
									<input type=text  class="txtbox" ID = txt_treenm   STYLE="BORDER:0px;" style="font-size:9pt;position:relative;top:1px;left:5px" maxlength="70" onBlur="bytelength(this,this.value,70);">&nbsp;</td>
				        <td width=100%>&nbsp;</td>
				        <td><nobr></nobr></td>
				      </tr>
				    </table>
    
					<table width="687" cellpadding="0" cellspacing="0" border="0"><tr><td HEIGHT=5></td></tr></table>

				    <table width="687" cellpadding="0" cellspacing="0" border="0" HEIGHT=0>
				      <tr> 
				        <td HEIGHT=0	VALIGN=BOTTOM class="txtbox" ><nobr>+ �����Ҽ��ڵ�����</nobr></td>
						<td HEIGHT=35 VALIGN=BOTTOM><nobr>&nbsp;<input type=text value="+ ��ü�Ҽ��ڵ�����" style="position:relative;left:245px;border=0;font-size:12"></nobr></td>
				        <td width=100%></td>
				        <td style="padding-top:3px;padding-right:5px;">&nbsp;</td>
						<td style="padding-top:3px;"><nobr>
						    <img src="../../Common/img/btn/com_b_level.gif" style="cursor:hand;position:relative;top:0px" onClick="ln_Level()"> 
						    <img src="../../Common/img/btn/com_b_save.gif"	style="cursor:hand;position:relative;top:0px" onClick="ln_Save2()"> 
							<img src="../../Common/img/btn/com_b_query.gif"	style="cursor:hand;position:relative;top:0px" onClick="ln_QueryAll()">
							<nobr>
						</td>
					  </tr>
				    </table>
			   </td>
			</tr>
  			<tr><td align=LEFT valign=top >
			  	   <table width="685" cellpadding="1" cellspacing="0" border="0">
			        <tr> 
			          <td style="width:331" align=center VALIGN=TOP >
			            <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_reresult   class="txtbox" style="WIDTH:331px;HEIGHT:335px;border:1 solid #777777;display:block;" viewastext>
			              <PARAM NAME="DataID"      VALUE="gcds_dept2">
			              <PARAM NAME="Editable"		VALUE="false">
			              <PARAM NAME="BorderStyle" VALUE="0">
						  <PARAM name="Fillarea"    VALUE="true">
			              <PARAM NAME="Format"      VALUE="  
							<C> Name='��������'		ID=TREECD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center	Edit=none</C>
			                <C> Name='�Ҽ��ڵ�'		ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center	Edit=none</C> 
			                <C> Name='�� �� ��'		ID=DEPTNM       HeadAlign=Center HeadBgColor=#B9D4DC Width=180	    align=left		Edit=none</C> 
			                ">
			            </OBJECT></comment><script>__ws__(__NSID__);</script>
			          </td>
					  <TD>
							<img src="../../Common/img/btn/com_btn_right.gif" style="cursor:hand" onclick="ln_Move('GORIGHT')"><br>
							<img src="../../Common/img/btn/com_btn_left.gif"	style="cursor:hand" onclick="ln_Move('GOLEFT') ">
					  </TD>
			          <td style="width:331" align=center VALIGN=TOP>
			            <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_reresult   class="txtbox" style="WIDTH:331px;HEIGHT:335px;border:1 solid #777777;display:block;" viewastext>
			              <PARAM NAME="DataID"        VALUE="gcds_dept3">
			              <PARAM NAME="Editable"	  VALUE="false">
			              <PARAM NAME="BorderStyle"	  VALUE="0">
						  <PARAM name="SortView"	  VALUE="left">
						  <PARAM name="Fillarea"      VALUE="true">
			              <PARAM NAME="Format"        VALUE="  
							<C> Name='��������'		ID=TREECD	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center	Edit=none</C>
			                <F> Name='�Ҽ��ڵ�'		ID=DEPTCD   HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center	Edit=none</F> 
			                <C> Name='�� �� ��'		ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=180	    align=left		Edit=none sort=true</C> 
			                ">
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
  <table border=0 cellpadding=0 cellspacing=0 width=875>
   <tr><td height=10></td></tr>
   <tr>
	   <td height="24">��ȸ�Ǽ� : <label id="lbl_search2"></label></td>
	</tr>
  </table>
</div>
</td>
</tr>
</table>

<!-----------------------------------------------------------------------------
											B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_dept classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_dept>
	<param name=BindInfo  value='
		<C>Col=DEPTCD		Ctrl=gcem_deptcd    Param=text			</C>
		<C>Col=DEPTNM		Ctrl=txt_deptnm	    Param=value			</C>
		<C>Col=DEPTNMK		Ctrl=txt_deptnmk    Param=value			</C>
		<C>Col=DEPTNME		Ctrl=txt_deptnme    Param=value			</C>
		<C>Col=TREECD		Ctrl=txt_treecd		Param=value			</C>
		<C>Col=FRDT			Ctrl=gcem_frdt		Param=text			</C>
		<C>Col=TODT			Ctrl=gcem_todt		Param=text			</C>
		<C>Col=DEPTPRT		Ctrl=gclx_deptprt	Param=BindColVal    </C>
		<C>Col=DEPTGB		Ctrl=gclx_deptgb    Param=BindColVal    </C>
		<C>Col=USEYN		Ctrl=txt_useyn		Param=value			</C>
		<C>Col=REDTAXYN		Ctrl=txt_useyn2		Param=value			</C>
        <C>Col=GROUPID		Ctrl=gclx_groupid	Param=BindColVal    </C>
		<C>Col=CHGYM		Ctrl=gcem_chgym   	Param=text			</C>
		<C>Col=SITE		    Ctrl=gclx_site      Param=BindColVal    </C>
		<C>Col=DEPT_LEVEL   Ctrl=txt_dept_level Param=value         </C>
		<C>Col=FDCODE       Ctrl=txt_fdcode     Param=value         </C>
		<C>Col=BGTDEPT      Ctrl=txt_bgtdept    Param=value         </C>
		<C>Col=DEPTCD_M     Ctrl=txt_deptcd_m   Param=value         </C>
  '>
</object></comment><script>__ws__(__NSID__);</script>

    <div class=page id="out_line" style="position:absolute; left:4; top:68; width:875; height:437;z-index:-1;">&nbsp;</div>
	<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
	<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�/�޿��������� > ��°���
+ ���α׷� ID	: P020007.html
+ �� �� �� ��	: ��ȸ|���
+ �� �� �� ��	: �ǿ���
+ �� �� �� �� : �޿�������Ȳ ����Ÿ�� �� ����. Servlet ��� ������. �����׸��߰���.
+ �� �� �� ��	: �̼��� - 2005.08.02 - �ҽ� ����
+ �� �� �� ��	: ������ - 2005.08.24 - �ҼӺ� �޿�������Ȳ ���� �߰�
+ �� �� �� ��	: ������ - 2005.09.07 - ��°��� 4�� �׸� ���� ���� (�޿�+�ұ�+����+�ޱ�, ��)
+ �� �� �� ��	: �̼��� - 2006.03.10 - �޿��Ҽ��Ѿ�(�˻����� �Ҽ�,���� �߰�),����Ʈ �ݿ�
---------------------------------------------------------------------------------
+ �� �� �� �� : ������Ȳ ���� ������ ��ȸ�� ���Ͽ� ������Ȳ ��¹��� �󼼳��� ������ ����
                ( h100009_s33 ==> h100009_s331�� ������ )
								PBPAY �� �÷� �߰� PRTSEQ, PRTCOD, PRTDEPTNM [��¼� ����]
+ �� �� �� �� : 2010.10.29 
+ ��   ��  �� : ��  ��  �� 
------------------------------------------------------------------------------
+ �� �� �� ��	: p020007_s1, p020007_s2, p020007_s3, p020007_s4,
								p020007_s5, p020007_s6, p020007_s7
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>��°���</title>
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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4) +"/"+ gcurdate.substr(5,2) +"/"+ gcurdate.substr(8,2);
var gs_date3 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var Hrow=0; var Hcol=0;
var THeader ="param1:String(10),param2:String(10),param3:String(10),param4:String(10),param5:String(10),"
            +"param6:String(10),param7:String(10),param8:String(10),param9:String(10),param10:String(10)";

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	
	gcem_app_yyyymm_3.Text = gs_date3;
	gcem_app_yyyymm_7.Text = gs_date3;


	gcem_yyyymm41.Text = gs_date3;
	gcem_yyyymm42.Text = gs_date3;

	gcem_yyyymm51.Text = gs_date3;
	gcem_yyyymm52.Text = gs_date3;

	gcem_yyyymm61.Text = gs_date3;
	gcem_yyyymm62.Text = gs_date3;

	gcds_pyo4.ClearAll();
	gcds_pyo4.DataID = "";
	gcds_pyo4.SetDataHeader(THeader);
	gcds_pyo4.addrow();
	gcds_pyo4.namevalue(1,"param1")="�Ѱ�";
	gcds_pyo4.namevalue(1,"param4")="�⺻�ް�";
	gcds_pyo4.namevalue(1,"param5")=0;
	gcds_pyo4.namevalue(1,"param6")="�ǰ������";
	gcds_pyo4.namevalue(1,"param7")=0;
	gcds_pyo4.namevalue(1,"param8")="�ҵ漼��";
	gcds_pyo4.namevalue(1,"param9")=0;
	gcds_pyo4.addrow();
	gcds_pyo4.namevalue(2,"param1")=0;
	gcds_pyo4.namevalue(2,"param2")="�����޾װ�";
	gcds_pyo4.namevalue(2,"param3")=0;
	gcds_pyo4.namevalue(2,"param4")="�󿩰�";
	gcds_pyo4.namevalue(2,"param5")=0;
	gcds_pyo4.namevalue(2,"param6")="���ο��ݰ�";
	gcds_pyo4.namevalue(2,"param7")=0;
	gcds_pyo4.namevalue(2,"param8")="�ֹμ���";
	gcds_pyo4.namevalue(2,"param9")=0;

	gcds_pyo4.addrow();
	gcds_pyo4.namevalue(3,"param4")="�ð��ܼ����";
	gcds_pyo4.namevalue(3,"param5")=0;
	gcds_pyo4.namevalue(3,"param6")="���뺸���";
	gcds_pyo4.namevalue(3,"param7")=0;
	gcds_pyo4.namevalue(3,"param8")="������";
	gcds_pyo4.namevalue(3,"param9")=0;
	gcds_pyo4.addrow();
	gcds_pyo4.RowPosition = 4;

	gcds_pyo5.ClearAll();
	gcds_pyo5.DataID = "";
	gcds_pyo5.SetDataHeader(THeader);
	gcds_pyo5.addrow();
	gcds_pyo5.namevalue(1,"param1")="�Ѱ�";
	gcds_pyo5.namevalue(1,"param4")="�⺻�ް�";
	gcds_pyo5.namevalue(1,"param5")=0;
	gcds_pyo5.namevalue(1,"param6")="�ǰ������";
	gcds_pyo5.namevalue(1,"param7")=0;
	gcds_pyo5.namevalue(1,"param8")="�ҵ漼��";
	gcds_pyo5.namevalue(1,"param9")=0;
	gcds_pyo5.addrow();
	gcds_pyo5.namevalue(2,"param1")=0;
	gcds_pyo5.namevalue(2,"param2")="�����޾װ�";
	gcds_pyo5.namevalue(2,"param3")=0;
	gcds_pyo5.namevalue(2,"param4")="��å�����";
	gcds_pyo5.namevalue(2,"param5")=0;
	gcds_pyo5.namevalue(2,"param6")="���ο��ݰ�";
	gcds_pyo5.namevalue(2,"param7")=0;
	gcds_pyo5.namevalue(2,"param8")="�ֹμ���";
	gcds_pyo5.namevalue(2,"param9")=0;

	gcds_pyo5.addrow();
	gcds_pyo5.namevalue(3,"param4")="�ð��ܼ����";
	gcds_pyo5.namevalue(3,"param5")=0;
	gcds_pyo5.namevalue(3,"param6")="���뺸���";
	gcds_pyo5.namevalue(3,"param7")=0;
	gcds_pyo5.namevalue(3,"param8")="������";
	gcds_pyo5.namevalue(3,"param9")=0;
	gcds_pyo5.addrow();
	gcds_pyo5.RowPosition = 4;

	gcds_pyo6.ClearAll();
	gcds_pyo6.DataID = "";
	gcds_pyo6.SetDataHeader(THeader);
	gcds_pyo6.addrow();
	gcds_pyo6.namevalue(1,"param1")="�Ѱ�";
	gcds_pyo6.namevalue(1,"param4")="�⺻�ް�";
	gcds_pyo6.namevalue(1,"param5")=0;
	gcds_pyo6.namevalue(1,"param6")="�ǰ������";
	gcds_pyo6.namevalue(1,"param7")=0;
	gcds_pyo6.namevalue(1,"param8")="�ҵ漼��";
	gcds_pyo6.namevalue(1,"param9")=0;
	gcds_pyo6.addrow();
	gcds_pyo6.namevalue(2,"param1")=0;
	gcds_pyo6.namevalue(2,"param2")="�����޾װ�";
	gcds_pyo6.namevalue(2,"param3")=0;
	gcds_pyo6.namevalue(2,"param4")="��å�����";
	gcds_pyo6.namevalue(2,"param5")=0;
	gcds_pyo6.namevalue(2,"param6")="���ο��ݰ�";
	gcds_pyo6.namevalue(2,"param7")=0;
	gcds_pyo6.namevalue(2,"param8")="�ֹμ���";
	gcds_pyo6.namevalue(2,"param9")=0;

	gcds_pyo6.addrow();
	gcds_pyo6.namevalue(3,"param4")="�ð��ܼ����";
	gcds_pyo6.namevalue(3,"param5")=0;
	gcds_pyo6.namevalue(3,"param6")="���뺸���";
	gcds_pyo6.namevalue(3,"param7")=0;
	gcds_pyo6.namevalue(3,"param8")="������";
	gcds_pyo6.namevalue(3,"param9")=0;
	gcds_pyo6.addrow();
	gcds_pyo6.RowPosition = 4;

	//���ޱ���
	gcds_select_ec01az.DataID = "/servlet/Contract.hclcode_s1?v_str1=1120"; 
	gcds_select_ec01az.Reset();

	//�Ҽ�����
  gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept.Reset();

	//��������
	gcds_select_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000"; 
	gcds_select_ec03az.Reset();

	//��������
	gcds_select_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002"; 
	gcds_select_ec04az.Reset();

	//�޿��׸�
	gcds_select_ec06az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_select_ec06az.Reset();

	//��������
	gcds_select_ec05az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	gcds_select_ec05az.Reset();

	var str1 = "";//fn_trim(gcem_jigubil_3.Text);      //��������
	var str2 = fn_trim(gcem_app_yyyymm_3.Text);        //penwidth=5���
  yyyymmPlusMinus(str2,str1,gs_date3);
	gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name') = str2_1.substr(0,4)+"�� " + str2_1.substr(4,2)+"��";
	gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name') = str2_2.substr(0,4)+"�� " + str2_2.substr(4,2)+"��";

	nwgubun.value="4_1";
	ln_visible_hidden("4_1");

}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){

	eval("ln_Query_"+nwgubun.value+"();");

}

/******************************************************************************
	Description : �ҼӺ� �޿�������Ȳ Excel ����
******************************************************************************/
function ln_Excel_Query(){
	var str1 = fn_trim(gcem_yyyymm51.Text);								//���޳��
	var str2 = fn_trim(gcem_yyyymm52.Text);								//���޳��
	var str3 = fn_trim(gclx_select_jigub5.BindColVal);		//���ޱ���						

	gcds_excel_5_1.DataID = "/servlet/Contract.h100009_s10?v_str1="+str1+"&v_str2="+str3; 
	//prompt("",gcds_excel_5_1.DataID);
	gcds_excel_5_1.Reset();
	gcgd_excel_5_1.RunExcelEx('�ҼӺ��޿�������Ȳ', 1, 0);
}

/******************************************************************************
	Description : �޿��ҵ��Ѿ� Excel 
******************************************************************************/
function ln_Excel_Query2(){
	var str1 = fn_trim(gcem_yyyymm61.Text);									//���޳�� fr
	var str2 = fn_trim(gcem_yyyymm62.Text);									//���޳�� to
	var str3 = fn_trim(gclx_select_jigub6.BindColVal);      //���ޱ���
	var str4 = fn_trim(gclx_select_div6.BindColVal);				//��������
	var str5 = str1.substring(0,4);
  str5+="�ҵ��Ѿ�";
	var str6 = fn_trim(gclx_select_position7.BindColVal);		//����

	gcds_excel_6_1.DataID = "/servlet/Contract.h100009_s9?"
									 + "v_str1="  + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + gs_level
									 + "&v_str6=" + gs_treecd
									 + "&v_str7=" + str6;
	//prompt("",gcds_excel_6_1.DataID);
	gcds_excel_6_1.Reset(); //�׸���
	gcds_excel_6_1.rowposition=1;
	gcgd_excel_6_1.RunExcelEx(str5, 1, 0);
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvyyyy(yyyy,mm) {

	if(parseInt(mm)==1)	{
    returnPrv=(parseInt(yyyy)-1)+"";
	}
	else returnPrv=yyyy;

	return returnPrv;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvmm(prv) {

	if(Number(prv)==1) returnPrv="12";
	else
	{
		returnPrv=(Number(prv)-1)+"";
	}
	
	if(returnPrv.length ==1)
			returnPrv="0" + returnPrv ;

	return returnPrv;

}

/******************************************************************************
	Description : �󿩿��� ����
******************************************************************************/
function ln_prvmm2(prv) {

	if(Number(prv)==1) {
		returnPrv="12";
	} else if(Number(prv)==12){
		returnPrv="11";
	} else{
		returnPrv=(Number(prv)-2)+"";
	}

	if(returnPrv.length ==1)
			returnPrv="0" + returnPrv ;

	return returnPrv;
}

/******************************************************************************
	Description : 
	Param       : str2 - ���޳�� fr
	              str1 - ���޳�� to
								gs_date2 - ������
******************************************************************************/
function yyyymmPlusMinus(str2,str1,gs_date2) {
	if( str2.length ==6) {
		str2_1=ln_prvyyyy(str2.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str2.substr(4,2));
		str2_2=str2.substr(0,4) +""+ str2.substr(4,2);
	} else if ( str1.length ==8) {
		str2_1=ln_prvyyyy(str1.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str1.substr(4,2));
		str2_2=str1.substr(0,4) +""+ str1.substr(4,2);
	} else {
		str2_1=ln_prvyyyy(gs_date2.substr(0,4),gs_date2.substr(4,2)) +""+ ln_prvmm(gs_date2.substr(4,2));
		str2_2=gs_date2.substr(0,4) +""+ gs_date2.substr(4,2);
  }
}

/******************************************************************************
	Description : ���϶��� ��� (�����޿� 1, 3, 5, 7, 9, 11, 12��)
	Param       : str2 - ���޳�� fr
	              str1 - ���޳�� to
								gs_date2 - ������
******************************************************************************/
function yyyymmPlusMinus2(str2,str1,gs_date2) {
	
		str2_1=ln_prvyyyy(str2.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm2(str2.substr(4,2));
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Query_3_1(){ //�޿��������� �� ��ȸ
	var str1 = "";// fn_trim(gcem_jigubil_3.Text);        //��������
	var str2 = fn_trim(gcem_app_yyyymm_3.Text);        //penwidth=5���
	var str3 = fn_trim(gclx_select_ec01az_3.BindColVal);  //���ޱ���
	var str4 = fn_trim(gclx_select_div3.BindColVal);  //�Ҽ�
	var str5 = fn_trim(gclx_select_ec03az_3.BindColVal);  //����

	if(str2.length != 6) {
	alert("�������� �Է����ּ���");
		gcem_app_yyyymm_3.Focus();
	}	else	{
   
		 yyyymmPlusMinus(str2,str1,gs_date3);
	 gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name') = str2_1.substr(0,4)+"�� " + str2_1.substr(4,2)+"��";
	 gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name') = str2_2.substr(0,4)+"�� " + str2_2.substr(4,2)+"��";
   
	 gcds_grid_ec03az.DataID = "/servlet/Contract.h100009_s8?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2_1
									 + "&v_str3=" + str2_2
									 + "&v_str4=" + str3
									 + "&v_str5=" + str4
									 + "&v_str6=" + str5;

//prompt("",gcds_grid_ec03az.DataID);	
	gcds_grid_ec03az.Reset(); //�׸���
	gcds_grid_ec03az.rowposition=1;
	}
}

/******************************************************************************
	Description : �޿�������Ȳ ��ȸ
******************************************************************************/
function ln_Query_4_1(){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);									//���޳��
	var str2 = fn_trim(gcem_yyyymm42.Text);									//���޳��
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);      //���ޱ���
	var str4 = fn_trim(gclx_select_div4.BindColVal);				//�Ҽ�
	var str5 = fn_trim(gclx_select_group4.BindColVal);			//����
	var str6 = fn_trim(gclx_select_position4.BindColVal);		//����
	var str7 = fn_trim(gclx_select_grade4.BindColVal);			//����

  if(str3=='T'){

	gcds_grid_ec04az.DataID = "/servlet/Contract.h100009_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + gs_level
									 + "&v_str9=" + gs_treecd;
//	prompt("",gcds_grid_ec04az.DataID);	
	gcds_grid_ec04az.Reset(); //�׸���
	gcds_grid_ec04az.rowposition=1;

	}else{
		
			gcds_grid_ec04az.DataID = "/servlet/Contract.h100009_s1?"				
			             + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + gs_level
									 + "&v_str9=" + gs_treecd;
	//prompt("",gcds_grid_ec04az.DataID);	
	gcds_grid_ec04az.Reset(); //�׸���
	gcds_grid_ec04az.rowposition=1;

	}

}

/******************************************************************************
	Description : �ҼӺ��޿�������Ȳ ��ȸ
******************************************************************************/
function ln_Query_5_1(){																
	var str1 = fn_trim(gcem_yyyymm51.Text);								//���޳��
	var str2 = fn_trim(gcem_yyyymm52.Text);								//���޳��
	var str3 = fn_trim(gclx_select_jigub5.BindColVal);		//���ޱ���
	var str4 = fn_trim(gclx_select_div5.BindColVal);			//�Ҽ�
	var str5 = fn_trim(gclx_select_group5.BindColVal);		//����
	var str6 = fn_trim(gclx_select_position5.BindColVal); //����
	var str7 = fn_trim(gclx_select_grade5.BindColVal);		//����

	gcds_grid_ec05az.DataID = "/servlet/Contract.h100009_s4?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
	//prompt("",gcds_grid_ec05az.DataID);	
	gcds_grid_ec05az.Reset(); //�׸���
	gcds_grid_ec05az.rowposition=1;
}

/******************************************************************************
	Description : �޿� �ҵ��Ѿ� ��ȸ
******************************************************************************/
function ln_Query_6_1(){ 

	var str1 = fn_trim(gcem_yyyymm61.Text);									//���޳�� fr
	var str2 = fn_trim(gcem_yyyymm62.Text);									//���޳�� to
	var str3 = fn_trim(gclx_select_jigub6.BindColVal);      //���ޱ���
	var str4 = fn_trim(gclx_select_div6.BindColVal);				//��������
	var str5 = fn_trim(gclx_select_position7.BindColVal);		//����

	gcds_grid_ec06az.DataID = "/servlet/Contract.h100009_s9?"
									 + "v_str1="  + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4 
									 + "&v_str5=" + gs_level 
									 + "&v_str6=" + gs_treecd 
									 + "&v_str7=" + str5;
	//prompt("",gcds_grid_ec06az.DataID);		
	gcds_grid_ec06az.Reset(); //�׸���
	gcds_grid_ec06az.rowposition=1;

}

/******************************************************************************
	Description : ��� �޿� ������
******************************************************************************/
function ln_Query_7_1(){ 

	var str1 = "";									
	var str2 = fn_trim(gcem_app_yyyymm_7.Text);				 //���޳�� 
	var str3 = fn_trim(gclx_select_7.BindColVal);      //���ޱ���
	var str4="";

  yyyymmPlusMinus(str2,str1,gs_date3);
	gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name') = str2_1.substr(0,4)+"�� " + str2_1.substr(4,2)+"��";
	gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name') = str2_2.substr(0,4)+"�� " + str2_2.substr(4,2)+"��";

	if(gclx_select_7.bindcolval=="T"){
		if (gclx_ord_7.bindcolval=="A"){
			str4="";
		}else if(gclx_ord_7.bindcolval=="A1"){ //�Ի�
			str4="'A1','A2','A3','A4','A9','C4','C8','F1','F2'";
		}else if(gclx_ord_7.bindcolval=="A2"){ //���
			str4="'C5'";
		}else if(gclx_ord_7.bindcolval=="A3"){ //����
			str4="'C1'";
		}else if(gclx_ord_7.bindcolval=="A4"){ //����
			str4="'C3','C9'";
		}else if(gclx_ord_7.bindcolval=="A5"){ //��Ÿ
      str4="Z";
    }

		gcds_change_7.DataID = "/servlet/Contract.h100009_s17?"
										 + "v_str1="  + str2
										 + "&v_str2=" + str3
										 + "&v_str3=" + str2_1
										 + "&v_str4=" + str4;
										 
		gcds_change_7.Reset(); //�׸���
		gcds_change_7.rowposition=1;
	}else{ 
		gcds_change_7.DataID = "/servlet/Contract.h100009_s18?"
										 + "v_str1="  + str2
										 + "&v_str2=" + str3
										 + "&v_str3=" + str2_1
										 + "&v_str4=" + str4;
										 
		gcds_change_7.Reset(); //�׸���
		gcds_change_7.rowposition=1;

	}
}

/******************************************************************************
	Description : �޿�������Ȳ ���ο�������(Fheader �κ�)
******************************************************************************/
function ln_Report_4_1(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);								//���޳��
	var str2 = fn_trim(gcem_yyyymm42.Text);								//���޳��
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);		//���ޱ���
	var str4 = fn_trim(gclx_select_div4.BindColVal);			//�Ҽ�
	var str5 = fn_trim(gclx_select_group4.BindColVal);    //����
	var str6 = fn_trim(gclx_select_position4.BindColVal); //����
	var str7 = fn_trim(gclx_select_grade4.BindColVal);    //����

  if(fn_trim(gclx_select_jigub4.bindcolval)==5){ 	//���϶��� �޸� �Ѵ�.
		yyyymmPlusMinus2(str2,str2,gs_date3);
	}else {
		yyyymmPlusMinus(str2,str2,gs_date3);
  }

	gcds_report0.ClearAll();

	if (str3 == e) {
		gcds_report0.DataID = "/servlet/Contract.h100009_s2"+n+"?"
										 + "v_str1="	+ str2_1
										 + "&v_str2=" + str2
										 + "&v_str3=" + str3
										 + "&v_str4=" + str4
										 + "&v_str5=" + str5
										 + "&v_str6=" + str6
										 + "&v_str7=" + str7
										 + "&v_str8=" + gs_date;
	//	prompt("",gcds_report0.DataID);
		gcds_report0.Reset();
	}
}

/******************************************************************************
	Description : �޿�������Ȳ �󼼺����� (Detail �κ�)
******************************************************************************/
function ln_Report_4_2(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);								//���޳��
	var str2 = fn_trim(gcem_yyyymm42.Text);								//���޳��
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);    //���ޱ���
	var str4 = fn_trim(gclx_select_div4.BindColVal);			//�Ҽ�
	var str5 = fn_trim(gclx_select_group4.BindColVal);    //����
	var str6 = fn_trim(gclx_select_position4.BindColVal); //����
	var str7 = fn_trim(gclx_select_grade4.BindColVal);    //����
  
	gcds_report1.ClearAll();

	if (str3 == e) {

 		//gcds_report1.DataID = "/servlet/Contract.h100009_s3"+n+"?"
		//gcds_report1.DataID = "/servlet/Contract.h100009_s33"+n+"?"
		gcds_report1.DataID = "/servlet/Contract.h100009_s331"+n+"?"
										 + "v_str1="	+ str2_1
										 + "&v_str2=" + str2
										 + "&v_str3=" + str3
										 + "&v_str4=" + str4
										 + "&v_str5=" + str5
										 + "&v_str6=" + str6
										 + "&v_str7=" + str7;
// prompt("",gcds_report1.DataID);
		gcds_report1.Reset(); 
		gcds_report1.rowposition=1;
	}
}

/******************************************************************************
	Description : �޿�������Ȳ ����ٹ��ں�����(Header �κ�)
******************************************************************************/
function ln_Report_4_3(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);										//���޳��
	var str2 = fn_trim(gcem_yyyymm42.Text);										//���޳��
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);        //���ޱ���
	var str4 = fn_trim(gclx_select_div4.BindColVal);					//�Ҽ�
	var str5 = fn_trim(gclx_select_group4.BindColVal);				//����
	var str6 = fn_trim(gclx_select_position4.BindColVal);			//����
	var str7 = fn_trim(gclx_select_grade4.BindColVal);				//����
  
	gcds_report2.ClearAll();

	if (str3 == e) {
	gcds_report2.DataID = "/servlet/Contract.h100009_s7"+n+"?"
									 + "v_str1="	+ str2_1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7;
/<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020007_s7?v_str1=200603&v_str2=200604&v_str3=T&v_str4=&v_str5=&v_str6=&v_str7=

	//prompt("",gcds_report2.DataID);	
	gcds_report2.Reset(); 
	gcds_report2.rowposition=1;
	
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Report_5_1(){ //�ҼӺ��޿�������Ȳ ���ο�������(Fheader �κ�)
	var str2 = fn_trim(gcem_yyyymm52.Text);        //���޳��
	
       gcds_report0.ClearAll();

		var ls_temp = "CYYYY:STRING,"
		            + "CMM:STRING,"
		            + "TODATEE:STRING";
		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();
		gcds_report0.namevalue(1,"CYYYY")=str2.substring(0,4);
		gcds_report0.namevalue(1,"CMM")=str2.substring(4,6);
		gcds_report0.namevalue(1,"TODATEE")=gs_date;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Report_5_2(){ //�ҼӺ��޿�������Ȳ �󼼺�����
	var str1 = fn_trim(gcem_yyyymm51.Text);        //���޳��
	var str2 = fn_trim(gcem_yyyymm52.Text);        //���޳��
	var str3 = fn_trim(gclx_select_jigub5.BindColVal);        //���ޱ���
	var str4 = fn_trim(gclx_select_div5.BindColVal);  //�Ҽ�
	var str5 = fn_trim(gclx_select_group5.BindColVal);     //����
	var str6 = fn_trim(gclx_select_position5.BindColVal);  //����
	var str7 = fn_trim(gclx_select_grade5.BindColVal);     //����

	
	gcds_report2.ClearAll();

	gcds_report2.DataID = "/servlet/Contract.h100009_s5?"
									 + "v_str1=" + str2_1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7;
	//prompt("", gcds_report2.DataID);
	gcds_report2.Reset(); //�׸���
	gcds_report2.rowposition=1;
	/*
    if (gcds_report2.countrow >0)
	   return true;
	  else{
		alert("���޳�� 2��° �Է¶��� ��±��س�����μ�\n "+str2.substr(0,4)+"�� "+str2.substr(4,2)+"���� �ҼӺ� �޿�������Ȳ����Ÿ�� �����ϴ�.");
		return false;
	}
	*/
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Report_3_1(){ //�޿��������� ���ο�������
	var str2 = fn_trim(gcem_app_yyyymm_3.Text);        //���޳��
       gcds_report0.ClearAll();

		var ls_temp = 
					"CTITLE:STRING,"
		      //+ "CMM:STRING,"
		            + "TODATEE:STRING,"
		            + "PRVYYYYMM:STRING,"   /*�������*/
		            + "NOWYYYYMM:STRING,"   /*������*/
					+	"PRVNUM:Decimal,"	/* ������ ���ο� */
					+	"PRVAMT:Decimal,"   /* ������ ��ü �� �Ǳ޿�*/
					+	"NEXNUM:Decimal,"	/* ����� ���ο�*/
					+	"NEXAMT:Decimal,"	/* ����� ��ü �� �Ǳ޿� */
					+   "IBSANUM:Decimal,"	/* ����penwidth=5��� �Ի��ο�*/	
					+   "IBSAAMT:Decimal,"	/* ����penwidth=5��� �Ի� �� �Ǳ޿�*/
					+	"TAENUM:Decimal,"	/* ����penwidth=5��� �����ο� */
					+	"TAEAMT:Decimal,"   /* ���������� ���� �� �Ǳ޿�*/
					+   "SUNGNUM:Decimal,"	/* ���������� �����ο�*/
					+   "SUNGAMT:Decimal,"	/* ���������� ������ �� �Ǳ޿�*/
					+	"ITSNUM:Decimal,"	/* ���������� ��,��,������ �� �Ǳ޿�*/
					+	"ITSAMT:Decimal,"	/* ���������� ��,��,������ �� �Ǳ޿�*/	
					+	"A1_AMT:Decimal,"	/* --�⺻�� ���� �ݾ�  */
					+	"A2_AMT:Decimal,"	/* --��å���� ���� �ݾ� */
					+	"A3_AMT:Decimal,"   /* --�ð��� ���� �ݾ�  */
					+	"A4_AMT:Decimal,"	/* --�ټӼ��� ���� �ݾ� */
					+	"A5_AMT:Decimal,"	/* --�ڱ��ߺ� ���� �ݾ� */
					+	"A6_AMT:Decimal,"	/* --�����ξ�� ���� �ݾ� */	
					+	"A7_AMT:Decimal,"	/* --���������� ���� �ݾ� */
					+	"A8_AMT:Decimal,"	/* --�ڰݼ��� ���� �ݾ�  */
					+	"A9_AMT:Decimal,"   /* --���ο��� ���� �ݾ�  */
					+   "A10_AMT:Decimal,"	/* ���ϰ��� ���� �ݾ�       */
					+   "A11_AMT:Decimal,"	/* Ư���� ���� ���� �ݾ�         */
					+   "A12_AMT:Decimal,"	/* �����ٹ����� ���� �ݾ�       */	
					+   "A13_AMT:Decimal,"	/* ���ϱٹ����� ���� �ݾ� -�����ʿ�*/
					+   "A14_AMT:Decimal,"	/* �����ұ� ���� �ݾ�            */
					+   "A15_AMT:Decimal,"	/* �ӿ���å ���� �ݾ�         */	
					+   "A16_AMT:Decimal,"	/* ���ڱ� ���� �ݾ�          */	
					+   "AA_AMT:Decimal";	    /* ���� ���� ���� �ݾ�*/						

		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();

    //alert(gcds_report0.namevalue(1,"CTITLE"));
		gcds_report0.namevalue(1,"CTITLE")= "�޿�������Ȳ ["+str2.substring(0,4) +"�� "+ str2.substring(4,6)+"��]";

		//gcds_report0.namevalue(1,"CYYYY")=str2.substring(0,4);
		//gcds_report0.namevalue(1,"CMM")=str2.substring(4,6);
		gcds_report0.namevalue(1,"TODATEE")=gs_date;
		gcds_report0.namevalue(1,"PRVYYYYMM")=gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name');
	  gcds_report0.namevalue(1,"NOWYYYYMM")=gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name');

		gcds_report0.namevalue(1,"PRVNUM")=gcds_grid_ec03az.Sum(5,0,0);		/* ������ ���ο� */
		gcds_report0.namevalue(1,"PRVAMT")=gcds_grid_ec03az.Sum(6,0,0);   /* ������ ��ü �� �Ǳ޿�*/
		gcds_report0.namevalue(1,"NEXNUM")=gcds_grid_ec03az.Sum(7,0,0);		/* ����� ���ο�*/
		gcds_report0.namevalue(1,"NEXAMT")=gcds_grid_ec03az.Sum(8,0,0);		/* ����� ��ü �� �Ǳ޿� */
		gcds_report0.namevalue(1,"IBSANUM")=gcds_grid_ec03az.Sum(9,0,0);	/* ���������� �Ի��ο�*/	
		gcds_report0.namevalue(1,"IBSAAMT")=gcds_grid_ec03az.Sum(10,0,0);	/* ���������� �Ի� �� �Ǳ޿�*/
		gcds_report0.namevalue(1,"TAENUM")=gcds_grid_ec03az.Sum(11,0,0);	/* ���������� �����ο� */
		gcds_report0.namevalue(1,"TAEAMT")=gcds_grid_ec03az.Sum(12,0,0);  /* ���������� ���� �� �Ǳ޿�*/
		gcds_report0.namevalue(1,"SUNGNUM")=gcds_grid_ec03az.Sum(13,0,0);	/* ���������� �����ο�*/
		gcds_report0.namevalue(1,"SUNGAMT")=gcds_grid_ec03az.Sum(14,0,0);	/* ���������� ������ �� �Ǳ޿�*/
		gcds_report0.namevalue(1,"ITSNUM")=gcds_grid_ec03az.Sum(15,0,0);	/* ���������� ��,��,������ �� �Ǳ޿�*/
		gcds_report0.namevalue(1,"ITSAMT")=gcds_grid_ec03az.Sum(16,0,0);	/* ���������� ��,��,������ �� �Ǳ޿�*/	
		gcds_report0.namevalue(1,"A1_AMT")=gcds_grid_ec03az.Sum(17,0,0);	/* --�⺻�� ���� �ݾ�  */
		gcds_report0.namevalue(1,"A2_AMT")=gcds_grid_ec03az.Sum(18,0,0);	/* --��å���� ���� �ݾ� */
		gcds_report0.namevalue(1,"A3_AMT")=gcds_grid_ec03az.Sum(19,0,0);  /* --�ð��� ���� �ݾ�  */
		gcds_report0.namevalue(1,"A4_AMT")=gcds_grid_ec03az.Sum(20,0,0);	/* --�ټӼ��� ���� �ݾ� */
		gcds_report0.namevalue(1,"A5_AMT")=gcds_grid_ec03az.Sum(21,0,0);	/* --�ڱ��ߺ� ���� �ݾ� */
		gcds_report0.namevalue(1,"A6_AMT")=gcds_grid_ec03az.Sum(22,0,0);	/* --�����ξ�� ���� �ݾ� */	
		gcds_report0.namevalue(1,"A7_AMT")=gcds_grid_ec03az.Sum(23,0,0);	/* --���������� ���� �ݾ� */
		gcds_report0.namevalue(1,"A8_AMT")=gcds_grid_ec03az.Sum(24,0,0);	/* --�ڰݼ��� ���� �ݾ�  */
		gcds_report0.namevalue(1,"A9_AMT")=gcds_grid_ec03az.Sum(25,0,0);  /* --���ο��� ���� �ݾ�  */
		gcds_report0.namevalue(1,"A10_AMT")=gcds_grid_ec03az.Sum(26,0,0);	/* ���ϰ��� ���� �ݾ� */
		gcds_report0.namevalue(1,"A11_AMT")=gcds_grid_ec03az.Sum(27,0,0);	/* Ư���� ���� ���� �ݾ� */
		gcds_report0.namevalue(1,"A12_AMT")=gcds_grid_ec03az.Sum(28,0,0);	/* �����ٹ����� ���� �ݾ� */	
		gcds_report0.namevalue(1,"A13_AMT")=gcds_grid_ec03az.Sum(29,0,0);	/* ���ϱٹ����� ���� �ݾ� -�����ʿ�*/
		gcds_report0.namevalue(1,"A14_AMT")=gcds_grid_ec03az.Sum(30,0,0);	/* �����ұ� ���� �ݾ� */
		gcds_report0.namevalue(1,"A15_AMT")=gcds_grid_ec03az.Sum(31,0,0);	/* �ӿ���å ���� �ݾ� */	
		gcds_report0.namevalue(1,"A16_AMT")=gcds_grid_ec03az.Sum(32,0,0);	/* ���ڱ� ���� �ݾ� */	
		gcds_report0.namevalue(1,"AA_AMT")=gcds_grid_ec03az.Sum(41,0,0); 	/* ���� ���� ���� �ݾ�*/				
		
}

/******************************************************************************
	Description : ����޿� ������
******************************************************************************/
function ln_Report_7_1(){ //�޿��������� ���ο�������
	  var str2 = fn_trim(gcem_app_yyyymm_7.Text);        //���޳��
		var str3 ="";
    gcds_report0.ClearAll();
		var ls_temp = "CTITLE:STRING,PRINTDT:STRING,GUBUN:STRING";
		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();
		if (gclx_select_7.bindcolval=="1"){
       str3 = "�޿� ������";  		
		}else if (gclx_select_7.bindcolval=="2"){
       str3 = "�޿� �ұ޳���";
		}else{
       str3 = gclx_select_7.text;
		}

		gcds_report0.namevalue(1,"CTITLE")= " ["+ str2.substring(4,6)+"��] "+str3 ;
		gcds_report0.namevalue(1,"PRINTDT")=gs_date;
		gcds_report0.namevalue(1,"GUBUN")= "���� : " +gclx_ord_7.text;

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){
//alert(nwgubun.value);
//	if (nwgubun.value=='4_1' && fn_trim(gclx_select_jigub4.BindColVal) == '1') {	//�޿� ������Ȳ[����]
	if (nwgubun.value=='4_1' && fn_trim(gclx_select_jigub4.BindColVal) == 'T') {	//�޿� ������Ȳ[����]
	//alert("111111");
		if (gcds_grid_ec04az.countrow<1) {
			alert("����Ͻ� ������ �����ϴ�");
		} else {
			var str1=fn_trim(gcem_yyyymm42.Text);
			if (str1.length != 6) {
				alert("���޳�� 2��° �Է¶��� ���س���Դϴ�.\n�Է����ּ���");
			}else{
				var v_pay01 = "T";
				var v_pay02 = "";
				ln_Report_4_1(v_pay01,v_pay02);	
				//ln_Report_4_3(v_pay01,v_pay02);
				ln_Report_4_2(v_pay01,v_pay02);
				gcrp_print.preview();
			}
		}
	} else if (nwgubun.value=='4_1' && fn_trim(gclx_select_jigub4.BindColVal) == 'K') {	//�޿� ������Ȳ[��]
		//alert("22222");
		if (gcds_grid_ec04az.countrow<1) {
			alert("����Ͻ� ������ �����ϴ�");
		} else {
			var str1=fn_trim(gcem_yyyymm42.Text);
			if (str1.length != 6) {
				alert("���޳�� 2��° �Է¶��� ���س���Դϴ�.\n�Է����ּ���");
			}else{
				var v_pay01 = "K";
				ln_Report_4_1(v_pay01,"");
				//ln_Report_4_3(v_pay01,"7");
				ln_Report_4_2(v_pay01,"");
				//gcrp_print_2.preview();
        gcrp_print.preview();
			}
		}
  }	else if (nwgubun.value=='5_1') {			
		if (gcds_grid_ec05az.countrow<1) {
			alert("����Ͻ� ������ �����ϴ�");
		} else {
			var str1=fn_trim(gcem_yyyymm52.Text);
			if (str1.length != 6) {
				alert("���޳�� 2��° �Է¶��� ���س���Դϴ�.\n�Է����ּ���");
			}else{
			//alert(gcds_grid_ec05az.countrow);
				ln_Report_5_1();
        ln_Report_5_2();
				//if(ln_Report_5_2())
					gcrp_print2.preview();
					
				}
		}
  }	else if (nwgubun.value=='3_1') {
		//	alert("44444");
		if (gcds_grid_ec03az.countrow<1) {
			alert("����Ͻ� ������ �����ϴ�");
		} else {
			var str1=fn_trim(gcem_app_yyyymm_3.Text);
			if (str1.length != 6) {
				alert("�������� �Է����ּ���");
			}else{
				ln_Report_3_1();
				//ln_Report_5_2();
				gcrp_print3.preview();
			}
		}
	}	else if (nwgubun.value=='6_1') {
		//	alert("5555");
		if (gcds_grid_ec06az.countrow<1) {
		alert("����Ͻ� ������ �����ϴ�");
		} else {
			var str1=fn_trim(gcem_yyyymm62.Text);	//text box name �ٲ����
			if (str1.length != 6) {
				alert("���޳�� 2��° �Է¶��� ���س���Դϴ�.\n�Է����ּ���");
			}else{
			//	ln_Report_6_1();		����Ʈ�ۼ�
			//	if(ln_Report_6_2())
				//	gcrp_print6.preview();
			}
		}
	} else if (nwgubun.value=='7_1') { //����޿� ������
		if (gcds_change_7.countrow<1) {
		alert("����Ͻ� ������ �����ϴ�");
		} else {
			var str1=fn_trim(gcem_app_yyyymm_7.Text);	//text box name �ٲ����
			if (str1.length != 6) {
				alert("���޳�� 2��° �Է¶��� ���س���Դϴ�.\n�Է����ּ���");
			}else{
				ln_Report_7_1();	
				gcrp_print7.preview();
			}
		}
	}
}

/*******************************************************************************
  Description : ���� - �޿�������Ȳ
******************************************************************************/
function ln_Excel(){
  if(nwgubun.value=="4_1"){
		if (gcds_grid_ec04az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_create4_1.RunExcel('�޿�������Ȳ');
	}else if(nwgubun.value=="5_1"){
	   ln_Excel_Query();
	}else if(nwgubun.value=="3_1"){
		if (gcds_grid_ec03az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_create3_1.RunExcel('�޿���������');
	}else if(nwgubun.value=="6_1"){
		ln_Excel_Query2();
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(Obj){
	
	var lib_com= new Array("gcgd_create1_1","gcgd_create2_1","gcgd_create3_1","gcgd_create4_1","gcgd_create5_1","gcgd_create6_1","gcgd_create7_1");
	var lib_total= new Array("gcgd_create1_1","gcgd_create2_2","gcgd_create3_1","gcgd_create4_2","gcgd_create5_2","gcgd_create6_2","gcgd_create7_1");

	for(i=0;i<lib_com.length;i++) {
		if("gcgd_create"+Obj==lib_com[i]) {
			eval("document.all."+lib_com[i]+".style.display='block';");
			eval("document.all."+lib_total[i]+".style.display='block';");
		}	else {
			eval("document.all."+lib_com[i]+".style.display='none';");
			eval("document.all."+lib_total[i]+".style.display='none';");
		}
	}
	
	for(i=1;i<=7;i++){
		if(Obj.substring(0,1)==(""+i)){
				eval("document.all.gcgd_create"+i+".style.display='block';");
		}	else {
				eval("document.all.gcgd_create"+i+".style.display='none';");
		}
	 }
    
	if(Obj=="4_1" || Obj=="5_1" || Obj=="6_1") {	
		document.all.ft_div1.style.display="none";
		document.all.ft_div2.style.display="none";
		document.all.ft_div3.style.display="block";

		gcds_pyo4.namevalue(1,"param5")="0";
		//gcds_pyo4.namevalue(1,"param6")="�ǰ������";
		gcds_pyo4.namevalue(1,"param7")="0";
		//gcds_pyo4.namevalue(1,"param8")="�ҵ漼��";
		gcds_pyo4.namevalue(1,"param9")="0";

		gcds_pyo4.namevalue(2,"param1")="0";
		//gcds_pyo4.namevalue(2,"param2")="�����޾װ�";
		gcds_pyo4.namevalue(2,"param3")="0";
		//gcds_pyo4.namevalue(2,"param4")="�󿩰�";
		gcds_pyo4.namevalue(2,"param5")="0";
		//gcds_pyo4.namevalue(2,"param6")="���ο��ݰ�";
		gcds_pyo4.namevalue(2,"param7")="0";
		//gcds_pyo4.namevalue(2,"param8")="�ֹμ���";
		gcds_pyo4.namevalue(2,"param9")="0";

		//gcds_pyo4.namevalue(3,"param4")="�������";
		gcds_pyo4.namevalue(3,"param5")="0";
		//gcds_pyo4.namevalue(3,"param6")="���뺸���";
		gcds_pyo4.namevalue(3,"param7")="0";
		//gcds_pyo4.namevalue(3,"param8")="������";
		gcds_pyo4.namevalue(3,"param9")="0";
		gcds_pyo4.RowPosition = 4;


		gcds_pyo5.namevalue(1,"param5")="0";
		//gcds_pyo5.namevalue(1,"param6")="�ǰ������";
		gcds_pyo5.namevalue(1,"param7")="0";
		//gcds_pyo5.namevalue(1,"param8")="�ҵ漼��";
		gcds_pyo5.namevalue(1,"param9")="0";

		gcds_pyo5.namevalue(2,"param1")="0";
		//gcds_pyo5.namevalue(2,"param2")="�����޾װ�";
		gcds_pyo5.namevalue(2,"param3")="0";
		//gcds_pyo5.namevalue(2,"param4")="�󿩰�";
		gcds_pyo5.namevalue(2,"param5")="0";
		//gcds_pyo5.namevalue(2,"param6")="���ο��ݰ�";
		gcds_pyo5.namevalue(2,"param7")="0";
		//gcds_pyo5.namevalue(2,"param8")="�ֹμ���";
		gcds_pyo5.namevalue(2,"param9")="0";

		//gcds_pyo5.namevalue(3,"param4")="�������";
		gcds_pyo5.namevalue(3,"param5")="0";
		//gcds_pyo5.namevalue(3,"param6")="���뺸���";
		gcds_pyo5.namevalue(3,"param7")="0";
		//gcds_pyo5.namevalue(3,"param8")="������";
		gcds_pyo5.namevalue(3,"param9")="0";
		gcds_pyo5.RowPosition = 4;


		//�޿��ҵ��Ѿ�
		gcds_pyo6.namevalue(1,"param5")="0";
		//gcds_pyo4.namevalue(1,"param6")="�ǰ������";
		gcds_pyo6.namevalue(1,"param7")="0";
		//gcds_pyo4.namevalue(1,"param8")="�ҵ漼��";
		gcds_pyo6.namevalue(1,"param9")="0";

		gcds_pyo6.namevalue(2,"param1")="0";
		//gcds_pyo4.namevalue(2,"param2")="�����޾װ�";
		gcds_pyo6.namevalue(2,"param3")="0";
		//gcds_pyo4.namevalue(2,"param4")="�󿩰�";
		gcds_pyo6.namevalue(2,"param5")="0";
		//gcds_pyo4.namevalue(2,"param6")="���ο��ݰ�";
		gcds_pyo6.namevalue(2,"param7")="0";
		//gcds_pyo4.namevalue(2,"param8")="�ֹμ���";
		gcds_pyo6.namevalue(2,"param9")="0";

		//gcds_pyo4.namevalue(3,"param4")="�������";
		gcds_pyo6.namevalue(3,"param5")="0";
		//gcds_pyo4.namevalue(3,"param6")="���뺸���";
		gcds_pyo6.namevalue(3,"param7")="0";
		//gcds_pyo4.namevalue(3,"param8")="������";
		gcds_pyo6.namevalue(3,"param9")="0";
		gcds_pyo6.RowPosition = 4;
	}	else 	{ 
		if(Obj=="2_1"){
		document.all.ft_div1.style.display="none";
		document.all.ft_div2.style.display="block";
		document.all.ft_div3.style.display="none";
		
		}else	{      //3_1,1_1
		document.all.ft_div1.style.display="block";
		document.all.ft_div2.style.display="none";
		document.all.ft_div3.style.display="none";
		
		}
	}
	if(Obj=="3_1") document.all.excel_btn_id.style.visibility="visible";
	else document.all.excel_btn_id.style.visibility="hidden";
   
	 gcds_grid_ec03az.clearData();
   gcds_grid_ec04az.clearData();
   gcds_grid_ec05az.clearData();
	 gcds_grid_ec06az.clearData();

   ft_cnt1.innerText = "";
   ft_cnt2.innerText = "";
   ft_cnt3.innerText = "";
	 //ft_cnt6.innerText = "";

	 gclx_select_jigub3.index=0; //���ޱ���3
	 gclx_select_jigub4.index=0; //���ޱ���4
	 gclx_select_jigub5.index=0; //���ޱ���5
	 gclx_select_jigub6.index=0; //���ޱ���6

	 gclx_select_div3.index=0; //�Ҽӱ���3
	 gclx_select_div4.index=0; //�Ҽӱ���4
	 gclx_select_div5.index=0; //�Ҽӱ���5

	 gclx_select_div6.index=0; //��������6
	 gclx_ord_7.index=0; //�߷�

   gclx_select_ec03az_3.index=0; //��������
	 gclx_select_group4.index=0;
	 gclx_select_group5.index=0;

   gclx_select_position4.index=0; //��������
   gclx_select_position5.index=0;

   gclx_select_grade4.index=0;		//���ޱ���
   gclx_select_grade5.index=0;

}

/*******************************************************************************
  Description : ����
******************************************************************************/
function ln_Excel_bank(){
	
	var str1 =fn_trim(gcem_app_yyyymm_3.Text);
	var str2 =fn_trim(gclx_select_ec01az_3.BindColVal);

	gcds_excel.DataID = "/servlet/Contract.h100009_s12?v_str1="+str1+"&v_str2="+str2;
	//prompt('',gcds_excel.DataID);
	
	gcds_excel.Reset(); 

}


/*******************************************************************************
  Description : ��¹� TITLE ����
******************************************************************************/
function ln_Print_title(){
var strTitle = fn_trim(gclx_select_jigub4.bindcolval);
 var strTitlenm = fn_trim(gclx_select_jigub4.text);
	//alert("strTitle" + strTitle + "   strTitlenm   "+strTitlenm);
  if (strTitle==1){
		gcds_report0.namevalue(1,"CTITLE") = "�����";	
	}else if (strTitle==5) {
    gcds_report0.namevalue(1,"CTITLE") = "��";
	}	else if (strTitle=='T') {
	   //alert(strTitlenm);
    gcds_report0.namevalue(1,"CTITLE") = "����� �޿�������Ȳ";
	}else if (strTitle=='K') {
	   //alert(strTitlenm);
    gcds_report0.namevalue(1,"CTITLE") = "�ݷ���";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_pyo4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �ӽ� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_pyo5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �ӽ� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_pyo6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �ӽ� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���ޱ��� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �Ҽӱ��� DataSet-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec03az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec04az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec05az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec06az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �޿��׸� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec08az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ü DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec03az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec04az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec05az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec06az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SortExpr     value="+TREECD">
  <param name=SubsumExpr   value="1:TREECD">
<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORT��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel_5_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �ҼӺ��޿�������Ȳ Excel DataSet--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �޿�������Ȳ Excel DataSet--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel_6_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �޿��ҵ��Ѿ� Excel DataSet--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_change_7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ����޿�������--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_excel" event="OnLoadStarted()">
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (gcds_excel.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	//else gcgd_excel.RunExcel('���°���');
 else gcgd_excel.RunExcel('���°���');
</script>

<script language=javascript for=gcgd_create4_2 event=OnScrolling(row,col,bymethod)>
	if(!bymethod)
	gcgd_create4_1.SetScrolling(row,(col + 5));
</script>

<script language=javascript for=gcgd_create5_2 event=OnScrolling(row,col,bymethod)>
	if(!bymethod)
	gcgd_create5_1.SetScrolling(row,(col + 3));
</script>

<script language=javascript for=gcgd_create6_2 event=OnScrolling(row,col,bymethod)>
	if(!bymethod)
	gcgd_create6_1.SetScrolling(row,(col + 7));
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");

	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt2.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec02az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec03az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec03az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec03az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec04az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt3.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec04az" event="onloadcompleted(row,colid)">
	nwgubun.disable=true;
	ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec04az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	else
	{
		//gcds_pyo4.namevalue(1,"param1")="�Ѱ�";
		//gcds_pyo4.namevalue(1,"param4")="�޿���";
		gcds_pyo4.namevalue(1,"param5")=gcds_grid_ec04az.Sum(7,0,0)+"";
		//gcds_pyo4.namevalue(1,"param6")="�ǰ������";
		gcds_pyo4.namevalue(1,"param7")=gcds_grid_ec04az.Sum(10,0,0)+"";
		//gcds_pyo4.namevalue(1,"param8")="�ҵ漼��";
		gcds_pyo4.namevalue(1,"param9")=gcds_grid_ec04az.Sum(13,0,0)+"";

		gcds_pyo4.namevalue(2,"param1")=gcds_grid_ec04az.countRow;
		//gcds_pyo4.namevalue(2,"param2")="�����޾װ�";
		gcds_pyo4.namevalue(2,"param3")=gcds_grid_ec04az.Sum(16,0,0)+"";
		//gcds_pyo4.namevalue(2,"param4")="�󿩰�";
		gcds_pyo4.namevalue(2,"param5")=gcds_grid_ec04az.Sum(8,0,0)+"";
		//gcds_pyo4.namevalue(2,"param6")="���ο��ݰ�";
		gcds_pyo4.namevalue(2,"param7")=gcds_grid_ec04az.Sum(11,0,0)+"";
		//gcds_pyo4.namevalue(2,"param8")="�ֹμ���";
		gcds_pyo4.namevalue(2,"param9")=gcds_grid_ec04az.Sum(14,0,0)+"";

		//gcds_pyo4.namevalue(3,"param4")="�������";
		gcds_pyo4.namevalue(3,"param5")=gcds_grid_ec04az.Sum(9,0,0)+"";
		//gcds_pyo4.namevalue(3,"param6")="���뺸���";
		gcds_pyo4.namevalue(3,"param7")=gcds_grid_ec04az.Sum(12,0,0)+"";
		//gcds_pyo4.namevalue(3,"param8")="������";
		gcds_pyo4.namevalue(3,"param9")=gcds_grid_ec04az.Sum(15,0,0)+"";
		gcds_pyo4.RowPosition = 4;
	}
	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec05az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt3.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec05az" event="onloadcompleted(row,colid)">
	ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec05az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	else
	{
		//gcds_pyo5.namevalue(1,"param1")="�Ѱ�";
		//gcds_pyo5.namevalue(1,"param4")="�޿���";
		gcds_pyo5.namevalue(1,"param5")=gcds_grid_ec05az.Sum(5,0,0)+"";
		//gcds_pyo5.namevalue(1,"param6")="�ǰ������";
		gcds_pyo5.namevalue(1,"param7")=gcds_grid_ec05az.Sum(8,0,0)+"";
		//gcds_pyo5.namevalue(1,"param8")="�ҵ漼��";
		gcds_pyo5.namevalue(1,"param9")=gcds_grid_ec05az.Sum(11,0,0)+"";

		gcds_pyo5.namevalue(2,"param1")=gcds_grid_ec05az.countRow;
		//gcds_pyo5.namevalue(2,"param2")="�����޾װ�";
		gcds_pyo5.namevalue(2,"param3")=gcds_grid_ec05az.Sum(14,0,0)+"";
		//gcds_pyo5.namevalue(2,"param4")="�󿩰�";
		gcds_pyo5.namevalue(2,"param5")=gcds_grid_ec05az.Sum(6,0,0)+"";
		//gcds_pyo5.namevalue(2,"param6")="���ο��ݰ�";
		gcds_pyo5.namevalue(2,"param7")=gcds_grid_ec05az.Sum(9,0,0)+"";
		//gcds_pyo5.namevalue(2,"param8")="�ֹμ���";
		gcds_pyo5.namevalue(2,"param9")=gcds_grid_ec05az.Sum(12,0,0)+"";

		//gcds_pyo5.namevalue(3,"param4")="�������";
		gcds_pyo5.namevalue(3,"param5")=gcds_grid_ec05az.Sum(7,0,0)+"";
		//gcds_pyo5.namevalue(3,"param6")="���뺸���";
		gcds_pyo5.namevalue(3,"param7")=gcds_grid_ec05az.Sum(10,0,0)+"";
		//gcds_pyo5.namevalue(3,"param8")="������";
		gcds_pyo5.namevalue(3,"param9")=gcds_grid_ec05az.Sum(13,0,0)+"";
		gcds_pyo5.RowPosition = 4;
	}
	nwgubun.disabled=false;
</script>

<!-- �޿� �ҵ� �Ѿ� END -->
<script language="javascript" for="gcds_grid_ec06az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt3.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec06az" event="onloadcompleted(row,colid)">
	nwgubun.disable=true;
	ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec06az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	else
	{
		//gcds_pyo6.namevalue(1,"param1")="�Ѱ�";
		//gcds_pyo6.namevalue(1,"param4")="�޿���";
		gcds_pyo6.namevalue(1,"param5")=gcds_grid_ec06az.Sum(7,0,0)+"";
		//gcds_pyo6.namevalue(1,"param6")="�ǰ������";
		gcds_pyo6.namevalue(1,"param7")=gcds_grid_ec06az.Sum(10,0,0)+"";
		//gcds_pyo6.namevalue(1,"param8")="�ҵ漼��";
		gcds_pyo6.namevalue(1,"param9")=gcds_grid_ec06az.Sum(13,0,0)+"";

		gcds_pyo6.namevalue(2,"param1")=gcds_grid_ec06az.countRow;
		//gcds_pyo6.namevalue(2,"param2")="�����޾װ�";
		gcds_pyo6.namevalue(2,"param3")=gcds_grid_ec06az.Sum(16,0,0)+"";
		//gcds_pyo6.namevalue(2,"param4")="�󿩰�";
		gcds_pyo6.namevalue(2,"param5")=gcds_grid_ec06az.Sum(8,0,0)+"";
		//gcds_pyo6.namevalue(2,"param6")="���ο��ݰ�";
		gcds_pyo6.namevalue(2,"param7")=gcds_grid_ec06az.Sum(11,0,0)+"";
		//gcds_pyo6.namevalue(2,"param8")="�ֹμ���";
		gcds_pyo6.namevalue(2,"param9")=gcds_grid_ec06az.Sum(14,0,0)+"";

		//gcds_pyo6.namevalue(3,"param4")="�������";
		gcds_pyo6.namevalue(3,"param5")=gcds_grid_ec06az.Sum(9,0,0)+"";
		//gcds_pyo6.namevalue(3,"param6")="���뺸���";
		gcds_pyo6.namevalue(3,"param7")=gcds_grid_ec06az.Sum(12,0,0)+"";
		//gcds_pyo6.namevalue(3,"param8")="������";
		gcds_pyo6.namevalue(3,"param9")=gcds_grid_ec06az.Sum(15,0,0)+"";
		gcds_pyo6.RowPosition = 4;
	}
	nwgubun.disabled=false;
	// alert("!!!");
</script>
<!-- �޿� �ҵ� �Ѿ� END -->

<!-- ����޿������� -->
<script language="javascript" for="gcds_change_7" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_change_7" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_change_7.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	nwgubun.disabled=false;
</script>
<!-- ����޿������� END -->

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
  
	gclx_select_jigub3.index=0; //���ޱ���3
	gclx_select_jigub4.index=0; //���ޱ���4
	gclx_select_jigub5.index=0; //���ޱ���5
	gclx_select_jigub6.index=0; //���ޱ���6
  
//	gcds_select_ec01az.DeleteRow(2);
//	gcds_select_ec01az.DeleteRow(2);
//	gcds_select_ec01az.DeleteRow(2);

</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="��ü";
	gclx_select_div3.index=0; //�Ҽӱ���3
	gclx_select_div4.index=0; //�Ҽӱ���4
	gclx_select_div5.index=0; //�Ҽӱ���5
	gclx_select_div7.index=0; //�Ҽӱ���7
</script>

<script language="javascript" for="gcds_select_ec03az" event="onloadCompleted(row,colid)">
	gcds_select_ec03az.InsertRow(1); //����
	gcds_select_ec03az.NameValue(1,"MINORCD")="";
	gcds_select_ec03az.NameValue(1,"MINORNM")="��ü";
	gclx_select_ec03az_3.index=0;
	gclx_select_group4.index=0;
	gclx_select_group5.index=0;
</script>

<script language="javascript" for="gcds_select_ec04az" event="onloadCompleted(row,colid)">
	gcds_select_ec04az.InsertRow(1);
	gcds_select_ec04az.NameValue(1,"MINORCD")="";
	gcds_select_ec04az.NameValue(1,"MINORNM")="��ü";
	//���� ��ü�� ���ԵǾ�����
	//gclx_select_ec04az.index=0;
	gclx_select_position4.index=0;
	gclx_select_position5.index=0;
	gclx_select_position7.index=0;
</script>

<script language="javascript" for="gcds_select_ec05az" event="onloadCompleted(row,colid)">
	gcds_select_ec05az.InsertRow(1);
	gcds_select_ec05az.NameValue(1,"MINORCD")="";
	gcds_select_ec05az.NameValue(1,"MINORNM")="��ü";
	//gclx_select_ec05az.index=0;
	gclx_select_grade4.index=0;
	gclx_select_grade5.index=0;
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec03az" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec04az" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>


<!--�ҼӺ��޿�������Ȳ Excel -->
<script language="javascript" for="gcds_excel_5_1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel_5_1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<!--�޿��ҵ��Ѿ� Excel -->
<script language="javascript" for="gcds_excel_6_1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel_6_1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_report0" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_report0" event="onloadCompleted(row,colid)">

	if(nwgubun.value=="4_1"){ //�޿�������Ȳ
		ln_Print_title();
	}

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_report0.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_select_div4 event=onSelChange()>
	gs_level	= '';
	gs_treecd =	'';
	gs_level	= gclx_select_div4.ValueOfIndex ("level", gclx_select_div4.Index);
	gs_treecd = gclx_select_div4.ValueOfIndex ("treecd", gclx_select_div4.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language=JavaScript for=gclx_select_div7 event=onSelChange()>
	gs_level	 = '';
	gs_treecd  = '';
	gs_level	 = gclx_select_div7.ValueOfIndex("level", gclx_select_div7.Index);
	gs_treecd  = gclx_select_div7.ValueOfIndex("treecd", gclx_select_div7.Index);
	gs_treecd  = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif" ><img src="../img/p020007_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>	    
			 <img id=excel_btn_id src="../../Common/img/btn/com_b_bank.gif" style="visible:hidden;cursor:hand" onclick="ln_Excel_bank()"> 
			 <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			 <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
			 <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			&nbsp;</nobr>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="0" cellspacing="0" border="0">
    <tr><td width=140 valign=top>
			<table cellpadding="0" cellspacing="0" border="0" style='width:125px;height:62px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
					<td align=center  style="height:30px;border:0 solid #708090;border-bottom-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;��±���&nbsp;</nobr></td><tr>
				<tr> 
					<td align=center  style="border:0 solid #708090;"><nobr>&nbsp;
						<SELECT id="nwgubun" name=�ҼӺ�"nwgubun" style="width:122px;" onchange="ln_visible_hidden(this.value);">
							<option value="4_1">�޿� ������Ȳ</option>
							<option value="5_1">�ҼӺ� �޿���Ȳ</option>
							<option value="3_1">�޿� ������Ȳ</option>
							<option value="6_1">�޿� �ҵ��Ѿ�</option>
							<option value="7_1">����޿�������</option>
						</SELECT>&nbsp;</nobr></td></tr></table></td>
          <td valign=top><nobr>
					<DIV ID="gcgd_create1" STYLE="display:block;"></div>
					<DIV ID="gcgd_create2" STYLE="display:block;"></div>

<DIV ID="gcgd_create3" STYLE="display:block;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;������&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_app_yyyymm_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;���ޱ���&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_ec01az_3  name="gclx_select_jigub3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
         	<param name=CBData					value="T^���޿�00,K^Ư����">					
					<param name=ComboDataID			value=gcds_select_ec01az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>

			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;padding-left:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-top-width:0px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div3  name="gclx_select_div3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM^0^160">
					<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr >&nbsp;����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_ec03az_3  name="gclx_select_ec03az_3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
				style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec03az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;&nbsp;</td>
		</tr>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;padding-left:3px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>
			<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3>&nbsp;</td>
			<td width="100%" style="height:30px;border:0 solid #708090;border-top-width:0px;" align=RIGHT >&nbsp;&nbsp;</td>
		</tr>
</table>
</div>
<!--�Ⱓ�����ҵ���Ȳ,�Ⱓ�ҵ�������Ȳ-->

<!--�޿�������Ȳ-->
<DIV ID="gcgd_create4" STYLE="display:block;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;���޳��&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px;"><nobr>
    <table cellpadding=0 cellspacing=0>
			<tr>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm41 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td><td>~</td>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=0>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			</tr>
		</table></nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;���ޱ���&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;padding-top:2px;"><nobr>
        <table cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td><nobr>
							<comment id="__NSID__"><OBJECT id=gclx_select_jigub4  name="gclx_select_jigub4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
								<param name=ComboDataID			value=gcds_select_ec01az>
								<param name=SearchColumn		value="MINORCD^MINORNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM">
								<param name=BindColumn			value="MINORCD">
							</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
					</tr>
				</table></nobr></td>
            <td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;&nbsp;</nobr></td>
						<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;</nobr></td>
						<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;</td>
						<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;&nbsp;</td>
					</tr>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_div4  name="gclx_select_div4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value=gcds_dept>
							<param name=SearchColumn		value="DEPTCD^DEPTNM">
							<param name=Sort            value="false">
							<param name=SortColumn			value="DEPTCD">
							<param name=ListExprFormat	value="DEPTNM^0^160">
							<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
          <td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;����&nbsp;</nobr></td>
          <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_group4   name="gclx_select_group4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec03az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
          <td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;����&nbsp;</nobr></td>
          <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_position4  name="gclx_select_position4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec04az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM^0^150">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>
          <td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee" ><nobr>&nbsp;����&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_grade4  name="gclx_select_grade4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:70px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec05az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
					<td width="10" align=left style="height:30px;border:0 solid #708090;border-right-width:0px;" ><nobr>&nbsp;&nbsp;</nobr></td>
				</tr>
			</table>
</div>

<!-- �޿� �ҵ� �Ѿ� [�˻�]-->
<DIV ID="gcgd_create6" STYLE="display:block;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;������&nbsp;&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm61 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td><td style="height:30px;border:0 solid #708090;border-bottom-width:1px;">~&nbsp;</td>
				<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;"><nobr>
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm62 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;padding-left:0px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;���ޱ���&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_ec01az_6  name="gclx_select_jigub6" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
				<!--	<param name=CBData					value="0^��ü,1^����޿�,5^�󿩱޿�">
					<param name=CBDataColumns		value="MINORCD,MINORNM">
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">-->
					<param name=ComboDataID			value=gcds_select_ec01az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;padding-left:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;��������&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;padding-top:2px;border-top-width:0px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div6  name="gclx_select_div6" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=CBData					value="0^��ü,1^������,3^������">
					<param name=CBDataColumns		value="MINORCD,MINORNM">
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;</td>
		</tr>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;" colspan="3"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div7 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM^0^160">
					<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
			<td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;����&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;" colspan="4"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_position7 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:140px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec04az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM^0^150">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
		</tr>
	</table>
</div>
<!-- �޿� �ҵ� �Ѿ� END -->

<!--����޿�������//////////////////////////////////////////////////////////////////////////////////////////////////-->
<DIV ID="gcgd_create7" STYLE="display:none;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;������&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_app_yyyymm_7 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:1px;top:1px;width:50px;height:20px;font-family:����;font-size:9pt;z-index:2;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;���ޱ���&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gclx_select_7  name="gclx_select_jigub3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec01az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM^0^150">
					<param name=BindColumn			value="MINORCD">
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
     <td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�߷ɱ���&nbsp;</nobr></td>	
		 <td style="height:30px;border:0 solid solid #708090;border-right-width:0px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__">
					<object  id=gclx_ord_7 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:2px;top:0px;font-size:12px;width:100px;">
							<param name=CBData			   value="A^��ü,A1^�Ի�,A2^���,A3^����,A4^����,A5^��Ÿ">
							<param name=CBDataColumns	 value="CODE,NAME">
							<param name=SearchColumn	 value=NAME>
							<param name=Sort			     value=false>
							<param name=ListExprFormat value="NAME^0^100">								
							<param name=BindColumn		 value="CODE">
					</object></comment><script>__ws__(__NSID__);</script> 	
			</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;&nbsp;</td>
    </tr>
		<tr> 
		  <td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;padding-left:3px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;padding-left:3px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>
		
		</tr>
</table>
</DIV>
<!--����޿������� END-->


<!--�ҼӺ� ������Ȳ �˻�Ű����-->
<DIV ID="gcgd_create5" STYLE="display:block;">   
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;���޳��&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px;"><nobr>
        <table cellpadding=0 cellspacing=0><tr><td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm51 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=0>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
			    </OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td><td>~</td>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm52 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			</tr>
		</table></nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
					<nobr>&nbsp;���ޱ���&nbsp;</nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;padding-top:2px;"><nobr>
    <table cellpadding=0 cellspacing=0 border=0>
			<tr>
				<td><nobr>
					<comment id="__NSID__"><OBJECT id=gclx_select_jigub5  name="gclx_select_jigub5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec01az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="false">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
				</td>
			</tr>
		</table></nobr></td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;&nbsp;</nobr></td>
			<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;</nobr></td>
			<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;&nbsp;</td>
		</tr>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div5  name="gclx_select_div5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM^0^160">
					<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
			<td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;����&nbsp;</nobr></td>
      <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_group5   name="gclx_select_group5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec03az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
      <td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;����&nbsp;</nobr></td>
      <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_position5  name="gclx_select_position5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec04az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM^0^150">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee" ><nobr>&nbsp;����&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_grade5  name="gclx_select_grade5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:70px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec05az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
      <td width="10" align=left style="height:30px;border:0 solid #708090;border-right-width:0px;" ><nobr>&nbsp;&nbsp;</nobr></td></tr>				</table>
		</div></nobr>
					</td>
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
          <td style="width:340px" valign=top>
						<DIV ID="gcgd_create1_1" STYLE="display:block;"> </div>
						<DIV ID="gcgd_create2_1" STYLE="display:block;">  </div>
						<DIV id=gcgd_create2_2 style="position:absolute;top:112px;left:347px;display:none"></div>
						<comment id="__NSID__"><OBJECT id=gcgd_create3_1 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 875px; HEIGHT: 416px;border:1 solid #777777;display:block;" viewastext>
						  <PARAM NAME="DataID"			VALUE="gcds_grid_ec03az">
						  <PARAM NAME="Editable"		VALUE="false">
						  <PARAM NAME="BorderStyle" VALUE="0">
						  <PARAM NAME="viewSummary" VALUE="1">
							<PARAM name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<FX> Name='��    ����' ID=EXCSCR1  	HeadAlign=left HeadBgColor=#B9D4DC Width=65
										<G> Name='��' ID=EXCSCR3  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65
											<C> Name='����    ��' ID=PAYGRDNM  	HeadAlign=right HeadBgColor=#B9D4DC Width=70 SumText='�հ�' SumBgColor=#C3D0DB   BgColor='#f5f5f5' align=LEFT </C> 
										</G>
								</FX>
								<FX> Name='05�� 03��'   ID=PRVYYYYMM	HeadAlign=Center HeadBgColor=#B9D4DC 
										<C> Name='�ο�' ID=PRVNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB align=RIGHT </C> 
										<C> Name='�ݾ�' ID=PRVAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
								</FX>
								<FX> Name='05�� 04��'    ID=NOWYYYYMM	HeadAlign=Center HeadBgColor=#B9D4DC 
										<C> Name='�ο�' ID=NEXNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										<C> Name='�ݾ�' ID=NEXAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
								</FX>
								<X> Name='��������'   	HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<G> Name='��' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='�ο�' ID=ITSNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=40 SumText=@sum SumBgColor=#C3D0DB   align=RIGHT </C> 
										<C> Name='�ݾ�' ID=ITSAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										</G>

										<G> Name='�Ի�' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='�ο�' ID=IBSANUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30 SumText=@sum SumBgColor=#C3D0DB   align=RIGHT </C> 
										<C> Name='�ݾ�' ID=IBSAAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										</G>

										<G> Name='���' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='�ο�' ID=TAENUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										<C> Name='�ݾ�' ID=TAEAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										</G>

										<G> Name='����' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='�ο�' ID=SUNGNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										<C> Name='�ݾ�' ID=SUNGAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										</G>

										<C> Name='��' ID=AA_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='�⺻' ID=A1_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='��å' ID=A2_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='�ð���' ID=A3_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB    align=RIGHT  </C> 
										<C> Name='�ټ�\\����' ID=A4_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='�� ��\\��ߺ�' ID=A5_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='�� ��\\�ξ��' ID=A6_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB   align=RIGHT  </C> 

										<C> Name='�� ��\\������' ID=A7_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='�ڰ�\\����' ID=A8_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='����\\����' ID=A9_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='����\\����' ID=A10_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='Ư����\\�� ��' ID=A11_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB   align=RIGHT  </C> 
										<C> Name='�����ٹ�\\��  ��' ID=A12_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='��  ��\\�ٹ�����' ID=A13_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='�����ұ�' ID=A14_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='�ӿ���å' ID=A15_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='���ڱ�' ID=A16_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
           
										<C> Name='�ⳳ����' ID=A17_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='��������' ID=A18_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='�������' ID=A19_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='����ܼ���' ID=A20_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='��������' ID=A21_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='�Ĵ뺸��' ID=A22_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='��Ÿ����1' ID=A23_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='��Ÿ����2' ID=A24_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='��Ÿ����3' ID=A25_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
							</X>
								<C> Name='���' ID=GODSCRSS  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
<!-- �޿�������Ȳ-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create4_1 codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec04az">
              <PARAM NAME="Editable"		VALUE="False">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='�Ҽ�' ID=DEPTNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=left  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='���' ID=PAYDT BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB Value={Left(PAYDT,6)}  sort=true MASK='XXXX/XX'</FC> 
								<FC> Name='����' ID=PAYDIVNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<FC> Name='���' ID=EMPNO BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<F> Name='����' ID=EMPNMK BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center SumBgColor=#C3D0DB  sort=true </F> 
								<C> Name='�⺻��'		ID=P10000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��' ID=P11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB show=false</C>
								<C> Name='�������'			 ID=P30000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=right   </C> 
								<C> Name='�����ٹ�����'     ID=P31000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=78  align=right   </C> 
								<C> Name='�ð���'		ID=P12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ǰ�����' ID=B11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���ο���' ID=B12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���뺸��' ID=B13000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ҵ漼'		ID=T11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='�ֹμ�'		ID=T12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='����'			ID=S93000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<c> Name='�����޾�' ID=S94000   HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT  SumBgColor=#C3D0DB </c> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>

						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create4_2  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"   style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_pyo4">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="ViewHeader"	VALUE="False">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="HiddenVScroll" VALUE="True">
							<PARAM NAME="Fillarea"		VALUE="True">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='' ID=param1  	HeadAlign=Center	HeadBgColor=#B9D4DC  BgColor='#C3D0DB' Width=80 align=center </C> 
							<C> Name='' ID=param2  	HeadAlign=Center	HeadBgColor=#B9D4DC BgColor='#C3D0DB' Width=70 align=center  </C> 
							<C> Name='' ID=param3   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=RIGHT Value={Number(param3)}  </C> 
							<C> Name='' ID=param4		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=86 align=RIGHT  </C> 
							<C> Name='' ID=param5		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT  Value={Number(param5)} </C> 
							<C> Name='' ID=param6   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
							<C> Name='' ID=param7   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param7)} </C> 
							<C> Name='' ID=param8   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
							<C> Name='' ID=param9		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=RIGHT   Value={Number(param9)}  </C> 
							<C> Name='' ID=param10  BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=133 align=RIGHT  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script> 
						
						<!-- �޿� �ҵ� �Ѿ� START-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create6_1 codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec06az">
              <PARAM NAME="Editable"		VALUE="False">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='�Ҽ�'				ID=DEPTNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=105 align=left    SumBgColor=#C3D0DB sort=true </FC>
								<FC> Name='����'				ID=PAYGNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left    SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='���'				ID=EMPNO  BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='����'				ID=EMPNMK BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=left    SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='�ֹι�ȣ'		ID=RESINO BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=center  SumBgColor=#C3D0DB sort=true MASK='XXXXXX-XXXXXXX' </FC> 
								<FC> Name='�Ի���'			ID=STRTDT BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=center  SumBgColor=#C3D0DB sort=true MASK='XXXX/XX/XX'</FC> 
								<FC> Name='������'			ID=PAYDT  BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center  SumBgColor=#C3D0DB Value={Left(PAYDT,6)}  sort=true MASK='XXXX/XX'</FC>  
								
								<C> Name='�⺻��'				ID=P10000 HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��å����'			ID=P11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ð��ܼ���'		ID=P12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ټӼ���'			ID=P21000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ڱ��ߺ�'		ID=P22000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ξ簡������' ID=P23000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='����������'		ID=P24000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ⳳ����'			ID=P25000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��������'			ID=P26000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�������'			ID=P27000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ڰݼ���'			ID=P28000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���ϰ�������' ID=P29000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='����ܼ���'		ID=P30000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='Ư��������'		ID=P31000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�����ٹ�����' ID=P32000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�к�����'		ID=P36000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���ο��ݺ�����' ID=P37000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ӿ���å����' ID=P38000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��������'			ID=P34000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�Ĵ뺸��'			ID=P35000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�����ұ�'			ID=P39000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���ϼ���'			ID=PX0010 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��Ÿ����1'		ID=PX0020 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��Ÿ����2'		ID=PX0030 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��Ÿ����3'		ID=PX0040 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�����հ�'			ID=S91000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ҵ漼'				ID=T11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ֹμ�'				ID=T12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ǰ������'		ID=B11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���ο���'			ID=B12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���뺸��'			ID=B13000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���ο���'			ID=B15000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='������ȸ��'		ID=B14000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='����ȸ��'			ID=B16000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���纸��'			ID=B17000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��������'			ID=BX0010 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��Ÿ����1'		ID=BX0020 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��Ÿ����2'		ID=BX0030 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��Ÿ����3'		ID=BX0040 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='����ǰ�'			ID=P41000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�������'			ID=P42000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='����ҵ�'			ID=T21000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�����ֹ�'			ID=T22000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�����հ�'			ID=S93000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�����޾�'			ID=S94000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>

						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create6_2  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"   style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_pyo6">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="ViewHeader"	VALUE="False">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="HiddenVScroll" VALUE="True">
							<PARAM NAME="Fillarea"		VALUE="True">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='' ID=param1  	BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center </C> 
							<C> Name='' ID=param2  	BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  </C> 
							<C> Name='' ID=param3   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=RIGHT Value={Number(param3)}  </C> 
							<C> Name='' ID=param4		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=86		align=RIGHT  </C> 
							<C> Name='' ID=param5		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT  Value={Number(param5)} </C> 
							<C> Name='' ID=param6   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86		align=RIGHT  </C> 
							<C> Name='' ID=param7   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param7)} </C> 
							<C> Name='' ID=param8   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86		align=RIGHT  </C> 
							<C> Name='' ID=param9		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=RIGHT   Value={Number(param9)}  </C> 
							<C> Name='' ID=param10  BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=133	align=RIGHT  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<!-- �޿� �ҵ� �Ѿ� END -->

						<!-- ���� ���� START -->
						<comment id="__NSID__"><OBJECT id=gcgd_excel  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
							<PARAM NAME="DataID"				VALUE="gcds_excel">
							<PARAM NAME="Editable"			VALUE="fALSE">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="Fillarea"			VALUE="true">
							<PARAM NAME="ColSizing"			VALUE="true">
							<Param NAME="SortView"			VALUE="Left">
							<PARAM NAME="Format"				VALUE="  
								<C> Name='No'				ID={Currow} BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=CENTER </C> 
						<C> Name='����'	ID=EMPNMK 	BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER</C>
								<C> Name='�����ڵ�'	ID=PAYBNK		BgColor='#FFFFFF'	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=CENTER </C> 
								<C> Name='���¹�ȣ' ID=PAYNUM		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=CENTER </C> 
								<C> Name='�ݾ�'			ID=S94000		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='�ݾ�2'		ID=DONG		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='��'				ID=DONG			BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='ȣ��'			ID=BUNJI		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='��ȭ'			ID=TELNO		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='�޸�'			ID=MEMO			BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<!-- ���� ���� END -->

            <!--�ҼӺ� ������Ȳ-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create5_1 codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec05az">
              <PARAM NAME="Editable"		VALUE="flase">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
						  <PARAM NAME="Format"			VALUE="  
								<FC> Name='�Ҽ�' ID=DEPTNM		BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=140 align=left  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='���' ID=PAYDT			BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='����' ID=PAYDIVNM	BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB  sort=true</FC> 
								<C> Name='�⺻��' ID=P10000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='��å����' ID=P11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ð���' ID=P12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ǰ�����' ID=B11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���ο���' ID=B12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='���뺸��' ID=B13000 HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='�ҵ漼' ID=T11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='�ֹμ�' ID=T12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='����' ID=S93000  		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<c> Name='�����޾�' ID=S94000 HeadAlign=Center HeadBgColor=#B9D4DC Width=121  align=RIGHT  SumBgColor=#C3D0DB </c> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
            
						 <!--�ҼӺ� ������Ȳ Excel-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_excel_5_1  style="WIDTH:874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_excel_5_1">
							<PARAM NAME="SuppressOption" value="1">
						  <PARAM NAME="Format"			VALUE="  
								<C> Name='�Ҽ�' ID=GUBUN		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left  suppress=1  </C> 
								<C> Name='�Ҽ�' ID=DEPTNM2	HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left  </C> 
								<C> Name='�ο�' ID=CNT      HeadAlign=Center HeadBgColor=#B9D4DC Width=30   align=RIGHT  </C> 
								<C> Name='�ݾ�' ID=S91AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>

						 <!--�޿��ҵ��Ѿ� Excel-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_excel_6_1  style="WIDTH:874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_excel_6_1">
							<PARAM NAME="SuppressOption" value="1">
						  <PARAM NAME="Format"			VALUE="  
								<C> Name='�ҼӸ�'         ID=DEPTNM   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left   </C> 
								<C> Name='����'           ID=EMPNMK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left   </C> 
								<C> Name='���'           ID=EMPNO        HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  </C> 
								<C> Name='ȣ��'           ID=PAYSEQ     	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center  </C> 
								<C> Name='������'         ID=PAYGNM   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left   </C> 
								<C> Name='�ٹ���'         ID=DEPTPRTNM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left   </C> 
								<C> Name='����������'     ID=CHAGDT       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='�����'         ID=BANKNM     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left  </C> 
								<C> Name='���¹�ȣ'       ID=PAYACNT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left   </C> 
								<C> Name='�׷��Ի���'     ID=GRSTRTDT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=center  mask='XXXX/XX/XX' </C> 
								<C> Name='�Ի���'         ID=STRTDT       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  mask='XXXX/XX/XX' </C> 
								<C> Name='������'         ID=TRAINYN    	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�߷���'         ID=DPOFFDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  mask='XXXX/XX/XX' </C> 
								<C> Name='�����޾�'       ID=S94000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='�����հ�'       ID=S91000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�����հ�'       ID=S93000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�⺻��'         ID=P10000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='��å����'       ID=P11000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='�ð��ܼ���'     ID=P12000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�ټӼ���'       ID=P21000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�ڱ��ߺ�'     ID=P22000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='�ξ簡������'   ID=P23000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='����������'     ID=P24000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�ⳳ����'       ID=P25000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='��������'       ID=P26000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='�������'       ID=P27000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='�ڰݼ���'       ID=P28000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='���ϰ�������'   ID=P29000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='����ܼ���'     ID=P30000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='Ư��������'     ID=P31000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='�����ٹ�����'   ID=P32000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�к�����'     ID=P36000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='���ο��ݺ�����' ID=P37000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='�ӿ���å����'   ID=P38000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='��������'       ID=P34000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�Ĵ뺸��'       ID=P35000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�����ұ�'       ID=P39000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='���ϼ���'       ID=PX0010   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='��Ÿ����1'      ID=PX0020       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='��Ÿ����2'      ID=PX0030     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='��Ÿ����3'      ID=PX0040   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='�ҵ漼'         ID=T11000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='�ֹμ�'         ID=T12000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�ǰ������'     ID=B11000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='���ο���'       ID=B12000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='���뺸��'       ID=B13000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='���ο���'       ID=B15000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='������ȸ��'     ID=B14000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='����ȸ��'       ID=B16000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='���纸��'       ID=B17000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='��������'       ID=BX0010   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='��Ÿ����1'      ID=BX0020   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='��Ÿ����2'      ID=BX0030   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='��Ÿ����3'      ID=BX0040   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  </C> 
								<C> Name='����ǰ�'       ID=P41000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�������'       ID=P42000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='����ҵ�'       ID=T21000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='�����ֹ�'       ID=T22000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='�ֹι�ȣ'       ID=RESINO   		HeadAlign=Center HeadBgColor=#B9D4DC Width=130  align=center  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create5_2  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"   style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_pyo5">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="ViewHeader"	VALUE="False">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME=HiddenVScroll VALUE="True">
              <PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="Fillarea"		VALUE="True">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='' ID=param1  	HeadAlign=Center HeadBgColor=#B9D4DC  BgColor='#C3D0DB' Width=70 align=center </C> 
								<C> Name='' ID=param2  	HeadAlign=Center HeadBgColor=#B9D4DC BgColor='#C3D0DB' Width=70 align=center  </C> 
								<C> Name='' ID=param3   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=130  align=RIGHT    Value={Number(param3)} </C> 
								<C> Name=''  BgColor='#C3D0DB' ID=param4  	HeadAlign=Center HeadBgColor=#B9D4DC Width=86 align=RIGHT  </C> 
								<C> Name=''  BgColor='#C3D0DB' ID=param5  	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param5)} </C> 
								<C> Name='' ID=param6   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
								<C> Name='' ID=param7   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param7)}  </C> 
								<C> Name='' ID=param8   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
								<C> Name='' ID=param9  BgColor='#C3D0DB' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=RIGHT   Value={Number(param9)} </C> 
								<C> Name='' ID=param10  BgColor='#C3D0DB' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=123 align=RIGHT Dec=3 </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>         
						
						
						 <!-- ����޿�������/////////////////////////////////////////////////////////////////////////////////////////////////-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create7_1  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_change_7">
              <PARAM NAME="Editable"		VALUE="False">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='����'				ID=''        HeadAlign=Center HeadBgColor=#B9D4DC Width=30   align=center BgColor='#f5f5f5' SumBgColor=#C3D0DB value={currow} </FC>
								<FC> Name='�Ҽ�'				ID=DEPTNMK2  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='������'			ID=CHAGDT    HeadAlign=Center HeadBgColor=#B9D4DC Width=70   align=center BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true MASK={IF(CHAGDT='','','XXXX/XX/XX')}</FC> 
								<FC> Name='����'				ID=PAYGRDNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=95   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true </FC> 
							  <FC> Name='����/ȣ��'		ID=PAYSEQ    HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB  </FC> 
								<FC> Name='����'		    ID=EMPNMK    HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true  </FC> 
								<FG> Name='�ٹ��ϼ�' HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='����'			  ID=BSDAY     HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB  </FC> 
									<C> Name='����'			  ID=HJDAY     HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB  </FC>  
									<C> Name='�ؿ�'				ID=FSDAY     HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB </C> 
									<C> Name='��'			    ID=DAY_SUM   HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB </C> 
								</FG>																																															
                <G> Name='�������' HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='�⺻��'		  ID=P10000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='��'		  	ID=P11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�ð���'		  ID=P12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�ټӼ���'   ID=P21000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�ڱ���'		ID=P22000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�����ξ�'		ID=P23000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�ڰݼ���'		ID=P28000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='���ϰ���'		ID=P29000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='���ο���'		ID=P37000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�������'		ID=P27000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='��Ÿ����'		ID=ETC_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�Ұ�'       ID=COM_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=75 align=RIGHT SumBgColor=#C3D0DB  BgColor=#C3D0DB</C> 
								</G>

                <G> Name='��������' HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='��������'		ID=P24000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�������'		ID=P32000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='����Ĵ�'   ID=P35000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='����(����)'		ID=P31000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�����ұ�'   ID=P39000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='�Ұ�'       ID=CHG_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=RIGHT SumBgColor=#C3D0DB   BgColor=#C3D0DB</C> 
								</G>
								<C> Name='��'			      ID=TOT_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=85  align=RIGHT SumBgColor=#C3D0DB   BgColor=#C3D0DB</C> 
                <C> Name='���'				  ID=ORDNM2     HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true </FC>
								
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						 <!-- ����޿������� END/////////////////////////////////////////////////////////////////////////////////////////////////-->
						
						
						
						<fieldset id=ft_div1 style="width:876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
						<fieldset id=ft_div2 style="position:absolute;left:0px;top:529px;width: 342px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
						<fieldset  id=ft_div3 style="position:absolute;left:0px;top:529px;width:876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;display:none">
							<font id=ft_cnt3 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
						<!-- <fieldset  id=ft_div6 style="position:absolute;left:0px;top:529px;width:876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;display:none">
							<font id=ft_cnt6 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset> -->
          </td>
        </tr>
			</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------> 
<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_grid_ec02az">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=EMPNO		Ctrl=txt_EMPNO		Param=value</C>	
		<C>Col=EMPNMK		Ctrl=txt_EMPNMK		Param=value</C> 
		<C>Col=NOTWRK		Ctrl=txt_NOTWRK		Param=value</C> 
		<C>Col=APPDT		Ctrl=gcem_APPDT		Param=Text</C>	
		<C>Col=PAYDIV		Ctrl=txt_PAYDIV		Param=value</C>	
		<C>Col=DEPTCD		Ctrl=txt_DEPTCD		Param=value</C>	
		<C>Col=DEPTNM		Ctrl=txt_DEPTNM		Param=value</C>	
		<C>Col=PAYGRDNM	Ctrl=txt_PAYGRDNM	Param=value</C>	
		<C>Col=GRDDIVNM	Ctrl=txt_GRDDIVNM	Param=value</C>	
		<C>Col=PAYSEQNM	Ctrl=txt_PAYSEQNM	Param=value</C>	
		<C>Col=PAYBNKNM	Ctrl=txt_PAYBNKNM	Param=value</C>	
		<C>Col=PAYNUM		Ctrl=txt_PAYNUM		Param=value</C>	
		<C>Col=PAYDT		Ctrl=gcem_PAYDT		Param=Text</C> 
		<C>Col=DUYNOT		Ctrl=txt_DUYNOT		Param=value</C>	
		<C>Col=P10000		Ctrl=gcem_P10000	Param=Text</C>
		<C>Col=P11000		Ctrl=gcem_P11000	Param=Text</C>
		<C>Col=P12000		Ctrl=gcem_P12000	Param=Text</C>
		<C>Col=P21000		Ctrl=gcem_P21000	Param=Text</C>
		<C>Col=P22000		Ctrl=gcem_P22000	Param=Text</C>
		<C>Col=P23001		Ctrl=gcem_P23001	Param=Text</C>
		<C>Col=P24000		Ctrl=gcem_P24000	Param=Text</C>
		<C>Col=P25000		Ctrl=gcem_P25000	Param=Text</C>
		<C>Col=P26000		Ctrl=gcem_P26000	Param=Text</C>
		<C>Col=P27000		Ctrl=gcem_P27000	Param=Text</C>
		<C>Col=P28000		Ctrl=gcem_P28000	Param=Text</C>
		<C>Col=P29000		Ctrl=gcem_P29000	Param=Text</C>
		<C>Col=P30000		Ctrl=gcem_P30000	Param=Text</C>
		<C>Col=P31000		Ctrl=gcem_P31000	Param=Text</C>
		<C>Col=P32000		Ctrl=gcem_P32000	Param=Text</C>
		<C>Col=P36000		Ctrl=gcem_P36000	Param=Text</C>
		<C>Col=P37000		Ctrl=gcem_P37000	Param=Text</C>
		<C>Col=P38000		Ctrl=gcem_P38000	Param=Text</C>
		<C>Col=PX0010		Ctrl=gcem_PX0010	Param=Text</C>
		<C>Col=PX0020		Ctrl=gcem_PX0020	Param=Text</C>
		<C>Col=PX0030		Ctrl=gcem_PX0030	Param=Text</C>
		<C>Col=PX0040		Ctrl=gcem_PX0040	Param=Text</C>
		<C>Col=S91000		Ctrl=gcem_S91000	Param=Text</C>
		<C>Col=T11000		Ctrl=gcem_T11000	Param=Text</C>
		<C>Col=T12000		Ctrl=gcem_T12000	Param=Text</C>
		<C>Col=B11000		Ctrl=gcem_B11000	Param=Text</C>
		<C>Col=B12000		Ctrl=gcem_B12000	Param=Text</C>
		<C>Col=B13000		Ctrl=gcem_B13000	Param=Text</C>
		<C>Col=B15000		Ctrl=gcem_B15000	Param=Text</C>
		<C>Col=B14000		Ctrl=gcem_B14000	Param=Text</C>
		<C>Col=B16000		Ctrl=gcem_B16000	Param=Text</C>
		<C>Col=BX0010		Ctrl=gcem_BX0010	Param=Text</C>
		<C>Col=BX0020		Ctrl=gcem_BX0020	Param=Text</C>
		<C>Col=BX0030		Ctrl=gcem_BX0030	Param=Text</C>
		<C>Col=BX0040		Ctrl=gcem_BX0040	Param=Text</C>
		<C>Col=S93000		Ctrl=gcem_S93000	Param=Text</C>
		<C>Col=STRTDT		Ctrl=txt_STRTDT		Param=value</C>	
		<C>Col=JOBGRPHNM  Ctrl=txt_JOBGRPHNM	Param=value</C>	
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N
------------------------------------------------------------------------------>
<!--OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=511 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=921 ,top=98 ,right=1937 ,bottom=98 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='CMM', left=1262, top=3, right=1352, bottom=90, align='right', face='Arial', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �޿����� ��Ȳ' ,left=1296 ,top=3 ,right=1847 ,bottom=90 ,face='Arial' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1183 ,top=3 ,right=1262 ,bottom=90 ,face='Arial' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=1013, top=3, right=1185, bottom=90, align='right', face='Arial', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���� : ��' ,left=2696 ,top=98 ,right=2839 ,bottom=167 ,align='right'</T>
	<T>id='1.���ο�' ,left=16 ,top=87 ,right=228 ,bottom=156 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TODATEE', left=2696, top=69, right=2839, bottom=129 ,mask='XXXX.XX.XX'</C>
	<T>id='Print Date:' ,left=2434 ,top=69 ,right=2696 ,bottom=129 ,align='right'</T>
	<L> left=2376 ,top=209 ,right=2376 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=431 ,top=209 ,right=2551 ,bottom=209 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=431 ,top=138 ,right=431 ,bottom=503 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=21 ,top=138 ,right=21 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=283 ,top=138 ,right=283 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=21 ,top=503 ,right=2828 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=90 ,top=429 ,right=90 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=90 ,top=426 ,right=2831 ,bottom=426 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=26 ,top=357 ,right=2831 ,bottom=357 </L>
	<L> left=24 ,top=283 ,right=2828 ,bottom=283 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2559 ,top=138 ,right=2559 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1503 ,top=138 ,right=1503 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2831 ,top=138 ,right=2831 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=646 ,top=209 ,right=646 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=857 ,top=212 ,right=857 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=212 ,right=1069 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1281 ,top=209 ,right=1281 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2204 ,top=209 ,right=2204 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2032 ,top=209 ,right=2032 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1688 ,top=209 ,right=1688 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1860 ,top=209 ,right=1860 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=21 ,top=135 ,right=2828 ,bottom=135 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='����' ,left=50 ,top=201 ,right=262 ,bottom=267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=296 ,top=201 ,right=431 ,bottom=267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻��' ,left=437 ,top=230 ,right=648 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���޳���' ,left=950 ,top=164 ,right=1162 ,bottom=230 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��å����' ,left=648 ,top=230 ,right=860 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð��ܼ���' ,left=860 ,top=230 ,right=1072 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=1072 ,top=230 ,right=1283 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1283 ,top=230 ,right=1495 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ټ�' ,left=1519 ,top=230 ,right=1691 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=1691 ,top=230 ,right=1863 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǰ�����' ,left=1863 ,top=230 ,right=2035 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1913 ,top=164 ,right=2125 ,bottom=230 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���' ,left=2035 ,top=230 ,right=2207 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=2207 ,top=230 ,right=2379 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2379 ,top=230 ,right=2551 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����޾�' ,left=2593 ,top=196 ,right=2805 ,bottom=262 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYYO', left=74, top=310, right=153, bottom=376, align='right'</C>
	<T>id='.' ,left=151 ,top=310 ,right=175 ,bottom=376</T>
	<C>id='CMMO', left=167, top=310, right=217, bottom=376, align='right'</C>
	<T>id='��' ,left=214 ,top=310 ,right=262 ,bottom=376</T>
	<C>id='CYYYY', left=74, top=378, right=153, bottom=445, align='right'</C>
	<T>id='.' ,left=151 ,top=378 ,right=175 ,bottom=445</T>
	<C>id='CMM', left=167, top=378, right=217, bottom=445, align='right'</C>
	<T>id='��' ,left=214 ,top=378 ,right=262 ,bottom=445</T>
	<C>id='COUNTP', left=307, top=310, right=421, bottom=376, align='right'</C>
	<C>id='COUNTR', left=307, top=378, right=421, bottom=445, align='right'</C>
	<C>id='P10000R', left=437, top=378, right=648, bottom=445, align='right'</C>
	<C>id='P10000', left=437, top=310, right=648, bottom=376, align='right'</C>
	<C>id='P11000', left=648, top=310, right=860, bottom=376, align='right'</C>
	<C>id='P11000R', left=648, top=378, right=860, bottom=445, align='right'</C>
	<C>id='P12000', left=860, top=310, right=1072, bottom=376, align='right'</C>
	<C>id='P12000R', left=860, top=378, right=1072, bottom=445, align='right'</C>
	<C>id='PXTOTALR', left=1072, top=378, right=1283, bottom=445, align='right', Dec=0</C>
	<C>id='PXTOTAL', left=1069, top=310, right=1281, bottom=376, align='right', Dec=0</C>
	<C>id='S91000', left=1281, top=310, right=1492, bottom=376, align='right', Dec=0</C>
	<C>id='S91000R', left=1281, top=378, right=1492, bottom=445, align='right', Dec=0</C>
	<C>id='T11000', left=1516, top=310, right=1688, bottom=376, align='right', supplevel=2</C>
	<C>id='T11000R', left=1516, top=378, right=1688, bottom=445, align='right', supplevel=2</C>
	<C>id='T12000', left=1688, top=310, right=1860, bottom=376, align='right', supplevel=2</C>
	<C>id='T12000R', left=1688, top=378, right=1860, bottom=445, align='right', supplevel=2</C>
	<C>id='B11000', left=1860, top=310, right=2032, bottom=376, align='right', supplevel=2</C>
	<C>id='B11000R', left=1860, top=378, right=2032, bottom=445, align='right', supplevel=2</C>
	<C>id='B12000R', left=2032, top=378, right=2204, bottom=445, align='right', supplevel=2</C>
	<C>id='BXTOTAL', left=2204, top=310, right=2376, bottom=376, align='right', supplevel=2</C>
	<C>id='B12000', left=2032, top=310, right=2204, bottom=376, align='right', supplevel=2</C>
	<C>id='BXTOTALR', left=2204, top=378, right=2376, bottom=445, align='right', supplevel=2</C>
	<C>id='S93000', left=2376, top=310, right=2548, bottom=376, align='right', supplevel=2</C>
	<C>id='S93000R', left=2376, top=378, right=2548, bottom=445, align='right', supplevel=2</C>
	<C>id='S94000', left=2588, top=310, right=2807, bottom=376, align='right', Dec=0</C>
	<C>id='S94000R', left=2588, top=378, right=2807, bottom=445, align='right', Dec=0</C>
	<C>id='{S94000R-S94000}', left=2588, top=445, right=2807, bottom=511, align='right', Dec=0</C>
	<C>id='{S93000R-S93000}', left=2376, top=445, right=2548, bottom=511, align='right'</C>
	<C>id='{BXTOTALR-BXTOTAL}', left=2204, top=445, right=2376, bottom=511, align='right'</C>
	<C>id='{B12000R-B12000}', left=2032, top=445, right=2204, bottom=511, align='right'</C>
	<C>id='{B11000R-B11000}', left=1860, top=445, right=2032, bottom=511, align='right'</C>
	<C>id='{T12000R-T12000}', left=1688, top=445, right=1860, bottom=511, align='right'</C>
	<C>id='{T11000R-T11000}', left=1516, top=445, right=1688, bottom=511, align='right'</C>
	<C>id='{S91000R-S91000}', left=1281, top=445, right=1492, bottom=511, align='right', Dec=0</C>
	<C>id='{PXTOTALR-PXTOTAL}', left=1069, top=445, right=1281, bottom=511, align='right', Dec=0</C>
	<C>id='{P12000R-P12000}', left=857, top=445, right=1069, bottom=511, align='right'</C>
	<C>id='{P11000R-P11000}', left=646, top=445, right=857, bottom=511, align='right'</C>
	<C>id='{P10000R-P10000}', left=434, top=445, right=646, bottom=511, align='right'</C>
	<C>id='{COUNTR-COUNTP}', left=304, top=445, right=418, bottom=511, align='right'</C>
	<T>id='�����������' ,left=95 ,top=445 ,right=273 ,bottom=511 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

<B>id=default ,left=0,top=0 ,right=2871 ,bottom=439 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='DEPTNM', left=82, top=3, right=595, bottom=69, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=58 ,top=0 ,right=77 ,bottom=69 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{currow+1}', left=16, top=5, right=66, bottom=71, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2373 ,top=140 ,right=2373 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DCYYYY', left=69, top=291, right=148, bottom=357, align='right'</C>
	<T>id='.' ,left=146 ,top=291 ,right=169 ,bottom=357</T>
	<C>id='DCMM', left=161, top=291, right=212, bottom=357, align='right'</C>
	<T>id='��' ,left=209 ,top=291 ,right=257 ,bottom=357</T>
	<C>id='DCMMO', left=161, top=222, right=212, bottom=288, align='right'</C>
	<T>id='.' ,left=146 ,top=222 ,right=169 ,bottom=288</T>
	<C>id='DCYYYYO', left=69, top=222, right=148, bottom=288, align='right'</C>
	<T>id='��' ,left=209 ,top=222 ,right=257 ,bottom=288</T>
	<L> left=429 ,top=140 ,right=2548 ,bottom=140 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='����' ,left=45 ,top=114 ,right=257 ,bottom=180 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=291 ,top=114 ,right=426 ,bottom=180 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=69 ,right=429 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=19 ,top=69 ,right=19 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=280 ,top=69 ,right=280 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='{DS94000R-DS94000}', left=2585, top=360, right=2805, bottom=426, align='right', Dec=0</C>
	<C>id='{DCOUNTR-DCOUNTP}', left=302, top=360, right=415, bottom=426, align='right'</C>
	<C>id='DCOUNTR', left=302, top=291, right=415, bottom=357, align='right'</C>
	<C>id='DS94000R', left=2585, top=291, right=2805, bottom=357, align='right', Dec=0</C>
	<C>id='DS94000', left=2585, top=222, right=2805, bottom=288, align='right', Dec=0</C>
	<C>id='{DP10000R-DP10000}', left=431, top=360, right=643, bottom=426, align='right'</C>
	<C>id='{DS91000R-DS91000}', left=1278, top=360, right=1490, bottom=426, align='right', Dec=0</C>
	<C>id='{DPXTOTALR-DPXTOTAL}', left=1066, top=360, right=1278, bottom=426, align='right', Dec=0</C>
	<C>id='{DP12000R-DP12000}', left=855, top=360, right=1066, bottom=426, align='right'</C>
	<C>id='{DP11000R-DP11000}', left=643, top=360, right=855, bottom=426, align='right'</C>
	<C>id='{DT11000R-DT11000}', left=1513, top=360, right=1685, bottom=426, align='right'</C>
	<C>id='{DS93000R-DS93000}', left=2373, top=360, right=2545, bottom=426, align='right'</C>
	<C>id='{DT12000R-DT12000}', left=1685, top=360, right=1857, bottom=426, align='right'</C>
	<C>id='{DB11000R-DB11000}', left=1857, top=360, right=2029, bottom=426, align='right'</C>
	<C>id='{DB12000R-DB12000}', left=2029, top=360, right=2201, bottom=426, align='right'</C>
	<C>id='{DBXTOTALR-DBXTOTAL}', left=2201, top=360, right=2373, bottom=426, align='right', supplevel=2</C>
	<L> left=87 ,top=360 ,right=87 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=87 ,top=357 ,right=2828 ,bottom=357 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DP10000R', left=431, top=291, right=643, bottom=357, align='right'</C>
	<C>id='DP11000R', left=643, top=291, right=855, bottom=357, align='right'</C>
	<C>id='DP12000R', left=855, top=291, right=1066, bottom=357, align='right'</C>
	<C>id='DPXTOTALR', left=1066, top=291, right=1278, bottom=357, align='right', Dec=0</C>
	<C>id='DS91000R', left=1278, top=291, right=1490, bottom=357, align='right', Dec=0</C>
	<C>id='DT11000R', left=1513, top=291, right=1685, bottom=357, align='right', supplevel=2</C>
	<C>id='DT12000R', left=1685, top=291, right=1857, bottom=357, align='right', supplevel=2</C>
	<C>id='DB11000R', left=1857, top=291, right=2029, bottom=357, align='right', supplevel=2</C>
	<C>id='DB12000R', left=2029, top=291, right=2201, bottom=357, align='right', supplevel=2</C>
	<C>id='DBXTOTALR', left=2201, top=291, right=2373, bottom=357, align='right', supplevel=2</C>
	<C>id='DS93000R', left=2373, top=291, right=2545, bottom=357, align='right', supplevel=2</C>
	<C>id='DCOUNTP', left=302, top=222, right=415, bottom=288, align='right'</C>
	<L> left=24 ,top=288 ,right=2828 ,bottom=288 </L>
	<C>id='DBXTOTAL', left=2201, top=222, right=2373, bottom=288, align='right', supplevel=2</C>
	<C>id='DB12000', left=2029, top=222, right=2201, bottom=288, align='right', supplevel=2</C>
	<C>id='DB11000', left=1857, top=222, right=2029, bottom=288, align='right', supplevel=2</C>
	<C>id='DT12000', left=1685, top=222, right=1857, bottom=288, align='right', supplevel=2</C>
	<C>id='DS93000', left=2373, top=222, right=2545, bottom=288, align='right', supplevel=2</C>
	<C>id='DT11000', left=1513, top=222, right=1685, bottom=288, align='right', supplevel=2</C>
	<C>id='DS91000', left=1278, top=222, right=1490, bottom=288, align='right', Dec=0</C>
	<C>id='DP10000', left=431, top=222, right=643, bottom=288, align='right'</C>
	<C>id='DP11000', left=643, top=222, right=855, bottom=288, align='right'</C>
	<C>id='DP12000', left=855, top=222, right=1066, bottom=288, align='right'</C>
	<C>id='DPXTOTAL', left=1066, top=222, right=1278, bottom=288, align='right', Dec=0</C>
	<L> left=21 ,top=214 ,right=2826 ,bottom=214 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='��' ,left=1278 ,top=143 ,right=1490 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=1066 ,top=143 ,right=1278 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð��ܼ���' ,left=855 ,top=143 ,right=1066 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��å����' ,left=643 ,top=143 ,right=855 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻��' ,left=431 ,top=143 ,right=643 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2373 ,top=143 ,right=2545 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=2201 ,top=143 ,right=2373 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���' ,left=2029 ,top=143 ,right=2201 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǰ�����' ,left=1857 ,top=143 ,right=2029 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=1685 ,top=143 ,right=1857 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ټ�' ,left=1513 ,top=143 ,right=1685 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����޾�' ,left=2588 ,top=108 ,right=2799 ,bottom=175 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2556 ,top=69 ,right=2556 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1500 ,top=69 ,right=1500 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2828 ,top=69 ,right=2828 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=643 ,top=140 ,right=643 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=855 ,top=143 ,right=855 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1066 ,top=143 ,right=1066 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1278 ,top=140 ,right=1278 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2201 ,top=140 ,right=2201 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2029 ,top=140 ,right=2029 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1685 ,top=140 ,right=1685 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1857 ,top=140 ,right=1857 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=19 ,top=66 ,right=2826 ,bottom=66 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='���޳���' ,left=945 ,top=77 ,right=1156 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1908 ,top=77 ,right=2119 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����������' ,left=93 ,top=360 ,right=270 ,bottom=426 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=19 ,top=434 ,right=2826 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1896 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=19 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=19 ,top=19 ,right=2826 ,bottom=98</T>
	<I>id='../../Common/img/icon.jpg' ,left=2466 ,top=3 ,right=2847 ,bottom=103</I>
</B>


">
</OBJECT>-->

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- ����� �޿�������Ȳ[����] --
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='�޿�������Ȳ_���ο�.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0' 
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=582 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=818 ,top=5 ,right=2133 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
			<L> left=32 ,top=228 ,right=2781 ,bottom=228 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='TODATEE', left=2580, top=132, right=2783, bottom=180, align='right' ,mask='XXXX.XX.XX', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='��  ��' ,left=45 ,top=241 ,right=246 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=360 ,right=2781 ,bottom=360 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=550 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��' ,left=201 ,top=373 ,right=246 ,bottom=421 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=373, right=204, bottom=421, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=373 ,right=164 ,bottom=421 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYYO', left=45, top=373, right=140, bottom=421, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='��' ,left=201 ,top=431 ,right=246 ,bottom=482 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=431, right=204, bottom=482, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=431 ,right=164 ,bottom=482 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=45, top=431, right=140, bottom=482, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='�����������' ,left=77 ,top=492 ,right=246 ,bottom=540 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=230 ,right=32 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=257 ,top=230 ,right=257 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=352 ,top=230 ,right=352 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='S91000', left=360, top=373, right=582, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S91000R-S91000}', left=360, top=492, right=582, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S91000R', left=360, top=431, right=582, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1680 ,top=294 ,right=1680 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=590 ,top=230 ,right=590 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2474 ,top=230 ,right=2474 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2781 ,top=230 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='Print Date:' ,left=2315 ,top=132 ,right=2577 ,bottom=180 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1   ���ο�' ,left=32 ,top=180 ,right=241 ,bottom=222 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1685 ,top=299 ,right=1894 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=929, top=13, right=1101, bottom=98, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<L> left=69 ,top=484 ,right=2781 ,bottom=484 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S94000', left=2487, top=373, right=2773, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S94000R-S94000}', left=2487, top=492, right=2773, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2487, top=431, right=2773, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='�ҵ漼' ,left=598 ,top=299 ,right=767 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���ο���' ,left=1132 ,top=299 ,right=1302 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ǰ�����' ,left=955 ,top=299 ,right=1124 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���� : ��' ,left=2580 ,top=180 ,right=2783 ,bottom=222 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='COUNTP', left=273, top=373, right=349, bottom=421, align='right'</C>
			<C>id='COUNTR', left=270, top=431, right=347, bottom=482, align='right'</C>
			<L> left=71 ,top=484 ,right=71 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=590 ,top=294 ,right=1680 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1677 ,top=294 ,right=1900 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='�ο�' ,left=270 ,top=241 ,right=347 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='{COUNTR-COUNTP}', left=270, top=492, right=347, bottom=540, align='right', Dec=0</C>
			<T>id='�����޾�' ,left=2487 ,top=241 ,right=2773 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=1188, top=13, right=1275, bottom=98, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<T>id='��' ,left=1278 ,top=13 ,right=1349 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='��' ,left=1103 ,top=13 ,right=1185 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<L> left=773 ,top=296 ,right=773 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=34 ,top=426 ,right=2781 ,bottom=426 </L>
			<L> left=953 ,top=296 ,right=953 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1127 ,top=296 ,right=1127 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1307 ,top=296 ,right=1307 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1487 ,top=296 ,right=1487 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S93000', left=1685, top=373, right=1894, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S93000R', left=1685, top=431, right=1894, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S93000R-S93000}', left=1685, top=492, right=1894, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='ȸ������' ,left=1905 ,top=238 ,right=2461 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1900 ,top=230 ,right=1900 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2265 ,top=294 ,right=2265 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='��' ,left=2270 ,top=299 ,right=2466 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1902 ,top=294 ,right=2294 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2270 ,top=294 ,right=2471 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='���뺸��' ,left=1910 ,top=299 ,right=2080 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='B23000', left=1910, top=373, right=2080, bottom=421, align='right'</C>
			<T>id='���纸��' ,left=2090 ,top=299 ,right=2260 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='B17000', left=2090, top=373, right=2260, bottom=421, align='right'</C>
			<C>id='B17000R', left=2090, top=431, right=2260, bottom=482, align='right'</C>
			<C>id='{B17000R-B17000}', left=2090, top=492, right=2260, bottom=540, align='right', Dec=0</C>
			<C>id='B23000R', left=1910, top=431, right=2080, bottom=482, align='right'</C>
			<C>id='{B23000R-B23000}', left=1910, top=492, right=2080, bottom=540, align='right', Dec=0</C>
			<T>id='���ް�' ,left=381 ,top=241 ,right=561 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='B23170', left=2270, top=373, right=2466, bottom=421, align='right'</C>
			<C>id='B23170R', left=2270, top=431, right=2466, bottom=482, align='right'</C>
			<C>id='{B23170R-B23170}', left=2270, top=492, right=2466, bottom=540, align='right', Dec=0</C>
			<T>id='��������' ,left=601 ,top=238 ,right=1886 ,bottom=288 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ֹμ�' ,left=778 ,top=299 ,right=947 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T11000', left=598, top=373, right=773, bottom=421, align='right'</C>
			<C>id='T11000R', left=598, top=429, right=773, bottom=479, align='right'</C>
			<C>id='{T11000R-T11000}', left=598, top=489, right=773, bottom=537, align='right', Dec=0</C>
			<C>id='T12000', left=778, top=373, right=953, bottom=421, align='right'</C>
			<C>id='B12000', left=1132, top=373, right=1307, bottom=421, align='right'</C>
			<C>id='B13000', left=1310, top=373, right=1484, bottom=421, align='right'</C>
			<C>id='T12000R', left=778, top=431, right=953, bottom=482, align='right'</C>
			<C>id='{T12000R-T12000}', left=778, top=492, right=953, bottom=540, align='right', Dec=0</C>
			<C>id='{BXTOTALR-BXTOTAL}', left=1490, top=495, right=1677, bottom=542, align='right', Dec=0</C>
			<C>id='BXTOTALR', left=1490, top=434, right=1677, bottom=484, align='right'</C>
			<C>id='BXTOTAL', left=1490, top=376, right=1677, bottom=423, align='right'</C>
			<C>id='B13000R', left=1310, top=431, right=1484, bottom=482, align='right'</C>
			<C>id='{B13000R-B13000}', left=1310, top=492, right=1484, bottom=540, align='right', Dec=0</C>
			<C>id='B12000R', left=1132, top=431, right=1307, bottom=482, align='right'</C>
			<C>id='{B12000R-B12000}', left=1132, top=492, right=1307, bottom=540, align='right', Dec=0</C>
			<C>id='B11000', left=955, top=373, right=1124, bottom=421, align='right'</C>
			<C>id='B11000R', left=955, top=431, right=1124, bottom=482, align='right'</C>
			<C>id='{B11000R-B11000}', left=955, top=492, right=1124, bottom=540, align='right', Dec=0</C>
			<T>id='��Ÿ' ,left=1492 ,top=299 ,right=1672 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���뺸��' ,left=1312 ,top=299 ,right=1482 ,bottom=349 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2082 ,top=296 ,right=2082 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='CTITLE', left=1363, top=13, right=2096, bottom=98, align='left', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		</B>
	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='�޿�������Ȳ_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=132 , DetailDataID='gcds_report1' 
			<B>id=default ,left=0,top=0 ,right=2871 ,bottom=418 ,face='Arial' ,size=10 ,penwidth=1
				<L> left=2257 ,top=148 ,right=2471 ,bottom=148 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<L> left=1902 ,top=148 ,right=2262 ,bottom=148 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<C>id='DB23170R', left=2265, top=286, right=2466, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{DB23170R-DB23170}', left=2265, top=347, right=2466, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<C>id='{DB17000R-DB17000}', left=2088, top=347, right=2257, bottom=394, align='right', Dec=0</C>
				<C>id='{DB23000R-DB23000}', left=1905, top=347, right=2074, bottom=394, align='right', Dec=0</C>
				<C>id='DB17000R', left=2088, top=286, right=2257, bottom=336, align='right'</C>
				<C>id='DB23000R', left=1905, top=286, right=2074, bottom=336, align='right'</C>
				<C>id='DB23170', left=2265, top=228, right=2466, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DB17000', left=2088, top=228, right=2257, bottom=275, align='right'</C>
				<C>id='DB23000', left=1905, top=228, right=2074, bottom=275, align='right'</C>
				<L> left=595 ,top=148 ,right=1672 ,bottom=148 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<C>id='{DBXTOTALR-DBXTOTAL}', left=1487, top=347, right=1672, bottom=394, align='right', Dec=0</C>
				<C>id='{DB13000R-DB13000}', left=1310, top=347, right=1479, bottom=394, align='right', Dec=0</C>
				<C>id='{DB12000R-DB12000}', left=1132, top=347, right=1302, bottom=394, align='right', Dec=0</C>
				<C>id='{DB11000R-DB11000}', left=953, top=347, right=1122, bottom=394, align='right', Dec=0</C>
				<C>id='{DT12000R-DT12000}', left=775, top=347, right=942, bottom=394, align='right', Dec=0</C>
				<C>id='DBXTOTALR', left=1487, top=286, right=1672, bottom=336, align='right'</C>
				<C>id='DB13000R', left=1310, top=286, right=1479, bottom=336, align='right'</C>
				<C>id='DB12000R', left=1132, top=286, right=1302, bottom=336, align='right'</C>
				<C>id='DB11000R', left=953, top=286, right=1122, bottom=336, align='right'</C>
				<C>id='DT12000R', left=775, top=286, right=942, bottom=336, align='right'</C>
				<C>id='DBXTOTAL', left=1487, top=228, right=1672, bottom=275, align='right'</C>
				<C>id='DB13000', left=1310, top=228, right=1479, bottom=275, align='right'</C>
				<C>id='DB12000', left=1132, top=228, right=1302, bottom=275, align='right'</C>
				<C>id='DB11000', left=953, top=228, right=1122, bottom=275, align='right'</C>
				<C>id='DT12000', left=775, top=228, right=942, bottom=275, align='right'</C>
				<T>id='��' ,left=2262 ,top=151 ,right=2466 ,bottom=201 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='���纸��' ,left=2085 ,top=151 ,right=2254 ,bottom=201 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=2260 ,top=148 ,right=2260 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<T>id='ȸ������' ,left=1910 ,top=93 ,right=2455 ,bottom=143 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=2080 ,top=148 ,right=2080 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='���뺸��' ,left=1908 ,top=151 ,right=2077 ,bottom=201 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='��������' ,left=598 ,top=95 ,right=1889 ,bottom=146 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=1675 ,top=148 ,right=1897 ,bottom=148 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<L> left=1900 ,top=85 ,right=1900 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=1482 ,top=151 ,right=1482 ,bottom=407 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<C>id='{DT11000R-DT11000}', left=598, top=347, right=767, bottom=394, align='right', Dec=0</C>
				<C>id='DT11000R', left=598, top=286, right=767, bottom=336, align='right'</C>
				<C>id='DT11000', left=598, top=228, right=767, bottom=275, align='right'</C>
				<T>id='���뺸��' ,left=1310 ,top=156 ,right=1479 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=1304 ,top=151 ,right=1304 ,bottom=407 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<L> left=1127 ,top=148 ,right=1127 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='���ް�' ,left=360 ,top=95 ,right=582 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='��Ÿ' ,left=1487 ,top=156 ,right=1672 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='��' ,left=1683 ,top=156 ,right=1892 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<C>id='{DS93000R-DS93000}', left=1683, top=347, right=1892, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<C>id='DS93000R', left=1683, top=286, right=1892, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{currow+1}', left=32, top=29, right=87, bottom=74, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<L> left=71 ,top=341 ,right=71 ,bottom=407 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<L> left=773 ,top=148 ,right=773 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<L> left=352 ,top=85 ,right=352 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<C>id='DS91000', left=357, top=228, right=579, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DS91000R', left=357, top=286, right=579, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{DS91000R-DS91000}', left=357, top=347, right=579, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<L> left=2781 ,top=87 ,right=2781 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<C>id='DS94000', left=2487, top=228, right=2773, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DS94000R', left=2487, top=286, right=2773, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{DS94000R-DS94000}', left=2487, top=347, right=2773, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<T>id='�����޾�' ,left=2487 ,top=95 ,right=2773 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=2474 ,top=87 ,right=2474 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=1675 ,top=148 ,right=1675 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<C>id='DS93000', left=1683, top=228, right=1892, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<L> left=947 ,top=148 ,right=947 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='���ο���' ,left=1132 ,top=156 ,right=1302 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='�ǰ�����' ,left=955 ,top=156 ,right=1124 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='�ҵ漼' ,left=598 ,top=156 ,right=767 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='�ֹμ�' ,left=778 ,top=156 ,right=945 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=593 ,top=87 ,right=593 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=32 ,top=87 ,right=32 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<T>id='�����������' ,left=77 ,top=347 ,right=246 ,bottom=394 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=405 ,right=2781 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=257 ,top=87 ,right=257 ,bottom=400 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<C>id='DCOUNTP', left=270, top=228, right=347, bottom=275, align='right'</C>
				<C>id='DCOUNTR', left=270, top=286, right=347, bottom=336, align='right'</C>
				<C>id='{DCOUNTR-DCOUNTP}', left=270, top=347, right=347, bottom=394, align='right', Dec=0</C>
				<L> left=71 ,top=339 ,right=2781 ,bottom=339 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='�ο�' ,left=270 ,top=95 ,right=347 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='.' ,left=138 ,top=286 ,right=164 ,bottom=336 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<C>id='DCMM', left=153, top=286, right=204, bottom=336, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='��' ,left=201 ,top=286 ,right=246 ,bottom=336 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=280 ,right=2781 ,bottom=280 </L>
				<C>id='DCYYYY', left=45, top=286, right=140, bottom=336, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DCYYYYO', left=45, top=228, right=140, bottom=275, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='.' ,left=138 ,top=228 ,right=164 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<C>id='DCMMO', left=153, top=228, right=204, bottom=275, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='��' ,left=201 ,top=228 ,right=246 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=214 ,right=2781 ,bottom=214 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<C>id='DEPTNM', left=93, top=29, right=606, bottom=74, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='��  ��' ,left=45 ,top=95 ,right=246 ,bottom=206 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=85 ,right=2781 ,bottom=85 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			</B>
	</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- �޿�������Ȳ[��] --
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print_2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='�޿�������Ȳ_���ο�.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0' 
		<B>id=DHeader ,left=0,top=0 ,right=2972 ,bottom=579 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=894 ,top=6 ,right=1919 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
			<L> left=31 ,top=228 ,right=2781 ,bottom=228 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='TODATEE', left=2581, top=131, right=2784, bottom=181, align='right' ,mask='XXXX.XX.XX', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='��  ��' ,left=44 ,top=241 ,right=247 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=359 ,right=2781 ,bottom=359 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=425 ,right=2781 ,bottom=425 </L>
			<L> left=34 ,top=550 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��' ,left=200 ,top=372 ,right=247 ,bottom=422 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=372, right=203, bottom=422, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=372 ,right=163 ,bottom=422 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYYO', left=44, top=372, right=141, bottom=422, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='��' ,left=200 ,top=431 ,right=247 ,bottom=481 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=431, right=203, bottom=481, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=431 ,right=163 ,bottom=481 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=44, top=431, right=141, bottom=481, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='�����������' ,left=78 ,top=491 ,right=247 ,bottom=541 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=31 ,top=231 ,right=31 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=256 ,top=231 ,right=256 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=353 ,top=231 ,right=353 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=563 ,top=294 ,right=563 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S93000', left=2244, top=372, right=2466, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000', left=1106, top=372, right=1328, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={S93000R-S93000}, left=2244, top=491, right=2466, bottom=541, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id={S91000R-S91000}, left=1106, top=491, right=1328, bottom=541, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S93000R', left=2244, top=431, right=2466, bottom=481, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000R', left=1106, top=431, right=1328, bottom=481, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2238 ,top=294 ,right=2238 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2056 ,top=294 ,right=2056 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1878 ,top=294 ,right=1878 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1522 ,top=294 ,right=1522 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1100 ,top=294 ,right=1100 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=919 ,top=294 ,right=919 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=741 ,top=294 ,right=741 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1338 ,top=231 ,right=1338 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2475 ,top=231 ,right=2475 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2781 ,top=231 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='Print Date:' ,left=2316 ,top=131 ,right=2578 ,bottom=181 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1   ���ο�' ,left=31 ,top=181 ,right=241 ,bottom=222 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2244 ,top=300 ,right=2466 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1106 ,top=300 ,right=1328 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���޳���' ,left=359 ,top=241 ,right=1328 ,bottom=291 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=1350 ,top=241 ,right=2466 ,bottom=291 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=963, top=12, right=1134, bottom=97, align='right', face='HY������M', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<L> left=69 ,top=484 ,right=2781 ,bottom=484 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S94000', left=2488, top=372, right=2772, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={S94000R-S94000}, left=2488, top=491, right=2772, bottom=541, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2488, top=431, right=2772, bottom=481, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='PXTOTAL', left=925, top=372, right=1094, bottom=422, align='right'</C>
			<C>id='P12000', left=747, top=372, right=916, bottom=422, align='right'</C>
			<C>id='P11000', left=569, top=372, right=738, bottom=422, align='right'</C>
			<C>id='PXTOTALR', left=925, top=431, right=1094, bottom=481, align='right'</C>
			<C>id='P12000R', left=747, top=431, right=916, bottom=481, align='right'</C>
			<C>id='P11000R', left=569, top=431, right=738, bottom=481, align='right'</C>
			<C>id='P10000R', left=359, top=431, right=559, bottom=481, align='right'</C>
			<C>id={PXTOTALR-PXTOTAL}, left=925, top=491, right=1094, bottom=541, align='right', Dec=0</C>
			<C>id={P12000R-P12000}, left=747, top=491, right=916, bottom=541, align='right', Dec=0</C>
			<C>id={P11000R-P11000}, left=569, top=491, right=738, bottom=541, align='right', Dec=0</C>
			<C>id={P10000R-P10000}, left=359, top=491, right=559, bottom=541, align='right', Dec=0</C>
			<T>id='���ټ�' ,left=1350 ,top=300 ,right=1519 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='' ,left=2063 ,top=300 ,right=2231 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=1884 ,top=300 ,right=2053 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���뺸��' ,left=1706 ,top=300 ,right=1875 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ֹμ�' ,left=1528 ,top=300 ,right=1697 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='', left=2063, top=491, right=2231, bottom=541, align='right', Dec=0</C>
			<C>id={BXTOTALR-BXTOTAL}, left=1884, top=491, right=2053, bottom=541, align='right', Dec=0</C>
			<C>id={B13000R-B13000},		left=1706, top=491, right=1875, bottom=541, align='right', Dec=0</C>
			<C>id={T12000R-T12000},		left=1528, top=491, right=1697, bottom=541, align='right', Dec=0</C>
			<C>id={T11000R-T11000},		left=1350, top=491, right=1519, bottom=541, align='right', Dec=0</C>
			<C>id='', left=2063, top=431, right=2231, bottom=481, align='right'</C>
			<C>id='BXTOTALR', left=1884, top=431, right=2053, bottom=481, align='right'</C>
			<C>id='B13000R', left=1706, top=431, right=1875, bottom=481, align='right'</C>
			<C>id='T12000R', left=1528, top=431, right=1697, bottom=481, align='right'</C>
			<C>id='T11000R', left=1350, top=431, right=1519, bottom=481, align='right'</C>
			<C>id='', left=2063, top=372, right=2231, bottom=422, align='right'</C>
			<C>id='BXTOTAL', left=1884, top=372, right=2053, bottom=422, align='right'</C>
			<C>id='B13000', left=1706, top=372, right=1875, bottom=422, align='right'</C>
			<C>id='T12000', left=1528, top=372, right=1697, bottom=422, align='right'</C>
			<C>id='T11000', left=1350, top=372, right=1519, bottom=422, align='right'</C>
			<T>id='���� : ��' ,left=2581 ,top=181 ,right=2784 ,bottom=222 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�⺻��' ,left=359 ,top=300 ,right=559 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��å����' ,left=569 ,top=300 ,right=738 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ð��ܼ���' ,left=747 ,top=300 ,right=916 ,bottom=350 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=925 ,top=300 ,right=1094 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='P10000', left=363, top=372, right=563, bottom=422, align='right'</C>
			<C>id='COUNTP', left=272, top=372, right=350, bottom=422, align='right'</C>
			<C>id='COUNTR', left=269, top=431, right=347, bottom=481, align='right'</C>
			<L> left=72 ,top=484 ,right=72 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=353 ,top=294 ,right=2466 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2238 ,top=294 ,right=2475 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='�ο�' ,left=269 ,top=241 ,right=347 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=294 ,right=1338 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id={COUNTR-COUNTP}, left=269, top=491, right=347, bottom=541, align='right', Dec=0</C>
			<T>id='�����޾�' ,left=2488 ,top=241 ,right=2772 ,bottom=350 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1700 ,top=294 ,right=1700 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='CMM', left=1222, top=12, right=1309, bottom=97, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<T>id='��' ,left=1313 ,top=12 ,right=1384 ,bottom=97 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<C>id='CTITLE', left=1416, top=12, right=1553, bottom=97, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<T>id='���� ��Ȳ' ,left=1556 ,top=12 ,right=1869 ,bottom=97 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='��' ,left=1138 ,top=12 ,right=1219 ,bottom=97 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
		</B>
	</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='�޿�������Ȳ_����ٹ���.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_report2' 
		<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=391 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=34 ,top=62 ,right=2781 ,bottom=62 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='2   ����ٹ���' ,left=31 ,top=9 ,right=353 ,bottom=56 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��  ��' ,left=44 ,top=75 ,right=247 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=194 ,right=2781 ,bottom=194 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='CYYYYO', left=44, top=206, right=141, bottom=256, align='right' ,mask='XXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='��' ,left=200 ,top=206 ,right=247 ,bottom=256 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=206, right=203, bottom=256, align='right' ,mask='XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=206 ,right=163 ,bottom=256 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=259 ,right=2781 ,bottom=259 </L>
			<T>id='�ο�' ,left=269 ,top=75 ,right=347 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=266, right=203, bottom=316, align='right' ,mask='XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=266 ,right=163 ,bottom=316 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=200 ,top=266 ,right=247 ,bottom=316 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=44, top=266, right=141, bottom=316, align='right' ,mask='XXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COUNTP', left=269, top=206, right=347, bottom=256, align='right'</C>
			<C>id='COUNTR', left=269, top=266, right=347, bottom=316, align='right'</C>
			<T>id='�����������' ,left=78 ,top=325 ,right=247 ,bottom=375 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2475 ,top=62 ,right=2475 ,bottom=381 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=256 ,top=62 ,right=256 ,bottom=381 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=384 ,right=2781 ,bottom=384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='���޳���' ,left=359 ,top=75 ,right=1328 ,bottom=125 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=353 ,top=128 ,right=2472 ,bottom=128 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�⺻��' ,left=359 ,top=134 ,right=550 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1106 ,top=134 ,right=1328 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=925 ,top=134 ,right=1094 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ð��ܼ���' ,left=738 ,top=134 ,right=916 ,bottom=184 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��å����' ,left=559 ,top=134 ,right=728 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=131 ,right=1100 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=31 ,top=62 ,right=31 ,bottom=381 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='P12000R', left=738, top=266, right=916, bottom=316, align='right'</C>
			<C>id={PXTOTALR-PXTOTAL}, left=925, top=325, right=1094, bottom=375, align='right', Dec=0</C>
			<C>id='PXTOTALR', left=925, top=266, right=1094, bottom=316, align='right'</C>
			<C>id='PXTOTAL', left=925, top=206, right=1094, bottom=256, align='right'</C>
			<L> left=1338 ,top=66 ,right=1338 ,bottom=384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1097 ,top=128 ,right=1338 ,bottom=128 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='S91000', left=1106, top=206, right=1328, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000R', left=1106, top=266, right=1328, bottom=316, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={S91000R-S91000}, left=1106, top=325, right=1328, bottom=375, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='��������' ,left=1350 ,top=75 ,right=2466 ,bottom=125 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=1884 ,top=134 ,right=2053 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���뺸��' ,left=1706 ,top=134 ,right=1875 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ֹμ�' ,left=1528 ,top=134 ,right=1697 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���ټ�' ,left=1350 ,top=134 ,right=1519 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T11000', left=1350, top=206, right=1519, bottom=256, align='right'</C>
			<C>id='T11000R', left=1350, top=266, right=1519, bottom=316, align='right'</C>
			<C>id={T11000R-T11000}, left=1350, top=325, right=1519, bottom=375, align='right', Dec=0</C>
			<C>id='', left=2063, top=206, right=2231, bottom=256, align='right'</C>
			<C>id='BXTOTAL', left=1884, top=206, right=2053, bottom=256, align='right'</C>
			<C>id='T12000', left=1528, top=206, right=1697, bottom=256, align='right'</C>
			<C>id='', left=2063, top=266, right=2231, bottom=316, align='right'</C>
			<C>id='BXTOTALR', left=1884, top=266, right=2053, bottom=316, align='right'</C>
			<C>id='T12000R', left=1528, top=266, right=1697, bottom=316, align='right'</C>
			<C>id='', left=2063, top=325, right=2231, bottom=375, align='right', Dec=0</C>
			<C>id={BXTOTALR-BXTOTAL}, left=1884, top=325, right=2053, bottom=375, align='right', Dec=0</C>
			<C>id={T12000R-T12000}, left=1528, top=325, right=1697, bottom=375, align='right', Dec=0</C>
			<L> left=1700 ,top=131 ,right=1700 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={B13000R-B13000}, left=1706, top=325, right=1875, bottom=375, align='right', Dec=0</C>
			<C>id='B13000R', left=1706, top=266, right=1875, bottom=316, align='right'</C>
			<C>id='B13000', left=1706, top=206, right=1875, bottom=256, align='right'</C>
			<L> left=1878 ,top=131 ,right=1878 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2056 ,top=131 ,right=2056 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='' ,left=2063 ,top=134 ,right=2231 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2238 ,top=131 ,right=2238 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='��' ,left=2244 ,top=134 ,right=2466 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={S93000R-S93000}, left=2244, top=325, right=2466, bottom=375, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S93000R', left=2244, top=266, right=2466, bottom=316, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S93000', left=2244, top=206, right=2466, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2238 ,top=128 ,right=2475 ,bottom=128 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='�����޾�' ,left=2488 ,top=75 ,right=2772 ,bottom=184 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={S94000R-S94000}, left=2488, top=325, right=2772, bottom=375, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2488, top=266, right=2772, bottom=316, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S94000', left=2488, top=206, right=2772, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2781 ,top=62 ,right=2781 ,bottom=384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='P12000', left=738, top=206, right=916, bottom=256, align='right'</C>
			<C>id='P11000', left=559, top=206, right=728, bottom=256, align='right'</C>
			<C>id='P11000R', left=559, top=266, right=728, bottom=316, align='right'</C>
			<C>id='P10000', left=359, top=206, right=550, bottom=256, align='right'</C>
			<C>id='P10000R', left=359, top=266, right=550, bottom=316, align='right'</C>
			<C>id={P12000R-P12000}, left=738, top=325, right=916, bottom=375, align='right', Dec=0</C>
			<C>id={P11000R-P11000}, left=559, top=325, right=728, bottom=375, align='right', Dec=0</C>
			<C>id={P10000R-P10000}, left=359, top=325, right=550, bottom=375, align='right', Dec=0</C>
			<L> left=72 ,top=319 ,right=2781 ,bottom=319 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=72 ,top=319 ,right=72 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=353 ,top=66 ,right=353 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1522 ,top=131 ,right=1522 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=919 ,top=131 ,right=919 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=731 ,top=131 ,right=731 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=553 ,top=131 ,right=553 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={COUNTR-COUNTP}, left=269, top=325, right=347, bottom=375, align='right', Dec=0</C>
		</B>
	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='�޿�������Ȳ_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_report1' 
		<B>id=default ,left=0,top=0 ,right=2869 ,bottom=431 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=31 ,top=94 ,right=2781 ,bottom=94 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��  ��' ,left=44 ,top=106 ,right=247 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DEPTNM', left=94, top=41, right=606, bottom=84, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=31 ,top=225 ,right=2781 ,bottom=225 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��' ,left=200 ,top=237 ,right=247 ,bottom=287 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DCMMO', left=153, top=237, right=203, bottom=287, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=237 ,right=163 ,bottom=287 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DCYYYYO', left=44, top=237, right=141, bottom=287, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DCYYYY', left=44, top=297, right=141, bottom=347, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=31 ,top=291 ,right=2781 ,bottom=291 </L>
			<T>id='��' ,left=200 ,top=297 ,right=247 ,bottom=347 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DCMM', left=153, top=297, right=203, bottom=347, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=297 ,right=163 ,bottom=347 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ο�' ,left=269 ,top=106 ,right=347 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=72 ,top=350 ,right=2781 ,bottom=350 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={DCOUNTR-DCOUNTP}, left=269, top=356, right=347, bottom=406, align='right', Dec=0</C>
			<C>id='DCOUNTR', left=269, top=297, right=347, bottom=347, align='right'</C>
			<C>id='DCOUNTP', left=269, top=237, right=347, bottom=287, align='right'</C>
			<L> left=353 ,top=159 ,right=2472 ,bottom=159 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�ð��ܼ���' ,left=738 ,top=166 ,right=916 ,bottom=216 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=925 ,top=166 ,right=1094 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=256 ,top=97 ,right=256 ,bottom=409 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=31 ,top=416 ,right=2781 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='�����������' ,left=78 ,top=356 ,right=247 ,bottom=406 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=31 ,top=97 ,right=31 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1338 ,top=97 ,right=1338 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��������' ,left=1350 ,top=106 ,right=2466 ,bottom=156 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1106 ,top=166 ,right=1328 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ֹμ�' ,left=1528 ,top=166 ,right=1697 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=159 ,right=1100 ,bottom=416 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='���ټ�' ,left=1350 ,top=166 ,right=1519 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2244 ,top=166 ,right=2466 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='' ,left=2063 ,top=166 ,right=2231 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���뺸��' ,left=1706 ,top=166 ,right=1875 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={DT12000R-DT12000}, left=1528, top=356, right=1697, bottom=406, align='right', Dec=0</C>
			<C>id='DT12000R', left=1528, top=297, right=1697, bottom=347, align='right'</C>
			<C>id='DB13000R', left=1706, top=297, right=1875, bottom=347, align='right'</C>
			<C>id={DB13000R-DB13000}, left=1706, top=356, right=1875, bottom=406, align='right', Dec=0</C>
			<T>id='��Ÿ' ,left=1884 ,top=166 ,right=2053 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DBXTOTAL', left=1884, top=237, right=2053, bottom=287, align='right'</C>
			<C>id='DBXTOTALR', left=1884, top=297, right=2053, bottom=347, align='right'</C>
			<C>id={DBXTOTALR-DBXTOTAL}, left=1884, top=356, right=2053, bottom=406, align='right', Dec=0</C>
			<C>id='', left=2063, top=237, right=2231, bottom=287, align='right'</C>
			<C>id='', left=2063, top=297, right=2231, bottom=347, align='right'</C>
			<C>id='', left=2063, top=356, right=2231, bottom=406, align='right', Dec=0</C>
			<L> left=1700 ,top=159 ,right=1700 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1878 ,top=159 ,right=1878 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2056 ,top=159 ,right=2056 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='DS93000', left=2244, top=237, right=2466, bottom=287, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DS93000R', left=2244, top=297, right=2466, bottom=347, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={DS93000R-DS93000}, left=2244, top=356, right=2466, bottom=406, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<L> left=2238 ,top=159 ,right=2238 ,bottom=416 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2475 ,top=97 ,right=2475 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2238 ,top=159 ,right=2475 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='�����޾�' ,left=2488 ,top=106 ,right=2772 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={DS94000R-DS94000}, left=2488, top=356, right=2772, bottom=406, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='DS94000R', left=2488, top=297, right=2772, bottom=347, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DS94000', left=2488, top=237, right=2772, bottom=287, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2781 ,top=97 ,right=2781 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id={DS91000R-DS91000}, left=1106, top=356, right=1328, bottom=406, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='DS91000R', left=1106, top=297, right=1328, bottom=347, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DS91000', left=1106, top=237, right=1328, bottom=287, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DPXTOTAL', left=925, top=237, right=1094, bottom=287, align='right'</C>
			<C>id='DPXTOTALR', left=925, top=297, right=1094, bottom=347, align='right'</C>
			<C>id={DPXTOTALR-DPXTOTAL}, left=925, top=356, right=1094, bottom=406, align='right', Dec=0</C>
			<C>id={DP12000R-DP12000}, left=738, top=356, right=916, bottom=406, align='right', Dec=0</C>
			<C>id='DP12000R', left=738, top=297, right=916, bottom=347, align='right'</C>
			<C>id='DP12000', left=738, top=237, right=916, bottom=287, align='right'</C>
			<C>id='DP11000', left=559, top=237, right=728, bottom=287, align='right'</C>
			<C>id='DP11000R', left=559, top=297, right=728, bottom=347, align='right'</C>
			<C>id={DP11000R-DP11000}, left=559, top=356, right=728, bottom=406, align='right', Dec=0</C>
			<C>id={DP10000R-DP10000}, left=359, top=356, right=550, bottom=406, align='right', Dec=0</C>
			<C>id='DP10000R', left=359, top=297, right=550, bottom=347, align='right'</C>
			<C>id='DP10000', left=359, top=237, right=550, bottom=287, align='right'</C>
			<C>id='DT12000', left=1528, top=237, right=1697, bottom=287, align='right'</C>
			<C>id='DT11000', left=1350, top=237, right=1519, bottom=287, align='right'</C>
			<C>id='DT11000R', left=1350, top=297, right=1519, bottom=347, align='right'</C>
			<C>id={DT11000R-DT11000}, left=1350, top=356, right=1519, bottom=406, align='right', Dec=0</C>
			<T>id='���޳���' ,left=359 ,top=106 ,right=1328 ,bottom=156 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�⺻��' ,left=359 ,top=166 ,right=550 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��å����' ,left=559 ,top=166 ,right=728 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=159 ,right=1338 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=353 ,top=94 ,right=353 ,bottom=419 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1522 ,top=159 ,right=1522 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=919 ,top=159 ,right=919 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=731 ,top=159 ,right=731 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=553 ,top=159 ,right=553 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=72 ,top=353 ,right=72 ,bottom=419 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={currow+2}, left=31, top=41, right=88, bottom=84, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='DB13000', left=1706, top=237, right=1875, bottom=287, align='right'</C>
		</B>
	</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- �ҼӺ� �޿����� ��Ȳ -->
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_report2">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=331 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CYYYY', left=492, top=3, right=733, bottom=90, align='right' ,mask='XXXX�� ', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CMM', left=736, top=3, right=1532, bottom=90, align='left' ,mask='XX�� �ҼӺ� �޿����� ��Ȳ', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=471 ,top=101 ,right=1529 ,bottom=101 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=143 ,right=1963 ,bottom=143 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=333 ,right=1963 ,bottom=331 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1966 ,top=146 ,right=1966 ,bottom=331 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=21 ,top=146 ,right=21 ,bottom=331 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=836 ,top=146 ,right=836 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1400 ,top=148 ,right=1400 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=963 ,top=238 ,right=963 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1550 ,top=148 ,right=1550 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Print Date:' ,left=1627 ,top=58 ,right=1823 ,bottom=119 ,align='right'</T>
	<C>id='TODATEE', left=1826, top=58, right=1969, bottom=119 ,mask='XXXX.XX.XX'</C>
	<T>id='���� : ��' ,left=1797 ,top=106 ,right=1969 ,bottom=167 ,align='right'</T>
	<T>id='��     ��' ,left=400 ,top=220 ,right=818 ,bottom=302 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='%' ,left=1423 ,top=220 ,right=1527 ,bottom=291 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=1614 ,top=217 ,right=1884 ,bottom=296 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�޿�����' ,left=945 ,top=175 ,right=1156 ,bottom=257 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=974 ,top=262 ,right=1378 ,bottom=331 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=847 ,top=259 ,right=953 ,bottom=331 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=836 ,top=235 ,right=1400 ,bottom=235 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=384 ,top=146 ,right=384 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=45 ,top=220 ,right=373 ,bottom=302 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1550 ,top=0 ,right=1550 ,bottom=69 </L>
	<L> left=963 ,top=0 ,right=963 ,bottom=69 </L>
	<L> left=836 ,top=0 ,right=836 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1966 ,top=0 ,right=1966 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='SCOUNT', left=844, top=8, right=958, bottom=69, align='right'</C>
	<L> left=21 ,top=0 ,right=21 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1400 ,top=0 ,right=1400 ,bottom=69 </L>
	<C>id='S94000SUM', left=974, top=8, right=1389, bottom=69, align='right'</C>
	<L> left=384 ,top=0 ,right=384 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,\'��  ��\',DEPTNM2)}', left=392, top=8, right=828, bottom=69, align='left'</C>
	<C>id='DEPTNM', left=34, top=8, right=376, bottom=69, align='left'</C>
	<C>id='PERRATE', left=1408, top=8, right=1540, bottom=69, align='right', supplevel=2</C>
	<L> left=26 ,top=69 ,right=1966 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=5 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=24 ,top=5 ,right=1963 ,bottom=5 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=2000 ,bottom=71 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=384 ,top=0 ,right=384 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1400 ,top=0 ,right=1400 ,bottom=69 </L>
	<L> left=21 ,top=0 ,right=21 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1966 ,top=0 ,right=1966 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=836 ,top=0 ,right=836 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=963 ,top=0 ,right=963 ,bottom=69 </L>
	<L> left=1550 ,top=0 ,right=1550 ,bottom=69 </L>
	<T>id='�� ��' ,left=101 ,top=5 ,right=312 ,bottom=69</T>
	<S>id='{SUM(SCOUNT)}' ,left=844 ,top=3 ,right=955 ,bottom=69 ,align='right'</S>
	<S>id='{SUM(S94000SUM)}' ,left=976 ,top=3 ,right=1389 ,bottom=69 ,align='right'</S>
	<S>id='{SUM(PERRATE)}' ,left=1408 ,top=3 ,right=1543 ,bottom=69 ,align='right'</S>
	<L> left=24 ,top=69 ,right=1963 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2770 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=13 ,top=19 ,right=1961 ,bottom=98</T>
	<I>id='../../Common/img/icon.jpg' ,left=1609 ,top=5 ,right=1990 ,bottom=101</I>
	<L> left=26 ,top=0 ,right=1974 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- �޿� ���� ��Ȳ -->
<comment id="__NSID__"><OBJECT id=gcrp_print3  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_grid_ec03az">
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="80">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=4100 ,bottom=616 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1516, top=6, right=2584, bottom=94, face='HY�߰���', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
	<L> left=0 ,top=237 ,right=3978 ,bottom=237 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=234 ,right=0 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=3981 ,top=234 ,right=3981 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=166 ,top=328 ,right=3981 ,bottom=328 </L>
	<L> left=1559 ,top=422 ,right=659 ,bottom=422 </L>
	<T>id='���ڱ�' ,left=3738 ,top=387 ,right=3863 ,bottom=453 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӿ���å' ,left=3606 ,top=387 ,right=3728 ,bottom=453 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ұ�' ,left=3475 ,top=387 ,right=3600 ,bottom=453 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻' ,left=1756 ,top=391 ,right=1872 ,bottom=472 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð���' ,left=2041 ,top=391 ,right=2153 ,bottom=472 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1594 ,top=391 ,right=1706 ,bottom=472 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ټ�' ,left=2166 ,top=362 ,right=2278 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2294 ,top=362 ,right=2409 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2428 ,top=362 ,right=2541 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2556 ,top=362 ,right=2669 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2819 ,top=362 ,right=2931 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2819 ,top=416 ,right=2931 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڰ�' ,left=2688 ,top=362 ,right=2803 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2688 ,top=416 ,right=2803 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2950 ,top=362 ,right=3066 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2950 ,top=416 ,right=3066 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư����' ,left=3084 ,top=362 ,right=3200 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=3084 ,top=416 ,right=3200 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ٹ�' ,left=3213 ,top=362 ,right=3338 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=3213 ,top=416 ,right=3338 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��å' ,left=1906 ,top=391 ,right=2019 ,bottom=472 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=2556 ,top=416 ,right=2669 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ξ��' ,left=2428 ,top=416 ,right=2541 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ߺ�' ,left=2294 ,top=416 ,right=2409 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2166 ,top=416 ,right=2278 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=669 ,top=431 ,right=731 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=738 ,top=431 ,right=881 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=891 ,top=431 ,right=956 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=963 ,top=431 ,right=1106 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=1116 ,top=431 ,right=1181 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=1188 ,top=431 ,right=1331 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=1341 ,top=431 ,right=1406 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=1413 ,top=431 ,right=1556 ,bottom=512 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1341 ,top=334 ,right=1556 ,bottom=416 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=1116 ,top=334 ,right=1331 ,bottom=416 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ի�' ,left=891 ,top=334 ,right=1106 ,bottom=416 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=669 ,top=334 ,right=881 ,bottom=416 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=491 ,top=387 ,right=656 ,bottom=469 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=419 ,top=387 ,right=481 ,bottom=469 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=172 ,top=387 ,right=234 ,bottom=469 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=3872 ,top=387 ,right=3969 ,bottom=453 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�հ�' ,left=6 ,top=531 ,right=159 ,bottom=616 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=0 ,top=237 ,right=172 ,bottom=519 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��������' ,left=2163 ,top=247 ,right=2575 ,bottom=328 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=0 ,top=616 ,right=3981 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=522 ,right=3981 ,bottom=522 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='����' ,left=9 ,top=441 ,right=109 ,bottom=516 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PRVYYYYMM', left=175, top=256, right=403, bottom=319, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NOWYYYYMM', left=422, top=256, right=653, bottom=319, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRVNUM', left=169, top=544, right=234, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A16_AMT', left=3738, top=544, right=3863, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A15_AMT', left=3603, top=544, right=3728, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A14_AMT', left=3472, top=544, right=3600, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A13_AMT', left=3341, top=544, right=3469, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A12_AMT', left=3209, top=544, right=3338, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A11_AMT', left=3078, top=544, right=3203, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A10_AMT', left=2947, top=544, right=3072, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A9_AMT', left=2816, top=544, right=2941, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A8_AMT', left=2684, top=544, right=2813, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A7_AMT', left=2553, top=544, right=2681, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A6_AMT', left=2422, top=544, right=2547, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A5_AMT', left=2291, top=544, right=2419, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A4_AMT', left=2159, top=544, right=2288, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A3_AMT', left=2031, top=544, right=2156, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A2_AMT', left=1891, top=544, right=2028, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A1_AMT', left=1744, top=544, right=1884, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AA_AMT', left=1569, top=544, right=1734, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGAMT', left=1413, top=544, right=1556, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGNUM', left=1341, top=544, right=1406, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAEAMT', left=1188, top=544, right=1331, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAENUM', left=1116, top=544, right=1181, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSAAMT', left=963, top=544, right=1106, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSANUM', left=891, top=544, right=956, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSAMT', left=738, top=544, right=881, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSNUM', left=669, top=544, right=731, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXAMT', left=491, top=544, right=656, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXNUM', left=419, top=544, right=481, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRVAMT', left=241, top=544, right=406, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���� : ��' ,left=3806 ,top=166 ,right=3978 ,bottom=228 ,align='right'</T>
	<C>id='TODATEE', left=3834, top=97, right=3978, bottom=159, align='right' ,mask='XXXX.XX.XX'</C>
	<T>id='Print Date:' ,left=3638 ,top=97 ,right=3831 ,bottom=159 ,align='right'</T>
	<T>id='�ݾ�' ,left=241 ,top=387 ,right=406 ,bottom=469 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=234 ,top=331 ,right=234 ,bottom=616 </L>
	<L> left=484 ,top=331 ,right=484 ,bottom=616 </L>
	<L> left=734 ,top=425 ,right=734 ,bottom=612 </L>
	<L> left=888 ,top=331 ,right=888 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1406 ,top=425 ,right=1406 ,bottom=612 </L>
	<L> left=1181 ,top=425 ,right=1181 ,bottom=612 </L>
	<L> left=959 ,top=425 ,right=959 ,bottom=612 </L>
	<L> left=166 ,top=237 ,right=166 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=663 ,top=237 ,right=663 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=413 ,top=237 ,right=413 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='����' ,left=66 ,top=247 ,right=159 ,bottom=328 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1738 ,top=331 ,right=1738 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1563 ,top=331 ,right=1563 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1338 ,top=331 ,right=1338 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1113 ,top=331 ,right=1113 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1888 ,top=328 ,right=1888 ,bottom=616 </L>
	<L> left=2028 ,top=328 ,right=2028 ,bottom=616 </L>
	<L> left=2156 ,top=328 ,right=2156 ,bottom=616 </L>
	<L> left=2288 ,top=328 ,right=2288 ,bottom=616 </L>
	<L> left=2419 ,top=328 ,right=2419 ,bottom=616 </L>
	<L> left=2550 ,top=328 ,right=2550 ,bottom=616 </L>
	<L> left=2681 ,top=328 ,right=2681 ,bottom=616 </L>
	<L> left=2813 ,top=328 ,right=2813 ,bottom=616 </L>
	<L> left=2944 ,top=328 ,right=2944 ,bottom=616 </L>
	<L> left=3075 ,top=328 ,right=3075 ,bottom=616 </L>
	<L> left=3206 ,top=328 ,right=3206 ,bottom=616 </L>
	<L> left=3338 ,top=328 ,right=3338 ,bottom=616 </L>
	<T>id='�ٹ�����' ,left=3344 ,top=416 ,right=3469 ,bottom=481 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    ��' ,left=3344 ,top=362 ,right=3469 ,bottom=431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3469 ,top=328 ,right=3469 ,bottom=616 </L>
	<L> left=3600 ,top=328 ,right=3600 ,bottom=616 </L>
	<L> left=3731 ,top=328 ,right=3731 ,bottom=616 </L>
	<L> left=3866 ,top=328 ,right=3866 ,bottom=616 </L>
</B>
<B>id=default ,left=0,top=0 ,right=4100 ,bottom=72 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=166 ,top=0 ,right=166 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=0 ,right=0 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=888 ,top=0 ,right=888 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='PAYGRDNM', left=6, top=6, right=159, bottom=66, align='left', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXNUM', left=419, top=6, right=481, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXAMT', left=491, top=6, right=656, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSNUM', left=669, top=6, right=731, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSAMT', left=738, top=6, right=881, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSANUM', left=891, top=6, right=956, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSAAMT', left=963, top=6, right=1106, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAENUM', left=1116, top=6, right=1181, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAEAMT', left=1188, top=6, right=1331, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGNUM', left=1341, top=6, right=1406, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGAMT', left=1413, top=6, right=1556, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A1_AMT', left=1744, top=6, right=1884, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AA_AMT', left=1569, top=6, right=1734, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3981 ,top=0 ,right=3981 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='PRVNUM', left=172, top=6, right=238, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=234 ,top=3 ,right=234 ,bottom=72 </L>
	<C>id='PRVAMT', left=241, top=6, right=406, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=413 ,top=0 ,right=413 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=484 ,top=0 ,right=484 ,bottom=69 </L>
	<L> left=663 ,top=0 ,right=663 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=734 ,top=0 ,right=734 ,bottom=69 </L>
	<L> left=959 ,top=0 ,right=959 ,bottom=69 </L>
	<L> left=1113 ,top=0 ,right=1113 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1181 ,top=0 ,right=1181 ,bottom=69 </L>
	<L> left=1338 ,top=0 ,right=1338 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1406 ,top=0 ,right=1406 ,bottom=69 </L>
	<L> left=1563 ,top=0 ,right=1563 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1738 ,top=0 ,right=1738 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1888 ,top=0 ,right=1888 ,bottom=69 </L>
	<C>id='A2_AMT', left=1891, top=6, right=2028, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A3_AMT', left=2031, top=6, right=2156, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2028 ,top=0 ,right=2028 ,bottom=69 </L>
	<L> left=2156 ,top=0 ,right=2156 ,bottom=69 </L>
	<C>id='A4_AMT', left=2159, top=6, right=2288, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2288 ,top=0 ,right=2288 ,bottom=69 </L>
	<C>id='A5_AMT', left=2291, top=6, right=2419, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2419 ,top=0 ,right=2419 ,bottom=69 </L>
	<C>id='A6_AMT', left=2422, top=6, right=2547, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2550 ,top=0 ,right=2550 ,bottom=69 </L>
	<C>id='A7_AMT', left=2553, top=6, right=2681, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2681 ,top=0 ,right=2681 ,bottom=69 </L>
	<C>id='A8_AMT', left=2684, top=6, right=2813, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=69 </L>
	<C>id='A9_AMT', left=2816, top=6, right=2941, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2944 ,top=0 ,right=2944 ,bottom=69 </L>
	<C>id='A10_AMT', left=2947, top=6, right=3072, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3075 ,top=0 ,right=3075 ,bottom=69 </L>
	<C>id='A11_AMT', left=3078, top=6, right=3203, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3206 ,top=0 ,right=3206 ,bottom=69 </L>
	<C>id='A12_AMT', left=3209, top=6, right=3338, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3338 ,top=0 ,right=3338 ,bottom=69 </L>
	<C>id='A13_AMT', left=3341, top=6, right=3469, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3469 ,top=0 ,right=3469 ,bottom=69 </L>
	<C>id='A14_AMT', left=3472, top=6, right=3600, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3600 ,top=0 ,right=3600 ,bottom=69 </L>
	<C>id='A15_AMT', left=3603, top=6, right=3728, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3731 ,top=0 ,right=3731 ,bottom=69 </L>
	<C>id='A16_AMT', left=3738, top=6, right=3863, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3866 ,top=0 ,right=3866 ,bottom=69 </L>
	<L> left=0 ,top=72 ,right=3981 ,bottom=72 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=4100 ,bottom=63 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=0 ,top=0 ,right=3981 ,bottom=0 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2770 ,right=4100 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=13 ,top=19 ,right=4069 ,bottom=97</T>
	<I>id='../../Common/img/icon.jpg' ,left=3697 ,top=0 ,right=4078 ,bottom=100</I>
	<L> left=25 ,top=0 ,right=4075 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����޿������� -->
<comment id="__NSID__"><OBJECT id=gcrp_print7  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_change_7">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=350 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=895 ,top=5 ,right=1917 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<C>id='CTITLE', left=924, top=13, right=1901, bottom=98, face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=11 ,top=208 ,right=2817 ,bottom=208 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='PRINTDT', left=2614, top=105, right=2817, bottom=153, align='right' ,mask='XXXX.XX.XX', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2351 ,top=105 ,right=2612 ,bottom=153 ,align='right' ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=208 ,right=11 ,bottom=351 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2817 ,top=208 ,right=2817 ,bottom=351 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�ڱ���' ,left=1132 ,top=282 ,right=1224 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ��ϼ�' ,left=558 ,top=219 ,right=732 ,bottom=279 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=356 ,right=2817 ,bottom=351 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='��������' ,left=1925 ,top=219 ,right=2588 ,bottom=279 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=63 ,top=211 ,right=63 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=208 ,top=211 ,right=208 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=332 ,top=211 ,right=332 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1922 ,top=211 ,right=1922 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2591 ,top=208 ,right=2591 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=556 ,top=279 ,right=729 ,bottom=279 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1925 ,top=279 ,right=2588 ,bottom=279 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=21 ,top=219 ,right=58 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=479 ,top=208 ,right=479 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�Ұ�' ,left=1798 ,top=282 ,right=1917 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=742 ,top=279 ,right=1925 ,bottom=279 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�����ұ�' ,left=2346 ,top=282 ,right=2459 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����(����)' ,left=2233 ,top=282 ,right=2343 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2462 ,top=282 ,right=2462 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2343 ,top=282 ,right=2343 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=282 ,right=2230 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2127 ,top=282 ,right=2127 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='�Ұ�' ,left=2464 ,top=282 ,right=2588 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=2762 ,top=219 ,right=2812 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2596 ,top=219 ,right=2757 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2759 ,top=208 ,right=2759 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�Ҽ�' ,left=68 ,top=219 ,right=208 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=213 ,top=219 ,right=332 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����(��/ȣ)' ,left=337 ,top=219 ,right=477 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=482 ,top=219 ,right=550 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=556 ,top=282 ,right=598 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=600 ,top=282 ,right=642 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ؿ�' ,left=645 ,top=282 ,right=687 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=690 ,top=282 ,right=732 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=553 ,top=208 ,right=553 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=598 ,top=282 ,right=598 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=642 ,top=282 ,right=642 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=687 ,top=282 ,right=687 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=737 ,top=211 ,right=737 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⺻��' ,left=737 ,top=282 ,right=853 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=853 ,top=282 ,right=853 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='��' ,left=856 ,top=282 ,right=948 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð���' ,left=950 ,top=282 ,right=1043 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ټӼ���' ,left=1045 ,top=282 ,right=1129 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1129 ,top=282 ,right=1129 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1224 ,top=282 ,right=1224 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=948 ,top=282 ,right=948 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1043 ,top=282 ,right=1043 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='���ϰ���' ,left=1409 ,top=282 ,right=1503 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���' ,left=1506 ,top=282 ,right=1598 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1503 ,top=282 ,right=1503 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='�������' ,left=1601 ,top=282 ,right=1690 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1925 ,top=282 ,right=2025 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ĵ�' ,left=2130 ,top=282 ,right=2230 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=2027 ,top=282 ,right=2127 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2025 ,top=282 ,right=2025 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='��Ÿ����' ,left=1693 ,top=282 ,right=1798 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڰݼ���' ,left=1319 ,top=282 ,right=1406 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ξ�' ,left=1227 ,top=282 ,right=1314 ,bottom=343 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1598 ,top=282 ,right=1598 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1690 ,top=282 ,right=1690 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1406 ,top=282 ,right=1406 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1314 ,top=282 ,right=1314 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='�������' ,left=737 ,top=219 ,right=1917 ,bottom=279 ,face='����' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1798 ,top=282 ,right=1798 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='���� : ��' ,left=2614 ,top=158 ,right=2817 ,bottom=200 ,align='right' ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='GUBUN', left=11, top=158, right=666, bottom=200, align='left', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


<B>id=default ,left=0,top=0 ,right=2870 ,bottom=68 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=11 ,top=0 ,right=11 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='P23000', left=1227, top=0, right=1314, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P28000', left=1319, top=0, right=1406, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P24000', left=1925, top=0, right=2025, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=63 ,top=0 ,right=63 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1314 ,top=0 ,right=1314 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2817 ,top=0 ,right=2817 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2462 ,top=0 ,right=2462 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=21, top=0, right=58, bottom=66, face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNMK2', left=68, top=0, right=208, bottom=66, align='left', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=208 ,top=0 ,right=208 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CHAGDT', left=213, top=0, right=332, bottom=66 ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=482, top=0, right=550, bottom=66, align='left', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2025 ,top=0 ,right=2025 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=0 ,right=2230 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P31000', left=2233, top=0, right=2343, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2343 ,top=0 ,right=2343 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P39000', left=2346, top=0, right=2459, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHG_SUM', left=2464, top=0, right=2588, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2591 ,top=0 ,right=2591 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2759 ,top=0 ,right=2759 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TOT_SUM', left=2596, top=0, right=2757, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORDNM2', left=2762, top=0, right=2812, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=11 ,top=69 ,right=2817 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=332 ,top=0 ,right=332 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=479 ,top=0 ,right=479 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=553 ,top=0 ,right=553 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='BSDAY', left=556, top=0, right=598, bottom=66 ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=598 ,top=3 ,right=598 ,bottom=69 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='HJDAY', left=600, top=0, right=642, bottom=66 ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=642 ,top=0 ,right=642 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='FSDAY', left=645, top=0, right=687, bottom=66 ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=687 ,top=0 ,right=687 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DAY_SUM', left=690, top=0, right=732, bottom=66 ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=737 ,top=0 ,right=737 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='P10000', left=737, top=0, right=853, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=853 ,top=0 ,right=853 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P11000', left=856, top=0, right=948, bottom=66, align='right' ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P12000', left=950, top=0, right=1043, bottom=66, align='right' ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P21000', left=1045, top=0, right=1129, bottom=66, align='right' ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1129 ,top=0 ,right=1129 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P22000', left=1132, top=0, right=1224, bottom=66, align='right' ,mask='XXXX/XX/XX', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1224 ,top=0 ,right=1224 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1043 ,top=0 ,right=1043 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=948 ,top=0 ,right=948 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1406 ,top=0 ,right=1406 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P29000', left=1409, top=0, right=1503, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P37000', left=1506, top=0, right=1598, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P27000', left=1601, top=0, right=1690, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P32000', left=2027, top=0, right=2127, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P35000', left=2130, top=0, right=2230, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2127 ,top=0 ,right=2127 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1922 ,top=0 ,right=1922 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='COM_SUM', left=1798, top=0, right=1917, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1798 ,top=0 ,right=1798 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1690 ,top=0 ,right=1690 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ETC_SUM', left=1693, top=0, right=1798, bottom=66, align='right', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYSEQ', left=337, top=34, right=477, bottom=69, align='left', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=337, top=0, right=477, bottom=34, align='left', face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

<B>id=Footer ,left=0 ,top=1892 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2818 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=11 ,right=2781 ,bottom=106</I>
</B>



">
</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
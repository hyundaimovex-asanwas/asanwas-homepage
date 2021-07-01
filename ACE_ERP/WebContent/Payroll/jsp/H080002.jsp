<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	���������
+ ���α׷� ID	: H080002.HTML
+ �� �� �� ��	: ��ȸ,����,����,���,����
+ �� �� �� ��	: �̼���  -- ������ȸ�κ� �߰�
+ �� �� �� ��	: 
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>���ߵ����⺻����</title>


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
get_cookdata();


gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_cdate = gcurdate.substring(0,4) + "/" + gcurdate.substring(5,7) + "/"+ gcurdate.substring(8,10);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_Before();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data0.DataID = "/servlet/Contract.h080002_s1?v_str1=&v_str2="
										+ "&v_str3=" + fn_trim(txt_gbn.value) 
										+ "&v_str4=" + gs_date ;
	gcds_data0.Reset();
}

/******************************************************************************
	Description : ����ȸ����
******************************************************************************/
function ln_Before(){
	//�����ڵ�
	gcds_people.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2032";
	gcds_people.Reset();

	//����븮��
	gcds_agency.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2033";
	gcds_agency.Reset();

	//����_���ߵ��� �ڵ�
	gcds_jobdty.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2036";
	gcds_jobdty.Reset();

	//����_���ߵ��� �ڵ�2 �׸���
	gcds_jobdty2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2036";
	gcds_jobdty2.Reset();

	//�Ҽ��ڵ�
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_dept.Reset();

	//�����ڵ�
	gcds_hdfamret.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	gcds_hdfamret.Reset();

	//�ڰ�������
	gcds_lcstype.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1127";
	gcds_lcstype.Reset();

}

/******************************************************************************
	Description : ����������ȸ[TAB 1]
******************************************************************************/
function ln_FamQuery() {
	gcds_data1.DataID = "/servlet/Contract.h080002_s3?"
									 + "v_str1=" + gcds_data0.namevalue(gcds_data0.rowposition,"empno");
	gcds_data1.Reset();
}

/******************************************************************************
	Description : ��»�����ȸ[TAB 2]
******************************************************************************/
function ln_CarQuery() {
	gcds_data2.DataID = "/servlet/Contract.h080002_s4?"
									 + "v_str1=" + gcds_data0.namevalue(gcds_data0.rowposition,"empno");
	gcds_data2.Reset();
}

/******************************************************************************
	Description : �系�����ȸ[TAB 3]
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

	gcds_data3.DataID = "/servlet/Contract.h080002_s5?"
									 + "v_str1=" + gcds_data0.namevalue(gcds_data0.rowposition,"empno");
	gcds_data3.Reset();
}

/******************************************************************************
	Description : �ڰ���������ȸ[TAB 4]
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

	gcds_data4.DataID = "/servlet/Contract.h080002_s6?"
									 + "v_str1=" + gcds_data0.namevalue(gcds_data0.rowposition,"empno");
	gcds_data4.Reset();
}

/******************************************************************************
	Description : �ް���ȸ[TAB 5]
******************************************************************************/
function ln_HolQuery() {

	if (gcds_lcstype.countrow<1) {
		//�ް�����
		var emp = gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO");
		gcds_data5.DataID = "/servlet/Contract.h080002_s2?v_str1=" + emp;
		gcds_data5.Reset();
	}

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(e){
	eval("gcds_data"+e).addrow();
	if (e=="0") {
		photo.src = "photo/00000.gif";
		gcds_data0.namevalue(gcds_data0.rowposition,"USESTS") = "1";
		gcds_data0.namevalue(gcds_data0.rowposition,"EMPDIV") = "5";
	} else if (e=="10")	eval("gcds_data"+e).namevalue(eval("gcds_data"+e).rowposition,"REQDT") = gs_date;
}

/******************************************************************************
	Description : �߰�[����/ü��]
******************************************************************************/
function ln_AssurAdd() {

	var row = gcds_hiassur.rowposition;

	var THeader = "EMPNO:String(7),HEIGHT:DECIMAL(3),WEIGHT:DECIMAL(3)";
	gcds_hiassur.SetDataHeader(THeader);
	
		for(i=1;i<gcds_data0.countrow;i++) {
	
			gcds_hiassur.addrow();

			gcds_hiassur.namevalue(i,"EMPNO")		= txt_empno.value;	//���
			gcds_hiassur.namevalue(i,"HEIGHT")	= gcem_height.text;	//����
			gcds_hiassur.namevalue(i,"WEIGHT")	= gcem_weight.text;	//ü��
		}

	if (gcds_hiassur.IsUpdated) {
		gctr_hiassur.KeyValue = "Contract.h080002_t3(I:USER=gcds_hiassur)";
		gctr_hiassur.Action = "/servlet/Contract.h080002_t3";
		//gctr_data.Parameters = "v_str1=" + gcurdate.substring(2,4);	
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(e){
	var obj = eval("gcds_data"+e);
	var empno = gcds_data0.namevalue(gcds_data0.rowposition,"empno");

	//prompt('',gcurdate.substring(2,4));
	if (!obj.IsUpdated ){
		alert("�����Ͻ� ������ �����ϴ�.");
	} else {
		if (confirm("�ش� �Է������� �����ϰڽ��ϱ� ?")) {
			if (e=="0") {	
			//prompt('',gcds_data0.text);
				gctr_data.KeyValue = "Contract.h080002_t1(I:USER=gcds_data0)";
				gctr_data.Action = "/servlet/Contract.h080002_t1";
				gctr_data.Parameters = "v_str1=" + gcurdate.substring(2,4);		
			} else if (e=="1") {
				gctr_data.KeyValue = "Contract.h080002_t3(I:USER=gcds_data1)";
				gctr_data.Action = "/servlet/Contract.h080002_t3";	//���� tr
				gctr_data.Parameters = "v_str1=" + empno;
			} else if (e=="2") {
				gctr_data.KeyValue = "Contract.h080002_t4(I:USER=gcds_data2)";
				gctr_data.Action = "/servlet/Contract.h080002_t4";	//��� tr
				gctr_data.Parameters = "v_str1=" + empno;
			} else if (e=="3") {
				gctr_data.KeyValue = "Contract.h080002_t6(I:USER=gcds_data3)";
				gctr_data.Action = "/servlet/Contract.h080002_t6";	//�系��� tr
				gctr_data.Parameters = "v_str1=" + empno;
			} else if (e=="4") {
				gctr_data.KeyValue = "Contract.h080002_t7(I:USER=gcds_data4)";
				gctr_data.Action = "/servlet/Contract.h080002_t7";	//�ڰ��� tr
				gctr_data.Parameters = "v_str1=" + empno;
			} else if (e=="5") {
				gctr_data.KeyValue = "Contract.h080002_t2(I:USER=gcds_data5)";
				gctr_data.Action = "/servlet/Contract.h080002_t2";	//�ް� tr
				gctr_data.Parameters = "v_str1=" + empno;
			} else {
				gctr_data.KeyValue = "Contract.h080002_t"+parseInt(e)+"(I:USER=gcds_data"+e+")";
				gctr_data.Action = "/servlet/Contract.h080002_t"+parseInt(e);
				gctr_data.Parameters = "v_str1=" + empno;
			}

			gctr_data.post();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(e){
	var obj = eval("gcds_data"+e);
	var row = obj.rowposition;
	if (obj.sysStatus(row)!="1")obj.deleterow(row);
	else obj.undo(row);
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

	if (gcds_data0.countrow<1) {
		alert("����Ͻ� ������ �����ϴ�");
	} else {
		var ls_msdata = gcds_data0.namevalue(gcds_data0.rowposition,"empno");		//���

		gcds_report0.ClearAll();

		gcds_report1.DataID = "/servlet/Contract.h080002_s3?v_str1=" + ls_msdata;	//��������[Tab 1]
		gcds_report1.Reset();

		gcds_report2.DataID = "/servlet/Contract.h080002_s4?v_str1=" + ls_msdata;	//��»���[Tab 2]
		gcds_report2.Reset();

		gcds_report3.DataID = "/servlet/Contract.h080002_s5?v_str1=" + ls_msdata;	//[�系���][Tab 3]
		gcds_report3.Reset();

		gcds_report4.DataID = "/servlet/Contract.h080002_s6?v_str1=" + ls_msdata;	//�ڰݻ���[Tab 4]
		gcds_report4.Reset();

		gcds_report5.DataID = "/servlet/Contract.h080002_s2?v_str1=" + ls_msdata;	//�ް�����[Tab 5]
		gcds_report5.Reset();

		gcds_report8.DataID = "/servlet/Contract.h080002_s0?v_str1=" + ls_msdata;	//����
		gcds_report8.Reset();

		var ls_temp = "";
		for (var i=1;i<=gcds_data0.countcolumn;i++) {
			if (i==1) ls_temp += gcds_data0.columnid(i) + ":" + gcds_data0.ColumnType(i);
			else {
				var col = gcds_data0.ColumnIndex(gcds_data0.columnid(i));
				col = gcds_data0.ColumnType(col)
				if (col==1) ls_temp += "," + gcds_data0.ColumnID(i) + ":STRING";
				else if (col==3) ls_temp += "," + gcds_data0.ColumnID(i) + ":DECIMAL";
				else if (col==5) ls_temp += "," + gcds_data0.ColumnID(i) + ":URL";
			}	
		}

		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();

		for (var k=1;k<=gcds_data0.countcolumn;k++) {
		 gcds_report0.namevalue(1,gcds_data0.columnid(k)) = gcds_data0.namevalue(gcds_data0.rowposition,gcds_data0.columnid(k));
		}

		ln_RptFor(ls_msdata);

		gcrp_print.preview();
	}

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	if (gcds_data0.countrow<1) alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
	else gcgd_disp.runexcel("�λ�߷��۾�");	
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
	Description : ��¹� ���� �ۼ�
******************************************************************************/
function ln_RptFor(e){
	var ls_for = "";

	ls_for += "<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=630 ,face='����' ,size=10 ,penwidth=1                                                                                                                           ";
	ls_for += "	<X>left=0 ,top=206	,right=336  ,bottom=527  ,border=true</X>                                                                                                                                                   ";
	//�⺻���� TXT BOX
	ls_for += "	<X>left=0 ,top=561	,right=116  ,bottom=689  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
	ls_for += "	<X>left=114 ,top=561	,right=1974 ,bottom=627	 ,border=true</X>                                                                                                                                                 ";
	ls_for += "	<X>left=114 ,top=624	,right=1974 ,bottom=689  ,border=true</X>                                                                                                                                                 ";
	//��    �� COL BOX
	ls_for += "	<X>left=518 ,top=206 ,right=1974 ,bottom=273 ,border=true</X>                                                                                                                                                   ";
	//��    �� COL BOX
	ls_for += "	<X>left=518 ,top=272 ,right=1974 ,bottom=340 ,border=true</X>                                                                                                                                                   ";
	//���ǹ�ȣ COL BOX
	ls_for += "	<X>left=518 ,top=333 ,right=1974 ,bottom=400 ,border=true</X>                                                                                                                                                   ";
	ls_for += "	<X>left=518 ,top=397 ,right=1974 ,bottom=463 ,border=true</X>                                                                                                                                                   ";
	ls_for += "	<X>left=518 ,top=460 ,right=1974 ,bottom=527 ,border=true</X>                                                                                                                                                   ";

	//ls_for += "	<X>left=114 ,top=688	,right=1974 ,bottom=754  ,border=true</X>                                                                                                                                                 ";
	//ls_for += "	<X>left=114 ,top=751	,right=1974 ,bottom=818  ,border=true</X>                                                                                                                                                 ";
	//ls_for += "	<X>left=114 ,top=815	,right=1974 ,bottom=881  ,border=true</X>                                                                                                                                                 ";
	//ls_for += "	<X>left=114 ,top=878	,right=1974 ,bottom=945  ,border=true</X>                                                                                                                                                 ";
	////�⺻���� �� �� ó TXT BOX
	////ls_for += "	<X>left=114 ,top=688  ,right=299 ,bottom=754  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	////�⺻���� ȣ    �� TXT BOX
	////ls_for += "	<X>left=114 ,top=751  ,right=299 ,bottom=818  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	////�⺻���� �系���� TXT BOX
	////ls_for += "	<X>left=114 ,top=815  ,right=299 ,bottom=879  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	////�⺻���� �� õ �� TXT BOX
	////ls_for += "	<X>left=114 ,top=878  ,right=299 ,bottom=945  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	////�⺻���� �系����/���� TXT BOX
	////ls_for += "	<X>left=725 ,top=815  ,right=910 ,bottom=881  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	////�⺻���� �� õ ��/���� TXT BOX
	////ls_for += "	<X>left=725 ,top=878  ,right=910 ,bottom=945  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	////�⺻���� ȣ��/���� TXT BOX
	///ls_for += "	<X>left=1304 ,top=751  ,right=1490 ,bottom=817  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	/////�⺻���� ��õ��/���� TXT BOX
	////ls_for += "	<X>left=1304 ,top=878  ,right=1490 ,bottom=945  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";

	//�⺻���� �߱����ּ� TXT BOX
	ls_for += "	<X>left=114		,top=561  ,right=333	,bottom=627  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	//�⺻�� TXT BOX
	ls_for += "	<X>left=1416	,top=561  ,right=1601 ,bottom=627  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
	//�⺻���� �����б��� TXT BOX
	ls_for += "	<X>left=114		,top=624  ,right=333	,bottom=689  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	//�⺻���� �����⵵ TXT BOX
	ls_for += "	<X>left=876		,top=624  ,right=1061 ,bottom=689  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	//�⺻���� �������� TXT BOX
	ls_for += "	<X>left=1416	,top=624  ,right=1601 ,bottom=689  ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";

	//��    �� TXT BOX
	ls_for += "	<X>left=333		,top=206	,right=519	,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
	//��   �� TXT BOX
	ls_for += "	<X>left=1416	,top=206	,right=1601 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	//���ǹ�ȣ TXT BOX
	ls_for += "	<X>left=333		,top=272	,right=519	,bottom=340 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
	//������� TXT BOX
	ls_for += "	<X>left=876		,top=272	,right=1061 ,bottom=334 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
	//�� �� �� TXT BOX
	ls_for += "	<X>left=333		,top=333	,right=519	,bottom=400 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
	//��    �� TXT BOX
	ls_for += "	<X>left=876		,top=333	,right=1061 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";	
	//��   �� TXT BOX
	ls_for += "	<X>left=1416	,top=333	,right=1601 ,bottom=398 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	//����븮�� TXT BOX
	ls_for += "	<X>left=333		,top=397	,right=519	,bottom=463 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
	//��ȭ��ȣ TXT BOX
	ls_for += "	<X>left=876		,top=397	,right=1061 ,bottom=461 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
	//����/ü�� TXT BOX
	ls_for += "	<X>left=1416	,top=397	,right=1601 ,bottom=461 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
	//���Ǹ����� TXT BOX
	ls_for += "	<X>left=333		,top=460	,right=519	,bottom=527 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
	//��    �� TXT BOX
	ls_for += "	<X>left=876		,top=460	,right=1061 ,bottom=527 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
	//����� TXT BOX
	ls_for += "	<X>left=1416 ,top=460		,right=1601 ,bottom=527 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";

	ls_for += "	<I>id='http://www.singiro.co.kr/servlet/Contract.h080002_s0?v_str1="+e+"' ,left=1 ,top=207 ,right=332 ,bottom=526</I>                                                                                   ";
	ls_for += "	<T>id='"+gs_cdate+"',		left=1688, top=156, right=1974, bottom=206, align='left' , face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                       ";
	ls_for += "	<C>id='EMPNMK',		left=529,		top=212, right=757,		bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                ";
	ls_for += "	<C>id='NMC',			left=762,		top=212, right=990,		bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   ";
	ls_for += "	<C>id='NME',			left=995,		top=212, right=1408,	bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  ";
	ls_for += "	<C>id='EMPNO',		left=1614,	top=212, right=1842,	bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               ";
	ls_for += "	<C>id='PASSPORT', left=529,		top=275, right=863,		bottom=331, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         ";
	ls_for += "	<C>id='PASSEDT',	left=529,		top=466, right=863,		bottom=521, align='left',	mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
	ls_for += "	<C>id='BIRDT',		left=1069,	top=275, right=1402,	bottom=331, align='left',	mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            ";
	ls_for += "	<C>id='TELNO',		left=1069,	top=402, right=1402,	bottom=458, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                 ";
	ls_for += "	<C>id='STRTDT',		left=529,		top=339, right=863,		bottom=394, align='left',	mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         ";
	ls_for += "	<C>id='PAYAMT',		left=1614,	top=566, right=1842,	bottom=622, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                ";
	
	//������-����
	//ls_for += "	<C>id='ENDDT', left=1609, top=466, right=1942, bottom=521, align='left' ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            ";

	//var c_dept = "";	�Ҽ�-����
	//ls_for += "<T>id='" + c_dept + "' ,left=1614 ,top=339 ,right=1842 ,bottom=394 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	//�߱����ּ�
	ls_for += "	<C>id='ADDRCHINA', left=343, top=566, right=1280, bottom=622, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                ";
	//�����б���
	ls_for += "	<C>id='LASTSCHNM', left=343, top=630, right=582, bottom=685, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                ";
	//�����⵵
	ls_for += "	<C>id='GRAYY', left=1069, top=630, right=1280, bottom=685, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                ";
	
	var ls_va00 ="";  //��������
	ls_va00 += gclx_edcgb.ValueByColumn("MINORCD",gclx_edcgb.ValueOfIndex("MINORCD",gclx_edcgb.Index),"MINORNM");
	ls_for += "	<T>id='"+ls_va00+"', left=1614, top=630, right=1842, bottom=685, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                ";
	
	var ls_va01 = ""; //����
	ls_va01 += gclx_jobkind.ValueByColumn("MINORCD",gclx_jobkind.ValueOfIndex("MINORCD",gclx_jobkind.Index),"MINORNM");
	ls_for += "	<T>id='"+ls_va01+"', left=1069, top=339, right=1402, bottom=394, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                 ";

	var ls_va02 = "";	//����븮��
	ls_va02 += gclx_agency.ValueByColumn("MINORCD", gclx_agency.ValueOfIndex("MINORCD", gclx_agency.Index), "MINORNM");
	ls_for += "	<T>id='"+ls_va02+"', left=529, top=402, right=863, bottom=458, align='left', , face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                ";

	var ls_va03 = ""; //����
	ls_va03 +=  gclx_people.ValueByColumn("MINORCD", gclx_people.ValueOfIndex("MINORCD", gclx_people.Index), "MINORNM");
	ls_for += "	<T>id='"+ls_va03+"', left=1069, top=466, right=1402, bottom=521, align='left' , face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>           ";

	var ls_va04 = "";	//����/���
	if (gcds_report0.namevalue(1,"GLDIV") =="1") ls_va04 = "����"; else ls_va04 = "���";
	ls_for += "	<T>id='"+ls_va04+"', left=1408, top=275, right=1741, bottom=331, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                               ";

	var ls_va05 = "";	//����
	if (gcds_report0.namevalue(1,"SEX") =="1") ls_va05 = " / ����"; else ls_va05 = " / ����";
	ls_for += "	<T>id='"+ls_va05+"', left=1478, top=275, right=1671, bottom=331, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                               ";

	var ls_height = gcds_report0.namevalue(1,"HEIGHT");	//����
//	ls_for += "	<C>id='HEIGHT'	, left=307	, top=1376, right=455	, bottom=1431, align='left' ,mask='XXX Cm', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>               ";
	ls_for += "	<T>id='" + ls_height + " Cm /'	, left=1614	, top=402, right=1842	, bottom=458, align='left' ,mask='XXX Cm', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>               ";

	var ls_weight = gcds_report0.namevalue(1,"WEIGHT");	//ü��
//	ls_for += "	<C>id='WEIGHT'	, left=468	, top=1376, right=616	, bottom=1431, align='left' ,mask='XXX Kg', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>               ";
	ls_for += "	<T>id='" + ls_weight + " Kg', left=1774	, top=402, right=2012	, bottom=458, align='left' ,mask='XXX Kg', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>               ";


	ls_for += "	<T>id='�� �� �� ��  �� �� �� ��' ,left=0 ,top=19 ,right=1974 ,bottom=122 ,face='HY�߰��' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                   ";
	ls_for += "	<T>id='�������� :'	,left=1453	,top=156 ,right=1691	,bottom=206 ,align='right' ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                          ";
	ls_for += "	<T>id='��  ��'			,left=339		,top=212 ,right=513		,bottom=267 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                              ";
	ls_for += "	<T>id='��  ��'			,left=1421	,top=212 ,right=1595	,bottom=267 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
	ls_for += "	<T>id='���ǹ�ȣ'		,left=339		,top=275 ,right=513		,bottom=331 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
	ls_for += "	<T>id='�������'		,left=881		,top=275 ,right=1056	,bottom=331 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
	ls_for += "	<T>id='�Ի���'			,left=339		,top=339 ,right=513		,bottom=394 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
	ls_for += "	<T>id='��  ��'			,left=881		,top=339 ,right=1056	,bottom=394 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
	ls_for += "	<T>id='��  ��'			,left=1421	,top=339 ,right=1595	,bottom=394 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
	ls_for += "	<T>id='����븮��'	,left=339		,top=402 ,right=513		,bottom=458 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
	ls_for += "	<T>id='��ȭ��ȣ'		,left=881		,top=402 ,right=1056	,bottom=458 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
	ls_for += "	<T>id='����/ü��'		,left=1421	,top=402 ,right=1595	,bottom=458 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
	ls_for += "	<T>id='���Ǹ�����'	,left=339		,top=466 ,right=513		,bottom=521 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                          ";
	ls_for += "	<T>id='��  ��'			,left=881		,top=466 ,right=1056	,bottom=521 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";		
	ls_for += "	<T>id='�����'			,left=1421	,top=466 ,right=1595	,bottom=521 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";

	ls_for += "	<T>id='�⺻'				,left=5			,top=570 ,right=111		,bottom=625 ,face='����' ,size=9 ,bold=true		,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                     ";
	ls_for += "	<T>id='����'				,left=5			,top=623 ,right=111		,bottom=679 ,face='����' ,size=9 ,bold=true		,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                     ";
	ls_for += "	<T>id='�߱����ּ�'	,left=145		,top=566 ,right=294		,bottom=622 ,face='����' ,size=9 ,bold=false	,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                              ";
	ls_for += "	<T>id='�⺻��'			,left=1421	,top=566 ,right=1595	,bottom=622 ,face='����' ,size=9 ,bold=false	,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";
	ls_for += "	<T>id='�����б���'	,left=145		,top=630 ,right=294		,bottom=685 ,face='����' ,size=9 ,bold=false	,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
	ls_for += "	<T>id='�����⵵'		,left=881		,top=630 ,right=1056	,bottom=685 ,face='����' ,size=9 ,bold=false	,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                              ";
	ls_for += "	<T>id='��������'		,left=1421	,top=630 ,right=1595	,bottom=685 ,face='����' ,size=9 ,bold=false	,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
	
	ls_for += "</B> ";

	gcrp_print.format = ls_for + gcrp_print.format;
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �������� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��»��� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �系��� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �ڰ��� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �ް� -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_people classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_agency classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobdty classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobdty2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hdfamret classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcstype classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����ü�� -->
<comment id="__NSID__"><OBJECT id=gcds_hiassur classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����Ʈ -->
<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����Ʈ �������� -->
<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����Ʈ ��»��� -->
<comment id="__NSID__"><OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����Ʈ �系��� -->
<comment id="__NSID__"><OBJECT id=gcds_report3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����Ʈ �ڰݻ��� -->
<comment id="__NSID__"><OBJECT id=gcds_report4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����Ʈ �ް����� -->
<comment id="__NSID__"><OBJECT id=gcds_report5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����Ʈ ���� -->
<comment id="__NSID__"><OBJECT id=gcds_report8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ����/ü�� -->
<comment id="__NSID__"><OBJECT id=gctr_hiassur classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_people" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data0" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_hdfamret" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data0" event="onloadCompleted(row,colid)">
	ft_cnt0.innerText = "��ȸ�Ǽ� : " + row + " ��";

	if (row > 0) {
		var emp = gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO");
		gcds_data1.DataID = "/servlet/Contract.h080002_s3?v_str1=" + emp;
		gcds_data1.Reset();

		//������ȸ �߰�
		if (gcds_data0.namevalue(1,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data0.namevalue(1,"empno");
			photo.src="/servlet/Contract.h080002_s0?v_str1="+str1;
		}
	} else {
		if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	}

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";

	var emp = gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO");
	gcds_data2.DataID = "/servlet/Contract.h080002_s4?v_str1=" + emp;
	gcds_data2.Reset();
	
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";

	var emp = gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO");
	gcds_data3.DataID = "/servlet/Contract.h080002_s5?v_str1=" + emp;	//7
	gcds_data3.Reset();
	
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";

	var emp = gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO");
	gcds_data4.DataID = "/servlet/Contract.h080002_s6?v_str1=" + emp;
	gcds_data4.Reset();
	
</script>

<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	ft_cnt4.innerText = "��ȸ�Ǽ� : " + row + " ��";

	var emp = gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO");
	gcds_data5.DataID = "/servlet/Contract.h080002_s2?v_str1=" + emp;	//3
	gcds_data5.Reset();

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data0" event="onRowPosChanged(row)">
	gcte_disp.ActiveIndex = 1;
	var emp = gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO");
	gcds_data1.DataID = "/servlet/Contract.h080002_s3?v_str1=" + emp;
	gcds_data1.Reset();
</script>

<script language="javascript" for="gcds_data5" event="onRowPosChanged(row)">
	if (gcds_data5.sysStatus(row)=="1") {
		gcgd_disp05.columnProp("STDYY","edit") = "";
		gcgd_disp05.columnProp("SEQ","edit") = "";
	} else {
		gcgd_disp05.columnProp("STDYY","edit") = "none";
		gcgd_disp05.columnProp("SEQ","edit") = "none";
	}
</script>

<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!=""){
		txt_file.value = gcip_file.value;
		photo.src = gcip_file.value;
		var tfile = txt_file.value;
		var tfilename = ln_Divide(txt_file.value, "\\");
		gcds_data0.namevalue(gcds_data0.rowposition,"PICTURE") = tfilename;
	}
</script>

<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">
		gcte_disp.ActiveIndex = 1;

		if (gcds_data0.namevalue(row,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data0.namevalue(row,"empno");
			photo.src="/servlet/Contract.h080002_s0?v_str1="+str1;
		}
</script>

<script language=JavaScript for=gcgd_disp event="onKeyPress()">
		gcte_disp.ActiveIndex = 1;
		var row = gcds_data0.rowposition;
		if (gcds_data0.namevalue(row,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data0.namevalue(row,"empno");
			photo.src="/servlet/Contract.h080002_s0?v_str1="+str1;
		}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	gcte_disp.ActiveIndex = 1;
	ln_Query();
</script>

<script language="javascript" for="gctr_data3" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	gcte_disp.ActiveIndex = 1;
	ln_Query();
</script>

<script language="javascript" for="gctr_data3" event="onfail()">
	alert("��û�Ͻ� �۾��� ���������� �������� ���߽��ϴ�.");
	gcte_disp.ActiveIndex = 1;
	ln_Query();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/h080002_head.gif"></td>
		<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img name="btn_print" src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print('00')">
			<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete('0')"> 
			<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Add('0')">
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save('0')">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			&nbsp;
		</td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0">
  <tr> 
		<td width="3px;"></td>
    <td valign=top	>
			<table border="0" cellspacing="0" cellpadding="0" style="border:1 solid #708090">
				<tr>
					<td class="tab12" style="width:80px;height:25px;" bgcolor="#eeeeee">�����</td>
					<td style="width:120px;"><input type="text" class="txt11" id="txt_gbn" style="width:80px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
				</tr>
			</table>
			<table border="0" cellspacing="0" cellpadding="0" style="position:relative;top:4px;border:0 solid #708090;border-left-width:1px;">
				<tr>
					<td style="border:1 solid #708090;border-left-width:0px;" colspan="2">
						<comment id="__NSID__"><OBJECT id="gcgd_disp"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:437;width:198" >
		            <param name=dataid					value=gcds_data0>
								<param Name=BorderStyle			value=0> 
								<param name=indwidth        value=0>
								<param name=fillarea        value=true>
								<param name=headlinecolor   value=#999999>
     						<param name=format          value='
									<C>ID={CURROW},	Name="NO"	 ,  width=30,  HeadBgColor=#B9D4DC,	HeadAlign=center, align=right</C>
									<C>ID=EMPNO		,	Name="���",  width=70,  HeadBgColor=#B9D4DC,	HeadAlign=center</C>
									<C>ID=EMPNMK	,	Name="����",  width=83,	 HeadBgColor=#B9D4DC,	HeadAlign=center</C>
								'>
						</OBJECT></comment><script>__ws__(__NSID__);</script><br>
						<fieldset style="width:201;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt0 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
		<td width="3px;"></td>
		<td width="672px">
			<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" style="border:1 solid #708090;border-bottom-width:0px">
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="tab21">
									<table border=0 cellpadding=0 cellspacing=0 width="125px">
										<tr><td class="tab13" style="height:100px;"><img id="photo" src="photo/00000.gif" border=0 width="85px" height="100px" style="position:relative;left:0px;top:-12px"></td></tr>
										<tr>
											<td class="tab13" style="height:26px;">
												<input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
											  <comment id="__NSID__"><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
									        style="position:relative;left:0px;top:0px;width:80; height:20;">
											      <param name="Text"		value="ã�ƺ���">
									          <param name="Enable"  value="true">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
								</td>
								<td valign="top">
									<table border=0 cellpadding=0 cellspacing=0>
										<tr>
											<td class="tab11" width="70px;" height="30px;" bgcolor="#eeeeee">����</td>
											<td class="tab21" width="300px">
												<input type="text" id="txt_nmk" class="txt11" style="width:80px;">
												<input type="text" id="txt_nmc" class="txt11" style="width:80px;">
												<input type="text" id="txt_nme" class="txt11" style="width:110px;">
											</td>
											<td class="tab11" width="70px;" bgcolor="#eeeeee">���</td>
											<td class="tab22" width="101px"><input type="text" id="txt_empno" class="txt11" style="width:80px;" readonly></td>
										</tr>
									</table>
									<table border=0 cellpadding=0 cellspacing=0>
										<tr>
											<td class="tab11" width="70px;" height="30px;" bgcolor="#eeeeee">�������</td>
											<td class="tab21" width="110px">
												<comment id="__NSID__"><OBJECT id=gcem_birdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" width="70px;" bgcolor="#eeeeee">����</td>
											<td class="tab21" width="118px">
												<comment id="__NSID__"><OBJECT id=gcra_sex classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
													style="position:relative;left:0px;top:0px;height:20;width:100;cursor:hand;">
														<param name=Cols     value="2">
														<param name=Format   value="1^����,2^����">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" width="70px;" bgcolor="#eeeeee">����</td>
											<td class="tab22" width="101px">
												<comment id="__NSID__"><OBJECT id=gclx_people classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_people">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^80">
														<param name=BindColumn			value=MINORCD>
			 									</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td class="tab11" height="30px;" bgcolor="#eeeeee">�Ի���</td>
											<td class="tab21" >
												<comment id="__NSID__"><OBJECT id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" bgcolor="#eeeeee">����</td>
											<td class="tab21" >
												<comment id="__NSID__"><OBJECT id=gclx_jobkind classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
														<param name=ComboDataID			value="gcds_jobdty">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^80">
														<param name=BindColumn			value=MINORCD>
			 									</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" bgcolor="#eeeeee">�⺻��</td>
											<td class="tab22" >
												<comment id="__NSID__"><OBJECT id=gcem_payamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:80px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=1>
														<param name=Numeric	      value=1>
														<param name=Maxlength     value=9>
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td class="tab11" height="30px;" bgcolor="#eeeeee">����븮��</td>
											<td class="tab21" >
												<comment id="__NSID__"><OBJECT id=gclx_agency classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:95px;">
														<param name=ComboDataID			value="gcds_agency">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^80">
														<param name=BindColumn			value=MINORCD>
			 									</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" bgcolor="#eeeeee">��ȭ��ȣ</td>
											<td class="tab21" ><input type="text" id="txt_telno" class="txt11" style="width:100px;"></td>
											<td class="tab11" bgcolor="#eeeeee">����/ü��</td>
											<td class="tab22" >
												<comment id="__NSID__"><OBJECT id=gcem_height classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:30px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=1>
														<param name=Numeric	      value=1>
														<param name=Maxlength     value=3>
										    </OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/
												<comment id="__NSID__"><OBJECT id=gcem_weight classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:30px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=1>
														<param name=Numeric	      value=1>
														<param name=Maxlength     value=3>
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td class="tab11" height="30px;" bgcolor="#eeeeee">���ǹ�ȣ</td>
											<td class="tab21" ><input type="text" id="txt_passport" class="txt11" style="width:100px;"></td>
											<td class="tab11" bgcolor="#eeeeee">���Ǹ�����</td>
											<td class="tab22" colspan="5">
												<comment id="__NSID__"><OBJECT id=gcem_passedt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td class="tab11" height="30px;" bgcolor="#eeeeee">�����б���</td>
											<td class="tab21" ><input type="text" id="txt_lastschnm" class="txt11" style="width:100px;"></td>
											<td class="tab11" bgcolor="#eeeeee">�����⵵</td>
											<td class="tab21" >
												<comment id="__NSID__"><OBJECT id=gcem_grayy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:30px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY">
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" bgcolor="#eeeeee">��������</td>
											<td class="tab22" >
												<comment id="__NSID__"><OBJECT id=gclx_edcgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:70px;">
														<param name=CBData					value="1^����^,2^����,3^����,4^����,5^����">
														<param name=CBDataColumns		value="minorcd,minornm">
														<param name=SearchColumn		value="minornm">
														<param name=ListExprFormat	value="minornm^0^70">								
														<param name=BindColumn			value="minorcd">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td class="tab11" height="30px;" bgcolor="#eeeeee">�߱����ּ�</td>
											<td class="tab22" colspan="5"><input type="text" id="txt_addrchina" class="txt11" style="width:450px;"></td>
										</tr>
									</table>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0">
				<tr><td height="5"></td></tr>
				<tr>
					<td>
						<comment id="__NSID__"><OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 
							style="width:660px;height:20px">
								<PARAM NAME="BackColor"					VALUE="#cccccc">
								<PARAM NAME="titleHeight"				VALUE="20px">
		            <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
								<PARAM NAME="Format"						VALUE="
									<T>divid=layer1  title='��������'</T>									
									<T>divid=layer2  title='��»���'</T>
								  <T>divid=layer3  title='�系���'</T>
								  <T>divid=layer4  title='�ڰݻ���'</T>
								  <T>divid=layer5  title='�ް�'</T>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td align=left>
						<div id="layer1" style="position:absolute;top:337px; left:377px; width:670px;">
							<table border="0" cellpadding="0" cellspacing="0" style="border:1 solid #708090">
								<tr>
									<td align=right>
										<img name="btn_del_1" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('1')">
										<img name="btn_add_1" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('1')">
										<img name="btn_save_1" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('1')">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td style="border:0 solid #708090;border-top-width:1px">
										<comment id="__NSID__"><OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:670;height:239;"><!-- �������� -->
						            <param name=dataid					value=gcds_data1>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
													<F> Name=NO ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC   Width=50, align=right </F> 
												 	<C> Name=����   ID=FAMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=120,	align=left</C> 
													<C> Name=����   ID=AGE			HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=center</C> 
													<C> Name=����   ID=CMPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=250,	align=left</C> 
													<C> Name=����   ID=REFCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=133,	align=left,		EditStyle=Lookup, Data="gcds_hdfamret:minorcd:minornm"</C> 
												'>
									  </OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:670;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<div id="layer2" style="position:absolute; top:337px; left:377px; width:670px; visibility:hidden">
							<table border="0" cellpadding="0" cellspacing="0" style="border:1 solid #708090">
								<tr>
									<td align=right>
										<img name="btn_del_2" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('2')">
										<img name="btn_add_2" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('2')">
										<img name="btn_save_2" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('2')">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td style="border:0 solid #708090;border-top-width:1px">
										<comment id="__NSID__"><OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:670;height:239;"><!-- ��»��� -->
						            <param name=dataid					value=gcds_data2>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
													<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=50, align=right </F> 
												 	<C> Name=ȸ���   ID=CAPLACE	HeadAlign=Center HeadBgColor=#B9D4DC Width=150,	align=left</C> 
													<C> Name=�ⰣFR		ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	align=center, Mask="XXXX/XX/XX"</C> 
													<C> Name=�ⰣTO		ID=ENDDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	align=center, Mask="XXXX/XX/XX"</C> 
													<C> Name=������ ID=DUTYNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=140,	align=left</C> 
													<C> Name=���			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=153,	align=left</C> 
												'>
									  </OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:670;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<div id="layer3" style="position:absolute; top:337px; left:377px; width:670px; visibility:hidden">
							<table border="0" cellpadding="0" cellspacing="0" style="border:1 solid #708090">
								<tr>
									<td align=right>
										<img name="btn_del_3" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('3')">
										<img name="btn_add_3" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('3')">
										<img name="btn_save_3" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('3')">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td style="border:0 solid #708090;border-top-width:1px">
										<comment id="__NSID__"><OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:670;height:239;"><!-- �系��� -->
						            <param name=dataid					value=gcds_data3>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
													<F> Name=NO			ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC   Width=50, align=right </F> 
												 	<C> Name=����� ID=ORDDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	align=center Mask="XXXX/XX/XX"</C> 
													<C> Name=�Ҽ�   ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=160,	align=left,	EditStyle=Lookup, Data="gcds_dept:deptcd:deptnm"</C> 
													<C> Name=����   ID=JOBKIND	HeadAlign=Center HeadBgColor=#B9D4DC Width=200,	align=left,	EditStyle=Lookup, Data="gcds_jobdty2:minorcd:minornm"</C>
													<C> Name=�⺻�� ID=BASICPAY	HeadAlign=Center HeadBgColor=#B9D4DC Width=163,	align=right</C> 
												'>
									  </OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:670;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt3 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<div id="layer4" style="position:absolute; top:337px; left:377px; width:670px; visibility:hidden">
							<table border="0" cellpadding="0" cellspacing="0" style="border:1 solid #708090">
								<tr>
									<td align=right>
										<img name="btn_del_4" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('4')">
										<img name="btn_add_4" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('4')">
										<img name="btn_save_4" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('4')">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td style="border:0 solid #708090;border-top-width:1px">
										<comment id="__NSID__"><OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:670;height:239;"><!-- �ڰݻ��� -->
						            <param name=dataid					value=gcds_data4>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
													<F> Name=NO			ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC   Width=50, align=right </F> 
												 	<C> Name=��������		ID=LCSTYPE	HeadAlign=Center HeadBgColor=#B9D4DC Width=400,	align=left,	EditStyle=Lookup, Data="gcds_lcstype:minorcd:minornm"</C> 
													<C> Name=�߱޳���� ID=GETDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=203,	align=center, Mask="XXXX/XX/XX"</C> 
												'>
									  </OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:670;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt4 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<div id="layer5" style="position:absolute; top:337px; left:377px; width:670px; visibility:hidden">
							<table border="0" cellpadding="0" cellspacing="0" style="border:1 solid #708090">
								<tr>
									<td align=right>
										<img name="btn_del_5" src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('5')">
										<img name="btn_add_5" src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('5')">
										<img name="btn_save_5" src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('5')">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td style="border:0 solid #708090;border-top-width:1px">
										<comment id="__NSID__"><OBJECT id=gcgd_disp05 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:670;height:239;"><!-- �ް����� -->
						            <param name=dataid					value=gcds_data5>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
													<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC   Width=50, align=right </F> 
												 	<C> Name=�ް���		ID=STDYY	HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=center</C> 
												 	<C> Name=ȸ��			ID=SEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=60,	align=center</C> 
												 	<C> Name=������		ID=FRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=center, Mask="XXXX/XX/XX"</C> 
												 	<C> Name=������		ID=ENDDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=center, Mask="XXXX/XX/XX"</C> 
													<C> Name=�ް����� ID=ETC		HeadAlign=Center HeadBgColor=#B9D4DC Width=243,	align=left</C> 
												'>
									  </OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:670;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt5 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<!-- <comment id="__NSID__"><OBJECT id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data3>
	<param name=BindInfo  value='
		<C>Col=JOBKIND		Ctrl=gclx_jobkind		Param=BindColVal</C>
'>
</OBJECT></comment><script>__ws__(__NSID__);</script> -->

<comment id="__NSID__"><OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data0>
	<param name=BindInfo  value='
		<C>Col=EMPNMK			Ctrl=txt_nmk				Param=Value</C>
		<C>Col=NMC				Ctrl=txt_nmc				Param=Value</C>
		<C>Col=NME				Ctrl=txt_nme				Param=Value</C>
		<C>Col=EMPNO			Ctrl=txt_empno			Param=Value</C>
		<C>Col=BIRDT			Ctrl=gcem_birdt			Param=Text</C>
		<C>Col=SEX				Ctrl=gcra_sex				Param=CodeValue</C>
		<C>Col=PEOPLE			Ctrl=gclx_people		Param=BindColVal</C>
		<C>Col=STRTDT			Ctrl=gcem_strtdt		Param=Text</C>
		<C>Col=JOBKIND		Ctrl=gclx_jobdty		Param=BindColVal</C>
		<C>Col=PAYAMT			Ctrl=gcem_payamt		Param=Text</C>
		<C>Col=AGENCY			Ctrl=gclx_agency		Param=BindColVal</C>
		<C>Col=TELNO			Ctrl=txt_telno			Param=Value</C>
		<C>Col=HEIGHT			Ctrl=gcem_height		Param=Text</C>
		<C>Col=WEIGHT			Ctrl=gcem_weight		Param=Text</C>
		<C>Col=PASSPORT		Ctrl=txt_passport		Param=Value</C>
		<C>Col=PASSEDT		Ctrl=gcem_passedt		Param=Text</C>
		<C>Col=LASTSCHNM	Ctrl=txt_lastschnm	Param=Value</C>
		<C>Col=GRAYY			Ctrl=gcem_grayy			Param=Text</C>
		<C>Col=EDCGB			Ctrl=gclx_edcgb			Param=BindColVal</C>
		<C>Col=ADDRCHINA	Ctrl=txt_addrchina	Param=Value</C>
		<C>Col=PICFILE 		Ctrl=txt_file				Param=Value</C>
		<C>Col=JOBKIND		Ctrl=gclx_jobkind		Param=BindColVal</C>
	'>
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

<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='family.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report1
		<B>id=DHeader	,left=0,top=0 ,right=2000 ,bottom=216 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=0			,top=159	,right=106	,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=159	,right=500	,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=500		,top=159	,right=753	,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=750		,top=159	,right=1602 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1601	,top=159	,right=1973 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=100 ,right=1691 ,bottom=159 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No'			,left=6			,top=162 ,right=100		,bottom=216 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'	,left=1606	,top=162 ,right=1972	,bottom=216 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'	,left=506		,top=162 ,right=747		,bottom=216 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'	,left=109		,top=162 ,right=500		,bottom=216 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'	,left=756		,top=162 ,right=1600	,bottom=216 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=62 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=0		,top=0		,right=0			,bottom=62 </L>
			<L> left=0		,top=62		,right=1972		,bottom=62 </L>
			<L> left=103	,top=0		,right=103		,bottom=62 </L>
			<L> left=500	,top=0		,right=500		,bottom=62 </L>
			<L> left=750	,top=0		,right=750		,bottom=62 </L>
			<L> left=1601	,top=0		,right=1601		,bottom=62 </L>
			<L> left=1972	,top=0		,right=1972		,bottom=62 </L>
			<C>id='{CURROW}'	,left=6			,top=6, right=100,	bottom=59, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FAMNM'			,left=109		,top=6, right=494,	bottom=59, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>			
			<C>id='AGE'				,left=506		,top=6, right=750,	bottom=59, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CMPNM'			,left=756		,top=6, right=1600, bottom=59, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left' </C>
			<C>id='REFNM'			,left=1609	,top=6, right=1969, bottom=59, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=165 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='career.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=162 ,DetailDataID=gcds_report2
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=219 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=0 ,top=91 ,right=1974 ,bottom=219 ,border=true</X>
			<X>left=0 ,top=91 ,right=106 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103 ,top=91 ,right=500 ,bottom=156 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103 ,top=153 ,right=291 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=288 ,top=153 ,right=500 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=498 ,top=91 ,right=944 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=941 ,top=91 ,right=1602 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1601 ,top=91 ,right=1974 ,bottom=219 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=28 ,right=1691 ,bottom=91 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ٹ��Ⱓ'	,left=109		,top=94		,right=466	,bottom=150 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='No'				,left=6			,top=94		,right=100	,bottom=212 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�Ի���'		,left=109		,top=159	,right=284	,bottom=212	,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�����'		,left=310		,top=159	,right=466	,bottom=212 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='ȸ���'		,left=475		,top=94		,right=938	,bottom=212 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������'	,left=947		,top=94		,right=1541 ,bottom=212 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��������'	,left=1601	,top=94		,right=1969	,bottom=212 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=56 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=1972 ,top=0	,right=1972 ,bottom=56 </L>
			<L> left=1601 ,top=0	,right=1601 ,bottom=56 </L>
			<L> left=941	,top=0	,right=941	,bottom=56 </L>
			<L> left=498	,top=0	,right=498	,bottom=56 </L>
			<L> left=288	,top=0	,right=288	,bottom=56 </L>
			<L> left=103	,top=0	,right=103	,bottom=56 </L>
			<L> left=0		,top=0	,right=0		,bottom=56 </L>
			<L> left=0		,top=59 ,right=1974 ,bottom=56 </L>
			<C>id='{CURROW}', left=6,			top=0, right=100,		bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FRDT',			left=109,		top=0, right=284,		bottom=56 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ENDDT',		left=291,		top=0, right=466,		bottom=56 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CAPLACE',	left=506,		top=0, right=938,		bottom=56, align='left',			face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DUTYNM',		left=947,		top=0, right=1541,	bottom=56, align='left',			face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK',		left=1609,	top=0, right=1969,	bottom=56, align='left',			face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>			
		</B>
	</R>
</A>


<A>id=Area5 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='hdcareer.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report3
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=150 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=0			,top=94 ,right=104 ,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=94 ,right=500	,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=499		,top=94 ,right=1116 ,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1116	,top=94 ,right=1601 ,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1600	,top=94 ,right=1974 ,bottom=150 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0		,top=31		,right=1691 ,bottom=91	,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No'						,left=6			,top=100	,right=100	,bottom=147 ,face='����'	,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�߷�����'			,left=208		,top=100	,right=399	,bottom=147 ,face='����'	,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'				,left=366		,top=100	,right=1109 ,bottom=147 ,face='����'	,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��'				,left=1122	,top=100	,right=1602 ,bottom=147 ,face='����'	,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� ��'			,left=1601	,top=100	,right=1968 ,bottom=147 ,face='����'	,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=59 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=0		,top=0	,right=0		,bottom=59 </L>
			<L> left=0		,top=60 ,right=1974 ,bottom=60 </L>
			<L> left=103	,top=0	,right=103	,bottom=59 </L>
			<L> left=499	,top=0	,right=499	,bottom=59 </L>			
			<L> left=1116 ,top=0	,right=1116 ,bottom=59 </L>
			<L> left=1600 ,top=0	,right=1600 ,bottom=59 </L>
			<L> left=1974 ,top=0	,right=1974 ,bottom=59 </L>
			<C>id='{CURROW}',		left=6,			top=0, right=100,		bottom=56, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ORDDT',			left=109,		top=0, right=494,		bottom=56 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DEPTNM',			left=506,		top=0, right=1113,	bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JOBKINDNM',	left=1122,	top=0, right=1647,	bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='BASICPAY',		left=1653,	top=0, right=1969,	bottom=56, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>


<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='license.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report4
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=142 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1421	,top=87 ,right=1974 ,bottom=144 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=87 ,right=1422 ,bottom=144 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=0			,top=87 ,right=104	,bottom=144 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=28 ,right=1691 ,bottom=87 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=6 ,top=94 ,right=100 ,bottom=144 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��������' ,left=109 ,top=94 ,right=1419 ,bottom=144 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�߱޳����' ,left=1428 ,top=94 ,right=1969 ,bottom=144 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=72 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=0		,top=0	,right=0		,bottom=69 </L>
			<L> left=0		,top=69 ,right=1972 ,bottom=69 </L>
			<L> left=103	,top=0	,right=103	,bottom=69 </L>
			<L> left=1422 ,top=0	,right=1422 ,bottom=69 </L>
			<L> left=1974 ,top=0	,right=1974 ,bottom=69 </L>
			<C>id='{CURROW}', left=6,			top=3, right=100,		bottom=66, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCSTNM',		left=109,		top=3, right=1419,	bottom=66, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='GETDT',		left=1428,	top=3, right=1969,	bottom=66 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>


<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='holiday.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=65 ,DetailDataID=gcds_report5
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=133 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=0			,top=84 ,right=104	,bottom=134 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103		,top=84 ,right=364	,bottom=134 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=363		,top=84 ,right=550	,bottom=134 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=549		,top=84 ,right=909	,bottom=134 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=908		,top=84 ,right=1278 ,bottom=134 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1277	,top=84 ,right=1974 ,bottom=134 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ��' ,left=0 ,top=25 ,right=1691 ,bottom=84 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No',					top=87,	left=6		,right=100	,bottom=134 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ް���',			top=87,	left=109	,right=359	,bottom=134 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ް�����',		top=87,	left=1284 ,right=1975 ,bottom=134 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������',			top=87,	left=916	,right=1275 ,bottom=134 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������',			top=87,	left=556	,right=909	,bottom=134 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='ȸ  ��',			top=87,	left=369	,right=547	,bottom=134 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=72 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=0			,top=0 ,right=0 ,bottom=69 </L>
			<L> left=0			,top=69 ,right=1975 ,bottom=69 </L>
			<L> left=103		,top=0 ,right=103 ,bottom=69 </L>
			<L> left=363		,top=0 ,right=363 ,bottom=69 </L>
			<L> left=549		,top=0 ,right=549 ,bottom=69 </L>
			<L> left=909		,top=0 ,right=909 ,bottom=69 </L>
			<L> left=1277		,top=0 ,right=1277 ,bottom=69 </L>
			<L> left=1974		,top=0 ,right=1974 ,bottom=69 </L>
			<C>id='{CURROW}', left=6,			top=0, right=100,		bottom=66, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='STDYY',		left=109,		top=0, right=359,		bottom=66 ,mask='XXXX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SEQ',			left=369,		top=0, right=547,		bottom=66 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FRDT',			left=556,		top=0, right=909,		bottom=66, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ENDDT',		left=916,		top=0, right=1274,	bottom=66 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ETC',			left=1284,	top=0, right=1974,	bottom=66, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>


<B>id=Footer ,left=0,top=2550 ,right=2000 ,bottom=2600 ,face='����' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1594 ,top=230 ,right=1974 ,bottom=330</I>
	<L> left=0 ,top=220	,right=1974 ,bottom=220, penstyle=solid, penwidth=2 </L>
	<T> id='#p/#t' left=0 ,top=230 ,right=1974 ,bottom=310</T>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>
 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
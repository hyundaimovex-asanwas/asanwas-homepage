<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: H030005.HTML
+ �� �� �� ��	: ��ȸ,���
+ �� �� �� ��	: 
+ �� �� �� ��	: 
------------------------------------------------------------------------------>

<html>
<head>
	<jsp:include page="/Sales/common/include/head.jsp"/>
<title>�λ������м�</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>
<Script language="javascript" src="../../Common/include/XChart.js"></script>
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
lfn_init();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+ "/" + gcurdate.substr(5,2)+ "/" + gcurdate.substr(8,2);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	cfInitXChart13(gcxc_chart1);
	cfInitXChart15(gcxc_chart2); //������

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "/servlet/Person.h030005_s1"
	gcds_data.Reset();
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

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

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
	var	row = gcds_data.rowposition;
	if (gcds_data.countrow<1) alert("����Ͻ� �ڷᰡ �����ϴ�");
	else {
		ln_Format();
		gcrp_print.preview();
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Format(){
	var ls_html = "";

	ls_html += "	<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=341 ,face='Arial' ,size=10 ,penwidth=1 ";
	ls_html += "		<X>left=0 ,top=222 ,right=2834 ,bottom=341 ,border=true, penstyle=solid ,penwidth=2</X> ";
	ls_html += "		<T>id='�� ��' ,left=5 ,top=249 ,right=410 ,bottom=315 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<L> left=410 ,top=222 ,right=410 ,bottom=341 </L> ";
	ls_html += "		<L> left=410 ,top=275 ,right=2650 ,bottom=275 </L> ";
	ls_html += "		<L> left=1190 ,top=116 ,right=1640 ,bottom=116 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L> ";
	ls_html += "		<T>id='�� �� �� �� �� ��' ,left=0 ,top=19 ,right=2834 ,bottom=115 ,face='HY�߰��' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='���س�� :' ,left=0 ,top=148 ,right=200 ,bottom=214 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
  ls_html += "		<T>id='" + gs_date.substring(0,4) + "�� " + gs_date.substring(4,6) + "�� " + "' ,left=200, top=148, right=553, bottom=214, align='left', face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
	ls_html += "		<L> left=550  ,top=275 ,right=550  ,bottom=341 </L> ";
	ls_html += "		<L> left=690  ,top=275 ,right=690  ,bottom=341 </L> ";
	ls_html += "		<L> left=830  ,top=275 ,right=830  ,bottom=341 </L> ";
	ls_html += "		<L> left=970  ,top=275 ,right=970  ,bottom=341 </L> ";
	ls_html += "		<L> left=1110 ,top=275 ,right=1110 ,bottom=341 </L> ";
	ls_html += "		<L> left=1250 ,top=275 ,right=1250 ,bottom=341 </L> ";
	ls_html += "		<L> left=1390 ,top=275 ,right=1390 ,bottom=341 </L> ";
	ls_html += "		<L> left=1530 ,top=222 ,right=1530 ,bottom=341 </L> ";
	ls_html += "		<L> left=1670 ,top=275 ,right=1670 ,bottom=341 </L> ";
	ls_html += "		<L> left=1810 ,top=275 ,right=1810 ,bottom=341 </L> ";
	ls_html += "		<L> left=1950 ,top=275 ,right=1950 ,bottom=341 </L> ";
	ls_html += "		<L> left=2090 ,top=275 ,right=2090 ,bottom=341 </L> ";
	ls_html += "		<L> left=2230 ,top=275 ,right=2230 ,bottom=341 </L> ";
	ls_html += "		<L> left=2370 ,top=275 ,right=2370 ,bottom=341 </L> ";
	ls_html += "		<L> left=2510 ,top=275 ,right=2510 ,bottom=341 </L> ";
	ls_html += "		<L> left=2650 ,top=222 ,right=2650 ,bottom=341 </L> ";
	ls_html += "		<T>id='�繫/������' ,left=410  ,top=222 ,right=1530  ,bottom=275 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='�����' ,left=1530  ,top=222 ,right=2650  ,bottom=275 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='�ӿ�' ,left=410  ,top=275 ,right=550  ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='����' ,left=550  ,top=275 ,right=690  ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='����' ,left=690  ,top=275 ,right=830  ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='����' ,left=830  ,top=275 ,right=970  ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='�븮' ,left=970  ,top=275 ,right=1110 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='���' ,left=1110 ,top=275 ,right=1250 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='��Ÿ' ,left=1250 ,top=275 ,right=1390 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='��'   ,left=1390 ,top=275 ,right=1530 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='�ӿ�' ,left=1530 ,top=275 ,right=1670 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='����' ,left=1670 ,top=275 ,right=1810 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='����' ,left=1810 ,top=275 ,right=1950 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='����' ,left=1950 ,top=275 ,right=2090 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='�븮' ,left=2090 ,top=275 ,right=2230 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='���' ,left=2230 ,top=275 ,right=2370 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='��Ÿ' ,left=2370 ,top=275 ,right=2510 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='��'   ,left=2510 ,top=275 ,right=2650 ,bottom=341 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "		<T>id='�հ�' ,left=2650 ,top=249 ,right=2834 ,bottom=315 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_html += "	</B> ";
	ls_html += "	<B>id=Default ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1 ";
	ls_html += "		<X>left=1390 ,top=0 ,right=1531 ,bottom=56 ,border=true, penstyle=solid ,penwidth=1, bgcolor=#cccccc</X> ";
	ls_html += "		<X>left=2510 ,top=0 ,right=2651 ,bottom=56 ,border=true, penstyle=solid ,penwidth=1, bgcolor=#cccccc</X> ";
	ls_html += "		<X>left=2650 ,top=0 ,right=2833 ,bottom=56 ,border=true, penstyle=solid ,penwidth=1, bgcolor=#b1b1b1</X> ";
	ls_html += "		<L>left=0 ,top=0 ,right=0 ,bottom=55 ,border=true, penstyle=solid ,penwidth=2</L> ";
	ls_html += "		<L>left=2833 ,top=0 ,right=2833 ,bottom=55 ,border=true, penstyle=solid ,penwidth=2</L> ";
	ls_html += "		<L>left=0 ,top=55,right=2833 ,bottom=55 ,border=true, penstyle=solid ,penwidth=1</L> ";
	ls_html += "		<L> left=410  ,top=0 ,right=410  ,bottom=55 </L> ";
	ls_html += "		<L> left=550  ,top=0 ,right=550  ,bottom=55 </L> ";
	ls_html += "		<L> left=690  ,top=0 ,right=690  ,bottom=55 </L> ";
	ls_html += "		<L> left=830  ,top=0 ,right=830  ,bottom=55 </L> ";
	ls_html += "		<L> left=970  ,top=0 ,right=970  ,bottom=55 </L> ";
	ls_html += "		<L> left=1110 ,top=0 ,right=1110 ,bottom=55 </L> ";
	ls_html += "		<L> left=1250 ,top=0 ,right=1250 ,bottom=55 </L> ";
	ls_html += "		<L> left=1390 ,top=0 ,right=1390 ,bottom=55 </L> ";
	ls_html += "		<L> left=1530 ,top=0 ,right=1530 ,bottom=55 </L> ";
	ls_html += "		<L> left=1670 ,top=0 ,right=1670 ,bottom=55 </L> ";
	ls_html += "		<L> left=1810 ,top=0 ,right=1810 ,bottom=55 </L> ";
	ls_html += "		<L> left=1950 ,top=0 ,right=1950 ,bottom=55 </L> ";
	ls_html += "		<L> left=2090 ,top=0 ,right=2090 ,bottom=55 </L> ";
	ls_html += "		<L> left=2230 ,top=0 ,right=2230 ,bottom=55 </L> ";
	ls_html += "		<L> left=2370 ,top=0 ,right=2370 ,bottom=55 </L> ";
	ls_html += "		<L> left=2510 ,top=0 ,right=2510 ,bottom=55 </L> ";
	ls_html += "		<L> left=2650 ,top=0 ,right=2650 ,bottom=55 </L> ";
	ls_html += "		<C>id='DEPTNM' ,left=10 ,top=0 ,right=410 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</C> ";
	ls_html += "		<C>id='T1'  ,left=410  ,top=0 ,right=550  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T2'  ,left=550  ,top=0 ,right=690  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T3'  ,left=690  ,top=0 ,right=830  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T4'  ,left=830  ,top=0 ,right=970  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T5'  ,left=970  ,top=0 ,right=1110 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T6'  ,left=1110 ,top=0 ,right=1250 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T7'  ,left=1250 ,top=0 ,right=1390 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T8'  ,left=1390 ,top=0 ,right=1530 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#cccccc</C> ";
	ls_html += "		<C>id='T9'  ,left=1530 ,top=0 ,right=1670 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T10' ,left=1670 ,top=0 ,right=1810 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T11' ,left=1810 ,top=0 ,right=1950 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T12' ,left=1950 ,top=0 ,right=2090 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T13' ,left=2090 ,top=0 ,right=2230 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T14' ,left=2230 ,top=0 ,right=2370 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T15' ,left=2370 ,top=0 ,right=2510 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C> ";
	ls_html += "		<C>id='T16' ,left=2510 ,top=0 ,right=2650 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#cccccc</C> ";
	ls_html += "		<C>id='T17' ,left=2650 ,top=0 ,right=2834 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</C> ";
	ls_html += "	</B> ";
	ls_html += "	<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1 ";
	ls_html += "		<X>left=0 ,top=0 ,right=2834 ,bottom=55 ,border=true, penstyle=solid ,penwidth=1, bgcolor=#b1b1b1</X> ";
	ls_html += "		<L>left=0 ,top=0 ,right=0 ,bottom=55 ,border=true, penstyle=solid ,penwidth=2</L> ";
	ls_html += "		<L>left=2833 ,top=0 ,right=2833 ,bottom=55 ,border=true, penstyle=solid ,penwidth=2</L> ";
	ls_html += "		<L>left=0 ,top=55,right=2833 ,bottom=55 ,border=true, penstyle=solid ,penwidth=1</L> ";
	ls_html += "		<L> left=410  ,top=0 ,right=410  ,bottom=55 </L> ";
	ls_html += "		<L> left=550  ,top=0 ,right=550  ,bottom=55 </L> ";
	ls_html += "		<L> left=690  ,top=0 ,right=690  ,bottom=55 </L> ";
	ls_html += "		<L> left=830  ,top=0 ,right=830  ,bottom=55 </L> ";
	ls_html += "		<L> left=970  ,top=0 ,right=970  ,bottom=55 </L> ";
	ls_html += "		<L> left=1110 ,top=0 ,right=1110 ,bottom=55 </L> ";
	ls_html += "		<L> left=1250 ,top=0 ,right=1250 ,bottom=55 </L> ";
	ls_html += "		<L> left=1390 ,top=0 ,right=1390 ,bottom=55 </L> ";
	ls_html += "		<L> left=1530 ,top=0 ,right=1530 ,bottom=55 </L> ";
	ls_html += "		<L> left=1670 ,top=0 ,right=1670 ,bottom=55 </L> ";
	ls_html += "		<L> left=1810 ,top=0 ,right=1810 ,bottom=55 </L> ";
	ls_html += "		<L> left=1950 ,top=0 ,right=1950 ,bottom=55 </L> ";
	ls_html += "		<L> left=2090 ,top=0 ,right=2090 ,bottom=55 </L> ";
	ls_html += "		<L> left=2230 ,top=0 ,right=2230 ,bottom=55 </L> ";
	ls_html += "		<L> left=2370 ,top=0 ,right=2370 ,bottom=55 </L> ";
	ls_html += "		<L> left=2510 ,top=0 ,right=2510 ,bottom=55 </L> ";
	ls_html += "		<L> left=2650 ,top=0 ,right=2650 ,bottom=55 </L> ";
	ls_html += "		<T>id='�հ�' ,left=10 ,top=0 ,right=410 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</T> ";
	ls_html += "		<S>id='Sum(T1)'  ,left=410  ,top=0 ,right=550  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T2)'  ,left=550  ,top=0 ,right=690  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T3)'  ,left=690  ,top=0 ,right=830  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T4)'  ,left=830  ,top=0 ,right=970  ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T5)'  ,left=970  ,top=0 ,right=1110 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T6)'  ,left=1110 ,top=0 ,right=1250 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T7)'  ,left=1250 ,top=0 ,right=1390 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T8)'  ,left=1390 ,top=0 ,right=1530 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T9)'  ,left=1530 ,top=0 ,right=1670 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T10)' ,left=1670 ,top=0 ,right=1810 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T11)' ,left=1810 ,top=0 ,right=1950 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T12)' ,left=1950 ,top=0 ,right=2090 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T13)' ,left=2090 ,top=0 ,right=2230 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T14)' ,left=2230 ,top=0 ,right=2370 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T15)' ,left=2370 ,top=0 ,right=2510 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T16)' ,left=2510 ,top=0 ,right=2650 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<S>id='Sum(T17)' ,left=2650 ,top=0 ,right=2834 ,bottom=55 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1</S> ";
	ls_html += "		<L> left=0 ,top=0 ,right=2833 ,bottom=0, penstyle=solid ,penwidth=2 </L> ";
	ls_html += "	</B> ";

	ls_html += "<B>id=Footer ,left=0,top=1950 ,right=2871 ,bottom=2100 ,face='����' ,size=10 ,penwidth=1 ";
	ls_html += "	<I>id='../../Common/img/icon.jpg' ,left=2450 ,top=0 ,right=2830 ,bottom=100</I>";
	ls_html += "	<L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2 </L> ";
	ls_html += "	<T> id='#p/#t' left=0 ,top=0 ,right=2834 ,bottom=100</T> ";
	ls_html += "</B>";

  gcrp_print.format = ls_html;
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
	<!-- <PARAM NAME="SortExpr"	VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chart classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	else {
		cfAddSeriesOne_1(gcxc_chart1, gcds_data.id, 31, "", "#00ff00", "DEPTNM", "T17" );

		var ls_ehtml = "";
		ls_ehtml += "CHKNM:STRING(30),CHKVAL:DECIMAL(5.0),COLOR:STRING(10)";
		gcds_data2.SetDataHeader(ls_ehtml);
		gcds_data2.addrow();
		gcds_data2.namevalue(1,"CHKNM") = "�繫/������ ";
		gcds_data2.namevalue(1,"CHKVAL") = gcds_data.NameSum("T8",0,gcds_data.countrow);
		gcds_data2.namevalue(1,"COLOR") = "blue";
		gcds_data2.addrow();
		gcds_data2.namevalue(2,"CHKNM") = "�����";
		gcds_data2.namevalue(2,"CHKVAL") = gcds_data.NameSum("T16",0,gcds_data.countrow);
		gcds_data2.namevalue(2,"COLOR") = "green";

		gcxc_chart2.Header.Alignment = 2;
		gcxc_chart2.Header.Font.Size=9;
		gcxc_chart2.Header.Text.Clear();
		gcxc_chart2.Header.Text.Add("������ ��Ȳ");

		gcxc_chart2.RemoveAllSeries();

		idx = gcxc_chart2.AddSeries(5);
		gcxc_chart2.Series(idx).Marks.Style = 1;
		gcxc_chart2.Series(idx).DataID = "gcds_data2";
		gcxc_chart2.Series(idx).YValueColumn = "CHKVAL";
		gcxc_chart2.Series(idx).XValueColumn = "CHKNM";
		gcxc_chart2.Series(idx).LabelColumn = "CHKNM";
		gcxc_chart2.Series(idx).ColorColumn = "COLOR";
		gcxc_chart2.Reset();
	}

</script>

<script language=JavaScript for=gcds_chart event=OnLoadCompleted(rowcnt)>
//	cfAddSeriesOne_1(gcxc_chart1, gcds_chart.id, 31, " man", "green", "ITEM_CODE", "mkt_rate" );
//	cfAddSeriesOne_1(gcxc_chart2, gcds_chart.id, 5, " man", "green", "ITEM_CODE", "mkt_rate" );
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">
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


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
		<td background="../../Common/img/com_t_bg.gif"><img src="../img/h030005_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><object id="gcgd_disp" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:260px;width:877px;border:1 solid #708090" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data">
					      <PARAM NAME="Editable"		VALUE="false">
						    <PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Indwidth"		VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="ViewSummary"	VALUE="1">
								<PARAM NAME="Format"			VALUE='  
									<C>Name="�ҼӸ�", ID=DEPTNM   width=197, HeadBgColor=#B9D4DC, sumText="�հ�", sumBgcolor="#FFDDEE"</C>
									<G> Name="�繫/������", HeadBgColor=#B9D4DC, align=center 
										<C>ID=T1, Name="�ӿ�", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T2, Name="����", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T3, Name="����", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T4, Name="����", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T5, Name="�븮", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T6, Name="���", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T7, Name="��Ÿ", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T8, Name="��",		width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE", bgcolor="#eef5f5" </C>
									</G>
									<G> Name="�����", HeadBgColor=#B9D4DC, align=center 
										<C>ID=T9,  Name="�ӿ�", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T10, Name="����", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T11, Name="����", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T12, Name="����", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T13, Name="�븮", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T14, Name="���", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T15, Name="��Ÿ", width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T16, Name="��",		width=39, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE", bgcolor="#eef5f5" </C>
									</G>
									<C>ID=T17,  Name="�հ�",	width=39, HeadBgColor=#B9D4DC, align=center, sumText={SUM(T8)+SUM(T16)}, sumBgcolor="#FFDDEE", bgcolor="#FFeeEE" </C>
								'>
						</object></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:879px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset><!--
						<comment id="__NSID__"><object id="gcgd_dd" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:260px;width:877px;border:1 solid #708090" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_chart">
					      <PARAM NAME="Editable"		VALUE="false">
						    <PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Indwidth"		VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="ViewSummary"	VALUE="1">
								<PARAM NAME="Format"			VALUE='  
									<C>Name="�ҼӸ�", ID=SALE_DATE   width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="�ҼӸ�", ID=ITEM_CODE   width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="�ҼӸ�", ID=SHOP_CODE   width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="�ҼӸ�", ID=BRAND_CODE  width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="�ҼӸ�", ID=MKT_RATE    width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="�ҼӸ�", ID=COMP_CODE   width=107, HeadBgColor=#B9D4DC</C>
								'>
						</object></comment><script>__ws__(__NSID__);</script>-->


					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr><td height=3></td></tr>  
	<tr>
		<td colspan=2>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style='height:30px;font-size:9pt;'>
				<tr>
					<td>
						<comment id="__NSID__"><OBJECT id=gcxc_chart2 style="width:340;height:220px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px"   
							classid=clsid:75B5421D-15E1-43FA-990D-C7847D1077F0 VIEWASTEXT>
					  </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
					<td>&nbsp;</td>
					<td>
  				  <comment id="__NSID__"><OBJECT id=gcxc_chart1 style="width:530;height:220px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px"   
							classid=clsid:75B5421D-15E1-43FA-990D-C7847D1077F0 VIEWASTEXT>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ�
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_data">
  <PARAM NAME="DetailDataID"			VALUE="gcds_data">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="1">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
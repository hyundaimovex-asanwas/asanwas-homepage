<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�/�������꺯���ڷ�
+ ���α׷� ID	: p030007.HTML
+ �� �� �� ��	: ��ȸ|���|����|����|
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: p050001_s1, p050001_s2, p050001_s3, p050001_s4
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�������꺯���ڷ�</title>
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
var gs_date2 = gcurdate.substr(0,4);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_yyyy01.Text=gs_date2;	//�Ƿ�� - �ͼӳ⵵
	gcem_yyyy02.Text=gs_date2;	//��α� - �ͼӳ⵵
	gcem_yyyy03.Text=gs_date2;	//�׸��߰� - �ͼӳ⵵
	gclx_relation.index = 0;		//�Ƿ�� - ����
	gclx_empchk.index = 0;			//�Ƿ�� - ���ο���
	gclx_paycd.index = 0;				//�׸��߰� - �׸��ڵ�

	var Obj="div_01";
	var div_cm=new Array("div_01","div_02","div_03");

  for(var i=0;i<=2;i++) {
    if(div_cm[i]==Obj) {
      eval("document.all."+Obj+".style.display='block';");
    } else {
      eval("document.all."+div_cm[i]+".style.display='none';");
    }
  }

	gcem_givdate.style.visibility = "hidden";

	gcds_givcod.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2040";
	gcds_givcod.Reset();

}

/******************************************************************************
	Description : ��ȸ 
******************************************************************************/
function ln_Query(gubun){
	eval("ln_Query_"+gubun+"();");
}

/******************************************************************************
	Description : ��ȸ - �Ƿ��
******************************************************************************/
function ln_Query_1(){

	var str1 = fn_trim(gcem_yyyy01.Text);		//�ͼӳ⵵
	var str2 = fn_trim(txt_empno01.value);	//���

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_s5?"
										 + "v_str1="  + str1
										 + "&v_str2=" + str2;
	//prompt('',gcds_data01.DataID);
	gcds_data01.Reset();

	ln_Enable("F1");
}

/******************************************************************************
	Description : ��ȸ - ��α�
******************************************************************************/
function ln_Query_2(){

	var str1 = fn_trim(gcem_yyyy02.Text);   //�ͼӳ⵵
	var str2 = fn_trim(txt_empno02.value);  //���

	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_s2?"
										 + "v_str1=" + str1
										 + "&v_str2=" + str2;
	gcds_data02.Reset();

	ln_Enable("F2");
}

/******************************************************************************
	Description : ����ȸ - (��α�)
******************************************************************************/
function ln_Query_4(e){

	var str1 = fn_trim(gcem_yyyy02.Text);   //�ͼӳ⵵

	gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_s4?"
										 + "v_str1=" + str1
										 + "&v_str2="+ e;
	gcds_data04.Reset();
}

/******************************************************************************
	Description : ��ȸ - �׸��߰�
******************************************************************************/
function ln_Query_3() {

	var str1 = fn_trim(gcem_yyyy03.Text);		//�ͼӳ⵵
	var str2 = fn_trim(txt_empno03.value);	//���
	var str3 = gclx_paycd3.BindColVal;			//�׸�

	gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_s3?"
										 + "v_str1="  + str1
										 + "&v_str2=" + str2
										 + "&v_str3=" + str3;
	gcds_data03.Reset();

	ln_Enable("F3");
}

/******************************************************************************
	Description : �߰� - �Ƿ��
******************************************************************************/
function ln_Insert_1(){   
	/*if(gcds_data01.countrow==0) {
	var THeader = 
					 "YYYY:STRING(4),"	         
					+"EMPNO:STRING(7),"   					
					+"INDNO:STRING(11),"   					
					+"INDNAME:STRING(100),"					
					+"CARDCNT:DECIMAL(9),"					
					+"CARDAMT:DECIMAL(9),"					
					+"CASHCNT:DECIMAL(9),"					
					+"CASHAMT:DECIMAL(9),"						
					+"RELATION:STRING(1),"								 
					+"JUMINNO:STRING(13),"
					+"EMPCHK:STRING(1)";

		gcds_data01.DataID = "";									  
		gcds_data01.SetDataHeader(THeader);				
		
	}
*/
	gcds_data01.addRow();

	gclx_relation.index = 0;	//����
	gclx_empchk.index = 0;		//���ο���

	ln_Enable("T1");
}

/******************************************************************************
	Description : �߰� - ��α�
******************************************************************************/
function ln_Insert_2(){   //��α�
	if(gcds_data02.countRow==0) {
	var THeader =   
					 "YYYY:STRING(4),"	
					+"EMPNO:STRING(7),"   
					+"EMPNMK:STRING(6),"   
					+"GIVDATE:STRING(6),"	
					+"GIVCOD:STRING(2),"	
					+"GIVTYPE:STRING(50),"	
					+"GIVGMOK:STRING(50),"	
					+"GIVJYO:STRING(50),"	
					+"GIVCOMP:STRING(100),"	
					+"GIVSAUP:STRING(11),"	
					+"GIVAMT:DECIMAL(9),"	
					+"GIVCNT:DECIMAL(2),"	
					+"GIVREF:STRING(100)";	
	
		gcds_data02.DataID = "";
		gcds_data02.SetDataHeader(THeader);
	}
	
	gcds_data02.addRow();
	ln_Enable("T2");
	
}

/******************************************************************************
	Description : �߰� - �׸��߰�
******************************************************************************/
function ln_Insert_3(){   //�׸��߰�
 
 if(gcds_data03.countRow==0){
	var THeader ="YYYY:STRING(4),"	
							+"EMPNO:STRING(7),"   
							+"PAYCD:STRING(8),"   
							+"PAYAMT:DECIMAL(9)";	

		gcds_data03.DataID = "";
		gcds_data03.SetDataHeader(THeader);
	}
	gcds_data03.addRow();
	ln_Enable("T3");
	
}

/******************************************************************************
	Description : ���� - �Ƿ��
******************************************************************************/
function ln_Save_1(){
	if (gcds_data01.IsUpdated) {
		if (ln_Valchk_1()) {
		//prompt('',gcds_data01.Text) ;

			if (confirm("����� ������ �����Ͻðڽ��ϱ�?")) {
				gctr_data01.KeyValue = "p030007_t5(I:USER=gcds_data01)";
				gctr_data01.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_t5";
				gctr_data01.post();
				//ln_Query_1();
			}
		}
	}
}

/******************************************************************************
	Description : ���� - ��α�
******************************************************************************/
function ln_Save_2(){
	if (gcds_data02.IsUpdated) {
		if (ln_Valchk_2()) {
			var row2 = gcds_data02.rowposition;
			var row4 = gcds_data04.rowposition;
			if (gcds_data02.SysStatus(gcds_data02.rowposition) == '1') {
				gcds_data02.namevalue(row2,"GIVDATE") = gcds_data04.namevalue(row4,"MAXDATE");
			}
			if (confirm("����� ������ �����Ͻðڽ��ϱ�?")) {
				gctr_data02.KeyValue = "p030007_t2(I:USER=gcds_data02)";
				gctr_data02.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_t2";
				gctr_data02.post();
				//ln_Query_2();
			}
		}
	}
}
/******************************************************************************
	Description : ���� - �׸��߰�
******************************************************************************/
function ln_Save_3(){
	if (gcds_data03.IsUpdated) {
		if (ln_Valchk_3()) {
			if (confirm("����� ������ �����Ͻðڽ��ϱ�?")) {
				gctr_data03.KeyValue = "p030007_t3(I:USER=gcds_data03)";
				gctr_data03.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_t3";
				gctr_data03.post();
				//ln_Query_3();
			}
		}
	}
}

/******************************************************************************
	Description : ���� - �Ƿ��
******************************************************************************/
function ln_Del_1(){
	if (gcds_data01.countRow>0) {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
			gcds_data01.deleterow(gcds_data01.rowposition);
			gctr_data01.KeyValue = "p030007_t5(I:USER=gcds_data01)";
			gctr_data01.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_t5";
			gctr_data01.post();
			//ln_Query_1()
		}
	}
}

/******************************************************************************
	Description : ���� - ��α�
******************************************************************************/
function ln_Del_2(){
	if (gcds_data02.countRow>0) {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
			gcds_data02.deleterow(gcds_data02.rowposition);
			gctr_data02.KeyValue = "p030007_t2(I:USER=gcds_data02)";
			gctr_data02.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_t2";
			gctr_data02.post();
			//ln_Query_2()
		}
	}
}

/******************************************************************************
	Description : ���� - �׸��߰�
******************************************************************************/
function ln_Del_3(){
	if (gcds_data03.countRow>0) {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
			gcds_data03.deleterow(gcds_data03.rowposition);
			gctr_data03.KeyValue = "p030007_t3(I:USER=gcds_data03)";
			gctr_data03.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030007_t3";
			gctr_data03.post();
			//ln_Query_3()
		}
	}
}

/******************************************************************************
	Description : �Է°� üũ - �Ƿ��
******************************************************************************/
function ln_Valchk_1(){
	if (fn_trim(gcem_yyyy11.text) == ""){
		alert("��Ȯ�� �ͼӳ⵵�� �Է��Ͻʽÿ�.");
		gcem_yyyy11.focus();
		return false;
	}

	if (fn_trim(txt_empnm01.value) == ""){
		alert("��Ȯ�� ������ �Է��Ͻʽÿ�.");
		return false;
	}

	if (fn_trim(gcem_indno.text) == ""){
		alert("��Ȯ�� ����ڹ�ȣ�� �Է��Ͻʽÿ�.");
		gcem_indno.focus();
		return false;
	}

	if (fn_trim(gcem_juminno.text) == ""){
		alert("��Ȯ�� �ֹι�ȣ�� �Է��Ͻʽÿ�.");
		gcem_juminno.focus();
		return false;
	}

		return true;
}

/******************************************************************************
	Description : �Է°� üũ - ��α�
******************************************************************************/
function ln_Valchk_2(){
	if (fn_trim(gcem_yyyy22.text) == ""){
		alert("��Ȯ�� �ͼӳ⵵�� �Է��Ͻʽÿ�.");
		gcem_yyyy22.focus();
		return false;
	}

	if (fn_trim(txt_empnm02.value) == ""){
		alert("��Ȯ�� ������ �Է��Ͻʽÿ�.");
		return false;
	}

	//if (fn_trim(gcem_givdate.text) == ""){
	//	alert("��Ȯ�� ��γ���� �Է��Ͻʽÿ�.");
	//	gcem_givdate.focus();
	//	return false;
	//}

	if (fn_trim(gclx_givcod.BindColVal) == ""){
		alert("��Ȯ�� �ڵ带 �Է��Ͻʽÿ�.");
		gclx_givcod.focus();
		return false;
	}
		return true;
}

/******************************************************************************
	Description : �Է°� üũ - �׸��߰�
******************************************************************************/
function ln_Valchk_3(){
	if (fn_trim(gcem_yyyy33.text) == ""){
		alert("��Ȯ�� �ͼӳ⵵�� �Է��Ͻʽÿ�.");
		gcem_yyyy11.focus();
		return false;
	}

	if (fn_trim(txt_empnm03.value) == ""){
		alert("��Ȯ�� ������ �Է��Ͻʽÿ�.");
		return false;
	}

	if (fn_trim(gclx_paycd.BindColVal) == ""){
		alert("��Ȯ�� �׸���� �����Ͻʽÿ�.");
		gclx_paycd.focus();
		return false;
	}
		return true;
}

/******************************************************************************
	Description : ���� ã�� [�˻�]
******************************************************************************/
function ln_Popup1(e,n){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="txt_empnm0"+n) { 
			eval("txt_empnm0"+n).value = arrParam[0];
			eval("txt_empno"+n+n).value = arrParam[1];

			if(e=="txt_empnm02") {
				ln_Query_4(txt_empno22.value);
			}
		}
	} else {
		eval(e).value = "";
		if (e=="txt_empnm0"+n) eval("txt_empno"+n+n).value = "";	
	}
}
/******************************************************************************
	Description :
******************************************************************************/
function ln_Date(sdate) {
  var ls_yy = sdate.substring(0,4);
  var ls_mm = sdate.substring(5,7);
  var ls_dd = sdate.substring(8,10);

	return ls_yy + ls_mm + ls_dd
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Time(stime) {
  var ls_hh = stime.substring(0,2);
  var ls_mm = stime.substring(3,5);
  var ls_ss = stime.substring(6,8);
	var ls_uu = stime.substring(9,10);

	return ls_hh + ls_mm + ls_ss + ls_uu
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Ltrim(src,arg) {
	if(src !=undefined)	{
		var li_chk = src.length/4+1;
		var ls_val = src;
		for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
		return ls_val;
	}
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_sTrim(src,arg) {
	if(src!=undefined)	{
		var li_chk = src.length/4+1;
		var ls_val = src;
		for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
		return ls_val;
	}
}

/*******************************************************************************
  Description : ���� - �Ƿ��
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : T A B ����
******************************************************************************/
function ln_visible_hidden(index){
	var div_cm=new Array("div_01","div_02","div_03");
  for(var i=0;i<=2;i++) {
    if(i==index) {
      eval("document.all."+div_cm[i]+".style.display='block';");
    } else {
      eval("document.all."+div_cm[i]+".style.display='none';");
    }
  }
}

/*******************************************************************************
  Description : Enable OR Disabled
******************************************************************************/
function ln_Enable(e){

	if (e == "T1") {
		gcem_yyyy11.enable = true;
		gcem_indno.enable  = true;
		gcem_juminno.enable = true;
	}else if (e == "F1") {
		gcem_yyyy11.enable = false;
		gcem_indno.enable  = false;
		gcem_juminno.enable = false;
	}else if (e == "T2") {
		gcem_yyyy22.enable  = true;
		//gcem_givdate.enable = true;
		gclx_givcod.enable  = true;
	}else if (e == "F2") {
		gcem_yyyy22.enable  = false;
		//gcem_givdate.enable = false;
		gclx_givcod.enable  = false;
	}else	if (e == "T3") {
		gcem_yyyy33.enable = true;
		gclx_paycd.enable  = true;
	}else if (e == "F3") {
		gcem_yyyy33.enable = false;
		gclx_paycd.enable  = false;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_select_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_ec02az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data01" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!-- �Ƿ�� -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data02" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!-- ��α� -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data04" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!-- ��α�[�������] -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data03" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!-- �׸��߰�-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_givcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!-- ��α� - �ڵ� -->
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_data01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�Ƿ�� TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gctr_data02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4"><!--��α� TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gctr_data03" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�׸��߰� TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<!-- <script language="javascript" for="gcds_data01" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if(gcds_data01.countrow <=0) alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script> -->

<script language=JavaScript  for=gcds_data01 event=OnLoadCompleted(rowcount)>

	if (rowcount>0)	;//''ln_Chk3();
  window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";
	
	if (rowcount ==0)	alert("�˻��� ����Ÿ�� �����ϴ�.");
</script>



<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ft_cnt2.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data02" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	gcds_row_ec02az =0;
	if(gcds_data02.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data03" event="OnLoadStarted()">
	ft_cnt3.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data03" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if(gcds_data03.countrow <=0) alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data04" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data04.countrow >0) {	
			var row2 = gcds_data02.rowposition;
			var row4 = gcds_data04.rowposition;
			gcds_data02.namevalue(row2,"GIVDATE") = gcds_data04.namevalue(row4,"MAXDATE");
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=ADE_Tab_1 event=OnSelChanged(index)>
	ln_visible_hidden((index-1));
</script>

<script language="javascript" for="gclx_givcod"	event="OnSelChange2()">
	txt_givtype.value = gclx_givcod.text;
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="OnSuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query_1();
	
</script>

<script language="javascript" for="gctr_data01" event="OnFail()">
	alert(gctr_data01.ErrorMsg);
	//alert("�ߺ��� ����Ÿ �Է����� ������ �߻��߽��ϴ�.");
</script>

<script language="javascript" for="gctr_data02" event="OnSuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
</script>

<script language="javascript" for="gctr_data02" event="OnFail()">
	alert("�ߺ��� ����Ÿ �Է����� ������ �߻��߽��ϴ�.");
</script>

<script language="javascript" for="gctr_data03" event="OnSuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
</script>

<script language="javascript" for="gctr_data03" event="OnFail()">
	alert("�ߺ��� ����Ÿ �Է����� ������ �߻��߽��ϴ�.");
</script>

</head>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/p030007_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2 ALIgn=LEFT>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
					<td width="0" align=RIGHT><NOBR>
						<comment id="__NSID__"><OBJECT id=ADE_Tab_1 classid=clsid:ED382953-E907-11D3-B694-006097AD7252   VIEWASTEXT style="width:660px;height:20px">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
							<PARAM NAME="titleHeight"				VALUE="20px">
							<PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
							<PARAM NAME="Format"						VALUE="
								<T>divid=div_01		title=�Ƿ��	</T>  
								<T>divid=div_02		title=��α�	</T>
								<T>divid=div_03		title=�׸��߰�</T>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
       </table>
			</td>
		</tr>
		<tr> 
  <td height=10></td>
  </tr>
  <tr> 
    <td COLSPAN=2>
<!--* [TAB] �Ƿ�� ***************************************************************************************-->
<div id="div_01" style="display:block">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
	  <td colspan=8 align=center>
        <table width="847" cellpadding="1" cellspacing="0" border="0"
			 style='border:1 solid #708090' >
	<tr> 
	        <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
					<nobr>&nbsp;�ͼӳ⵵&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_yyyy01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:40px; height:20px;" class=txtbox	validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment			value=0>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode			value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY">
        				<param name=MaxLength     value=4>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
            <td style="width:100px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
							<nobr>&nbsp;����&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-bottom-width:0px;border-right-width:0px;"><nobr>&nbsp;
							<input id="txt_empno01" type="text" style="position:relative;left:-5px;width:70px;" onKeydown="if(event.keyCode==13) ln_Query_1()">&nbsp;</nobr>
						</td>
   				  <td width="100%">&nbsp;
						</td>
            <td><nobr>      
							<!-- <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand"  onClick="ln_Excel_1();" > -->
							<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Del_1();" >
							<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Insert_1();" >
							<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand"	onClick="ln_Save_1();" >
							<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onClick="ln_Query(1);"></nobr>
						</td>
					</tr>
        </table>
      </td>
    </tr>
		<tr> 
			<td ALIGN=CENTER>
        <table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:847" ALIGN=LEFT VALIGN=TOP>
							<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec01az  style="WIDTH:566px;HEIGHT:360px;border:1 solid #777777;display:block;" viewastext>
								<PARAM NAME="DataID"          VALUE="gcds_data01">
								<PARAM NAME="Editable"				VALUE="false">
								<PARAM NAME="BorderStyle"			VALUE="0">
								<param name="Fillarea"				VALUE="true">
								<param name="SortView"				VALUE="left">
								<PARAM NAME="Format"          VALUE="  
									<C> Name='���'			ID=EMPNO   HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=CENTER sort=true</C> 
									<C> Name='����'			ID=EMPNMK  HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=CENTER sort=true</C> 
									<C> Name='�ֹι�ȣ' ID=RESINO1 HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=CENTER Mask='XXXXXX-XXXXXXX'</C> 
									<C> Name='�ּ�'			ID=ADDCA   HeadAlign=Center HeadBgColor=#B9D4DC Width=310 align=LEFT	</C> 
									">
								</OBJECT></comment><script>__ws__(__NSID__);</script>
								<fieldset id=ft_div1 style="width:568px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
									<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
								</fieldset>
              </td>
              <TD>
					<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:276px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
						<tr>
							<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӳ⵵&nbsp;</nobr></td>
							<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_yyyy11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:1px;top:1px; width:40px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY">
										<param name=MaxLength     value=4>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>                   
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
						<td colspan=3 Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_empnm01"  type='text'	 style="width:60px;position:relative;left:-5px;top:-1px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled>
						<input id="txt_empno11"  type="hidden" style="position:relative;left:-5px;width:70px;"><img src="../../Common/img/btn/com_b_find.gif" style="cursor:hand;position:relative;top:3px;left:-5px" alt="������ �˻��մϴ�" onclick="ln_Popup1('txt_empnm01',1)">&nbsp;</nobr>
						</td>
              </tr>
              <tr>
                <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����ڹ�ȣ&nbsp;</nobr></td>
                <td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_indno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:1px;top:1px; width:80px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00000000000">
										<param name=MaxLength     value=11>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;��ȣ&nbsp;</nobr></td>
								<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<input id="txt_indname" type="text" style="position:relative;left:-5px;width:170px">&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:35px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;����û�ڷ� <BR>&nbsp;�ſ�ī��Ǽ�&nbsp;</td>
								<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cardcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:1px;top:1px; width:25px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00">
										<param name=MaxLength     value=2>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
								<td style="height:35px;border:0 solid #708090;border-bottom-width:1px;border-left-width:1px;border-right-width:1px" bgcolor="#eeeeee"><nobr>&nbsp; �ݾ� &nbsp;</nobr></td>
								<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cardamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:1px;top:2px; width:75px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=Format        value="000,000,000">
										<param name=MaxLength     value=9>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:35px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����û�ڷ�<BR>&nbsp;���ݻ��Ǽ�&nbsp;</nobr></td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cashcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:1px;top:1px; width:25px;height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00">
										<param name=MaxLength     value=2>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
								<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-left-width:1px;border-right-width:1px" bgcolor="#eeeeee"><nobr>&nbsp; �ݾ� &nbsp;</nobr></td>
								<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cashamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:1px;top:2px; width:75px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=Format        value="000,000,000">
										<param name=MaxLength     value=9>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:35px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�׹����ڷ� <BR>&nbsp;�ſ�ī��Ǽ�&nbsp;</td>
								<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cardcntb classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:1px;top:1px; width:25px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00">
										<param name=MaxLength     value=2>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
								<td style="height:35px;border:0 solid #708090;border-bottom-width:1px;border-left-width:1px;border-right-width:1px" bgcolor="#eeeeee"><nobr>&nbsp; �ݾ� &nbsp;</nobr></td>
								<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cardamtb classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:1px;top:2px; width:75px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=Format        value="000,000,000">
										<param name=MaxLength     value=9>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:35px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�׹��� �ڷ�<BR>&nbsp;���ݻ��Ǽ�&nbsp;</nobr></td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cashcntb classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:1px;top:1px; width:25px;height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00">
										<param name=MaxLength     value=2>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
								<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-left-width:1px;border-right-width:1px" bgcolor="#eeeeee"><nobr>&nbsp; �ݾ� &nbsp;</nobr></td>
								<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_cashamtb classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:1px;top:2px; width:75px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=Format        value="000,000,000">
										<param name=MaxLength     value=9>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>


							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
								<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;<comment id="__NSID__"><object id=gclx_relation classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=156 width=110 style="position:relative;top:2px;" class="txtbox">
										<param name=CBData					value="0^����,1^�ҵ����� ��������,2^������� ��������,3^�����,4^������,5^�����ڸ�,6^��Ÿ">
										<param name=CBDataColumns		value="RELATION,RELATION_NM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="RELATION">
										<param name=ListExprFormat	value="RELATION_NM^0^120">
										<param name=BindColumn			value="RELATION">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>                   
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�ֹε�Ϲ�ȣ&nbsp;</nobr></td>
								<td  colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_juminno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							 style="position:relative;left:1px;top:1px; width:95px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="000000-0000000">
										<param name=MaxLength     value=14>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;���ο���&nbsp;</nobr></td>
								<td  colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gclx_empchk classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=110 style="position:relative;top:2px;" class="txtbox">
										<param name=CBData					value="1^����/���/���,2^�⺻���������">
										<param name=index						value="0">
										<param name=CBDataColumns		value="EMPCHK,EMPCHK_NM">
										<param name=sort						value="true">
										<param name=sortColumns			value="EMPCHK">
										<param name=ListExprFormat	value="EMPCHK_NM">
										<param name=BindColumn			value="EMPCHK">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>
						<tr><td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;</td></tr>
					</table>
        </TD>
      </tr>
    </table>
       </td>
      </tr>
    </table>
	</div>

<!--* [TAB] ��α� ***************************************************************************************-->
<div id="div_02" style="display:block">
<table width="875" cellpadding="1" cellspacing="0" border="0">
	<tr> 
		<td colspan=8 align=center>
			<table width="847" cellpadding="1" cellspacing="0" border="0" style='border:1 solid #708090' >
         <tr> 
						<td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӳ⵵&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yyyy02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:1px;top:1px; width:40px;height:20px;" class="txtbox">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY">
								<param name=MaxLength     value=4>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td> 
	          <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
						<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px;border-right-width:0px;"><nobr>&nbsp;
			    		<input id="txt_empno02" type="text" style="position:relative;left:-5px;width:70px;" onKeydown="if(event.keyCode==13) ln_Query_2()">&nbsp;</nobr>
						</td>
   					<td width="100%">&nbsp;</td>
   					<td width=100%>&nbsp;
							<comment id="__NSID__"><object id=inp_File_2 classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 
						style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
								<param name="Text"		value='ã�ƺ���'>
								<param name="Enable"	value="True">
							</object></td>
						<td><nobr>      
						<!-- <img src="../../Common/img/btn/com_b_download.gif"	style="cursor:hand"		onClick="ln_FileOpen_2();" >
						<img src="../../Common/img/btn/com_b_excel.gif"			style="cursor:hand"		onClick="ln_Excel_2();" > -->
						<img src="../../Common/img/btn/com_b_delete.gif"		style="cursor:hand"		onClick="ln_Del_2();" >
						<img src="../../Common/img/btn/com_b_insert.gif"		style="cursor:hand"		onClick="ln_Insert_2();" >
						<img src="../../Common/img/btn/com_b_save.gif"			style="cursor:hand"		onClick="ln_Save_2();">
						<img src="../../Common/img/btn/com_b_query.gif"			style="cursor:hand"		onClick="ln_Query(2);" ></nobr></td>
         </tr>
        </table>
      </td>
    </tr>
    <tr>
			<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:847" ALIGN=LEFT VALIGN=TOP>
							<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec02az  style="WIDTH:566px;HEIGHT: 360px;border:1 solid #777777;display:block;">
								<PARAM NAME="DataID"          VALUE="gcds_data02">
								<PARAM NAME="Editable"				VALUE="False">
								<PARAM NAME="BorderStyle"			VALUE="0">
								<param name="Fillarea"				VALUE="true">
								<PARAM NAME="Format"          VALUE="
									<C> Name='�ͼӳ⵵' ID=YYYY			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER</C> 
									<C> Name='���'			ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=CENTER</C> 
									<C> Name='����'			ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=CENTER show=false</C> 
									<C> Name='��γ��' ID=GIVDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=CENTER show=false</C> 
									<C> Name='�ڵ�����'	ID=GIVCOD		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=CENTER EditStyle=Lookup Data='gcds_givcod:MINORCD:MINORNM'</C>
									<C> Name='�ݾ�'			ID=GIVAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT Edit=Numeric Mask='###,###,###' </C> 
									">
							 </OBJECT></comment><script>__ws__(__NSID__);</script>
								<fieldset id=ft_div1 style="width:568px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;"><font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
								</fieldset>
						</td>
					<TD>
         <table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:276px; height:350px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="width:84px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӳ⵵&nbsp;</nobr></td>
            <td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yyyy22 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:1px;top:1px; width:40px; height:20px;" class="txtbox">
								<param name=Text          value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=ClipMode      value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="YYYY">
								<param name=MaxLength     value=4>
								<param name=PromptChar    value="_">
								<param name=IsComma       value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
          </tr>                   
					<tr>
		       <td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
				   <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_empnm02"  type="text" style="width:60px;position:relative;left:-5px;top:-1px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled>
						<input id="txt_empno22"  type="hidden" style="width:60px;position:relative;left:-5px;top:-1px:70px;"><img src="../../Common/img/btn/com_b_find.gif" style="cursor:hand;position:relative;top:3px;left:-5px" alt="������ �˻��մϴ�" onclick="ln_Popup1('txt_empnm02',2)">
						
						<comment id="__NSID__"><object id=gcem_givdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:1px;top:1px; width:50px; height:20px;" class=txtbox>
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
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<!-- <tr>
						<td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;��γ��&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_givdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:1px;top:1px; width:50px; height:20px;" class=txtbox>
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
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr> -->
					<tr>
            <td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�ڵ�����&nbsp;</nobr></td>
            <td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_givcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=110 style="position:relative;left:0px;top:2px;" class="txtbox">
								<param name=ComboDataID 		value="gcds_givcod">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM">
								<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script><input id="txt_givtype" type="hidden" style="position:relative;left:-5px;width:170px">&nbsp;</nobr>
							
							<!-- <comment id="__NSID__"><object id=gcem_givcod classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:1px;top:1px; width:25px; height:20px;" class=txtbox>
								<param name=Text          value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=ClipMode      value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="00">
								<param name=MaxLength     value=2>
								<param name=PromptChar    value="_">
								<param name=IsComma       value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>-->
					<!-- <tr>
						<td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<input id="txt_givtype" type="text" style="position:relative;left:-5px;width:170px">&nbsp;</nobr>
						</td>
					</tr> -->
					<!-- <tr>
            <td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
						<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<input id="txt_givgmok" type="text" style="position:relative;left:-5px;width:170px">&nbsp;</nobr>
						</td>
          </tr>
					<tr>
            <td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
            <td  colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<input id="txt_givjyo" type="text" style="position:relative;left:-5px;width:170px">&nbsp;</nobr>
						</td>
          </tr> -->		  
					<tr>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;��ȣ&nbsp;</nobr></td>
						<td style="height:60px;border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
						<textarea id="txa_givcomp"  style="position:relative;left:-5px;width:170px;height:55px;"
						maxlength = "100" onBlur = "bytelength(this,this.value,100)"></textarea>&nbsp;</nobr>
						</td>
					</tr>   
					<tr>
  					<td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����ڹ�ȣ&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_givsaup classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							 style="  position:relative; left:1px;top:1px; width:75px; height:20px;" class=txtbox>
								<param name=Text          value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=ClipMode      value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="00000000000">
								<param name=MaxLength     value=11>
								<param name=PromptChar    value="_">
								<param name=IsComma       value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr> 
					<tr>
						<td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�ݾ�&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_givamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							 style="  position:relative; left:1px;top:1px; width:75px; height:20px;" class=txtbox>
								<param name=Text          value="">
								<param name=Alignment     value=2>
								<param name=Border        value=true>
								<param name=ClipMode      value=true>
								<param name=Numeric       value=true>
								<param name=Format        value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar    value="">
								<param name=IsComma       value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>  
					<tr>
					<tr>
						<td style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�Ǽ�&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_givcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							 style="  position:relative; left:1px;top:1px; width:25px; height:20px;" class=txtbox>
								<param name=Text          value="">
								<param name=Alignment     value=2>
								<param name=Border        value=true>
								<param name=ClipMode      value=true>
								<param name=Numeric       value=true>
								<param name=Format        value="00">
								<param name=MaxLength     value=2>
								<param name=PromptChar    value="">
								<param name=IsComma       value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>  
					<tr>
						<td  style="height:60px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;���&nbsp;</nobr></td>
						<td style="height:60px;border:0 solid #708090;"><nobr>&nbsp;
						<textarea id="txa_givref" style="position:relative;left:-5px;width:170px;height:55px;" maxlength = "100" onBlur = "bytelength(this,this.value,100)"></textarea>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td colspan=2 height="100px" style="border:0 solid #708090;border-top-width:1px">&nbsp;</td>
					</tr>
				</table>
					</TD>
						</tr>
						</table>
					</td>
				</tr>
			</table>
	</div>

<!--* [TAB] �׸��߰� ***************************************************************************************-->
<div id="div_03" style="display:block">
<table width="875" cellpadding="1" cellspacing="0" border="0">
	<tr> 
		<td colspan=8 align=center>
			<table width="847" cellpadding="1" cellspacing="0" border="0" style='border:1 solid #708090' >
         <tr> 
					<td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӳ⵵&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_yyyy03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="1" 
						style="position:relative; left:1px;top:1px; width:40px;height:20px;" class="txtbox">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY">
								<param name=MaxLength     value=4>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td> 		
					</td> 
          <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
					<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px;border-right-width:0px;"><nobr>
						<input id="txt_empno03" type="text" style="position:relative;left:7px;width:70px" onKeydown="if(event.keyCode==13) ln_Query_3()"> &nbsp;</nobr>
					</td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px;border-left-width:1px"bgcolor="#eeeeee"><nobr>&nbsp;�׸�&nbsp;</nobr></td>
					<td Style="height:30px;border:0 solid #708090;border-bottom-width:0px;border-right-width:0px;"><nobr>
						<comment id="__NSID__"><object id=gclx_paycd3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=110 style="position:relative;left:5px;top:2px;" class="txtbox">
							<param name=CBData					value=" ^��ü,Y10000^�ӿ�������,Y20000^Ư����,Y30000^����,Y40000^������">
							<param name=CBDataColumns		value="PAYCD,PAYCD_NM">
							<param name=index						value="0">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="PAYCD">
							<param name=ListExprFormat	value="PAYCD_NM">
							<param name=BindColumn			value="PAYCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
					<td width=100%>&nbsp;</td>
					<td><nobr>      
						<!-- <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand"  onClick="ln_Excel_3();"> -->
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Del_3();">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Insert_3();">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save_3();">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onClick="ln_Query(3);" ></nobr>
					</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
		 <td ALIGN=CENTER>
        <table width="847" cellpadding="1" cellspacing="0" border="0">
          <tr> 
            <td style="width:847" ALIGN=LEFT VALIGN=TOP>
              <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data03  style="WIDTH: 566px; HEIGHT: 360px;border:1 solid #777777;display:block;" viewastext>
							  <PARAM NAME="DataID"          VALUE="gcds_data03">
							  <PARAM NAME="Editable"				VALUE="False">
							  <PARAM NAME="BorderStyle"			VALUE="0">
       					<param name="Fillarea"				VALUE="true">
							  <PARAM NAME="Format"          VALUE="  
									<C> Name='�ͼӿ���'			ID=YYYY			HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=center </C> 
									<C> Name='����'					ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=center </C> 
									<C> Name='�׸��'				ID=PAYCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=LEFT   Value={Decode(PAYCD,'Y10000','�ӿ�������','Y20000','Ư����','Y30000','����','Y40000','������')} </C>
									<C> Name='�⸻����ݾ�'	ID=PAYAMT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT </C>
									">
							 </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:568px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt3 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
          </td>
          <TD>
            <table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:276px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӳ⵵&nbsp;</nobr></td>
								<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_yyyy33 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:1px;top:1px; width:40px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY">
										<param name=MaxLength     value=4>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>                   
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
								<td colspan=3 Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_empnm03"  type='text'	 style="width:60px;position:relative;left:-5px;top:-1px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled>
									<input id="txt_empno33"  type="hidden" style="position:relative;left:-5px;width:70px;"><img src="../../Common/img/btn/com_b_find.gif" style="cursor:hand;position:relative;top:3px;left:-5px" alt="������ �˻��մϴ�" onclick="ln_Popup1('txt_empnm03',3)">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�׸���&nbsp;</nobr></td>
                <td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gclx_paycd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=110 style="position:relative;top:2px;" class="txtbox">
										<param name=CBData					value="Y10000^�ӿ�������,Y20000^Ư����,Y30000^����,Y40000^������">
										<param name=CBDataColumns		value="PAYCD,PAYCD_NM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="PAYCD">
										<param name=ListExprFormat	value="PAYCD_NM">
										<param name=BindColumn			value="PAYCD">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>           
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����ݾ�&nbsp;</nobr></td>
								<td  colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_payamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:1px;top:2px; width:75px; height:20px;" class="txtbox">
										<param name=Text          value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=Format        value="000,000,000">
										<param name=MaxLength     value=9>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>
						<tr><td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;</td></tr>
					</table>
          </TD>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>

		<td>
	</tr>
</table>

<div class=page id="out_line" style="position:absolute; left:174; top:158; width:875; height:438;z-index:-1;">&nbsp;</div>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N (1) - �� �� ��
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_data01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01>
	<param name=BindInfo  value='
		<C>Col=APPDT			Ctrl=gcem_yyyy11					Param=Text</C>
		<C>Col=EMPNO			Ctrl=txt_empno11					Param=value</C>
		<C>Col=EMPNMK			Ctrl=txt_empnm01					Param=value</C>
		<C>Col=INDNO			Ctrl=gcem_indno						Param=Text</C>
		<C>Col=INDNAME		Ctrl=txt_indname						Param=value</C>
		<C>Col=CARDCNTA		Ctrl=gcem_cardcnt					Param=Text</C>
		<C>Col=CARDAMTA		Ctrl=gcem_cardamt					Param=Text</C>
		<C>Col=CASHCNTA		Ctrl=gcem_cashcnt					Param=Text</C>
		<C>Col=CASHAMTA		Ctrl=gcem_cashamt					Param=Text</C>
		<C>Col=CARDCNTB		Ctrl=gcem_cardcntb					Param=Text</C>
		<C>Col=CARDAMTB		Ctrl=gcem_cardamtb				Param=Text</C>
		<C>Col=CASHCNTB		Ctrl=gcem_cashcntb				Param=Text</C>
		<C>Col=CASHAMTB		Ctrl=gcem_cashamtb				Param=Text</C>
		<C>Col=RELATION		Ctrl=gclx_relation						Param=BindColVal</C>
		<C>Col=RESINO1		Ctrl=gcem_juminno					Param=Text</C>
		<C>Col=RELAT1			Ctrl=gclx_empchk						Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-- <comment id="__NSID__"><object id=gcbn_data01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01>
	<param name=BindInfo  value='
		<C>Col=YYYY				Ctrl=gcem_yyyy11					Param=Text</C>
		<C>Col=EMPNO			Ctrl=txt_empno11					Param=value</C>
		<C>Col=EMPNMK			Ctrl=txt_empnm01					Param=value</C>
		<C>Col=INDNO			Ctrl=gcem_indno						Param=Text</C>
		<C>Col=INDNAME    Ctrl=txt_indname					Param=value</C>
		<C>Col=CARDCNT    Ctrl=gcem_cardcnt					Param=Text</C>
		<C>Col=CARDAMT    Ctrl=gcem_cardamt					Param=Text</C>
		<C>Col=CASHCNT    Ctrl=gcem_cashcnt					Param=Text</C>
		<C>Col=CASHAMT    Ctrl=gcem_cashamt					Param=Text</C>
		<C>Col=RELATION   Ctrl=gclx_relation				Param=BindColVal</C>
		<C>Col=JUMINNO    Ctrl=gcem_juminno					Param=Text</C>
		<C>Col=EMPCHK			Ctrl=gclx_empchk					Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> -->

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N (2) - �� �� ��
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_data02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data02>
	<param name=BindInfo  value='
		<C>Col=YYYY				Ctrl=gcem_yyyy22					Param=Text</C>
		<C>Col=EMPNO			Ctrl=txt_empno22					Param=value</C>
		<C>Col=EMPNMK			Ctrl=txt_empnm02					Param=value</C>
		<C>Col=GIVDATE		Ctrl=gcem_givdate					Param=Text</C>
		<C>Col=GIVCOD			Ctrl=gclx_givcod					Param=BindColVal</C>
		<C>Col=GIVTYPE		Ctrl=txt_givtype					Param=value</C>
		<C>Col=GIVGMOK		Ctrl=txt_givgmok					Param=value</C>
		<C>Col=GIVJYO			Ctrl=txt_givjyo						Param=value</C>
		<C>Col=GIVCOMP		Ctrl=txa_givcomp					Param=value</C>
		<C>Col=GIVSAUP		Ctrl=gcem_givsaup					Param=Text</C>
		<C>Col=GIVAMT			Ctrl=gcem_givamt					Param=Text</C>
		<C>Col=GIVCNT			Ctrl=gcem_givcnt					Param=Text</C>
		<C>Col=GIVREF			Ctrl=txa_givref						Param=value</C>

	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N (3) - �׸��߰�
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_data03 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data03>
	<param name=BindInfo  value='
		<C>Col=YYYY				Ctrl=gcem_yyyy33					Param=Text</C>
		<C>Col=EMPNO			Ctrl=txt_empno33					Param=value</C>
		<C>Col=EMPNMK			Ctrl=txt_empnm03					Param=value</C>
		<C>Col=PAYCD			Ctrl=gclx_paycd						Param=BindColVal</C>
		<C>Col=PAYAMT			Ctrl=gcem_payamt					Param=Text</C>
		'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
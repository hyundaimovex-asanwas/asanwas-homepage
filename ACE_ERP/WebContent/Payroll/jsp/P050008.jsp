<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�-���δ������
+ ���α׷� ID	: p050008.HTML
+ �� �� �� ��	: ��ȸ|���|����|����|����(������ ������ ����ǥ���� ������ �����Ѵ�.)
+ �� �� �� ��	: 
+ �� �� �� ��	: ������
+ �� �� �� ��	: ������ 2007.06.12 ������� �߰�
+ �� �� �� ��	: p050008_s1, p050008_t1
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>���δ������</title>
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
var gstrChk =""; //���

get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

   ln_Before();
}

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Before(){
		gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?"; 
	  gcds_dept.Reset();
	  gcem_curdt.text = gs_date2
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050008_s1?v_str1=" + gclx_dept.bindcolval
	                                                     + "&v_str2=" + txt_empnmk.value
																										   + "&v_str3=" + gcem_curdt.text
																											 + "&v_str3=" + gs_level
																									     + "&v_str4=" + gs_treecd;
	 gcds_data.Reset(); 
	 ln_Enable("f");
	 gstrChk="";
}

/******************************************************************************
	Description : ��ȸ - Detail
******************************************************************************/
function ln_Query2(){
	gcds_detail.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050008_s1?v_str6=" + gcem_empno.text + "&v_str2=" + txt_empnmk.value;
	gcds_detail.Reset(); 
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
  gstrChk="";
  ln_Enable("t")
	gcds_data.addrow();	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if (gcds_data.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
		if(ln_Chk()){
			if(ln_Valchk()){
				if (confirm("�����Ͻðڽ��ϱ�?")) {
					gcds_temp.ClearData();
					var row = gcds_temp.rowposition;
					var THeader = "EMPNO:STRING(7),APPDAY:STRING(8),APLDAY:STRING(8),APPAMT:DECIMAL(9),"
											+ "APPCNT:DECIMAL(9),APJAMT:DECIMAL(9),APLRAT:DECIMAL(9),REASON:STRING(30)";

					gcds_temp.SetDataHeader(THeader);
					for(i=1;i<=gcds_data.countrow;i++) {
						if (gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==2||gcds_data.SysStatus(i)==3){
							gcds_temp.addrow();
							gcds_temp.namevalue(1,"EMPNO")  = gcds_data.namevalue(i,"EMPNO");		
							gcds_temp.namevalue(1,"APPDAY") = gcds_data.namevalue(i,"APPDAY");	
							gcds_temp.namevalue(1,"APLDAY") = gcds_data.namevalue(i,"APLDAY");	
							gcds_temp.namevalue(1,"APPAMT") = gcds_data.namevalue(i,"APPAMT");
							gcds_temp.namevalue(1,"APPCNT") = gcds_data.namevalue(i,"APPCNT");
							gcds_temp.namevalue(1,"APJAMT") = gcds_data.namevalue(i,"APJAMT");	
							gcds_temp.namevalue(1,"APLRAT") = gcds_data.namevalue(i,"APLRAT");	
							gcds_temp.namevalue(1,"REASON") = gcds_data.namevalue(i,"REASON");	
						}
					}
					gctr_data.KeyValue = "p050008_t1(I:USER=gcds_temp)";
					gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050008_t1";
					gctr_data.post();
					ln_Query();
				}
			}//if ln_Valchk
		}//if ln_Chk
	}

}


/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){
	if (gcds_data.IsUpdated) {
		return true; 
	}else{
		return true; 
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Run(){

	var THeader = "EMPNO:STRING(7),APPDAY:STRING(8),APLDAY:STRING(8),APPAMT:DECIMAL(9),"
							+ "APPCNT:DECIMAL(9),APJAMT:DECIMAL(9),APLRAT:DECIMAL(9),APLAMT:DECIMAL(9),AMT_1:DECIMAL(9),REASON:STRING(30)";
	gcds_detail.SetDataHeader(THeader);

	for(j=1;j<=60;j++) {
		
		gcds_detail.addrow();
		
		if (j!=60) {
			gcds_detail.namevalue(j,"EMPNO")  = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");		   //���
			gcds_detail.namevalue(j,"APPDAY") = gcds_data.namevalue(gcds_data.rowposition,"APPDAY");	  //��������
			gcds_detail.namevalue(j,"APPAMT") = gcds_data.namevalue(gcds_data.rowposition,"APPAMT");	  //����ݾ�
			gcds_detail.namevalue(j,"REASON") = gcds_data.namevalue(gcds_data.rowposition,"REASON");	  //����ݾ�
			
			gcds_detail.namevalue(j,"APPCNT") = j;                                    //Ƚ��
			if (j==1){
				gcds_detail.namevalue(j,"APLDAY") = gcds_data.namevalue(gcds_data.rowposition,"APLDAY")
			}else{
				gcds_detail.namevalue(j,"APLDAY") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDAY"));//��ȯ����
			}

			gcds_detail.namevalue(j,"APLAMT") =  Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/60));	  //��ȯ����
	 
			if (j==1){
				gcds_detail.namevalue(j,"APJAMT") = ln_Apjamt(j,gcds_detail.namevalue(j,"APPAMT"),0);     //�����ܾ�
			}else{
				gcds_detail.namevalue(j,"APJAMT") = ln_Apjamt(j,gcds_detail.namevalue(j-1,"APJAMT"),gcds_detail.namevalue(j-1,"APLAMT") );
			}
			gcds_detail.namevalue(j,"APLDAY") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDAY"));	  //��ȯ����

			gcds_detail.namevalue(j,"APLRAT") = ln_Aplrat(gcds_detail.namevalue(j,"APJAMT"));	  //��ȯ���� APJAMT

			var amt_01 = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/60));//��ȯ����
			var amt_02 = ln_Aplrat(gcds_detail.namevalue(j,"APJAMT"));
			gcds_detail.namevalue(j,"AMT_1")  = amt_01+amt_02;	//��ȯ��
		}else{

			gcds_detail.namevalue(j,"EMPNO")  = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");		   //���
			gcds_detail.namevalue(j,"APPDAY") = gcds_data.namevalue(gcds_data.rowposition,"APPDAY");	  //��������
			gcds_detail.namevalue(j,"APPAMT") = gcds_data.namevalue(gcds_data.rowposition,"APPAMT");	  //����ݾ�
			gcds_detail.namevalue(j,"REASON") = gcds_data.namevalue(gcds_data.rowposition,"REASON");	  //����ݾ�
			gcds_detail.namevalue(j,"APPCNT") = j;                                    //Ƚ��
			
			if (j==1){gcds_detail.namevalue(j,"APLDAY") = gcds_data.namevalue(gcds_data.rowposition,"APLDAY")
					}else{gcds_detail.namevalue(j,"APLDAY") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDAY"));} //��ȯ����

					var appamt_eja = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/60));
					var appamt_won = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")));
					var appamt_jan = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/60))*60;
			
			gcds_detail.namevalue(j,"APLAMT") =  appamt_eja+(appamt_won-appamt_jan);	  //��ȯ����

			if (j==1){gcds_detail.namevalue(j,"APJAMT") = ln_Apjamt(j,gcds_detail.namevalue(j,"APPAMT"),0);     //�����ܾ�
			}else{
				gcds_detail.namevalue(j,"APJAMT") = ln_Apjamt(j,gcds_detail.namevalue(j-1,"APJAMT"),gcds_detail.namevalue(j-1,"APLAMT") );
			}

			gcds_detail.namevalue(j,"APLDAY") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDAY"));	  //��ȯ����
			gcds_detail.namevalue(j,"APLRAT") = ln_Aplrat(gcds_detail.namevalue(j,"APJAMT"));				//��ȯ����

			var amt_01 = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/60));//��ȯ����
			var amt_02 = ln_Aplrat(gcds_detail.namevalue(j,"APJAMT"));
			gcds_detail.namevalue(j,"AMT_1")  = amt_01+amt_02;	//��ȯ��
		}

	}//FOR              
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_SaveDetail(){

	if (gcds_detail.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
	
		var str1 = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
		if (confirm("�����Ͻðڽ��ϱ�?")) {
			gctr_data.KeyValue = "p050008_t2(I:USER=gcds_detail)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050008_t2?v_str1"+str1;
			gctr_data.post();
		}
	}
}

/******************************************************************************
	Description : �����ܾ� ,
	              cnt - Ƚ��, apjamt - �����ܾ�, aplamt - ��ȯ����
******************************************************************************/
function ln_Apjamt(cnt,apjamt,aplamt) {

	if(cnt==1){
		return apjamt
	}else{
    apjamt = apjamt - aplamt
		return apjamt;
	}
}

/******************************************************************************
	Description : ��ȯ����
	              cnt - Ƚ��, aplday - ��ȯ����
******************************************************************************/
function ln_Aplday(cnt,aplday) {
  var yyyy="",mm="",dd="";
	yyyy = aplday.substr(0,4);
	mm=aplday.substr(4,2);
	dd = aplday.substr(6,2);
	if(cnt==1){
		return aplday;
	}else{
		if (mm=="12"){
				yyyy = Number(yyyy) + 1;
				mm="01";
        return yyyy+mm+dd;
		}else{
        mm = Number(mm) + 1;
				if(mm=="10"||mm=="11"||mm=="12"){
        }else{
					mm="0"+mm;
				}
		    return yyyy + mm+ dd;  
		}
	}
}

/******************************************************************************
	Description : ��ȯ���� 
	              apjamt-�����ܾ�
******************************************************************************/
function ln_Aplrat(apjamt) {
var aplrat=0;

	if (apjamt<=20000000){
		return 	aplrat = Math.floor((apjamt*0.02)/12)
	}else{
		return aplrat = Math.floor(((20000000*0.02) + (apjamt-20000000)*0.03)/12);
	}

}

/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Valchk() {

	if (fn_trim(gcem_empno.text) == "") {			
		alert("��Ȯ�� ����� �Է��� �ֽʽÿ�");
		gcem_empno.text = "";
		return false;
	}

	if (fn_trim(gcem_appday.text)== "") {			
		alert("��Ȯ�� �������� �Է��� �ֽʽÿ�");
		gcem_appday.text = "";
		gcem_appday.focus();
		return false;
	}

	if (fn_trim(gcem_aplday.text)== "") {			
		alert("��Ȯ�� ��ȯ���� �Է��� �ֽʽÿ�");
		gcem_aplday.text = "";
		gcem_aplday.focus();
		return false;
	}

	return true;

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

	if (gcds_data.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
	//	prompt("gcds_data",  gcds_data.text);
			gcds_data.deleterow(gcds_data.rowposition);
			gctr_data.KeyValue = "p050008_t1(I:USER=gcds_data)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050008_t1";
			gctr_data.post();
			ln_Query()
		}
	}
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
	gcds_excel.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050008_s2?v_str1=" + gclx_dept.bindcolval
	                                                     + "&v_str2=" + txt_empnmk.value
																										   + "&v_str3=" + gcem_curdt.text
																											 + "&v_str3=" + gs_level
																									     + "&v_str4=" + gs_treecd;
	gcds_excel.Reset(); 

}

/******************************************************************************
	Description : Enable or Disable
******************************************************************************/
function ln_Enable(p){

	if (p=="f"){
		if (gstrChk==""){
			/*gcem_empno.enable=false;
      txt_empnmk.disabled=false;
			gcem_appday.enable=false;
			gcem_appamt.enable=false;
	    gcem_aplday.enable=false;*/

			gcem_empno.enable =false;
      txt_empnmk.ReadOnly =false;
			gcem_appday.enable =false;
			gcem_appamt.enable =false;
	    gcem_aplday.enable =false;
		}
	}else if(p=="t"){
			gcem_empno.enable =true;
			txt_empnmk.ReadOnly =true;
			gcem_appday.enable =true;
			gcem_appamt.enable =true;
			gcem_aplday.enable =true;
	}
}


/******************************************************************************
	Description : �����ȸ
******************************************************************************/
function ln_Find(e){
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		gcem_empno.text = arrParam[1];
	} else {
		eval(e).value = "";
		gcem_empno.text  = "";
	}
}

/******************************************************************************
	Description : ����������(�ӽ�)
******************************************************************************/
function ln_Reason_add(){
		var str1 = gcds_data.namevalue(gcds_data.rowposition,"REASON");
		
		if (confirm("�����Ͻðڽ��ϱ�?")) {
			gctr_data.KeyValue = "p050008_t3(I:USER=gcds_data)";
		
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050008_t3?";
			gctr_data.post();
			//ln_Query2();
		}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_data" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
  <param name="syncload"  value="false"> 
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_excel" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
  <param name="syncload"  value="false"> 
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49" > 
	<param name="syncload"  value="false">
	<param name="SortExpr"	value="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_detail" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
  <param name="syncload" value="false"> 
	<param name="SortExpr"	value="+APPCNT">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_temp" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
  <param name="syncload" value="false"> 
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<!-- <param name="keyvalue"    value="p050008_t1(I:user=gcds_data)"> -->
</object></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	  alert("������ �߻� �߽��ϴ�.");
	  window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>


<script language=JavaScript  for=gcds_excel event="OnLoadStarted()" >
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_excel event=OnLoadCompleted(rowcount)>
	//document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	gcgd_excel.RunExcelEx('�系�������', 1, 0);
</script>


<script language=JavaScript  for=gcds_detail event=OnLoadCompleted(rowcount)>
  ft_cnt2.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_grid1 event=OnClick(Row,Colid)>
	if (Row>0) {
		ln_Enable("f");
	}

	ln_Query2();
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="��ü";
	gclx_dept.index=0;
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language=JavaScript for=gclx_dept event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_dept.ValueOfIndex ("level", gclx_dept.Index);
		gs_treecd = gclx_dept.ValueOfIndex ("treecd", gclx_dept.Index);
		gs_treecd = fn_treecd(gs_level, gs_treecd);
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
</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p050008_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
		  <img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
          <td width="10px" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><object id=gclx_dept  name="gclx_dept" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value=gcds_dept>
							<param name=SearchColumn		value="DEPTCD^DEPTNM">
							<param name=Sort            value="false">
							<param name=SortColumn			value="DEPTCD">
							<param name=ListExprFormat	value="DEPTNM^0^150">
							<param name=BindColumn			value="DEPTCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>  

					<td width="10px" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
					<td width="100px"><nobr>
					<INPUT id="txt_empnmk" class="txt21" TYPE=TEXT STYLE="width:90px; position:relative;left:4px;" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td> 

					<td width="10px" class="tab29"  bgcolor="#eeeeee">
						<nobr>&nbsp;��ȯ���ؿ�&nbsp;</nobr></td>
					<td ><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " 	>
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td> 

					<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
				</tr>
			</table>		
		</td>
  </tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid1  style="WIDTH: 480px; HEIGHT:420px;border:1 solid #777777;display:block;" >
							<PARAM NAME="DataID"			VALUE="gcds_data">
							<param NAME=BorderStyle		VALUE=0> 
							<param NAME=indwidth			VALUE=0>
							<PARAM NAME="Editable"		VALUE="False">
							<param NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"		VALUE="true">
							<param NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<F> Name='�Ҽ�'			ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=LEFT		sort=true	BgColor='#f5f5f5'</F> 
								<F> Name='���'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	sort=true	BgColor='#f5f5f5'</F> 
								<F> Name='����'			ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center	sort=true	BgColor='#f5f5f5'</F> 
								<C> Name='����'			ID=PAYGRDNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		sort=true</C> 
								<C> Name='������'		ID=APPDAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center	sort=true	Mask='XXXX/XX/XX'	</C> 
								<C> Name='�����'   ID=APPAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=RIGHT		sort=true</C> 
								<C> Name='Ƚ��'		  ID=APPCNT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		sort=true</C> 
								<C> Name='�����ܾ�' ID=APJAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		sort=true</C> 
								<C> Name='��ȯ��'		ID=APLDAY  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center	sort=true	Mask='XXXX/XX/XX'	</C> 
								<C> Name='��ȯ����'	ID=APLAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		sort=true</C> 
								<C> Name='����'     ID=APLRAT   HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=right   sort=true</C> 
								<C> Name='��ȯ��'		ID=''  			HeadAlign=Center HeadBgColor=#B9D4DC Width=120 	align=right		sort=true	Value={APLAMT+APLRAT}  </C> 
								<C> Name='�������'	ID=REASON  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left		sort=true	  </C> 
								">

						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:482px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
           
						<!-- �系������� Excel -->
            <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_excel  style="WIDTH: 480px; HEIGHT:420px;border:1 solid #777777;display:none;" >
							<PARAM NAME="DataID"			VALUE="gcds_excel">
							<param NAME=BorderStyle		VALUE=0> 
							<param NAME=indwidth			VALUE=0>
							<PARAM NAME="Editable"		VALUE="False">
							<param NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"		VALUE="true">
							<param name="ViewSummary" value=1>
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�Ҽ�'			ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=LEFT		SumText='��' SumColor=Black	</C> 
								<C> Name='����'			ID=PAYGRDNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		SumText=@count SumColor=Black</C> 
								<C> Name='���'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	SumText='��' SumColor=Black</C> 
								<C> Name='����'			ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center	</C> 
								<C> Name='������'		ID=APPDAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	Mask='XXXX/XX/XX'	</C> 
								<C> Name='�����'   ID=APPAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT		SumText=@sum SumColor=Black	</C> 
								<C> Name='��ȯ��'		ID=APLDAY  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	Mask='XXXX/XX/XX'	</C> 
								<C> Name='��ȯ����'	ID=APLAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT		SumText=@sum SumColor=Black	</C> 
								<C> Name='��ȯȽ��'	ID=APPCNT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		</C> 
								<C> Name='��ȯ����' ID=TAPLAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=RIGHT	 SumText=@sum SumColor=Black	</C> 
								<C> Name='�����ܾ�' ID=CPJLAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=RIGHT	 SumText=@sum SumColor=Black	</C> 
								<C> Name='�������ڴ���' ID=TAPLRAT   HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  SumText=@sum SumColor=Black	</C> 
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
					<td width=3></td>
					<td valign=top>
						<table border="0"  cellpadding="0" cellspacing="0"  style="width:390px;height:210px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090">
					  
						<tr>	
							<td width="90px" class="tab25" bgcolor="#eeeeee"><nobr>&nbsp;���&nbsp;</nobr>
							</td>
							<td width="55px" class="tab31"><nobr>
								<comment id="__NSID__"><object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
									<param name=Text          value="">
									<param name=Alignment	    value=0>
									<param name=Border	      value=True>
									<param name=Format	      value="0000000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=Readonly  value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
							</td>
							<td width="40px" class="tab31" ><nobr><img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="position:relative;top:2px;cursor:hand" onclick="ln_Find('txt_empnmk2')" ></nobr>
							</td>

							<td width="200px" class="tab24"><nobr>
							  <input id="txt_empnmk2" name="txt_empnmk2" type="text" class="txt21" style="width:75px;"  maxlength=10 readonly>&nbsp;&nbsp;</nobr></td>	
						</tr>
						<tr>
							<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;������&nbsp;</nobr></td>
							<td colspan=3 class="tab21"><nobr>
								<comment id="__NSID__"><object id=gcem_appday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:dotum; font-size:9pt; " >
									<param name=Text          value="">
									<param name=Alignment	    value=0>
									<param name=Border	      value=True>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=MaxLength     value=8>
									<param name=IsComma       value=true>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>
						</tr>
						
						<tr>	
							<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;�����&nbsp;</nobr></td>
							<td colspan=3 class="tab21"  ><nobr>
								<comment id="__NSID__"><object id=gcem_appamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:dotum; font-size:9pt; " >
									<param name=Text          value="">
									<param name=Alignment	    value=2>
									<param name=Border	      value=True>
									<param name=Numeric	      value=true>
									<param name=MaxLength     value="9">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>          
						 </tr>	

							<tr>
								<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;��ȯ��&nbsp;</nobr></td>
								<td colspan=3 class="tab21"><nobr>
									<comment id="__NSID__"><object id=gcem_aplday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:dotum; font-size:9pt; " >
										<param name=Text          value="">
										<param name=Alignment	    value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	    value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=MaxLength     value=8>
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
							</tr>
							<tr>
								<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;�������&nbsp;</nobr></td>
								<td colspan=3 class="tab21"><nobr>
									<comment id="__NSID__"><object id=gcem_reason classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:2px; width:200px; height:20px; font-family:dotum; font-size:9pt; " >
										<param name=Text          value="">
										<param name=Alignment	    value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	    value=true>
										<param name=GeneralEdit   value=true>
										<param name=MaxLength     value=30>
										<param name=BackColor     value="#CCCCCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
									<img src="../../Common/img/btn/com_b_insert.gif"   style="cursor:hand" onclick="ln_Reason_add()">
									</nobr>

								</td> 
							</tr>
							<tr>
								<td colspan=4 align="right" style="padding-top:3px;position:relative;left:-4px;top:1px;"><nobr>&nbsp;
									<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_SaveDetail()">
									<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Run()">
								</td>
	            </tr>
							<tr>
			        <td colspan=4>
			        	<comment id="__NSID__"><OBJECT id=gcgd_create  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 390px; HEIGHT:270px;border:1 solid #777777;display:block;">
								  <PARAM NAME="DataID"			VALUE="gcds_detail">
									<PARAM NAME=BorderStyle		VALUE=0> 
									<PARAM NAME=indwidth			VALUE=0>
								  <PARAM NAME="Editable"		VALUE="True">
								  <PARAM NAME="Fillarea"		VALUE="true">
								  <PARAM NAME="ColSizing"		VALUE="true">
									<param name=ViewSummary	value=1>
								  <PARAM NAME="Format"			VALUE="   
									<C> Name='Ƚ��'			ID=APPCNT HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=right	SumBgColor=#C3D0DB </C> 
									<C> Name='�����ܾ�'	ID=APJAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=73	 align=right	SumBgColor=#C3D0DB SumText='�հ�'</C> 
									<C> Name='��ȯ����'	ID=APLDAY HeadAlign=Center HeadBgColor=#B9D4DC Width=68	 align=center SumBgColor=#C3D0DB SumText='' Mask='XXXX/XX/XX'	</C> 
									<C> Name='��ȯ����'	ID=APLAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=73	 align=right	SumBgColor=#C3D0DB SumText=@sum</C> 
									<C> Name='��ȯ����'	ID=APLRAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=right	SumBgColor=#C3D0DB SumText=@sum</C> 
									<C> Name='��ȯ��'		ID='AMT_1' HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=right	SumBgColor=#C3D0DB SumText=@sum</C> 
       							">
                </OBJECT></comment><script>__ws__(__NSID__);</script>
								<fieldset id=ft_div2 style="width:392px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
									<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
								</fieldset>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=DEPTNM    Ctrl=gcem_yyyy      Param=Text    </C>
		<C>Col=EMPNO     Ctrl=gcem_empno     Param=Text    </C>
		<C>Col=EMPNMK  	 Ctrl=txt_empnmk2    Param=value   </C>
		<C>Col=APPDAY    Ctrl=gcem_appday    Param=Text    </C>
		<C>Col=APPAMT    Ctrl=gcem_appamt    Param=Text    </C>
		<C>Col=APLDAY    Ctrl=gcem_aplday    Param=Text    </C>
		<C>Col=REASON    Ctrl=gcem_reason    Param=Text    </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
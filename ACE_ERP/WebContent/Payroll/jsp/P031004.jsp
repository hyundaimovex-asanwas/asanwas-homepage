<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-----------------------------------------------------------------------------
+ �� �� �� ��	:	����������� - ����������
+ ���α׷� ID	: P031004.HTML
+ �� �� �� ��	: �������� ���װ�� 
+ ��   ��  �� : ������
+ �� �� �� �� : 2010.12.29. �� 
+ �� �� �� ��	: 
+ �� �� �� ��	: 
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>����������</title>
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
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	gcem_curdt.text = gcurdate;
	gcem_yyyy.text = '2010';

	gcrd_radio.CodeValue=1;
}


/******************************************************************************
	Description : ����� ��ȸ 
******************************************************************************/
function ln_Query(){
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_s1?v_str1="+gcem_yyyy.text; 
	 // prompt("gcds_data", gcds_data2.DataID);
	  gcds_data2.Reset(); 
}


/******************************************************************************
	Description : �۾�������ȸ 
******************************************************************************/
function ln_Query2(){
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_s1?v_str1=" + gcem_curdt.text+"&v_str2="+gcem_yyyy.text+"12"; 
	  //prompt("gcds_data", gcds_data.DataID);
	  gcds_data.Reset(); 
}



/******************************************************************************
	Description : ���װ�� , ��α��̿����� �� ��������󼼰���
******************************************************************************/
function ln_CalCulate(){

 if (gcds_data.namevalue(3,"WRKSTS") == 'C') {
			alert("�̹� ����ó�� �Ǿ����ϴ�.");
			return false;
	}

  if(gcrd_radio.CodeValue==""){
		alert("��걸���� �����Ͻʽÿ�");
		return;
	}

	if(gcrd_radio.CodeValue==1){        // �������� ���װ�� 
		ln_CalCulate1();
	}else if(gcrd_radio.CodeValue==2){  // ��α��̿����� �� ��������󼼰���
	  ln_WorkSts('Y104001S','2','��α��̿�'); //�۾�����
	  ln_CalCulate90();
	}
}

/******************************************************************************
	Description : ��� ( ����� + �⺻�ݾ�, add ������)
******************************************************************************/
function ln_CalCulate1(){
   
  //�����ϰ�� ��� ����.

	if (confirm("�������� ���װ���� �Ͻðڽ��ϱ�?")){	
	  ln_DataSet_Add();
		gctr_data.KeyValue = "Payroll.p031004_t1(I:USER=gcds_calc)";
		gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t1";
		//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
		//prompt('gcds_data2',gcds_data2.text);
		//prompt('gcds_calc',gcds_calc.text);
		gctr_data.post();
	}   
}

/******************************************************************************
	Description : ��� ( �������� ����� �� ) 
******************************************************************************/
function ln_CalCulate2(){
  ln_DataSet_Add();
	gctr_data2.KeyValue = "Payroll.p031004_t2(I:USER=gcds_calc)";
	gctr_data2.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t2";
	//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
	//prompt('gcds_calc',gcds_calc.text);
	gctr_data2.post();
}


/******************************************************************************
	Description : ��� ( �ٷμҵ����) 
******************************************************************************/
function ln_CalCulate3(){
  ln_DataSet_Add();
	gctr_data21.KeyValue = "Payroll.p031004_t3(I:USER=gcds_calc)";
	gctr_data21.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t3";
	//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
	//prompt('gcds_calc',gcds_calc.text);
	gctr_data21.post();
}


/******************************************************************************
	Description : ��� ( �����ٹ��� ) 
	              �����ó�� �߰��ؾ���.
******************************************************************************/
function ln_CalCulate4(){
  ln_DataSet_Add();
	gctr_data22.KeyValue = "Payroll.p031004_t4(I:USER=gcds_calc)";
	gctr_data22.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t4";
	//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
	//prompt('gcds_calc',gcds_calc.text);
	gctr_data22.post();
}

/******************************************************************************
	Description : ��� ( Ư������ ) 
******************************************************************************/
function ln_CalCulate5(){
  ln_DataSet_Add();
	gctr_data23.KeyValue = "Payroll.p031004_t5(I:USER=gcds_calc)";
	gctr_data23.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t5";
	//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
	//prompt('gcds_calc',gcds_calc.text);
	gctr_data23.post();
}
/******************************************************************************
	Description : ��� ( �ѵ�üũ ) 
******************************************************************************/
function ln_CalCulate6(){
  ln_DataSet_Add();
	gctr_data24.KeyValue = "Payroll.p031004_t6(I:USER=gcds_calc)";
	gctr_data24.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t6";
	//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
	//prompt('gcds_calc',gcds_calc.text);
	gctr_data24.post();
}

/******************************************************************************
	Description : ��α��̿�
******************************************************************************/
function ln_CalCulate90(){

  if (confirm("��α��̿����� �� ��������ҵ� �Ǻ������� �Ͻðڽ��ϱ�?")){	
		ln_DataSet_Add();
		gctr_data90.KeyValue = "Payroll.p031004_t90(I:USER=gcds_calc)";
		gctr_data90.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t90";
		//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
		//prompt('gcds_calc',gcds_calc.text);
		gctr_data90.post();
	}
}

/******************************************************************************
	Description : ��α��̿� �ѵ�üũ
******************************************************************************/
function ln_CalCulate91(){
  ln_DataSet_Add();
	gctr_data91.KeyValue = "Payroll.p031004_t91(I:USER=gcds_calc)";
	gctr_data91.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t91";
	//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
	//prompt('gcds_calc',gcds_calc.text);
	gctr_data91.post();
}


/******************************************************************************
	Description : ��������ҵ���� 
******************************************************************************/
function ln_CalCulate92(){
  ln_DataSet_Add();
	gctr_data92.KeyValue = "Payroll.p031004_t92(I:USER=gcds_calc)";
	gctr_data92.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p031004_t92";
	//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
	//prompt('gcds_calc',gcds_calc.text);
	gctr_data92.post();
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

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_DataSet_Add(){
	gcds_calc.ClearAll();
  ln_SetDataHeader();
	for(i=1;i<=gcds_data2.CountRow;i++){
		if(gcds_data2.namevalue(i,"CHK")=="T"){
			gcds_calc.ImportData(gcds_data2.ExportData(i,1,false));
		}
	}

}

/******************************************************************************
	Description : �����ͼ� ��� ���� 
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_calc.countrow<1){
		var s_temp = " CHK:STRING(1),EMPNMK:STRING(20),EMPNO:STRING(7),DEPTCD:STRING(4),DEPTNM:STRING(20),APPYY:STRING(6)";
		gcds_calc.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : �۾����� 
******************************************************************************/
function ln_WorkSts(strPaycd,strGb,strMemo){

  gcds_worksts.ClearAll();
	var s_temp = "APPDT:STRING(6),PAYDT:STRING(8),PBDIV:STRING(1),PAYCD:STRING(8),WRKSTS:STRING(1),MEMO:STRING(100)";					
	gcds_worksts.SetDataHeader(s_temp);
  gcds_worksts.Addrow();

	gcds_worksts.namevalue(gcds_worksts.rowposition,"APPDT")=gcem_yyyy.text+"12";
	gcds_worksts.namevalue(gcds_worksts.rowposition,"PAYDT")=gcem_yyyy.text+"1231";
  gcds_worksts.namevalue(gcds_worksts.rowposition,"PAYCD")=strPaycd;
	gcds_worksts.namevalue(gcds_worksts.rowposition,"WRKSTS")=strGb;
	gcds_worksts.namevalue(gcds_worksts.rowposition,"MEMO")=strMemo;
	
	gctr_data3.KeyValue = "Payroll.worksts_t1(I:USER=gcds_worksts)";
	gctr_data3.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>worksts_t1";
	//prompt('',gcds_worksts.text);
	gctr_data3.post();

	gs_Status = "Y" ; 
}



/******************************************************************************
	Description : �������� 
******************************************************************************/
function ln_Finish(){
	var str1 = gcem_yyyy.text+"12";
	var str2 = 'Y';
	var str3 = "Y103001S";

 	gcds_data99.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_s1?v_str1=" + gcem_curdt.text+"&v_str2="+gcem_yyyy.text+"12"; 
	gcds_data99.Reset(); 

	if(gcds_data.Countrow>2){
		if (gcds_data99.namevalue(3,"WRKSTS") == 'C') {
			alert("�̹� ����ó�� �Ǿ����ϴ�.");
			return false;
		}else{
			gcds_data99.namevalue(3,"WRKSTS") = 'C';
			if (confirm("�����Ű� �ݿ��� ���� �Ͻðڽ��ϱ�?")){
				gctr_data3.KeyValue = "worksts_t2(I:USER=gcds_data99)";
				gctr_data3.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>worksts_t2?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
				//prompt('',gcds_data99.text);
				gctr_data3.Post();
			}else{
				return false;
			}
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
   <PARAM NAME="SyncLoad" VALUE="false"><!-- �۾����� DataSet-->
 </OBJECT>

  <OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
   <PARAM NAME="SyncLoad" VALUE="false"><!-- ����� DataSet-->
 </OBJECT>

 <OBJECT id=gcds_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <PARAM NAME="SyncLoad" VALUE="false"><!-- ���� DS -->
 </OBJECT>

 <OBJECT id=gcds_calc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <PARAM NAME="SyncLoad" VALUE="false"><!--  -->
 </OBJECT>

  <OBJECT id=gcds_worksts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <PARAM NAME="SyncLoad" VALUE="false"><!-- �۾����� -->
 </OBJECT>

   <OBJECT id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <PARAM NAME="SyncLoad" VALUE="true"><!-- �۾����� -->
 </OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data21 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data22 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data23 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data24 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data90 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data91 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data92 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=1200000> <!-- 20�� -->
</object>

<object  id=gctr_data3 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
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


<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	ft_cnt2.innerText="����Ÿ ��ȸ���Դϴ�.";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(rowcount)>
  ft_cnt2.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>


<script language="javascript" for="gcds_create" event="OnLoadStarted()">
	//ft_cnt1.innerText="����Ÿ �������Դϴ�.";
	window.status=" �������� ���� �� ���� ������Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_create" event="onloadcompleted(row,colid)">

	window.status="  �������� ���� �� ���װ���� �Ϸ� �߽��ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_create.countrow <=0){
		alert("���ϰ��� �����ϴ�.");
	}else {
		if(gcds_create.NameValue(1,"RETCOD") =="Y"){
			alert( " ����� ���������� ���� �Ǿ�����\n��ȸ ��ư�� ����Ͽ� ������¸� ��ȸ�Ͻñ� �ٶ��ϴ�.");
		}else{
			alert( " ����� ���������� ���� ���� �ʾҽ��ϴ�.");
		}
	}
	window.status="";
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_display2 event=OnClick(row,colid)>

	if(colid=="CHK"){ 
		if(row==0){
			if(gcds_data2.namevalue(1,"CHK")=="T"){
				for(i=1;i<=gcds_data2.countrow;i++){
					gcds_data2.namevalue(i,"CHK")="F";
				}
				gcds_data2.Undoall();
			}else{
				for(i=1;i<=gcds_data2.countrow;i++){
					gcds_data2.namevalue(i,"CHK")="T";
				}  	
			}
		}else{
			if(gcds_data2.namevalue(gcds_data2.rowposition,"CHK")=="T"){
				gcds_data2.namevalue(gcds_data2.rowposition,"CHK")="F";
				gcds_data2.Undo(gcds_data2.rowposition);
			}else{
				gcds_data2.namevalue(gcds_data2.rowposition,"CHK")="T";
			}
		}
	}
</script>
 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	 ln_WorkSts('Y103001S','2','���װ��'); //�۾�����
	 ln_CalCulate2();
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� �����Ͽ����ϴ�.");
	alert("Error Code1 : " + gctr_data.ErrorCode + "\n" + "Error Message1 : " + gctr_data.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
   //return;
	 ln_WorkSts('Y103002S','2','��������'); //�۾�����
	 ln_CalCulate3();
</script>

<script language="javascript" for="gctr_data21" event="onsuccess()">
	 ln_WorkSts('Y103003S','2','�����ٹ���'); //�۾�����
	 ln_CalCulate4();
</script>

<script language="javascript" for="gctr_data22" event="onsuccess()">
	 ln_WorkSts('Y103004S','2','Ư������'); //�۾�����
	 ln_CalCulate5();
</script>

<script language="javascript" for="gctr_data23" event="onsuccess()">
	 ln_WorkSts('Y103005S','2','�ѵ�üũ'); //�۾�����
	 ln_CalCulate6();
</script>

<!-- <script language="javascript" for="gctr_data24" event="onsuccess()">
	 ln_WorkSts('Y103006S','2','��α��̿�'); //�۾�����
	 ln_CalCulate7();
</script>
 -->
<script language="javascript" for="gctr_data90" event="onsuccess()">
	 ln_WorkSts('Y104002S','2','��α��̿� �ѵ�üũ'); //�۾�����
	 ln_CalCulate91();
</script>

<script language="javascript" for="gctr_data91" event="onsuccess()">
	 ln_WorkSts('Y104003S','2','����������� ��'); //�۾�����
	 ln_CalCulate92();
</script>


<script language="javascript" for="gctr_data2" event="onfail()">
	alert("gctr_data2::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code2 : " + gctr_data2.ErrorCode + "\n" + "Error Message2 : " + gctr_data2.ErrorMsg + "\n");
</script>
<script language="javascript" for="gctr_data21" event="onfail()">
	alert("gctr_data21::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code21 : " + gctr_data21.ErrorCode + "\n" + "Error Message21 : " + gctr_data21.ErrorMsg + "\n");
</script>
<script language="javascript" for="gctr_data22" event="onfail()">
	alert("gctr_data22::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code22 : " + gctr_data22.ErrorCode + "\n" + "Error Message22 : " + gctr_data22.ErrorMsg + "\n");
</script>
<script language="javascript" for="gctr_data23" event="onfail()">
	alert("gctr_data23::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code23 : " + gctr_data23.ErrorCode + "\n" + "Error Message34 : " + gctr_data23.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data24" event="onfail()">
	alert("gctr_data24::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code : " + gctr_data24.ErrorCode + "\n" + "Error Message : " + gctr_data24.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data24" event="onsuccess()">
	alert("�۾��� �����Ͽ����ϴ�.");
</script>


<script language="javascript" for="gctr_data90" event="onfail()">
	alert("gctr_data90::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code : " + gctr_data90.ErrorCode + "\n" + "Error Message : " + gctr_data90.ErrorMsg + "\n");
</script>


<script language="javascript" for="gctr_data91" event="onfail()">
	alert("gctr_data91::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code : " + gctr_data91.ErrorCode + "\n" + "Error Message : " + gctr_data91.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data92" event="onfail()">
	alert("gctr_data92::�۾��� �����Ͽ����ϴ�.");
	alert("Error Code : " + gctr_data92.ErrorCode + "\n" + "Error Message : " + gctr_data92.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data92" event="onsuccess()">
	alert("�۾��� �����Ͽ����ϴ�.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/p030004_head.gif"></td>
    <td width="680" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>	    
		  <img src="../../Common/img/btn/com_b_finish.gif"  style="cursor:hand" onclick="ln_Finish()">
			<img src="../../Common/img/btn/com_b_calc.gif"    style="cursor:hand"	onclick="ln_CalCulate()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query();ln_Query2()" >
			</nobr>&nbsp;
		</td>
  </tr>
</table>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px" > 
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="3" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee">
						<nobr>&nbsp;�ͼӳ⵵&nbsp;</nobr></td>	
					<td style="width:120px;height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;"><nobr>
						<comment id="__NSID__"><object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:1px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
							<param name=Text          value="">
							<param name=Border	      value=True>
							<param name=Format	      value="YYYY">
							<param name=MaxLength     value=4>
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
					<td width="0" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;��������&nbsp;&nbsp;</nobr></td>
					<td style="width:120px;height:30px;border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
							<param name=Text          value="">
							<param name=Border	      value=True>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_curdt', 'Text')"   style="position:relative;width:20px;left:5px;cursor:hand;">
						</nobr>
					</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" >&nbsp;��걸�� </td>
					<td style="width:420px;height:30px;border:0 solid #708090;border-right-width:0px;" >
						<comment id="__NSID__">
							<object id=gcrd_radio classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:350">
							<param name=Cols	  value="2">
							<param name=Format	value="1^�������� ���װ��,2^�̿������� �����������">
							</object>
						</comment><script>__ws__(__NSID__);</script>	
					
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td colspan="2" height=3></td></tr>
		<tr>
			<td>
				<comment id="__NSID__">
					<OBJECT id=gcgd_display2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 250px; HEIGHT: 423px;border:1 solid #777777" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data2">
					<PARAM NAME="Editable"		VALUE="true">
					<PARAM NAME="ColSizing"		VALUE="True">
					<PARAM NAME="BorderStyle" VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<param name=IndWidth      value="0">
					<PARAM NAME="SortView"		VALUE="left">
					<PARAM NAME="Format"			VALUE="
						<C> Name='����'		ID=CHK	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=center  EditStyle=CheckBox </C>
						<C> Name='����'		ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=left    edit=none  sort=true</C>
						<C> Name='���'		ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  edit=none  sort=true</C>
						<C> Name='�μ�'		ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left    edit=none</C>
					">
					</OBJECT>
				</comment><script>__ws__(__NSID__);</script>	
				<fieldset style="width:252px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
					<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
				</fieldset>
			</td>

			<td> 
				<comment id="__NSID__">
					<OBJECT id=gcgd_display2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 620px; HEIGHT: 423px;border:1 solid #777777" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data">
					<PARAM NAME="Editable"		VALUE="FALSE">
					<PARAM NAME="ColSizing"		VALUE="True">
					<PARAM NAME="BorderStyle" VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<param name=IndWidth      value="0">
					<PARAM NAME="Format"			VALUE="
						<C> Name='������'		ID=APPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center  Mask='XXXX/XX' </C>
						<C> Name='���걸��'		ID=PAYDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center </C>
						<C> Name='�޿��׸�'		ID=PAYCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center </C>
						<C> Name='�۾�����'		ID=FRDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  Mask='XXXX/XX/XX'</C> 
						<C> Name='���۽ð�'		ID=FRTM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center	Mask='XX:XX:XX' </C> 
						<C> Name='������'			ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center  Mask='XXXX/XX/XX' show=false</C>
						<C> Name='����ð�'		ID=TOTM			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center  Mask='XX:XX:XX' </C>
						<C> Name='����'				ID=WRKSTS		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center  Value={Decode(WRKSTS,1,'������',2,'�Ϸ�','E','����','C','����')} </C>
						<C> Name='���'				ID=MEMO			HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left</C>
					">
					</OBJECT>
				</comment><script>__ws__(__NSID__);</script>
			
				<fieldset style="width:622px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
					<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
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

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �޿����
+ ���α׷�ID : em026i.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.11.20
----------------------------------------------------------------------------------
+ �������� : �޿������� �ݿ�
+ �� �� �� : ������
+ �������� : 2008.01.09
----------------------------------------------------------------------------------
+ ������ : Em026_S.java
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());			
%>
<!-- HTML ����-->
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>
	<script language="javascript">

	get_cookdata();
	//���ÿ��� ����ϱ� ���� ���Ƿ� ����.
    /*
	var gs_date = gcurdate;
	*/
    var gs_date ='<%=firstday%>';

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			ln_before();//����ȸ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

		}
/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(e){//������ȸ

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);

  if(e=='01'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno.value = arrParam[0];
        txt_empnmk.value = arrParam[1];
       }
       else{
        txt_empno.value = "";
        txt_empnmk.value = "";
      }
  }
}

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){
	gcds_data0.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_S1"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)					//�޿����
											 + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//���ޱ���
											 + "&v_str3=" + fn_trim(gcem_payym2.text);        //��������
  //prompt('',gcds_data0.DataID);
	gcds_data0.Reset();
}
/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){
  //���ޱ���  CM018
	gcds_cm018.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM018";
	gcds_cm018.Reset();
	//gcem_payym.text = gcurdate.substring(0,4)+gcurdate.substring(5,7);
	gcem_payym.text = gs_date.substring(0,6);
}

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
 /*
	function ln_Excel(){

    var szName = "�޿�����";
    var szPath = "C:\\Test\\em024s.xls";
      if (gcds_data00.countrow<1){
        alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
      }
      else{
        gcgd_disp.GridToExcel(szName,szPath,2);
      }
  }//END ln_Excel
  */

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
function ln_Close(){
	ln_DataSet_Add();
	if (confirm("�޿������۾��� �Ͻðڽ��ϱ�?")){
		gctr_data99.KeyValue = "Em026_t1(I:USER=gcds_data)";
		gctr_data99.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t99?";
		gctr_data99.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data99.post();
	}

}

/*----------------------------------------------------------------------------
	Description : �޿����� ����Ÿ���߰�
----------------------------------------------------------------------------*/
function ln_DataSet_Add(){
  gcds_data.ClearAll();
	ln_SetDataHeader();
	gcds_data.addrow();
	gcds_data.namevalue(gcds_data.rowposition,"PAY_YM") = gcem_payym.text;
	gcds_data.namevalue(gcds_data.rowposition,"PAY_DIV") = "1";
	gcds_data.namevalue(gcds_data.rowposition,"I_EMPNO") = gusrid;
}


/*----------------------------------------------------------------------------
	Description : �޿���� - ����
	1. �޿������ ����
	2. �⺻��2, �⺻��3 ����
	3. �ñ�1, �ñ�2 ����
----------------------------------------------------------------------------*/
function ln_Create(){
	if(!ln_Save_Chk()) return;
	ln_DataSet_Add();
	if (confirm( gcem_payym.text.substring(0,4)+"��"+gcem_payym.text.substring(4,6)+"�� �޿������ �Ͻðڽ��ϱ�?")){
		window.status="����ڻ���,�ٹ��ϼ�";
		gctr_data1.KeyValue = "Em026_t1(I:USER=gcds_data)";
		gctr_data1.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t1?";
		gctr_data1.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data1.post();
	}
}

/*----------------------------------------------------------------------------
	Description : �޿���� - STEP 1 
	1. �⺻�� ���
	2. OT�� ���
----------------------------------------------------------------------------*/
function ln_Cal_A(){
	 
	  window.status="�⺻�ް��,OT���";
		ln_DataSet_Add();
      gctr_data2.KeyValue = "Em026_t2(I:USER=gcds_data)";
		gctr_data2.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t2?";
		gctr_data2.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data2.post();
}

/*----------------------------------------------------------------------------
	Description : �޿���� - STEP2
	1. �ް� �̽ǽ� ����� ��ȸ
	2. 20�Ϻ� ����� ���� 2���� �⺻�� ���
	3. �ټӼ��� ���
	4. �װ����� ���
	5. 20�Ϻ� ���
----------------------------------------------------------------------------*/
function ln_Cal_B(){
	  window.status="�ް� �̽ǽð���-�ټӼ���, �װ�����, 20�Ϻ� ���"; 
		ln_DataSet_Add();
    gctr_data3.KeyValue = "Em026_t3(I:USER=gcds_data)";
		gctr_data3.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t3?";
		gctr_data3.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data3.post();
}

/*----------------------------------------------------------------------------
	Description : �޿���� -  STEP3
	1.�󿩱� ���
----------------------------------------------------------------------------*/
function ln_Cal_C(){
	  window.status="�󿩱� ���";
		ln_DataSet_Add();
    gctr_data4.KeyValue = "Em026_t4(I:USER=gcds_data)";
		gctr_data4.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t4?";
		gctr_data4.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data4.post();
}

/*----------------------------------------------------------------------------
	Description : �޿���� -  STEP4
	1.������ ���
----------------------------------------------------------------------------*/
function ln_Cal_D(){
	  window.status="������ ���";
	  ln_DataSet_Add();
		gctr_data5.KeyValue = "Em026_t5(I:USER=gcds_data)";
		gctr_data5.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t5?";
		gctr_data5.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data5.post();
}


/*----------------------------------------------------------------------------
	Description : �޿���� -  STEP6 ����ó�� 
  1.��ȭ��,2.���Ұ���, 3.��ȭ������, 4.��ȭ����������
----------------------------------------------------------------------------*/
function ln_Cal_G(){
	  window.status="���� ���";
		ln_DataSet_Add();
    gctr_data8.KeyValue = "Em026_t8(I:USER=gcds_data)";
		gctr_data8.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t8?";
		gctr_data8.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data8.post();
}

/*----------------------------------------------------------------------------
	Description : �޿���� -  STEP7
  1.����ó�� (�����ұ�, ��Ÿ���� ����)
----------------------------------------------------------------------------*/
function ln_Cal_H(){
	  window.status="����ó�� ���";
		ln_DataSet_Add();
    gctr_data9.KeyValue = "Em026_t9(I:USER=gcds_data)";
		gctr_data9.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t9?";
		gctr_data9.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data9.post();
}

/*----------------------------------------------------------------------------
	Description : �޿����� üũ 
----------------------------------------------------------------------------*/
function ln_Save_Chk(){
	if(gcem_payym.text==""){
		alert("�޿������ �Է��Ͻʽÿ�.");
		return false;	
	}

	//�޿������۾��� ������� �� ��� ����.
  gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_S1"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)					//�޿����
											 + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval) 	//���ޱ���
											 + "&v_str3=" ;
  //prompt('',gcds_data0.DataID);
	gcds_data2.Reset();
  
	if(gcds_data2.countrow>=1){
		if(gcds_data2.namevalue(1,"WRKSTS")=="C"){
			alert("�̹� ���� �Ǿ����ϴ�. �޿������ �� �� �����ϴ�.");
			return false;
		}
	}
  

	return true;
}

/******************************************************************************
	Description : ����Ÿ �� ��� ����
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data.countrow<1){
		var s_temp = " PAY_YM:STRING(6),PAY_DIV:STRING(1),I_EMPNO:STRING(10)";
		gcds_data.SetDataHeader(s_temp);
	}
}


/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_Start_Load(){
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
  document.all.LowerFrame.style.visibility="visible";
}

/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_End_Load(row,cnt){
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	eval(cnt).innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}
}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/
%>
<!-- ���ޱ��� -->
<script language="javascript" for="gcds_cm018" event="onloadCompleted(row,colid)">
		//ln_Insert_Row(1,"gcds_cm018","gclx_paydiv");
		gclx_paydiv.index=0;
</script>

<script language="javascript" for="gcds_data0" event="OnLoadStarted()">
	ln_Start_Load()
</script>
<script language="javascript" for="gcds_data0" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/
%>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	 ln_Cal_A(); //�⺻�ް��,OT���
</script>
<script language="javascript" for="gctr_data1" event="onfail()">
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
  ln_Cal_B(); //�ް� �̽ǽð���-�ټӼ���, �װ�����, 20�Ϻ� ���
</script>
<script language="javascript" for="gctr_data2" event="onfail()">
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data3" event="onsuccess()">
  ln_Cal_C(); //�󿩱� ���
</script>
<script language="javascript" for="gctr_data3" event="onfail()">
	alert("Error Code : " + gctr_data3.ErrorCode + "\n" + "Error Message : " + gctr_data3.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data4" event="onsuccess()">
  ln_Cal_D(); //������
</script>
<script language="javascript" for="gctr_data4" event="onfail()">
	alert("Error Code : " + gctr_data4.ErrorCode + "\n" + "Error Message : " + gctr_data4.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data5" event="onsuccess()">
  	ln_Cal_G()
</script>
<script language="javascript" for="gctr_data5" event="onfail()">
	alert("Error Code : " + gctr_data5.ErrorCode + "\n" + "Error Message : " + gctr_data5.ErrorMsg + "\n");
</script>


<script language="javascript" for="gctr_data8" event="onsuccess()">
  	ln_Cal_H(); 
</script>
<script language="javascript" for="gctr_data8" event="onfail()">
	alert("Error Code : " + gctr_data8.ErrorCode + "\n" + "Error Message : " + gctr_data8.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data9" event="onsuccess()">
  window.status="�޿���� �Ϸ�";
	alert("�޿������ �Ϸ� �߽��ϴ�.");
</script>
<script language="javascript" for="gctr_data9" event="onfail()">
  	alert("Error Code : " + gctr_data9.ErrorCode + "\n" + "Error Message : " + gctr_data9.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data99" event="onsuccess()">
  window.status="�޿����� �Ϸ�";
	alert("�޿������۾��� �Ϸ� �߽��ϴ�.");
</script>
<script language="javascript" for="gctr_data99" event="onfail()">
  	alert("Error Code : " + gctr_data9.ErrorCode + "\n" + "Error Message : " + gctr_data9.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>

<OBJECT id=gcds_data0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �����ڵ� -->
<OBJECT id=gcds_cm018 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data3" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data4" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data5" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data6" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data7" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data8" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data9" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data99" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
						<td align="right" height="30px">
						    <img src="<%=dirPath%>/Sales/images/n_create.gif"	   style="cursor:hand"  onclick="ln_Create()"> 
 								<img src="<%=dirPath%>/Sales/images/refer.gif"   	   style="cursor:hand" onclick="ln_Query()">
								<img src="<%=dirPath%>/Sales/images/btn_close.gif"    style="cursor:hand;position:relative;top:1px;" onclick="ln_Close()">
							<!-- 	<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onClick="ln_Print('01')">
								<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand" onClick="ln_Excel('01')"> -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
          <tr height="25">
            <td bgcolor="#eeeeee" align="center">�޿����</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_payym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_payym', 'Text');">
            </td>
            <td bgcolor="#eeeeee" align="center">���ޱ���</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_paydiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                <param name=ComboDataID			value="gcds_cm018">
                <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^100">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
            <td bgcolor="#eeeeee" align="center">��������</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_payym2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_payym2', 'Text');">
            </td>
          </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:819px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:819;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
                <C>ID=APPDT	,	  Name='�޿����',	width=55px,	align=center,	HeadBgColor=#B9D4DC</C>
                <C>ID=PAYDIV,	  Name='���ޱ���',	width=55px,	align=center,	HeadBgColor=#B9D4DC  EditStyle=Combo Data='1:�޿�'</C>
                <C>ID=PAYDIV,	  Name='�޿�����',	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PAYDT	,	  Name='������'  ,	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PBDIV	,	  Name='�׸񱸺�',	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PAYCD	,	  Name='�׸��ڵ�',	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PAY_NM,	  Name='�޿��׸�',  width=80px,	align=left,	  HeadBgColor=#B9D4DC</C>
                <C>ID=FRDT	,	  Name='������'  ,	width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XXXX/XX/XX'</C>
                <C>ID=FRTM	,	  Name='���۽ð�',	width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XX:XX:XX'</C>
                <C>ID=TODT	,	  Name='������'  ,	width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XXXX/XX/XX'</C>
                <C>ID=TOTM	,	  Name='����ð�',  width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XX:XX:XX'</C>
                <C>ID=WRKSTS,	  Name='����'  ,	  width=55px,	align=center,	HeadBgColor=#B9D4DC EditStyle=Combo Data='1:������,2:�Ϸ�,E:����,C:����'</C>
                <C>ID=MEMO	,	  Name='���'  ,	  width=204px,align=left,	HeadBgColor=#B9D4DC</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:819;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- �⺻�� -->
					
	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>
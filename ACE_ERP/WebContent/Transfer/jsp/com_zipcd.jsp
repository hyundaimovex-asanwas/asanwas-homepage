<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: COM_ZIPCD.HTML
+ �� �� �� ��	: �����ȣ �˻�
+ �� �� �� ��	: 
+ �� �� �� ��	: h020002_s2
------------------------------------------------------------------------------*/
%>

<%@ page import="transfer.common.*"%>
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

<html>
<head>
 <jsp:include page="/Transfer/common/include/head.jsp"/>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
get_cookdata();
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	if (txt_zip.value.length<1) {
		alert("��ȸ�� ���Ͻô� ���� �Է��� �ּ���");
	} else {
		gcds_data.DataID = "<%=dirPath%>/servlet/Person.h020002_s2?"
									 + "v_str1=" + txt_zip.value;
		gcds_data.Reset();
	}
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
	Description : â�ݱ�
******************************************************************************/
function ln_Close(){
	window.close();
}

/******************************************************************************
	Description : �ּҼ���
******************************************************************************/
function ln_Ok(){
	if (gcds_data.countrow<1) {
		alert("�����Ͻ� �ּҰ� �����ϴ�");
	} else {
		var row = gcds_data.rowposition;
		var pam1 = gcds_data.namevalue(row,"ZIPCD");	//�����ȣ
		var pam2 = gcds_data.namevalue(row,"SIDO");		//��,��
		var pam3 = gcds_data.namevalue(row,"GUGUN");	//��,��
		var pam4 = gcds_data.namevalue(row,"DONG");		//��
		var pam5 = gcds_data.namevalue(row,"BUNJI");	//����

//		window.returnValue = pam1 + ";" + pam2 + " ;" + pam3 + " ;" + pam4 + ";" + pam5 + ";";
		window.returnValue = pam1 + ";" + pam2 + " ;" + pam3 + " ;" + pam4 + ";";
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onDblClick(row)">
	ln_Ok();
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellspacing="0" cellpadding="0" style="position:relative;left:5px;top:5px;width:620;border:1 solid #708090">
  <tr>
    <td class="tab12" width="100" bgcolor="#eeeeee">���̸�</td>
		<td width="120px;"><input type=text id=txt_zip class="txt11" style="width:100px" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td width="400px"><img src="<%=dirPath%>/Common/img/btn/com_b_search.gif" style="position:relative;top:0px;left:0px;cursor:hand" onclick="ln_Query()"></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" style="position:relative;left:5px;top:10px;width:620;">
  <tr>
    <td colspan=3 align="left">
			<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
				style="height:299;width:618;border:1 solid #708090" id="gcgd_disp">
          <param name="DataID" 					value="gcds_data">
          <param name="fillarea" 				value="true">
          <param name="indwidth" 				value="0">
          <param name="BorderStyle"			value="0">
		      <param name="FontSize"     		value="9">
					<param name="sortview"				VALUE=left>
          <param name="Format" value='
            <F>id=ZIPCD,	name=�����ȣ,	width=60,	 	align=center,	headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF, Mask="XXX-XXX"</F>
            <C>id=SIDO,		name=��,				width=80,		align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF, sort = true</C>
						<C>id=GUGUN,	name=����,			width=80,		align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF, sort = true</C>
						<C>id=DONG,		name=��,				width=200,	align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF</C>
						<C>id=BUNJI,	name=����,			width=181,	align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF</C>
					'>
			</object>
    </td>
  </tr>
	<tr><td height="10px"></td></tr>
   <tr>
    <td colspan=3 align="center">
			<img src="<%=dirPath%>/Common/img/btn/com_b_select.gif" style="position:relative;top:0px;left:0px;cursor:hand" onclick="ln_Ok()">
			<img src="<%=dirPath%>/Common/img/btn/com_b_close.gif" style="position:relative;top:0px;left:0px;cursor:hand" onclick="ln_Close()">
    </td>
   </tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:180px; top:120px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
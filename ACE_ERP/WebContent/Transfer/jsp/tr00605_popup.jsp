<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*---------------------------------------------------------------------------
+ �� �� �� ��	:  �������� - ���̵�üũ	
+ ���α׷� ID	:  TR00605_poopup.html
+ �� �� �� ��	:  �����ڵ� �˾�â
+ ��   ��  �� :  �̹���
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� �� :	   
+ ��   ��  �� :
+ �� �� �� �� :
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
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
var parentGubun="";
get_cookdata();
var gflag = "";

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	var ls_id	= txt_userid.value;
	
	if( ls_id == "" ) {
		alert("���̵� �Է��Ͻʽÿ�.");
		txt_userid.focus();
		return false; 
	}

	gcds_data.DataID = "<%=dirPath%>/servlet/transfer.tr00605_s1?NOH=Y&gstr1=" + txt_userid.value.toUpperCase();
	prompt('',gcds_data.DataID );
	gcds_data.Reset();
}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	var ls_id		= txt_userid.value;

	if (p=="A") {
		if (gflag!="") window.returnValue = gflag + ";"; 
		window.close();
	} else {
		window.close();
	}
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=javascript for=gcds_data event=onloadCompleted(row,colid)>
	var ls_id = txt_userid.value;
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data.countrow < 1) {
		alert("'" + ls_id + "' �� ����Ͻ� �� �ִ� ID �Դϴ�.") ;
		gflag = ls_id;
	}else if (gcds_data.countrow ==1 ) {
		alert("'" + ls_id +  "' �� ���� ������� ID �Դϴ�. \n\n �ٽ� �Է����ֽʽÿ�.") ;
		gflag = "";
		txt_userid.value = "";
		txt_userid.focus();		
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

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:355px;border:1 solid #708090;border-bottom-width:0px;">
	<tr>
		<td class=tab22 style="height:25px;" align=center bgcolor="#eeeeee" colspan="2">����� ID üũ</td>
	</tr>	
	<tr>
		<td class="tab21" align=center bgcolor="#eeeeee" style="width:90px;height:40px;">����� ID</td>
		<td class="tab22">
			<input type="text" class="txt11" id="txt_userid" style="top:3px;width:100px;height:18px;" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;
			<img SRC="<%=dirPath%>/Common/img/btn/com_b_find.gif" BORDER="0" ALT="���̵� �˻��մϴ�" style="cursor:hand;position:relative;left:1px;top:1px" align=center onclick="ln_Query()">
		</td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:12px;width:355px;">
	<tr>
		<td height="30px;" align="center" colspan="2">
			<img name="btn_select" border="0" src="<%=dirPath%>/Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="<%=dirPath%>/Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')"> 
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:30px; top:70px;" FrameBorder="0" src="<%=dirPath%>/Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>

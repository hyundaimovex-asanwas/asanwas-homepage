<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - �����ڵ����
+ ���α׷� ID	: TR00515.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ ��   ��  �� : �̹���
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ �� �� �� ��	: tr00515_s1, tr00515_t1
----------------------------------------------------------------------------------*/
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


<!-- HTML ����-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- /******************************************************************************
	Description : Java Script 
******************************************************************************/ --> 
<SCRIPT language=JavaScript>

var	lb_boolean1 =  false ; 
var garg = "";
var parentGubun="";


	function Start(){
	
		arg = window.dialogArguments;
		sRet = arg.split(";");
		garg = sRet[0] ;

		if (garg != ""){
			CDNAM.value = garg;
			ln_Query();
		}

		//return true ;  
	}
 
	/******************************************************************************
		Description :  ��ȸ
	******************************************************************************/
	function ln_Query(){
	
		var ls_cnam = CDNAM.value ;
		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e1?NOH=Y&gstr1=" + ls_cnam  ; 
		gcDs1.Reset() ; 
		
	}

	/******************************************************************************
		Description :  �����ڵ� ����
	******************************************************************************/  
function ln_Close(e){

	if (e=="A") {
		var row = gcDs1.rowposition;
		if(parentGubun=="") {
			window.returnValue = gcDs1.namevalue(row,"CDCODE") + ";" 
												 + gcDs1.namevalue(row,"CDNAM")  + ";" 
												 + gcDs1.namevalue(row,"CDREMARK");
												 + "gstr1=" + CDNAM.value ;
		
		}
		window.close();
	} else {
		window.close();
	}
}
</SCRIPT> 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcDs1" event="onloadCompleted(row,colid)">
	if(gcDs1.countrow <=0) alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

 <script language="javascript" for="gcGR0" event="OnDblClick()">
	ln_Close('A');
</script>

<script language=JavaScript for="gcGR0" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script> 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</head>
<BODY onLoad="Start();">
	<table width="375" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="375" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="<%=dirPath%>/Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:377px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee">�����ڵ��</td>
						<td>&nbsp;
						<input id="CDNAM" name="CDNAM" type="text" class="txt11" style='width:230;position:relative;left:0px;top:0px' onkeydown="if(event.keyCode==13) ln_Query();"></td> 
					</tr> 
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:375px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR0 style="width:375;height:280px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<C> Name='�����ڵ�' ID=CDCODE HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center show=false</C> 
									<C> Name='�����ڵ��' ID=CDNAM HeadAlign=Center HeadBgColor=#eeeeee Width=220   align=left</C> 
									<C> Name='RAMARK' ID=CDREMARK HeadAlign=Center HeadBgColor=#eeeeee Width=120   align=center</C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 

			</td>
		</tr>  
	</table>
</BODY>
</HTML>


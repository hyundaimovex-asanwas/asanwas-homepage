<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ�  �����ֹ����
+ ���α׷� ID	: TR00102_E1.HTML
+ �� �� �� ��	: �����ֹ���� -�����ڵ� ���
+ �� �� �� ��	: ���̼�
+ �� �� �� ��	: TR00102_E1.html
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ :
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

	function Start(){
		arg = window.dialogArguments;

		sRet = arg.split(";");
		garg = sRet[0];
		
		if (garg != ""  ){
			VEND_NM.value = garg;
			ln_Query();
		}

	}
 
	/******************************************************************************
		Description :  ��ȸ
	******************************************************************************/ 
	function ln_Query(){
	
		var ls_cd = VEND_CD.value ;
		var ls_nm = VEND_NM.value ;

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e3?NOH=Y&gstr1=" + ls_cd + "&gstr2="+ ls_nm ; 
		gcDs1.Reset() ; 
	}

	/******************************************************************************
		Description :  �ŷ�ó ����
	******************************************************************************/  
	function getProject(row){
	
	  if(gcDs1.countRow> 0 ){
	  
			var ls_param = new Array();
			ls_param[0] = gcDs1.NameValue(row,"VEND_CD"); // �ŷ�ó�ڵ�
			ls_param[1] = gcDs1.NameValue(row,"VEND_NM"); // �ŷ�ó�� 
			ls_param[2] = gcDs1.NameValue(row,"VEND_PRS"); // ����ڸ�
			ls_param[3] = gcDs1.NameValue(row,"VEND_PST"); // ����
			ls_param[4] = gcDs1.NameValue(row,"VEND_TEL"); // ��ȭ��ȣ
			ls_param[5] = gcDs1.NameValue(row,"VEND_CPHN"); // �ڵ�����ȣ
			ls_param[6] = gcDs1.NameValue(row,"VEND_LCT"); // �ڵ�����ȣ
			ls_param[7] = gcDs1.NameValue(row,"ADDRESS1"); // �ڵ�����ȣ
			ls_param[8] = gcDs1.NameValue(row,"ADDRESS2"); // �ڵ�����ȣ
			ls_param[9] = gcDs1.NameValue(row,"VEND_ID"); // ����ڹ�ȣ
			window.returnValue	=	ls_param  ;
		}
		window.close();  
	}
 
 </SCRIPT> 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcDs1" event="onloadCompleted(row,colid)">
	if(gcDs1.countrow < 1) alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language =JavaScript for = gcGR0 event =OnDblClick(row,colid) >	                          
	if (row<1) return;	
	getProject(row);
</script>

<script language=JavaScript for=gcGR0 event=onKeyPress(keycode)>
	var row = gcDs1.RowPosition;
	if(keycode == '13' ) getProject(row);
</script> 

</HEAD>

<BODY onLoad="Start();">
	<table width="375" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="375" align="right" background="../../../Common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:380px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" bgcolor="#eeeeee" style="width:80px;text-align:center">�ŷ�ó��</td>
						<td class="tab23" style="width:130px"><input id="VEND_NM" name="VEND_NM" type="text" class="txt11" style='width:110;position:relative;left:8px;top:0px' onkeydown="if(event.keyCode==13) ln_Query();"></td> 
						<td class="tab12" bgcolor="#eeeeee" style="width:80px;text-align:center">�ŷ�ó�ڵ�</td>
						<td><input id="VEND_CD" name="VEND_CD" type="text" class="txt11" style='width:60;position:relative;left:8px;top:0px' onkeydown="if(event.keyCode==13) ln_Query();"></td> 
					</tr> 
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table cellpadding="0" cellspacing="0" border="0" style="width:380px;height:30px;font-size:9pt;background-color:#ffffff;border:0">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR0 style="width:378;height:281px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<C> Name='�ŷ�ó�ڵ�' ID=VEND_CD HeadAlign=Center HeadBgColor=#eeeeee Width=67  align=center</C> 
									<C> Name='�ŷ�ó��' ID=VEND_NM HeadAlign=Center HeadBgColor=#eeeeee Width=167   align=left</C> 
									<C> Name='��ǥ�ڸ�' ID=VD_DIRECT HeadAlign=Center HeadBgColor=#eeeeee Width=110   align=left</C> 
								">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 
			</td>
		</tr>  
	</table>
</BODY>
</HTML>

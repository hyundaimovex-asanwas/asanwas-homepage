<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - ȭ�ְ���
+ ���α׷� ID	: TR00601.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: �̹���
+ �� �� �� ��	: tr00601_s1, tr00601_t1
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

<HTML>
<HEAD>

   <jsp:include page="/Transfer/common/include/head.jsp"/>
   
<TITLE>�ŷ�ó��ȸ</TITLE>



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
var parentGubun = "";

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Start(){
	}
 
	/******************************************************************************
		Description :  ��ȸ
	******************************************************************************/ 
	function ln_Query(){
		if( VEND_NM.value =='' && VEND_CD.value=='') {
			alert("�ŷ�ó�� �Ǵ� �ŷ�ó�ڵ带 �Է��� �ֽʽÿ�.");
			VEND_NM.focus();
			return;
		}

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00601_popup_s2?NOH=Y&gstr1=" + VEND_NM.value + "&gstr2="+  VEND_CD.value ; 
		gcDs1.Reset(); 
	
	}

	/******************************************************************************
		Description : â�ݱ�
		parameter   : A - ����
	******************************************************************************/
	function ln_Close(e){
		if (e=="A") {
			var row = gcDs1.rowposition;
			if(parentGubun=="") {
				window.returnValue = gcDs1.namevalue(row,"VEND_CD") + ";" 
													 + gcDs1.namevalue(row,"VEND_NM")  + ";" 
													 + gcDs1.namevalue(row,"VD_TELNO")  + ";" 
													 + gcDs1.namevalue(row,"VD_FAXNO");
													 + "gstr1=" + VEND_NM.value + "&gstr2="+ VEND_CD.value;
			}

			window.close();
		} else {
			window.close();
		}
	}
</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcDs1" event="onloadCompleted(row,colid)">
	if(row<1) alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

 <!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>

</HEAD>

<BODY onLoad="Start();">
	<table width="375" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:5px;">
		<tr> 
			<td width="375" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="5px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:375px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" bgcolor="#eeeeee" align=center style="width:80px;">�ŷ�ó��</td>
						<td class="tab23" style="width:120px"><input id="VEND_NM" name="VEND_NM" type="text" class="txt11" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td> 
						<td class="tab12" bgcolor="#eeeeee" align=center>�ŷ�ó�ڵ�</td>
						<td><input id="VEND_CD" name="VEND_CD" type="text" class="txt11" style="width:80px;" onkeydown="if(event.keyCode==13) ln_Query();"></td> 
					</tr> 
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table cellpadding="0" cellspacing="0" border="0" style="width:375px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:375;height:361px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<C> Name='�ŷ�ó�ڵ�' ID=VEND_CD   HeadAlign=Center HeadBgColor=#eeeeee Width=70    align=center</C> 
									<C> Name='�ŷ�ó��'   ID=VEND_NM   HeadAlign=Center HeadBgColor=#eeeeee Width=180   align=left</C> 
									<C> Name='��ȭ��ȣ'   ID=VD_TELNO  HeadAlign=Center HeadBgColor=#eeeeee Width=90   align=left</C> 
									<C> Name='�ѽ���ȣ'   ID=VD_FAXNO  HeadAlign=Center HeadBgColor=#eeeeee Width=120   align=left, show=false</C> 
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

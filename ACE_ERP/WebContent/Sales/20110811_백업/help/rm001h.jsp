<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: ����Ÿ�� Help 
 * ���α׷�ID 	: RM001H (�ڵ�� �빮��)
 * J  S  P		: rm001h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Rm001H
 * �� �� ��		: ������
 * �� �� ��		: 2006-05-25
 * �������		: ����Ÿ�� ��ȸ 
 * ��������		: 2006-05-09 : XXXXX ���� XXXXX ������û (�Ϸ�/�̿Ϸ�)
 * �� �� ��		: ������
 * [2008-01-17][�ɵ���] 198 ���� ������Ʈ - �ε��ٺκ� ����.
 * [2008-03-19][�ɵ���] �׸��� ��Ÿ�� ��
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>����Ÿ�ԡ�����������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			// ������ �ε�
			function fnOnLoad(){
		        cfStyleGrid(getObjectFirst("gr1"), "comn");
				var strParam = new Array();
				strParam=window.dialogArguments;
			
				if(strParam[0]!=null) { //room �ڵ� ����
					txt_room_type_cd.value=strParam[0];
				}else {
				}
				if(strParam[1]!=null) { //room �̸� ����
					txt_room_type_nm.value=strParam[1];
				}else {
				}
				if(strParam[2]!=null) { //������ ����
					upjangsid.value=strParam[2];
				}else {
				}
			}

			// ���� ��ȸ
			function fnSelect() {
				fnSubSelect1();
			}
			
			// ������� ��ȸ 
			function fnSubSelect1() {
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm001H?proType=S&dsType=1&s_RoomTypeSid=&s_RoomTypeCd="+txt_room_cd.value+"&s_UpjangSid="+upjangsid.value;
				ds1.Reset();
			}
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "room_type_sid") + ";" +
								 	 ds1.namevalue(row, "room_type_cd") + ";" + 
								 	 ds1.namevalue(row, "room_type_nm") + ";" +
								 	 ds1.namevalue(row, "upjang_sid") + ";" +
								 	 ds1.namevalue(row, "upjang_nm") + ";" +
								 	 ds1.namevalue(row, "std_persons");								 	 
				fnClose();
			}
			
			function fnClose() {
				window.close();
			}
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			fnHideLoading();
		</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";

			fnHideLoading();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "room_type_sid") + ";" +
								 ds1.namevalue(row, "room_type_cd") + ";" + 
								 ds1.namevalue(row, "room_type_nm") + ";" +
							 	 ds1.namevalue(row, "upjang_sid") + ";" +
							 	 ds1.namevalue(row, "upjang_nm") + ";" +
							 	 ds1.namevalue(row, "std_persons");		
			window.close();
		</script>
			<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>	
<!-----------------------------------------------------------------------------
                                DataSet Components ���� 
# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
		<%=HDConstant.COMMENT_START%>
		<object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object>
		<%=HDConstant.COMMENT_END%>
		<%=HDConstant.COMMENT_START%>
		<object  id=ds2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
			<param name="SyncLoad" 	value="false">
		</object>
		<%=HDConstant.COMMENT_END%>

	</head>	
	
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	
		
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:50;height:15;">����Ÿ��</font>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">����Ÿ��/��</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
							<input type="hidden" id="upjangsid">
								<input type="text" id="txt_room_cd" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="����Ÿ��/���� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:288px;border:1 solid #777777;">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit����  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="VIEWSUMMARY"   value="1">
						<param name="Format" 		value="
							<c> Name='sid'				ID='room_type_sid'	HeadAlign=Center Width=100  align=center show=false</c>
							<c> Name='�� �� Ÿ ��'		ID='room_type_cd'	HeadAlign=Center Width=100  align=CENTER SUMTEXT='��'</c>
							<c> Name='��   ��   ��' 	ID='room_type_nm'	HeadAlign=Center Width=170  align=CENTER SUMTEXT=@CNT</c>
							<c> Name='�����SID' 		ID='upjang_sid'	  	HeadAlign=Center Width=379  LeftMargin=50 show=false</c>
							<c> Name='ǥ���ο�' 		ID='std_persons'	HeadAlign=Center Width=379  LeftMargin=50 show=false</c>
							<c> Name='�� �� �� ��' 		ID='upjang_nm'	  	HeadAlign=Center Width=190  align=CENTER</c>
							
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>
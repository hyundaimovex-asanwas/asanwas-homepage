<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: ��ü���� Help 
 * ���α׷�ID 	: Cu005H
 * J  S  P		: cu005h
 * �� �� ��		: Cu005H
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2008-03-24
 * �������		: ��ü���� ��ȸ 
 * ��������		: 
 * �� �� ��		: �̺���
 * [����  ����][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	
	// �븮�� ����
	String gubun = HDUtil.nullCheckStr(request.getParameter("gubun"));
	
	String title = "";
	if (gubun.equals("1")) {
		title = "�븮��";
	} else if (gubun.equals("2")) {
		title = "���¾�ü";
	} else {
		title = "�븮��";
	}
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title>��ü��� ������������������������������������������������������������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
		        cfStyleGrid(getObjectFirst("gr1"), "comn");
			}
			
			function fnSelect() {
				fnSubSelect1();
			}
			//
			function fnSubSelect1() {
				//if(!keyword.value) {
				//	alert("��ü�ڵ� �Ǵ� ��ü���� �Է����ּ���.");
				//	keyword.focus();
				//	return false;
				//};
				
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu005H?proType=S&dsType=1&keyWord=" + keyword.value + "&gubun=<%=gubun%>" ;
				ds1.Reset();
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "group_sid") + ";" +
									 ds1.namevalue(row, "group_nm") + ";" +
								 	 ds1.namevalue(row, "group_cd");
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
			ft_cnt1.innerText="Cnt : " + row;
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "group_sid") + ";" +
								 ds1.namevalue(row, "group_nm") + ";" +
								 ds1.namevalue(row, "group_cd");
			window.close();
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>
<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:50;height:15;left:5px;"><%=title%></font>
								<input type="hidden" name="gubun" value="<%=gubun%>" style="width:50;position:relative;top:2px;border:0;" readonly>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">�ڵ�/��</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
								<input type="text" name="keyword" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�ڵ�/���� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
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
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:248px;border:1 solid #777777;">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit����  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name="SortView"      value="LEFT">
						<param name="Format" 		value="
							<c> Name='sid'		ID='group_sid'		HeadAlign=Center Width=100  align=center show=false</c>
							<c> Name='��    ��'	ID='group_cd'		HeadAlign=Center Width=100  align=center sort=true</c>
							<c> Name='�� �� ��' ID='group_nm'	  	HeadAlign=Center Width=360  LeftMargin=50 sort=true</c>
							
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>
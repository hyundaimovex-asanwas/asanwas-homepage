<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: �ο�  Help 
 * ���α׷�ID 	: RV203H
 * J  S  P		: rv203h
 * �� �� ��		: Rv203H
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2010-06-29
 * [2010-06-29][�ڰ汹] �����ȳ� ����/���� �˾�â.
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.net.URLEncoder" %>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String toDay     = m_today.format(date.getTime());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>�����ȳ� ����/���� ����â</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
			}
			function fnSelect() {
           }
        
           //���� ����
			function fnApply() {
		
		         ln_TRSetting(tr1, 
		             "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv203H",
		             "JSP(I:MASTER=ds1,O:msgDS=msgDS)",
		             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
		         tr_post(tr1);
		         alert("������ �����Ͽ����ϴ�.");
			}
           //���� ����
			function fnApply2() {
				alert("������ �����Ͽ����ϴ�.");
			}
        	function fnClose() {
				window.close();
			}
		</script>
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>	
	
	
<!--  BODY START -->
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
			<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
				<tr>
					<td colspan=4 height=25 width="479px" align=left>
						<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">�����ȳ� ����/����</font>
					</td>
				</tr>
				<tr>
					<td colspan=4 height=25 width="479px" align=center bgcolor="#ffffff">
						���� <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();"> <!--�����ȳ� ���� �߼�-->
					</td>
				</tr>
				<tr>
					<td colspan=4 height=25 width="479px" align=center bgcolor="#ffffff">
						���� <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply2();"><!--�����ȳ� ���� �߼�-->
					</td>
				</tr>
			</table>
	</body>
	<!-- BODY END -->
</html>
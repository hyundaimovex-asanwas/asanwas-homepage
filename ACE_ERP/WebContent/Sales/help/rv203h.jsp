<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	: 인원  Help 
 * 프로그램ID 	: RV203H
 * J  S  P		: rv203h
 * 서 블 릿		: Rv203H
 * 작 성 자		: 박경국
 * 작 성 일		: 2010-06-29
 * [2010-06-29][박경국] 결제안내 쪽지/메일 팝업창.
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.net.URLEncoder" %>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String toDay     = m_today.format(date.getTime());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>결제안내 쪽지/메일 전송창</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
			}
			function fnSelect() {
           }
        
           //쪽지 전송
			function fnApply() {
		
		         ln_TRSetting(tr1, 
		             "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv203H",
		             "JSP(I:MASTER=ds1,O:msgDS=msgDS)",
		             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
		         tr_post(tr1);
		         alert("쪽지를 전송하였습니다.");
			}
           //메일 전송
			function fnApply2() {
				alert("메일을 전송하였습니다.");
			}
        	function fnClose() {
				window.close();
			}
		</script>
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
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
						<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">결제안내 쪽지/메일</font>
					</td>
				</tr>
				<tr>
					<td colspan=4 height=25 width="479px" align=center bgcolor="#ffffff">
						쪽지 <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();"> <!--결제안내 쪽지 발송-->
					</td>
				</tr>
				<tr>
					<td colspan=4 height=25 width="479px" align=center bgcolor="#ffffff">
						메일 <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply2();"><!--결제안내 메일 발송-->
					</td>
				</tr>
			</table>
	</body>
	<!-- BODY END -->
</html>
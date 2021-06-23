<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 11월 17일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "33";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("eng_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.eng.NewsletterBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String category = request.getParameter("category");

	NewsletterBean nb = new NewsletterBean();
	nb.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />


<%
	// 검색
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>

<html>
<head>
<title>:::: Opening the Way ::::</title>
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
</head>

<BODY topmargin="10" leftmargin="10" bgcolor="#FCFCF6">
<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="580" bgcolor="#234790">
<tr>
	<td><img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)read.get("IMG"))%>&dir=engnewsletter&sysfilename=<%= Utility.ko((String)read.get("SYSIMG"))%>" border="0" style="width:580px;"></td>
</tr>
</table>
<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="580" height="10"><tr><td></td></tr></table>

<!----- Box----->
<table border="0" cellpadding="0" cellspacing="0" width="580" height="100" bgcolor="#F1F1DB">
<tr>
	<td height="8"><img src="/english/img/common/pop_box580_top.gif"></td>
</tr>
<tr><td height="15"></td></tr>
<tr>
	<td align="center" valign="top">
		<!----- Contents----->
		<table border="0" cellpadding="0" cellspacing="0" width="555">
		<tr>
			<td style="padding-left:10"><img src="/english/img/common/bu_03.gif" align="absmiddle"> <b><%= Utility.ko( (String)read.get("TITLE") ) %></b></td>
		</tr>
		<tr><td height="10"></td></tr>
		</table>
		<table border="0" cellpadding="0" cellspacing="0" width="535">
		<tr>
			<td><%= Utility.ko( (String)read.get("CONTENT") ) %></td>
		</tr>
		</table>
		<!----- //Contents----->
	</td>
</tr>
<tr><td height="15"></td></tr>
<tr>
	<td height="8"><img src="/english/img/common/pop_box580_bottom.gif"></td>
</tr>
</table>
<!----- //Box----->

<!----- CopyRight----->
<table border="0" cellpadding="0" cellspacing="0" width="580">
<tr><td colspan="3" height="4"></td></tr>
<tr>
	<td width="505" background="/img/common/pop_copyright_bg.gif"><img src="/english/img/common/pop_copyright.gif"></td>
	<td align="right" background="/img/common/pop_copyright_bg.gif"><img src="/english/img/common/pop_copyright_right.gif"></td>
</tr>
<tr><td colspan="3" height="7"></td></tr>
</table>
<!----- //CopyRight----->

<!----- Btn_close----->
<table border="0" cellpadding="0" cellspacing="0" width="580">
<tr>
	<td align="right" ><a href="javascript:window.close()"><img src="/english/img/common/pop_close.gif" border="0"></a></td>
</tr>
</table>
<!----- Btn_close----->

</BODY>
</HTML>


<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : Mr.K JM
* 작성날자 : 2005. 10. 31
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
	String menuidx = "16";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.cyber.NewsletterBean" %>

<%
	NewsletterBean nb = new NewsletterBean();
	nb.SendMail(request, response);
	
	String yes = (String)request.getAttribute("yes");
	String no = (String)request.getAttribute("no");
%>

	<script language=javascript>
		alert("성공 : <%= yes%>\n실패 : <%= no %>");
		location.replace('/asanway/cyber/cyber_newsletter_list.jsp');
	</script>

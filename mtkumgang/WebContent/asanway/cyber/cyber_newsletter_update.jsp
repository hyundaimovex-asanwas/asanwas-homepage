<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* 작 성 인 : Mr.K JM
* 작성날자 : 2005. 10. 28
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
	int result = nb.Update(request, response);
	
	String idx = (String)request.getAttribute("idx");
	String category = (String)request.getAttribute("category");	
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('수정되었습니다.');
			location.href="/asanway/cyber/cyber_newsletter_read.jsp?idx=<%= idx %>&category=<%= category %>";
		</script>
	</body>
	</html>
<% } else {	%>
	<html>
	<body>
		<script language=javascript>
			alert('정상적으로 수정되지 않았습니다.');
			history.go(-1);
		</script>
	</body>
	</html>		
<% } %>		
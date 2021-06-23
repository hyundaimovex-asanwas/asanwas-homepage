<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 14일
* 요약 설명 : ceo 메시지 - 등록
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.company.ActivityBean" %>

<%
	ActivityBean ab = new ActivityBean();
	int result = ab.Update(request, response);

	String idx = (String)request.getAttribute("idx");
%>

<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "12";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("company_main.jsp?flag=1");
	}
%>


<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('수정되었습니다.');
			location.href="/asanway/company/company_activity.jsp?idx=<%= idx %>&page=<%=(String)request.getAttribute("page")%>";
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
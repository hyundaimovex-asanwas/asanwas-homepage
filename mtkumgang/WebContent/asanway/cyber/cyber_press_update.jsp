<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* 작 성 인 : Mr.K JM ( czar.pe.kr@gmail.com )
* 작성날자 : 2005. 10. 11
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
	String menuidx = "15";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.cyber.PressBean" %>

<%
	PressBean bean = new PressBean();
	int result = bean.Update(request, response);
	
	String idx = (String)request.getAttribute("idx");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('수정되었습니다.');
			location.replace('/asanway/cyber/cyber_press_read.jsp?idx=<%= idx %>');
//			location.href="/asanway/cyber/cyber_news_read.jsp?idx=<%= idx %>";			
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
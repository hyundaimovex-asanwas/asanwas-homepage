<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* 작 성 인 : Mr.K JM ( czar.pe.kr@gmail.com )
* 작성날자 : 2005. 10. 14
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>

<%

	NewsBean bean = new NewsBean();
	int result = bean.UpdateStatus(request, response);
	
	String idx = (String)request.getAttribute("idx");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('수정되었습니다.');
			//location.replace('/asanway/cyber/cyber_news_list.jsp?idx=<%= idx %>');
		</script>
	</body>
	</html>
<% } else {	%>
	<html>
	<body>
		<script language=javascript>
			alert('정상적으로 수정되지 않았습니다.');
			//history.go(-1);
		</script>
	</body>
	</html>		
<% } %>		
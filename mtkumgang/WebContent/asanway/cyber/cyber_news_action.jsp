<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* 작 성 인 : Mr.K JM ( mrkczar@gmail.com )
* 작성날자 : 2005. 10. 13
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
	String menuidx = "13";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>


<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>

<%
	NewsBean nb = new NewsBean();

	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("Insert") ) {
	int result = nb.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				location.href="/asanway/cyber/cyber_news_list.jsp";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-1);
			</script>
	<% } %>

<% } else if( cmd.equals("Update") ) {
			int result = nb.Update(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					location.href="/asanway/cyber/cyber_news_read.jsp?idx=<%= result %>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("Delete") ) {
			int result = nb.DeleteUpdate(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('삭제되었습니다..');
					location.href="/asanway/cyber/cyber_news_list.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>

<% } %>
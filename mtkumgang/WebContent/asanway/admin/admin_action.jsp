<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 18일
* 요약설명 : 운영자  정보  등록 /수정/삭제
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>

<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("admin_main.jsp?flag=1");
	}
%>

<%
	AuthBean ab = new AuthBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("Insert") ) {
	int result = ab.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				opener.location.replace("/asanway/admin/admin_list.jsp");
				window.close();
			</script>
	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('사용중인 ID입니다.');
				history.go(-1);
			</script>
	<% } else { %>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-1);
			</script>
	<% } %>


<% } else if( cmd.equals("Update") ) {
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					location.href="/asanway/admin/pop_modify.jsp?idx=<%=request.getAttribute("idx")%>";
					opener.location.reload();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("Delete") ) {
			int result = ab.DeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('삭제되었습니다..');
					opener.location.reload();
					window.close();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>
<% } %>
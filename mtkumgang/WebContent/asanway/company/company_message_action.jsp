<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 11일
* 요약설명 : CEO message 정보  등록 /수정/삭제
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.company.MessageBean" %>

<%@include file="/asanway/common/head.jsp"%>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "11";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("company_main.jsp?flag=1");
	}
%>

<%
	MessageBean mb = new MessageBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("Insert") ) {
	int result = mb.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				location.href="/asanway/company/company_message.jsp";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-1);
			</script>
	<% } %>


<% } else if( cmd.equals("Update") ) {
			int result = mb.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					location.href="/asanway/company/company_message_read.jsp?idx=<%=request.getAttribute("idx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("Delete") ) {
			int result = mb.DeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('삭제되었습니다..');
					location.href="/asanway/company/company_message.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>
<% } %>
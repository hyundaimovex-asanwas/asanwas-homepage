<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 26일
* 요약설명 : 관련사이트, 카테고리  정보  등록 /수정/삭제
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.cyber.LinkSiteBean" %>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "25";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%
	LinkSiteBean bean = new LinkSiteBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("I") ) {
	int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-1);
			</script>
	<% } %>


<% } else if( cmd.equals("U") ) {
			int result = bean.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					opener.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
					window.close();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("D") ) {
			int result = bean.DeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('삭제되었습니다..');
					parent.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
				</script>
		<% } %>

<% } else if( cmd.equals("CI") ) {
			int result = bean.CateInsert(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('등록되었습니다..');
					location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 등록되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("CU") ) {
			int result = bean.CateUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다..');
					opener.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
					window.close();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					window.close();
				</script>
		<% } %>

<% } else if( cmd.equals("CD") ) {
			int result = bean.CateDeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('삭제되었습니다..');
					parent.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
				</script>
		<% } %>
<% } %>
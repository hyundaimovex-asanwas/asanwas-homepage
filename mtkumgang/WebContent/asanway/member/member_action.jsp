<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 28일
* 요약설명 : 회원정보  등록 /수정/삭제
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>


<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.member.MemberBean" %>

<%@include file="/asanway/common/head.jsp"%>

<%
	MemberBean ab = new MemberBean();
	String cmd = request.getParameter("cmd");
	String mtype = request.getParameter("mtype");
%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>

<% if( cmd.equals("U") ) {
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					location.replace("/asanway/member/member_general_read.jsp?mtype=<%=mtype%>&idx=<%=request.getAttribute("idx")%>");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("D") ) {
			int result = ab.Delete(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('삭제되었습니다..');
					location.replace("/asanway/member/member_general_list.jsp?mtype=<%=mtype%>");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("UL") ) {
			int result = ab.UpdateLevel(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다..');
					parent.location.reload();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
				</script>
		<% } %>
<% } %>
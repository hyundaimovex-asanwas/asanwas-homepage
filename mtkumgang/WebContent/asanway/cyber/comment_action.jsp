<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%@ page import="com.hmm.asan.comment.CommentBean" %>

<%

	String cmd = request.getParameter("cmd");

	String url =  request.getHeader("referer");

	CommentBean comment = new CommentBean();
%>

<% if(cmd.equals("add") ) { %>

<% 	int result = comment.CommentAddAdmin(request, response);  %>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('덧글이 등록되었습니다..');
//				opener.document.location.reload();
				location.replace('<%= url %>');
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-1);
			</script>
	<% } %>

<% } %>

<% if(cmd.equals("del") ) { %>

<% 	int result = comment.CommentDel(request, response);  %>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('덧글이 삭제되었습니다..');
				parent.location.reload();
//				location.replace('<%= url %>');
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('정상적으로 삭제되지 않았습니다.');
				parent.location.reload();
			</script>
	<% } %>

<% } %>
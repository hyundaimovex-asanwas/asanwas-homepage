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
				alert('������ ��ϵǾ����ϴ�..');
//				opener.document.location.reload();
				location.replace('<%= url %>');
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>

<% } %>

<% if(cmd.equals("del") ) { %>

<% 	int result = comment.CommentDel(request, response);  %>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('������ �����Ǿ����ϴ�..');
				parent.location.reload();
//				location.replace('<%= url %>');
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� �������� �ʾҽ��ϴ�.');
				parent.location.reload();
			</script>
	<% } %>

<% } %>
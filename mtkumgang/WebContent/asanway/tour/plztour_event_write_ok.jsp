<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>

<%
	Plz_BoardBean pb = new Plz_BoardBean();
	int result = pb.Insert(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('등록되었습니다.');
			location.href = "plztour_event.jsp?category=event";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 등록되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>
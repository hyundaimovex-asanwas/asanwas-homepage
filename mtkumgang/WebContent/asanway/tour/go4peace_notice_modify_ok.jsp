<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>

<%
	Plz_BoardBean pb = new Plz_BoardBean();
	int result = pb.Update(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('수정되었습니다.');
			location.href = "go4peace_notice.jsp?category=go4notice";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 수정되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>
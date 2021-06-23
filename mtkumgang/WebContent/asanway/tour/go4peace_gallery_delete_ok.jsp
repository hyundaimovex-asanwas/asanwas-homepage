<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>

<%
	Plz_BoardBean pb = new Plz_BoardBean();
	int result = pb.Delete(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('삭제되었습니다.');
			location.href = "go4peace_gallery.jsp?category=go4gallery";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 삭제되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>
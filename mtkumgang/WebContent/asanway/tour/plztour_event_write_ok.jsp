<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>

<%
	Plz_BoardBean pb = new Plz_BoardBean();
	int result = pb.Insert(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('��ϵǾ����ϴ�.');
			location.href = "plztour_event.jsp?category=event";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>
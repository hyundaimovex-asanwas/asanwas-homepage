<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005. 10. 14
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "18";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.cyber.InterviewBean" %>

<%
	InterviewBean ib = new InterviewBean();
	int result = ib.Update(request, response);

	String idx = (String)request.getAttribute("idx");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			location.href="/asanway/cyber/cyber_interview_list.jsp?idx=<%= idx %>&page=<%=(String)request.getAttribute("page")%>";
		</script>
	</body>
	</html>
<% } else {	%>
	<html>
	<body>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
	</body>
	</html>
<% } %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 10�� 14��
* ��� ���� : ceo �޽��� - ���
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.company.ActivityBean" %>

<%
	ActivityBean ab = new ActivityBean();
	int result = ab.Update(request, response);

	String idx = (String)request.getAttribute("idx");
%>

<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "12";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("company_main.jsp?flag=1");
	}
%>


<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			location.href="/asanway/company/company_activity.jsp?idx=<%= idx %>&page=<%=(String)request.getAttribute("page")%>";
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
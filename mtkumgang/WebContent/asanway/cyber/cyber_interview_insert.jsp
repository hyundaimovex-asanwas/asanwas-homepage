<%@ page language="java" contentType="text/html; charset=euc-kr"%>
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
	int result = ib.Insert(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('��ϵǾ����ϴ�.');
			location.replace('/asanway/cyber/cyber_interview_list.jsp');
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>
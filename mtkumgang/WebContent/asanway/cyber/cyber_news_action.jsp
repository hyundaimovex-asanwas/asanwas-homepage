<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM ( mrkczar@gmail.com )
* �ۼ����� : 2005. 10. 13
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
	String menuidx = "13";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>


<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>

<%
	NewsBean nb = new NewsBean();

	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("Insert") ) {
	int result = nb.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				location.href="/asanway/cyber/cyber_news_list.jsp";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>

<% } else if( cmd.equals("Update") ) {
			int result = nb.Update(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.href="/asanway/cyber/cyber_news_read.jsp?idx=<%= result %>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("Delete") ) {
			int result = nb.DeleteUpdate(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					location.href="/asanway/cyber/cyber_news_list.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } %>
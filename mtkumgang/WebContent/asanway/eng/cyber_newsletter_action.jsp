<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 11�� 17��
* ��� ���� : EngNewsletter - ���
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "33";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("eng_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.eng.NewsletterBean" %>

<%
	NewsletterBean nb = new NewsletterBean();
	String cmd = request.getParameter("cmd");

	String category = request.getParameter("category");
	if (category == null || category.equals("") || category.equals("null")){
		category = "enguser";
	}
%>

<%
if(cmd.equals("I") ) {
	int result = nb.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				location.href="/asanway/eng/cyber_newsletter_list.jsp?category=<%=category%>";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>

<% } else if( cmd.equals("U") ) {
			int result = nb.Update(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.href="/asanway/eng/cyber_newsletter_read.jsp?category=<%=category%>&idx=<%= request.getAttribute("idx") %>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("D") ) {
			int result = nb.DeleteUpdate(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					location.href="/asanway/eng/cyber_newsletter_list.jsp?category=<%=category%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("send") ) {
		nb.SendMail(request, response);

		String yes = (String)request.getAttribute("yes");
		if (yes == null) yes="0";
		String no = (String)request.getAttribute("no");
		if (no == null) no="0";
%>

	<script language=javascript>
		alert("���� : <%= yes%>\n���� : <%= no %>");
		location.replace('/asanway/eng/cyber_newsletter_list.jsp?category=<%=category%>');
	</script>
<% } %>


<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 26��
* ��༳�� : ���û���Ʈ, ī�װ�  ����  ��� /����/����
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.cyber.LinkSiteBean" %>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "25";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%
	LinkSiteBean bean = new LinkSiteBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("I") ) {
	int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>


<% } else if( cmd.equals("U") ) {
			int result = bean.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					opener.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
					window.close();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("D") ) {
			int result = bean.DeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					parent.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
				</script>
		<% } %>

<% } else if( cmd.equals("CI") ) {
			int result = bean.CateInsert(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('��ϵǾ����ϴ�..');
					location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("CU") ) {
			int result = bean.CateUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					opener.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
					window.close();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					window.close();
				</script>
		<% } %>

<% } else if( cmd.equals("CD") ) {
			int result = bean.CateDeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					parent.location.href="/asanway/cyber/cyber_linksite_write.jsp?cateidx=<%=request.getParameter("cateidx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
				</script>
		<% } %>
<% } %>
<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 18��
* ��༳�� : ���  ����  ��� /����/����
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>

<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("admin_main.jsp?flag=1");
	}
%>

<%
	AuthBean ab = new AuthBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("Insert") ) {
	int result = ab.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				opener.location.replace("/asanway/admin/admin_list.jsp");
				window.close();
			</script>
	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('������� ID�Դϴ�.');
				history.go(-1);
			</script>
	<% } else { %>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>


<% } else if( cmd.equals("Update") ) {
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.href="/asanway/admin/pop_modify.jsp?idx=<%=request.getAttribute("idx")%>";
					opener.location.reload();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("Delete") ) {
			int result = ab.DeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					opener.location.reload();
					window.close();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>
<% } %>
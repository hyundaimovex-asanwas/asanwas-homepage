<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 11�� 16��
* ��� ���� : ��ũ�� ������  (�Ź�)
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "20";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.cyber.ScrapBean" %>

<%
	String category = "scrappaper";
	String cmd = request.getParameter("cmd");
	String dirName = WEBConstants.SCRAPPAPERUPLOADDIR;
	int maxFileSize = WEBConstants.SCRAPPAPERUPLOADMAX;

	ScrapBean bean = new ScrapBean(dirName,maxFileSize,category);
%>

<%
	if(cmd.equals("I") ) {
		int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				location.replace('/asanway/cyber/cyber_scrap_paper_list.jsp');
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
					location.href="/asanway/cyber/cyber_scrap_paper_read.jsp?idx=<%=request.getAttribute("idx")%>";
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
					location.href="/asanway/cyber/cyber_scrap_paper_list.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>
<% } %>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 20��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
* 2005/11/12 : ����� : �亯�� �Խ������� ����
******************************************/
%>

<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.admin.NoticeBean" %>

<%
	String category = "adminbbs";
	String cmd = request.getParameter("cmd");
	String dirName = WEBConstants.ADMINNOTICEUPLOADDIR;
	int maxFileSize = WEBConstants.ADMINNOTICEUPLOADMAX;

	NoticeBean bean = new NoticeBean(dirName,maxFileSize,category);
%>

<%
	if(cmd.equals("I") ) {
		int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				location.replace('/asanway/admin/admin_notice.jsp');
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
					location.href="/asanway/admin/admin_notice_read.jsp?idx=<%=request.getAttribute("idx")%>";
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
					location.href="/asanway/admin/admin_notice.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>
<% } %>
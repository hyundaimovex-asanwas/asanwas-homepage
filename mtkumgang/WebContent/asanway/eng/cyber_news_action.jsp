<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 11�� 17��
* ��� ���� : EngNotice - ���
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.eng.NewsBean" %>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "32";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("eng_main.jsp?flag=1");
	}
%>


<%
	String category = "engnews";
	String cmd = request.getParameter("cmd");
	String dirName = "";
	int maxFileSize = 0;

 	dirName		= WEBConstants.ENGNEWSUPLOADDIR ;
 	maxFileSize	= WEBConstants.ENGNEWSUPLOADMAX ;

	NewsBean bean = new NewsBean(dirName,maxFileSize,category);
%>
<%
if(cmd.equals("I") ) {
	int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				location.href="/asanway/eng/cyber_news_list.jsp";
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
					location.href="/asanway/eng/cyber_news_read.jsp?idx=<%=request.getAttribute("idx") %>";
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
					location.href="/asanway/eng/cyber_news_list.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } %>
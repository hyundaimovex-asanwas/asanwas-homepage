<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 12�� 08��
* ��༳�� : ������ ȸ�� ����  ��� /����/����
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>


<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.member.HrMemberBean" %>

<%@include file="/asanway/common/head.jsp"%>

<%
	HrMemberBean ab = new HrMemberBean();
	String cmd = request.getParameter("cmd");
%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>

<% if( cmd.equals("I") ) {
			int result = ab.Insert(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('��� �Ǿ����ϴ�.');
					location.replace("/asanway/member/member_hr_list.jsp");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("U") ) {
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.replace("/asanway/member/member_hr_read.jsp?idx=<%=request.getAttribute("idx")%>");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("D") ) {
			int result = ab.Delete(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					location.replace("/asanway/member/member_hr_list.jsp");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>
<% } else if( cmd.equals("DA") ) {
			int result = ab.DeleteAll(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					location.replace("/asanway/member/member_hr_list.jsp");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>
<% } %>
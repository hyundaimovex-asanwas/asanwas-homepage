<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 28��
* ��༳�� : ȸ������  ��� /����/����
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>


<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.asanway.member.MemberBean" %>

<%@include file="/asanway/common/head.jsp"%>

<%
	MemberBean ab = new MemberBean();
	String cmd = request.getParameter("cmd");
	String mtype = request.getParameter("mtype");
%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>

<% if( cmd.equals("U") ) {
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.replace("/asanway/member/member_general_read.jsp?mtype=<%=mtype%>&idx=<%=request.getAttribute("idx")%>");
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
					location.replace("/asanway/member/member_general_list.jsp?mtype=<%=mtype%>");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("UL") ) {
			int result = ab.UpdateLevel(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					parent.location.reload();
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
				</script>
		<% } %>
<% } %>
<%
/****************************************
*
* �� �� �� : ������
* �ۼ����� : 2005�� 5�� 11��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="com.hmm.asan.board.BoardBean" %>

<%
	BoardBean bb = new BoardBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("Insert") ) {
	int result = bb.Insert(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			//alert('��ϵǾ����ϴ�.');
			location.href="/admin/newsroom/notice/notice_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>


<% } else if( cmd.equals("Update") ) {
			int result = bb.Update(request, response);
%>
	<% if(result > 0 ) { %>
			<script language=javascript>
				//alert('�����Ǿ����ϴ�.');
				location.href="/admin/newsroom/notice/notice_read.jsp?idx=<%= result %>";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� �������� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>


<% } else if( cmd.equals("Delete") ) {
			int result = bb.Delete(request, response);
%>
	<% if(result > 0 ) { %>
			<script language=javascript>
				//alert('�����Ǿ����ϴ�..');
				location.href="/admin/newsroom/notice/notice_list.jsp";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� �������� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>
<% } %>
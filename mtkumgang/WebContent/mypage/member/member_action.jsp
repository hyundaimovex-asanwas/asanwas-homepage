<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.01
  - ���۱� ǥ��: IMJ Korea
  - ����: ȸ������  ��� /����/ ���̵� ã�� / ��й�ȣ ã�� / ȸ�� Ż��
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.www.member.MemberBean" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%@ include file="/common/properties.jsp" %>
<%
	MemberBean ab = new MemberBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("I") ) {				//ȸ������
	int result = ab.Insert(request, response);
%>
	<% if(result > 0 ) { %>
			<form name="form" method=post action="/member/join_complete.jsp">
				<input type=hidden name=name value="<%=request.getParameter("name")%>">
				<input type=hidden name=id value="<%=request.getParameter("id")%>">
				<input type=hidden name=pwd value="<%=request.getParameter("pwd")%>">
				<input type=hidden name=domain value="<%=ROOT_DNS%>">
			</form>
			<script language=javascript>
				document.form.submit();
			</script>

	<% } else if(result == -2) {	%>
			<script language=javascript>
				alert('�̹� ���Ե� �ֹε�� ��ȣ �Դϴ�.');
				history.go(-2);
			</script>

	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('������� ID�Դϴ�.');
				history.go(-2);
			</script>
	<% } else { %>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-2);
			</script>
	<% } %>


<% } else if( cmd.equals("U") ) {			//ȸ������ ����
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.replace("/index.jsp");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("C") ) {				//ȸ������ üũ
			int result = ab.JoinConfirm(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�̹� ȸ�������ϼ̽��ϴ�.');
					location.replace("/member/login.jsp");
				</script>
		<% } else {	%>
				<form name="form" method=post action="/member/join_register.jsp">
					<input type=hidden name=name value="<%=request.getParameter("name")%>">
					<input type=hidden name=regno1 value="<%=request.getParameter("regno1")%>">
					<input type=hidden name=regno2 value="<%=request.getParameter("regno2")%>">
				</form>
				<script language=javascript>
					document.form.submit();
				</script>
		<% } %>

<% } else if( cmd.equals("IS") ) {				//id search
			int result = ab.IdSearch(request, response);
%>
	
		<form name="form" method=post action="/member/id_search_result.jsp">
			<input type=hidden name=result value="<%=result%>">
			<input type=hidden name=cmd value="<%=cmd%>">
			<input type=hidden name=name value="<%=request.getParameter("name")%>">
			<input type=hidden name=id value="<%=request.getAttribute("id")%>">
		</form>
		<script language=javascript>
				document.form.submit();
		</script>


<% } else if( cmd.equals("PS") ) {				//pwd search
			int result = ab.PwdSearch(request, response);
%>	
			<form name="form" method=post action="/member/id_search_result.jsp">
				<input type=hidden name=result value="<%=result%>">
				<input type=hidden name=cmd value="<%=cmd%>">
				<input type=hidden name=semail value="<%=request.getParameter("semail")%>">
			</form>
			<script language=javascript>
				document.form.submit();
			</script>

<% } if(cmd.equals("D") ) {	//ȸ��Ż��
	int result = ab.Withdrawal(request, response);
%>
	<% if(result > 0 ) {
			//logout ó��
			LoginBean lb = new LoginBean();
			lb.Logout(request, response);
	%>
			<script language=javascript>
				window.open("popup_leave_confirm.jsp","lostMem","width=450,height=310,top=200,left=200,scrollbars=no");
				location.replace("/index.jsp");
			</script>

	<% } else if(result == -1) {	%>
	
			<script language=javascript>
				alert('�α����� ���̵�� �Է��Ͻ� ���̵� ��ġ ���� �ʽ��ϴ�.');
				history.go(-1);
			</script>

	<% } else { %>
	
			<script language=javascript>
				alert('�Է��Ͻ� ������ ��ġ�ϴ� ȸ�������� �����ϴ�.');
				history.go(-1);
			</script>
			
	<% } %>
	
<% } %>
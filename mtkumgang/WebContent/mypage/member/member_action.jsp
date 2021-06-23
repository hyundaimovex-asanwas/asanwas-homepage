<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.01
  - 저작권 표시: IMJ Korea
  - 설명: 회원정보  등록 /수정/ 아이디 찾기 / 비밀번호 찾기 / 회원 탈퇴
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
if(cmd.equals("I") ) {				//회원가입
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
				alert('이미 가입된 주민등록 번호 입니다.');
				history.go(-2);
			</script>

	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('사용중인 ID입니다.');
				history.go(-2);
			</script>
	<% } else { %>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-2);
			</script>
	<% } %>


<% } else if( cmd.equals("U") ) {			//회원정보 변경
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					location.replace("/index.jsp");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("C") ) {				//회원가입 체크
			int result = ab.JoinConfirm(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('이미 회원가입하셨습니다.');
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

<% } if(cmd.equals("D") ) {	//회원탈퇴
	int result = ab.Withdrawal(request, response);
%>
	<% if(result > 0 ) {
			//logout 처리
			LoginBean lb = new LoginBean();
			lb.Logout(request, response);
	%>
			<script language=javascript>
				window.open("popup_leave_confirm.jsp","lostMem","width=450,height=310,top=200,left=200,scrollbars=no");
				location.replace("/index.jsp");
			</script>

	<% } else if(result == -1) {	%>
	
			<script language=javascript>
				alert('로그인한 아이디와 입력하신 아이디가 일치 하지 않습니다.');
				history.go(-1);
			</script>

	<% } else { %>
	
			<script language=javascript>
				alert('입력하신 정보와 일치하는 회원정보가 없습니다.');
				history.go(-1);
			</script>
			
	<% } %>
	
<% } %>
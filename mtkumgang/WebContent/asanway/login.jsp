<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 11일
* 요약설명 :로그인 처리
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="com.hmm.asan.asanway.admin.LoginBean" %>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	String url = request.getParameter("url");

	if(url == null || url.trim().equals("")) {
		url = "/asanway/admin/admin_main.jsp";
	}

	String query = request.getParameter("query");
	if(query == null || query.trim().equals("")) {
		query = "";
	}
	query = query.replaceAll("/", "&");

	LoginBean lb = new LoginBean();

	int result = lb.Login(request, response);
%>

<% if(result == 1 ) { %>
<!-- 정상인 경우 -->
		<script language=javascript>
			<%if(url != null && !url.trim().equals("")) { %>
				location.href="<%=url%>?<%=query%>";
			<% } else { %>
				location.href="/asanway/main.jsp";
			<% } %>

		</script>

<% } else if(result == 0) { %>
<!-- 등록된 ID가 아닌경우 -->
		<script language=javascript>
			alert('등록된 ID가  아닙니다.');
			history.go(-1);
		</script>

<% } else { %>
<!-- 비밀번호가 틀린경우  -->
		<script language=javascript>
			alert('비밀번호를 확인하세요!');
			history.go(-1);
		</script>

<% } %>
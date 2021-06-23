<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 11일
* 요약설명 : 관리자 로그인 체크
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%
	response.setHeader("Pragma","No-cache");
	response.setDateHeader("Expires",0);
	response.setHeader("Cache-Control","no-cache");

	String request_uri = request.getRequestURI();
	if(request_uri == null) request_uri = "";
	String request_query = request.getQueryString();
	if(request_query == null) request_query = "";
	request_query = request_query.replaceAll("&", "/");
%>

<%
	if(session == null){
			response.sendRedirect("/asanway/admin_login.jsp?url=" + request_uri + "&query=" + request_query);
			return;
	}

	String adminlogin = (String)session.getAttribute("adminidx");
		if(adminlogin == null || adminlogin.trim().equals("") || adminlogin.trim().equals("null")){
			response.sendRedirect("/asanway/admin_login.jsp?url=" + request_uri + "&query=" + request_query);
			return;
		}

	String menuidx = "";
%>

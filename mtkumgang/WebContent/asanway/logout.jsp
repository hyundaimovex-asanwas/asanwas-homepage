<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 11일
* 요약설명 :관리자 로그 아웃
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>


<%@ page import="com.hmm.asan.asanway.admin.LoginBean" %>

<%
	response.setHeader("Pragma","No-cache");
	response.setDateHeader("Expires",0);
	response.setHeader("Cache-Control","no-cache");
%>
<%
	LoginBean lb = new LoginBean();

	lb.Logout(request, response);

	response.sendRedirect("/asanway/admin_login.jsp");
%>
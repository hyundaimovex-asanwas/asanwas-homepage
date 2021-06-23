<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.05
  - 저작권 표시: IMJ Korea
  - 설명: 로그아웃을 처리한다. session 삭제한다.
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%

	response.setHeader("Pragma","No-cache");
	response.setDateHeader("Expires",0);
	response.setHeader("Cache-Control","no-cache");

	LoginBean lb = new LoginBean();

	lb.Logout(request, response);

	//response.sendRedirect("/index.jsp");

	out.println(" logout do not redirect ");
%>
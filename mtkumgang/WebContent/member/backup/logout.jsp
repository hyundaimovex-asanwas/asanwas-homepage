<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.05
  - ���۱� ǥ��: IMJ Korea
  - ����: �α׾ƿ��� ó���Ѵ�. session �����Ѵ�.
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
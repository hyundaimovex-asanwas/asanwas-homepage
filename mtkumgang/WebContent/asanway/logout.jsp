<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 11��
* ��༳�� :������ �α� �ƿ�
*
*
* �����ð�  : ������ : ��������
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
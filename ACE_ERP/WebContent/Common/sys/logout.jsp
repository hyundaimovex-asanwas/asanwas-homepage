<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="common.sys.HdasanLogin" %>
<%
	String dirPath = request.getContextPath(); //HDASan
	
	HdasanLogin hl = new HdasanLogin();
	hl.Logout(request, response);
	response.sendRedirect(dirPath+"/newIndeX.jsp");
	//�� ���������� 
%>
<script >
//	location.href="https://biz.hdasan.com:448/";
</script>


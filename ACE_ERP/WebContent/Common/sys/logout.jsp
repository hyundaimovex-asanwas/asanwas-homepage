<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="common.sys.HdasanLogin" %>
<%
	String dirPath = request.getContextPath(); //HDASan
	
	HdasanLogin hl = new HdasanLogin();
	hl.Logout(request, response);
	response.sendRedirect(dirPath+"/newIndeX.jsp");
	//왜 서버에서는 
%>
<script >
//	location.href="https://biz.hdasan.com:448/";
</script>


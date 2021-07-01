
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	String jumin1 = request.getParameter("jumin1");
	String jumin2 = request.getParameter("jumin2");
	String name = request.getParameter("name");
%>
<html>
	<head>
	</head>
	<body onload="http://www.mtkumgang.com/webCom/cNameCheck.asp?Jumin1=<%=jumin1%>&Jumin2=<%=jumin2%>&Name=<%=name%>">
	</body>
</html>
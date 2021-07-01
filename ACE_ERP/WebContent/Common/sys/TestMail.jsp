<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hdasan.util.AriveSendMail" %>

<%
	AriveSendMail asm  = new AriveSendMail();
//	int result = asmn.Insert(request, response);
	asm.TestMail(request, response, "title", "content", "regname", "regemail");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
        <title></title>
    </head>
    <body>xHTML 1.0 strict !
    </body>
</html>

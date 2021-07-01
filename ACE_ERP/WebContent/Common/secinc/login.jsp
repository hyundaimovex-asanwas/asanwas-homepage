
<%@ page 
language="java"
contentType="text/html; charset=EUC-KR"
pageEncoding="EUC-KR"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Using JCaptcha - A Simple Captcha Servlet</title>
<style type="text/css">
td
{ font-family: Verdana, Tahoma, Arial, Helvetica; font-size: 10pt;
  background-color: #FFFFFF; margin-left: 0pt
}
</style>
</head>
<body>
<h2>Using JCaptcha: A Simple Captcha Servlet</h2>
<form name="SimpleServletForm" action="/captcha-demos/simple" method="post">
<input type="hidden" name="hidCaptchaID" value="<%= session.getId() %>"/>
<table border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>Username:</td>
    <td align="center"><input type="text" name="inUsername" value="joeuser"/></td>
  </tr>
  <tr>
    <td>Password:</td>
    <td align="center"><input type="password" name="inPassword"
    value="somepassword"/></td>
  </tr>
  <tr>
    <td valign="middle">Enter these letters:<br/>
    <img src="/captcha-demos/simple" align="middle" alt="Enter the
    characters appearing in this image" border="1"/></td>
    <td><input type="text" name="inCaptchaChars"/></td>
  </tr>
  <tr>
    <td colspan="2" align="right"><input type="submit"
    value="Submit"/></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><br/><br/>(refresh
    page to generate a new image)</td>
  </tr>
</table>
</form>
</body>
</html>
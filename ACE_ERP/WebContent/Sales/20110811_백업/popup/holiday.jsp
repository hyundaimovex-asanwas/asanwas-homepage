<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, java.io.*, java.util.* " %>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
    String caln_date  = request.getParameter("caln_date");
    String id  = request.getParameter("id");
    String yoil_cd  = request.getParameter("yoil_cd");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>소피아그린cc</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <script language="javascript">
    <!--
     function send() 
     { 
        form1.action = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Holiday";
        form1.target="holi_proc";
        form1.submit();
        opener.document.getElementById('<%=id%>').style.backgroundColor  = "#ff0000";
        self.close();
     } 
    //-->  
  </script>
<style type="text/css">
<!--
td {
	font-size: 9pt;
	line-height: 130%;
}
-->
</style>
<style type="text/css">
<!--
a {
	color: #FFFFFF;
	text-decoration: none;
}
-->
</style>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="114" border="0" cellspacing="0" cellpadding="0">
<form name="form1">
  <input type="hidden" name="proType" value="I">
  <input type="hidden" name="caln_date" value="<%=caln_date%>">
  <input type="hidden" name="yoil_cd" value="<%=yoil_cd%>">
  <tr> 
    <td><table width="300" height="400" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td align="center" valign="top" >
            <table width="235" height="220" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="40">휴일명 : </td>
                <td height="40"> <input type="text" name="holiday_nm"></td>
              </tr>
              <tr> 
                <td colspan="2" valign="top"> </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
  	<td height="25" align="right" bgcolor="404040"><a href="javascript:send();">저장</a></td>
  </tr>
  </form>
</table>
<iframe name="holi_proc" width="0" height="0"></iframe>
</body>
</html>
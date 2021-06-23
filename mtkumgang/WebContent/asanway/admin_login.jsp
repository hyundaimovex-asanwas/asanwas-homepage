<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 11일
* 요약설명 : 관리자 로그인 폼
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="euc-kr" %>

<%
	String url = request.getParameter("url");
	if(url == null || url.trim().equals("")) {
		url = "/asanway/admin/admin_main.jsp";
	}

	String query = request.getParameter("query");
	if(query == null || query.trim().equals("")) {
		query = "";
	}

	String adminlogin = (String)session.getAttribute("adminidx");
	if(adminlogin != null && !adminlogin.trim().equals("")) {
		response.sendRedirect("/asanway/admin/admin_main.jsp");
	}
%>

<html>
<head>
<title>" 현대아산 : Administrator "</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/asanway/css/style.css" type="text/css">
</head>
	<script language="javascript">
		<!--
		function loginSubmit()
		{
			if(document.login.id.value=="")
			{
				alert("ID를 입력해주세요");
				document.login.id.focus();
				return;
			}

			if(document.login.password.value=="")
			{
				alert("비밀번호를 입력해주세요.");
				document.login.password.focus();
				return;
			}
			document.login.submit();

		}
		//-->
	</script>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0" onload="document.login.id.focus();">

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td align="center" valign="middle">
	  <table width="440" height="190" border="0" cellpadding="0" cellspacing="0" style="border-style:solid; border-color:#EEEED8; border-width:2;">
        <tr>
          <td valign="top" style="padding-top:35;">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center"><img src="img/login_main_01.gif" width="403" height="38"></td>
              </tr>
              <tr>
                <td height="25"></td>
              </tr>
              <tr>
                <td>
                  <table width="100%"  border="0" cellpadding="0" cellspacing="0">

                    <form name="login" method="post" action="login.jsp">
						<input type="hidden" name="url" value="<%=url%>">
						<input type="hidden" name="query" value="<%=query%>">
                    <tr>
                      <td height="40" align="center"  style="padding-right:15;">
                        <table  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="85"><b>ID</b> </td>
                            <td> <input type="text" name="id" class="log_input" style="width:176px; height:20px;" onKeyPress="if (event.keyCode==13) loginSubmit();"  tabindex=1></td>
                            <td rowspan="2"><a href="javascript:loginSubmit()"><img src="img/bt_login.gif" width="55" height="42" hspace="5" border="0" tabindex=3></a></td>
                          </tr>
                          <tr>
                            <td><b>PASSWORD</b> </td>
                            <td> <input type="password" name="password" class="log_input" style="width:176px; height:20px;" onKeyPress="if (event.keyCode==13) loginSubmit();"  tabindex=2></td>
                          </tr>
                        </table>
                       </td>
                    </tr>
                    </form>

                  </table>
                 </td>
              </tr>
            </table>
           </td>
        </tr>
      </table>
    </td>
  </tr>
</table>


</body>
</html>


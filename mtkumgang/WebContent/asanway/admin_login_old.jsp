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
		url = "/asanway";
	}

	String query = request.getParameter("query");
	if(query == null || query.trim().equals("")) {
		query = "";
	}

	String adminlogin = (String)session.getAttribute("adminidx");
	if(adminlogin != null && !adminlogin.trim().equals("")) {
		response.sendRedirect("/asanway/main.jsp");
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

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td align="center" valign="middle">
      <table width="628" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="628"><img src="/asanway/img/login_img_01.gif" width="848" height="208"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="/asanway/img/login_img_02.gif" width="383" height="92"></td>
                <td>

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">

                    <form name="login" method="post" action="login.jsp">
						<input type="hidden" name="url" value="<%=url%>">
						<input type="hidden" name="query" value="<%=query%>">
                    <tr>
                      <td width="290" height="92" align="center" background="/asanway/img/login_img_05.gif">
                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><img src="/asanway/img/login_01.gif" width="21" height="7" align="absmiddle">
                              <input type="text" name="id" class="log_input" style="width:100px; height:18px;" onKeyPress="if (event.keyCode==13) loginSubmit();"  tabindex=1>
                            </td>
                            <td rowspan="2"><a href="javascript:loginSubmit()"><img src="/asanway/img/bt_login.gif" width="55" height="42" border="0" tabindex=3></a></td>
                          </tr>
                          <tr>
                            <td><img src="/asanway/img/login_02.gif" width="21" height="7" align="absmiddle">
                              <input type="password" name="password" class="log_input" style="width:100px; height:18px;" onKeyPress="if (event.keyCode==13) loginSubmit();"  tabindex=2>
                            </td>
                          </tr>
                        </table>
                       </td>
                    </tr>
                    </form>

                  </table>
                 </td>
                <td align="right"><img src="/asanway/img/login_img_03.gif" width="175" height="92"></td>
              </tr>
            </table>
           </td>
        </tr>
        <tr>
          <td><img src="/asanway/img/login_img_04.gif"></td>
        </tr>
      </table>

    </td>
  </tr>
</table>
</body>
</html>


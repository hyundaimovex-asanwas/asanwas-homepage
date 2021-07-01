<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 로그인 포탈
 * 프로그램ID 	: PcOffLogin
 * J  S  P		: PcOffLogin.jsp
 * 작 성 자		: 이동훈
 * 작 성 일		: 2020-04-01
 * 기능정의		: PcOffLogin
 * [2020-04-01] [이동훈] 로그인 화면 정의
 *****************************************************************************/
%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<%@ page import="sales.common.HDUtil" %>

<%

	String login_attempt1 	= (String)session.getAttribute("login_attempt");

	if (login_attempt1==null || login_attempt1==""){
		
		login_attempt1 ="1";
		
	}
	
	int login_attempt       = Integer.parseInt(login_attempt1);
	
	String ssID 			= session.getId();	//페이지 이동간 세션ID get
	
	boolean remotePosition = false;	
			
	String PCOFF = "PCOFF";
	
%>



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<title>연장근무신청</title>
		<link rel="shortcut icon" href="<%=dirPath%>/Common/img/iconlogo.jpg" />
		<link href="<%=dirPath%>/Common/css30/intro.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" src="<%=dirPath%>/Common/js/intro.js"></script>
	</head>


<BODY border="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">

<table border="0" cellpadding="0" cellspacing="0" width="100%"align="left">

  <tr>
  	<td width="2000" height="900" style="background:url(<%=dirPath%>/Common/img/bg_login.jpg);">
		<form method="POST" action="<%=dirPath%>/arivels" name="form" onSubmit="return form_submit();">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="login_attempt" type="hidden" value="<%=login_attempt%>" />
			<input name="remotePosition" type="hidden" value="<%=remotePosition%>" />
			<input name="PCOFF" type="hidden" value="<%=PCOFF%>" />
			
		<table cellspacing="0" border = '0' align=center>
			<tr>
				<td><label for="txt_id">아이디</label></td>
				<td><label for="txt_pass">비밀번호</label></td>
			</tr>
			<tr>
				<td><input type="text" class="inputtext" name="txt_id" id="txt_id" tabindex="1" value="" /></td>
				<td><input type="password" class="inputtext" name="txt_pass" id="txt_pass" tabindex="2" value="" /></td>
				<td><label class="uiButton uiButtonConfirm" for="u752837_5"><input value="로그인" tabindex="4" type="submit" id="u752837_5" /></label></td>
			</tr>
			
			<tr>
				<td>
					<input type="checkbox" class="inputcheckbox" value="1" id="saveID" name="saveID" checked="1" />
					<input type="hidden" name="default_persistent" value="1" />
					아이디 저장</td>
			</tr>
			<tr>
			  	<td>
			  	</td>
			  	<td></td>
			  	<td>※ 본 시스템은 회사의 업무용 어플리케이션입니다.<br/>
				　 불법적인 로긴 시도 및 사용에 대해서는 관련 법에 의거<br/>
				　　<b>처벌</b>을 받을 수 있습니다.<br/>
				　 로그인 후 활동 및 접속 기록이 유지/관리됩니다.<br/><br/>
			  	</td>
			</tr>
		</table>
		</form> 
  	</td>
  </tr>

</table>

</BODY>
</HTML>


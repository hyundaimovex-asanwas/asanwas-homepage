<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 로그인
 * 프로그램ID 	: newLogin
 * J  S  P		: newLogin.jsp
 * 작 성 자		: 심동현
 * 작 성 일		: 2011-08-12
 * 기능정의		: 로그인 페이지
 * [ 수정일자 ][수정자] 내용
 * [2011-08-08][심동현] 디자인 변경, 스크립트 간소화 
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
	String result 			= HDUtil.nullCheckStr(request.getParameter("result")); 
	String ssID 			= HDUtil.nullCheckStr(session.getId());	//페이지 이동간 세션ID get
	String msg 				= (String)session.getAttribute("loginMSG");;
	

	login_attempt=1;	//캡차 수정까지 고정 값...

	if(login_attempt>3){
		msg=msg+"<br/>로그인 시도가 4회 이상인 경우, <br/>그림문자를 함께 입력하셔야 로그인할 수 있습니다.";
	};

	boolean remotePosition = true;	//외부접속?
	String remoteAddr = (String)request.getRemoteAddr().substring(0,9);
	if(remoteAddr.equals("10.61.108") || remoteAddr.equals("10.61.107") || remoteAddr.equals("10.61.106") || remoteAddr.equals("10.31.102") || remoteAddr.equals("172.22.2.") || remoteAddr.equals("172.23.2.") ){
		remotePosition = false;	//연지동사옥(6,7,8층), 투어센터, 고성, 도라산 사무소
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<title>　로그인 |  (<%=login_attempt%>)</title>
		<link href="<%=dirPath%>/Common/css30/intro.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" src="<%=dirPath%>/Common/js/intro.js"></script>
		<script language="javascript">
			function reImg(){
			
				document.form.capImg.src="<%=dirPath%>/Common/img/disabled.gif";
				setTimeout("document.form.capImg.src='<%=dirPath%>/arivels'",30)	;
			}
		</script>	
	</head>

<BODY border="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">

<table border="0" cellpadding="0" cellspacing="0" width="100%"align="left">
  <tr>
  	<td width="290" height="10"></td>
  	<td width="100"></td>
  	<td width="100%"></td>
  </tr>
  <tr>
  	<td><img src="<%=dirPath%>/Common/img/intro2_1.gif" alt="2_1" width="290" height="98"  /></td>
  	<td align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=dirPath%>/Sales/images/attention_Mark.jpg" alt="attention"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  	<td><label ><h3>로그인 시도 <%=login_attempt%> 회</h3></label>
  		<%=msg%></td>
  </tr>
  <tr>
  	<td height="130"><img src="<%=dirPath%>/Common/img/intro2_2.gif" alt="2_2" width="290" height="130"  /></td>
  	<td style="background-color:#187DFF"></td>
  	<td style="background-color:#187DFF">

		<form method="POST" action="<%=dirPath%>/arivels" name="form" onSubmit="return form_submit();">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="login_attempt" type="hidden" value="<%=login_attempt%>" />
			<input name="remotePosition" type="hidden" value="<%=remotePosition%>" />
		<table cellspacing="0" border="0">
			<tr>
				<td class="html7magic"><label for="txt_id">아이디</label></td>
				<td class="html7magic"><label for="txt_pass">비밀번호</label></td>
			</tr>
			<tr>
				<td><input type="text" class="inputtext" name="txt_id" id="txt_id" tabindex="1" /></td>
				<td><input type="password" class="inputtext" name="txt_pass" id="txt_pass" tabindex="2" /></td>
				<td><label class="uiButton uiButtonConfirm" for="u752837_5"><input value="로그인" tabindex="4" type="submit" id="u752837_5" /></label></td>
			</tr>
			<tr>
				<td class="login_form_label_field"><input type="checkbox" class="inputcheckbox" value="1" id="saveID" name="saveID" checked="1" />
					<input type="hidden" name="default_persistent" value="1" />
					<label id="label_persistent" for="saveID">아이디 저장</label></td>
				<td class="login_form_label_field"><a href="<%=dirPath%>/newPwd1.jsp" rel="nofollow">비밀번호를 잊으셨나요?</a></td>
			</tr>
			<%	if(login_attempt>3){%>
			<tr>
			    <td class="login_form_label_field"><label>아래 그림문자를 넣어주세요.</label></td>
			    <td><input type="text" class="inputtext" name="inCaptchaChars" tabindex="3" /></td>
			</tr>
			<%	}%>
		</table>

  	</td>
  </tr>
  <tr>
  	<td valign="top"><img src="<%=dirPath%>/Common/img/intro2_3.gif" alt="2_3" width="290" height="29" /></td>
  	<td></td>
  	<td><%	if(login_attempt>3){%>
	  	<table cellspacing="0" cellpadding="4">
	  		<tr>
	  			<td style="width:84px;cursor:hand;" align="center"  onclick="reImg();"><b>Click</b><br/>그림문자</br>새로고침</td>
	  			<td><img src="<%=dirPath%>/arivels" align="middle" alt="이 문자를 입력해 주세요." id="capImg" style="border:1 solid #1d2a5b;width:200px;height:100px" /></td>
	  		</tr>
	  	</table>
	  	<%}%>
		</form> 
  	</td>
  </tr>
  <tr>
  	<td></td>
  	<td></td>
  	<td>※ 본 시스템은 회사의 업무용 어플리케이션입니다.<br/>
	　 불법적인 로긴 시도 및 사용에 대해서는 관련 법에 의거<br/>
	　　<b>처벌</b>을 받을 수 있습니다.<br/>
	　 로그인 후 활동 및 접속 기록이 유지/관리됩니다.<br/><br/>
	※ It will be punished for illegal login to this system.<br/>
	　 It is saved for login information in another system.<br/>
  	</td>
  </tr>
</table>

</BODY>
</HTML>

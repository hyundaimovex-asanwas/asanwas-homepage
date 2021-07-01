<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 로그인 포탈
 * 프로그램ID 	: newIndeX
 * J  S  P		: newIndeX.jsp
 * 작 성 자		: 심동현
 * 작 성 일		: 2010-09-08
 * 기능정의		: 트리메뉴 적용한 erp 공통포탈
 * [ 수정일자 ][수정자] 내용
 * [2011-06-01][심동현] UI는 1024*768 최소 기준. 테스트해볼 것~
 * 이 페이지에는 네이버에서 제공한 나눔글꼴이 적용되어 있습니다 - 해보자
 * [2011-08-08][심동현] 디자인 변경, 스크립트 간소화 
 * [2011-10-26][심동현] 로그인 버튼 클릭했을 때 새 세션값 받아오기로 수정
 * [2012-01-27][심동현] 컴포넌트 설치+브라우저 사용 수락용 페이지  링크 추가
 * [2013-11-11][심동현] test-erp에 올리는 중.. 리모트ip 체크가 또 색다르군, String.contains 로 해결!
 * [2014-01-17][심동현] 디자인 레이아웃 변경
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
	
	boolean remotePosition = true;	//외부접속?
	String remoteAddr = (String)request.getRemoteAddr();	// local 테스트용
	//String remoteAddr = (String)request.getHeader("Proxy-Client-IP");	// 서버용
	//String remoteAddr = (String)request.getHeader("X-Forwarded-For");	// 서버용
	//request.getHeader("WL-Proxy-Client-IP")
	
	//String remoteAddr = (String)request.getRemoteAddr().substring(0,9);
	if(remoteAddr.contains("203.242.40.26") || 
			remoteAddr.contains("203.242.40.27") || 
			remoteAddr.contains("10.61.108.") || 
			remoteAddr.contains("10.61.107.") || 
			remoteAddr.contains("10.61.106.") || 
			remoteAddr.contains("10.31.102.") || 
			remoteAddr.contains("172.22.2.") || 
			remoteAddr.contains("172.23.2.") ){
			remotePosition = false;	//연지동사옥(6,7,8층), 투어센터, 고성, 도라산 사무소
	}
			remotePosition = false;	//실명확인 될 때까징
//=remoteAddr<br>
//=remotePosition <br>
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<title>열려라 금강산!!!</title>
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
				<td>접속 IP : <%=remoteAddr%></td>
			</tr>
			 
			<tr>
			  	<td>
			  	
			  	<a href="newAX3.jsp" target="_blank">컴포넌트 인스톨 링크(버전 3)</a><br/>
			  	<a href="newAX5.jsp" target="_blank">컴포넌트 인스톨 링크(버전 5)</a><br/><br/><br/><br/><br/>
			  	
			  	</td>
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
		</form> 
  	</td>
  </tr>

</table>

</BODY>
</HTML>

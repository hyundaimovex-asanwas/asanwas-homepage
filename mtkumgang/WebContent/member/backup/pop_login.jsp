<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.12
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.12
  - 저작권 표시: IMJ Korea
  - 설명: 팝업 로그인
			action page : login_ok.jsp 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%
	String sErrStr = request.getParameter("sErrStr");
	if(sErrStr == null || sErrStr.trim().equals("")) {
		sErrStr = "1";
	}

	//쿠키생성시 도메인
	String sDomain = ROOT_DNS;
%>


<script language="javascript">
<!--
	function checkForm(){

		var form = document.form;

		if( form.id.value=="" ){
			alert("ID를  입력해 주십시오.");
			form.id.focus();
			return false;
		}

		if( form.pwd.value=="" ){
			alert("비밀번호를   입력해 주십시오.");
			form.pwd.focus();
			return false;
		}

		return true;
	}

	function openr_herf(url)
	{
		if (opener)
		{
			opener.location.href= url;
			this.close();
		}
	}
  
//-->
</script>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">


<!----- //CONTENTS START----->
      <table border="0" cellpadding="0" cellspacing="0" width="644" id='tarea'>
      <tr>
      	<td align="center">
      
      	<!----- CONTENTS START----->
      	<table border="0" cellpadding="0" cellspacing="0" width="624" height="190" style="border:4 solid #EEEED8">
      	<tr>
      		<td align="center">
				<form name=form method=post action=login_ok.jsp onSubmit="return checkForm();">
				<input type=hidden name=popuplogin value="1">
				<div id="showstr">
							<b>"금강산관광 홈페이지 방문을 환영합니다"</b><br>
							로그인을 하시면 금강산 관광 홈페이지에서 제공하는 다양한 정보는 물론,...... <br><br>
				</div>
				<!-- 내용 문구및 에러 문구 출력 -->
				
				<script>
					var sShowString = "<%=sErrStr%>";
					if ( sShowString == "2" ) //id error
					{
						showstr.innerHTML = "<b>\"등록되지 않은 아이디입니다.\"</b>"
																			+"<br>회원아이디를 확인하시고 다시 로그인하여 주십시오.";
																			+"<br>아이디가 기억나지 않으실 경우, 하단의 '아이디 찾기' 버튼을 클릭하세요.";
																			+"<br><br>";
					}
					else if ( sShowString == "3" ) //password error
					{
						showstr.innerHTML = "<b>\"비밀번호가 일치하지 않습니다.\"</b>"
																			+"<br>회원님의 비밀번호를 확인하시고 다시 로그인하여 주십시오.";
																			+"<br>비밀번호가 기억나지 않으실 경우, 하단의 '비밀번호 찾기' 버튼을 클릭하세요.";
																			+"<br><br>";
					}
						
				</script>
				<!-- //내용 문구및 에러 문구 출력 -->
      			<!-- 로그인-->
      			<table border="0" cellpadding="0" cellspacing="0" width="">
					<input type=hidden name=domain value="<%=sDomain%>">
      			<tr height="26">
      				<td width="55" align="right" style="padding-right:15"><img src="/img/member/img_login_01.gif"></td>
      				<td width="190"><INPUT TYPE="text" NAME="id" style="width:175; height:18;" class="gray_input" onkeypress="if (13 == event.keyCode) checkForm();" tabindex="1"></td>
      				<td width="55" rowspan="2"><input type="image" src="/img/member/btn_login.gif" tabindex="3"></a></td>
      			</tr>
      			<tr height="26">
      				<td align="right" style="padding-right:15"><img src="/img/member/img_login_02.gif"></td>
      				<td><INPUT TYPE="password" NAME="pwd" style="width:175; height:18;" class="gray_input" tabindex="2" onkeypress="if (13 == event.keyCode) onSubmit='return checkForm();'"></td>
      			</tr>
      			</table>
      			<!-- //로그인-->
				</form>
      			<table border="0" cellpadding="0" cellspacing="0" width="580">
      			<tr><td height="15"></td></tr>
      			<tr>
      				<td height="1" bgcolor="#CECE9C"></td>
      			</tr>
      			<tr><td height="25"></td></tr>
      			</table>
      
      			<table border="0" cellpadding="0" cellspacing="0" width="">
      			<tr height="26">
      				<td width="360"><img src="/img/member/img_login_03.gif"></td>
      				<td width="76">
      				
					<a href="javascript:openr_herf('id_search.jsp')"><img src="/img/member/btn_sch_id.gif" alt='ID 찾기'></a>&nbsp;
					<a href="javascript:openr_herf('pwd_search.jsp')"><img src="/img/member/btn_sch_id.gif" alt='비밀번호 찾기'></a>
      				</td>
      			</tr>
      			<tr height="26">
      				<td><img src="/img/member/img_login_04.gif"></td>
      				<td><a href="javascript:openr_herf('join_agreement.jsp')"><img src="/img/member/btn_join.gif"></a></td>
      			</tr>
      			</table>
      		</td>
      </tr>
      </table>
      
     <!----- //CONTENTS END----->


</body>
</html>

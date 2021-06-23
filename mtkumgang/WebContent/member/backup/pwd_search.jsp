<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.05
  - 저작권 표시: IMJ Korea
  - 설명: 비밀번호 찾기
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<script language="javascript">
<!--
	function checkForm2(){

		var form = document.form2;
		if( form.id.value=="" ){
			alert("ID를  입력해 주십시오.");
			form.id.focus();
			return false;
		}

		if( form.name.value=="" ){
			alert("이름을  입력해 주십시오.");
			form.name.focus();
			return false;
		}

		if( form.regno1.value=="" || form.regno2.value==""){
			alert("주민번호를  입력해 주십시오.");
			form.regno1.focus();
			return false;
		}

		//이메일 확인
		if( form.semail.value==""  ){
			alert("이메일 주소를  입력해 주십시오.");
			form.semail.focus();
			return false;
		}
		else if(!CheckEmail(form.semail.value)){
			alert("올바른 이메일 주소가 아닙니다. 다시 입력해 주십시오.");
			form.semail.focus();
			return false;
		}
	}

//-->
</script>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">

<!----- //CONTENTS END----->
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="50"><tr><td></td></tr></table>

					<!--// 비밀번호 찾기-->
					<table border="0" cellpadding="0" cellspacing="0" width="510">
					<tr>
						<td style="padding-left:10"><img src="/img/member/img_search_0102.gif"></td>
					</tr>
					<tr><td height="5"></td></tr>
					</table>

					<form name=form2 method=post action=member_action.jsp onSubmit="return checkForm2();">
						<input type=hidden name=cmd value="PS">
					<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
					<tr>
						<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
					</tr>
					<tr>
						<td align="center">

						<table border="0" cellpadding="0" cellspacing="0">
						<tr height="26">
							<td align="right" style="padding-right:15"><img src="/img/member/img_login_01.gif"></td>
							<td><INPUT TYPE="text" NAME="id" style="width:175; height:18;" class="gray_input" tabindex=1></td>
						</tr>
						<tr height="26">
							<td width="78" align="right" style="padding-right:15"><img src="/img/member/img_join_0202.gif"></td>
							<td width="190"><INPUT TYPE="text" NAME="name" style="width:175; height:18;" class="gray_input" tabindex=2></td>
						</tr>
						<tr height="26">
							<td align="right" style="padding-right:15"><img src="/img/member/img_join_0203.gif"></td>
							<td>
								<INPUT TYPE="text" NAME="regno1" maxlength=6 style="width:80; height:18;" class="gray_input" onKeyup="movenext(this.form.regno1,this.form.regno2,6)" tabindex=3> -
								<INPUT TYPE="text" NAME="regno2" maxlength=7 style="width:80; height:18;" class="gray_input" tabindex=4>
							</td>
						</tr>
						<tr height="26">
							<td width="78" align="right" style="padding-right:15">이메일주소</td>
							<td width="190"><INPUT TYPE="text" NAME="semail" style="width:175; height:18;" class="gray_input" tabindex=5></td>
						</tr>												
						</table>

						</td>
					</tr>
					<tr>
						<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
					</tr>
					</table>
					<!-- Button-->
					<table border="0" cellpadding="0" cellspacing="0" width="510">
					<tr><td height="15"></td></tr>
					<tr>
						<td align="center"><input type=image src="/img/common/btn_submit.gif"></a>&nbsp;
						<a href="javascript:document.form2.reset();"><img src="/img/common/btn_rewrite.gif"></a></td>
					</tr>
					</table>
					</form>
					<!-- //Button-->
					<!-- //비밀번호 찾기-->

					<!----- //CONTENTS END----->

</body>
</html>

<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.14
  - 저작권 표시: IMJ Korea
  - 설명: 실명확인페이지 , 로직은 실명을 확인하지 않고 , 가입자에 주민번호와 이름을 가지고
			중복가입 확인 여부만을 처리한다. 향후 실명확인 시스템 연동시 이 페이지를 이용하면
			된다.
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import= "com.hmm.asan.common.util.Utility"%>
<%@ include file="/common/header.jsp" %>
<%
	//동의가 이루어 졌는지 확인 필요. step1
	String sRefUrl = "";
	if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	if ( sRefUrl.indexOf("join_agreement.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");

%>

<script language="javascript">
<!--

	function checkForm()
	{
		var form = document.form;
		if( form.name.value=="" )
		{
			alert("이름을  입력해 주십시오.");
			form.name.focus();
			return false;
		}

		var regno = form.regno1.value + form.regno2.value;
		if (!Jumin_Num_Check(regno) ) 
		{
			alert("유효하지 않은 주민등록번호입니다.");
			form.regno1.focus();
			return false;
		}
		return true;
	}

//-->
</script>
<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">


				<!----- Title----->
				<table border="0" cellpadding="0" cellspacing="0" width="644" background="/img/common/tit_bg.gif">
				<tr>
					<td width="10"><img src="/img/common/tit_left.gif"></td>
					<td><img src="/img/member/tit_01.gif"></td>
					<td align="right"><img src="/img/member/tit_img_01.gif"></td>
				</tr>
				</table>
				<!----- //Title----->
				
				<table border="0" cellpadding="0" cellspacing="0" width="644" height="20"><tr><td></td></tr></table>

				<table border="0" cellpadding="0" cellspacing="0" width="644"  id='tarea'>
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<!-- 단계-->
					<table border="0" cellpadding="0" cellspacing="0" width="">
					<tr align="center">
						<td width="83"><img src="/img/member/img_step01.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step02_on.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step03.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step04.gif"></td>
					</tr>
					</table>
					<!-- //단계-->
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="30"><tr><td></td></tr></table>

					<table cellpadding="0" cellspacing="0" width="624">
					<tr>
						<td width="9" valign="top"><img src="/img/common/bl03.gif"></td>
						<td class="ti_b">이용자 본인의 이름 및 주민등록번호를 정확히 입력해주시기 바랍니다. </td>
					</tr>
					<tr>
						<td colspan="2" height="8"></td>
					</tr>
					</table>

					<!-- 실명확인-->
					<table border="0" cellpadding="0" cellspacing="0" width="624" height="160" style="border:4 solid #EEEED8">
					<form name="form" method="post" action="member_action.jsp" onSubmit="return checkForm();">
					 		<input type = hidden name=cmd value="C">
					 		<input type = hidden name=mtype value="">
						<tr>
							<td align="center">
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="3"><img src="/img/member/img_join_0201.gif"></td>
								</tr>
								<tr><td colspan="3" height="15"></td></tr>
								<tr height="26">
									<td width="78" align="right" style="padding-right:15"><img src="/img/member/img_join_0202.gif"></td>
									<td width="190"><INPUT TYPE="text" NAME="name" maxlength=20  style="width:175; height:18;" class="gray_input" tabindex="1"></td>
									<td width="55" rowspan="2"><input type=image src="/img/member/btn_submit.gif" tabindex="4"></a></td>
								</tr>
								<tr height="26">
									<td align="right" style="padding-right:15"><img src="/img/member/img_join_0203.gif"></td>
									<td>
										<INPUT TYPE="text" NAME="regno1" maxlength=6 style="width:80; height:18;" class="gray_input" tabindex="2" onKeyup="movenext(this.form.regno1,this.form.regno2,6)"> -
										<INPUT TYPE="text" NAME="regno2" maxlength=7 style="width:80; height:18;" class="gray_input" tabindex="3" onkeypress="if (13 == event.keyCode) onSubmit='return checkForm();'">
									</td>
								</tr>
								</table>
							</td>
						</tr>
					</form>
					</table>
					<!-- //실명확인-->

					<!-- Button-->
					<table border="0" cellpadding="0" cellspacing="0" width="624">
					<tr><td height="15"></td></tr>
					<tr>
						<td><img src="/img/member/img_join_0204.gif"></td>
					</tr>
					</table>
					<!-- //Button-->

					<!----- //CONTENTS END----->

</body>
</html>

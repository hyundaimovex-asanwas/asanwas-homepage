<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.09
  - 최종 수정자 : 이소연
  - 최종 수정일 : 2006.08
  - 저작권 표시: IMJ Korea
  - 설명: 탈퇴하기
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/common/header.jsp" %>
<%
  String McNum = "0";
  String sub = "0";
  String pageNum = "4";
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>
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

		if( form.pwd.value==""  ){
			alert("비밀번호를  입력해 주십시오.");
			form.pwd.focus();
			return false;
		}
	
	}

//-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/mypage/tour_mypage_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
			<%@ include file="../../include/mypage/tour_mypage_left.jsp" %>
			<!--  left menu flash -->
            </td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_leave.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">마이페이지</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">회원탈퇴</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<form name=form2 method=post action=member_action.jsp onSubmit="return checkForm2();">
	<input type=hidden name=cmd value="D">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/mypage/img_top_mypage04.jpg"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_leave.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr><td height="35" align="right"><img src="<%=imageServer%>/tour_img/mypage/txt_leave2.gif" hspace="10"></td></tr>
						</table>

						<!-- / insert table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="114"><col width="1"><col width="565" class="lpad_10">
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist04.gif"><!-- 아이디 --></td>
							<td><input type="text" name="id" style="width:152px;" tabindex=1></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist01.gif"><!-- 이름 --></td>
							<td><input type="text" name="name" style="width:152px;" tabindex=2></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist02.gif"><!-- 주민등록번호 --></td>
							<td>
							  <input type="text" name="regno1" style="width:82px;" maxlength="6" onKeyup="movenext(document.form2.regno1,document.form2.regno2,6)" tabindex=3> - 
							  <input type="password" name="regno2" style="width:82px;" maxlength="7" onKeyup="movenext(this.form.regno2,this.form.pwd,7)"  tabindex=4>
							</td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist05.gif"><!-- 비밀번호 --></td>
							<td><input type="password" name="pwd" style="width:152px;" tabindex=5></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						</table>
						<!-- insert table / -->

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="15"></td></tr>
						<tr><td align="center">
						<input type=image src="<%=imageServer%>/tour_img/btn/btn_leavereq.gif">
						<!--<a href="/"><img src="<%=imageServer%>/tour_img/btn/btn_cancel.gif" class="btn"></a>-->
						</td></tr>
						</table>
					</td>
				</tr>
				</table>
</form>				
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->           
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
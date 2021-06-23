<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.DateUtils"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>금강산|개성 예약판매　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
<link rel="STYLESHEET" type="text/css" href="/asanway/img/tour_common/common.css">
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
-->
</style>

<script language="javascript">
	//예약 일정을 선택하기 위한 화면으로 링크한다.
	function reservation(str) {
		/*
			str : 예약일정을 구분해주는 변수
			value case 
				28: 2박 3일
				27: 1박 2일
				30: 당일

				57	1111900	예약개성	
				58	1111901	예약1박	
				59	1111902	예약2박	
		*/
		document.resv.goods_sid.value = str;
		document.resv.action = "reservatio_step4.jsp";
		document.resv.submit();
	}



	//이전단계로 가기
	function prevStep() {
		document.resv.action = "res_login.jsp";
		document.resv.submit();
	}

	//다음단계로 가기
	function nextStep() {
		if(!document.resv.rname.value){
			alert("예약자 이름을 입력해주세요.");
			document.resv.rname.focus();
			return;
		}
		if(!document.resv.rmail.value){
			alert("이메일을 입력해주세요.");
			document.resv.rmail.focus();
			return;
		}
		if(!document.resv.rmob.value&&!document.resv.rtel.value){
			alert("핸드폰이나 전화번호 중 1개는 꼭 입력해주세요.");
			document.resv.rmob.focus();
			return;
		}
		if(!document.resv.rpass.value){
			alert("비밀번호를 입력해주세요. 예약조회에 필요합니다.");
			document.resv.rpass.focus();
			return;
		}


		document.resv.action = "res_step2.jsp";
		document.resv.submit();
	}
</script>
</head>
<body>
<form name="resv" method="post">

<table cellpadding="0" cellspacing="0" width="720" height="470">
  <tr>
    <td height="54"><img src="/asanway/img/reservation/img/tit_res01.gif" width="70" height="21" /></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--컨텐츠 시작-->
			<table cellpadding="0" cellspacing="0" width="720">
				<tr>	
					<td style="padding:20 0 10 16"><!-- 예약자정보 --><img src="/asanway/img/reservation/img/title_step1.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="690" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="690" height="291">
										<tr>
											<td>


<!-- / 예약자정보 -->
<table cellspacing="0" cellpadding="0" width="510" align=center>
  <tr><td height="2" colspan="3" class="line_dg"></td></tr>
  <tr height="26">
	<td width="102"><img src="/asanway/img/reservation/img/txt_s1_6.gif"><!-- 상품종류 --></td>
	<td align=left colspan="2">&nbsp;&nbsp;&nbsp;
		<table>
			<tr>
				<td>
					<img src="/asanway/img/reservation/img/1.jpg">
				</td>
				<td>
					<input type="radio" name="type" checked>상품1
				</td>
				<td>
					<img src="/asanway/img/reservation/img/2.jpg">
				</td>
				<td>
					<input type="radio" name="type">상품2
				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td align="right"></td>
			</tr>
		</table>
	</td>
  </tr>
  <tr><td height="1" colspan="3" class="tabline"></td></tr>
  <tr height="26">
	<td width="102"><img src="/asanway/img/reservation/img/txt_s1_0.gif"><!-- 출발일자 --></td>
	<td align=left>&nbsp;&nbsp;&nbsp;<input name="start_day" type="text" maxlength=10 style="width:120px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
	<td width="285"><img src="/asanway/img/reservation/img/icon_cal.gif" border="0"></td>
  </tr>
  <tr><td height="1" colspan="3" class="tabline"></td></tr>
  <tr height="26">
	<td width="102"><img src="/asanway/img/reservation/img/txt_s1_1.gif"><!-- 예약자이름 --></td>
	<td width=100% align=left colspan="2">&nbsp;&nbsp;&nbsp;<input name="rname" type="text" maxlength=10 style="width:120px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
  </tr>
  <tr><td height="1" colspan="3" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="/asanway/img/reservation/img/txt_s1_2.gif"><!-- 이메일 --></td>
	<td width=100% align=left colspan="2">&nbsp;&nbsp;&nbsp;<input name="rmail" type="text" maxlength=50 style="width:200px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
  </tr>
  <tr><td height="1" colspan="3" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="/asanway/img/reservation/img/txt_s1_3.gif"><!-- 핸드폰번호 --></td>
	<td width=100% align=left colspan="2">&nbsp;&nbsp;&nbsp;<input name="rmob" type="text" maxlength=13 style="width:120px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
  </tr>
  <tr><td height="1" colspan="3" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="/asanway/img/reservation/img/txt_s1_4.gif"><!-- 전화번호 --></td>
	<td width=100% align=left colspan="2">&nbsp;&nbsp;&nbsp;<input name="rtel" type="text" maxlength=13 style="width:120px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>  </tr>
  <tr><td height="1" colspan="3" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="/asanway/img/reservation/img/txt_s1_5.gif"><!-- 비밀번호--></td>
	<td width=100% align=left colspan="2">&nbsp;&nbsp;&nbsp;<input name="rpass" type="password" maxlength=10 style="width:100px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>  </tr>
  <tr><td height="2" colspan="3" class="line_dg"></td></tr>
  <tr height="26">
	<td valign="top" height="26" colspan="3"></td>
  </tr>
</table>
<!-- 예약자정보 / -->












											</td>
										</tr>
										<tr>
											<td height="10" align=center><div id="btn"><a href="javascript:prevStep()"><img src="/asanway/img/tour_img/reservation/step_prev.gif" border="0"></a>&nbsp;&nbsp;&nbsp;<a href="javascript:nextStep()"><img src="/asanway/img/tour_img/reservation/step_next.gif" border="0"></a></div></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<!--컨텐츠 끝-->
		</td>
	</tr>
	<tr>
		<td height="8" bgcolor="3F667D"></td>
	</tr>
</table>
</form>

</body>
</html>

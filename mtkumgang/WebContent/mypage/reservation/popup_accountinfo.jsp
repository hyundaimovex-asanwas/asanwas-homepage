<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<html>
<head>
<title>금강산관광  </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>

<body class="popmargin">

<!-- 팝업사이즈 : 500 * 585 -->
<table cellspacing="0" cellpadding="0" border="0" width="470">
<tr>
	<td>
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr><img src="<%=imageServer%>/tour_img/mypage/pop_tit_accountinfo.gif"><!-- 타이틀 --></td></tr>
		<tr><td height="25"></td></tr>
		<tr><td height="48" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_accountinfo.gif" hspace="13"></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<img src="<%=imageServer%>/tour_img/mypage/pop_billinfo_bg.gif" width="442" height="344">
		<div id="billinfo" style="position:absolute; width:442px; height:344px; z-index:1; left: 30px; top: 153px;">
		<table cellspacing="1" cellpadding="0" border="0" width="442">
		<tr align="center">
			<td height="22" width="158"><img src="<%=imageServer%>/tour_img/mypage/txt01.gif"><!-- 카드종류 --></td>
			<td width="284" colspan="2"><img src="<%=imageServer%>/tour_img/mypage/txt02.gif"><!-- 주문번호 --></td>
		</tr>
		<tr align="center">
			<td height="22" class="fs11 txt_dblue">국민인터넷 ISP</td>
			<td colspan="2" class="fs11 txt_dblue">20006sdfas-s222222</td>
		</tr>
		<tr align="center">
			<td height="22" colspan="3"><img src="<%=imageServer%>/tour_img/mypage/txt03.gif"><!-- 카드번호 --></td>
		</tr>
		<tr align="center">
			<td height="22" colspan="3" class="fs11 txt_dblue">5409470000000****</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt04.gif"><!-- 유효기간 --></td>
			<td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/txt05.gif"><!-- 거래일시 --></td>
		</tr>
		<tr align="center">
			<td height="22" class="fs11 txt_dblue">09/09</td>
			<td class="fs11 txt_dblue" colspan="2">2006.05.09</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt06.gif"><!-- 거래종류 --></td>
			<td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/txt07.gif"><!-- 상품정보 --></td>
		</tr>
		<tr align="center">
			<td height="22" class="fs11 txt_dblue">신용구매</td>
			<td class="fs11 txt_dblue" colspan="2">금강산 2박 3일</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt08.gif"><!-- 결제방법 --></td>
			<td class="fs11 txt_dblue b" colspan="2">일시불</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt09.gif"><!-- 금액 --></td>
			<td class="fs11 txt_dblue b" colspan="2">
				<table cellspacing="0" cellpadding="0" border="0" width="284">
				<tr align="center">
					<td height="22" width="28" class="b white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt10.gif"><!-- 세금 --></td>
			<td class="fs11 txt_dblue b" colspan="2">
				<table cellspacing="0" cellpadding="0" border="0" width="284">
				<tr align="center">
					<td height="22" width="28" class="b white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt11.gif"><!-- 기타 --></td>
			<td class="fs11 txt_dblue b" colspan="2">
				<table cellspacing="0" cellpadding="0" border="0" width="284">
				<tr align="center">
					<td height="22" width="28" class="b white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt12.gif"><!-- 합계 --></td>
			<td class="fs11 txt_dblue b" colspan="2">
				<table cellspacing="0" cellpadding="0" border="0" width="284">
				<tr align="center">
					<td height="22" width="28" class="b white"></td>
					<td width="1"></td>
					<td width="27" class="b txt_white"></td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="28" class="b txt_white">o</td>
					<td width="1"></td>
					<td width="27" class="b txt_white">o</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr align="center">
			<td height="22"><img src="<%=imageServer%>/tour_img/mypage/txt13.gif"><!-- 대표자 --></td>
			<td><img src="<%=imageServer%>/tour_img/mypage/txt14.gif"><!-- 승인번호 --></td>
			<td><img src="<%=imageServer%>/tour_img/mypage/txt15.gif"><!-- 가맹점명 --></td>
		</tr>
		<tr align="center">
			<td height="22" class="fs11 txt_dblue">홍길동</td>
			<td class="fs11 txt_dblue">111111111</td>
			<td class="fs11 txt_dblue">현대아산</td>
		</tr>
		</table>
		</div>

		<table cellspacing="0" cellpadding="0" border="0" width="442">
		<tr><td height="21"></td></tr>
		<tr>
			<td height="39" valign="top" align="center"><a href="javascript:;" onclick="window.print();"><img src="<%=imageServer%>/tour_img/btn/btn_print.gif" class="btn"></a><a href="javascript:;" onclick="window.close();"><img src="<%=imageServer%>/tour_img/btn/btn_confirm2.gif"></a></td>
		</tr>
		</table>

		
		<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0"><tr><td><img src="<%=imageServer%>/tour_img/mypage/pop_btm_accountinfo.gif"></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>

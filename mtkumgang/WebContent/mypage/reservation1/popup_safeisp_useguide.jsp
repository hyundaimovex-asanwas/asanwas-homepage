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
<title> 금강산관광 </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
</head>

<body class="popmargin">

<!-- 팝업사이즈 : 450 * 320 -->
<table cellspacing="0" cellpadding="0" border="0" width="420">
<tr>
	<td>
			<!-- / 타이틀 -->
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/mypage/pop_tit_useguide2.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- 타이틀 / -->
			
			<table cellspacing="0" cellpadding="0" border="0" width="420">
			<tr>
				<td class="tpad_20 bpad_15 lpad_15 rpad_10"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop"><span class="txt_dblue b">안심클릭 (일반 신용카드)</span><table cellspacing="0" cellpadding="0" border="0" height="3"><tr><td></td></tr></table>&nbsp;&nbsp;국민, 비씨카드를 제외한 모든 신용카드<br>&nbsp;&nbsp;(삼성,LG,외환 등)로 결제시 이용. (2004년 1월 1일부터 시행)</td>
			</tr>
			<tr>
				<td class="bpad_15 lpad_15 rpad_10"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop"><span class="txt_dblue b">ISP(인터넷 안전결제)</span><table cellspacing="0" cellpadding="0" border="0" height="3"><tr><td></td></tr></table>&nbsp;&nbsp;국민,비씨카드로 결제시 이용<br>&nbsp;&nbsp;(2003년 10월 1일부터 시행중)</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<tr><td height="20"></td></tr>
			<tr>
				<td height="39" valign="top" align="center"><a href="javascript:;" onclick="window.close();"><img src="<%=imageServer%>/tour_img/btn/btn_confirm2.gif"></a><!-- 확인 --></td>
			</tr>
			</table>

			<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dblue"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>

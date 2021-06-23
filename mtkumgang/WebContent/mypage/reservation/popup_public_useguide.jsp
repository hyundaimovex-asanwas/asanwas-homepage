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
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
</head>

<body class="popmargin">

<!-- 팝업사이즈 : 450 * 427 -->
<table cellspacing="0" cellpadding="0" border="0" width="420">
<tr>
	<td>
			<!-- / 타이틀 -->
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/mypage/pop_tit_useguide.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- 타이틀 / -->
			
			<table cellspacing="0" cellpadding="0" border="0" width="420">
			<tr>
				<td class="tpad_20 bpad_15 lpad_15 rpad_10"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop">금융감독원의 <span class="txt_dblue">전자금융거래 안정성 강화대책</span>(2005년 9월)에 따라<br>&nbsp;&nbsp;2005년 11월 1일부터 인터넷 쇼핑 30만원 이상 카드 결제시 공인인증서<br>&nbsp;&nbsp;의무사용이 아래와 같이 적용됩니다.</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<tr>
				<td class="tpad_20 bpad_15 lpad_15 rpad_10">
					<strong>가. 변경 전</strong> : 결제금액 구분없이 안심클릭이나 공인인증 중 택함<br>
					<strong>나. 변경 후</strong> : 30만원 이상 신용카드 결제시 공인인증 의무사용 지침<br>
					<strong>다. 적용일자</strong> : 2005년 11월 1일부터 적용<br>
					<strong>라. 내용</strong><br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 온라인상 신용카드 결제시 > 전자거래범용, 신용카드용 공인인증서<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;가 있어야만 결제가 가능함.<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 인터넷 뱅킹용, 증권용 공인인증서를 발급 받아 사용하시기<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;바랍니다.
				</td>
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

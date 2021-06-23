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

<!-- 팝업사이즈 : 500 * 514 -->
<table cellspacing="0" cellpadding="0" border="0" width="470">
<tr>
	<td>
			<!-- / 타이틀 -->
			<table cellspacing="0" cellpadding="0" border="0" width="470" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/mypage/pop_tit_useinfo.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- 타이틀 / -->
			
			<table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:25px;">
			<tr>
				<td height="48" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo.gif" hspace="13"></td>
			</tr>
			<tr>
				<td valign="top" align="center">
					<table cellspacing="0" cellpadding="0" border="0" width="442">
					<tr valign="top">
						<td width="150">
							<table width="130" cellspacing="0" cellpadding="0" border="0">
							<tr>
								<td><img src="<%=imageServer%>/tour_img/mypage/_temp_pic.gif" width="130" height="150"><!-- 사진 --></td>
							</tr>
							<tr>
								<td align="center" class="tpad_10"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_filesch.gif"></a><!-- 파일찾기 --></td>
							</tr>
							</table>
						</td>
						<td width="292">
							<table width="292" cellspacing="0" cellpadding="0" border="0">
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29" width="81"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo01.gif"><!-- 성명 --></td>
								<td width="211"><input type="text" style="width:70px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo02.gif"><!-- 주민번호 --></td>
								<td><input type="text" style="width:68px;"> - <input type="text" style="width:69px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo03.gif"><!-- 우편번호 --></td>
								<td><input type="text" style="width:40px;"> - <input type="text" style="width:40px;"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_postsch.gif" hspace="5" align="absmiddle"></a><!-- 우편번호검색 --></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo04.gif"><!-- 기본주소 --></td>
								<td><input type="text" style="width:203px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo05.gif"><!-- 상세주소 --></td>
								<td><input type="text" style="width:203px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo06.gif"><!-- 자택전화 --></td>
								<td><input type="text" style="width:41px;"> - <input type="text" style="width:41px;"> - <input type="text" style="width:41px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo07.gif"><!-- 핸드폰 --></td>
								<td><input type="text" style="width:41px;"> - <input type="text" style="width:41px;"> - <input type="text" style="width:41px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo08.gif"><!-- 직장명 --></td>
								<td><input type="text" style="width:151px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo09.gif"><!-- 직위 --></td>
								<td><input type="text" style="width:151px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							</table>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr><td height="29"></td></tr>
			<tr>
				<td height="39" valign="top" align="center"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_confirm2.gif"></a><!-- 확인 --></td>
			</tr>
			</table>

			<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dblue"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>

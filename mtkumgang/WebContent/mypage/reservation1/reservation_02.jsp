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
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
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
			<td width="174" height="100%">
				<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td height="50%" valign="top">
			<!--  left menu flash -->
			<%@ include file="../../include/mypage/tour_mypage_left.jsp" %>
			<!--  left menu flash -->
					</td>
				</tr>
				<tr>
					<td height="50%" valign="bottom"><img src="<%=imageServer%>/tour_img/mypage/img_left_callcenter.jpg" width="174" height="46"></td>
				</tr>
				</table>
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reservation.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">나의 예약정보</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="13"></td></tr>
								<tr><td height="100" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_reservation2.gif"></td></tr>
								<tr><td height="77" valign="top"><img src="<%=imageServer%>/tour_img/mypage/tab01.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab02_on.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab03.gif" class="btn"></td></tr>
								</table>
							</td>
							<td align="right"><img src="<%=imageServer%>/tour_img/mypage/img_reservation2.jpg"></td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="530">
								<!-- / 관광객기본정보 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510">
								<tr>
									<td valign="top" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket04.gif" hspace="5"><!-- 관광객기본정보 --></td>
								</tr>
								</table>

								<!-- 호텔1 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin:14 0 0 0px;">
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- 숙소 --></td>
									<td width="175">호텔 해금강</td>
									<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- 객실 --></td>
									<td width="205">일반실(온돌)</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:14 0 0 0px;" class="tabline">
								<tr align="center">
									<td class="bg_white" height="26">이름</td>
									<td class="bg_white">주민등록번호</td>
									<td class="bg_white">상세정보</td>
									<td class="bg_white">연령구분</td>
									<td class="bg_white">관광요금</td>
									<td class="bg_white">입금액</td>
									<td class="bg_white">결제여부</td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- 완료 --></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">0</td>
									<td class="bg_white"><input type="checkbox" name="" class="noborder" checked></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- 미입력 --></td>
									<td class="bg_white">어린이</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">0</td>
									<td class="bg_white"><input type="checkbox" name="" class="noborder"></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- 미입력 --></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">0</td>
									<td class="bg_white"><input type="checkbox" name="" class="noborder"></td>
								</tr>
								</table>

								<!-- 호텔2 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin:14 0 0 0px;">
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- 숙소 --></td>
									<td width="175">금강산 호텔</td>
									<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- 객실 --></td>
									<td width="205">일반실(온돌)</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:14 0 0 0px;" class="tabline">
								<tr align="center">
									<td class="bg_white" height="26">이름</td>
									<td class="bg_white">주민등록번호</td>
									<td class="bg_white">상세정보</td>
									<td class="bg_white">연령구분</td>
									<td class="bg_white">관광요금</td>
									<td class="bg_white">입금액</td>
									<td class="bg_white">결제여부</td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- 완료 --></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">0</td>
									<td class="bg_white"><input type="checkbox" name="" class="noborder" checked></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- 미입력 --></td>
									<td class="bg_white">어린이</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">0</td>
									<td class="bg_white"><input type="checkbox" name="" class="noborder"></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- 미입력 --></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">0</td>
									<td class="bg_white"><input type="checkbox" name="" class="noborder"></td>
								</tr>
								</table>

								<!-- 총결제금액 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin:14 0 0 0px;">
								<tr><td height="1" class="line_dg"></td></tr>
								<tr><td height="14"></td></tr>
								<tr>
									<td height="30" align="right" class="rpad_10" bgcolor="#F7F7F7">결제하실 금액 :&nbsp;&nbsp;&nbsp;<span class="txt_sky b fs14">1,400,000원</span></td>
								</tr>
								</table>
								<!-- 관광객기본정보 / -->

								<!-- / 결제정보 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket05.gif" hspace="5"><!-- 결제정보 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket51.gif"><!-- 상품명 --></td>
									<td width="173">	금강산 관광</td>
									<td width="98"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket52.gif"><!-- 신청서번호 --></td>
									<td width="151">99000-1000461</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket53.gif"><!-- 주문자명 --></td>
									<td>홍길동</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket54.gif"><!-- 이메일 --></td>
									<td>today@imjk.co.kr</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket55.gif"><!-- 전화번호 --></td>
									<td>111-111-1111</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket56.gif"><!-- 휴대폰 번호 --></td>
									<td>111-111-1111</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- 결제정보 / -->

								<!-- / 하단버튼 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:14px;">
								<tr>
									<td align="right"><a href="reservation_03.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_account.gif" class="btn"></a><!-- 결제하기 --><a href="reservation_01.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_reserdesc.gif"></a><!-- 예약상세보기화면으로 --></td>
								</tr>
								</table>
								<!-- 하단버튼 / -->

							</td>
							<td width="160" style="padding-top:25px;">
								<table width="160" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_03.gif"></td></tr>
								<tr><td class="tpad_10"><a href="javascript:;" onclick="window.open ('popup_public_useguide.html', 'movieview', 'width=450,height=427,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/mypage/btn_desc_public.gif"></a></td></tr>
								<tr><td class="tpad_5"><a href="javascript:;" onclick="window.open ('popup_safeisp_useguide.html', 'movieview', 'width=450,height=320,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/mypage/btn_desc_safeisp.gif"></a></td></tr>
								</table>
							</td>
						</table>
						<!-- list table / -->
					</td>
				</tr>
				</table>
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
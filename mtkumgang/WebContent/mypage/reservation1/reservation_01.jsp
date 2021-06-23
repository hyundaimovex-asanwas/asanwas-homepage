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
								<tr><td height="77" valign="top"><img src="<%=imageServer%>/tour_img/mypage/tab01_on.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab02.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab03.gif" class="btn"></td></tr>
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
								<!-- / 예약내용 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket01.gif" hspace="5"><!-- 예약내용 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket01.gif"><!-- 여행기간 --></td>
									<td colspan="3">2006년 05월 24일(수요일) ~ 2006년 05월 26일(금요일)</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket02.gif"><!-- 숙박일수 --></td>
									<td width="166">2박3일</td>
									<td width="112"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket03.gif"><!-- 예약일시 --></td>
									<td width="144">2006-05-22 08:00</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket04.gif"><!-- 인원 --></td>
									<td>12명</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket05.gif"><!-- 예약상태 --></td>
									<td>결제완료</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket06.gif"><!-- 총액 --></td>
									<td>1,400,000</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket07.gif"><!-- 결제마감일시 --></td>
									<td>2006-05-26 08:00</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- 예약내용 / -->

								<!-- / 예약자정보 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket02.gif" hspace="5"><!-- 예약자정보 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="102" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket21.gif"><!-- 예약자이름 --></td>
									<td width="139">곽효진</td>
									<td width="85"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket22.gif"><!-- 이메일 --></td>
									<td width="184">today@imjk.co.kr</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket23.gif"><!-- 핸드폰번호 --></td>
									<td>011-1111-1111</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket24.gif"><!-- 전화번호 --></td>
									<td>011-1111-1111</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- 예약자정보 / -->

								<!-- / 숙소`객실`관광객정보 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- 숙소`객실`관광객정보 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- 숙소 --></td>
									<td width="175">호텔 해금강</td>
									<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- 객실 --></td>
									<td width="205">일반실(온돌)</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>

								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:14 0 14 0px;" class="tabline">
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
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_useinfo.jsp', 'userview', 'width=530,height=540,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- 완료 --></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_accountinfo.jsp', 'payview', 'width=520,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"></a><!-- 결제완료 --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- 미입력 --></td>
									<td class="bg_white">어린이</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"></a><!-- 결제완료 --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">홍길동</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- 미입력 --></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white"><a href="javascript:alert('결제 프로세스 이동');"><img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif"></a><!-- 미납 --></td>
								</tr>
								</table>
								<!-- 숙소`객실`관광객정보 / -->

								<!-- / 하단버튼 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:14px;">
								<tr><td height="1" colspan="2" class="line_dg"></td></tr>
								<tr><td height="13" colspan="2"></td></tr>
								<tr>
									<td><a href="reservation_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_listgo.gif"></a><!-- 목록으로 --></td>
									<td align="right"><a href="reservation_02.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_account.gif" class="btn"></a><!-- 결제하기 --><a href="javascript:alert('예약 취소 프로세스 이동');"><img src="<%=imageServer%>/tour_img/btn/btn_resercancel.gif" class="btn"></a><!-- 예약취소 --><a href="javascript:;" onclick="window.open ('popup_reservation_ticket.jsp', 'movieview', 'width=518,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_ticketview.gif"></a><!-- 예약티켓보기 --></td>
								</tr>
								</table>
								<!-- 하단버튼 / -->

							</td>
							<td width="160" style="padding-top:25px;">
								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_sky3">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_01.gif"></td></tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:12 5 7 11px;"><strong>1) 주소</strong>: 시/도, 구/군, 동/면<br>까지 확인하며, 주민등록증<br>의 거주지와 대조하여 틀릴<br>경우 벌금이 부과됩니다.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 0 11px;"><strong>2) 직장/직위</strong>: 사실과 다를 경우 벌금이 부과되며,<br>반드시 현대아산 담당자와<br>통화하여 확인 받으시기<br>바랍니다.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 2 11px;">(☎ 현대아산 영업팀 이소윤<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 02-3669-3724)</td>
								</tr>
								<tr>
									<td style="padding:0 5 10 11px;">
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td colspan="3" class="txt_dblue fs11 lh13" style="padding:5 0 7 0px;">--------- 예시 ---------</td>
										</tr>
										<tr valign="top">
											<td width="6"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td width="37" class="txt_dblue fs11 lh13">주   부:</td>
											<td class="txt_dblue fs11 lh13">직장명에 주부,<br>직위에 공란</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">자영업:</td>
											<td class="txt_dblue fs11 lh13">직장명에 상호,<br>직위에 대표.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">학   생:</td>
											<td class="txt_dblue fs11 lh13">직장명에 학생,<br>직위에 공란.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">대학생:</td>
											<td class="txt_dblue fs11 lh13">직장명에 OO대학교<br>직위에 학생</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0"><tr><td height="10"></td></tr></table>

								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_lbrown">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_02.gif"></td></tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:12 5 7 11px;"><strong>보내실 곳</strong>: (우110-793)<br>서울시 종로구 계동 1410-2<br>현대빌딩 온라인 담당자 앞</td>
								</tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:0 5 10 11px;">(사진 뒷면에 주민등록번호와<br>성함을 볼펜으로 적어주시기<br>바랍니다.)</td>
								</table>
							</td>
						</tr>
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
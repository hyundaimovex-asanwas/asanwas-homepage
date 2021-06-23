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
<title>금강산관광</title>
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

<!-- 팝업사이즈 : 519 * 600 가로스크롤생기게.. -->
<table cellspacing="0" cellpadding="0" border="0" width="470">
<tr>
	<td>
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/pop_tit_ticket.gif"><!-- 타이틀 --></td></tr>
		<tr><td colspan="2" height="30"></td></tr>
		<tr>
			<td height="19" class="lpad_10"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop"><span class="b txt_dblue">신청서 번호 : </span><span class="txt_sky">990001000461</span></td>
			<td align="right" class="rpad_10 fs11">예약신청일 : 2006년 5월 23일 화요일</td>
		</tr>
		<tr><td colspan="2" height="2" class="tabline"></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<!-- / 예약내용 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:20px;">
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
			<td width="146">2박3일</td>
			<td width="112"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket03.gif"><!-- 예약일시 --></td>
			<td width="124">2006-05-22 08:00</td>
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
		<table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:30px;">
		<tr>
			<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket02.gif" hspace="5"><!-- 예약자정보 --></td>
		</tr>
		<tr><td height="2" colspan="4" class="line_dg"></td></tr>
		<tr>
			<td width="102" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket21.gif"><!-- 예약자이름 --></td>
			<td width="119">곽효진</td>
			<td width="85"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket22.gif"><!-- 이메일 --></td>
			<td width="164">today@imjk.co.kr</td>
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
		<table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:30px;">
		<tr>
			<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- 숙소`객실`관광객정보 --></td>
		</tr>
		<tr><td height="2" colspan="4" class="line_dg"></td></tr>
		<tr>
			<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- 숙소 --></td>
			<td width="155">호텔 해금강</td>
			<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- 객실 --></td>
			<td width="185">일반실(온돌)</td>
		</tr>
		<tr><td height="1" colspan="4" class="line_dg"></td></tr>
		</table>
		<!-- 숙소`객실`관광객정보 / -->

		<!-- / 숙소`객실`관광객정보 -->
		<table cellspacing="1" cellpadding="1" border="0" width="470" style="margin:14 0 14 0px;" class="tabline">
		<tr align="center">
			<td class="bg_white fs11" height="26">이름</td>
			<td class="bg_white fs11">주민등록번호</td>
			<td class="bg_white fs11">상세정보</td>
			<td class="bg_white fs11">연령</td>
			<td class="bg_white fs11">관광요금</td>
			<td class="bg_white fs11">입금액</td>
			<td class="bg_white fs11">결제여부</td>
		</tr>
		<tr align="center">
			<td class="bg_white fs11" height="26">홍길동</td>
			<td class="bg_white fs11">780116-1234567</td>
			<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- 완료 --></td>
			<td class="bg_white fs11">성인</td>
			<td class="bg_white fs11 rpad_10" align="right">405,000</td>
			<td class="bg_white fs11 rpad_10" align="right">405,000</td>
			<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"></a><!-- 결제완료 --></td>
		</tr>
		<tr align="center">
			<td class="bg_white fs11" height="26">홍길동</td>
			<td class="bg_white fs11">780116-1234567</td>
			<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- 완료 --></td>
			<td class="bg_white fs11">어린이</td>
			<td class="bg_white fs11 rpad_10" align="right">405,000</td>
			<td class="bg_white fs11 rpad_10" align="right">405,000</td>
			<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"></a><!-- 결제완료 --></td>
		</tr>
		<tr align="center">
			<td class="bg_white fs11" height="26">홍길동</td>
			<td class="bg_white fs11">780116-1234567</td>
			<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- 완료 --></td>
			<td class="bg_white fs11">성인</td>
			<td class="bg_white fs11 rpad_10" align="right">405,000</td>
			<td class="bg_white fs11 rpad_10" align="right">405,000</td>
			<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"></a><!-- 결제완료 --></td>
		</tr>
		</table>
		<!-- 숙소`객실`관광객정보 / -->

		<!-- / 탭메뉴 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr><td height="1" class="line_dg"><img src="<%=imageServer%>/tour_img/spacer.gif" width="1" height="1" name="top"></td></tr>
		<tr><td height="40"></td></tr>
		<tr>
			<td><a href="#01"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket01.gif'"></a><a href="#02"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket02.gif'"></a><a href="#03"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket03.gif'"></a><a href="#04"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket04.gif'"></a><a href="#05"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket05.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket05.gif'"></a><a href="#06"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket06.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket06.gif'"></a><a href="#07"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket07.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket07.gif'"></a></td>
		</tr>
		<tr><td height="30"></td></tr>
		</table>
		<!-- 탭메뉴 / -->

		<!-- / 예약확인정보 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/01.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="427">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_01.gif" name="01"></td></tr>
				<tr valign="top">
					<td width="16">①</td>
					<td width="411"><span class="txt_sky"><u>곽효진</u></span> 님의 예약이 <span class="txt_sky"><u>2006-05-29-11:50</u></span> 에 접수되었습니다.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>②</td>
					<td>입력하신 이메일과 비밀번호는 신청한 예약의 진행상태를 조회하고<br>기타 정보를 수정하는데 필요하오니 꼭 메모해 두시기 바랍니다.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>③</td>
					<td>관광객의 상세정보 입력 및 관광요금 결제가  <span class="txt_sky"><u>2006-06-01 08:00</u></span> 까지<br>이루어지지 않으면 자동취소 됨을 알려드립니다.</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr valign="top">
					<td></td>
					<td>- 금강산관광은 여타 관광과 달리 '북한'으로 방문하는 상품이므로<br>&nbsp;&nbsp;&nbsp;관광객 상세정보입력에 신경써 주시기 바랍니다.<br>- 아래 사항이 사실과 다를 경우 북측 통행검사소에서 벌금을 부과하오니<br>&nbsp;&nbsp;&nbsp;불이익을 당하는 일이 없도록 세심하게 입력해 주시기 바랍니다.</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr valign="top">
					<td></td>
					<td class="lpad_10">1) 주소 : 시/도, 구/군, 동/면 까지 확인하며, 주민등록증의 거주지와<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대조하여 틀릴 경우 벌금이 부과됩니다.<br>2) 직장 / 직위 : 역시 사실과 다를 경우 벌금이 부과되며, 반드시<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;현대아산 담당자와 통화하여 확인받으시기 바랍니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(☎ 현대아산 영업팀 이소윤 : 02-3669-3724)</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr valign="top">
					<td></td>
					<td><u>* 예시 *</u><br>- 주부 = 직장명에 주부, 직위에 공란<br>- 자영업 = 직장명에 상호, 직위에 대표<br>- 학생 = 직장명에 학생, 직위에 공란<br>- 대학생 = 직장명에 ○○대학교, 직위에 학생</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>④</td>
					<td>금강산관광 사이트 메인화면에서 [온라인예약 배너클릭] ><br>[예약확인하기] 로 들어가시면 상세정보 입력 및 관광요금 결제를<br>하실 수 있습니다.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>⑤</td>
					<td>관광객의 사진은 JPG로 스캔하여 업로드하시거나 우편으로 1매를 보내<br>주셔야 합니다.<br>사진을 보내실 때는 사진 뒷면에 볼펜으로 주민등록번호와 성함을 꼭<br>적어주시기 바랍니다.<br>
					- <strong>보내실 곳</strong> : (우.110-793) 서울시 종로구 계동 1410-2 현대빌딩<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;온라인 담당자 앞</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>⑥</td>
					<td>관광요금 결제는 신용카드 결제, 계좌이체를 지원하고 있습니다.<br>양쪽 모두 공인인증서가 필요하오니(신용카드결제는 카드용 인증서필요)<br>거래 은행사이트 혹은 거래 카드사이트에서 공인인증서를 발급받으시기<br>바랍니다.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>⑦</td>
					<td>기타 관광에 대한 문의는 ☎ 현대아산 콜센터 02-3669-3000를 이용해<br>주시면 됩니다.</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- 예약확인정보 / -->

		<!-- / 집결지안내 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/02.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_02.gif" name="02"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/pop_img_21.gif"></td></tr>
				<tr><td colspan="2" height="20"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>탑승 수속시간 (집결지 도착시간)</strong><br>- 2박 3일 : 14:30<br>- 1박 2일 : 06:00<br>※ 탑승 수속시간에 늦지 않도록 도착하셔야 하며, 관광도우미의 안내에<br>&nbsp;&nbsp;&nbsp;&nbsp;협조하여 주시기 바랍니다.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>집결지 : </strong>화진포 아산 휴게소<br><strong>주소 : </strong>강원도 고성군 현내면 초도리 산28번지<br>- 약도</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/pop_img_22.gif"></td></tr>
				<tr><td colspan="2" height="15"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
					<td><strong>출입국심사시 준비물</strong><br>
					- 신분증, 탑승권, 출입신고서를 잘 보관하셨다가 돌아오시는 날 제출<br>&nbsp;&nbsp;&nbsp;하셔야 합니다.<br>
					※ 신분증(주민등록증, 운전면허증, 여권)이 없으시면 탑승이 거절되오니<br>&nbsp;&nbsp;&nbsp;&nbsp;반드시 지참하시기 바랍니다.<br>
					※ 영주권자, 시민권자, 외국인은 반드시 여권을 지참하시기 바랍니다.<br>
					※ 착용하는 관광증은 북측 입출국시 여권을 대신하는 것이므로 훼손되지<br>&nbsp;&nbsp;&nbsp;&nbsp;않도록 주의 바랍니다.<br>
					☎ 문의 전화 : 현대아산 고성사무소 ( Tel. 033-681-9400) </td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- 집결지안내 / -->

		<!-- / 교통안내 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/03.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_03.gif" name="03"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>개별차량 이용 집결지 도착 고객</strong><br>금강산콘도에 무료주차가 가능하며 금강산콘도에서 통일전망대까지의<br>왕복 버스비용(3만원)을 별도로 지불하셔야 합니다.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>단체버스 이용 고객</strong><br>거주지로부터 단체로 전세버스를 이용하시는 분들은 최소 5일전까지<br>(02-3669-3000)로 버스번호와 탑승인원 등을 반드시 통보하시기 바랍니다.<br>※ 차량번호를 사전에 관할 군부대에 통보해야만 민통선 검문소 통과가<br>&nbsp;&nbsp;&nbsp;&nbsp;가능합니다</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
					<td><strong>지정버스 이용 고객(서울)</strong><br>고객들의 편의를 위하여 관광버스가 출발시간과 도착시간에 맞춰<br>서울↔통일전망대 구간을 정기적으로 운행합니다.<br>필요하신 고객께서는 아래의 지정 수송업체로 직접 예약하여 주시기<br>바랍니다. (1인당 왕복요금 3만원 별도 지불)</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<!-- / 숙소`객실`관광객정보 -->
				<table cellspacing="1" cellpadding="1" border="0" width="407" style="margin:14 0 14 0px;" class="tabline">
				<tr align="center">
					<td class="bg_white fs11" height="26">구간</td>
					<td class="bg_white fs11">버스회사</td>
					<td class="bg_white fs11">연락처</td>
					<td class="bg_white fs11">출발시각</td>
					<td class="bg_white fs11">출발지</td>
					<td class="bg_white fs11">약도</td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11" height="26" rowspan="4">서울<br>↑↓<br>금강산<br>(집결지)</td>
					<td class="bg_white fs11" rowspan="2">대화관광<br>(강북)</td>
					<td class="bg_white fs11 lpad_10" align="left" rowspan="2">(02)<br>733-0017</td>
					<td class="bg_white fs11">09:00</td>
					<td class="bg_white fs11 lpad_5" align="left">계동 현대사옥<br>스포츠센터 앞</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- 상세보기 --></td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11">09:15</td>
					<td class="bg_white fs11 lpad_5" align="left">광화문 금강제화<br>빌딩 앞</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- 상세보기 --></td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11" rowspan="2">대원관광<br>(강남)</td>
					<td class="bg_white fs11 lpad_10" align="left" rowspan="2">(02)<br>575-7710</td>
					<td class="bg_white fs11">09:00</td>
					<td class="bg_white fs11 lpad_5" align="left">압구정 현대백화점<br>옆 공영주차장</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- 상세보기 --></td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11">09:30</td>
					<td class="bg_white fs11 lpad_5" align="left">잠실 종합운동장<br>입구 공영주차장 앞</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- 상세보기 --></td>
				</tr>
				</table>
				<!-- 숙소`객실`관광객정보 / -->
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- 교통안내 / -->

		<!-- / 여행전준비사항안내 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/04.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_04.gif" name="04"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>여행 준비물</strong><br>※ 주민등록증 등 신분증을 필히 지참해 주시기 바랍니다.<br>1) 복 장 : 계절에 맞는 복장, 산행에 적합한 복장 및 신발, 모자 등<br>2) 세면도구 : 치약, 치솔, 면도기(수건 및 비누는 비치되어 있음)<br>3) 의 약 품 : 금강산 현지에 병원이 있으므로 개인 비상약만 준비<br>4) 기 타 : 배낭, 지팡이, 장갑, 우의 등</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>현지사용 화폐 : </strong>미달러($), 신용카드 및 금강산관광카드<br>※ 관광카드 사용시 달러환전 등 번거로운 절차가 필요없습니다.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
					<td><strong>금강산관광카드(무료) 안내</strong><br> 금강산관광카드(무료)는 관광객 모든 분께 관광증과 함께 발급되는<br>전자카드로서 금강산특구내에서만 사용 가능합니다.<br>1) 사용 방법 : 원화(\)를 관광카드에 현지 기준 환율로 달러($) 충전<br>&nbsp;&nbsp;&nbsp;(예) 15만원 충전시 (환율 1,050기준) → 약 $142 충전<br>2) 충전 장소 : 금강산 콘도(고성) 및 금강산 현지(온정각 서관)<br>3) 환 불 : 관광 후, 온정각 서관에서 남은 금액 원화(\)로 환불</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>4.</strong></td>
					<td><strong>휴대금지 품목</strong><br>※ 핸드폰은 금강산콘도에서 관광조장이 수거 및 보관<br>1) 10배 이상의 쌍안경 및 망원경, 160밀리미터 이상의 망원렌즈가 달린<br>&nbsp;&nbsp;&nbsp;사진기, 24배줌이상(옵티컬 기준)의 줌렌즈가 달린 비디오 카메라<br>2) 남측의 각종 인쇄물 (신문, 잡지, 책 등)<br>3) 위조지폐, 무전기 등 통신물품<br>4) 의료목적을 위한 약품을 제외한 독약, 마약, 그밖에 유독성 화학물질<br>5) 기타 관광에 적합하지 않은 물건</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- 여행전준비사항안내 / -->

		<!-- / 알아둘사항 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/05.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_05.gif" name="05"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>금강산의 기후</strong><br>동해안 강릉지역과 비슷한 기후</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>전 압 : </strong>220V (금강산 현지 시설물)</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
					<td><strong>관광요금에 포함된 사항</strong><br>1) 교통비(통일전망대 ↔ 금강산)<br>2) 관광안내비<br>3) 관광기간 중의 숙박비 및 조식<br>4) 여행자 보험</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>4.</strong></td>
					<td><strong>관광요금에 포함되지 않은 사항</strong><br>1) 출발지에서 통일전망대까지의 왕복 교통비<br>2) 현지에서의 중/석식(4식)<br>3) 교예공연 관람비용</td>
				</tr>
				<tr valign="top">
					<td colspan="2">
						<table cellspacing="1" cellpadding="1" border="0" width="400" style="margin:5 0 5 0px;" class="tabline">
						<tr align="center">
							<td class="bg_white fs11" height="26" width="25%">구분</td>
							<td class="bg_white fs11" width="25%">특석</td>
							<td class="bg_white fs11" width="25%">일반석</td>
							<td class="bg_white fs11" width="25%">입석</td>
						</tr>
						<tr align="center">
							<td class="bg_white fs11">성인</td>
							<td class="bg_white fs11">$ 30</td>
							<td class="bg_white fs11">$ 25</td>
							<td class="bg_white fs11">$ 20</td>
						</tr>
						<tr align="center">
							<td class="bg_white fs11">고교생 이하</td>
							<td class="bg_white fs11">$ 30</td>
							<td class="bg_white fs11">$ 20</td>
							<td class="bg_white fs11">$ 15</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr valign="top">
					<td></td>
					<td>※ 만 6세 이하는 무료입장이나 별도의 좌석은 제공하지 않는다.<br>&nbsp;&nbsp;&nbsp;&nbsp;입석은 좌석권 매진일 때에만 구매 가능<br>4) 온천욕 비용 (대중탕) -2회 이용권 구입시는 $20입니다.</td>
				</tr>
				<tr valign="top">
					<td colspan="2">
						<table cellspacing="1" cellpadding="1" border="0" width="412" style="margin:5 0 5 0px;" class="tabline">
						<tr align="center">
							<td class="bg_white fs11" height="26" width="20%">성인</td>
							<td class="bg_white fs11" width="20%">초/중/고생</td>
							<td class="bg_white fs11" width="30%">8인실(가족)</td>
							<td class="bg_white fs11" width="30%">15인실(가족)</td>
						</tr>
						<tr align="center">
							<td class="bg_white fs11">$ 12</td>
							<td class="bg_white fs11">$ 10</td>
							<td class="bg_white fs11">기본료 $ 30 (8인)<br>1인 추가 $ 10</td>
							<td class="bg_white fs11">기본료 $ 50 (15인)<br>1인 추가 $ 10</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- 알아둘사항 / -->

		<!-- / 여행중주의사항 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/06.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_06.gif" name="06"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>주의사항</strong><br>1) 차량이동 중 북측 시설물이나 북측 사람 사진 촬영<br>2) 관광 중 각종 쓰레기나 담배꽁초 투기<br>3) 출입국 신고, 세관 신고 시 업무 방해<br>4) 지정된 장소 외 흡연 및 용변<br>5) 자연을 훼손하거나 자연물 채취<br>6) 휴대금지 품목 및 음식물 반입<br>7) 북측의 경제나 사상을 비판하는 말</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- 여행중주의사항 / -->

		<!-- / 표준일정표 -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/07.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="420">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_07.gif" name="07"></td></tr>
				<tr>
					<td><strong>- 육로→육로 상품(1박2일)</strong></td>
					<td align="right">* 마지막 업데이트일 : <span class="txt_sky">2006-01-04</span></td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="1" cellpadding="3" border="0" width="420" style="margin:10 0 15 0px;" class="tabline">
						<tr align="center" valign="top">
							<td class="bg_white fs11" height="26" width="40">날짜</td>
							<td class="bg_white fs11" width="65">장소</td>
							<td class="bg_white fs11" width="89">시각</td>
							<td class="bg_white fs11" width="218">일정</td>
						</tr>
						<tr align="center" valign="top">
							<td class="bg_white fs11">제1일</td>
							<td class="bg_white fs11"><br>금강산콘도<br><br>통일전망대<br><br>구선봉<br><br><br><br><br><br>문화회관<br><br><br><br></td>
							<td class="bg_white fs11"><br>06:00<br>07:00<br>07:20<br>08:00<br>08:15<br>08:45<br>09:40~15:00<br>(13:30~16:10)<br><br><br><br><br>16:30<br>18:00~ (21:00) </td>
							<td class="bg_white fs11" align="left">금강산콘도 집결 후 금강산으로 출발!<br>집결지 도착 (개별이동, 관광증 수령)<br>집결지 출발<br>남측 출입사무소 도착 / 수속<br>남측 출입사무소 출발 (군사분계소 통과)<br>북측 출입사무소 도착 / 수속<br>북측 출입사무소 출발<br>구룡연 코스관광 및 중식<br>삼일포 코스관광(유료), 또는 온천 (선택)<br>※ 하계 해수욕장 이용<br>&nbsp;&nbsp;&nbsp;(셔틀버스 운용:온정각 출발)<br>개장시간 : 13:00~17:00<br>교예공연 관람<br>석식 및 자유시간 (온천/쇼핑)<br>가무극 (금강산호텔)</td>
						</tr>
						<tr align="center" valign="top">
							<td class="bg_white fs11">제2일</td>
							<td class="bg_white fs11">각 숙소<br><br><br>구선봉<br><br><br>통일전망대</td>
							<td class="bg_white fs11">06:30<br>08:20<br>12:00<br>15:15<br>15:30<br>16:15<br>16:30</td>
							<td class="bg_white fs11" align="left">알찬 1박2일을 마치며~<br>조식<br>만물상 또는 삼일포/해금강 코스관광<br>중식 및 자유시간 (온천/쇼핑)<br>온정각 출발북측 출입사무소 도착/수속<br>북측 출입사무소 출발 (군사분계선 통과)<br>남측 출입사무소 도착/수속</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">- 상기일정은 현지 사정에 따라 다소 변경될 수도 있습니다.<br>- 온천욕.교예공연 관람권은 현지 매표소에서 판매하며 현지에서 식권을<br>&nbsp;&nbsp;&nbsp;구입하시기 바랍니다.<br>- 온천, 교예관람, 식사 비용은 <span class="txt_sky">[요금표]</span>를 참고하시기 바랍니다.</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		</table>
		<!-- 표준일정표 / -->

		<!-- / 버튼 -->
		<table cellspacing="0" cellpadding="0" border="0" width="442">
		<tr><td height="11"></td></tr>
		<tr>
			<td height="39" valign="top" align="center"><a href="javascript:;" onclick="window.print();"><img src="<%=imageServer%>/tour_img/btn/btn_print.gif" class="btn"></a><a href="javascript:;" onclick="window.close();"><img src="<%=imageServer%>/tour_img/btn/btn_confirm2.gif"></a></td>
		</tr>
		</table>
		<!-- 버튼 / -->

		<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0"><tr><td><img src="<%=imageServer%>/tour_img/mypage/pop_btm_accountinfo.gif"></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>

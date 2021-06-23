<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%   
  String pageNum = "3";
  String McNum = "0";
  String sub = "1";  
  
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript">
<!--
function goResv() {
	window.open("/preserv/plz_resv_pop.jsp", "", "width=730, height=500 scrollbars=no");
}
-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/plz/tour_plz_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../include/plz/tour_plz_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">PLZ관광</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">상품안내<img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">상품1</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz03_01.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz03_02.jpg"></td></tr>
				<tr><td>
				
				
<table border="0" cellpadding="0" cellspacing="0" width="690">
	<tr height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="26">
			<td width="1" align="center" bgcolor="#CCCCCC"></td>
			<td width="36" align="center">구분</td>
			<td width="1" height="26" align="center" bgcolor="#CCCCCC"></td>
			<td width="22" height="26" align="center">순</td>
			<td width="138" height="26" align="center">대리점명</td>
			<td width="63" height="26" align="center">대표</td>
			<td height="26" align="center">주소</td>
			<td width="98" height="26" align="center">전화번호</td>
			<td width="84" height="26" align="center">팩스</td>
			<td width="1" height="26" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td rowspan="28" align="center" bgcolor="#CCCCCC"></td>
			<td rowspan="28" align="center">서울</td>
			<td width="1" height="672" rowspan="28" align="center" bgcolor="#CCCCCC"></td>
			<td align="center">1</td>
			<td>&nbsp;㈜아주특별한여행</td>
			<td>정관수</td>
			<td>서울 강남구 삼성2동38-29
		  한어빌딩 2F</td>
			<td>02-545-3994</td>
			<td>02-545-6882</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">2</td>
			<td>&nbsp;㈜현대H&amp;S</td>
			<td>홍성원</td>
			<td>서울 강동구 암사동513-16
		  현대H&amp;S빌딩 3층</td>
			<td>02-3014-2501</td>
			<td>02-3014-2519</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">3</td>
			<td>&nbsp;㈜일연인베스트먼트</td>
			<td>안교식</td>
			<td>서울 강동구 길동445-3 
		  정우빌딩 14층</td>
			<td>02-6911-7700</td>
			<td>02-6911-7710</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">4</td>
			<td>&nbsp;㈜통일농업교류센터</td>
			<td>김원일</td>
			<td>서울 서초구 양재동223번지<br>
		  양곡도매시장 314호</td>
			<td>070-7101-5519</td>
			<td>02-577-7318</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">5</td>
			<td>&nbsp;㈜고려드림투어</td>
			<td>오정원</td>
			<td>서울 서초구 양재동215<br>
		  하이브랜드 리빙관 13층 1321</td>
			<td>02-572-8161</td>
			<td>02-2155-3161</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">6</td>
			<td>&nbsp;㈜K코오롱트래블</td>
			<td>김지화</td>
			<td>서울 성동구 용답동103-1
		  그린빌딩 1층</td>
			<td>02-757-7780</td>
			<td>02-2242-4050</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">7</td>
			<td>&nbsp;㈜채널라인</td>
			<td>최요식</td>
			<td>서울 송파구 오금동28번지<br>
		  서울레져관광타운 1층 2호</td>
			<td>02-449-6071</td>
			<td>02-404-6078</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">8</td>
			<td>&nbsp;아이리더스투어㈜</td>
			<td>함진홍</td>
			<td>서울 송파구 송파동146-2
		  일조빌딩 303호</td>
			<td>02-515-1889</td>
			<td>02-412-5511</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">9</td>
			<td>&nbsp;금강교육개발원㈜</td>
			<td>손창용</td>
			<td>서울 용산구    후암동105-194</td>
			<td>02-779-6664</td>
			<td>02-730-6662</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">10</td>
			<td>&nbsp;㈜VIP관광여행사</td>
			<td>김성진</td>
			<td>서울 용산구 갈월동66    신아빌딩 1F</td>
			<td>02-319-3322</td>
			<td>02-319-3343</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">11</td>
			<td>&nbsp;코레일투어서비스㈜</td>
			<td>김웅</td>
			<td>서울 용산구 청파동1가95<br>
		  KORAIL KTX B/D 2층</td>
			<td>02-2084-7727</td>
			<td>02-2084-7719</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">12</td>
			<td>&nbsp;㈜기독교방송여행사</td>
			<td>김동권</td>
			<td>서울 양천구 목동917-1    기독교방송 11층</td>
			<td>02-2061-3311</td>
			<td>02-2645-5522</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">13</td>
			<td>&nbsp;금강산닷컴㈜</td>
			<td>홍성균</td>
			<td>서울 종로구 안국동148번지    해영회관906호</td>
			<td>02-739-1090</td>
			<td>(02) 739-3222</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">14</td>
			<td>&nbsp;㈜세일여행사</td>
			<td>박주용</td>
			<td>서울 종로구 경운동91-1</td>
			<td>02-724-0642</td>
			<td>02-733-2884</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">15</td>
			<td>&nbsp;㈜하나투어</td>
			<td>박상환</td>
			<td>서울 종로구 공평동1번지<br>
			  (주)하나투어빌딩 5층
		  하나투어인터내셔날</td>
			<td>02-398-6522</td>
			<td>02-6234-2301</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">16</td>
			<td>&nbsp;㈜오케이투어</td>
			<td>심재혁</td>
			<td>서울 종로구 인사동43번지    대일빌딩 14/15F</td>
			<td>02-3705-2405</td>
			<td>02-6234-0507</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">17</td>
			<td>&nbsp;롯데관광개발㈜</td>
			<td>유동수</td>
			<td>서울 종로구 관철동266    롯데관광개발㈜</td>
			<td>1577-3700</td>
			<td>02-736-1355</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">18</td>
			<td>&nbsp;㈜모두투어네트워크</td>
			<td>우종웅</td>
			<td>서울 중구 을지로1가188-3    백남빌딩 5층</td>
			<td>02-728-8700</td>
			<td>02-2021-7827</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">19</td>
			<td>&nbsp;㈜NH여행</td>
			<td>권달읍</td>
			<td>서울 종로구    신문로1가163번지 오피시아 7층</td>
			<td>02-3276-3947</td>
			<td>02-3276-3940</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">20</td>
			<td>&nbsp;㈜한영관광개발</td>
			<td>진병렬</td>
			<td>서울 종로구 신문로1가163    광화문<br>
		  오피시아빌딩 2023</td>
			<td>02-3276-3733</td>
			<td>02-3276-3732</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">21</td>
			<td>&nbsp;㈜동화항공여행사</td>
			<td>이재학</td>
			<td>서울 성북구 길음동33-13</td>
			<td>02-984-1161</td>
			<td>02-982-8804</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">22</td>
			<td>&nbsp;두레평화관광여행사㈜</td>
			<td>이영신</td>
			<td>서울 강북구 번1동    446-13 가든타워빌딩<br>
		  1116~1117호</td>
			<td>02-717-0500</td>
			<td>02-707-0050</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">23</td>
			<td>&nbsp;㈜에프엠텍</td>
			<td>신무송</td>
			<td>서울 종로구 운니동98-5    삼환빌딩 8층<br>
			  (주)에프엠텍 
		  관광사업부</td>
			<td>02-720-0909</td>
			<td>02-747-7966</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">24</td>
			<td>&nbsp;㈜금강산관광</td>
			<td>나호성</td>
			<td>서울 종로구 내수동75    용비어천가 1101호</td>
			<td>02-722-2118</td>
			<td>02-733-3185</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">25</td>
			<td>&nbsp;엘렉토-E모던투어</td>
			<td>정선,<br>
		  김계중</td>
			<td>서울 종로구 내수동 72<br>
			  경희궁의 아침2단지 오피스텔 
		  1418호</td>
			<td>02-720-4343</td>
			<td>02-720-4364</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">26</td>
			<td>&nbsp;금성관광㈜</td>
			<td>김태일</td>
			<td>서울 중구 북창동35번지    우성빌딩 601호</td>
			<td>02-755-5000</td>
			<td>02-778-3003</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">27</td>
			<td>&nbsp;신일관광㈜</td>
			<td>이신일</td>
			<td>서울 중구 태평로2가68-7<br>
		  디지털 조선일보빌딩 1층</td>
			<td>02-775-3333</td>
			<td>02-775-6018</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">28</td>
			<td>&nbsp;㈜서울항공여행사</td>
			<td>김홍배</td>
			<td>서울 중구 무교동32-2    남강빌딩 7층<br>
		  서울항공여행사</td>
			<td>02-753-8585</td>
			<td>02-776-1159</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
			
		<tr align="center" height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td width="1" rowspan="8" align="center" bgcolor="#CCCCCC"></td>
			<td rowspan="8" align="center">경기</td>
			<td width="1" height="209" rowspan="8" align="center" bgcolor="#CCCCCC"></td>
			<td align="center">29</td>
			<td>&nbsp;(주)대한여행사</td>
			<td>김정한</td>
			<td>경기 안산시 고잔동533-3    영풍프라자 1층</td>
			<td>031-414-6114</td>
			<td>031-410-5443</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">30</td>
			<td>&nbsp;드림관광 (주)</td>
			<td>김형호</td>
			<td>경기 성남시 분당구수내동6-9<br>
			  현대수내프라자 3층<br> 
		  313호</td>
			<td>031-718-6636-8</td>
			<td>031-718-6639</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">31</td>
			<td>&nbsp;(주)한솔여행사</td>
			<td>최영찬</td>
			<td>경기 수원시 권선구    권선동1165-3 205</td>
			<td>031-231-1777</td>
			<td>031-231-1780</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="33">
			<td height="33" align="center">32</td>
			<td>&nbsp;(주)금강산투어</td>
			<td>조필연</td>
			<td width="274">서울시 영등포구 여의도동 45-5번지<br>
			  대우메종리브르 
		  516호</td>
			<td>02-3775-2266</td>
			<td></td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="32">
			<td height="32" align="center">33</td>
			<td>&nbsp;(주)씽씽투어</td>
			<td>김선관</td>
			<td width="274">경기 부천시 원미구 상동 543-1<br>
			  승재밀레니엄오피스텔 204호<br>
			  (홈플러스주차장입구)</td>
			<td>032-329-8500</td>
			<td>032-328-9958</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">34</td>
			<td>&nbsp;(주)투어센스네트워크</td>
			<td>전병태</td>
			<td>인천시 남동구 구월동    1133-12<br>
		  한빛빌딩 402</td>
			<td>1544-6638</td>
			<td></td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">35</td>
			<td>&nbsp;(주)평양금강산투어</td>
			<td>최용관</td>
			<td>인천시 남동구 간석4동    240-1<br>
		  아트폴리스&nbsp; 207호</td>
			<td>032-815-2119&nbsp;</td>
			<td></td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">36</td>
			<td>&nbsp;(주)라이브투어엔레포츠</td>
			<td>이영일</td>
			<td>경기 고양시 일산동구    백석동1324번지<br>
		  굿모닝타워 2차 1004호</td>
			<td>031-902-2662</td>
			<td>031-902-5432</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
			<tr align="center" height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td width="1" rowspan="2" align="center" bgcolor="#CCCCCC"></td>
			<td rowspan="2" align="center">해외</td>
			<td width="1" height="48" rowspan="2" align="center" bgcolor="#CCCCCC"></td>
			<td align="center">37</td>
			<td>(주)중앙고속관광</td>
			<td>김상호</td>
			<td>서울 중구 소공동롯데호텔    본관6층<br>
		  (주)중앙고속관광</td>
			<td>02-2269-8478</td>
			<td>02-2253-8478</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">38</td>
			<td>(주)고앤씨</td>
			<td>호준환</td>
			<td>서울 서초구 서초2동    1338-21<br>
		  코리아비즈니스센터 1010</td>
			<td>02-6243-7071</td>
			<td>02-6243-7074</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
</table>








				</td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz03_03.jpg" width="690" height="82" border="0" usemap="#Map"></td>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>





<map name="Map"><area shape="rect" coords="268,17,409,59" href="javascript:goResv();"></map></body>
</html>
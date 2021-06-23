<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%   
String McNum = "3";
String sub = "2";
String pageNum = "2";
String subNum = "";
%>
<head>
<title> 금강산관광    </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/start/tour_start_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../include/start/tour_start_left.jsp" %>
            <!--  left menu flash -->			
			</td>
			<td>
				<!-- / content  -->
<p>				
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/start/tit_start02.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">출발안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">교통안내</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<DIV id="print_area" class=newpage style="width:690">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/start/img_top_start02.jpg"></td></tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr>
							<td width="11" height="15"></td>
							<td width="674"></td>
						</tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/start/stit_start021.gif"></td></tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td>화진포 아산 휴게소는 금강산에 들어가기 위한 집결지입니다. 집결지에 오시면 티켓 발권 등의 수속을 시작하실 수 있습니다.</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0211.gif"><!-- 약도 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- 집결지 : 화진포 아산 휴게소<br>- 주&nbsp;&nbsp;&nbsp;소 : 강원도 고성군 현내면 초도리 산28번지<br>- 집결지 관련 문의 : 현대아산 고성사무소 ☎ (033)681-9400</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_map_start02.jpg" width="674"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0212.gif"><!-- 탑승 수속시간 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- 2박 3일 : 12:00<br>- 1박 2일(8시출발) : 06:00<br>- 1박 2일(11시출발) : 09:30<br>- 당일 : 06:00<br>※ 탑승 수속시간에 늦지 않도록 도착하셔야 하며, 관광도우미의 안내에 협조하여 주시기 바랍니다.</td>
						</tr>
						<tr><td colspan="2" height="47"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/start/stit_start022.gif"></td></tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0221.gif"><!-- 개별차량 이용 집결지 도착 고객 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>화진포 아산 휴게소에 무료주차가 가능하며 화진포 아산 휴게소에서 남측출입사무소까지의 왕복 버스비용을 별도로 지불하셔야 합니다.</td>
						</tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" bgcolor="#F6F6F6" cellpadding="0" cellspacing="0" border="0">
								<tr><td height="15"></td></tr>
								<tr>
									<td align="center">
										<table width="640" cellpadding="0" cellspacing="0" border="0">
										<tr valign="top">
											<td width="9"><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td width="631">서울출발 - 팔당대교 - 양평 - 홍천 - 인제(44번) - 원통 - 용대삼거리 - 진부령 - 간성방향 직진<br>- 통일전망대 외길(7번 국도) - 화진포 아산휴게소 도착</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>서울출발 - 워커힐 - 구리시 - 가평 - 춘천 - 중앙고속도로 - 홍천 - 인제 - 원통 -용대리 - 진부령 - 간성방향직진<br>- 통일전망대 외길(7번 국도) - 화진포 아산휴게소 도착</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>영동고속도로 - 원주 - 중앙고속도로 - 홍천 - 인제 - 원통 - 용대삼거리 - 진부령 - 간성방향직진<br>- 통일전망대 외길(7번 국도) - 화진포 아산휴게소 도착</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>영동고속도로 - 강릉 - 주문진 - 속초 - 간성방향 - 통일전망대 외길(7번 국도) - 화진포 아산휴게소 도착</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr><td height="15"></td></tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0222.gif"><!-- 단체버스 이용 고객   --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>거주지로부터 단체로 전세버스를 이용하시는 분들은 최소 5일전까지 예약을 하신 대리점으로 버스번호와 탑승인원 등을 반드시 통보하시기 바랍니다.<br>※ 차량번호를 사전에 관할 군부대에 통보해야만 민통선 검문소 통과가 가능합니다</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0223.gif"><!-- 지정버스 이용 고객(서울) --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>고객들의 편의를 위하여 관광버스가 출발시간과 도착시간에 맞춰 출발지(남측출입사무소)까지의 구간을 정기적으로 운행합니다. 필요하신 고객께서는 아래의 지정 버스회사로 직접 예약하여 주시기 바랍니다.</td>
						</tr>
						<tr><td colspan="2" height="27"></td></tr>
						<tr>
							<td></td>
							<td height="27" valign="top">- <strong>금강산관광 각 지역별 지정버스 운행 현황</strong></td>
						</tr>
						<tr>
							<td></td>
							<td valign="top">
								<table width="674" cellpadding="1" cellspacing="1" border="0" class="tabline">
								<tr align="center">
									<td width="47" height="26" class="bg_white">구간</td>
									<td width="39" class="bg_white">지역</td>
									<td width="47" class="bg_white">출발일</td>
									<td width="61" class="bg_white">버스<br>회사</td>
									<td width="67" class="bg_white">연락처</td>
									<td width="47" class="bg_white">출발<br>시간</td>
									<td width="246" class="bg_white">출발지</td>
									<td width="75" class="bg_white">왕복요금<span class="fs11">(인)</span></td>
									<td width="45" class="bg_white">약도</td>
								</tr>
								<tr align="center">
									<td class="bg_white" rowspan="2">1박2일<br>(11시)</td>
									<td class="bg_white b" rowspan="2">서울</td>
									<td class="bg_white" rowspan="2">매일</td>
									<td class="bg_white" rowspan="2">대화<br>관광</td>
									<td class="bg_white lpad_10" rowspan="2" align="left">02)<br>764-2255</td>
									<td height="26" class="bg_white">05:50</td>
									<td class="bg_white lpad_5" align="left">광화문사거리 서대문방향 70m 국민은행앞</td>
									<td class="bg_white" rowspan="2"><font color="#459E9D">30,000원/인</font></td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:20</td>
									<td class="bg_white lpad_5" align="left">종합운동장 6번출구 GS편의점 앞</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" rowspan="15">2박3일</td>
									<td class="bg_white b" rowspan="4">서울</td>
									<td class="bg_white" rowspan="4">매일</td>
									<td class="bg_white" rowspan="2">대화<br>관광</td>
									<td class="bg_white lpad_10" rowspan="2" align="left">02)<br>733-0017</td>
									<td height="26" class="bg_white">08:00</td>
									<td class="bg_white lpad_5" align="left">계동 현대사옥 스포츠센터 앞</td>
									<td class="bg_white" rowspan="4"><font color="#459E9D">30,000원/인</font></td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_gaedong.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:15</td>
									<td class="bg_white lpad_5" align="left">광화문사거리 서대문방향 70m 국민은행앞</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" rowspan="2">대원<br>관광</td>
									<td class="bg_white lpad_10" rowspan="2" align="left">02)<br>575-7710</td>
									<td height="26" class="bg_white">08:00</td>
									<td class="bg_white lpad_5" align="left">압구정 현대백화점 주차장</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_apgujung.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:30</td>
									<td class="bg_white lpad_5" align="left">종합운동장 6번출구 GS편의점 앞</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td class="bg_white b" rowspan="4">대전</td>
									<td class="bg_white" rowspan="4">월,수,금</td>
									<td class="bg_white" rowspan="4">동선<br>관광</td>
									<td class="bg_white lpad_10" rowspan="4" align="left">1544-5980</td>
									<td height="26" class="bg_white">06:30</td>
									<td class="bg_white lpad_5" align="left">서대전역 택시 승장강 앞</td>
									<td class="bg_white" rowspan="4"><font color="#459E9D">40,000원/인</font></td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:50</td>
									<td class="bg_white lpad_5" align="left">대전역 동광장 동쪽 출구 주차장 앞</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">07:30</td>
									<td class="bg_white lpad_5" align="left">청주 시외버스터미널 건너편 GS주유소 앞</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:00</td>
									<td class="bg_white lpad_5" align="left">천안 톨게이트 만남의 광장 앞</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td class="bg_white b" rowspan="4">영남</td>
									<td class="bg_white" rowspan="4">수,금</td>
									<td class="bg_white" rowspan="4">새부산<br>관광투어</td>
									<td class="bg_white lpad_10" rowspan="4" align="left">051)<br>851-0600</td>
									<td height="26" class="bg_white">05:50</td>
									<td class="bg_white lpad_5" align="left">서면로터리 KT전화국옆 신한은행 앞</td>
									<td class="bg_white" rowspan="2"><font color="#459E9D">70,000원/인</font></td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:10</td>
									<td class="bg_white lpad_5" align="left">동래지하철 공영주차장 앞</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">07:10</td>
									<td class="bg_white lpad_5" align="left">경주톨게이트 만남의 광장 휴게소</td>
									<td class="bg_white" rowspan="2"><font color="#459E9D">60,000원/인</font></td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_goungjutol.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:10</td>
									<td class="bg_white lpad_5" align="left">동대구 톨게이트 앞</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_dongdaegu.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- 보기 --></td>
								</tr>
								<tr align="center">
									<td class="bg_white b" rowspan="3">호남</td>
									<td class="bg_white" rowspan="3">수,금</td>
									<td class="bg_white" rowspan="3">송광관광<br>버스</td>
									<td class="bg_white lpad_10" rowspan="3" align="left">062)<br>383-1133</td>
									<td height="26" class="bg_white">05:00</td>
									<td class="bg_white lpad_5" align="left">광주 상무지구 송광여행사 앞</td>
									<td class="bg_white" rowspan="3"><font color="#459E9D">60,000원/인</font></td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:00</td>
									<td class="bg_white lpad_5" align="left">정읍 정읍IC(호남고속도로)</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:50</td>
									<td class="bg_white lpad_5" align="left">전주 월드컵경기장 주차장</td>
									<td class="bg_white"></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onclick="fc_print();"><img src="<%=imageServer%>/tour_img/btn/btn_start_print.gif" class="btn"></a><!-- 인쇄하기 --></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				</div>
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


</body>
</html>
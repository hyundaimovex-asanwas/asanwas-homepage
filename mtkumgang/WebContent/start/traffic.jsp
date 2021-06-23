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
							<td><img src="<%=imageServer%>/tour_img/start/img_map_start02.jpg" width="674" height="416" border="0" usemap="#Map"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0212.gif"><!-- 탑승 수속시간 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- 2박 3일 : 13:00<br>
							  - 1박 2일(8시출발) : 06:00<br>-<!-- 1박 2일(11시출발) : 09:30<br> -->- 당일 : 06:00<br>※ 탑승 수속시간에 늦지 않도록 도착하셔야 하며, 관광도우미의 안내에 협조하여 주시기 바랍니다.</td>
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
							<td>거주지로부터 단체로 전세버스를 이용하시는 분들은 최소 5일전까지 예약을 하신 대리점으로 버스번호와 탑승인원 등을 반드시 통보하시기 바랍니다.<br>
                          ※ 차량번호를 사전에 관할 군부대에 통보해야만 민통선 검문소 통과가 가능합니다.</td>
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
							
                        <td valign="top"> <table width="674" cellpadding="1" cellspacing="1" border="0" class="tabline">
                            <tr> 
                              <td width="38" height="26" align="center" class="bg_white">구간</td>
                              <td width="34" align="center" class="bg_white">지역</td>
                              <td width="37" align="center" class="bg_white">출발일</td>
                              <td width="65" align="center" class="bg_white">버스<br>
                                회사</td>
                              <td width="57" align="center" class="bg_white">연락처</td>
                              <td width="33" align="center" class="bg_white">출발<br>
                                시간</td>
                              <td width="250" align="center" class="bg_white">출발지</td>
                              <td width="72" align="center" class="bg_white">왕복요금<span class="fs11">(인)</span></td>
                              <td width="60" align="center" class="bg_white">약도</td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white">1박2일<br>
                                (11시)</td>
                              <td rowspan="2" align="center" class="bg_white b">서울</td>
                              <td rowspan="2" align="center" class="bg_white">매일</td>
                              <td rowspan="2" align="center" class="bg_white">대화<br>
                                관광</td>
                              <td class="bg_white lpad_10" rowspan="2" align="left">02)<br>
                                764-2255</td>
                              <td height="26" align="center" class="bg_white">05:50</td>
                              <td class="bg_white lpad_5" align="left">광화문사거리 
                                서대문방향 70m 투섬플레이스 <br>
                                카페 앞</td>
                              <td rowspan="2" align="center" class="bg_white"><font color="#459E9D">30,000원/인</font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:20</td>
                              <td class="bg_white lpad_5" align="left">2호선 종합운동장역 6번출구 
                                오른쪽 옆 </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white">1박2일<br>
                                (8시)<br>
                                ㆍ<br>
                                당일 </td>
                              <td rowspan="2" align="center" class="bg_white b">서울</td>
                              <td rowspan="2" align="center" class="bg_white"><b>화,금,토</b> 
                                <p>화:당일<br>
                                  (수)관광</p>
                                <p>금:당일/<br>
                                  1박2일<br>
                                  (토)관광</p>
                                <p>토:당일<br>
                                  (일)관광</p></td>
                              <td rowspan="2" align="center" class="bg_white"><p>대원<br>
                                  관광</p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/tour_img/start/btn_online.gif" width="65" height="16" border="0"></a></p></td>
                              <td rowspan="2" align="left" class="bg_white lpad_10">02)<br>
                                458-4514</td>
                              <td height="217" align="center" class="bg_white">20:00</td>
                              <td class="bg_white lpad_5" align="left">광화문 사거리 
                                서대문방향 70m 투섬플레이스 <br>
                                카페  앞<br> 
                                <img src="<%=imageServer%>/tour_img/start/date01.gif" width="240" height="170"> 
                              </td>
                              <td rowspan="2" align="center" class="bg_white"><font color="#459E9D">40,000<br>
                                원/인 
                                <p>(20,000<br>
                                  원 편도)</p>
                                </font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="201" class="bg_white">20:30</td>
                              <td class="bg_white lpad_5" align="left">2호선 종합운동장역 6번출구 오른쪽 옆<br> 
                                <img src="<%=imageServer%>/tour_img/start/date02.gif" width="240" height="170">                              </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="15" align="center" class="bg_white">2박3일</td>
                              <td rowspan="4" align="center" class="bg_white b">서울</td>
                              <td rowspan="4" align="center" class="bg_white">매일</td>
                              <td rowspan="2" align="center" class="bg_white"><p>대화<br>
                                  관광</p>
                                <p><a href="http://www.daehwatour.co.kr/" target="_blank"><img src="<%=imageServer%>/tour_img/start/btn_online.gif" width="65" height="16" border="0"></a></p></td>
                              <td class="bg_white lpad_10" rowspan="2" align="left">02)<br>
                                733-0017</td>
                              <td height="26" align="center" class="bg_white">08:30</td>
                              <td class="bg_white lpad_5" align="left">계동 현대사옥 
                                스포츠센터 앞</td>
                              <td rowspan="4" align="center" class="bg_white"><font color="#459E9D">30,000원/인</font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gaedong.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:45</td>
                              <td class="bg_white lpad_5" align="left">광화문사거리 
                                서대문방향 70m 투섬플레이스 <br>
                                카페 앞</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white" rowspan="2"><p>대원<br>
                                  관광</p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/tour_img/start/btn_online.gif" width="65" height="16" border="0"></a></p></td>
                              <td class="bg_white lpad_10" rowspan="2" align="left"><p>02)<br>
                                  458-4514</p>
                                02)458-4550</td>
                              <td height="26" class="bg_white">08:30</td>
                              <td class="bg_white lpad_5" align="left">압구정 현대백화점 
                                주차장</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_apgujung.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">09:00</td>
                              <td class="bg_white lpad_5" align="left">2호선 종합운동장역 6번출구 오른쪽 옆</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="4">대전</td>
                              <td class="bg_white" rowspan="4">월,수,금</td>
                              <td class="bg_white" rowspan="4">동선<br>
                                관광</td>
                              <td class="bg_white lpad_10" rowspan="4" align="left">1544-5980</td>
                              <td height="26" class="bg_white">06:30</td>
                              <td class="bg_white lpad_5" align="left">서대전역 택시 
                                승장강 앞</td>
                              <td class="bg_white" rowspan="4"><font color="#459E9D">50,000원/<br>
                                성인,대학생 
                                <p>40,000원/<br>
                                  중,고등학생</p>
                                <p>30,000원/<br>
                                  초등학생이하</p>
                                </font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:50</td>
                              <td class="bg_white lpad_5" align="left">대전역 동광장 
                                동쪽 출구 주차장 앞</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">07:30</td>
                              <td class="bg_white lpad_5" align="left">서청주 톨게이트 
                                앞</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:00</td>
                              <td class="bg_white lpad_5" align="left">천안 톨게이트 
                                만남의 광장 앞</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="4">영남</td>
                              <td class="bg_white" rowspan="4">수,금</td>
                              <td class="bg_white" rowspan="4">새부산<br>
                                관광투어</td>
                              <td class="bg_white lpad_10" rowspan="4" align="left">051)<br>
                                851-0600</td>
                              <td height="26" class="bg_white">05:50</td>
                              <td class="bg_white lpad_5" align="left">서면로터리 KT전화국옆 
                                신한은행 앞</td>
                              <td class="bg_white" rowspan="2"><font color="#459E9D">70,000원/인</font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:10</td>
                              <td class="bg_white lpad_5" align="left">동래지하철 공영주차장 
                                앞</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">07:10</td>
                              <td class="bg_white lpad_5" align="left">경주톨게이트 
                                만남의 광장 휴게소</td>
                              <td class="bg_white" rowspan="2"><font color="#459E9D">60,000원/인</font></td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_goungjutol.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:10</td>
                              <td class="bg_white lpad_5" align="left">동대구 톨게이트 
                                앞</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_dongdaegu.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="3">호남</td>
                              <td class="bg_white" rowspan="3">수,금</td>
                              <td class="bg_white" rowspan="3">송광관광<br>
                                버스</td>
                              <td class="bg_white lpad_10" rowspan="3" align="left">062)<br>
                                383-1133</td>
                              <td height="26" class="bg_white">05:00</td>
                              <td class="bg_white lpad_5" align="left">광주 상무지구 
                                송광여행사 앞</td>
                              <td class="bg_white" rowspan="3"><font color="#459E9D">7</font><font color="#459E9D">0,000원/인</font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:00</td>
                              <td class="bg_white lpad_5" align="left">정읍 정읍IC(호남고속도로)</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:50</td>
                              <td class="bg_white lpad_5" align="left">전주 월드컵경기장 
                                주차장</td>
                              <td class="bg_white"></td>
                            </tr>
                          </table></td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr align="right">
						  <td height="17" colspan="2">&nbsp;</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0224.gif"><!-- 대중교통 이용고객  --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td>시외버스 : 동서울 터미널, 상봉터미널에서 간성(고성) 및 대진 行 시외 버스 이용 후 간성, 
                          <br>
                          대진에서 시내버스 1번 또는 1-1 번을 이용하여, 집결지(화진포아산휴게소) 로 이동</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0225.gif"><!-- 고속버스 이용고객 --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td>서울 강남고속터미널에서 속초 행 고속버스 이용 후 통일전망대행 시외버스로 간성(고성)에서 
                          하차, <br>
                          다시 시내버스로 집결지(화진포아산휴게소) 로 이동</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onClick="fc_print();"><img src="<%=imageServer%>/tour_img/btn/btn_start_print.gif" class="btn"></a><!-- 인쇄하기 --></td>
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


<map name="Map">
  <area shape="rect" coords="67,210,170,226" href="http://www.dcffood.co.kr/07business_03.html" target="_blank" onFocus="this.blur()">
</map>
</body>
</html>
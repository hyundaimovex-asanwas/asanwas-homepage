<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%  
String pageNum = "1";
String subNum = "1";
String McNum = "4";
String sub = "1";
%>
<html>
<head>
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/eng_img/inc/java.js"></script>
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
        <%@ include file="/eng/include/start/tour_start_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/eng/include/start/tour_start_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/eng_img/start/tit_start02.gif"></td>
						<td align="right" class="linemap"></td>
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
				<tr><td><img src="<%=imageServer%>/eng_img/start/img_top_start02.jpg"></td></tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr>
							<td width="11" height="15"></td>
							<td width="674"></td>
						</tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/eng_img/start/stit_start021.gif"></td></tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td>You can start the entry procedure by ticketing here. </td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0211.gif"><!-- 약도 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- Gathering Point : Asan Rest Area, Hwajinpo <br>
- Address : San 28, Chodo-ri, Hyunlae-myun, Kosung-gun, Gangwon-Province<br>
- Inquiries : Hyundai Asan Kosung Office (033)681-9400 
</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/img_map_start02.jpg" width="674" height="416" border="0" usemap="#Map"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0212.gif"><!-- 탑승 수속시간 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- 2 nights 3 days trip : 13:00<br>
- 1 night 2 days trip (depart at 8AM) : 06:00<br>
- One day trip : 06:00<br>
- We ask you to be sure to arrive by the boarding time and follow the tour guide뭩 instruction. 
</td>
						</tr>
						<tr><td colspan="2" height="47"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/eng_img/start/stit_start022.gif"></td></tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0221.gif"><!-- 개별차량 이용 집결지 도착 고객 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>You can park your car for free at the Asan Rest Area and but will be charged for taking bus between Asan Rest Area and the South Korean CIQ Office. 
</td>
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
											<td width="631">Seoul - Paldang Bridge - Yangpyeong - Hongcheon - Inje(Route 44) - Wontong - Yongdae 3-way intersection - Jinburyeong - Go straight toward Ganseong - Take Route 7 toward Unification Observatory - Asan Rest Area
</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>Seoul - Walkerhill - Guri-si - Gapyeong - Chuncheon - Jungang Highway - Hongcheon - Inje - Yongdae-ri - Jinburyeong - Go straight toward Gansung - Take Route 7 toward Unification Observatory - Asan Rest Area
</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>Yeongdong Express Highway - Wonju - Jungang Highway - Hongcheon - Inje - Yongdae-ri - Jinburyeong - Go straight toward Gansung - Take Route 7 toward Unification Observatory - Asan Rest Area
</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>Yeongdong Express Highway - Gangneung - Jumunjin - Sokcho - Toward Ganseong - Take Route 7 toward Unification Observatory - Asan Rest Area</td>
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
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0222.gif"><!-- 단체버스 이용 고객   --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>If you come on a chartered bus, make sure you notify the agency through which you made the reservation of the bus plate number and number of the people on the bus at least 5 days in advance of your departure. <br>
&#8251; To pass the checkpoint of the Civilian Control Line(CCL), the plate number of the vehicle must be reported to the local military base. 
</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0223.gif"><!-- 지정버스 이용 고객(서울) --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>A shuttle bus is available to the departure point(South Korean CIQ Office) for the convenience of travelers. You can make a reservation for the shuttle bus through the designated bus companies below.</td>
						</tr>
						<tr><td colspan="2" height="27"></td></tr>
						<tr>
							<td></td>
							<td height="27" valign="top">- <strong>Shuttle Bus Services by Area </strong></td>
						</tr>
						<tr>
							<td></td>
							
                        <td valign="top"> <table width="674" cellpadding="1" cellspacing="1" border="0" class="tabline">
                            <tr> 
                              <td width="38" height="26" align="center" class="bg_white">Duration 
</td>
                              <td width="34" align="center" class="bg_white">Area</td>
                              <td width="37" align="center" class="bg_white">Departure
Day </td>
                              <td width="65" align="center" class="bg_white">Bus Company 
</td>
                              <td width="57" align="center" class="bg_white">Contact Information </td>
                              <td width="33" align="center" class="bg_white">Departure </td>
                              <td width="250" align="center" class="bg_white">Departure Point 
</td>
                              <td width="72" align="center" class="bg_white">Round Trip Fares</td>
                              <td width="60" align="center" class="bg_white">Map</td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white">1 night
2 days
(11 O'clock)</td>
                              <td rowspan="2" align="center" class="bg_white b">Seoul</td>
                              <td rowspan="2" align="center" class="bg_white">Every day </td>
                              <td rowspan="2" align="center" class="bg_white">Daehwa Tour </td>
                              <td class="bg_white lpad_10" rowspan="2" align="left">02)<br>
                                764-2255</td>
                              <td height="26" align="center" class="bg_white">05:50</td>
                              <td class="bg_white lpad_5" align="left">In front of Kookmin Bank 70m from Gwanghwamun intersection toward Seodaemun 
</td>
                              <td rowspan="2" align="center" class="bg_white"><font color="#459E9D">30,000 won/person</font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:20</td>
                              <td class="bg_white lpad_5" align="left">In front of GS convenience store near Exit 6 of Sports Complex Station 
</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white">1 night2 days(8 O'clock)One day
</td>
                              <td rowspan="2" align="center" class="bg_white b">Seoul 
</td>
                              <td rowspan="2" align="center" class="bg_white"><b>Tue, Fri, SatTue</b> : One day(Wed)tourFri : One day/1 night2 days(Sat) tourSat : One day(Sun) tour
</td>
                              <td rowspan="2" align="center" class="bg_white"><p>Daewon Tour 
</p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/eng_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td rowspan="2" align="left" class="bg_white lpad_10">02)<br>
                                458-4514</td>
                              <td height="217" align="center" class="bg_white">20:00</td>
                              <td class="bg_white lpad_5" align="left">In front of Kookmin Bank 70m from Gwanghwamun intersection toward Seodaemun 
<br> 
                                <img src="<%=imageServer%>/eng_img/start/date01.gif" width="234" height="219"> 
                              </td>
                              <td rowspan="2" align="center" class="bg_white"><font color="#459E9D">40,000 won/person 
(20,000 won, one-way) 
                                </font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="201" class="bg_white">20:30</td>
                              <td class="bg_white lpad_5" align="left">In front of GS convenience store near Exit 6 of Sports Complex Station 
<br> 
                                <img src="<%=imageServer%>/eng_img/start/date02.gif" width="234" height="219">                              </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="15" align="center" class="bg_white">1 night2 days(8 O'clock)One day</td>
                              <td rowspan="4" align="center" class="bg_white b">Seoul </td>
                              <td rowspan="4" align="center" class="bg_white">Every
day </td>
                              <td rowspan="2" align="center" class="bg_white"><p>Daewon Tour
</p>
                                <p><a href="http://www.daehwatour.co.kr/" target="_blank"><img src="<%=imageServer%>/eng_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td class="bg_white lpad_10" rowspan="2" align="left">02)<br>
                                733-0017</td>
                              <td height="26" align="center" class="bg_white">08:30</td>
                              <td class="bg_white lpad_5" align="left">In front of Sports Center of Hyundai building, Gye-dong 
</td>
                              <td rowspan="4" align="center" class="bg_white"><font color="#459E9D">30,000 won/person 
</font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gaedong.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:45</td>
                              <td class="bg_white lpad_5" align="left">In front of Kookmin Bank 70m from Gwanghwamun intersection toward Seodaemun </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white" rowspan="2"><p>Daewon Tour
</p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/eng_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td class="bg_white lpad_10" rowspan="2" align="left"><p>02)<br>
                                  458-4514</p>
                                02)458-4550</td>
                              <td height="26" class="bg_white">08:30</td>
                              <td class="bg_white lpad_5" align="left">Parking lot of Hyundai Department Store, Apgujeong-dong </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_apgujung.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">09:00</td>
                              <td class="bg_white lpad_5" align="left">In front of GS convenience store near Exit 6 of Sports Complex Station </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="4">Daejun </td>
                              <td class="bg_white" rowspan="4">Mon
Wed
Fri</td>
                              <td class="bg_white" rowspan="4">Dongsun Tour 
</td>
                              <td class="bg_white lpad_10" rowspan="4" align="left">1544-5980</td>
                              <td height="26" class="bg_white">06:30</td>
                              <td class="bg_white lpad_5" align="left">In front of the taxi stand of Seodaejeon Station  </td>
                              <td class="bg_white" rowspan="4"><font color="#459E9D">50,000 won/adult/college student 40,000 won/middle and high school student
30,000
won/person(elementary school student) 

                                </font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:50</td>
                              <td class="bg_white lpad_5" align="left">In front of the parking lot at the east exit of Dong Plaza of Daejeon Station </td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">07:30</td>
                              <td class="bg_white lpad_5" align="left">In front of the West Cheongju toll gate </td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:00</td>
                              <td class="bg_white lpad_5" align="left">In front of the plaza of Cheonan toll gate 
</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="4">Young-nam</td>
                              <td class="bg_white" rowspan="4">Wed, Fri 
</td>
                              <td class="bg_white" rowspan="4">New PusanTour</td>
                              <td class="bg_white lpad_10" rowspan="4" align="left">051)<br>
                                851-0600</td>
                              <td height="26" class="bg_white">05:50</td>
                              <td class="bg_white lpad_5" align="left">In front of the Shinhan bank on the way to KT telephone service in Seomyun rotary 
</td>
                              <td class="bg_white" rowspan="2"><font color="#459E9D">70,000 won/person 
</font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:10</td>
                              <td class="bg_white lpad_5" align="left">In front of the public parking lot near the Donglae Metro Station 
</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">07:10</td>
                              <td class="bg_white lpad_5" align="left">Rest Area plaza at the Gyungju toll gate </td>
                              <td class="bg_white" rowspan="2"><font color="#459E9D">60,000 won/person </font></td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_goungjutol.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:10</td>
                              <td class="bg_white lpad_5" align="left">In front of the Dongdaegu toll gate </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_dongdaegu.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/eng_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="3">Honam</td>
                              <td class="bg_white" rowspan="3">Wed, Fri</td>
                              <td class="bg_white" rowspan="3">Songkwang Sightseeing bus </td>
                              <td class="bg_white lpad_10" rowspan="3" align="left">062)<br>
                                383-1133</td>
                              <td height="26" class="bg_white">05:00</td>
                              <td class="bg_white lpad_5" align="left">In front of Songkwang Tour in Gwangju Business District 
</td>
                              <td class="bg_white" rowspan="3"><font color="#459E9D">60,000 won/person </font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:00</td>
                              <td class="bg_white lpad_5" align="left">Cheongeup IC (Honam Highway)</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:50</td>
                              <td class="bg_white lpad_5" align="left">Parking lot of Cheonju Worldcup Stadium </td>
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
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0224.gif"><!-- 대중교통 이용고객  --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td>Intercity bus : Use the intercity bus bound for Ganseong (Kosung) or Daejin at East Seoul Terminal or Sangbong Terminal and then transfer to local bus 1 or 1-1 at Gansung or Daejin. Get off at the gathering point (Asan Rest Area, Hwajinpo). 
</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0225.gif"><!-- 고속버스 이용고객 --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td>Get on an express bus bound for Sokcho at Gangnam Express Bus Terminal, transfer to a long distance bus bound for the Unification Observatory, get off at Ganseong(Kosung) and go to the gathering point(Asan Rest Area, Hwajinpo) by local bus. 
</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onClick="fc_print();"><img src="<%=imageServer%>/eng_img/start/btn_start_print.gif" class="btn"></a><!-- 인쇄하기 --></td>
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
        <%@ include file="/eng/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


<map name="Map">
  <area shape="rect" coords="67,210,170,226" href="http://www.dcffood.co.kr/07business_03.html" target="_blank" onFocus="this.blur()">
</map>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
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
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/jpn/include/start/tour_start_top_utf8.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/jpn/include/start/tour_start_left_utf8.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/jpn_img/start/tit_start02.gif"></td>
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
				<tr><td><img src="<%=imageServer%>/jpn_img/start/img_top_start02.jpg"></td></tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr>
							<td width="11" height="15"></td>
							<td width="674"></td>
						</tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/jpn_img/start/stit_start021.gif"></td></tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td>花津浦・牙山 (ファジンポアサン)休憩場は金剛山へ行くための集結場です。集結場へ到着しましたら
チケット発券等の手続きをはじめる事ができます。 </td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0211.gif"><!-- 약도 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- 集結場： 花津浦・牙山 (ファジンポアサン)休憩所
                              <br>
                              - 住所：江原道高城郡ヒョンネ面ミョンチョド里山28番地
                              <br>
                          - 集結地関連問い合わせ：現代牙山高城事務所　（033）-681-9400</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/img_map_start02.jpg" width="674" height="416" border="0" usemap="#Map"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0212.gif"><!-- 탑승 수속시간 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- 二泊三日：　13：00<br>
- 一泊二日(8時出発)：　06；00<br>
- 当日：　　06：00<br>
- 搭乗手続き時間にはくれぐれも遅れないようにして、観光ガイドの案内にご協力をお願いします
 
</td>
						</tr>
						<tr><td colspan="2" height="47"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/jpn_img/start/stit_start022.gif"></td></tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0221.gif"><!-- 개별차량 이용 집결지 도착 고객 --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>花津浦・牙山 (ファジンポアサン)休憩所は無料駐車が可能であり、 
花津浦・牙山 (ファジンポアサン)休憩所から南側出入事務所までの往復バス費用は別途発生します

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
											<td width="631">ソウル出発-八堂大橋-楊平-洪川- 麟蹄（４４番）-ウォントン-ヨンデ三差路-陳富嶺-ガンソン方向直行
-統一展望台一筋道（７番国道） 花津浦・牙山休憩所到着

</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>ソウル出発-　ウァーカーヒル　-グリ-　加平-春川-中央高速道路-洪川-麟蹄-ウォントン-ヨンデリ-陳富嶺-
ガンソン方向直行- 統一展望台一筋道（７番国道） 花津浦・牙山休憩所到着
</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>嶺東高速道路-原州-中央高速道路- 麟蹄(インゼ)-ウォントン-ヨンデ三差路-陳富嶺-ガンソン方向直行
-統一展望台一筋道（７番国道） 花津浦・牙山休憩所到着

										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>嶺東高速道路-江陵-ジュムンジン-束草-ガンソン方向-統一展望台一筋道（７番国道） 花津浦・牙山休憩所到着</td>
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
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0222.gif"><!-- 단체버스 이용 고객   --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>居住地から団体バスをご利用される方は遅くても5日前までには予約した代理店へバスナンバーと
搭乗人員等を必ずご連絡してください
                              <br>
                              *車両NOを先に管轄軍部隊へ通報せねば、民統線検問所の通過ができません</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0223.gif"><!-- 지정버스 이용 고객(서울) --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>お客様のために観光バスが出発時間と到着時間に合わせて出発地（南側出入事務所）までの区間を
定期的に運行をしてます。
必要なお客様は下記の指定バス会社へ直接ご予約をお願いします
</td>
						</tr>
						<tr><td colspan="2" height="27"></td></tr>
						<tr>
							<td></td>
							<td height="27" valign="top">- <strong>金剛山観光各地域別の指定バス運行状況 </strong></td>
						</tr>
						<tr>
							<td></td>
							
                        <td valign="top"> <table width="674" cellpadding="1" cellspacing="1" border="0" class="tabline">
                            <tr> 
                              <td width="38" height="26" align="center" class="bg_white">区間
</td>
                              <td width="34" align="center" class="bg_white">地域</td>
                              <td width="37" align="center" class="bg_white">出発日</td>
                              <td width="65" align="center" class="bg_white">バス会社 
</td>
                              <td width="57" align="center" class="bg_white">連絡先</td>
                              <td width="33" align="center" class="bg_white">出発
時間</td>
                              <td width="250" align="center" class="bg_white">出発地 
</td>
                              <td width="72" align="center" class="bg_white">往復料金</td>
                              <td width="60" align="center" class="bg_white">Map</td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white">1泊2日
(11時)
</td>
                              <td rowspan="2" align="center" class="bg_white b">ソウル</td>
                              <td rowspan="2" align="center" class="bg_white">毎日</td>
                              <td rowspan="2" align="center" class="bg_white">デファ
観光
 </td>
                              <td class="bg_white lpad_10" rowspan="2" align="left">02)<br>
                                764-2255</td>
                              <td height="26" align="center" class="bg_white">05:50</td>
                              <td class="bg_white lpad_5" align="left">光化門四つ角　西大門方向70m　国民銀行前
</td>
                              <td rowspan="2" align="center" class="bg_white"><font color="#459E9D">30,000WON/人
</font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:20</td>
                              <td class="bg_white lpad_5" align="left">総合運動場６番出口GSコンビに前 
</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white">1泊2日
(９時)
　・
当日

</td>
                              <td rowspan="2" align="center" class="bg_white b">ソウル
 
</td>
                              <td rowspan="2" align="center" class="bg_white">火、金
　土
火：当　日
(水)観光
金：当日/1泊2日(土)観光
土：当日
(日)観光</td>
                              <td rowspan="2" align="center" class="bg_white"><p>DEWON
観光

</p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/jpn_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td rowspan="2" align="left" class="bg_white lpad_10">02)<br>
                                458-4514</td>
                              <td height="217" align="center" class="bg_white">20:00</td>
                              <td class="bg_white lpad_5" align="left"><img src="<%=imageServer%>/jpn_img/start/date01.gif" width="234" height="219">                              </td>
                              <td rowspan="2" align="center" class="bg_white"><font color="#459E9D">40,000WON/人
(20,000WON別途)
                                </font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="201" class="bg_white">20:30</td>
                              <td class="bg_white lpad_5" align="left"><img src="<%=imageServer%>/jpn_img/start/date02.gif" width="234" height="219">                              </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="15" align="center" class="bg_white">2泊3日</td>
                              <td rowspan="4" align="center" class="bg_white b">ソウル
 </td>
                              <td rowspan="4" align="center" class="bg_white">毎日</td>
                              <td rowspan="2" align="center" class="bg_white"><p>DEHWA
観光
</p>
                                <p><a href="http://www.daehwatour.co.kr/" target="_blank"><img src="<%=imageServer%>/jpn_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td class="bg_white lpad_10" rowspan="2" align="left">02)<br>
                                733-0017</td>
                              <td height="26" align="center" class="bg_white">08:30</td>
                              <td class="bg_white lpad_5" align="left">ゲドン現代社屋スポーツセンター前

</td>
                              <td rowspan="4" align="center" class="bg_white"><font color="#459E9D">30,000WON/人</font></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gaedong.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:45</td>
                              <td class="bg_white lpad_5" align="left">光化門　西大門方向70m　国民銀行前</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white" rowspan="2"><p>DEHWA
観光
</p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/jpn_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td class="bg_white lpad_10" rowspan="2" align="left"><p>02)<br>
                                  458-4514</p>
                                02)458-4550</td>
                              <td height="26" class="bg_white">08:30</td>
                              <td class="bg_white lpad_5" align="left">狎鷗亭現代デパート駐車場</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_apgujung.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">09:00</td>
                              <td class="bg_white lpad_5" align="left">総合運動場６番出口GSコンビに前</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="4">大田 </td>
                              <td class="bg_white" rowspan="4">月、水
金
</td>
                              <td class="bg_white" rowspan="4">DONGSUN
観光

</td>
                              <td class="bg_white lpad_10" rowspan="4" align="left">1544-5980</td>
                              <td height="26" class="bg_white">06:30</td>
                              <td class="bg_white lpad_5" align="left">西大田駅タクシー乗り場前

</td>
                              <td class="bg_white" rowspan="4"><font color="#459E9D">50,000WON/
大人、大学生
40,000WON/
中・高等学生
30,000WON/
小学生



                                </font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:50</td>
                              <td class="bg_white lpad_5" align="left">大田駅東広場東側出口駐車場前

</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">07:30</td>
                              <td class="bg_white lpad_5" align="left">西清州トールゲート前

</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:00</td>
                              <td class="bg_white lpad_5" align="left">天安トールゲート出会いの場前

</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="4">&nbsp;</td>
                              <td class="bg_white" rowspan="4">水、金i</td>
                              <td class="bg_white" rowspan="4">ニュー
釜山観光ツアー
</td>
                              <td class="bg_white lpad_10" rowspan="4" align="left">051)<br>
                                851-0600</td>
                              <td height="26" class="bg_white">05:50</td>
                              <td class="bg_white lpad_5" align="left">西面ロータリーKT電話局隣、新韓銀行 
</td>
                              <td class="bg_white" rowspan="2"><font color="#459E9D">70,000WON/人 
</font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:10</td>
                              <td class="bg_white lpad_5" align="left">ドンレ地下鉄公営駐車場

</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">07:10</td>
                              <td class="bg_white lpad_5" align="left">慶州トールゲート出会いの場休憩所
</td>
                              <td class="bg_white" rowspan="2"><font color="#459E9D">60,000WON/人
</font></td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_goungjutol.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">08:10</td>
                              <td class="bg_white lpad_5" align="left">東デグトールゲート前
</td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_dongdaegu.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/jpn_img/start/btn_s_view.gif"></a> 
                                <!-- 보기 -->
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td class="bg_white b" rowspan="3">&nbsp;</td>
                              <td class="bg_white" rowspan="3">水、金</td>
                              <td class="bg_white" rowspan="3">SONGGUANG
観光バス
</td>
                              <td class="bg_white lpad_10" rowspan="3" align="left">062)<br>
                                383-1133</td>
                              <td height="26" class="bg_white">05:00</td>
                              <td class="bg_white lpad_5" align="left">グァンジュ尚武地区SONGGUANG旅行会社前
 
</td>
                              <td class="bg_white" rowspan="3"><font color="#459E9D">60,000WON/人</font></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:00</td>
                              <td class="bg_white lpad_5" align="left">井邑　井邑IC（湖南高速道路）
</td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white">06:50</td>
                              <td class="bg_white lpad_5" align="left">全州ワールドカップ競技場駐車場</td>
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
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0224.gif"><!-- 대중교통 이용고객  --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td>市外バス：東ソウルターミナル、上鳳ターミナルからガンソン（高城）及びデジン行き市外バスの利用後
ガンソン、デジンから市外バス１番または1-1番をご利用して、集結場 花津浦・牙山 (ファジンポアサン休憩所)へ移動

</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0225.gif"><!-- 고속버스 이용고객 --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td>ソウル江南高速バスターミナルで束草行き高速バスのご利用後、
統一展望台行市外バスでガンソン(高城)まで行き、またそこで市外バスで
集結場 花津浦・牙山 (ファジンポアサン休憩場）まで移動

</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onClick="fc_print();"><img src="<%=imageServer%>/jpn_img/start/btn_start_print.gif" class="btn"></a><!-- 인쇄하기 --></td>
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
        <%@ include file="/jpn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


<map name="Map">
  <area shape="rect" coords="67,210,170,226" href="http://www.dcffood.co.kr/07business_03.html" target="_blank" onFocus="this.blur()">
</map>
</body>
</html>
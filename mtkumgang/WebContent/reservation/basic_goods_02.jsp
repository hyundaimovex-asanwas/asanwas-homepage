<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<% 
  String McNum = "2";
  String sub = "2";
  String pageNum = "2";
  String subNum = "3";
%>
<%
    String dateview = ParamUtil.getReqParameter(request.getParameter("dateview"),"1");
%>
<html>
<head>
<title> 금강산관광  </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/maplink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
		    <%@ include file="../include/reservation/tour_reservation_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app22.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">기본상품</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">8시 출발 1박2일</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td colspan="2" height="22"></td></tr>
				<tr>
					<td colspan="2">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/apply/top_txt_app22.gif" style="margin-top:12px;"></td>
							<td align="right"><img src="<%=imageServer%>/tour_img/apply/img_top_app03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="8"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="41" valign="top"><img src="<%=imageServer%>/tour_img/apply/sstit_app222.gif"></td></tr>
						<tr>
							<td valign="top" height="308"><img src="<%=imageServer%>/tour_img/apply/img_basic02.jpg" width="269" height="308"></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr><td height="41" colspan="4" valign="top" align="right"></td></tr>
						<tr><td class="line_dg" colspan="4" height="2"></td></tr>
						<tr>
							<td height="29" colspan="3" width="97"><img src="<%=imageServer%>/tour_img/apply/txt_order01.gif"><!-- 출발일 --></td>
							<td width="293">매일</td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order02.gif"><!-- 여행기간 --></td>
							<td><strong>1박 2일</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order06.gif"><!-- 출발시간 --></td>
							<td><strong>08:00 (남측출입사무소 기준)</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="172" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- 상품소개 --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							<td>며칠동안 휴가내기는 힘들고, 주머니 사정도 여의치 않은데, 그렇다고 금강산의 절경을 놓치기는 아깝고...<br>금강산 1박 2일(8시출발)상품은 여러분의 고민을 속 시원하게 날려 줄 것입니다.<br><br>북녘 땅에 발을 디딤과 동시에 금강산을 오르고 교예공연을 볼까 온천을 할까 고민도 해보고 금강산의 야경을 감상하며 숨가쁘게 달려온 하루를 마친 다음날에는<br>만물상과 삼일포/해금강 사이에서 고민하게 되지요.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- 가격 --></td>
							<td><span class="txt_orange b">200,000원 ~ 350,000원</span>&nbsp;&nbsp;※중석식은 별도 매식</td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="20"></td></tr>
						<tr><td colspan="4" align="right"><a href="http://www.mtkumgang.com/reservation/price/price_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_detailprice.gif" class="btn"></a></td></tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="14"></td></tr>
				<tr>
					<td colspan="2">
						<!-- / 일정보기 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_app0302.gif" name="01"></td></tr>
						<tr>
							<td><%if(dateview.equals("1")){%><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/tour_img/apply/tab_date01.gif" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/tour_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/tour_img/apply/tab_date02.gif" ></a><%}%><img src="<%=imageServer%>/tour_img/apply/tab_date00.gif" width="526" height="28"></td>
						</tr>
						<tr><td height="20"></td></tr>
						<tr>
							<td>
								<!-- / 표1 -->
<div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white" height="26">시간</td>
									<td width="50%" class="bg_white">세부일정</td>
									<td width="30%" class="bg_white">비고</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">06:00</td>
									<td class="bg_white lpad_20">집결지(화진포 아산 휴게소) 도착</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">07:00</td>
									<td class="bg_white lpad_20">발권 및 집결지 출발</td>
									<td class="bg_white lpad_20">관광증 수령</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">07:20</td>
									<td class="bg_white lpad_20">남측 출입사무소 도착/수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">08:15</td>
									<td class="bg_white lpad_20">북측 출입사무소 도착/수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">09:40</td>
									<td class="bg_white lpad_20">구룡연 코스관광 및 중식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:30</td>
									<td class="bg_white lpad_20">중식 및 쇼핑</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">13:30</td>
									<td class="bg_white lpad_20">삼일포 코스(유료) 또는 온천</td>
									<td class="bg_white lpad_20">선택</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:30</td>
									<td class="bg_white lpad_20">교예공연 관람</td>
									<td class="bg_white lpad_20">선택</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">18:00</td>
									<td class="bg_white lpad_20">석식 및 자유시간</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- 표1 / -->


								<!-- / 표2 -->
<div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">시간</td>
									<td width="50%" class="bg_white lpad_20">세부일정</td>
									<td width="30%" class="bg_white lpad_20">비고</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">07:00</td>
									<td class="bg_white lpad_20">조식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">08:20</td>
									<td class="bg_white lpad_20">만물상 또는 삼일포/해금강 코스 관광</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:30</td>
									<td class="bg_white lpad_20">중식 및 자유시간(온천/쇼핑)</td>
									<td class="bg_white lpad_20">선택</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">15:55</td>
									<td class="bg_white lpad_20">온정각 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:10</td>
									<td class="bg_white lpad_20">북측 출입사무소 도착 및 수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">17:10</td>
									<td class="bg_white lpad_20">남측 출입사무소 도착 및 수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- 표2 / -->

							</td>
						</tr>
						<tr><td height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">
							<table cellpadding="0" cellspacing="0">
								 <tr>
                      <td width="483" height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">※ 
                        상기 일정은 현지 사정에 의하여 변경될 수 있습니다.</td>
                      <td width="207" height="35" align="right" valign="bottom" class="txt_orange2 fs11 lpad_10"><a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print03.jsp','','scrollbars=yes,width=702,height=600')"><img src="<%=imageServer%>/tour_img/btn/btn_plan_viw.gif" width="80" height="27" border="0"></a></td>
                    </tr>
							</table>
						</td></tr>
						</table>
						<!-- 일정보기 / -->
					</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/img_tip_order.gif"></td></tr>
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


</body>
</html>
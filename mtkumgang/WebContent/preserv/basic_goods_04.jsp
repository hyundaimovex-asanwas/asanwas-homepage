<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%
  String McNum = "2";
  String sub = "2"; 
  String pageNum = "2";
  String subNum = "5";
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
<script type="text/JavaScript">
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app24.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">기본상품</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">당일</span></td>
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
							<td><img src="<%=imageServer%>/tour_img/apply/top_txt_app24.gif" style="margin-top:12px;"></td>
							<td align="right"><img src="<%=imageServer%>/tour_img/apply/img_top_app03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="8"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="41" valign="top"><img src="<%=imageServer%>/tour_img/apply/sstit_app224.gif"></td></tr>
						<tr>
							<td valign="top" height="308"><img src="<%=imageServer%>/tour_img/apply/img_basic04.jpg" width="269" height="308"></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td height="41" colspan="4" valign="top" align="right"></td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="2"></td></tr>
						<tr>
							<td height="29" colspan="3" width="97"><img src="<%=imageServer%>/tour_img/apply/txt_order01.gif"><!-- 출발일 --></td>
							<td width="293">매일</td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order02.gif"><!-- 여행기간 --></td>
							<td><strong>당일</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="202" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- 상품소개 --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							<td>한걸음에 달려가는 금강산. 상상이나 해보셨나요? 금강산을 느끼기에는 하루라도 가능합니다.<br><br>아침에 구룡연을 오르며 금강산의 기운이 몸에 깃들고, 북녘의 흙과 물이 기른 먹거리로 배를 채우며, 삼일포의 운치를 눈에 담고서 돌아오노라면 애틋한 아쉬움이 남는 추억거리가 또하나 늘어났음을 절감하게 됩니다.<br>금강산의 추억을 담은 북측 토산품을 품에 간직하고 남측으로 돌아가신다면 누구에게나 자신있게 금강산유람을 자랑하실 수 있을 것입니다.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- 가격 --></td>
							<td><span class="txt_orange b">120,000원 ~ 170,000원</span>&nbsp;&nbsp;※중석식은 별도 매식</td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="20"></td></tr>
						<tr><td colspan="4" align="right"><a href="http://www.mtkumgang.com/reservation/price/price_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_detailprice.gif" border="0" class="btn"></a></td></tr>
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
							<td><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif"><img src="<%=imageServer%>/tour_img/apply/tab_date003.gif"></td>
						</tr>
						<tr><td height="20"></td></tr>
						<tr>
							<td>
								<!-- / 표1 -->
								<div id="dateview1" style="display:show;">	
								
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
                              <td class="bg_white" align="center" height="37">09:00 
                                ~ 13:30</td>
                              <td class="bg_white lpad_20">구룡연 또는 만물상 코스 관광<br>
                                중식 및 자유 시간</td>
                              <td class="bg_white lpad_20">선택</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">14:00 
                                ~ 16:00</td>
                              <td class="bg_white lpad_20">온천 또는 유료 삼일포(가능시)</td>
                              <td class="bg_white lpad_20">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:00</td>
                              <td class="bg_white lpad_20">온정각 출발</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:25</td>
                              <td class="bg_white lpad_20">북측 출입사무소 도착/수속</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:55</td>
                              <td class="bg_white lpad_20">북측 출입사무소 출발</td>
                              <td class="bg_white lpad_20">군사분계선 통과</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">17:10</td>
                              <td class="bg_white lpad_20">남측 출입사무소 도착/수속</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                          </table>
								</div>
								<!-- 표1 / -->

							</td>
						</tr>
						<tr><td height="31" valign="bottom" class="txt_orange2 fs11 lpad_10"><table cellpadding="0" cellspacing="0">
             <tr>
              <td width="483" height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">※ 
               상기 일정은 현지 사정에 의하여 변경될 수 있습니다.</td>
              <td width="207" height="35" align="right" valign="bottom" class="txt_orange2 fs11 lpad_10"><a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print05.jsp','','scrollbars=yes,width=702,height=600')"><img src="<%=imageServer%>/tour_img/btn/btn_plan_viw.gif" width="80" height="27" border="0"></a></td>
             </tr>
            </table></td>
						</tr>
						</table>
						<!-- 일정보기 / -->
					</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/img_tip_order2.gif"></td></tr>
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
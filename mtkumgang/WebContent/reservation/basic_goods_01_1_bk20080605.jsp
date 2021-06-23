<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<% 
  String McNum = "2";
  String sub = "2";
  String pageNum = "2";
  String subNum = "2";
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app211.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app02.gif" hspace="9"></td>
						
                      <td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">기본상품</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">2박3일(내금강)</span></td>
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
							<td><img src="<%=imageServer%>/tour_img/apply/top_txt_app211.gif" style="margin-top:12px;"></td>
							<td align="right"><img src="<%=imageServer%>/tour_img/apply/img_top_app03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="8"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="41" valign="top"><img src="<%=imageServer%>/tour_img/apply/sstit_app2211.gif"></td></tr>
						<tr>
							<td valign="top" height="308"><img src="<%=imageServer%>/tour_img/apply/img_basic01_1.jpg" width="269" height="308"></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr><td height="41" colspan="4" valign="top" align="right"></td></tr>
						<tr><td class="line_dg" colspan="4" height="2"></td></tr>
						<tr>
							<td height="29" colspan="3" width="97"><img src="<%=imageServer%>/tour_img/apply/txt_order01.gif"><!-- 출발일 --></td>
							<td width="293"><strong>매일</strong>
							<br>(인원 제한이 있으므로 금강산관광 대리점을 통해 예약, 온라인예약 불가) </td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order02.gif"><!-- 여행기간 --></td>
							<td><strong>2박 3일</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="202" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- 상품소개 --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							
                      <td>금강산은 흔히 내금강과 외금강으로 나누는데 내륙을 향한 서쪽을 내금강, 바다를 향한 동쪽을 외금강이라고 
                        부르고 있습니다. <br>
                        <br>
                        외금강의 대표코스인 구룡연, 만물상, 삼일포/해금강을 둘러봄으로써 남성적인 웅장한 자연미를 느낄 
                        수 있으며, 내금강은 여러 갈래 계곡의 물줄기가 빚어놓은 수많은 폭포와 못을 통해 온화한 여성미를 
                        경험할 수 있습니다. <br>
                        <br>
                        또한 내금강의 표훈사, 삼불암, 묘길상 등 많은 문화유적들이 여러분을 역사 속으로 빠져들게 할 것입니다.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- 가격 --></td>
							<td><span class="txt_orange b">280,000 ~ 520,000원 </span>&nbsp;&nbsp;※중석식은 별도 매식</td>
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
                    <tr> 
                      <td height="25" colspan="2" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_app0302.gif" name="01"></td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <%if(dateview.equals("1")){%><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/tour_img/apply/tab_date01.gif" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/tour_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/tour_img/apply/tab_date02.gif" ></a><%}%><%if(dateview.equals("3")){%><img src="<%=imageServer%>/tour_img/apply/tab_date03_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/tour_img/apply/tab_date03.gif" ></a><%}%><img src="<%=imageServer%>/tour_img/apply/tab_date00.gif"></td></tr>
                    <tr> 
                      <td height="20" colspan="2"></td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <!-- / 표1 -->
                        <div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>> 
                          <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                            <tr align="center"> 
                              <td width="20%" class="bg_white" height="26">시간</td>
                              <td width="55%" class="bg_white">세부일정</td>
                              <td width="25%" class="bg_white">비고</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">13:00</td>
                              <td class="bg_white lpad_20">집결지(화진포 아산 휴게소) 도착</td>
                              <td class="bg_white lpad_20">관광증 수령</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">13:30</td>
                              <td class="bg_white lpad_20">집별지 출발 </td>
                              <td class="bg_white lpad_20">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">14:10</td>
                              <td class="bg_white lpad_20">남측 출입사무소 도착/수속</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">15:20</td>
                              <td class="bg_white lpad_20">남측 출입사무소 출발 </td>
                              <td class="bg_white lpad_20"> 군사분계선 통과 </td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">15:35</td>
                              <td class="bg_white lpad_20">북측 출입사무소 도착/수속 </td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:00</td>
                              <td class="bg_white lpad_20">북측 출입사무소 출발 </td>
                              <td class="bg_white lpad_20">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:30</td>
                              <td class="bg_white lpad_20">교예공연 관람</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">18:00 
                              </td>
                              <td class="bg_white lpad_20"> 숙소 도착/ 체크인 </td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">18:20</td>
                              <td class="bg_white lpad_20">석식 및 자유시간(온천/금강산관광특구 
                                투어)</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <!-- 일정보기1 / -->
                            <table cellspacing="1" cellpadding="3" border="0" width="690">
                              <tr>
                      <td width="483" height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">※ 
                        상기 일정은 현지 사정에 의하여 변경될 수 있습니다.</td>
                      <td width="207" height="35" align="right" valign="bottom" class="txt_orange2 fs11 lpad_10">
					  <a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print02.jsp','','scrollbars=yes,width=702,height=600')">
					  <img src="<%=imageServer%>/tour_img/btn/btn_plan_viw.gif" width="80" height="27" border="0"></a></td>
                    </tr>
                              <tr> 
                                <td colspan="3" height="12"></td>
                              </tr>
                              <tr> 
                                <td colspan="3"><img src="<%=imageServer%>/tour_img/apply/img_tip_order.gif"></td>
                              </tr>
                            </table>
                          </table>
                        </div>
                        <!-- 표1 / -->
                        <!-- / 표2 -->
                        <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>> 
                          <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                            <tr align="center"> 
                              <td width="20%" class="bg_white lpad_20" height="26">시간</td>
                              <td width="55%" class="bg_white lpad_20">세부일정</td>
                              <td width="25%" class="bg_white lpad_20">비고</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">06:30</td>
                              <td class="bg_white lpad_20">조식</td>
                              <td class="bg_white lpad_20">각 숙소 </td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">08:00~13:30</td>
                              <td class="bg_white lpad_20">내금강 관광 - 표훈사, 만폭동, 
                                묘길상, 보덕암</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">13:30~14:30</td>
                              <td class="bg_white lpad_20">중식 (표훈사 인근)</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">14:30~16:00</td>
                              <td class="bg_white lpad_20">내금강 관광 - 백화암부도, 삼불암, 
                                울소, 장안사터 - 도보관광</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:00~18:00</td>
                              <td class="bg_white lpad_20">온정각 으로 이동</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">18:00~</td>
                              <td class="bg_white lpad_20">석식 및 자유시간 (온천 및 쇼핑)</td>
                              <td class="bg_white lpad_20">매식</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">(21:00~22:00)</td>
                              <td class="bg_white lpad_20">가무극 관람 (금강산호텔)</td>
                              <td class="bg_white lpad_20">선택관광 (정원 130명) </td>
                            </tr>
                            <!-- 일정보기2 / -->
                            <table cellspacing="1" cellpadding="3" border="0" width="690">
                              <tr>
                      <td width="483" height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">※ 
                        상기 일정은 현지 사정에 의하여 변경될 수 있습니다.</td>
                      <td width="207" height="35" align="right" valign="bottom" class="txt_orange2 fs11 lpad_10">
					  <a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print02.jsp','','scrollbars=yes,width=702,height=600')">
					  <img src="<%=imageServer%>/tour_img/btn/btn_plan_viw.gif" width="80" height="27" border="0"></a></td>
                    </tr>
                              <tr> 
                                <td colspan="3" height="12"></td>
                              </tr>
                              <tr> 
                                <td colspan="3"><img src="<%=imageServer%>/tour_img/apply/img_tip_order02.gif"></td>
                              </tr>
                            </table>
                          </table>
                        </div>
                        <!-- 표2 / -->
                        <!-- / 표3 -->
                        <div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>> 
                          <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                            <tr align="center"> 
                              <td width="20%" class="bg_white lpad_20" height="26">시간</td>
                              <td width="55%" class="bg_white lpad_20">세부일정</td>
                              <td width="25%" class="bg_white lpad_20">비고</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">06:30</td>
                              <td class="bg_white lpad_20">조식</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">08:00</td>
                              <td class="bg_white lpad_20">구룡연, 만물상 또는 삼일포/해금강 
                                코스 관광</td>
                              <td class="bg_white lpad_20">선택관광</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">11:30</td>
                              <td class="bg_white lpad_20">중식 및 쇼핑</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">13:00</td>
                              <td class="bg_white lpad_20">온정각 출발</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">13:15</td>
                              <td class="bg_white lpad_20">북측 출입사무소 도착 / 수속</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">13:45</td>
                              <td class="bg_white lpad_20">북측 출입사무소 출발 </td>
                              <td class="bg_white lpad_20">군사분계선 통과</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">14:00</td>
                              <td class="bg_white lpad_20">남측 출입사무소 도착 및 수속</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <!-- 일정보기3 / -->
                            <table cellspacing="1" cellpadding="3" border="0" width="690">
                               <tr>
                      <td width="483" height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">※ 
                        상기 일정은 현지 사정에 의하여 변경될 수 있습니다.</td>
                      <td width="207" height="35" align="right" valign="bottom" class="txt_orange2 fs11 lpad_10">
					  <a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print02.jsp','','scrollbars=yes,width=702,height=600')">
					  <img src="<%=imageServer%>/tour_img/btn/btn_plan_viw.gif" width="80" height="27" border="0"></a></td>
                    </tr>
                              <tr> 
                                <td colspan="3" height="12"></td>
                              </tr>
                              <tr> 
                                <td colspan="3"><img src="<%=imageServer%>/tour_img/apply/img_tip_order.gif"></td>
                              </tr>
                            </table>
                          </table>
                        </div>
                        <!-- 표3 / -->
                      </td>
                    </tr>
                  </table>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
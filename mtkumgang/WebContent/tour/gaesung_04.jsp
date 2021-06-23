<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
String McNum = "0";
String sub = "0";
String pageNum = "2";
String subNum = "4";
%>
<%
    String dateview = ParamUtil.getReqParameter(request.getParameter("dateview"),"1");
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/tour/tour_tour_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../include/tour/tour_tour_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/tour/tit_tour24.gif"><img src="<%=imageServer%>/tour_img/tour/tit_tour02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">북측관광</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">개성관광</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" lass="linemap_margin2"><span class="linemap_now">관광일정</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour21.gif"></td></tr>
				<tr><td height="63"></td></tr>
				<tr>
					<td>
						<!-- / 탭메뉴 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
					                     <td width="92" height="28"><%if(dateview.equals("1")){%><img src="<%=imageServer%>/tour_img/tour/tab_part01_on.gif"><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/tour_img/tour/tab_part01.gif"></a><%}%></td>
							<td width="92"><%if(dateview.equals("2")){%><img src="<%=imageServer%>/tour_img/tour/tab_part02_on.gif"><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/tour_img/tour/tab_part02.gif"></a><%}%></td>
							<td width="92"><%if(dateview.equals("3")){%><img src="<%=imageServer%>/tour_img/tour/tab_part03_on.gif"><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/tour_img/tour/tab_part03.gif"></a><%}%></td>
							<td width="1"><img src="<%=imageServer%>/tour_img/tour/tab_part_l.gif"></td>
							<td width="411" background="<%=imageServer%>/tour_img/tour/tab_part00.gif"></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/tour/tab_part_r.gif"></td>
						</tr>
						</table>
						<!-- 탭메뉴 / -->
					</td>
				</tr>
				<tr>
					<td valign="top">

						<!-- / 표1 -->
<div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="51" class="txt_dblue lpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" style="margin:0 5 2 0px;"><strong>개성/박연코스 (오전 개성시내/ 오후 왕건왕릉,공민왕릉) </strong></td>
						</tr>
						</table>
						<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
						<tr align="center">
							<td width="75" class="bg_white" height="26">구분</td>
							<td width="105" class="bg_white" height="26">시간</td>
							<td width="135" class="bg_white">장소 및 교통</td>
							<td width="375" class="bg_white">일정</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">남측</td>
							<td class="bg_white" align="center">05:30</td>
							<td class="bg_white lpad_20">경복궁 주차장</td>
							<td class="bg_white lpad_20">집결 후 출발준비</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">06:00</td>
							<td class="bg_white lpad_20">서울~남측 CIQ</td>
							<td class="bg_white lpad_20">남측 CIQ로 이동</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:10~07:50</td>
							<td class="bg_white lpad_20">남측 CIQ</td>
							<td class="bg_white lpad_20">남측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:50~08:10</td>
							<td class="bg_white lpad_20">비무장지대</td>
							<td class="bg_white lpad_20">휴전선 통과(08:00)</td>
						</tr>
						<tr>
							<td class="bg_lgray" height="26" align="center" rowspan="3">북측</td>
							<td class="bg_lgray" align="center">08:10~08:50</td>
							<td class="bg_lgray lpad_20">북측 CIQ</td>
							<td class="bg_lgray lpad_20">북측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">08:50~16:40</td>
							<td class="bg_lgray lpad_20">개성지역</td>
							<td class="bg_lgray lpad_20">북측 관광 및 중식<br>* 고려박물관-선죽교-중식-박연폭포</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">16:40~17:20</td>
							<td class="bg_lgray lpad_20">북측 CIQ</td>
							<td class="bg_lgray lpad_20">북측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">남측</td>
							<td class="bg_white" align="center">17:20~17:40</td>
							<td class="bg_white lpad_20">비무장지대</td>
							<td class="bg_white lpad_20">휴전선 통과 (17:30)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">17:40~18:20</td>
							<td class="bg_white lpad_20">남측 CIQ</td>
							<td class="bg_white lpad_20">남측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">18:20~</td>
							<td class="bg_white lpad_20"></td>
							<td class="bg_white lpad_20">서울 이동 및 해산</td>
						</tr>
						</table>
						<table cellpadding="0" cellspacing="0" border="0" class="tpad_20 lpad_15">
						<tr>
							<td>- 일정 및 시간은 현지 사정에 따라 조정 될 수 있습니다.<br><span class="txt_dblue b">- 상기 관광코스는 2005년 8월에 실시한 시범관광을 기준으로 구성한 것입니다.</span></td>
						</tr>
						</table>
</div>
						<!-- 표1 / -->

						<!-- / 표2 -->
<div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="51" class="txt_dblue lpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" style="margin:0 5 2 0px;"><strong>개성/왕릉코스 (오전 개성시내/ 오후 왕건왕릉,공민왕릉) </strong></td>
						</tr>
						</table>
						<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
						<tr align="center">
							<td width="75" class="bg_white" height="26">구분</td>
							<td width="105" class="bg_white" height="26">시간</td>
							<td width="135" class="bg_white">장소 및 교통</td>
							<td width="375" class="bg_white">일정</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">남측</td>
							<td class="bg_white" align="center">05:30</td>
							<td class="bg_white lpad_20">경복궁 주차장</td>
							<td class="bg_white lpad_20">집결 후 출발준비</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">06:00</td>
							<td class="bg_white lpad_20">서울~남측 CIQ</td>
							<td class="bg_white lpad_20">남측 CIQ로 이동</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:10~07:50</td>
							<td class="bg_white lpad_20">남측 CIQ</td>
							<td class="bg_white lpad_20">남측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:50~08:10</td>
							<td class="bg_white lpad_20">비무장지대</td>
							<td class="bg_white lpad_20">휴전선 통과(08:00)</td>
						</tr>
						<tr>
							<td class="bg_lgray" height="26" align="center" rowspan="3">북측</td>
							<td class="bg_lgray" align="center">08:10~08:50</td>
							<td class="bg_lgray lpad_20">북측 CIQ</td>
							<td class="bg_lgray lpad_20">북측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">08:50~16:40</td>
							<td class="bg_lgray lpad_20">개성지역</td>
							<td class="bg_lgray lpad_20">북측 관광 및 중식<br>* 고려박물관-선죽교-숭양서원-중식-박연폭포-개성공업지구</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">16:40~17:20</td>
							<td class="bg_lgray lpad_20">북측 CIQ</td>
							<td class="bg_lgray lpad_20">북측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">남측</td>
							<td class="bg_white" align="center">17:20~17:40</td>
							<td class="bg_white lpad_20">비무장지대</td>
							<td class="bg_white lpad_20">휴전선 통과 (17:30)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">17:40~18:20</td>
							<td class="bg_white lpad_20">남측 CIQ</td>
							<td class="bg_white lpad_20">남측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">18:20~</td>
							<td class="bg_white lpad_20"></td>
							<td class="bg_white lpad_20">서울 이동 및 해산</td>
						</tr>
						</table>
						<table cellpadding="0" cellspacing="0" border="0" class="tpad_20 lpad_15">
						<tr>
							<td>- 일정 및 시간은 현지 사정에 따라 조정 될 수 있습니다.<br><span class="txt_dblue b">- 상기 관광코스는 2005년 8월에 실시한 시범관광을 기준으로 구성한 것입니다.</span></td>
						</tr>
						</table>
</div>
						<!-- 표2 / -->

						<!-- / 표3 -->
<div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="51" class="txt_dblue lpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" style="margin:0 5 2 0px;"><strong>개성/영통코스 (오전 영통사 / 오후 개성시내) </strong></td>
						</tr>
						</table>
						<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
						<tr align="center">
							<td width="75" class="bg_white" height="26">구분</td>
							<td width="105" class="bg_white" height="26">시간</td>
							<td width="135" class="bg_white">장소 및 교통</td>
							<td width="375" class="bg_white">일정</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">남측</td>
							<td class="bg_white" align="center">05:30</td>
							<td class="bg_white lpad_20">경복궁 주차장</td>
							<td class="bg_white lpad_20">집결 후 출발준비</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">06:00</td>
							<td class="bg_white lpad_20">서울~남측 CIQ</td>
							<td class="bg_white lpad_20">남측 CIQ로 이동(임진각 휴게소 경유)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:10~07:50</td>
							<td class="bg_white lpad_20">남측 CIQ</td>
							<td class="bg_white lpad_20">남측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:50~08:10</td>
							<td class="bg_white lpad_20">비무장지대</td>
							<td class="bg_white lpad_20">휴전선 통과(08:00)</td>
						</tr>
						<tr>
							<td class="bg_lgray" height="26" align="center" rowspan="3">북측</td>
							<td class="bg_lgray" align="center">08:10~08:50</td>
							<td class="bg_lgray lpad_20">북측 CIQ</td>
							<td class="bg_lgray lpad_20">북측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">08:50~16:40</td>
							<td class="bg_lgray lpad_20">개성지역</td>
							<td class="bg_lgray lpad_20">북측 관광 및 중식<br>* 영통사-중식-숭양서원-선죽교-고려박물관-개성공업지구</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">16:40~17:20</td>
							<td class="bg_lgray lpad_20">북측 CIQ</td>
							<td class="bg_lgray lpad_20">북측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">남측</td>
							<td class="bg_white" align="center">17:20~17:40</td>
							<td class="bg_white lpad_20">비무장지대</td>
							<td class="bg_white lpad_20">휴전선 통과 (17:30)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">17:40~18:20</td>
							<td class="bg_white lpad_20">남측 CIQ</td>
							<td class="bg_white lpad_20">남측 출입 수속</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">18:20~</td>
							<td class="bg_white lpad_20"></td>
							<td class="bg_white lpad_20">서울 이동 및 해산</td>
						</tr>
						</table>
						<table cellpadding="0" cellspacing="0" border="0" class="tpad_20 lpad_15">
						<tr>
							<td>- 일정 및 시간은 현지 사정에 따라 조정 될 수 있습니다.<br><span class="txt_dblue b">- 상기 관광코스는 2005년 8월에 실시한 시범관광을 기준으로 구성한 것입니다.</span></td>
						</tr>
						</table>
</div>
						<!-- 표3 / -->

						
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
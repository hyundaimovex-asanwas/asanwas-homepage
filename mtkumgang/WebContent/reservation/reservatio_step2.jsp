<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.reservation.dao.ScheduleInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Schedule_bean"%>
<%@ page import="kr.co.imjk.util.DateUtils"%>
<%@ page import="java.util.Calendar"%>

<%
	String goods_sid = request.getParameter("goods_sid");					//관광상품 코드
	String saup_sid = request.getParameter("saup_sid");					//관광지 코드
	String today_ymd = request.getParameter("today_ymd");				//오늘일자

	//일자조회를 위한 param bean 생성
	Schedule_bean param = new Schedule_bean();
	Schedule_bean[] result = null;

	//일자조회를 위한 함수생성
	ScheduleInfo info = new ScheduleInfo();

	//날짜계산을 위한 함수생성
	DateUtils date = new DateUtils();

	//파라메터 세팅
	param.setFlag_ymd(today_ymd);		//선택된일자
	param.setSaup_sid(saup_sid);				//관광지
	param.setGoods_sid(goods_sid);			//관광품목

	try {
		//프로시져 호출
//		result = info.getMonthResv(param);
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>금강산 예약</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
-->
</style>
<script language="javascript">

	//다음 단계로 진행
	function nextStep() {

		document.resv.start_ymd.value = "20080724";
		document.resv.weekend_yn.value = "Y";
		document.resv.action = "reservatio_step3.jsp";
		document.resv.submit();
	}

    function addDay(yyyy, mm, dd, pDay) // 년, 월, 일, 계산할 일자 (년도는 반드시 4자리로 입력)
    {
        var oDate; // 리턴할 날짜 객체 선언       
        mm = mm*1 + pDay*1; // 날짜 계산        
        mm--; // 월은 0~11 이므로 하나 빼준다        
        oDate = new Date(yyyy, mm, dd) // 계산된 날짜 객체 생성 (객체에서 자동 계산)
       
        return oDate;
	}
	
	//월 이동하기
	function moveMonth(str) {
		
		var date = addDay(<%=today_ymd.substring(0,4)%>,<%=today_ymd.substring(4,6)%>,<%=today_ymd.substring(6,8)%>,str);

		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		alert(year);
		alert(month);
		alert(day);

		if((month+"").length == 1) {
			month = "0"+month;
		}
		if((day+"").length == 1) {
			day = "0"+day;
		}

		document.resv.today_ymd.value = year+month+day;
		document.resv.action = "reservatio_step2.jsp";
		document.resv.submit();
		
	}

	//날자를 선택했을때 Msg 보여주기
	function sel_day(day, weekend_yn) {
		var dv = document.getElementsById("selMsg");			//Msg DIV객체
		var goods_sid = document.resv.goods_sid.value;			//상품코드
		
		var date = new Date(day.substring(0,4), day.substring(4,6), day.substring(6,8));

		if(goods_sid == "28") {
			
		} else if(goods_sid == "27") {

		} else if(goods_sid == "30") {

		}
		dv.innerHTML = "<span class=pagingon>2008년 4월 23일(수)부터 2008년 4월 25일(금)까지</span>";
	}
</script>
</head>
<body>
<form name="resv" method="post">
	<input type="hidden" name="goods_sid" value="<%=goods_sid%>">
	<input type="hidden" name="saup_sid" value="<%=saup_sid%>">
	<input type="hidden" name="start_ymd">
	<input type="hidden" name="today_ymd">
	<input type="hidden" name="weekend_yn">

<table cellpadding="0" cellspacing="0" width="" height="470">
	<tr>
		<td width="770" height="65" bgcolor="3F667D">
			<table cellpadding="0" cellspacing="0" height="47" width="100%">
				<tr>
					<td style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_toptitle1.gif"></td>
					<td align="right" valign="bottom" style="padding-right:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_toptitle2.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--컨텐츠 시작-->
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_01.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_02.gif"></td>
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
										<tr>
											<td class="fs14" style="padding:10 0 0 10"><a href="javascript:moveMonth(-1)"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_prev.gif" border="0"></a> <b><%=today_ymd.substring(0,4)%>년 <%=today_ymd.substring(4,6)%>월</b> <a href="javascript:moveMonth(1)"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_next.gif" border="0"></a></td>
										</tr>
										<tr>
											<td style="padding:5 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td width="386" height="210" align="center" valign="bottom" bgcolor="B8C7D0">
															<table cellpadding="0" cellspacing="1" width="100%">
																<tr>
																	<td height="30"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_sun.gif"></td>
																	<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_mon.gif"></td>
																	<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_tue.gif"></td>
																	<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_wed.gif"></td>
																	<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_thu.gif"></td>
																	<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_fri.gif"></td>
																	<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step2_sat.gif"></td>
																</tr>
<%
													String caln_date = "";										//달력일
													String rsv_yn = "";											//예약가능여부
													String weekend_yn = "";									//주말여부
													int yoil = 0;													//요일표시 (숫자로)
														
													//일자계산을 위한 Calendar객체
													Calendar cal = null;

													try {
														//결과값이 있으면
														if(result != null) {
															for(int i=0 ; i<result.length ; i++) {
																caln_date = result[i].getCaln_date();
																rsv_yn = result[i].getRsv_yn();
																weekend_yn = result[i].getWeekend_yn();
																
																//요일구하기
																cal = date.getCalenderYYYYMMDD(caln_date);
																yoil = cal.get(Calendar.DAY_OF_WEEK);
																
																//월 첫째날일 경우
																if(i == 0) {
																	for(int j=1 ; j<yoil ; j++) {
%>
																	<td align="center" bgcolor="#FFFFFF">&nbsp;</td>
<%
																	}

																	//일요일이면
																	if(yoil == 1) {
%>
																<tr>
																	<td height="33" align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금" <%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
<%																//토요일이면
																	} else if(yoil == 7) {
%>
																	<td align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=testdgreen"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금" <%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
																</tr>
<%																//그외요일이면
																	} else {
%>
																	<td align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금" <%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
<%
																	}
																//마지막날일경우
																} else if(i == (result.length)-1) {
																	//일요일의 경우
																	if(yoil == 1) {
%>
																<tr>
																	<td height="33" align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금" <%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>	
<%
																	//토요일의 경우
																	} else if(yoil == 7) {
%>
																	<td align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금"  <%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
																</tr>
<%																//그외의 요일일경우
																	} else {
%>
																	<td align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금" <%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
<%
																	}
														
																	for(int j=yoil+1 ; j<8 ; j++) {
%>
																	<td align="center" bgcolor="#FFFFFF">&nbsp;</td>

<%
																	} 
																//그외날일경우
																} else {
																	//일요일일 경우
																	if(yoil == 1) {
%>
																<tr>
																	<td height="33" align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금"<%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
<%																//토요일일 경우
																	} else if(yoil == 7) {
%>
																	<td align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금"<%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
																</tr>
<%																//그외의 요일일경우
																	} else {
%>
																	<td align="center" bgcolor="#FFFFFF" <%if(rsv_yn.equals("Y")) {%> class="class=pagingon"  <%} else {%> class="txt_orange"<%}%> <%if(weekend_yn.equals("Y")) {%> alt="주말요금"<%}%>><a href="javascript:sel_day(<%=caln_date%>, '<%=weekend_yn%>')"><%=caln_date.substring(6,8)%></a></td>
<%
																	}
																}
															}
														}
													} catch(Exception e) {
														e.printStackTrace();
													}
%>
															</table>
													  </td>
														<td width="15"></td>
														<td valign="top"> 
															<table cellpadding="0" cellspacing="0">
																<tr>
																	<td height="90" bgcolor="F2F2F2" style="padding:10px;"><span class="fs14">고객님의 <b>여행기간(온라인 예약일)</b>은 </span><br>
																       <div id="selMsg"></div><br>입니다.</td>
																</tr>
																<tr>
																	<td height="90"></td>
																</tr>
																<tr>
																	<td align="right"><a href="reservatio_step1.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_prev.gif" border="0"></a> <a href="javascript:nextStep()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_next.gif" border="0"></a></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<!--컨텐츠 끝-->
		</td>
	</tr>
	<tr>
		<td height="8" bgcolor="3F667D"></td>
	</tr>
</table>
</body>
</html> 
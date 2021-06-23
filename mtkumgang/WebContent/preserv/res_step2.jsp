<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.DateUtils"%>

<%
//사전예약용 수정~:)
	//예약자정보---------------------------------------------
	String rname = request.getParameter("rname");	//예약자명
	String rtel  = request.getParameter("rtel");	//이메일
	String rmob  = request.getParameter("rmob");	//핸드폰
	String rmail = request.getParameter("rmail");	//전화번호
	String rpass = request.getParameter("rpass");	//비밀번호
	//예약자정보---------------------------------------------

	//현재날짜 가져오기
	DateUtils date = new DateUtils();
	String today_ymd = date.getSysDate(1);

	//관광지역 선택 - 금강산일 경우에만 해당 페이지로 들어오기 때문에 거의 보통은 1로 셋팅되어 있다.
	String saup_sid = request.getParameter("saup_sid")==null?"1":request.getParameter("saup_sid");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>금강산|개성 예약판매　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
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
	//예약 일정을 선택하기 위한 화면으로 링크한다.
	function reservation(str) {
		/*
			str : 예약일정을 구분해주는 변수
			value case 
				28: 2박 3일
				27: 1박 2일
				30: 당일

				57	1111900	예약개성	
				58	1111901	예약1박	
				59	1111902	예약2박	
		*/
		document.resv.goods_sid.value = str;
		document.resv.action = "res_step3.jsp";
		document.resv.submit();
	}
</script>
</head>
<body>
<form name="resv" method="post">
	<input type="hidden" name="rname" value="<%=rname%>">
	<input type="hidden" name="rtel" value="<%=rtel%>">
	<input type="hidden" name="rmob" value="<%=rmob%>">
	<input type="hidden" name="rmail" value="<%=rmail%>">
	<input type="hidden" name="rpass" value="<%=rpass%>">

	<input type="hidden" name="goods_sid" value="">
	<input type="hidden" name="saup_sid" value="<%=saup_sid%>">
	<input type="hidden" name="today_ymd" value="<%=today_ymd%>">
</form>

<table cellpadding="0" cellspacing="0" width="720" height="470">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/tit_res01.gif" width="70" height="21" /></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--컨텐츠 시작-->
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>	
					<td style="padding:20 0 10 16"><img src="<%=imageServer%>/reservation/img/title_step2.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="720" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="716" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_02.gif"></td>
										</tr>
										<tr>
											<td height="35"></td>
										</tr>
										<tr>
											<td align="center" valign="top">
												<table cellpadding="0" cellspacing="0"border=0>
													<tr>
														<td></td>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_con1.jpg"></td>
														<td></td>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_con3.jpg"></td>
														<td></td>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_con2.jpg"></td>
														<td></td>
													</tr>
													<tr>
														<td></td>
														<td align="center" style="padding:7 0 0 0"><a href="javascript:reservation('59')" onFocus="this.blur()"><img src="<%=imageServer%>/reservation/img/reservatio_step1_bt_1.gif" border="0"></a></td>
														<td width="15"></td>
														<td align="center" style="padding:7 0 0 0"><a href="javascript:reservation('58')" onFocus="this.blur()"><img src="<%=imageServer%>/reservation/img/reservatio_step1_bt_2.gif" border="0"></a></td>
														<td width="15"></td>
														<td align="center" style="padding:7 0 0 0"><a href="javascript:reservation('57')" onFocus="this.blur()"><img src="<%=imageServer%>/reservation/img/reservatio_step1_bt_3.gif" border="0"></a></td>
														<td></td>
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

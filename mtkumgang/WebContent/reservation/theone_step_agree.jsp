<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%
	String goods_sid = request.getParameter("goods_sid");					//관광상품 코드
	String saup_sid = request.getParameter("saup_sid");					//관광지 코드
	String start_ymd = request.getParameter("start_ymd");				//출발일자
	String weekend_yn = request.getParameter("weekend_yn");			//주말여부
	String sel_room_sid = request.getParameter("sel_room_sid");		//선택된 방ID
	String sel_upjang_nm = request.getParameter("sel_upjang_nm");	//선택된 호텔명
	String sel_upjang_sid = request.getParameter("sel_upjang_sid");	//선택된 호텔ID
	String pinfo = request.getParameter("pinfo");								//예약한고객의 정보
	String room_nm = request.getParameter("room_nm");					//방명
	String foreigner_yn = request.getParameter("foreigner_yn");			//외국인여부
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>현대아산 온라인 예약　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
#btn {
	position:absolute;
	left:590;
	top:472;
	width:167;
	height:27;
	z-index:1;
}
-->
</style>

<script language="javascript">

	//다음단계로가기
	function nextStep() {
		if(document.resv.agree.checked){
			document.resv.action = "theone_step1.jsp";
			document.resv.submit();
		}else{
			alert("체크박스에 표시하여 동의하셔야 진행할 수 있습니다.");
		};

	}
	
	function prevStep() {
		window.location.history.back();
	}
</script>
</head>
<body>
<form name="resv" method="post">

<table cellpadding="0" cellspacing="0" height="470">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/theone_l_title_1.gif" /></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--컨텐츠 시작-->
			<table cellpadding="0" cellspacing="0" width="770">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/reservation/img/theone_m_title_0.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="335" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="331">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_02.gif"></td>	
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
										<tr>
											<td valign="top" style="padding:5 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="726" height="241" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="724" height="239" bgcolor="F8F8F8">
																<tr>
																	<td><div style="overflow-y:scroll; width:724; height:239; padding:7px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td style="padding:0 0 5 0"><img src="<%=imageServer%>/reservation/img/theone_ss_title_agree.gif"></td>
																			</tr>
																			<tr>
																				<td width="682" height="80" align="LEFT" valign="middle">
<textarea id='xmlarea' name='xmlarea' rows='6' style='width:100%;font-size:12px;'>
<%@ include file="/include/txt_agree.jsp" %>
</textarea>
																				</td>
																			</tr>
																			<tr>
																				<td style="padding:12 0 5 0;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_con2.gif"></td>
																			</tr>
																			<tr>
																				<td width="682" height="78" align="center" valign="middle">
<textarea id='xmlarea' name='xmlarea' rows='6' style='width:100%;font-size:12px;'>
<%@ include file="/include/txt_privacy.jsp" %>
</textarea>
																				</td>
																			</tr>
																		</table>
																	</div></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="40">
											<table width=100%>
											  <tr>
												<td>　<input type=checkbox name=agree>　<b>관광표준약관 및 개인정보취급방침에 동의합니다.</b></td>
												<td align=right><a href="javascript:prevStep()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_cancle.gif" border="0"></a> <a href="javascript:nextStep()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_ok.gif" border="0"></a></td>
											  </tr>
											</table>
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
</form>
</body>
</html>

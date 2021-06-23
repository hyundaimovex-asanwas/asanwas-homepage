<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

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
#btn {
	position:absolute;
	left:590;
	top:432;
	width:167;
	height:27;
	z-index:1;
}
-->
</style>
</head>
<body>
<table cellpadding="0" cellspacing="0" height="470">
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
			<table cellpadding="0" cellspacing="0" width="770">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step6_01.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step6_02.gif"></td>	
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
										<tr>
											<td valign="top" style="padding:5 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="726" height="201" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="724" height="199" bgcolor="F8F8F8">
																<tr>
																	<td align="center" valign="middle" class="res07">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td>여행상품 : <span class="res06">금강산 관광 2박3일</span><br>
																					  여행일정 : <span class="res06">2008년 4월 25일~2008년 4월 28일 </span><br>
																					  숙소 및 객실 : <span class="res06">외금강호텔 스텐다드</span><br>
																					  인원설정 :  <span class="res06">성인 2</span></td>
																			</tr>
																			<tr>
																				<td height="10"></td>
																			</tr>
																			<tr>
																				<td height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td height="10"></td>
																			</tr>
																			<tr>
																				<td>
																					<table cellpadding="0" cellspacing="0" width="360">
																						<tr>
																							<td height="25" class="res08" bgcolor="#666666" align="center">예상 관광요금 : 850,000 원</td>
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
										<tr>
											<td height="10"><div id="btn" align="right"><a href="reservatio_step6.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step6_ok.gif" border="0"></a></div></td>
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

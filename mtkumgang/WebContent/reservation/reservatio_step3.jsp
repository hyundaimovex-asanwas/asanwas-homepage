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
	left:630;
	top:432;
	width:128;
	height:27;
	z-index:1;
}
-->
</style>
<script type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
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
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_01.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
										<tr>
											<td width="328" height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_02.gif"></td>
											<td valign="bottom"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_03.gif"></td>
										</tr>
										<tr>
											<td height="5"></td>
											<td></td>
										</tr>
										<tr>
											<td style="padding:5 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="308" height="132" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="306" height="130" bgcolor="F8F8F8">
																<tr>
																	<td><div style="overflow-y:scroll; width:306; height:130; padding:10px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td width="125" align="center" class="fs11"><b class="res01">숙소명</b></td>
																				<td width="80" align="center" class="res01">객실</td>
																				<td width="62" align="center" class="res02">소개</td>
																			</tr>
																			<tr>
																				<td colspan="3" height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td colspan="3" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" class="res03" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" class="res03">예약가능</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif" onClick="MM_openBrWindow('reservation_popup/pop_01.jsp','','scrollbars=yes,width=600,height=500')"></td>
																			</tr>
																			<tr>
																				<td colspan="3" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" bgcolor="E5E5E5" class="res03" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" bgcolor="E5E5E5" class="res03">예약가능</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="3" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" bgcolor="CECECE" class="res03" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" bgcolor="CECECE" class="res03">예약가능</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="3" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" class="res04" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" class="res04">예약마감</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif"></td>
																			</tr>

																		</table>
																	</div></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
										  </td>
											<td style="padding:5 0 0 0">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="398" height="132" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="396" height="130" bgcolor="F8F8F8">
																<tr>
																	<td><div style="overflow-y:scroll; width:396; height:130; padding:10px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td width="105" align="center" class="fs11"><b class="res01">타입</b></td>
																				<td width="80" align="center" class="res01">요금</td>
																				<td width="55" align="center" class="res01">잔여</td>
																				<td width="59" align="center" class="res01">신청</td>
																				<td width="60" align="center" class="res02">소개</td>
																			</tr>
																			<tr>
																				<td colspan="5" height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td colspan="5" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" bgcolor="#CECECE" class="res03" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" bgcolor="#CECECE" class="res03">11,100,520</td>
																				<td align="center" bgcolor="#CECECE" class="res03"><span class="res05">2</span></td>
																				<td align="center">
																				    <select name="comment" class="linemap_now" style="width:33px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>1</option>
																					  <option>2</option>
																					  <option>3</option>
																					  <option>4</option>
                                                                                  </select>
																			    </td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="5" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" class="res03" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" class="res03">11,100,520</td>
																				<td align="center" class="res03"><span class="res05">2</span></td>
																				<td align="center">
																				    <select name="comment" class="linemap_now" style="width:33px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>1</option>
																					  <option>2</option>
																					  <option>3</option>
																					  <option>4</option>
                                                                                  </select>
																			    </td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="5" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" class="res03" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" class="res03">11,100,520</td>
																				<td align="center" class="res03"><span class="res05">2</span></td>
																				<td align="center">
																				    <select name="comment" class="linemap_now" style="width:33px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>1</option>
																					  <option>2</option>
																					  <option>3</option>
																					  <option>4</option>
                                                                                  </select>
																			    </td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="5" height="3"></td>
																			</tr>
																			<tr>
																				<td height="18" bgcolor="#CECECE" class="res03" style="padding:0 0 0 5">금강산 호텔 본관</td>
																				<td align="center" bgcolor="#CECECE" class="res03">11,100,520</td>
																				<td align="center" bgcolor="#CECECE" class="res03"><span class="res05">2</span></td>
																				<td align="center">
																				    <select name="comment" class="linemap_now" style="width:33px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>1</option>
																					  <option>2</option>
																					  <option>3</option>
																					  <option>4</option>
                                                                                  </select>
																			    </td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif"></td>
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
											<td valign="top" style="padding:0 0 0 10">
												<table width="308" cellpadding="0" cellspacing="0">
													<tr>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_img_01.jpg"></td>
														<td width="10px;"></td>
														<td valign="top">만물상 입구에 자리잡은 
금강산호텔에서는 천혜의 
자연경관과 함께 북측봉사...</td>
													</tr>
											  </table>
											</td>
											<td valign="top">
												<table width="398" cellpadding="0" cellspacing="0">
													<tr>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_img_01.jpg"></td>
														<td width="10px;"></td>
														<td valign="top">만물상 입구에 자리잡은 
금강산호텔에서는 천혜의 
자연경관과 함께 북측봉사...
													  <div id="btn"><a href="reservatio_step2.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_prev.gif" border="0"></a> <a href="reservatio_step4.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_next.gif" border="0"></a></div></td>
													</tr>
											  </table>
											</td>
										</tr>
										<tr>
											<td height="10"></td>
											<td></td>
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

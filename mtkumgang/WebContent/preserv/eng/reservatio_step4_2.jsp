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
//-->
</script>
</head>
<body>
<table cellpadding="0" cellspacing="0" height="470">
	<tr>
		<td width="770" height="65" bgcolor="3F667D">
			<table cellpadding="0" cellspacing="0" height="47" width="100%">
				<tr>
					<td style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_toptitle1.gif"></td>
					<td align="right" valign="bottom" style="padding-right:15px;"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_toptitle2.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--컨텐츠 시작-->
			<table cellpadding="0" cellspacing="0" width="770">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_01.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td><a href="reservatio_step4.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_02_2.gif" border="0"></a> <img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_03.gif"></td>
														<td valign="top" style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_con.gif" align="absmiddle"> You must register by <span class="pagingon">DD, MM, YYYY</span> to complete your reservation for the Mt. Kumgang tour</td>
													</tr>
												</table>	
											</td>	
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
																	<td><div style="overflow-y:scroll; width:724; height:199; padding:10px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																		<table width="100%" cellpadding="0" cellspacing="0">
																			<tr>
																				<td width="90" align="center" class="res01">First Name</td>
																				<td width="90" align="center" class="res01">Last Name</td>
																				<td width="100" align="center" class="res01">Passport No.</td>
																				<td width="150" align="center"><span class="res01">Birthdate</span></td>
																				<td width="120" align="center" class="res01">Phone</td>
																				<td width="72" align="center" class="res01">charge</td>
																				<td width="45" align="center" class="res02">Cancle</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
																			<tr>
																				<td colspan="7">
																					<table width="100%" cellpadding="0" cellspacing="0">
																						<tr>
																							<td height="18" valign="middle" bgcolor="CECECE" class="res03" style="padding-left:10px;"><img src="<%=imageServer%>/tour_img/en_reservation/step4_icon2.gif" align="absmiddle"> 호텔해금강  일반실(더블)</td>
																							<td width="58" align="left" bgcolor="#CECECE"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_del.gif"></td>
																						</tr>
																				  </table>																				</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment2" type="text" style="width:85px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:80px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td height="18" align="center" class="res03"><input name="comment" type="text" style="width:90px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td width="74" align="center">
																					<table cellpadding="0" cellspacing="0">
																						<tr>
																							<td>
																				  <select name="select" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>1920</option>
                                                                                    <option>1921</option>
                                                                                    <option>1922</option>
                                                                                    <option>1923</option>
                                                                                    <option>1924</option>
                                                                                    <option>1925</option>
                                                                                  </select></td>
																				  <td width="45" align="right">&nbsp;<select name="select" class="linemap_now" style="width:40px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>01</option>
                                                                                    <option>02</option>
                                                                                    <option>03</option>
                                                                                    <option>04</option>
                                                                                    <option>05</option>
                                                                                    <option>06</option>
																					<option>07</option>
																					<option>08</option>
																					<option>09</option>
																					<option>10</option>
																					<option>11</option>
																					<option>12</option>
                                                                                  </select></td>
																				  <td width="45" align="right">&nbsp;<select name="select" class="linemap_now" style="width:40px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>01</option>
                                                                                    <option>02</option>
                                                                                    <option>03</option>
                                                                                    <option>04</option>
                                                                                    <option>05</option>
                                                                                    <option>06</option>
																					<option>07</option>
																					<option>08</option>
																					<option>09</option>
																					<option>10</option>
																					<option>11</option>
																					<option>12</option>
																					<option>31</option>
                                                                                  </select></td>
																				 </tr>
																			  </table>																			</td>
																				<td align="center" class="res03"><input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> - <input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> - <input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment2" type="text" style="width:85px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:80px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td height="18" align="center" class="res03"><input name="comment" type="text" style="width:90px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td width="74" align="center">
																					<table cellpadding="0" cellspacing="0">
																						<tr>
																							<td>
																				  <select name="select" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>1920</option>
                                                                                    <option>1921</option>
                                                                                    <option>1922</option>
                                                                                    <option>1923</option>
                                                                                    <option>1924</option>
                                                                                    <option>1925</option>
                                                                                  </select></td>
																				  <td width="45" align="right">&nbsp;<select name="select" class="linemap_now" style="width:40px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>01</option>
                                                                                    <option>02</option>
                                                                                    <option>03</option>
                                                                                    <option>04</option>
                                                                                    <option>05</option>
                                                                                    <option>06</option>
																					<option>07</option>
																					<option>08</option>
																					<option>09</option>
																					<option>10</option>
																					<option>11</option>
																					<option>12</option>
                                                                                  </select></td>
																				  <td width="45" align="right">&nbsp;<select name="select" class="linemap_now" style="width:40px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>01</option>
                                                                                    <option>02</option>
                                                                                    <option>03</option>
                                                                                    <option>04</option>
                                                                                    <option>05</option>
                                                                                    <option>06</option>
																					<option>07</option>
																					<option>08</option>
																					<option>09</option>
																					<option>10</option>
																					<option>11</option>
																					<option>12</option>
																					<option>31</option>
                                                                                  </select></td>
																				 </tr>
																			  </table>																			</td>
																				<td align="center" class="res03"><input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> - <input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> - <input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment2" type="text" style="width:85px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:80px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td height="18" align="center" class="res03"><input name="comment" type="text" style="width:90px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td width="74" align="center">
																					<table cellpadding="0" cellspacing="0">
																						<tr>
																							<td>
																				  <select name="select" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>1920</option>
                                                                                    <option>1921</option>
                                                                                    <option>1922</option>
                                                                                    <option>1923</option>
                                                                                    <option>1924</option>
                                                                                    <option>1925</option>
                                                                                  </select></td>
																				  <td width="45" align="right">&nbsp;<select name="select" class="linemap_now" style="width:40px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>01</option>
                                                                                    <option>02</option>
                                                                                    <option>03</option>
                                                                                    <option>04</option>
                                                                                    <option>05</option>
                                                                                    <option>06</option>
																					<option>07</option>
																					<option>08</option>
																					<option>09</option>
																					<option>10</option>
																					<option>11</option>
																					<option>12</option>
                                                                                  </select></td>
																				  <td width="45" align="right">&nbsp;<select name="select" class="linemap_now" style="width:40px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                    <option>01</option>
                                                                                    <option>02</option>
                                                                                    <option>03</option>
                                                                                    <option>04</option>
                                                                                    <option>05</option>
                                                                                    <option>06</option>
																					<option>07</option>
																					<option>08</option>
																					<option>09</option>
																					<option>10</option>
																					<option>11</option>
																					<option>12</option>
																					<option>31</option>
                                                                                  </select></td>
																				 </tr>
																			  </table>																			</td>
																				<td align="center" class="res03"><input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> - <input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> - <input name="comment22" type="text" style="width:30px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																				<td colspan="7"><img src="<%=imageServer%>/tour_img/en_reservation/reservatio_step4_add.gif"></td>
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
											<td height="10"><div id="btn"><a href="reservatio_step3.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/en_reservation/step_prev.gif" border="0"></a> <a href="reservatio_step5.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/en_reservation/step_next.gif" border="0"></a></div></td>
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

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
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_01.gif"></td>
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
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_02.gif"> <a href="reservatio_step4_2.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_03_2.gif" border="0"></a> </td>
														<td valign="top" style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_con.gif" align="absmiddle"> <span class="pagingon">2008년 4월 23일 까지</span> 관광객등록을 해주셔야 관광예약이 됩니다.</td>
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
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td width="67" align="center" class="res01">이름</td>
																				<td width="161" align="center" class="res01">주민등록번호</td>
																				<td width="186" align="center" class="res01">연락처</td>
																				<td width="34"></td>
																				<td width="68" align="center" class="res01">구분</td>
																				<td width="103" align="center" class="res01">관광요금</td>
																				<td width="58" align="center" class="res02">취소</td>
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
																							<td height="18" valign="middle" bgcolor="CECECE" class="res03" style="padding-left:10px;"><img src="<%=imageServer%>/tour_img/reservation/step4_icon2.gif" align="absmiddle"> 호텔해금강  일반실(더블)</td>
																							<td width="58" align="left" bgcolor="#CECECE"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_del.gif"></td>
																						</tr>
																				  </table>
																				</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment2" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;" value="곽효진"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;" value="102000"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">독실</td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">독실</td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">독실</td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																				<td colspan="7"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_add.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="15"></td>
																			</tr>
																			<tr>
																				<td colspan="7">
																					<table width="100%" cellpadding="0" cellspacing="0">
																						<tr>
																							<td height="18" valign="middle" bgcolor="CECECE" class="res03" style="padding-left:10px;"><img src="<%=imageServer%>/tour_img/reservation/step4_icon2.gif" align="absmiddle"> 호텔해금강  일반실(싱글)</td>
																							<td width="58" align="left" bgcolor="#CECECE"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_del.gif"></td>
																						</tr>
																				  </table>
																				</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment2" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;" value="곽효진"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;" value="102000"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:돋움;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">독실</td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>																			
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																				<td colspan="7"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_add.gif"></td>
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
											<td height="10"><div id="btn"><a href="reservatio_step3.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_prev.gif" border="0"></a> <a href="reservatio_step5.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_next.gif" border="0"></a></div></td>
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

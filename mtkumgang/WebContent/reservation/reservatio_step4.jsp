<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ݰ��� ����</title>
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
		<!--������ ����-->
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
														<td valign="top" style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_con.gif" align="absmiddle"> <span class="pagingon">2008�� 4�� 23�� ����</span> ����������� ���ּž� ���������� �˴ϴ�.</td>
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
																				<td width="67" align="center" class="res01">�̸�</td>
																				<td width="161" align="center" class="res01">�ֹε�Ϲ�ȣ</td>
																				<td width="186" align="center" class="res01">����ó</td>
																				<td width="34"></td>
																				<td width="68" align="center" class="res01">����</td>
																				<td width="103" align="center" class="res01">�������</td>
																				<td width="58" align="center" class="res02">���</td>
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
																							<td height="18" valign="middle" bgcolor="CECECE" class="res03" style="padding-left:10px;"><img src="<%=imageServer%>/tour_img/reservation/step4_icon2.gif" align="absmiddle"> ȣ���رݰ�  �Ϲݽ�(����)</td>
																							<td width="58" align="left" bgcolor="#CECECE"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_del.gif"></td>
																						</tr>
																				  </table>
																				</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment2" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" value="��ȿ��"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" value="102000"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:����;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">����</td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:����;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">����</td>
																				<td align="center" class="res03">12,012,000</td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_delcheck.gif"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:����;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">����</td>
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
																							<td height="18" valign="middle" bgcolor="CECECE" class="res03" style="padding-left:10px;"><img src="<%=imageServer%>/tour_img/reservation/step4_icon2.gif" align="absmiddle"> ȣ���رݰ�  �Ϲݽ�(�̱�)</td>
																							<td width="58" align="left" bgcolor="#CECECE"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_del.gif"></td>
																						</tr>
																				  </table>
																				</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
																			<tr>
																			  <td height="18" class="res03"><input name="comment2" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" value="��ȿ��"></td>
																				<td align="center" class="res03"><input name="comment" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" value="102000"> 
																				- <input name="comment" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td align="center" class="res03"><select name="comment" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:����;" onChange="MM_jumpMenu('parent',this,0)" type="text" value="">
                                                                                      <option>010</option>
																					  <option>011</option>
																					  <option>016</option>
																					  <option>017</option>
																					  <option>018</option>
																					  <option>019</option>
                                                                                  </select> - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"> 
                                                                                  - <input name="comment" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td width="74"></td>
																				<td align="center" class="res03">����</td>
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
		<!--������ ��-->
		</td>
	</tr>
	<tr>
		<td height="8" bgcolor="3F667D"></td>
	</tr>
</table>
</body>
</html>

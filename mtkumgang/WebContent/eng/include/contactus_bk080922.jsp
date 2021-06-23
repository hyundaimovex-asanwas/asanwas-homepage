<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<html>  
<head>
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/eng_img/inc/java.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="194" valign="top"><a href="/eng/main.jsp"><img src="<%=imageServer%>/eng_img/guide/eng_logo.gif" border="0"></a></td>
			<td width="690" height="87" valign="top">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td height="34" valign="top" align="right"><img src="<%=imageServer%>/eng_img/common/korea_bt.gif"></td>
					</tr>
					<!--¿øµª½º ½ÃÀÛ-->
					<tr>
						<td height="29">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td><a href="/eng/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01','','<%=imageServer%>/eng_img/common/top_menu1on.gif',1);MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/eng_img/common/top_menu1.gif" name="topsub_01" border="0"></a></td>
									<td><a href="/eng/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02','','<%=imageServer%>/eng_img/common/top_menu2on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/eng_img/common/top_menu2.gif" name="topsub_02" border="0"></a></td>
									<td><a href="/eng/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03','','<%=imageServer%>/eng_img/common/top_menu3on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show','Layer4','','hide')"><img src="<%=imageServer%>/eng_img/common/top_menu3.gif" name="topsub_03" border="0"></a></td>
									<td><a href="/eng/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04','','<%=imageServer%>/eng_img/common/top_menu4on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','show')"><img src="<%=imageServer%>/eng_img/common/top_menu4.gif" name="topsub_04" border="0"></a></td>
								</tr>						
							</table>						</td>
					</tr>
					<!--¿øµª½º ³¡-->
					<!--Åõµª½º ½ÃÀÛ-->
					<tr>
					 <td height="24" valign="top">
							<div id="Layer1" style="position:absolute; z-index:1; visibility: hidden;">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td width="45"></td>
									<td><a href="/eng/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_01','','<%=imageServer%>/eng_img/common/top_submenu1_01on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu1_01.gif" name="topsub_01_01" border="0"></a></td>
									<td><a href="/eng/preview/story.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_02','','<%=imageServer%>/eng_img/common/top_submenu1_02on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu1_02.gif" name="topsub_01_02" border="0"></a></td>
									<td><a href="/eng/preview/gallery/gallery_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_03','','<%=imageServer%>/eng_img/common/top_submenu1_03on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu1_03.gif" name="topsub_01_03" border="0"></a></td>
									<td><a href="/eng/preview/pr_room/pr_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_04','','<%=imageServer%>/eng_img/common/top_submenu1_04on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu1_04.gif" name="topsub_01_04" border="0"></a></td>
								</tr>
							</table>
						</div>
							<div id="Layer2" style="position:absolute; z-index:2; visibility: hidden;">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td width="244"></td>
									<td><a href="/eng/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_01','','<%=imageServer%>/eng_img/common/top_submenu2_01on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu2_01.gif" name="topsub_02_01" border="0"></a></td>
									<td><a href="/eng/reservation/basic_goods_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_02','','<%=imageServer%>/eng_img/common/top_submenu2_02on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu2_02.gif" name="topsub_02_02" border="0"></a></td>
									<td><a href="/eng/reservation/price/price_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_03','','<%=imageServer%>/eng_img/common/top_submenu2_03on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu2_03.gif" name="topsub_02_03" border="0"></a></td>
									<td><a href="/eng/reservation/agent/agent_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_04','','<%=imageServer%>/eng_img/common/top_submenu2_04on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu2_04.gif" name="topsub_02_04" border="0"></a></td>
								</tr>
							</table>
						</div>
							<div id="Layer3" style="position:absolute; z-index:3; visibility: hidden;">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td width="403"></td>
									<td><a href="/eng/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_01','','<%=imageServer%>/eng_img/common/top_submenu3_01on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu3_01.gif" name="topsub_03_01" border="0"></a></td>
									<td><a href="/eng/start/traffic.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_02','','<%=imageServer%>/eng_img/common/top_submenu3_02on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu3_02.gif" name="topsub_03_02" border="0"></a></td>
									<td><a href="/eng/start/admission.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_03','','<%=imageServer%>/eng_img/common/top_submenu3_03on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu3_03.gif" name="topsub_03_03" border="0"></a></td>
									<td><a href="/eng/start/keeping.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_04','','<%=imageServer%>/eng_img/common/top_submenu3_04on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu3_04.gif" name="topsub_03_04" border="0"></a></td>
								</tr>
							</table>
						</div>
						  <div id="Layer4" style="position:absolute; z-index:4; visibility: hidden;">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td width="223"></td>
									<td><a href="/eng/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_01','','<%=imageServer%>/eng_img/common/top_submenu4_01on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu4_01.gif" name="topsub_04_01" border="0"></a></td>
									<td><a href="/eng/guide/hotel/hotel01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_02','','<%=imageServer%>/eng_img/common/top_submenu4_02on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu4_02.gif" name="topsub_04_02" border="0"></a></td>
									<td><a href="/eng/guide/food/food01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_03','','<%=imageServer%>/eng_img/common/top_submenu4_03on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu4_03.gif" name="topsub_04_03" border="0"></a></td>
									<td><a href="/eng/guide/play/play01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_04','','<%=imageServer%>/eng_img/common/top_submenu4_04on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu4_04.gif" name="topsub_04_04" border="0"></a></td>
									<td><a href="/eng/guide/etc/etcguide.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_05','','<%=imageServer%>/eng_img/common/top_submenu4_05on.gif',1)"><img src="<%=imageServer%>/eng_img/common/top_submenu4_05.gif" name="topsub_04_05" border="0"></a></td>
								</tr>
							</table>
					  </div>					  </td>
					</tr>
					<!--Åõµª½º ³¡-->
				</table>			</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/eng_img/footer/contactus_visul.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/eng_img/leftMenu85.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/eng_img/footer/tit_footer05.gif"></td>
						</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td valign="top" height="25" colspan="4"><img src="<%=imageServer%>/eng_img/footer/txt_contactus_01.gif"></td></tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td width="178" height="26" align="right"><img src="<%=imageServer%>/eng_img/footer/txt04.gif"></td>
							<td width="140" class="lpad_10 tpad_3">Call Center</td>
							<td width="140" class="lpad_10 tpad_3"><a href="mailto:miran@hdasan.com">miran@hdasan.com</a></td>
							<td width="300" class="lpad_10 tpad_3">02-3669-3000</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/eng_img/footer/txt05.gif"></td>
							<td class="lpad_10 tpad_3">Young Man Choi </td>
							<td class="lpad_10 tpad_3"><a href="mailto:ymchoi@hdasan.com">ymchoi@hdasan.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3914</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/eng_img/footer/txt06.gif"></td>
							<td class="lpad_10 tpad_3">Moo Yul Kim</td>
							<td class="lpad_10 tpad_3"><a href="mailto:helloray@hdasan.com">helloray@hdasan.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3915</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/eng_img/footer/txt07.gif"></td>
							<td class="lpad_10 tpad_3">Myung Ryul Gong</td>
							<td class="lpad_10 tpad_3"><a href="mailto:smlkong@empal.com">smlkong@empal.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3711</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/eng_img/footer/txt08.gif"></td>
							<td class="lpad_10 tpad_3">Yoon Jung Lee</td>
							<td class="lpad_10 tpad_3"><a href="mailto:lyjtotoro@hdasan.com">lyjtotoro@hdasan.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3879</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr><td height="39" colspan="4"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td valign="top" height="27" colspan="2"><img src="<%=imageServer%>/eng_img/footer/txt_contactus_02.gif"></td></tr>
						<tr>
							<td width="12"></td>
							<td width="678">- Address: (110-793) Hyundai Bldg. 12F, 140-2 Gye-dong Jongro-gu, Seoul</td>
						</tr>
						<tr>
							<td></td>
							<td>- TEL: 02) 3669-3000 (Inquiries on Tour)</td>
						</tr>
						<tr><td height="34" colspan="2"></td></tr>
						<tr><td valign="top" height="27" colspan="2"><img src="<%=imageServer%>/eng_img/footer/txt_contactus_03.gif"></td></tr>
						<tr>
							<td></td>
							<td>- Subway: Subway Line No. 3 Exit No. 3 (Walk 3 Minutes)<br>- Bus: Local (Green) - No. 1012<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Arterial (Blue) - No. 151, 162, 171, 172, 272, 601</td>
						</tr>
						<tr><td height="27" colspan="2"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/eng_img/footer/map.gif"></td></tr>
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
        <%@ include file="footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
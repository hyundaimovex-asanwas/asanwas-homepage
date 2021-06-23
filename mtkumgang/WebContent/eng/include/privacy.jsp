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
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/eng_img/footer/privacy_visul.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/eng_img/leftMenu83.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/eng_img/footer/tit_footer03.gif"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr><td><img src="<%=imageServer%>/eng_img/footer/txt_privacy02.gif"></td></tr>
				<tr><td height="39"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/eng_img/footer/txt_privacy01.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<span style="width:678px;" class="div06 lh16">
								<strong>01. Purpose and Use of Personal Information</strong><br><br>
								Mt. Geumgang Tour only requires minimum information that is essential for users¡¯ effective use of our Website.  Another reason why we collect your personal information is to provide you with customized services that fit your needs.  With the information you provide, we can provide you with more useful information that satisfies your needs.<br><br>
								<strong>02. Personal Information Categories Requested by Service Provider</strong><br><br>
								For effectiveness, Mt. Geumgang operates on membership.  Therefore, we request basic information to verify your identification, including name, date of birth (Citizen Registration No.), contact information, occupation, address, e-mail, and phone number.  We also request your personal information when you participate in survey or promotion for statistics or delivery of gifts to correct address.<br><br>
								<strong>03. Third Person to Receive Your Personal Information, Purpose, and Information to Provide</strong><br><br>
								Mt. Geumgang Tour does not share or disclose our members¡¯ personal information.  Unless you intentionally share your information on our public bulletin board, your personal information will not be disclosed.  However, we may share your information with our business partners in order to provide you with better services.  Even in this case, we will notify you with whom we are sharing the information and which of the information are needed.  If you disapprove disclosure, we will not share your information with any party.  If one harms others, requested by related government organizations, or demanded for academic statistics, market survey, and statistical processing, we might provide your personal information as general demographic information.<br><br>
								<strong>04. Users¡¯ Rights to Withdraw Agreement, View Information, Request Modification, and Terminate Membership</strong><br><br>
								As a member, you may view and modify your personal information anytime and request termination of membership.  You may view, modify, or terminate your information, visit ¡°Member¡¯s Page¡± on Mt. Geumgang Tour Website.  For other requests and inquiries, dial 399-2326 and our administrator will provide you with answers and instructions.
								</span>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr><td height="30"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
							<td class="lpad_10 rpad_10">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/eng_img/footer/txt_privacy03.gif"></td></tr>
								<tr><td height="14"></td></tr>
								<tr>
									<td class="lh16"><strong class="txt_dblue">Personal Information Administrator: </strong>TEL 02) 3669-3883<br><strong class="txt_dblue">Hyundai-Asan Web Master:</strong><a href="mailto:webmaster@hdasan.com">webmaster@hdasan.com</a></td>
								</tr>
								</table>
							</td>
						</tr>
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
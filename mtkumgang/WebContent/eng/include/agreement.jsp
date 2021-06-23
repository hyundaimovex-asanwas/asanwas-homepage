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
<script language="javascript">
 function savePds(val) {
     location.href="../center/download/download.jsp?file="+val;
 }
</script>
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
					<!--원뎁스 시작-->
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
					<!--원뎁스 끝-->
					<!--투뎁스 시작-->
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
					<!--투뎁스 끝-->
				</table>			</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/eng_img/footer/agreement_visul.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/eng_img/leftMenu82.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/eng_img/footer/tit_footer02.gif"></td>
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
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/eng_img/footer/txt_agreement01.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<div style="width:678px;height:274px;overflow:auto;" class="div06">
								<table width="640" cellpadding="0" cellspacing="1" border="0">
								<tr><td colspan="2"><strong>Chapter 1 General Terms</strong></td></tr>
								<tr><td colspan="2">Article 1 (Purpose)</td></tr>
								<tr>
									<td colspan="2">The purpose of the following Terms and Conditions is to stipulate conditions and procedures on using the Web services (“the services”) provided by Hyundai-Asan Co., Ltd. (“the Company”) (<a href="http://www.hdasan.com" target="new">www.hdasan.com</a>/ <a href="http://www.mtKumgang.com" target="new">www.mtKumgang.com</a>)</td>
								</tr>
								<tr><td colspan="2">Article 2 (Validation and Modification) </td></tr>
								<tr valign="top">
									<td width="15">①</td>
									<td width="625">This document is validated when it is publicly posted on service menu and the Company Website.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company may modify these terms and conditions when there are acceptable reasons.  The modifications must be posted immediately. </td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>Members may terminate their use of services if they do not agree with the modifications.  If members continue to use services even after modifications are validated, it is considered that they have agreed with the modifications.</td>
								</tr>
								<tr><td colspan="2">Article 3 (Supplementary Rules) </td></tr>
								<tr valign="top">
									<td>①</td>
									<td>This document is applied along with the Company’s Individual Service Guidelines (“ the Service Guidelines”). </td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company may follow related laws and the Service Guidelines for issues not stipulated in this document.</td>
								</tr>
								<tr><td colspan="2">Article 4 (Definition of Terms) </td></tr>
								<tr valign="top">
									<td>①</td>
									<td>This document applies the following definitions of terms: </td>
								</tr>
								<tr>
									<td></td>
									<td>1.'Customers' refer to users who have agreed to use the services as members.</td>
								</tr>
								<tr>
									<td></td>
									<td>2. 'User Agreement' refers to the agreement signed between the Company and a customer for the use of services. </td>
								</tr>
								<tr>
									<td></td>
									<td>3. 'User ID' is the combination of alphanumeric characters chosen by customers and authorized by the Company to identity customers and to provide services.</td>
								</tr>
								<tr>
									<td></td>
									<td>4. 'Password' is the combination of alphanumeric characters chosen by customers to verify their authorization as customers and to protect their rights as customers. </td>
								</tr>
								<tr>
									<td></td>
									<td>5. 'Terminal' refers to personal computers and modems installed by customers to use the services.</td>
								</tr>
								<tr>
									<td></td>
									<td>6. 'Termination' refers to terminating the User Agreement between by the Company or a member.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The definitions in this document, except for the one in Item 1, corresponds to the definitions found in related regulations and the Service Guidelines. </td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>Chapter 2 User Agreement </strong></td></tr>
								<tr><td colspan="2">Article 5 (Signing User Agreement)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>User Agreement is validated when customer agrees to comply with this document and the Company accepts his application to use the services.  </td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>Customers agree with the Terms and Conditions by pressing the “I Agree” button on the Hyundai-Asan Website when registering for the services. </td>
								</tr>
								<tr><td colspan="2">Article 6 (Registration for Use of Service) </td></tr>
								<tr valign="top">
									<td>①</td>
									<td>Customers who intend to register as members to use the services must provide required information (name, Citizen Reg. No., contact info, etc).</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>All members must provide their own name and Citizen Reg. No. to use the services.  Those who provide fraudulent information cannot claim any rights.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>Members are required to provide their legal name and the Company reserves the right to verify names.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>If a member uses other person’s name and Citizen Reg. No. to register, his ID will be deleted and he could be punished by law.</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>The Company may classify members by level and restrict their hours of use, accessibility, and/or service menus.</td>
								</tr>
								<tr><td colspan="2">Article 7 (Protection and Use of Personal Information) </td></tr>
								<tr>
									<td colspan="2">The Company makes efforts to protect users’ personal information, including the information they provide, by law.  Related regulations and the Company’s Personal Information Protection Policies apply to the protection and use of users’ personal information.  However, the Company’s Personal Information Protection Policies do not apply to other Websites that are linked to the Company’s official Website(s).  The Company is not responsible for information that is disclosed by users’ mistakes. </td>
								</tr>
								<tr><td colspan="2">Article 8 (Acceptance/Rejection of Registration)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>The Company accepts registration of users, who register for the services in accordance to Article 6, in the order received unless their acceptance interferes with its business or technical services.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company does not accept registration any of the following cases:<br>
									- If used fraudulent name or other’s name;<br>
									- If provided fraudulent information on the registration form; <br>
									- If registering to undermine social order or public morals;<br>
									- If intending to use the services for unjust purposes;<br>
									- If intending to use the services for profitability;<br>
									- If violating other related regulations to register for the services; <br>
									- If intended user is a competitive service provider; <br> </td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>The Company may reserve acceptance until the following reasons of rejection are solved: <br>
									- When the Company does not have enough capacity with facility; <br>
									- When acceptance could cause technical interference;<br>
									- Any other similar reasons.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>The Company may reserve acceptance of registration submitted by legal minors as stipulated in the Service Guidelines. </td>
								</tr>
								<tr><td colspan="2">Article 9 (Authorization and Modification of User ID)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>The Company authorizes User ID as stipulated in this document. </td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>User ID cannot be modified.  If a member wants to use a different User ID, he must re-register with a new ID.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>Hyundai-Asan’s User IDs can be shared with the subsidiary companies of Hyundai-Asan with members’ consent.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>User ID may be modified by customer or with the Company’s request in the following cases:<br>
									- If User ID is user’s telephone number or Citizen Reg. No. and might violate member’s privacy;<br>
									- If User ID disgusts others or undermines with public morals;<br>
									- In other reasonable cases.</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>Each user is responsible for keeping their User ID and password in a safe place.  The Company is not responsible for any losses used by a third person’s unjust use of their User ID and password. </td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>Refer to the Service Guidelines for information on personal information management and modification.</td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>Chapter 3 Responsibility</strong></td></tr>
								<tr><td colspan="2">Article 10 (Company’s Responsibility)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>The Company must allow customers to use the services on any day the services are expected to be available, unless there is a special reason not to.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company must immediately repair or recover systems to provide continuous and stable services, unless there is an inevitable reason not to.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>The Company must build a security system to protect members’ personal information and observe the Personal Information Protection Policies.</td>
								</tr>
								<tr><td colspan="2">Article 11 (User’s Responsibility) </td></tr>
								<tr valign="top">
									<td>①</td>
									<td>Upon registration or modification, Users must provide their real names and factual information.  They cannot claim any rights if they use fraudulent or other’s information.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>Members must observe this document, other regulations and notices provided by the company, related laws and regulations, and must not interfere with the Company’s business or compromise the Company’s reputation.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>Members must take immediate measures to notify the Company in case their address, contact information, and/or e-mail address change.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>Unless the Company is entitled to be responsible by related laws or the Personal Information Protection Policies, each member is responsible for any consequences of incautious management or unlawful use of their User ID.</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>Members cannot use the services to pursue business activities without the Company’s approval and the Company is not responsible for the consequences of such business activities.  If a member’s business activities cause the Company losses, he must compensate for the losses and the Company may restrict his access and take legal measures to claim compensations.</td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>Members cannot transfer, grant, or provide as security their accessibility to the services or membership to a third person without the Company’s written consent.</td>
								</tr>
								<tr valign="top">
									<td>⑦</td>
									<td>Members must not violate the Company’s or a third person’s intellectual property rights.</td>
								</tr>
								<tr valign="top">
									<td>⑧</td>
									<td>Members are not permitted to do any of the following.  If they do, the Company may restrict their services or take legal measures against them.<br>
									- Providing fraudulent information to register or modify member information;<br>
									- Using other person’s User ID, password, and/or Citizen Reg. No.;<br>
									- Trading User ID with others;<br>
									- Impersonating as an employee or staff of the Company;<br>
									- Modifying the Company’s client program, hacking its server, or modifying all or parts of its Website or posts without obtaining special rights to do so from the Company;<br>
									- Damaging the services or interfering with the services intentionally;<br>
									- Duplicating, publishing, broadcasting, or providing to a third person the information acquired through the services without the Company’s approval;<br>
									- Distributing vulgar or lewd information, sentence, drawings, sound, and/or video through online posting, e-mail, or other measures; <br>
									- Distributing insulting or certain contents that might compromise other’s reputation or violate other’s privacy through online posting, e-mail, or other measures;<br>
									- Constantly harassing, blackmailing, or troubling other users;<br>
									- Gathering or saving other users’ personal information without the Company’s approval;<br>
									- Taking any actions that relate to a crime;<br>
									- Violating regulations or conditions of the Company, including this document;<br>
									- Violating related laws.</td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>Chapter 4 User of Service </strong></td></tr>
								<tr><td colspan="2">Article 12 (Service Hours)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>Services must be available 24 hours a day and seven days a week unless there is a special problem with the Company’s operation or technical resources.  However, the Company may temporarily stop providing services at a designated date/time for system maintenance, expansion, or replacement.  In this case, Hyundai-Asan must notify members of service schedule on the Web in advance.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company may temporarily stop the services without notice for urgent system maintenance, expansion, or replacement.  The Company may terminate the services to replace the services with new services or in any other reasonable cases.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>The Company may restrict or stop all or parts of the services if normal system operation is impossible due to national emergencies, blackout, service defects, or service overload.  In this case, the reason and period of restriction or stop must be notified to members in advance or afterwards.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>The Company does not need to notify members if service has been shut down by uncontrollable causes (intentional/mistaken misuse of disks by system administrators, system failure, etc) or by other entities (communication service provider, arterial communication service provider, etc).</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>The Company may divide the services into several sections and designate certain service hours for each section.  In this case, service hours must be noticed.</td>
								</tr>
								<tr><td colspan="2">Article 13 (User ID Management)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>Members are responsible for managing their User ID and password.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company administers User ID and other personal information of members.  When a member intends to modify User ID, the Company may reject it unless there is a special reason.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>Each member is responsible for any losses caused by fraudulent or unjust use of their User ID and/or password.</td>
								</tr>
								<tr><td colspan="2">Article 14 (Posts)</td></tr>
								<tr>
									<td colspan="2">The Company may delete, move, or reject any of the following posts or resources:<br>
									- If posts insult other member(s) or a third person or compromise their reputation;<br>
									- If posts distribute or link to information that is against public order or morals;<br>
									- If posts encourage illegal duplication or hacking;<br>
									- If posts advertise certain products for profits;<br>
									- If posts are related to crimes;<br>
									- If posts violate other members’ or a third person’s intellectual property rights or other rights;<br>
									- If posts violate the Company’s regulations or does not meet the character of bulletin boards;<br>
									- If posts violate related laws.</td>
								</tr>
								<tr><td colspan="2">Article 15 (Intellectual Property Rights)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>Each member has the intellectual property rights of items they post on the service system.  The Company cannot use their posts for commercial purpose without their consent.  However, the Company may use it for non-commercial purpose and reserves the right to post them within the service system.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>Members cannot process, sell, or use for commercial purpose the information they acquire through the services.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>The Company may delete, move, or reject members’ contents or posts if certain contents or posts apply to Article 14.</td>
								</tr>
								<tr><td colspan="2">Article 16 (Information Sharing)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>The Company may share information that might be useful for members via e-mail or official letters.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company may demand additional personal information with users’ consent for service improvement or service promotions.</td>
								</tr>
								<tr><td colspan="2">Article 17 (Advertisements and Relationships with Advertisers)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>The Company makes a portion of their service investment from advertising profits. Members agree with seeing advertisements with the services.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company is not responsible for losses caused by participating in promotions posted on the services or interacting or trading with related advertisers. </td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>Chapter 5 Termination and Restriction</strong></td></tr>
								<tr><td colspan="2">Article 18 (Modification/Termination)</td></tr>
								<tr>
									<td colspan="2">To terminate membership agreement, members must terminate membership using the [Help] menu on Hyundai-Asan’s Website.</td>
								</tr>
								<tr><td colspan="2">Article 19 (Service Restriction)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>The Company may restrict use of services if a member violates Article 11 of this document or in any of the following cases:<br>
									- Using vulgar ID or nickname that is not acceptable for public morals;<br>
									- Insulting other members or interfering with their use of services;<br>
									- Interfering with normal service operation;<br>
									- If correction is required by related organization, including the Korea Internet Safety Commission;<br>
									- If services have not been used for more than three months.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>According to unlawful users’ service restriction rules, the Company may decide to stop service temporarily, format services, or terminate member agreement for certain users without any notice.</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>Chapter 6 Compensations and Other Issues</strong></td></tr>
								<tr><td colspan="2">Article 20 (Compensations)</td></tr>
								<tr><td colspan="2">The Company is not responsible for any losses that relate to the use of free services, unless it is stipulated in the Personal Information Protection Policies.</td></tr>
								<tr><td colspan="2">Article 21 (Exemptions)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>The Company is not responsible for stopping services in case of natural disaster, warfare, or other types of force majeure.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>The Company is not responsible for losses caused when arterial communication service provider stops services or does not provide proper services.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>The Company is not responsible for losses caused by its service maintenance, replacement, regular checkup, or repair.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>The Company is not responsible for service interference or losses caused by members’ mistakes.</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>The Company is not responsible for losses caused by users’ computer failures or mistaken provision of personal information or e-mail address.</td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>The Company is not responsible for it when members fail to acquire expected profits or lose profits by using its services.</td>
								</tr>
								<tr valign="top">
									<td>⑦</td>
									<td>The Company is not responsible for losses caused by using information obtained from the services.  The Company is not required to compensate for members’ mental or physical damages caused by other members on the services.</td>
								</tr>
								<tr valign="top">
									<td>⑧</td>
									<td>The Company is not responsible for the reliability and accuracy of information, resources, or facts posted by members on the services.</td>
								</tr>
								<tr valign="top">
									<td>⑨</td>
									<td>The Company is not obliged to intervene in disputes between members or between a member and a third party and is not responsible for any compensations.</td>
								</tr>
								<tr valign="top">
									<td>⑩</td>
									<td>The Company is not responsible for any losses that relate to the use of its free services.</td>
								</tr>
								<tr><td colspan="2">Article 22 (Other)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>Special members and other charged members shall follow a separate set of Terms and Conditions, and policies.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>If any dispute on the use of services lead to a lawsuit, it shall be arbitrated at Seoul Central District Court.</td>
								</tr>
								<tr>
									<td colspan="2">&lt;Additional Provisions&gt;</td>
								</tr>
								<tr>
									<td colspan="2">(Execution) The above Terms and Conditions are effective as of November 1, 2005. The previous Terms and Conditions effective from April 1, 2003 shall be replaced with the above Terms and Conditions.</td>
								</tr>
								</table>
</div>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr><td height="50"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
							<td align="left">
								<!-- 금강산관광  표준약관 --><!--
								<table width="169" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><img src="<%=imageServer%>/tour_img/footer/txt_agreement02.gif" align="absmiddle"><img src="<%=imageServer%>/tour_img/bu/ico_pdf.gif"  hspace="3" align="absmiddle"></td>
								</tr>
								<tr>
									<td class="tpad_10"><a href="javascript:savePds('금강산관광표준약관.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_footer_pdfdown.gif"></a></td>
								</tr>
								</table>--><!-- PDF다운로드 -->
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
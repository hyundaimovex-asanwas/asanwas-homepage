<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%  
String pageNum = "1";
String subNum = "1";
String McNum = "4";
String sub = "1";
%>
<html>
<head>
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/eng_img/inc/java.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/eng/include/start/tour_start_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/eng/include/start/tour_start_left.jsp" %>
            <!--  left menu flash -->					
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/eng_img/start/tit_start03.gif"></td>
						<td align="right" class="linemap"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<DIV id="print_area" class=newpage style="width:690">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="502">
								<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
								<tr><td colspan="2" valign="top" style="padding:11 0 0 0px;"><img src="<%=imageServer%>/eng_img/start/txt_start03.gif"></td></tr>
								<tr><td width="11" height="61"></td><td width="491"></td></tr>
								<tr><td colspan="2"><img src="<%=imageServer%>/eng_img/start/stit_start031.gif"></td></tr>
								<tr><td colspan="2" height="12"></td></tr>
								<tr>
									<td></td>
									<td>The entry procedure to Mt. Kumgang is similar to entering a foreign countries. </td>
								</tr>
								</table>
							</td>
							<td width="188"><img src="<%=imageServer%>/eng_img/start/img_top_start03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr><td></td><td><img src="<%=imageServer%>/eng_img/start/img_start031.jpg" width="674" height="142"></td></tr>
						<tr><td width="11" height="40"></td><td width="674"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/eng_img/start/stit_start032.gif"></td></tr>
						<tr><td colspan="2" height="19"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0321.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>- Your ID is a document that identifies you. Make sure you bring your ID just as you would when you travel abroad.
<br>- As an ID, your residence registration card, driver¡¯s license or passport will do.
<br>- A permanent resident or citizen of a foreign country or a foreigner must have a passport.
<br>¡Ø Inquiries : Kosung Office of Hyundai Asan Corporation(033)681-9400 </td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0322.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>- You will receive the required documents when you arrive at Asan Rest Area in Hwajinpo, <br>which is  
   the gathering point.
<br>- If you find anything wrong in the document, please let the tour guide know. 
</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/eng_img/start/stit_start0323.gif"></td>
						</tr>
						<tr><td colspan="2" height="8"></td></tr>
						<tr>
							<td></td>
							<td class="b txt_orange">[The documents you need to cross the border to the North]    South Korea -> Mt. Kumgang
</td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/eng_img/start/img_start0321.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>Mt. Kumgang Boarding Pass </strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532"> Three copies are given including one for the corporation, <br>another for collection and the other for the tourist.</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>On the ticket, the name of the hotel and guest room number and the group<br> you belong to are written.</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr valign="top" class="bpad_15">
									<td><img src="<%=imageServer%>/eng_img/start/img_start0322.jpg"></td>
									<td>
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>Two Copies of Tour pass </strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">The original copy and a mini-tour pass are given to you.</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>These are your temporary visa to Mt. Kumgang (North Korea) </td>
										</tr>
										<tr valign="top">
											<td>- </td><td>If you damage or lose the tour pass, a penalty fee will be charged to you.<br> Please keep it safe
   during your trip. 
</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td class="b txt_orange">[The documents you need to cross the border to the South]      Mt. Kumgang -> South Korea</td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/eng_img/start/img_start0324.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>Health Questionnaire</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">This is a form controlled by the Ministry of Health and Welfare to simplify the quarantine inspections  in accordance with Article 9 of the Quarantine Act.</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onclick="fc_print();"><img src="<%=imageServer%>/eng_img/start/btn_start_print.gif" class="btn"></a><!-- ÀÎ¼âÇÏ±â --></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
</div>				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->           
        <%@ include file="/eng/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
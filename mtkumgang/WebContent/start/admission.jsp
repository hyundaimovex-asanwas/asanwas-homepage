<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%   
String McNum = "3";
String sub = "3";
String pageNum = "3";
String subNum = "";
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
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
        <%@ include file="../include/start/tour_start_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../include/start/tour_start_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/start/tit_start03.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">출발안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">출입안내</span></td>
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
								<tr><td colspan="2" valign="top" style="padding:11 0 0 0px;"><img src="<%=imageServer%>/tour_img/start/txt_start03.gif"></td></tr>
								<tr><td width="11" height="61"></td><td width="491"></td></tr>
								<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/start/stit_start031.gif"></td></tr>
								<tr><td colspan="2" height="12"></td></tr>
								<tr>
									<td></td>
									<td>금강산 출입절차는 해외여행과 유사합니다.</td>
								</tr>
								</table>
							</td>
							<td width="188"><img src="<%=imageServer%>/tour_img/start/img_top_start03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr><td></td><td><img src="<%=imageServer%>/tour_img/start/img_start031.jpg" width="674" height="142"></td></tr>
						<tr><td width="11" height="40"></td><td width="674"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/start/stit_start032.gif"></td></tr>
						<tr><td colspan="2" height="19"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0321.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>- 신분증은 본인임을 증명하는 서류입니다. 해외 여행시에 필요한 것과 마찬가지로 반드시 지참하세요.<br>- 신분증은 주민등록증, 운전면허증, 여권 중 하나를 가져오시면 됩니다.<br>- 영주권자, 시민권자, 외국인은 반드시 여권을 지참하시기 바랍니다.<br>※ 문의 전화 : 현대아산 고성사무소 ☎ (033) 681-9400</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0322.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>- 집결지인 화진포 아산 휴게소에 도착하시면 관광에 필요한 서류들을 받으실 수 있습니다.<br>- 내용이 잘못 표기된 사항은 관광조장에게 말씀해주세요.</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0323.gif"></td>
						</tr>
						<tr><td colspan="2" height="8"></td></tr>
						<tr>
							<td></td>
							<td class="b txt_orange">[출경시 필요서류] 남측 → 금강산</td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/tour_img/start/img_start0321.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>금강산관광   이용권</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">회사용, 회수용, 관광객용 3장이 제공됩니다.</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>머무르실 숙소와 객실 방번호, 반/조가 적혀있습니다.</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr valign="top" class="bpad_15">
									<td><img src="<%=imageServer%>/tour_img/start/img_start0322.jpg"></td>
									<td>
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>관광증 2장</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">원본과 미니관광증 각각 1장씩 제공됩니다.</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>일반 해외 여행에 있어 여권에 해당합니다.</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>관광증이 손상되거나 분실될 경우 위반금이 부과될 수 있으므로, 여행기간 동안 깨끗하게<br>보관해야 합니다.</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr valign="top" class="bpad_15">
									<td><img src="<%=imageServer%>/tour_img/start/img_start0323.jpg"></td>
									<td class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>출입신고서(출발)</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">법무부에서 관리하는 신고서로 북측으로 몇 명이 왕래하는지 체크하는 신고서입니다.</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>출발일에 남측 출입사무소에서 제출합니다.</td>
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
							<td class="b txt_orange">[입경시 필요서류] 금강산 → 남측</td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/tour_img/start/img_start0324.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>검역질문서</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">보건복지부에서 관리하는 질문지로서, 검역법 제 9조의 규정에 의한 검역조사를 간소화하기<br>위한 질문서입니다.</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr valign="top" class="bpad_15">
									<td><img src="<%=imageServer%>/tour_img/start/img_start0325.jpg"></td>
									<td class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>출입신고서(도착)</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">법무부에서 관리하는 신고서로 북측으로 몇 명이 왕래하는지 체크하는 신고서입니다.</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>도착일에 남측 출입사무소에서 제출합니다.</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onclick="fc_print();"><img src="<%=imageServer%>/tour_img/btn/btn_start_print.gif" class="btn"></a><!-- 인쇄하기 --></td>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
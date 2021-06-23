<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
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
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/jpn/include/start/tour_start_top_utf8.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/jpn/include/start/tour_start_left_utf8.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/jpn_img/start/tit_start03.gif"></td>
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
								<tr><td colspan="2" valign="top" style="padding:11 0 0 0px;"><img src="<%=imageServer%>/jpn_img/start/txt_start03.gif"></td></tr>
								<tr><td width="11" height="61"></td><td width="491"></td></tr>
								<tr><td colspan="2"><img src="<%=imageServer%>/jpn_img/start/stit_start031.gif"></td></tr>
								<tr><td colspan="2" height="12"></td></tr>
								<tr>
									<td></td>
									<td>金剛山出入手続きは、海外旅行と類似しています</td>
								</tr>
								</table>
							</td>
							<td width="188"><img src="<%=imageServer%>/jpn_img/start/img_top_start03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr><td></td><td><img src="<%=imageServer%>/jpn_img/start/img_start031.jpg" width="674" height="142"></td></tr>
						<tr><td width="11" height="40"></td><td width="674"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/jpn_img/start/stit_start032.gif"></td></tr>
						<tr><td colspan="2" height="19"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0321.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>- 身分証明書はご本人であることを証明する書類です。海外旅行時必要なことと同じなので必ずご持参してください
<br>- 身分証明書は住人登録証、運転免許証、パスポート中一つをご持参してください
<br>- 永住権者、市民権者、外国人は必ずパスポートをご持参してください
<br>※ 問い合わせ電話：現代牙高城山事務所℡（033）681-9400 </td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0322.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>- 集結場である花津浦・牙山(ファジンポアサン)休憩所に到着しましたら観光に必要な書類を
受け取ります
<br>- -内容が間違って表記された場合は観光組長へお話してください
集結場で受け取る書類です
</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/jpn_img/start/stit_start0323.gif"></td>
						</tr>
						<tr><td colspan="2" height="8"></td></tr>
						<tr>
							<td></td>
							<td class="b txt_orange">「出境時に必要な書類」南側→金剛山

</td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/jpn_img/start/img_start0321.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>金剛山観光利用券
</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532"> 会社用、回収用、観光客用の3枚が提供されます</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>お泊りになる宿と部屋番号、班/組が書かれています</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr valign="top" class="bpad_15">
									<td><img src="<%=imageServer%>/jpn_img/start/img_start0322.jpg"></td>
									<td>
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>観光カード２枚</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">原本とミニ観光カード、各1枚ずつが提供されます</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>通常海外旅行のパスポートに該当します</td>
										</tr>
										<tr valign="top">
											<td>- </td><td>観光カードが損傷されたり紛失された場合は違反金が賦課される場合が
　<br>
ありますので旅行期間中はきれいに保管してください

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
							<td class="b txt_orange">「入境時に必要な書類」金剛山→南側</td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/jpn_img/start/img_start0324.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><strong>検疫質問紙</strong></td></tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532">保健福祉部で管理する質問紙として、検疫法第９条の規定によって検疫調査を
簡素化するための質問紙です
</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onClick="fc_print();"><img src="<%=imageServer%>/jpn_img/start/btn_start_print.gif" class="btn"></a><!-- 인쇄하기 --></td>
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
        <%@ include file="/jpn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
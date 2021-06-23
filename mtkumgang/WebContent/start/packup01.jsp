<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<% 
String McNum = "3";
String sub = "1";
String pageNum = "1";
String subNum = "";
%>
<html> 
<head>
<title> 금강산관광   </title>
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
<script language="JavaScript">
<!-- 
function bluring(){ 
if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus(); 
} 
document.onfocusin=bluring; 
// --> 
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
<form name=thisForm> 
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/start/tit_start01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">출발안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">짐꾸리기</span></td>
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
				<tr><td><img src="<%=imageServer%>/tour_img/start/img_top_start01.jpg"></td></tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td>
						<!-- / 탭메뉴 -->

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="102" height="28"><img src="<%=imageServer%>/tour_img/start/tab_start0101_on.gif"></td>
							<td width="102"><a href="packup02.jsp"><img src="<%=imageServer%>/tour_img/start/tab_start0102.gif" onMouseOver="this.src='<%=imageServer%>/tour_img/start/tab_start0102_on.gif'" onMouseOut="this.src='<%=imageServer%>/tour_img/start/tab_start0102.gif'"></a></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/start/tab_start0111.gif"></td>
							<td width="482" background="<%=imageServer%>/tour_img/start/tab_start0112.gif"></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/start/tab_start0113.gif"></td>
						</tr>
						</table>
						<table width="690" class="bg_lgreen" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="33" class="txt_dgreen"><img src="<%=imageServer%>/tour_img/bu/bu_dgreen_arw.gif" style="margin:0 5 2 16px;"><strong>안내 :</strong> 핸드폰은 북측에 가져갈 수 없으므로, 남측 출입사무소 통과시 관광조장에게 맡겨야 합니다.</td>
						</tr>
						</table>
						<!-- 탭메뉴 / -->
					</td>
				</tr>
				<tr><td height="30"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr class="bpad_15" valign="top">
							<td width="135"><img src="<%=imageServer%>/tour_img/start/img_start0101.jpg" width="115" height="100"></td>
							<td width="210"><img src="<%=imageServer%>/tour_img/start/txt_start0101.gif" style="margin-top:10px;"></td>
							<td width="135"><img src="<%=imageServer%>/tour_img/start/img_start0102.jpg" width="115" height="100"></td>
							<td width="210"><a href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3877&requestedPage=1&part=&keyword="><img src="<%=imageServer%>/tour_img/start/txt_start0102.gif" border="0" style="margin-top:10px;" onFocus="this.blur()"></a></td>
						</tr>
						
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0103.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0103.gif" style="margin-top:10px;"></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_start0104.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0104.gif" style="margin-top:10px;"></td>
						</tr>
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0105.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0105.gif" style="margin-top:10px;"></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_start0106.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0106.gif" style="margin-top:10px;"></td>
						</tr>
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0107.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0107.gif" style="margin-top:10px;"></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_start0108.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0108.gif" style="margin-top:10px;"></td>
						</tr>

						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0109.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0109.gif" style="margin-top:10px;"></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_start0110.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0110.gif" style="margin-top:10px;"></td>
						</tr>
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0111.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0111.gif" style="margin-top:10px;"></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_start0112.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0112.gif" style="margin-top:10px;"></td>
						</tr>
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0113.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0113.gif" style="margin-top:10px;"></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_start0114.jpg" width="115" height="100"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0114.gif" style="margin-top:10px;"></td>
						</tr>
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0115.jpg" width="115" height="100"></td>
							
                          <td><img src="<%=imageServer%>/tour_img/start/txt_start0115.gif" style="margin-top:10px;"></td>
							
                          <td>&nbsp;</td>
							
                          <td>&nbsp;</td>
						</tr>
						<tr><td height="10" colspan="4"></td></tr>
						<tr>
						
							<td align="right" colspan="4">
														<a href="javascript:;" onClick="fc_print()"><img src="<%=imageServer%>/tour_img/btn/btn_start_print.gif" class="btn" name=prt id=prt></a><!-- 인쇄하기 --></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
</DIV>
</form>				

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
                     <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
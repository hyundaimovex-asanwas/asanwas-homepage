<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<% 
  String McNum = "2";
  String sub = "1";
  String pageNum = "1";
  String subNum = ""; 
%>

<html>
<head>
<title> 금강산관광  </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/maplink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script>
function printDiv () { 
if (document.all && window.print) { 
   window.onbeforeprint = beforeDivs; 
   window.onafterprint = afterDivs; 
   window.print(); 
} 
} 
function beforeDivs () { 
if (document.all) { 
   objContents.style.display = 'none'; 
   objSelection.innerHTML = document.all['d1'].innerHTML; 
} 
} 
function afterDivs () { 
if (document.all) { 
   objContents.style.display = 'block'; 
   objSelection.innerHTML = ""; 
} 
} 
</script>
</head>

<body>
<DIV ID="objContents">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
                     <%@ include file="../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
		<!-------- / top area -------->
                     <%@ include file="../include/reservation/tour_reservation_left.jsp" %>
		<!-------- top area / -------->
				</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_res01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약/신청</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">예약방법</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
 				
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/apply/top_txt_res01.gif"></td></tr>
				</table>
				<span id="d1">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr>
					<td>
						<table width="679" cellpadding="0" cellspacing="0" border="0" style='margin-left:11px;'>
						<tr><td colspan="7" height="10"></td></tr>
						<tr valign="top">
							<td width="145"><img src="<%=imageServer%>/tour_img/apply/img_res_p0101.gif"><br><a href="javascript:;Menu02_06();"><img src="<%=imageServer%>/tour_img/btn/btn_agencydesc.gif" style='margin:14 0 0 9px;'></a></td>
							<td width="33" align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline.gif"></td>
							<td width="145"><img src="<%=imageServer%>/tour_img/apply/img_res_p0102.gif"></td>
							<td width="33" align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline.gif"></td>
							<td width="145"><img src="<%=imageServer%>/tour_img/apply/img_res_p0103.gif"></td>
							<td width="33" align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline.gif"></td>
							<td width="145"><img src="<%=imageServer%>/tour_img/apply/img_res_p0104.gif"></td>
						</tr>
						<tr><td colspan="7" height="30"></td></tr>
						<tr><td colspan="7"><img src="<%=imageServer%>/tour_img/apply/stit_res02.gif"></td></tr>
						<tr><td colspan="7" height="10"></td></tr>
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/apply/img_res_p0201.gif"><br><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/btn/btn_onlinereser.gif" style='margin:14 0 0 9px;'></a></td>
							<td align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline2.gif"></td>
							<td><img src="<%=imageServer%>/tour_img/apply/img_res_p0202.gif"></td>
							<td align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline2.gif"></td>
							<td><img src="<%=imageServer%>/tour_img/apply/img_res_p0203.gif"></td>
							<td align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline2.gif"></td>
							<td><img src="<%=imageServer%>/tour_img/apply/img_res_p0204.gif"></td>
						</tr>
						</table>
						
						<table width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="right" style="padding-top:20px;"><a href="javascript:printDiv('d1');"><img src="<%=imageServer%>/tour_img/btn/print_bt.gif" border="0"></a></td>
							</tr>
					 </table>
					 
					</td>
				</tr>
				</table>
				</span>
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

</DIV> 
<DIV ID="objSelection"> 
</DIV>
</body>
</html>
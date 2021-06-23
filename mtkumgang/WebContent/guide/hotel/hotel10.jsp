<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>  
<% 
String McNum = "4";
String sub = "2";
String pageNum = "2";
String subNum = "10";
%>
<html>
<head>
<title>   금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/guide/tour_guide_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../../include/guide/tour_guide_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/guide/tit_guide210.gif"><img src="<%=imageServer%>/tour_img/guide/tit_guide02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">현지안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">숙박안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">해변 마을</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="36"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="264">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_hotel10.gif"></td></tr>
								<tr><td height="12"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_hotel101.gif"></td></tr>
								<tr><td height="25"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_hotel102.gif"></td></tr>
								<tr><td height="12"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_hotel103.gif"></td></tr>
								<tr><td height="12"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_hotel104.gif"></td></tr>
								<tr><td height="12"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_hotel105.gif"></td></tr>
								</table>
							</td>
							<td width="426"><img src="<%=imageServer%>/tour_img/guide/img_hotel10.jpg" width="426" height="329"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="30"></td></tr>
				<tr>
					<td valign="top">
						<!-- / detail table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="232"><col width="458">
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/tour_img/guide/img_hotel1001.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_hotel1001.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/tour_img/guide/img_hotel1002.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_hotel1002.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/tour_img/guide/img_hotel1003.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_hotel1003.gif" style="margin-top:11px;"></td>
						</tr>
						</table>
						<!-- detail table / -->
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
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="922">
				<table width="884" cellpadding="0" cellspacing="0" border="0" class="footer">
				<tr valign="top">
					<td width="104" height="20" rowspan="2"><img src="<%=imageServer%>/tour_img/footer_logo.gif"></td>
					<td width="645" class="tpad_3"><a href="#"><img src="<%=imageServer%>/tour_img/footer_01.gif"></a><a href="#"><img src="<%=imageServer%>/tour_img/footer_02.gif"></a><a href="#"><img src="<%=imageServer%>/tour_img/footer_03.gif"></a><a href="#"><img src="<%=imageServer%>/tour_img/footer_04.gif"></a></td>
					<td width="135">
						<table width="132" height="17" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="center" style="background:url('<%=imageServer%>/tour_img/bgbox_select.gif');fixed no-repeat left top;">
								<script>
								var strCombo = ""
								+ "<select name='select' style='width:128px; height:15px;'>"
								+ "<option value='#' selected>FAMILY SITE</option>"
								+ "<option value='#'></option>"
								+ "<option value='#'></option>"
								+ "<option value='#'></option>"
								+ "<option value='#'></option>"
								+ "<option value='#'></option>"
								+ "<option value='#'></option>"
								+ "</select>";
								SS_write(strCombo, 5, '', 'up');
								</script>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="61" colspan="2" valign="top"><img src="<%=imageServer%>/tour_img/footer_right.gif"></td></tr>
				</table>
			</td>
			<td valign="top" style="padding-top:40px;"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top.gif"></a></td>
		</tr>
		</table>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
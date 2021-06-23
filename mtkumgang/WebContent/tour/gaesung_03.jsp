<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
String McNum = "0";
String sub = "0";
String pageNum = "2";
String subNum = "3";
%>
<html>
<head>
<title> 陛碍魂包堡      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/tour/tour_tour_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../include/tour/tour_tour_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/tour/tit_tour23.gif"><img src="<%=imageServer%>/tour_img/tour/tit_tour02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">合螟包堡</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">俺己包堡</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" lass="linemap_margin2"><span class="linemap_now">林夸 包堡瘤</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour21.gif"></td></tr>
				<tr><td height="49"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="233">
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="29"><img src="<%=imageServer%>/tour_img/tour/img_tour2311.jpg" width="215" height="107"></td></tr>
								</table>
							</td>
							<td width="457"><img src="<%=imageServer%>/tour_img/tour/txt_tour2301.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>
						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="29"><img src="<%=imageServer%>/tour_img/tour/img_tour2321.jpg" width="215" height="107"></td></tr>
								</table>
							</td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour2302.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="29"><img src="<%=imageServer%>/tour_img/tour/img_tour2331.jpg" width="215" height="107"></td></tr>
								</table>
							</td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour2303.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="29"><img src="<%=imageServer%>/tour_img/tour/img_tour2341.jpg" width="215" height="107"></td></tr>
								</table>
							</td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour2304.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="29"><img src="<%=imageServer%>/tour_img/tour/img_tour2351.jpg" width="215" height="107"></td></tr>
								</table>
							</td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour2305.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="29"><img src="<%=imageServer%>/tour_img/tour/img_tour2361.jpg" width="215" height="107"></td></tr>
								</table>
							</td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour2306.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="29"><img src="<%=imageServer%>/tour_img/tour/img_tour2371.jpg" width="215" height="107"></td></tr>
								</table>
							</td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour2307.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>  
<% 
String McNum = "4";
String sub = "4"; 
String pageNum = "4";
String subNum = "5";
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
						<td height="54"><img src="<%=imageServer%>/tour_img/guide/tit_guide45.gif"><img src="<%=imageServer%>/tour_img/guide/tit_guide04.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">현지안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">문화/놀이</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">해수욕장</span></td>
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
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_play05.gif"></td></tr>
								<tr><td height="12"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_play051.gif"></td></tr>
								<tr><td height="25"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_play052.gif"></td></tr>
								<tr><td height="14"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_play053.gif"></td></tr>
								<tr><td height="17"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_play054.gif"></td></tr>
								<tr><td height="14"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/guide/txt_play055.gif"></td></tr>
								<tr><td height="24"></td></tr>
								</table>
							</td>
							<td width="426"><img src="<%=imageServer%>/tour_img/guide/img_play05.jpg" width="426" height="329"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / detail table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="232"><col width="458">
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/tour_img/guide/img_play0501.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_play0501.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/tour_img/guide/img_play0502.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_play0502.gif" style="margin-top:11px;"></td>
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
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>
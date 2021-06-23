<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
String McNum = "0";
String sub = "0";
String pageNum = "1";
String subNum = "2";
%>
<html>
<head>
<title> ±Ý°­»ê°ü±¤      </title>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/tour/tit_tour12.gif"><img src="<%=imageServer%>/tour_img/tour/tit_tour01.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">ºÏÃø°ü±¤</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">¹éµÎ»ê°ü±¤</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" lass="linemap_margin2"><span class="linemap_now">ÁÖ¿ä °ü±¤Áö</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour11.gif" style="margin-left:17px;"></td></tr>
				<tr><td height="49"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="233"><img src="<%=imageServer%>/tour_img/tour/img_tour1201.jpg" width="215" height="107"></td>
							<td width="457"><img src="<%=imageServer%>/tour_img/tour/txt_tour1201.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1202.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1202.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1203.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1203.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1204.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1204.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1205.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1205.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1206.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1206.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1207.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1207.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1208.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1208.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1209.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1209.gif" style="margin-top:10px;"></td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/tour/img_tour1210.jpg" width="215" height="107"></td>
							<td><img src="<%=imageServer%>/tour_img/tour/txt_tour1210.gif" style="margin-top:10px;"></td>
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
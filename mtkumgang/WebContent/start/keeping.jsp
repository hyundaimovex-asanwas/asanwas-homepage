<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%  
String McNum = "3";
String sub = "4";
String pageNum = "4";
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
						<td height="54"><img src="<%=imageServer%>/tour_img/start/tit_start04.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">출발안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">유의사항</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td colspan="2" height="11"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/start/img_top_start04.jpg"></td></tr>
				<tr><td colspan="2" height="10"></td></tr>
				<tr>
					<td width="375"><img src="<%=imageServer%>/tour_img/start/img_start041.jpg"></td>
					<td><img src="<%=imageServer%>/tour_img/start/txt_start041.gif"></td>
				</tr>
				<tr><td colspan="2" height="30"></td></tr>
				<tr>
					<td><img src="<%=imageServer%>/tour_img/start/txt_start0421.gif"><br><img src="<%=imageServer%>/tour_img/start/txt_start0422.gif" style="margin-top:25px;"></td>
					<td><img src="<%=imageServer%>/tour_img/start/img_start042.jpg"></td>
				</tr>
				<tr><td colspan="2" height="30"></td></tr>
				<tr>
					<td><img src="<%=imageServer%>/tour_img/start/img_start043.jpg"></td>
					<td><img src="<%=imageServer%>/tour_img/start/txt_start0431.gif"><br><img src="<%=imageServer%>/tour_img/start/txt_start0432.gif" style="margin-top:25px;"><br><img src="<%=imageServer%>/tour_img/start/txt_start0433.gif" style="margin-top:25px;"></td>
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
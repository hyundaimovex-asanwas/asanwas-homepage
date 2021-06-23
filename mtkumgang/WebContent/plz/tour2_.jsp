<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%   
  String pageNum = "2";
  String McNum = "0";
  String sub = "2";  
  
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
        <%@ include file="../include/plz/tour_plz_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../include/plz/tour_plz_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">PLZ관광</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">상품안내<img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">상품1</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_01.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_02_02.jpg" width="690" height="200" border="0" usemap="#Map"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_02_03.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_02_04.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_02_05.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_02_06.jpg"></td></tr>
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




<map name="Map">
<area shape="rect" coords="278,156,371,176" href="#">
<area shape="rect" coords="375,156,462,179" href="#">
<area shape="rect" coords="465,156,556,179" href="#">
<area shape="rect" coords="559,156,658,180" href="#">
</map></body>
</html>
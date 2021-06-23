<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%   
  String pageNum = "2";
  String McNum = "0";
  String sub = "1";  
  
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
<!--
function pop_close() {
	window.open("/plz/tour1_01.jsp", '', 'width=600,height=800, scrollbars=yes');
}

function content_print() {
	window.open("/plz/tour1_print.jsp", '','width=700, height=800 scrollbars=yes');
}

function goResv() {
	window.open("/preserv/plz_resv_pop.jsp", "", "width=730, height=500 scrollbars=no");
}
-->
</script>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview05.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">PLZ관광</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">상품안내<img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">상품1</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
				
				<div id="print01">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_01.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_02.jpg" width="690" height="227" border="0" usemap="#Map"></td>
				</tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_03.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_04.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_05.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_06.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz02_01_07.jpg"></td></tr>
				</table>
				</div>

				<map name="Map">
				      <area shape="rect" coords="280,178,373,198" href="javascript:pop_close();">
				      <area shape="rect" coords="377,177,464,200" href="javascript:content_print();">
				      <area shape="rect" coords="468,177,559,200" href="#">
				      <area shape="rect" coords="561,176,660,200" href="javascript:goResv();">
			      </map>
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
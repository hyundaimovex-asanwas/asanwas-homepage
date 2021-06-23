<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
String McNum = "0";
String sub = "0";
String pageNum = "2";
String subNum = "1"; 
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
						<td height="54"><img src="<%=imageServer%>/tour_img/tour/tit_tour21.gif"><img src="<%=imageServer%>/tour_img/tour/tit_tour02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">북측관광</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">개성관광</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" lass="linemap_margin2"><span class="linemap_now">개성관광 소개</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour21.gif" style="margin-left:5px;"></td></tr>
				<tr><td height="49"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="284"><img src="<%=imageServer%>/tour_img/tour/img_tour2101.jpg" width="245" height="340"></td>
							<td width="406">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour2101.gif"></td></tr>
								<tr><td height="19"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour2102.gif"></td></tr>
								<tr><td height="34"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour2103.gif"></td></tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="45"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="425"><img src="<%=imageServer%>/tour_img/tour/stit_tour02012.gif"></td>
							<td width="265" rowspan="7" valign="top" style="padding-top:50px"><script language="javascript">
					f_id = "Tour_flash";//플래시 아이디
					f_name ="<%=imageServer%>/tour_swf/Tour_flash.swf"; //플래시 파일명
					f_width = "264";//가로크기
					f_height ="236"; //세로높이
					f_trans =""; //공백, transparent(투명)
					f_para =""; //파라미터
					show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
				</script></td>
						</tr>
						<tr><td height="30"></td></tr>
						<tr><td><img src="<%=imageServer%>/tour_img/tour/stit_tour0201.gif"></td></tr>
						<tr><td height="18"></td></tr>
						<tr><td><img src="<%=imageServer%>/tour_img/tour/stit_tour02011.gif"></td></tr>
						<tr><td height="9"></td></tr>
						<tr valign="top">
							<td width="425">
								<table width="390" cellpadding="0" cellspacing="0" border="0">
								<tr><td>개성은 북측 황해북도에 위치한 고려(918~1392)의 도읍지로 문화유적이 많은 도시입니다. 휴전선을 사이에 두고 남측의 파주, 연천 등과 접하고 있으며, 한강을 사이에 두고는 김포와 인천(강화도)를 마주하고 있습니다<br><br>2002년까지만 해도 개성시,판문군,개풍군,장풍군을 합하여 개성직할시였으나,2002년 개성공업지구(개성공단)가 만들어지면서 개성직할시체제는 없어지고 현재는 개성시,개풍군,장풍군으로 나뉘어져 있습니다. 현재 개성시가지에는 약 10만여명의 주민이 생활하고 있습니다.</td></tr>
								<tr><td height="34"></td></tr>
								</table>
							</td>
						</tr>
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
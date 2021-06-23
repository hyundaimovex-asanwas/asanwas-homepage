<%-- 
  - 작성자: 이소연
  - 일자: 2006.07
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>다운로드
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
String McNum = "5";
String sub = "2";
String pageNum = "2";
String subNum = "0";
%>
<html>
<head>
<title> 금강산관광   </title>
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
        <%@ include file="../../include/community/tour_gallery_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../../include/community/tour_gallery_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm022.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">이벤트</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0">
						<map name="lasteventview">
								<area shape="rect" coords="424,24,522,45" href="javascript:document.location.href='prevent_list.jsp';"><!-- 지난이벤트보기 -->
						</map>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/community/img_ingevent_top.jpg" usemap="#lasteventview"></td>
						</tr>
						<tr>
							<td align=center>
								<!-- / 이벤트내용 -->

<table width="680" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="<%=imageServer%>/tour_img/community/img_ingevent_0428.jpg" width="682" height="544" border="0" usemap="#Map" /></td>
  </tr>
</table>
<map name="Map" id="Map"><area shape="rect" coords="229,980,457,1032" href="#top" onclick="Q_navi01();"/>
                  <area shape="rect" coords="253,144,326,166" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1512&requestedPage=1&part=&keyword=">
                  <area shape="rect" coords="593,145,669,170" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=1431&requestedPage=1&part=&keyword=">
                  <area shape="rect" coords="258,329,329,353" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=1431&requestedPage=1&part=&keyword=">
                  <area shape="rect" coords="597,332,670,354" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1233&requestedPage=1&part=&keyword=">
                  <area shape="rect" coords="257,510,329,533" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1313&requestedPage=1&part=&keyword=">
                  <area shape="rect" coords="593,509,669,534" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=678&requestedPage=1&part=&keyword=">
                </map></body>
								
								<!-- 이벤트내용 / -->
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
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /--> 
	</td>
</tr>
</table>

</body>
</html>
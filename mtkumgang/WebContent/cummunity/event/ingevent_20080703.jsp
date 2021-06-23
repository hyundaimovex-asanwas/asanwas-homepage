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

<style type="text/css">
<!--

A:link {color:ad9dc1;text-decoration:none;}
A:visited {color:ad9dc1;text-decoration:none;}
A:active {color:ad9dc1;text-decoration:none;}
A:hover {color:ad9dc1;text-decoration: none}

.style1 {
	font-size: 14px;
	font-weight: bold;
	color: #FFFFFF;
}
.style3 {color: #ad9dc1}
-->
</style>
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
          <td><img src="<%=imageServer%>/tour_img/community/event_page_080624.jpg" width="682" height="911" border="0" usemap="#gogogo">
            <map name="gogogo">
              <!--10주년 -->
              <area shape="rect" coords="249,140,323,170" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3891&requestedPage=1&part=&keyword=" onFocus="this.blur()">
              <!--내금강문화유적 -->
              <area shape="rect" coords="590,141,666,170" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3878&requestedPage=1&part=&keyword="onFocus="this.blur()">
              <!--지마켓 -->
              <area shape="rect" coords="589,319,664,349" href="http://gen.gmarket.co.kr/challenge/neo_sangsul/html_sangsul/plan_display_43766.asp?sid=43766&goodscode=&stat=S3&subkind=" target="_blank"onFocus="this.blur()">
              <!--마이카 -->
              <area shape="rect" coords="248,500,326,530" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3543&requestedPage=1&part=&keyword="onFocus="this.blur()">
              <!--여름휴가 -->
              <area shape="rect" coords="249,320,320,350" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3944&requestedPage=1&part=&keyword=">
              <!--침대열차 -->
              <area shape="rect" coords="584,501,664,534" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3605&requestedPage=1&part=&keyword="onFocus="this.blur()">
              <!--가고또가고 -->
              <area shape="rect" coords="249,680,326,712" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3910&requestedPage=1&part=&keyword="onFocus="this.blur()">
              <!--온라인예약 -->
              <area shape="rect" coords="589,681,666,714" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=678&requestedPage=1&part=&keyword="onFocus="this.blur()">
              <!--특별한이벤트 -->
              <area shape="rect" coords="250,862,324,892" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3617&requestedPage=1&part=&keyword="onFocus="this.blur()">
              <!--공모전 -->
              <area shape="rect" coords="588,865,664,894" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3697&requestedPage=1&part=&keyword=" onFocus="this.blur()">
            </map></td>
  </tr>
</table>
             
                            </body>
								
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
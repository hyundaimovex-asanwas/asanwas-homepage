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
          <td><img src="<%=imageServer%>/tour_img/community/event_page_080725.jpg" width="682" height="910" border="0" usemap="#gogogo">
            <map name="gogogo">
              <!--10주년 --><!--내금강문화유적 --><!--지마켓 -->
              <area shape="rect" coords="251,868,325,893" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');" onFocus="this.blur()">
              <!--마이카 -->
              <area shape="rect" coords="591,684,668,712" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');"onFocus="this.blur()">
              <!--여름휴가 -->
              <area shape="rect" coords="251,684,328,711" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');" onFocus="this.blur()">
              <!--침대열차 -->
              <area shape="rect" coords="588,500,668,528" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');"onFocus="this.blur()">
              <!--가고또가고 -->
              <area shape="rect" coords="251,319,322,344" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');">
              <!--온라인예약 -->
              <area shape="rect" coords="249,505,327,530" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');"onFocus="this.blur()">
              <!--특별한이벤트 -->
              <area shape="rect" coords="588,320,663,345" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');"onFocus="this.blur()">
              <!--공모전 -->
              <area shape="rect" coords="589,138,665,162" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');" onFocus="this.blur()">
               <area shape="rect" coords="249,141,323,166" href="javascript:alert('빠른시일내 즐거운 금강산관광 으로 찾아 뵙겠습니다^^');" onFocus="this.blur()">
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
<%-- 
  - �ۼ���: �̼ҿ�
  - ����: 2006.07
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>�ٿ�ε�
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
<title> �ݰ������   </title>
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
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">�̺�Ʈ</span></td>
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
								<area shape="rect" coords="424,24,522,45" href="javascript:document.location.href='prevent_list.jsp';"><!-- �����̺�Ʈ���� -->
						</map>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/community/img_ingevent_top.jpg" usemap="#lasteventview"></td>
						</tr>
						<tr>
							<td align=center>
								<!-- / �̺�Ʈ���� -->

<table width="680" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="<%=imageServer%>/tour_img/community/img_ingevent_0712.jpg" width="682" height="907" border="0" usemap="#Map" /></td>
  </tr>
</table>
<map name="Map" id="Map">
				<area shape="rect" coords="590,496,666,529" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1859&requestedPage=1&part=&keyword=" onFocus="this.blur()"/>
                  <area shape="rect" coords="249,500,325,528" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=2041&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="592,320,665,350" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=2037&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="253,316,324,348" href="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=2040&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="590,138,666,171" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1943&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="252,138,325,168" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1949&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="229,1306,457,1375" href="#top" onClick="Q_navi01();">
                  <area shape="rect" coords="250,685,325,711" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=678&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="591,683,663,712" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1810&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="256,867,327,891" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1733&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                  <area shape="rect" coords="590,867,665,890" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1233&requestedPage=1&part=&keyword=" onFocus="this.blur()">
                </map></body>
								
								<!-- �̺�Ʈ���� / -->
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
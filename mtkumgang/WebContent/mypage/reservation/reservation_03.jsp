<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.07.03
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ��
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
  String McNum = "0";
  String sub = "0";
  String pageNum = "2";
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
        <%@ include file="../../include/mypage/tour_mypage_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174" height="100%">
				<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td height="50%" valign="top">
			<!--  left menu flash -->
			<%@ include file="../../include/mypage/tour_mypage_left.jsp" %>
			<!--  left menu flash -->
					</td>
				</tr>
				<tr>
					<td height="50%" valign="bottom"><!-- <img src="<%=imageServer%>/tour_img/mypage/img_left_callcenter.jpg" width="174" height="46"> --></td>
				</tr>
				</table>
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reservation.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���� ��������</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="13"></td></tr>
								<tr><td height="100" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_reservation2.gif"></td></tr>
								<tr><td height="77" valign="top"><img src="<%=imageServer%>/tour_img/mypage/tab01.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab02.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab03_on.gif" class="btn"></td></tr>
								</table>
							</td>
							<td align="right"><img src="<%=imageServer%>/tour_img/mypage/img_reservation2.jpg"></td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / �������� -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr>
							<td valign="top" height="26" colspan="4" class="txt_sky"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket06.gif" style="margin:0 7 3 5px;" align="absmiddle"><u><strong>990001000461</strong></u></td>
						</tr>
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td width="86" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket61.gif"><!-- ���� �Ⱓ --></td>
							<td colspan="3">2006��05�� 24��(������) ~ 2006�� 05�� 26��(�ݿ���)</td>
						</tr>
						<tr><td height="1" colspan="4" class="tabline"></td></tr>
						<tr>
							<td width="86" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket62.gif"><!-- ���� �ϼ� --></td>
							<td width="258">2�� 3��</td>
							<td width="86"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket63.gif"><!-- �����Ͻ� --></td>
							<td width="260">2006-05-22 08:00</td>
						</tr>
						<tr><td height="1" colspan="4" class="tabline"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket64.gif"><!-- �ο� --></td>
							<td>12 ��</td>
							<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket65.gif"><!-- �Ѿ� --></td>
							<td>1,400,000</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>

						<table cellspacing="0" cellpadding="0" border="0" width="690" style="margin-top:30px;">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td width="100" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket66.gif"><!-- ������ �̸� --></td>
							<td width="244">��ȿ��</td>
							<td width="86"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket67.gif"><!-- �̸��� --></td>
							<td width="260">today@imjk.co.kr</td>
						</tr>
						<tr><td height="1" colspan="4" class="tabline"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket68.gif"><!-- �ڵ��� ��ȣ --></td>
							<td>011-1111-1111</td>
							<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket69.gif"><!-- ��ȭ��ȣ --></td>
							<td>011-111-1111</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- �������� / -->

						<!-- / �ϴܹ�ư -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" style="margin-top:14px;">
						<tr>
							<td align="right"><a href="javascript:;" onclick="window.open ('popup_reservation_ticket.jsp', 'movieview', 'width=518,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_preticket.gif" class="btn"></a><!-- ����Ƽ�� ���� --></td>
						</tr>
						</table>
						<!-- �ϴܹ�ư / -->
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
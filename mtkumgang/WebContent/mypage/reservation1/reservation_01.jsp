<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.07.03
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ��
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<html>
<head>
<title> �ݰ������ </title>
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
					<td height="50%" valign="bottom"><img src="<%=imageServer%>/tour_img/mypage/img_left_callcenter.jpg" width="174" height="46"></td>
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
								<tr><td height="77" valign="top"><img src="<%=imageServer%>/tour_img/mypage/tab01_on.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab02.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab03.gif" class="btn"></td></tr>
								</table>
							</td>
							<td align="right"><img src="<%=imageServer%>/tour_img/mypage/img_reservation2.jpg"></td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="530">
								<!-- / ���೻�� -->
								<table cellspacing="0" cellpadding="0" border="0" width="510">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket01.gif" hspace="5"><!-- ���೻�� --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket01.gif"><!-- ����Ⱓ --></td>
									<td colspan="3">2006�� 05�� 24��(������) ~ 2006�� 05�� 26��(�ݿ���)</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket02.gif"><!-- �����ϼ� --></td>
									<td width="166">2��3��</td>
									<td width="112"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket03.gif"><!-- �����Ͻ� --></td>
									<td width="144">2006-05-22 08:00</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket04.gif"><!-- �ο� --></td>
									<td>12��</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket05.gif"><!-- ������� --></td>
									<td>�����Ϸ�</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket06.gif"><!-- �Ѿ� --></td>
									<td>1,400,000</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket07.gif"><!-- ���������Ͻ� --></td>
									<td>2006-05-26 08:00</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- ���೻�� / -->

								<!-- / ���������� -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket02.gif" hspace="5"><!-- ���������� --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="102" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket21.gif"><!-- �������̸� --></td>
									<td width="139">��ȿ��</td>
									<td width="85"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket22.gif"><!-- �̸��� --></td>
									<td width="184">today@imjk.co.kr</td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket23.gif"><!-- �ڵ�����ȣ --></td>
									<td>011-1111-1111</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket24.gif"><!-- ��ȭ��ȣ --></td>
									<td>011-1111-1111</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- ���������� / -->

								<!-- / ����`����`���������� -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- ����`����`���������� --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- ���� --></td>
									<td width="175">ȣ�� �رݰ�</td>
									<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- ���� --></td>
									<td width="205">�Ϲݽ�(�µ�)</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>

								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:14 0 14 0px;" class="tabline">
								<tr align="center">
									<td class="bg_white" height="26">�̸�</td>
									<td class="bg_white">�ֹε�Ϲ�ȣ</td>
									<td class="bg_white">������</td>
									<td class="bg_white">���ɱ���</td>
									<td class="bg_white">�������</td>
									<td class="bg_white">�Աݾ�</td>
									<td class="bg_white">��������</td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">ȫ�浿</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_useinfo.jsp', 'userview', 'width=530,height=540,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- �Ϸ� --></td>
									<td class="bg_white">����</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_accountinfo.jsp', 'payview', 'width=520,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"></a><!-- �����Ϸ� --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">ȫ�浿</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- ���Է� --></td>
									<td class="bg_white">���</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"></a><!-- �����Ϸ� --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" height="26">ȫ�浿</td>
									<td class="bg_white">780116-1234567</td>
									<td class="bg_white"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- ���Է� --></td>
									<td class="bg_white">����</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white rpad_10" align="right">405,000</td>
									<td class="bg_white"><a href="javascript:alert('���� ���μ��� �̵�');"><img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif"></a><!-- �̳� --></td>
								</tr>
								</table>
								<!-- ����`����`���������� / -->

								<!-- / �ϴܹ�ư -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:14px;">
								<tr><td height="1" colspan="2" class="line_dg"></td></tr>
								<tr><td height="13" colspan="2"></td></tr>
								<tr>
									<td><a href="reservation_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_listgo.gif"></a><!-- ������� --></td>
									<td align="right"><a href="reservation_02.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_account.gif" class="btn"></a><!-- �����ϱ� --><a href="javascript:alert('���� ��� ���μ��� �̵�');"><img src="<%=imageServer%>/tour_img/btn/btn_resercancel.gif" class="btn"></a><!-- ������� --><a href="javascript:;" onclick="window.open ('popup_reservation_ticket.jsp', 'movieview', 'width=518,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_ticketview.gif"></a><!-- ����Ƽ�Ϻ��� --></td>
								</tr>
								</table>
								<!-- �ϴܹ�ư / -->

							</td>
							<td width="160" style="padding-top:25px;">
								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_sky3">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_01.gif"></td></tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:12 5 7 11px;"><strong>1) �ּ�</strong>: ��/��, ��/��, ��/��<br>���� Ȯ���ϸ�, �ֹε����<br>�� �������� �����Ͽ� Ʋ��<br>��� ������ �ΰ��˴ϴ�.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 0 11px;"><strong>2) ����/����</strong>: ��ǰ� �ٸ� ��� ������ �ΰ��Ǹ�,<br>�ݵ�� ����ƻ� ����ڿ�<br>��ȭ�Ͽ� Ȯ�� �����ñ�<br>�ٶ��ϴ�.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 2 11px;">(�� ����ƻ� ������ �̼���<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 02-3669-3724)</td>
								</tr>
								<tr>
									<td style="padding:0 5 10 11px;">
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td colspan="3" class="txt_dblue fs11 lh13" style="padding:5 0 7 0px;">--------- ���� ---------</td>
										</tr>
										<tr valign="top">
											<td width="6"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td width="37" class="txt_dblue fs11 lh13">��   ��:</td>
											<td class="txt_dblue fs11 lh13">����� �ֺ�,<br>������ ����</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">�ڿ���:</td>
											<td class="txt_dblue fs11 lh13">����� ��ȣ,<br>������ ��ǥ.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">��   ��:</td>
											<td class="txt_dblue fs11 lh13">����� �л�,<br>������ ����.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">���л�:</td>
											<td class="txt_dblue fs11 lh13">����� OO���б�<br>������ �л�</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0"><tr><td height="10"></td></tr></table>

								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_lbrown">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_02.gif"></td></tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:12 5 7 11px;"><strong>������ ��</strong>: (��110-793)<br>����� ���α� �赿 1410-2<br>������� �¶��� ����� ��</td>
								</tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:0 5 10 11px;">(���� �޸鿡 �ֹε�Ϲ�ȣ��<br>������ �������� �����ֽñ�<br>�ٶ��ϴ�.)</td>
								</table>
							</td>
						</tr>
						</table>
						<!-- list table / -->
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
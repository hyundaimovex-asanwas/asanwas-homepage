<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
  String pageNum = "2";
  String McNum = "1";
  String sub = "2";  
%>
<html>
<head>
<title> �ݰ������      </title>
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
        <%@ include file="../include/preview/tour_preview_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../include/preview/tour_preview_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview02.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">�ݰ��� �˾ƺ���</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">������ ����</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/preview/txt_top_preview02.gif"></td></tr>
				<tr><td height="54"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="234"><img src="<%=imageServer%>/tour_img/preview/img_history01.jpg" width="215" height="117"></td>
							<td width="456"><img src="<%=imageServer%>/tour_img/preview/txt_history01.gif" style="margin-top:3px;"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/preview/img_history02.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/preview/txt_history02.gif" style="margin-top:14px;"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/preview/img_history03.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/preview/txt_history03.gif" style="margin-top:14px;"></td>
						</tr>
						<tr><td colspan="2" height="45"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="426">
								<table width="420" cellpadding="0" cellspacing="0" border="0">
								<tr><td colspan="5"><img src="<%=imageServer%>/tour_img/preview/txt_history00.gif"></td></tr>
								<tr><td colspan="5" height="45"></td></tr>
								<tr valign="top">
								  <td rowspan="2"><img src="<%=imageServer%>/tour_img/preview/2008.gif"></td>
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>05.28</strong></td>
								  <td>�ݰ��������(�Ƴ�Ƽ) �׷��� ����</td>
								  </tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>03.17</strong></td>
									<td>�ݰ��� �¿��� �������� </td>
								</tr>
								<tr valign="top">
								  <td rowspan="5"><img src="<%=imageServer%>/tour_img/preview/2007.gif"></td>
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>12.05</strong></td>
								  <td>�������� ���� </td>
								  </tr>
								<tr valign="top">
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>10.04</strong></td>
								  <td>��������ȸ��</td>
								  </tr>
								<tr valign="top">
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>06.01</strong></td>
								  <td>���ݰ� ���� ���� </td>
								  </tr>
								<tr valign="top">
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>05.28</strong></td>
								  <td>�������� �ݰ��� �鼼�� �׷��� ���� </td>
								  </tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>04.13</strong></td>
									<td>�ݰ��� �ý�(��Ÿ���� 1��) ���� ���� </td>
								</tr>
								<tr valign="top">
								  <td width="95" rowspan="5"><img src="<%=imageServer%>/tour_img/preview/2006.gif"></td>
								  <td width="1" rowspan="5" bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>09.14</strong></td>
								  <td>�ݰ������ �װ��̿� �ǽ�<br>
								    -�����װ� MOU ü�� </td>
								  </tr>
								<tr valign="top">
								  <td></td>
								  <td><strong>08.04</strong></td>
								  <td>������ ȸ��� �߸�����ȸ ���� </td>
								  </tr>
								<tr valign="top">
									<td width="22"></td>
									<td width="62"><strong>07.17</strong></td>
									<td width="240">ȭ�����ƻ��ް��, �ܱݰ�ȣ�� ����</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>05.27</strong></td>
									<td>���ݰ� �����ڽ� ���</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>04.28</strong></td>
									<td>�� 24ȸ MBC â�۵�����</td>
								</tr>
								<tr valign="top">
									<td rowspan="7"><img src="<%=imageServer%>/tour_img/preview/2005.gif"></td>
									<td rowspan="7" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>10.04</strong></td>
									<td>�� 86ȸ �������ü�� ��ȭäȭ</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>09.01</strong></td>
									<td>������, ��ġȣ��, ���������� ����</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>08.31</strong></td>
									<td>�̻갡����ȸ�� ����</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>07.17</strong></td>
									<td>������ ȸ�� ������ ���������� ���</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>06.08</strong></td>
									<td>���ݰ������ 100���� ���ġ� ��� ��������ȸ</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>04.01</strong></td>
									<td>���� ��ȥ�κ� �����ɱ� ���</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>02</strong></td>
									<td>��ȭ ����ū������ �Կ�</td>
								</tr>
								<tr valign="top">
									<td rowspan="4"><img src="<%=imageServer%>/tour_img/preview/2004.gif"></td>
									<td rowspan="4" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>11.20</strong></td>
									<td>�Ű�� ����� ����</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>11.19</strong></td>
									<td>�ݰ�������� ����</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>09.07</strong></td>
									<td>�������ü�� ��ȭ äȭ</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>07.02</strong></td>
									<td>�ݰ���ȣ�� ����</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td><img src="<%=imageServer%>/tour_img/preview/2003.gif"></td>
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td style="padding-top:7px;"><strong>09</strong></td>
									<td style="padding-top:7px;">�ݰ��� ���ΰ��� �ǽ�</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td><img src="<%=imageServer%>/tour_img/preview/2002.gif"></td>
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td style="padding-top:7px;"><strong>04~����</strong></td>
									<td style="padding-top:7px;">�� 4�� - 14�� ���� �̻갡�� ������</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td><img src="<%=imageServer%>/tour_img/preview/2001.gif"></td>
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td style="padding-top:7px;"><strong>08.14</strong></td>
									<td style="padding-top:7px;">�������ͻ���Ŭ ��� ��ȸ</td>
								</tr>
								<tr valign="top">
									<td rowspan="4"><img src="<%=imageServer%>/tour_img/preview/2000.gif"></td>
									<td rowspan="4" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>09.30</strong></td>
									<td>������ ���������� �ݰ��� �湮</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>06.15</strong></td>
									<td>���� ����ȸ��</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>05.24</strong></td>
									<td>���׺ε� �ذ�</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>05.08</strong></td>
									<td>�̽��ڸ��� ���ߴ�ȸ</td>
								</tr>
								<tr valign="top">
									<td rowspan="3"><img src="<%=imageServer%>/tour_img/preview/1998.gif"></td>
									<td rowspan="3" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>11.18</strong></td>
									<td>���� �ݰ�ȣ ù ����</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>10.30</strong></td>
									<td>���ֿ� ��ȸ�� ������ ���������� ���</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>06.16</strong></td>
									<td>���ֿ� ��ȸ�� �Ҷ����� ���</td>
								</tr>
								<tr valign="top">
									<td rowspan="2"><img src="<%=imageServer%>/tour_img/preview/1989.gif"></td>
									<td rowspan="2" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>01.31</strong></td>
									<td>�ݰ���������� ������ ü��(���)</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>01.24</strong></td>
									<td>���ֿ� ��ȸ�� ù ���/�ݰ������ ��<br>�ú����� �������������� ü��</td>
								</tr>
								</table>
							</td>
							<td width="264"><!-- �ݰ��������̶���Ʈ flash -->
								<script language="javascript">
									f_id = "highlight";//�÷��� ���̵�
									f_name ="<%=imageServer%>/tour_swf/highlight.swf"; //�÷��� ���ϸ�
									f_width = "264";//����ũ��
									f_height ="265"; //���γ���
									f_trans =""; //����, transparent(����)
									f_para =""; //�Ķ����
									show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
								</script></td>
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
<%-- 
  - �ۼ���: �̼ҿ�
  - ����: 2006.07
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>�ٿ�ε�
--%>
<%@ page contentType="text/html;charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
String pageNum = "4";
String McNum = "6";
String sub = "4";
%> 
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="javascript">
 function savePds(val) {
     location.href="download.jsp?file="+val;
 }
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/center/tour_center_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/center/tour_center_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/customer/tit_cus03.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">������</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">�ٿ�ε�</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus03.jpg"></td></tr>
				<tr>
					<td valign="top">
						<!-- / download  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr>
							<td width="232"><img src="<%=imageServer%>/tour_img/customer/desc_cus03_01.jpg"></td>
							<td width="458">
								<table width="458" cellpadding="0" cellspacing="0" border="0">
								<tr class="tpad_3">
									<td width="10"><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td width="298">�ݰ��� ���� �ȳ��� ( PDF ���� )</td>
									<td width="55"><img src="<%=imageServer%>/tour_img/customer/arw_download.gif"></td>
									<td width="95"><a href="javascript:savePds('�ݰ�������ȳ���.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/customer/desc_cus03_02.jpg"></td>
							<td>
								<table width="458" cellpadding="0" cellspacing="0" border="0">
								<tr class="tpad_3">
									<td width="10"><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td width="298">�ݰ������   ���� ( jpg �̹��� ���� )</td>
									<td width="55" rowspan="3"><img src="<%=imageServer%>/tour_img/customer/arw_download.gif"></td>
									<td width="95"><a href="javascript:savePds('�ݰ����������.jpg')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></td>
								</tr>
								<tr class="tpad_3">
									<td><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td>�ݰ��� ������� ( jpg �̹��� ���� )</td>
									<td><a href="javascript:savePds('�ݰ���������.jpg')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif" vspace="1"></a></td>
								</tr>
								<tr class="tpad_3">
									<td><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td>���װ� ������ ( jpg �̹��� ���� )</td>
									<td><a href="javascript:savePds('���װ�������.jpg')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/customer/desc_cus03_03.jpg"></td>
							<td>
								<table width="458" cellpadding="0" cellspacing="0" border="0">
								<tr class="tpad_3">
									<td width="10"><p><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></p>
								    <p><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></p></td>
									<td width="298"><p>�ݰ��� ���� ǥ�� ��� ( PDF ���� )</p>
								    <p>�ݰ��� ���� �����ں��� ( PDF ���� )</p></td>
									<td width="55" rowspan="3"><p><img src="<%=imageServer%>/tour_img/customer/arw_download.gif"></p>								    </td>
									<td width="95"><p><a href="javascript:savePds('�ݰ������ǥ�ؾ��.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></p>
								    <p><a href="javascript:savePds('�����ں���.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></p></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						</table>
						<!-- download / -->
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
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
String McNum = "0";
String sub = "0";
String pageNum = "2";
String subNum = "4";
%>
<%
    String dateview = ParamUtil.getReqParameter(request.getParameter("dateview"),"1");
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
						<td height="54"><img src="<%=imageServer%>/tour_img/tour/tit_tour24.gif"><img src="<%=imageServer%>/tour_img/tour/tit_tour02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">��������</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">��������</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" lass="linemap_margin2"><span class="linemap_now">��������</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/tour/txt_tour21.gif"></td></tr>
				<tr><td height="63"></td></tr>
				<tr>
					<td>
						<!-- / �Ǹ޴� -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
					                     <td width="92" height="28"><%if(dateview.equals("1")){%><img src="<%=imageServer%>/tour_img/tour/tab_part01_on.gif"><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/tour_img/tour/tab_part01.gif"></a><%}%></td>
							<td width="92"><%if(dateview.equals("2")){%><img src="<%=imageServer%>/tour_img/tour/tab_part02_on.gif"><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/tour_img/tour/tab_part02.gif"></a><%}%></td>
							<td width="92"><%if(dateview.equals("3")){%><img src="<%=imageServer%>/tour_img/tour/tab_part03_on.gif"><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/tour_img/tour/tab_part03.gif"></a><%}%></td>
							<td width="1"><img src="<%=imageServer%>/tour_img/tour/tab_part_l.gif"></td>
							<td width="411" background="<%=imageServer%>/tour_img/tour/tab_part00.gif"></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/tour/tab_part_r.gif"></td>
						</tr>
						</table>
						<!-- �Ǹ޴� / -->
					</td>
				</tr>
				<tr>
					<td valign="top">

						<!-- / ǥ1 -->
<div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="51" class="txt_dblue lpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" style="margin:0 5 2 0px;"><strong>����/�ڿ��ڽ� (���� �����ó�/ ���� �հǿո�,���οո�) </strong></td>
						</tr>
						</table>
						<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
						<tr align="center">
							<td width="75" class="bg_white" height="26">����</td>
							<td width="105" class="bg_white" height="26">�ð�</td>
							<td width="135" class="bg_white">��� �� ����</td>
							<td width="375" class="bg_white">����</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">����</td>
							<td class="bg_white" align="center">05:30</td>
							<td class="bg_white lpad_20">�溹�� ������</td>
							<td class="bg_white lpad_20">���� �� ����غ�</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">06:00</td>
							<td class="bg_white lpad_20">����~���� CIQ</td>
							<td class="bg_white lpad_20">���� CIQ�� �̵�</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:10~07:50</td>
							<td class="bg_white lpad_20">���� CIQ</td>
							<td class="bg_white lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:50~08:10</td>
							<td class="bg_white lpad_20">��������</td>
							<td class="bg_white lpad_20">������ ���(08:00)</td>
						</tr>
						<tr>
							<td class="bg_lgray" height="26" align="center" rowspan="3">����</td>
							<td class="bg_lgray" align="center">08:10~08:50</td>
							<td class="bg_lgray lpad_20">���� CIQ</td>
							<td class="bg_lgray lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">08:50~16:40</td>
							<td class="bg_lgray lpad_20">��������</td>
							<td class="bg_lgray lpad_20">���� ���� �� �߽�<br>* ����ڹ���-���ױ�-�߽�-�ڿ�����</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">16:40~17:20</td>
							<td class="bg_lgray lpad_20">���� CIQ</td>
							<td class="bg_lgray lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">����</td>
							<td class="bg_white" align="center">17:20~17:40</td>
							<td class="bg_white lpad_20">��������</td>
							<td class="bg_white lpad_20">������ ��� (17:30)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">17:40~18:20</td>
							<td class="bg_white lpad_20">���� CIQ</td>
							<td class="bg_white lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">18:20~</td>
							<td class="bg_white lpad_20"></td>
							<td class="bg_white lpad_20">���� �̵� �� �ػ�</td>
						</tr>
						</table>
						<table cellpadding="0" cellspacing="0" border="0" class="tpad_20 lpad_15">
						<tr>
							<td>- ���� �� �ð��� ���� ������ ���� ���� �� �� �ֽ��ϴ�.<br><span class="txt_dblue b">- ��� �����ڽ��� 2005�� 8���� �ǽ��� �ù������� �������� ������ ���Դϴ�.</span></td>
						</tr>
						</table>
</div>
						<!-- ǥ1 / -->

						<!-- / ǥ2 -->
<div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="51" class="txt_dblue lpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" style="margin:0 5 2 0px;"><strong>����/�ո��ڽ� (���� �����ó�/ ���� �հǿո�,���οո�) </strong></td>
						</tr>
						</table>
						<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
						<tr align="center">
							<td width="75" class="bg_white" height="26">����</td>
							<td width="105" class="bg_white" height="26">�ð�</td>
							<td width="135" class="bg_white">��� �� ����</td>
							<td width="375" class="bg_white">����</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">����</td>
							<td class="bg_white" align="center">05:30</td>
							<td class="bg_white lpad_20">�溹�� ������</td>
							<td class="bg_white lpad_20">���� �� ����غ�</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">06:00</td>
							<td class="bg_white lpad_20">����~���� CIQ</td>
							<td class="bg_white lpad_20">���� CIQ�� �̵�</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:10~07:50</td>
							<td class="bg_white lpad_20">���� CIQ</td>
							<td class="bg_white lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:50~08:10</td>
							<td class="bg_white lpad_20">��������</td>
							<td class="bg_white lpad_20">������ ���(08:00)</td>
						</tr>
						<tr>
							<td class="bg_lgray" height="26" align="center" rowspan="3">����</td>
							<td class="bg_lgray" align="center">08:10~08:50</td>
							<td class="bg_lgray lpad_20">���� CIQ</td>
							<td class="bg_lgray lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">08:50~16:40</td>
							<td class="bg_lgray lpad_20">��������</td>
							<td class="bg_lgray lpad_20">���� ���� �� �߽�<br>* ����ڹ���-���ױ�-���缭��-�߽�-�ڿ�����-������������</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">16:40~17:20</td>
							<td class="bg_lgray lpad_20">���� CIQ</td>
							<td class="bg_lgray lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">����</td>
							<td class="bg_white" align="center">17:20~17:40</td>
							<td class="bg_white lpad_20">��������</td>
							<td class="bg_white lpad_20">������ ��� (17:30)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">17:40~18:20</td>
							<td class="bg_white lpad_20">���� CIQ</td>
							<td class="bg_white lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">18:20~</td>
							<td class="bg_white lpad_20"></td>
							<td class="bg_white lpad_20">���� �̵� �� �ػ�</td>
						</tr>
						</table>
						<table cellpadding="0" cellspacing="0" border="0" class="tpad_20 lpad_15">
						<tr>
							<td>- ���� �� �ð��� ���� ������ ���� ���� �� �� �ֽ��ϴ�.<br><span class="txt_dblue b">- ��� �����ڽ��� 2005�� 8���� �ǽ��� �ù������� �������� ������ ���Դϴ�.</span></td>
						</tr>
						</table>
</div>
						<!-- ǥ2 / -->

						<!-- / ǥ3 -->
<div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="51" class="txt_dblue lpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" style="margin:0 5 2 0px;"><strong>����/�����ڽ� (���� ����� / ���� �����ó�) </strong></td>
						</tr>
						</table>
						<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
						<tr align="center">
							<td width="75" class="bg_white" height="26">����</td>
							<td width="105" class="bg_white" height="26">�ð�</td>
							<td width="135" class="bg_white">��� �� ����</td>
							<td width="375" class="bg_white">����</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">����</td>
							<td class="bg_white" align="center">05:30</td>
							<td class="bg_white lpad_20">�溹�� ������</td>
							<td class="bg_white lpad_20">���� �� ����غ�</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">06:00</td>
							<td class="bg_white lpad_20">����~���� CIQ</td>
							<td class="bg_white lpad_20">���� CIQ�� �̵�(������ �ްԼ� ����)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:10~07:50</td>
							<td class="bg_white lpad_20">���� CIQ</td>
							<td class="bg_white lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">07:50~08:10</td>
							<td class="bg_white lpad_20">��������</td>
							<td class="bg_white lpad_20">������ ���(08:00)</td>
						</tr>
						<tr>
							<td class="bg_lgray" height="26" align="center" rowspan="3">����</td>
							<td class="bg_lgray" align="center">08:10~08:50</td>
							<td class="bg_lgray lpad_20">���� CIQ</td>
							<td class="bg_lgray lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">08:50~16:40</td>
							<td class="bg_lgray lpad_20">��������</td>
							<td class="bg_lgray lpad_20">���� ���� �� �߽�<br>* �����-�߽�-���缭��-���ױ�-����ڹ���-������������</td>
						</tr>
						<tr>
							<td class="bg_lgray" align="center">16:40~17:20</td>
							<td class="bg_lgray lpad_20">���� CIQ</td>
							<td class="bg_lgray lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" height="26" align="center" rowspan="4">����</td>
							<td class="bg_white" align="center">17:20~17:40</td>
							<td class="bg_white lpad_20">��������</td>
							<td class="bg_white lpad_20">������ ��� (17:30)</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">17:40~18:20</td>
							<td class="bg_white lpad_20">���� CIQ</td>
							<td class="bg_white lpad_20">���� ���� ����</td>
						</tr>
						<tr>
							<td class="bg_white" align="center">18:20~</td>
							<td class="bg_white lpad_20"></td>
							<td class="bg_white lpad_20">���� �̵� �� �ػ�</td>
						</tr>
						</table>
						<table cellpadding="0" cellspacing="0" border="0" class="tpad_20 lpad_15">
						<tr>
							<td>- ���� �� �ð��� ���� ������ ���� ���� �� �� �ֽ��ϴ�.<br><span class="txt_dblue b">- ��� �����ڽ��� 2005�� 8���� �ǽ��� �ù������� �������� ������ ���Դϴ�.</span></td>
						</tr>
						</table>
</div>
						<!-- ǥ3 / -->

						
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
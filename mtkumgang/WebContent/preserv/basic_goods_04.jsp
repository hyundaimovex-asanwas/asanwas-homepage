<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%
  String McNum = "2";
  String sub = "2"; 
  String pageNum = "2";
  String subNum = "5";
%>
<%
    String dateview = ParamUtil.getReqParameter(request.getParameter("dateview"),"1");
%>
<html>
<head>
<title> �ݰ������  </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/maplink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
		    <%@ include file="../include/reservation/tour_reservation_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app24.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app02.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">����ȳ�</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">�⺻��ǰ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">����</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td colspan="2" height="22"></td></tr>
				<tr>
					<td colspan="2">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/apply/top_txt_app24.gif" style="margin-top:12px;"></td>
							<td align="right"><img src="<%=imageServer%>/tour_img/apply/img_top_app03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="8"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="41" valign="top"><img src="<%=imageServer%>/tour_img/apply/sstit_app224.gif"></td></tr>
						<tr>
							<td valign="top" height="308"><img src="<%=imageServer%>/tour_img/apply/img_basic04.jpg" width="269" height="308"></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td height="41" colspan="4" valign="top" align="right"></td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="2"></td></tr>
						<tr>
							<td height="29" colspan="3" width="97"><img src="<%=imageServer%>/tour_img/apply/txt_order01.gif"><!-- ����� --></td>
							<td width="293">����</td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order02.gif"><!-- ����Ⱓ --></td>
							<td><strong>����</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="202" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- ��ǰ�Ұ� --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							<td>�Ѱ����� �޷����� �ݰ���. ����̳� �غ��̳���? �ݰ����� �����⿡�� �Ϸ�� �����մϴ�.<br><br>��ħ�� ���濬�� ������ �ݰ����� ����� ���� ����, �ϳ��� ��� ���� �⸥ �԰Ÿ��� �踦 ä���, �������� ��ġ�� ���� ��� ���ƿ����� ��ƶ�� �ƽ����� ���� �߾�Ÿ��� ���ϳ� �þ���� �����ϰ� �˴ϴ�.<br>�ݰ����� �߾��� ���� ���� ���ǰ�� ǰ�� �����ϰ� �������� ���ư��Ŵٸ� �������Գ� �ڽ��ְ� �ݰ��������� �ڶ��Ͻ� �� ���� ���Դϴ�.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- ���� --></td>
							<td><span class="txt_orange b">120,000�� ~ 170,000��</span>&nbsp;&nbsp;���߼����� ���� �Ž�</td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="20"></td></tr>
						<tr><td colspan="4" align="right"><a href="http://www.mtkumgang.com/reservation/price/price_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_detailprice.gif" border="0" class="btn"></a></td></tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="14"></td></tr>
				<tr>
					<td colspan="2">
						<!-- / �������� -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_app0302.gif" name="01"></td></tr>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif"><img src="<%=imageServer%>/tour_img/apply/tab_date003.gif"></td>
						</tr>
						<tr><td height="20"></td></tr>
						<tr>
							<td>
								<!-- / ǥ1 -->
								<div id="dateview1" style="display:show;">	
								
                          <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                            <tr align="center"> 
                              <td width="20%" class="bg_white" height="26">�ð�</td>
                              <td width="50%" class="bg_white">��������</td>
                              <td width="30%" class="bg_white">���</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">06:00</td>
                              <td class="bg_white lpad_20">������(ȭ���� �ƻ� �ްԼ�) ����</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">07:00</td>
                              <td class="bg_white lpad_20">�߱� �� ������ ���</td>
                              <td class="bg_white lpad_20">������ ����</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">07:20</td>
                              <td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">08:15</td>
                              <td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="37">09:00 
                                ~ 13:30</td>
                              <td class="bg_white lpad_20">���濬 �Ǵ� ������ �ڽ� ����<br>
                                �߽� �� ���� �ð�</td>
                              <td class="bg_white lpad_20">����</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">14:00 
                                ~ 16:00</td>
                              <td class="bg_white lpad_20">��õ �Ǵ� ���� ������(���ɽ�)</td>
                              <td class="bg_white lpad_20">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:00</td>
                              <td class="bg_white lpad_20">������ ���</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:25</td>
                              <td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">16:55</td>
                              <td class="bg_white lpad_20">���� ���Ի繫�� ���</td>
                              <td class="bg_white lpad_20">����а輱 ���</td>
                            </tr>
                            <tr> 
                              <td class="bg_white" align="center" height="26">17:10</td>
                              <td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
                              <td class="bg_white lpad_20"></td>
                            </tr>
                          </table>
								</div>
								<!-- ǥ1 / -->

							</td>
						</tr>
						<tr><td height="31" valign="bottom" class="txt_orange2 fs11 lpad_10"><table cellpadding="0" cellspacing="0">
             <tr>
              <td width="483" height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">�� 
               ��� ������ ���� ������ ���Ͽ� ����� �� �ֽ��ϴ�.</td>
              <td width="207" height="35" align="right" valign="bottom" class="txt_orange2 fs11 lpad_10"><a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print05.jsp','','scrollbars=yes,width=702,height=600')"><img src="<%=imageServer%>/tour_img/btn/btn_plan_viw.gif" width="80" height="27" border="0"></a></td>
             </tr>
            </table></td>
						</tr>
						</table>
						<!-- �������� / -->
					</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/img_tip_order2.gif"></td></tr>
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
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%> 
<%@ page import="kr.co.imjk.board.dao.TourProductReview"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
  String McNum = "2";
  String sub = "3";
  String pageNum = "3";
  String subNum = "2";
%>
<%
  String reviewType = "02"; //����ü�����
  String returnUrl = "order_goods_02.jsp"; 
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
<script language="javascript">
function chk(){
	var obj = document.f1;
	var uid = "<%=session_id%>";

	if(uid == ""){
		//alert("�α����� �ʿ��� �����Դϴ�.");
		popLogin();
		return;
	}	

	if(obj.content.value == "" || obj.content.value =="�ǰ��� 500�� �̳��� ��� �� �� ������ �α��� �� �̿��Ͻñ� �ٶ��ϴ�."){
		alert("������ �Է��ϼ���.");
		obj.content.value="";
		obj.content.focus();
		return;
	}

	obj.cmd.value = "insert";

	obj.submit();
}

function del(idx){
	if(confirm("�����Ͻðڽ��ϱ�?")){
		var obj = document.f1;
		obj.board_seq.value = idx;
		obj.cmd.value = "del";

		obj.submit();
	}
}

function clearText(thefield){
    if (thefield.defaultValue==thefield.value)
        thefield.value = ""
}


function popLogin() {
   var winOpts="width=370,height=320,scrollbars=no";
   var url = "/member/pop_login.jsp";
   window.open(url,"LoginCheck",winOpts);
}
 
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app32.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app05.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">����ȳ�</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">�����ǰ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">����ü�����</span></td>
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
							<td><img src="<%=imageServer%>/tour_img/apply/top_txt_app32.gif" style="margin-top:12px;"></td>
							<td align="right"><img src="<%=imageServer%>/tour_img/apply/img_top_app03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="8"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="29"><img src="<%=imageServer%>/tour_img/apply/stit_app0301.gif"></td></tr>
						<tr>
							<td valign="top" height="261"><img src="<%=imageServer%>/tour_img/apply/img_order21.jpg" width="269" height="246" id="limg"></td>
						</tr>
						<tr>
							<td><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/img_order21.jpg'"><img src="<%=imageServer%>/tour_img/apply/img_order_s21.jpg" width="83" height="48"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/img_order22.jpg'"><img src="<%=imageServer%>/tour_img/apply/img_order_s22.jpg" width="83" height="48" style="margin-left:10px;"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/img_order23.jpg'"><img src="<%=imageServer%>/tour_img/apply/img_order_s23.jpg" width="83" height="48" style="margin-left:10px;"></a></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td height="29" colspan="4" valign="top" align="right"><a href="#01"><img src="<%=imageServer%>/tour_img/apply/tab_order01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order01.gif'" class="btn"></a><a href="#03"><img src="<%=imageServer%>/tour_img/apply/tab_order03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order03.gif'"></a></td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="2"></td></tr>
						<tr>
							<td height="29" colspan="3" width="97"><img src="<%=imageServer%>/tour_img/apply/txt_order01.gif"><!-- ����� --></td>
							<td width="293">����</td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order02.gif"><!-- ����Ⱓ --></td>
							<td><strong>2�� 3��</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="202" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- ��ǰ�Ұ� --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							<td>���Ϻд� 50�� �������� ���̵� �޶��� �츮. ���θ� �˾� ������ ������ �غ��ؾ� �ϴ� ���������� ����ִ� ����ü��� ������ �����մϴ�.<br>����ü������� ������ ���ϸ��� �ݰ��꿡�� ������ ��ȭ�� ����� ü���ϰ� ��� �� �ִ� ���α׷����� �����Ǿ����ϴ�.<br>���������� ���� �������ĵ� ������, ���� ������ �ڿ����� ��ȭ�� ���������. ��, �������� ��ȭ�� ����� �������ֽñ� �ٶ��ϴ�.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- ���� --></td>
							<td><span class="txt_orange b">290,000�� ~ 650,000��</span>&nbsp;&nbsp;���߼����� ���� �Ž�</td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="20"></td></tr>
						<!--<tr><td colspan="4" align="right"><a href="javascript:;" onclick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/btn/btn_app_date.gif" class="btn"></a></td></tr>-->
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
							<td><%if(dateview.equals("1")){%><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/tour_img/apply/tab_date01.gif" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/tour_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/tour_img/apply/tab_date02.gif" ></a><%}%><%if(dateview.equals("3")){%><img src="<%=imageServer%>/tour_img/apply/tab_date03_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/tour_img/apply/tab_date03.gif" ></a><%}%><img src="<%=imageServer%>/tour_img/apply/tab_date00.gif"></td>
						</tr>
						<tr><td height="20"></td></tr>
						<tr>
							<td>
								
								<!-- / ǥ1 -->
<div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">�ð�</td>
									<td width="50%" class="bg_white lpad_20">��������</td>
									<td width="30%" class="bg_white lpad_20">���</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:00</td>
									<td class="bg_white lpad_20">������(ȭ���� �ƻ� �ްԼ�) ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:10</td>
									<td class="bg_white lpad_20">�߽� �� �߱�</td>
									<td class="bg_white lpad_20">������ ����</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">14:00</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">15:00</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:00</td>
									<td class="bg_white lpad_20">���� üũ��</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:30</td>
									<td class="bg_white lpad_20">�ݰ������ Ư�� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">18:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">19:00</td>
									<td class="bg_white lpad_20">��õ(������)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">21:00</td>
									<td class="bg_white lpad_20">�ݰ��꿹������ �������� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- ǥ1 / -->


								<!-- / ǥ2 -->
<div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">�ð�</td>
									<td width="50%" class="bg_white lpad_20">��������</td>
									<td width="30%" class="bg_white lpad_20">���</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">07:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">08:30</td>
									<td class="bg_white lpad_20">���濬 �ڽ� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:30</td>
									<td class="bg_white lpad_20">����� �߽�</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">13:30</td>
									<td class="bg_white lpad_20">������ ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:30</td>
									<td class="bg_white lpad_20">�������� ����(�Ϲݼ�)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">18:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">19:00~</td>
									<td class="bg_white lpad_20">�ݰ��� ����Ʈ������<br>(ȣ��&����, �뷡��, �߿ܹٺ�ť ��)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- ǥ2 / -->

								<!-- / ǥ3 -->
<div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">�ð�</td>
									<td width="50%" class="bg_white lpad_20">��������</td>
									<td width="30%" class="bg_white lpad_20">���</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">07:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">08:00</td>
									<td class="bg_white lpad_20">������ �ڽ� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">11:30</td>
									<td class="bg_white lpad_20">������ �߽�</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:30</td>
									<td class="bg_white lpad_20">������ ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:45</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ���� �� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">13:45</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ���� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- ǥ3 / -->



							</td>
						</tr>
						<tr><td height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">�� ��� ������ ���� ������ ���Ͽ� ����� �� �ֽ��ϴ�.</td></tr>
						</table>
						<!-- �������� / -->
					</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/img_tip_order.gif"></td></tr>
				<tr><td colspan="2" height="30"></td></tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / ��ǰ�̿��ı� -->
                                                                <%@ include file="order_goods_review.jsp" %>
                                                                <!-- / ��ǰ�̿��ı� -->
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
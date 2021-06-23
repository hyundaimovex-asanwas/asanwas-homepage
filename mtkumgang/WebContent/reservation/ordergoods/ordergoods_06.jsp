<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>  
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourProductReview"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//���� ����
int board_seq			= 0;
int ref_no				= 0; 
int level_no			= 0;
int sort_no				= 0;
int read_num			= 0;
String title			= ""; 
String content			= "";
String user_nick		= "";
String use_yn			= "";
String user_level		= "";
int board_top_no		= 0;
String user_id			= "";
String user_name    	= "";

int pageSize			= 10;
int blockSize			= 10;

String McNum = "2";
String sub = "3";
String pageNum = "3";
String subNum = "6";

//�Խ��� Ÿ�԰���
String boardType		= "11";

// DB���� ��ü(ibatis���)  
TourProductReview dao = new TourProductReview();
CommonBoard commonDao = new CommonBoard();

String part ="";
String keyword ="";
String key_str = "";

//��û�� ������ �ѹ�
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getList(requestedPage, pageSize);

// ��ü �Խù� ��
int allCount = commonDao.getTotalCount(boardType, part,keyword);
// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
%>
<html>
<head>
<title> �ݰ������      </title>
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
		alert("�α����� �ʿ��� �����Դϴ�.");
		return;
	}	

	if(obj.content.value == ""){
		alert("������ �Է��ϼ���.");
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
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/reservation/tour_reservation_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app36.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app05.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">����ȳ�</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">�����ǰ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">�������/��ũ��</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td colspan="2" height="22"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/top_txt_app05.gif"></td></tr>
				<tr><td colspan="2" height="56"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="29"><img src="<%=imageServer%>/tour_img/apply/stit_app0301.gif"></td></tr>
						<tr>
							<td valign="top" height="261"><img src="<%=imageServer%>/tour_img/apply/_temp_limg01.gif" width="269" height="246" id="limg"></td>
						</tr>
						<tr>
							<td><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/_temp_limg01.gif'"><img src="<%=imageServer%>/tour_img/apply/_temp_simg01.gif" width="83" height="48"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/_temp_limg02.gif'"><img src="<%=imageServer%>/tour_img/apply/_temp_simg02.gif" width="83" height="48" style="margin-left:10px;"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/_temp_limg03.gif'"><img src="<%=imageServer%>/tour_img/apply/_temp_simg03.gif" width="83" height="48" style="margin-left:10px;"></a></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td height="29" colspan="4" valign="top" align="right"><a href="#01"><img src="<%=imageServer%>/tour_img/apply/tab_order01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order01.gif'" class="btn"></a><a href="#02"><img src="<%=imageServer%>/tour_img/apply/tab_order02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order02.gif'" class="btn"></a><a href="#03"><img src="<%=imageServer%>/tour_img/apply/tab_order03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order03.gif'"></a></td>
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
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order05.gif"><!-- �ּ��ο� --></td>
							<td><strong>�ּ� 30���̻�</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="172" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- ��ǰ�Ұ� --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							<td>�ݰ����� ���� ��ġ�� �Ƹ������� ǳ���� ���Ÿ��� ��ü ���� �ü��� �־� ��ü��縦 �ϱ⿡ �ֻ��� ������ ������ �ֽ��ϴ�. ��Ը� ��ȸ���, ���̳�, �����ü��� �غ�Ǿ� �ְ� ũ������ ������ ��縦 ������ ���������� ������ ������ ����մϴ�.�� ��ü�� ���ݿ����� �������� ������ �����մϴ�.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- ���� --></td>
							<td><span class="txt_orange b">290,000�� ~ 650,000��</span>&nbsp;&nbsp;���߼����� ���� �Ž�</td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="20"></td></tr>
						<tr><td colspan="4" align="right"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_app_date.gif" class="btn"></a></td></tr>
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
							<td><a href="javascript:;" onclick="opentab(1);"><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif" id="tabview1"></a><a href="javascript:;" onclick="opentab(2);"><img src="<%=imageServer%>/tour_img/apply/tab_date02.gif" id="tabview2"></a><a href="javascript:;" onclick="opentab(3);"><img src="<%=imageServer%>/tour_img/apply/tab_date03.gif" id="tabview3"></a><img src="<%=imageServer%>/tour_img/apply/tab_date00.gif"></td>
						</tr>
						<tr><td height="20"></td></tr>
						<tr>
							<td>
								<script> // �� �޴� ��ũ��Ʈ
								function opentab(opennum)
								{
									if(opennum == 1){
										tabview1.src = "<%=imageServer%>/tour_img/apply/tab_date01_on.gif";
										tabview2.src = "<%=imageServer%>/tour_img/apply/tab_date02.gif";
										tabview3.src = "<%=imageServer%>/tour_img/apply/tab_date03.gif";
										dateview1.style.display = "block";
										dateview2.style.display = "none";
										dateview3.style.display = "none";
									}
									else if(opennum == 2){
										tabview1.src = "<%=imageServer%>/tour_img/apply/tab_date01.gif";
										tabview2.src = "<%=imageServer%>/tour_img/apply/tab_date02_on.gif";
										tabview3.src = "<%=imageServer%>/tour_img/apply/tab_date03.gif";
										dateview1.style.display = "none";
										dateview2.style.display = "block";
										dateview3.style.display = "none";
									}
									else{
										tabview1.src = "<%=imageServer%>/tour_img/apply/tab_date01.gif";
										tabview2.src = "<%=imageServer%>/tour_img/apply/tab_date02.gif";
										tabview3.src = "<%=imageServer%>/tour_img/apply/tab_date03_on.gif";
										dateview1.style.display = "none";
										dateview2.style.display = "none";
										dateview3.style.display = "block";
									}
								}
							</script>
								<!-- / ǥ1 -->
								<div id="dateview1" style="display:show;">	
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">�ð�</td>
									<td width="50%" class="bg_white lpad_20">��������</td>
									<td width="30%" class="bg_white lpad_20">���</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">08:30</td>
									<td class="bg_white lpad_20">���� ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:00</td>
									<td class="bg_white lpad_20">������(ȭ���� �ƻ� �ްԼ�) ����</td>
									<td class="bg_white lpad_20">������ ����</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:00~13:30</td>
									<td class="bg_white lpad_20">�߽� �� �߱�</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:30~14:00</td>
									<td class="bg_white lpad_20">������ ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:00~14:40</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:45</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:55</td>
									<td class="bg_white lpad_20">MDL ���</td>
									<td class="bg_white lpad_20">����а輱 ���</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">15:00</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ����/����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">15:50</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">15:50~16:50</td>
									<td class="bg_white lpad_20">������ �ڽ� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">17:00</td>
									<td class="bg_white lpad_20">���� üũ��</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">18:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" rowspan="2">19:00~</td>
									<td class="bg_white lpad_20" height="26">�����ð�<br>-��õ(������,������)<br>-�߱����븶����(��,����)<br>-�ݰ��꿹������ ��������(21:00~22:00)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20">�ݰ��� ����Ʈ������<br>(ȣ��&����, �뷡��, �߿ܹٺ�ť ��)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
								</div>
								<!-- ǥ1 / -->


								<!-- / ǥ2 -->
								<div id="dateview2" style="display:none;">
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">�ð�</td>
									<td width="50%" class="bg_white lpad_20">��������</td>
									<td width="30%" class="bg_white lpad_20">���</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">07:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">08:30~16:30</td>
									<td class="bg_white lpad_20">������ �ڽ�����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">16:30~18:00</td>
									<td class="bg_white lpad_20">�������� ����(Ư��,�Ϲݼ�)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:30~16:00</td>
									<td class="bg_white lpad_20">�����ð�<br>�رݰ� �ڽ�����<br>��õ(������,������)<br>�߱����븶����(��,����)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">16:30~18:00</td>
									<td class="bg_white lpad_20">�������� ����(Ư��,�Ϲݼ�)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">18:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" rowspan="2">19:00~</td>
									<td class="bg_white lpad_20" height="26">�����ð�<br>-��õ(������,������)<br>-�߱����븶����(��,����)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20">�ݰ��� ����Ʈ������<br>(ȣ��&����, �뷡��, �߿ܹٺ�ť ��)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
								</div>
								<!-- ǥ2 / -->

								<!-- / ǥ3 -->
								<div id="dateview3" style="display:none;">
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">�ð�</td>
									<td width="50%" class="bg_white lpad_20">��������</td>
									<td width="30%" class="bg_white lpad_20">���</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">07:00</td>
									<td class="bg_white lpad_20">����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">08:00~11:30</td>
									<td class="bg_white lpad_20">�����ð�<br>- ������ �ڽ�����<br>- ���濬 �ڽ�����<br>- ������ �ڽ�����<br>- �ϰ�� : �ؼ�����<br>- ����� : �������</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">11:30~12:30</td>
									<td class="bg_white lpad_20">�߽�</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:30</td>
									<td class="bg_white lpad_20">������ ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:45</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:45~13:30</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ���� �� ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:35</td>
									<td class="bg_white lpad_20">MDL ���</td>
									<td class="bg_white lpad_20">����а輱 ���</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:45</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ���� ����</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:00</td>
									<td class="bg_white lpad_20">���� ���Ի繫�� ���</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">18:00</td>
									<td class="bg_white lpad_20">���� ����</td>
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
					<td colspan="2">
						<!-- / ����TIP -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_app0303.gif" name="02"></td></tr>
						<tr>
							<td class="txt_orange2 lpad_10 rpad_10">������ ���� �� �з� ���� ������<td>
						</tr>
						<tr><td height="20"></td></tr>
						</table>
						<!-- ����TIP / -->
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / ��ǰ�̿��ı� -->
<form method="post" name="f1" action="ordergoods_06_ok.jsp">
<input type="hidden" name="cmd">
<input type="hidden" name="board_seq">
<input type="hidden" name="board_type" value="<%=boardType%>">
<input type="hidden" name="requestedPage" value="<%=requestedPage%>">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td  class="fs11"><img src="<%=imageServer%>/tour_img/apply/stit_app0304.gif" name="03">&nbsp;&nbsp;(��ü���� <span class="txt_green b"><%=allCount%></span>��)</td></tr>
						<tr><td height="10"></td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="reply_bg02">
						<tr>
							<td><textarea name="content" style="width:616px;height:39px;overflow:auto;"></textarea>
							<a href="javascript:chk();"><img src="<%=imageServer%>/tour_img/btn/btn_reply_regis.gif" class="btnl7" align="absmiddle"></a></td>
						</tr>
						</table>
</form>						
						<!-- ��ǰ�̿��ı� / -->

						<!-- / ��۸�� -->
						
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="80" style="padding:0 12 0 12"><col width="1"><col width="560" style="padding:0 10 0 15">
          <% if(record.length <= 0){ %>
						<tr><td colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" colspan="3" align="center">����Ÿ�� �������� �ʽ��ϴ�.</td>
						</tr>
						<tr><td colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
          <%
          }else{
          	//����Ʈ ȭ�鿡 ����
          	for(int i=0;i<record.length; i++){ 
          		Tbrd_board_ma_bean tbean = record[i];
          		
          		board_seq			= tbean.getBoard_seq();
          		ref_no				= tbean.getRef_no(); 
          		level_no			= tbean.getLevel_no(); 
          		sort_no				= tbean.getSort_no(); 
          		read_num			= tbean.getRead_num(); 
          		title				= tbean.getTitle(); 
		        //content				= tbean.getContent();
		        content					= Util.getString(tbean.getContent(),"");
		        //content				= content.replaceAll("\"", "'");
          		use_yn				= tbean.getUse_yn(); 
          		user_level			= tbean.getUser_level(); 
          		board_top_no		= tbean.getBoard_top_no(); 
          		user_id				= tbean.getUser_id();
          		user_name			= tbean.getUser_name();
          		use_yn				= tbean.getUse_yn();
          
          		java.util.Date writeday = tbean.getReg_date();
          		String reg_date_string = tbean.getReg_date_String();
          		String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
          		String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
          %>
						<tr><td class="bg_lgreen" colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" class="bg_lgreen"><strong><%=user_name%></strong><br>(<%=user_id%>)</td>
							<td class="bg_dgray"></td>
							<td class="bg_lgreen">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><%=content%></td>
								</tr>
								<tr>
									<td class="tpad_5"><img src="<%=imageServer%>/tour_img/bu/bu_dgray_rec.gif" align="texttop" vspace="5"> 
									<span class="fs11"><%=reg_date_string%></span>
									<% if(session_id.equals(user_id)){ %>
									<a href="javascript:del('<%=board_seq%>');"><img src="<%=imageServer%>/tour_img/btn/btn_s_delete.gif" align="absmiddle"></a>
									<% } %>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td class="bg_lgreen" colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
          <%
          	}
          }
          
          %>
						</table>
						<!-- ��۸�� / -->

						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="60">
						<tr>
						 <td align="center">
							<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "ordergoods_06.jsp.jsp", "500", key_str ,imageServer+"imjk_img/", blockPerPage)%>
						 </td>
						</tr>
						</table>
						<!-- paging/ -->
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
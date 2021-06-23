<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrevent"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//���� ����
int board_seq= 0;
int ref_no= 0; 
int level_no= 0;
int sort_no= 0;
int read_num= 0;
String title= ""; 
String content= "";
String user_nick= "";
String use_yn= "";
String user_level= "";
int board_top_no= 0;
String user_id= "";
int pageSize= 10;
int blockSize= 10;
//�Խ��� Ÿ�԰���
String boardType= "12";

// DB���� ��ü(ibatis���)  
TourPrevent dao = new TourPrevent();
CommonBoard commonDao = new CommonBoard();
// �˻� - �÷���
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// �˻� - �˻���
String keyword    = ParamUtil.getReqParameter(request.getParameter("keyword"));
// �˻� - �Ķ����
String key_str = "&part="+part+"&keyword="+keyword;
//��û�� ������ �ѹ�
int requestedPage = Util.parseInt(request.getParameter("page"), 1);
//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);
// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);
// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);
// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, part, keyword );
// ��ü �Խù� ��
int allCount = commonDao.getTotalCount(boardType, part,keyword);
// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
%>
<%
String McNum = "5";
String sub = "2";
String pageNum = "2";
String subNum = "2";
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
      <!--  left menu flash --></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/event/s_event_1_1title.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#">�̺�Ʈ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">����� ���� </span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/event/s_event_1_bigtitle_1.jpg" border="0" usemap="#Map"></td>
				</tr>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td width="496" height="25" valign="top"><img src="<%=imageServer%>/tour_img/com/0_px.gif" width="8" height="1"><img src="<%=imageServer%>/tour_img/event/s_event_1_love_stitle_1.gif"></td>
								<td width="194"><img src="<%=imageServer%>/tour_img/event/s_event_1_bigtitle_2.gif"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / write table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="132"><col width="213" class="lpad_10"><col width="133"><col width="212" class="lpad_10">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/event/event_s_03.gif"><!-- ���� --></td>
							<td colspan="3"><input type="text" style="width:555px;" value="���������Դϴ�."></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/event/event_s_06.gif"><!-- �ۼ��� --></td>
							<td><input type="text" style="width:200px;" value="ȫ���"></td>
							<td><img src="<%=imageServer%>/tour_img/event/event_s_08.gif"><!-- ����ó --></td>
							<td>ȫ�浿</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/event/event_s_12.gif"><!-- �̸��� --></td>
							<td><input type="text" style="width:200px;" value="2007�� 8�� 20��"></td>
							<td colspan="2"><input type="radio" name="" class="noborder" checked>1�� 2��&nbsp;&nbsp;&nbsp;<input type="radio" name="" class="noborder">2�� 3��</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/event/event_s_15.gif"><!-- ��й�ȣ --></td>
							<td><input type="text" style="width:48px;" value="018"> 
							- <input type="text" style="width:60px;" value="6654"> 
							- <input type="text" style="width:60px;" value="9987"></td>
							<td><!-- ��й�ȣȮ�� --><img src="<%=imageServer%>/tour_img/event/event_s_14.gif"></td>
							<td><input type="text" style="width:205px;" value="abc@hanmail.net"></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr><td height="6" colspan="4"></td></tr>
						<tr>
							<td height="218" align="right"><img src="<%=imageServer%>/tour_img/event/event_s_18.gif"><!-- �����Է� --></td>
							<td colspan="3"><textarea style="width:555px;height:218px;">���� ���� �κ��Դϴ�.
�̰� �����ؾ� �ɱ��?
���� ���� ��� ���ϴ�. �����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~�����ϼ��� �����ϼ���~</textarea></td>
						</tr>
						<tr><td height="6" colspan="4"></td></tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- write table / -->
						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="13"></td></tr>
						<tr>
							<td align="right" class="rpad_10"><a href="#"><img src="<%=imageServer%>/tour_img/event_bt_2.gif" border="0"></a><!--�����ϱ�--><img src="<%=imageServer%>/tour_img/com/0_px.gif" width="5" height="1"><a href="#"><img src="<%=imageServer%>/tour_img/event_bt_3.gif" border="0"></a><!--�����ϱ�--><img src="<%=imageServer%>/tour_img/com/0_px.gif" width="5" height="1"><a href="loveletter_list.jsp"><img src="<%=imageServer%>/tour_img/event_bt_4.gif" border="0"></a><!--���--><img src="<%=imageServer%>/tour_img/com/0_px.gif" width="5" height="1"><a href="#"><img src="<%=imageServer%>/tour_img/bt_cancal.gif" border="0"></a><!--����ϱ�--></td>
						</tr>
						</table>
						<!-- button/ -->
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
<map name="Map"><area shape="rect" coords="394,16,495,36" href="prevent_list.jsp" onFocus="this.blur();"></map>
</body>
</html>
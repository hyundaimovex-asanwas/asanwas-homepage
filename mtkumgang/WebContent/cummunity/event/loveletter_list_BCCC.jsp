<%-- 
  - �ۼ���: �ɵ���
  - ����: 2007.04.27
  - ���� ������ : 
  - ���۱� ǥ��: 
  - ����: �̺�Ʈ - ����� ���� �Խ���
--%>

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
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="300"><col width="120"><col width="90"><col width="65"><col width="65">
						<tr><td height="2" colspan="6" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- ��ȣ --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- ���� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt04.gif"><!-- �ۼ��� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt08.gif"><!-- ����� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt06.gif"><!-- ��õ�� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- ��ȸ�� --></td>
						</tr>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26">10</td>
							<td align="left" class="tpad_3 lpad_10"><a href="loveletter_read.jsp" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">10</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">8</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">7</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">6</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">5</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">4</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">3</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">2</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">1</td>
							<td align="left" class="tpad_3 lpad_10"><a href="#" class="listtxt06">����ϴ� ������� ������ �����ּ���~</a></td>
							<td>������(id123)</td>
							<td>2006-01-01</td>
							<td>123</td>
							<td>123</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->
						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td height="5"></td>
						</tr>
						<tr>
							<td width="120"></td>
							<td align="center">
								<a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_first.gif" align="absmiddle" hspace="1"></a><!--ó������--><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_prev.gif" hspace="2" align="absmiddle"></a><!--����-->&nbsp;&nbsp;<a href="#" class="paging">1</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><span class="pagingon">2</span><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">3</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">4</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">5</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">6</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">7</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">8</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">9</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">10</a>&nbsp;&nbsp;<a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_next.gif" hspace="2" align="absmiddle"></a><!--����--><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_last.gif" align="absmiddle" hspace="1"></a><!--����������--></td>
							<td width="120" align="right" valign="middle" class="tpad_3 rpad_3"><a href="loveletter_write.jsp"><img src="<%=imageServer%>/tour_img/event/s_event_1_lovego_bt.gif" border="0"></a></td>
						</tr>
						</table>
						<!-- paging/ -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="32"></td></tr>
						</table>
						<!-- search/ -->
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
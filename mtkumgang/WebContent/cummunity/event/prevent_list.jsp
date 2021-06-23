<%--  
  - �ۼ���: �̼ҿ�
  - ����: 2006.07.26
  - ���۱� ǥ��: IMJ Korea
  - ����: Ŀ�´�Ƽ>�����̺�Ʈ���� �󼼺���
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
String subNum = "1";
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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm022.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">�̺�Ʈ</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<td width="77" height="141" style="padding-top:12px;"><img src="<%=imageServer%>/tour_img/community/img_comm02_1.gif"></td>
							<td width="414" style="padding-top:26px;">
								<table width="100%" cellpadding="0" cellspacing="0">
								<tr><td><img src="<%=imageServer%>/tour_img/community/txt_comm02_12.gif"><a href="javascript:document.location.href='/cummunity/event/ingevent.jsp'"><img src="<%=imageServer%>/tour_img/btn/btn_comm_ingevent.gif" hspace="7"></a><!-- �����̺�Ʈ���� --></td></tr>
								<tr><td height="11"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/community/txt_comm02_22.gif"></td></tr>
								</table>
							</td>
							<td width="199" rowspan="2" align=right><img src="<%=imageServer%>/tour_img/community/img_comm02_3.gif"></td>
						</tr>
						<tr>
							<td colspan="2" valign="top" height="25"><img src="<%=imageServer%>/tour_img/community/stit_comm022.gif" hspace="5"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="480"><col width="90"><col width="70">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- ��ȣ --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- ���� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt08.gif"><!-- ����� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt09.gif"><!-- ������ --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
 <% if(record.length <= 0){ %>						
						<tr align="center">
							<td class="tpad_3 lpad_10" colspan="4" align="center">��ϵ� �����Ͱ� �����ϴ�.</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
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
		content				= tbean.getContent(); 
		use_yn				= tbean.getUse_yn(); 
		user_level			= tbean.getUser_level(); 
		board_top_no		= tbean.getBoard_top_no(); 
		user_id				= tbean.getUser_id();
		use_yn				= tbean.getUse_yn();

		java.util.Date writeday = tbean.getReg_date();
		String reg_date_string = tbean.getReg_date_String();
		String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
		String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
%>
						<tr align="center">
							<td height="26"><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
							<td align="left" class="tpad_3 lpad_10"><a href="prevent_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt07"><%=title%></a></td>
							<td><%=reg_date_string%></td>
							<td><%=read_num%></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
<%
	}
}
%>
<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->
						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "prevent_list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
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
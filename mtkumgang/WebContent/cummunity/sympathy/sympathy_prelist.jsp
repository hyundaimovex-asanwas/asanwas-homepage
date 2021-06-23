<%-- 
  - �ۼ���: �ڻ�� 
  - ����: 2006.05.30
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ��������� �Խ���
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
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
int recomm_num			= 0;
String isbest			= "";
String status			= "";
int comment_num			= 0;

int pageSize			= 10;
int blockSize			= 10;
//�Խ��� Ÿ�԰���
String boardType	= "02";

String McNum = "5";
String sub = "2";
String pageNum = "2";


// DB���� ��ü(ibatis���)  
TourSympathy dao = new TourSympathy();
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

// ��ü �Խù� ��
int allCount = dao.getTotalCount(boardType, part,keyword);

// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getFrontList(requestedPage, pageSize, part, keyword );

// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

%>
<html>
<head>
<title> �ݰ������ </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="javascript">
function openSch(){
   var form = document.frm;
   if (form.schVal.value == "Ű���带 �Է��ϼ���"){
      form.schVal.value="";
   }
   form.submit();
}
</script>

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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm02.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���������</span></td>
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
								<tr><td><img src="<%=imageServer%>/tour_img/community/txt_comm02_1.gif"><a href="sympathy_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_thistitview.gif" hspace="7"></a><!-- �̹��������� --></td></tr>
								<tr><td height="11"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/community/txt_comm02_2.gif"></td></tr>
								</table>
							</td>
							<td width="199" rowspan="2"><img src="<%=imageServer%>/tour_img/community/img_comm02_2.gif"></td>
						</tr>
						<tr>
							<td colspan="2" valign="top" height="25"><img src="<%=imageServer%>/tour_img/community/stit_comm02.gif" hspace="5"></td>
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
							<td><img src="<%=imageServer%>/tour_img/txt07.gif"><!-- ���� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt08.gif"><!-- ����� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt09.gif"><!-- ������ --></td>
						</tr>
<% if(record.length <= 0){ %>							
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26" colspan="4" align="center">����Ÿ�� �������� �ʽ��ϴ�.</td>
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
		user_nick			= tbean.getUser_name(); 
		use_yn				= tbean.getUse_yn(); 
		user_level			= tbean.getUser_level(); 
		board_top_no		= tbean.getBoard_top_no(); 
		user_id				= tbean.getUser_id();
		recomm_num			= tbean.getRecomm_num();
		isbest				= tbean.getBest().trim();
		status				= tbean.getStatus().trim();
		comment_num			= tbean.getComment_num();
		
		
		
		java.util.Date writeday = tbean.getReg_date();
		String reg_date_string = tbean.getReg_date_String();
		String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
		String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
%>
						<tr align="center">
							<td height="26"><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
							<td align="left" class="tpad_3 lpad_10">
							<a href="sympathy_list.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt05">
							<%=Util.getStringLimit((title).trim(),30)%></a></td>
							<td><%=reg_date_string%></td>
							<td><%=comment_num%></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
						<%
							}
						}
						
						%>
						</table>
						<!-- list table / -->
						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								 <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "sympathy_prelist.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
			                      </td>
						</tr>
						</table>
						<!-- paging/ -->
						<!-- /search -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<FORM METHOD=POST ACTION="sympathy_prelist.jsp">
						<tr>
							<td align="center">
                             <select name="part">
                             <option value=''>�˻�</option>
                             <option value='1'>����</option>
                             </select>
                             <input type="text" name="keyword" style="width:140px;">
                             <a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--�˻�-->
                             </td>
						</tr>
						</FORM>
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


</body>
</html>
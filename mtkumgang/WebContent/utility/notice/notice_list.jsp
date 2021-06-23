<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourNotice"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
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

int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType		= "08";

String pageNum = "5";
String McNum = "6";
String sub="5";


// DB연결 객체(ibatis사용)  
TourNotice dao = new TourNotice();
CommonBoard commonDao = new CommonBoard();
// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 검색어
String keyword    = ParamUtil.getReqParameter(request.getParameter("keyword"));
// 검색 - 파라메터
String key_str = "&part="+part+"&keyword="+keyword;

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(requestedPage, pageSize, part, keyword );

// 전체 게시물 수
int allCount = commonDao.getTotalCount(boardType, part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>

<script language="javascript">
function openSch(){
	f = document.frm;
	if(f.part.value == ""){
	    alert ("검색 종류를 선택해주세요");
		f.part.focus();
		return;
	}

	f.submit();
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
			<td width="174"><!--  left menu flash -->				<%@ include file="../../include/center/tour_center_left.jsp" %>
</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/notice/tit_notice.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">공지사항</span></td>
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
						<table width="690" height="159" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="26"></td></tr>
								<tr><td height="108" valign="top"><img src="<%=imageServer%>/tour_img/notice/txt_notice.gif"></td></tr>
								<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/notice/stit_notice.gif" hspace="5"></td></tr>
								</table>
							</td>
							<td align="right"><img src="<%=imageServer%>/tour_img/notice/img_notice.jpg" width="179" height="159"></td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="485"><col width="85"><col width="70">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- 번호 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- 제목 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt08.gif"><!-- 등록일 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- 조회수 --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
                    <% if(record.length <= 0){ %>						
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26" colspan="4" align="center">등록된 데이터가 없습니다.</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
                    <%
                    }else{
                    	//리스트 화면에 전시
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
							<td align="left" class="tpad_3 lpad_10">
							<a href="notice_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt06"><%=title%></a></td>
							<td><%=reg_date_string%></td>
							<td><%=read_num%></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
                    <%
                    	}
                    }
                    
                    %>
</form>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->
						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "notice_list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
			                </td>
						</tr>
						</table>
						<!-- paging/ -->
						<!-- /search -->
<form name="frm" method="post" action="notice_list.jsp"    >				
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr>
							<td align="center">
									<select name="part" >
									<option value=''>선택</option>
                                                                                                <option value='1'>제목</option>
									</select>
									<input type="text" name="keyword" style="width:140px;" value="<%=keyword%>">
									<a href="javascript:openSch();"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--검색--></td>
						</tr>
						</table>
</form>
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
</form>

</body>
</html>
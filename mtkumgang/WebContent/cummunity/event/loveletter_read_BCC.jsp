<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrevent"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
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
//게시판 타입결정
String boardType= "12";

// DB연결 객체(ibatis사용)  
TourPrevent dao = new TourPrevent();
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
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, part, keyword );

// 전체 게시물 수
int allCount = commonDao.getTotalCount(boardType, part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
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
<title> 금강산관광   </title>
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
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#">이벤트</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">사랑의 편지 </span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/event/s_event_1_bigtitle_1.jpg" border="0" usemap="#Map"></td></tr>
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
						<!-- / read table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="77"><col width="613">
						<tr><td height="2" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view01.gif"><!-- 제목 --></td>
							<td class="tpad_3 lpad_10"><strong>여행갈 때 준비해야 할 사항은 어떤 것들이 있나요?</strong></td>
						</tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0">
						<col width="142"><col width="204"><col width="152"><col width="192">
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/event_title_2.gif"><!-- 받으실 분 --></td>
							<td class="tpad_3 lpad_10">이현대(id123)</td>
							<td><img src="<%=imageServer%>/tour_img/event_title_4.gif"><!-- 보내는 분 --></td>
							<td class="tpad_3 lpad_10">이아산</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/event_title_3.gif"><!-- 출발일 --></td>
							<td class="tpad_3 lpad_10" colspan="2">2007년 12월 24일 2박3일 </td>
							<td align="right" valign="middle" class="rpad_10"><a href="#" class="trad_5"><img src="<%=imageServer%>/tour_img/event_print.gif" border="0"></a> <!--인쇄하기--></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr><td height="10" colspan="4"></td></tr>
						<tr>
							<td class="lpad_10 rpad_10" colspan="4" valign="top">사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용<br>
               <br>						  
              사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용사용자 문의내용</td>
						</tr>
						<tr><td height="10" colspan="4"></td></tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- read table / -->

						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td colspan="2" height="13"></td></tr>
						<tr>
							<td class="lpad_5"><a href="#"><img src="<%=imageServer%>/tour_img/event_bt_1.gif" class="btn"></a><!-- 추천하기 --></td>
							<td align="right" class="rpad_5"><a href="loveletter_modify.jsp"><img src="<%=imageServer%>/tour_img/event_bt_2.gif" border="0" class="btn"></a><!-- 수정하기 --><a href="#"><img src="<%=imageServer%>/tour_img/event_bt_3.gif" border="0" class="btn"></a><!-- 삭제하기 --><a href="loveletter_list.jsp"><img src="<%=imageServer%>/tour_img/event_bt_4.gif" border="0" class="btn"></a><!-- 목록 보기 --></td>
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
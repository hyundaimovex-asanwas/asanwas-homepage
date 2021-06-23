<%-- 
  - 작성자: 임형수
  - 일자: 2006.06.05
  - 수정자 : 이소연 
  - 일자 : 2006.07    
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>자주 묻는 질문 신규등록 or 수정
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>


<%@ page import="kr.co.imjk.util.StringUtil" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
int position = Util.parseInt(request.getParameter("position"), 1);
String part        	= clearXSS(ParamUtil.getReqParameter(request.getParameter("part")),avatag );
String keyword    	= clearXSS(ParamUtil.getReqParameter(request.getParameter("keyword")),avatag );
String searchTypeCode = clearXSS(ParamUtil.getReqParameter(request.getParameter("searchTypeCode")),avatag );
// 검색 - 파라메터
String key_str = "&searchTypeCode="+searchTypeCode+"&part="+part+"&keyword="+keyword;
//페이지 페라메터
String page_str = "&page="+requestedPage+"&position="+position;

//변수 선언
String cmd	= "";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
String regdate = "";
int read_num = 0;
String use_yn = "";
String type_name = "";
String type_code = "";

String pageNum = "1";
String McNum = "6";
String sub = "1";

CommonBoard commonDao = new CommonBoard();

if (board_seq > 0){
	//DAO
	BestQuestion dao = new BestQuestion();
    //DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle();
	content					= bean[0].getContent();
	content      = StringUtil.textToHtml(content);
	user_id					= bean[0].getUser_id();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	use_yn					= bean[0].getUse_yn();
	type_code					= bean[0].getType_code();

	//조회수 증가
    commonDao.updateReadnum(board_seq);
}


%>

<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<script language="javascript">

//검색
function goSearch(searchTypeCode){
	f = document.searchForm;
	if(searchTypeCode != ''){
	   f.searchTypeCode.value=searchTypeCode;
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
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/center/tour_center_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/customer/tit_cus01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">고객센터</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">자주묻는질문</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus01.jpg"></td></tr>
				<tr>
					<td>
						<!-- / 고객센터소분류 -->
						<table width="690" height="153" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/customer/bg_smenu.gif');fixed no-repeat left top;">
						<tr>
							<td width="197"></td>
							<td width="493" valign="top">
								<table width="467" cellpadding="0" cellspacing="0" border="0">
								<tr><td colspan="4" height="38"></td></tr>
								<tr><td colspan="4" height="32" valign="top"><img src="<%=imageServer%>/tour_img/customer/txt_smenu.gif"></td></tr>
								<tr>
									<td width="117"><%if(type_code.equals("01")){%><img src="<%=imageServer%>/tour_img/customer/sm_01_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_01.gif'"><%}else{%><a href="javascript:goSearch('01')"><img src="<%=imageServer%>/tour_img/customer/sm_01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_01.gif'"></a><%}%></td>
									<td width="117"><%if(type_code.equals("02")){%><img src="<%=imageServer%>/tour_img/customer/sm_02_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_02.gif'"><%}else{%><a href="javascript:goSearch('02')"><img src="<%=imageServer%>/tour_img/customer/sm_02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_02.gif'"></a><%}%></td>
									<td width="117"><%if(type_code.equals("03")){%><img src="<%=imageServer%>/tour_img/customer/sm_03_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_03.gif'"><%}else{%><a href="javascript:goSearch('03')"><img src="<%=imageServer%>/tour_img/customer/sm_03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_03.gif'"></a><%}%></td>
									<td width="116"><%if(type_code.equals("04")){%><img src="<%=imageServer%>/tour_img/customer/sm_03_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_04.gif'"><%}else{%><a href="javascript:goSearch('04')"><img src="<%=imageServer%>/tour_img/customer/sm_04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_04.gif'"></a><%}%></td>
								</tr>
								<tr><td colspan="4" height="8"></td></tr>
								<tr>
									<td><%if(type_code.equals("05")){%><img src="<%=imageServer%>/tour_img/customer/sm_05_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_05.gif'"><%}else{%><a href="javascript:goSearch('05')"><img src="<%=imageServer%>/tour_img/customer/sm_05.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_05.gif'"></a><%}%></td>
									<td><%if(type_code.equals("06")){%><img src="<%=imageServer%>/tour_img/customer/sm_06_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_06.gif'"><%}else{%><a href="javascript:goSearch('06')"><img src="<%=imageServer%>/tour_img/customer/sm_06.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_06.gif'"></a><%}%></td>
									<td><%if(type_code.equals("07")){%><img src="<%=imageServer%>/tour_img/customer/sm_07_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_07.gif'"><%}else{%><a href="javascript:goSearch('07')"><img src="<%=imageServer%>/tour_img/customer/sm_07.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_07.gif'"></a><%}%></td>
									<td><%if(type_code.equals("08")){%><img src="<%=imageServer%>/tour_img/customer/sm_08_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_08_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_08.gif'"><%}else{%><a href="javascript:goSearch('08')"><img src="<%=imageServer%>/tour_img/customer/sm_08.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_08_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_08.gif'"></a><%}%></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
						<!-- 고객센터소분류 / -->
					</td>
				</tr>
				<tr><td height="30"></td></tr>
				<tr><td align="right">
<FORM METHOD=POST NAME=searchForm ACTION="question_list.jsp">
<INPUT TYPE="hidden" name="searchTypeCode" value="<%=searchTypeCode%>">				
				<input type="text" style="width:262px;" name="keyword"  value="<%=keyword%>" ><a href="javascript:goSearch('');"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--검색-->
</FORM>				
				</td></tr>
				<tr><td height="12"></td></tr>
				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="2" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td width="17"></td>
							<td width="656" height="26" class="tpad_3"><strong><%=title%><strong></td>
							<td width="17"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td></td>
							<td valign="top" height="262" style="padding:20 0 17 0px;"><%=content%></td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->
						
						<!-- / button  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="13"></td></tr>
						<tr><td align="right"><a href="question_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_cus_listview.gif"></a><!-- 목록보기 --></td></tr>
						</table>
						<!-- button / -->
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
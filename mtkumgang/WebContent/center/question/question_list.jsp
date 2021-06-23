<%-- 
  - 작성자: 임형수
  - 일자: 2006.06.05
  - 수정자 : 이소연 
  - 일자 : 2006.07    
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>자주 묻는 질문 리스트
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%


//변수 선언
int board_seq			= 0;
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		= "";
String type_code  = "";
String type_name = "";
String use_yn			= "";
String user_id		= "";
int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "06";


// DB연결 객체
BestQuestion dao = new BestQuestion();
CommonBoard commonDao = new CommonBoard();




// 검색 - 분류
String searchTypeCode =clearXSS(ParamUtil.getReqParameter(request.getParameter("searchTypeCode")),avatag );

// 검색 - 컬럼명
String part       = clearXSS(ParamUtil.getReqParameter(request.getParameter("part")),avatag );
// 검색 - 검색어
String keyword    =  clearXSS(ParamUtil.getReqParameter(request.getParameter("keyword")),avatag ); //Util.toKSC(ParamUtil.getReqParameter(request.getParameter("keyword")));

// 검색 - 파라메터
String key_str = "&searchTypeCode="+searchTypeCode+"&part="+part+"&keyword="+keyword;

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 전체 게시물 수
int allCount = dao.getTotalCount(searchTypeCode,part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, searchTypeCode, part, keyword );

//페이지 페라메터
String page_str = "&requestedPage="+requestedPage+"&position="+position;

String pageNum = "1";
String McNum = "6";
String sub = "1";


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
function openSch(){
   var form = document.frm;
   if (form.schVal.value == "키워드를 입력하세요"){
      form.schVal.value="";
   }
   form.submit();
}

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
									<td width="117"><%if(searchTypeCode.trim() == "01" || searchTypeCode.equals("01")){%><img src="<%=imageServer%>/tour_img/customer/sm_01_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_01.gif'"><%}else{%><a href="javascript:goSearch('01')"><img src="<%=imageServer%>/tour_img/customer/sm_01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_01.gif'"></a><%}%></td>
									<td width="117"><%if(searchTypeCode.trim() == "02" || searchTypeCode.equals("02")){%><img src="<%=imageServer%>/tour_img/customer/sm_02_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_02.gif'"><%}else{%><a href="javascript:goSearch('02')"><img src="<%=imageServer%>/tour_img/customer/sm_02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_02.gif'"></a><%}%></td>
									<td width="117"><%if(searchTypeCode.trim() == "03" || searchTypeCode.equals("03")){%><img src="<%=imageServer%>/tour_img/customer/sm_03_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_03.gif'"><%}else{%><a href="javascript:goSearch('03')"><img src="<%=imageServer%>/tour_img/customer/sm_03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_03.gif'"></a><%}%></td>
									<td width="116"><%if(searchTypeCode.trim() == "04" || searchTypeCode.equals("04")){%><img src="<%=imageServer%>/tour_img/customer/sm_04_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_04.gif'"><%}else{%><a href="javascript:goSearch('04')"><img src="<%=imageServer%>/tour_img/customer/sm_04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_04.gif'"></a><%}%></td>
								</tr>
								<tr><td colspan="4" height="8"></td></tr>
								<tr>
									<td><%if(searchTypeCode.trim() == "05" || searchTypeCode.equals("05")){%><img src="<%=imageServer%>/tour_img/customer/sm_05_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_05.gif'"><%}else{%><a href="javascript:goSearch('05')"><img src="<%=imageServer%>/tour_img/customer/sm_05.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_05.gif'"></a><%}%></td>
									<td><%if(searchTypeCode.trim() == "06" || searchTypeCode.equals("06")){%><img src="<%=imageServer%>/tour_img/customer/sm_06_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_06.gif'"><%}else{%><a href="javascript:goSearch('06')"><img src="<%=imageServer%>/tour_img/customer/sm_06.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_06.gif'"></a><%}%></td>
									<td><%if(searchTypeCode.trim() == "07" || searchTypeCode.equals("07")){%><img src="<%=imageServer%>/tour_img/customer/sm_07_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_07.gif'"><%}else{%><a href="javascript:goSearch('07')"><img src="<%=imageServer%>/tour_img/customer/sm_07.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_07.gif'"></a><%}%></td>
									<td><%if(searchTypeCode.trim() == "08" || searchTypeCode.equals("08")){%><img src="<%=imageServer%>/tour_img/customer/sm_08_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_08_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_08.gif'"><%}else{%><a href="javascript:goSearch('08')"><img src="<%=imageServer%>/tour_img/customer/sm_08.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_08_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_08.gif'"></a><%}%></td>
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

<form method=post name=searchForm action="question_list.jsp">
<input type="hidden" name="searchTypeCode" value="<%=searchTypeCode%>">				
				<input type="text" style="width:262px;" name="keyword"  value="<%=keyword%>" ><a href="javascript:goSearch('')"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--검색-->
</form>				
				</td></tr>
				<tr><td height="12"></td></tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="80"><col width="500"><col width="60">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- 번호 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt11.gif"><!-- 분류 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- 제목 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- 조회수 --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
<% if(record.length <= 0){ %>							
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26" colspan="4" align="center">데이타가 존재하지 않습니다.</td>
						</tr>
<%}else{
		//리스트 화면에 전시
		for(int i=0;i<record.length; i++){ 
			Tbrd_board_ma_bean tbean = record[i];
			board_seq			= tbean.getBoard_seq();
			ref_no				= tbean.getRef_no(); 
			read_num			= tbean.getRead_num(); 
			title				= tbean.getTitle(); 
			content				= tbean.getContent(); 
			use_yn				= tbean.getUse_yn(); 
			user_id				= tbean.getUser_id();
			type_code				= tbean.getType_code();
			if(type_code.equals("01")){  type_name = "육로관광";
			}else if(type_code.equals("02")){ type_name = "예약신청/취소";
			}else if(type_code.equals("03")){ type_name = "관광요금";
			}else if(type_code.equals("04")){ type_name = "여행준비";
			}else if(type_code.equals("05")){ type_name = "현지관광";
			}else if(type_code.equals("06")){ type_name = "세관출입국";
			}else if(type_code.equals("07")){ type_name = "현대아산";
			}else if(type_code.equals("08")){ type_name = "기타";
			}else{ type_name = "기타";
			}

			String reg_date_string = tbean.getReg_date_String();
			String re_img	= BoardUtil.getReImg(0,0,imageServer);
			String new_img	= BoardUtil.getNewArticle(reg_date_string,imageServer);
	%>						
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26"><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
							<td><%=type_name%></td>
							<td align="left" class="tpad_3 lpad_10">
                            <a href="question_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>" class="listtxt06"><%=Util.getStringLimit(title,25)%></a>							
                            </td>
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
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "question_list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
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
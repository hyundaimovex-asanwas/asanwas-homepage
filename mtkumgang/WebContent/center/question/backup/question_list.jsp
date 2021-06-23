<%--
  - 작성자: 임형수
  - 일자: 2006.06.05
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>자주 묻는 질문 리스트
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
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
String searchTypeCode =ParamUtil.getReqParameter(request.getParameter("searchTypeCode"));
// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 검색어
String keyword    =  ParamUtil.getReqParameter(request.getParameter("keyword")); 

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

%>

<HTML>
<HEAD>
<title></title>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
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
</HEAD>
<body>





   <TABLE cellspacing=0 cellpadding=0 width=600>
		<TR valign=top>
			<!-- main -->
			<TD width=650 valign=top>
				<table width=650 border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td>
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td class='title'><img src='<%=imageServer%>tour_img/bu_blue_title.gif' align=texttop class=rmar10>자주묻는질문</td>
						</tr>
						</table>
						<br>
						<!--분류 START -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<col width=25%>
						<col width=25%>
						<col width=25%>
						<col width=25%>
						    <tr height=28 align=center>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=육로관광 class=btn onclick="javascript:goSearch('01')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=예약신청/취소 class=btn onclick="javascript:goSearch('02')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=관광요금 class=btn onclick="javascript:goSearch('03')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=여행준비 class=btn onclick="javascript:goSearch('04')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td></td>
						    </tr>
						    <tr height=28 align=center>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=현지관광 class=btn onclick="javascript:goSearch('05')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=세관출입국 class=btn onclick="javascript:goSearch('06')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=현대아산 class=btn onclick="javascript:goSearch('07')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=기타 class=btn onclick="javascript:goSearch('08')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle></td>
						        <td></td>
						    </tr>
						    <tr><td colspan=4 height=2 class=linec1></td></tr>				    
						</table>
						<!--분류 END -->
						<br>
						<//-- 검색 -->
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td align=right>
								<!--검색 START -->
							  <FORM METHOD=POST NAME=searchForm ACTION="question_list.jsp">
							  <INPUT TYPE="hidden" name="searchTypeCode" value="<%=searchTypeCode%>">
          						<table border=0 cellspacing=0 cellpadding=0>
          						<tr>
          						  <td width="100" align=right>
                                        </td>                                  
                                        <td class="dblue rpad5">
                                        <input type=text style='width:200;' name="keyword"  value="<%=keyword%>" >
                                        <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value="검색" class="btn" onclick="goSearch('')" onfocus="this.blur();"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                                        <td>                                  
          						</tr>
          						</table>
							  </FORM>
							  <!--검색 END -->
							</td>
						</tr>
						<tr><td height=6></td></tr>
						</table>
						<//-- 검색 -->						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<col width=10%>
							<col width=20% style='padding:5 3 3 3;'>
							<col width=50%>
							<col width=20%>
							<tr><td colspan=4 height=2 class=linec1></td></tr>
							<tr height=28 align=center>
                             <td class=th>번호</td>
                             <td class=th>분류</td>
                             <td class=th>제목</td>
                             <td class=th>조회수</td>
							</tr>
							<tr><td colspan=4 height=1 class=linec1></td></tr> 
							 <% 
								//out.println(list.size());
								if(record.length <= 0){ %>	
								<tr align=center height=28 align=center height=35>
									<td colspan="4" align="center" height="30">데이타가 존재하지 않습니다.</td>
								</tr>
								<tr>
								    <td colspan="4" height=1 class=linec1></td>
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
          					
          					<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                   <td><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
                                   <td><%=type_name%></td>
                                   <td align=left><a href="question_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><%=Util.getStringLimit(title,25)%></a></td>
                                   <td><%=read_num%></td>
          					</tr>
          					<tr><td colspan=4 height=1 class=linec1></td></tr>
          						<%
									}
								}
								
								%>

																																																																				

						</table>
						
						<table width=100% border=0 cellspacing=0 cellpadding=0>
							<tr>
                              <td width=50%></td>
                              <td align=center>
                                <!--페이징 -->
						        <table width=600 border=0 cellspacing=0 cellpadding=0>
          					         <tr>
          						        <td align=center>
          						       <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "question_list.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
                                           </td>
                                        </tr>
                                       </table>
                                <!--페이징 -->
                              </td>
                              <td width=50% align=right></td>
							</tr>
						</table>
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
                        
					 </td>
				   </tr>
				</table>
			 </TD>
			<!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>

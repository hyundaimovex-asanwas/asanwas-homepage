<%--
  - 작성자: 박상배
  - 일자: 2006.05.30
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 여행공감대 게시판
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
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
int recomm_num			= 0;
String isbest			= "";
String status			= "";
int comment_num			= 0;

int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "02";
// DB연결 객체(ibatis사용)  
TourSympathy dao = new TourSympathy();
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

// 전체 게시물 수
int allCount = dao.getTotalCount(boardType, part,keyword);

// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getFrontList(requestedPage, pageSize, part, keyword );

// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

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
</script>
</HEAD>
<body>
   <TABLE cellspacing=0 cellpadding=0 width=650>
		<TR valign=top>
			<!-- main -->
			<TD width=650 valign=top>
				<table width=650 border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td>
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td class='title'><img src='../../asanway/img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>여행공감대</td>
						</tr>
						</table>
						<br>
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
                          <td align=right>
                           <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td class="dblue rpad5">
                              <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value="이번주제보기" class="btn" onclick="location.href='sympathy_list.jsp'" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                              <td>                                  
                            </tr>
                           </table>                           
                          </td>
						</tr>
						</table><br>					
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<col width=10%>
							<col width=50% style='padding:5 3 3 3;'>
							<col width=20%>
							<col width=20%>
							<tr><td colspan=4 height=2 class=linec1></td></tr>
							<tr height=28 align=center>
                             <td class=th>번호</td>
                             <td class=th>제목</td>
                             <td class=th>등록일</td>
                             <td class=th>참여수</td>
							</tr>
							<tr><td colspan=4 height=1 class=linec1></td></tr> 

							<% 
								//out.println(list.size());
							if(record.length <= 0){ %>	
							
								<tr>
									<td colspan="4" align="center" height="30">데이타가 존재하지 않습니다.</td>
								</tr>
								<tr><td colspan=4 height=1 class=linec1></td></tr>
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

							<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                             <td><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
                             <td><a href="sympathy_list.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>"><%=Util.getStringLimit((title).trim(),30)%></a></td>
                             <td><%=reg_date_string%></td>
                             <td><%=comment_num%></td>
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
			                      "sympathy_prelist.jsp", "500", key_str ,
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
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td align=right>
								<table border=0 cellspacing=0 cellpadding=0>
								<FORM METHOD=POST ACTION="sympathy_prelist.jsp">
								<tr>
                                  <td width="100" align=center>
                                    <select name="part" style='width:80;'>
                                    <option value=''>검색</option>
                                    <option value='1'>제목</option>
                                    </select>
                                  </td>                                  
                                  <td class="dblue rpad5">
                                  <input type=text style='width:200;' name="keyword">
                                  <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=submit value="검색" class="btn" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                                  <td>                                  
								</tr>
								</FORM>
								</table>
							</td>
						</tr>
						<tr><td height=6></td></tr>
						</table>                        
					 </td>
				   </tr>
				</table>
			 </TD>
			<!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>

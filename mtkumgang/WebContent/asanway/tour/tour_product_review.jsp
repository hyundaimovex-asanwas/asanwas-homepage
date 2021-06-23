<%--
  - 작성자: 이소연
  - 일자: 2006.08
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 상품후기
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourProductReview"%>
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
String user_name        = "";

int pageSize			= 10;
int blockSize			= 10;

//게시판 타입결정
String boardType		= "11";


// DB연결 객체(ibatis사용)  
TourProductReview dao = new TourProductReview();
CommonBoard commonDao = new CommonBoard();
// 검색 - 컬럼명
String part       = "1";
// 검색 - 검색어
String keyword = ParamUtil.getReqParameter(request.getParameter("keyword"));
String reviewType = keyword;

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
Tbrd_board_ma_bean record [] = dao.getList(requestedPage, pageSize, reviewType);

// 전체 게시물 수
int allCount = commonDao.getTotalCount(boardType, part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>

</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<SCRIPT LANGUAGE="JavaScript">
<!--
function openDel(val){
   var obj = document.mainForm;
   if(confirm("정말 삭제하시겠습니까?")){
   	obj.cmd.value = "del";
   	obj.board_seq.value = val;
   	obj.submit();
   }else{
   	return;
   }
}

function go_change() {
    var obj = document.searchForm;
    obj.submit();
}
//-->
</SCRIPT>

<form name="mainForm" method="post" action="tour_product_review_ok.jsp">
  <input type="hidden" name="board_seq">
  <input type="hidden" name="cmd">
</form>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3">
    	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr>
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/tour/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6" align="right">
          <!--// IMJK START -->
          <TABLE cellspacing=0 cellpadding=0 width=650>
                <TR>
                  <TD>
          	      <TABLE cellspacing=0 cellpadding=0 width=650>
          	       <!-- loc -->
          	         <TR valign=top>
          		        <TD colspan=2 height=50 align=right style='padding-top: 10'>
          		        <img src="../img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>Utility</A> > 
          		        <span class=locon>상품후기</span>
          		        </TD>
          	          </TR>
          	       <!-- //loc -->
          	       </TABLE>
                  </TD>
               </TR>
          	<TR valign=top>
          		<!-- main -->
          
          		<TD width=650 valign=top>
          			<table width=650 border=0 cellspacing=0 cellpadding=0>
          			<tr>
          				<td>
          					<table width=100% border=0 cellspacing=0 cellpadding=0>
          					<tr>
          						<td class='title'><img src='../img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>상품후기</td>
          					</tr>
          					</table>
          					<br>
          					<table width="100%" border="0" cellspacing="0" cellpadding="0">
          						<col width=15%>
          						<col width=75% style='padding:5 3 3 3;'>
          						<col width=10%>
          						<tr><td colspan=3 height=2 class=linec1></td></tr>
								<% 
								if(record.length <= 0){ %>	
								<tr align=center height=35>
									<td colspan=3 align="center" height="30">데이타가 존재하지 않습니다.</td>
								</tr>
								<tr><td colspan=3 height=1 class=linec1></td></tr>
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
                                                            	                                          content				= content.replaceAll("\"", "'");
										use_yn				= tbean.getUse_yn(); 
										user_level			= tbean.getUser_level(); 
										board_top_no		= tbean.getBoard_top_no(); 
										user_id				= tbean.getUser_id();
										user_name			= tbean.getUser_name();
										use_yn				= tbean.getUse_yn();

										java.util.Date writeday = tbean.getReg_date();
										String reg_date_string = tbean.getReg_date_String();
										String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
										String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
								%>
          						<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                    <td><%=title%></td>
                                    <td align="left">
                                    <b><%=user_name%>(<%=user_id%>)</b>&nbsp;[등록일:<%=reg_date_string%>]<br>
                                    <%=content%>&nbsp;&nbsp;</td>
                                    <td>
                                    <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=삭제 onclick="location.href='javascript:openDel(<%=board_seq%>)'" class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                    </td>
          						</tr>
          						<tr><td colspan=3 height=1 class=linec1></td></tr>
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
											<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "tour_product_revuew.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
										</td>
                                        </tr>
                                       </table>
                                       <!--페이징 -->
                                     </td>
                                     <td width=50% align=right></td>
          						</tr>
                                   <tr>
          						</tr>
          					</table>
                           <table width=100% border=0 cellspacing=0 cellpadding=0>
                           <tr>
                           	<td align=right>
                           	<!--검색 START -->
                           	  <form method="post" name="searchForm" action="tour_product_review.jsp">
                           		<table border=0 cellspacing=0 cellpadding=0>
                           		<tr>
                           		  <td width="100" align=right>
                                    <select name="keyword" style='width:150;' onChange="go_change()">
                                      <option <%if(keyword.equals("")){%>selected<%}%> value=''>전체</option>
                                      <option <%if(keyword.equals("01")){%>selected<%}%> value='01'>온천관광</option>
                                      <option <%if(keyword.equals("02")){%>selected<%}%> value='02'>북측체험관광</option>
                                      <option <%if(keyword.equals("03")){%>selected<%}%> value='03'>효도관광</option>
                                      <option <%if(keyword.equals("04")){%>selected<%}%> value='04'>산악/등산관광</option>
                                      <option <%if(keyword.equals("05")){%>selected<%}%> value='05'>수학여행/MT</option>
                                      <option <%if(keyword.equals("06")){%>selected<%}%> value='06'>기업연수/워크샵</option>
                                    </select>
                                  </td>                             
                           		</tr>
                           		</table>                               
                           	  </form>
                           	  <!--검색 END -->
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
          <!--// IMJK END -->
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>

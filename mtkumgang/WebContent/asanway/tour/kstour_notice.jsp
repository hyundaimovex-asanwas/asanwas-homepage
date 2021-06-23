<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.KsTourNotice"%>
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
String boardType		= "15";

// DB연결 객체(ibatis사용)  
KsTourNotice dao = new KsTourNotice();
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
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<script language="javascript">
function goSearch(){
   var form = document.frm;
   if(form.part.value == ""){
      alert("검색조건을 선택하세요.");
      form.part.focus();
      return;
   }
   if (form.keyword.value == ""){
      alert("키워드를 입력하세요.");
      form.keyword.focus();
      return;
   }
   

    form.action="kstour_notice.jsp";
    form.submit();

}
</script>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

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
          		        <span class=locon>공지사항</span>
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
          						<td class='title'><img src='../img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>공지사항</td>
          					</tr>
          					</table>
          					<br>
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
                                    <td class=th>조회수</td>
          						</tr>
          						<tr><td colspan=4 height=1 class=linec1></td></tr> 
								<% 
								if(record.length <= 0){ %>	
								<tr align=center height=35>
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
          						<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                    <td><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
                                    <td align="left"><a href="kstour_notice_edit.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>"><%=title%></a></td>
                                    <td><%=reg_date_string%></td>
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
			                      "kstour_notice.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
										</td>
                                        </tr>
                                       </table>
                                       <!--페이징 -->
                                     </td>
                                     <td width=50% align=right></td>
          						</tr>
                                   <tr>
          						  <td colspan=2 align=right>
          						    <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value="신규등록" class="btn" onclick="location.href='kstour_notice_edit.jsp'" onfocus="this.blur();"><img src=../img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>  
          						  </td>
          						</tr>
          					</table>
                               <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
          					<table width=100% border=0 cellspacing=0 cellpadding=0>
          					<tr>
          						<td align=right>
          							<table border=0 cellspacing=0 cellpadding=0>
          							<form name="frm" method=post>
          							  <tr>
                                         <td >
                                           <select name="part" style='width:80;'>
                                           <option value=''>선택</option>
                                           <option value='1'>제목</option>
                                           </select>
                                         <input type=text style='width:200;' name="keyword">
                                         <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value="검색" onclick="goSearch()" class="btn" onfocus="this.blur();"><img src=../img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                                         <td>                                  
          							   </tr>
          							</form>
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

</body>
</html>

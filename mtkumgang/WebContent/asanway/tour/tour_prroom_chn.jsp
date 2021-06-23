<%--
  - 작성자: 이소연
  - 일자: 2006.06.13
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 금강산 알아보기>홍보자료실 리스트
  
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrRoomChn"%>
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
String user_name		= "";
String virtual_name	= "";
String real_name		= "";
String regdate			= "";
int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "16";

// DB연결 객체
TourPrRoomChn dao = new TourPrRoomChn();
CommonBoard commonDao = new CommonBoard();


// 검색 - 컬럼명
String part   = ParamUtil.getReqParameter(request.getParameter("part"));

// 검색 - 검색어
String keyword    =  ParamUtil.getReqParameter(request.getParameter("keyword"));

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
int allCount = dao.getTotalCount(part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, part, keyword );

%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSearch(){
	f = document.searchForm;

	if(f.part.value==""){
		alert("검색종류를 선택하여 주십시요.");
		f.part.focus();
		return false;
	}else{
            	if(f.keyword.value==""){
            		alert("검색어를 입력해 주십시요.");
            		f.keyword.focus();
            		return false;
            	}          
          }
	f.submit();
}

//-->
</SCRIPT>

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
          		        <span class=locon>홍보자료실(중문)</span>
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
          						<td class='title'><img src='../img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>홍보자료실(중문)</td>
          					</tr>
          					</table>
          					<br>
          					<table width="100%" border="0" cellspacing="0" cellpadding="0">
          						<col width=10%>
          						<col width=10%>
          						<col width=40% style='padding:5 3 3 3;'>
          						<col width=20%>
          						<col width=20%>
          						<tr><td colspan=5 height=2 class=linec1></td></tr>
          						<tr height=28 align=center>
                                  <td class=th>번호</td>
                                  <td class=th>구분</td>
                                  <td class=th>제목</td>
                                  <td class=th>등록일</td>
                                  <td class=th>조회수</td>
          						</tr>
          						<tr><td colspan=5 height=1 class=linec1></td></tr> 
						<%
						if(record.length <= 0){
						%>
          						<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                   <td colspan=5><div align="center">등록된 데이터가 없습니다.</div></td>
          						</tr>
          						<tr><td colspan=5 height=1 class=linec1></td></tr>
						<%
						}else{
							int a_table = 0;
							for(int i=0;i<record.length; i++){
								Tbrd_board_ma_bean tbean = record[i];
								board_seq			= tbean.getBoard_seq();
								read_num			= tbean.getRead_num(); 
								title				= tbean.getTitle(); 
								type_code		    = tbean.getType_code().trim();
								
								if (type_code == "1" || type_code.equals("1")){
							        type_code = "이미지";
							    }else if (type_code == "2" || type_code.equals("2")){
						            type_code = "동영상";
						        }
								content				= tbean.getContent(); 
								regdate				= tbean.getReg_date_String();
						%>
						
						                        
          						<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                    <td><%=board_seq%></td>
                                    <td><%=type_code%></td>
                                    <td align="left"><a href="tour_prroom_chn_edit.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>"><%=title%></a></td>
                                    <td><%=regdate%></td>
                                    <td><%=read_num%></td>                  
          						</tr>
          						<tr><td colspan=5 height=1 class=linec1></td></tr>	   						
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
                                   <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "tour_prroom_chn.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
                                   </td>
                                  </tr>
                                 </table>
                                 <!--페이징 -->
                                </td>
                                <td width=50% align=right></td>
                             </tr>
                             <tr>
                                <td colspan=2 align=right>
                                  <img src=../img//tour_img/btn_l.gif align=absmiddle><input type=button value="신규등록" class="btn" onclick="location.href='tour_prroom_chn_edit.jsp'" onfocus="this.blur();"><img src=../img//tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>  
                                </td>
          					 </tr>
          					</table>
                               <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
          					<table width=100% border=0 cellspacing=0 cellpadding=0>
          					<tr>
          						<td align=right>

							      <!--검색 START -->
							      <FORM METHOD=POST NAME=searchForm ACTION="tour_prroom_chn.jsp">
          					      <table border=0 cellspacing=0 cellpadding=0>
          					       <tr>
                                                               <td  align=right>
                                                                <select name="part" style='width:80;' >
                                                                 <option <%if(part.equals("")){%>selected<%}%> value=''>선택</option>
                                                                 <option <%if(part.equals("1")){%>selected<%}%> value='1'>이미지</option>
                                                                 <option <%if(part.equals("2")){%>selected<%}%> value='2'>동영상</option>
                                                               </select>                                     
                                                               <input type=text style='width:200;' name="keyword"  value="<%=keyword%>" >
                                                               <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value="검색" class="btn" onclick="goSearch()" onfocus="this.blur();"><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
                                                             <td>
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

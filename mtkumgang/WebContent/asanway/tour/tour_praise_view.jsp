<%--
  - 작성자: 박상배
  - 일자: 2006.05.26
  - 수정자:이소연 (2006.08)
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 여행후기 게시판 상세보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPraise"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>
<%
int board_seq		= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));

String part			= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));	

String key_str = "&part="+part+"&keyword="+keyword;
String board_type	= "03";

//############### Connection생성 ##########################
TourPraise dao	= new TourPraise();
TourSympathyComment stardao = new TourSympathyComment();
//#########################################################


int ref_no				= 0;
int level_no			= 0;
int sort_no				= 0;
String title			= "";
String content			= "";
String user_id			= "";
String user_name		= "";
String user_nick		= "";
String user_level		= "";
String user_icon		= "";
String regdate			= "";
int read_num			= 0;
int recomm_num			= 0;
int comment_num			= 0;
String notice_from		= "";
String notice_to		= "";
int board_top_no		= 0;
String edit_yn			= "";
String use_yn			= "";
int point				= 0;
String password			= "";
String isbest			= "";

int prev_board_seq  = 0;
int next_board_seq	= 0;

String prev_title		= "";
String next_title		= "";

Tbrd_board_ma_bean[] recordview = dao.getPrevAndNextBoard(board_seq);

int totalCount = recordview.length;


dao.updateReadnum(board_seq);
	
for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = recordview[i];
	String gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){
		ref_no					= tbean.getRef_no();
		level_no				= tbean.getLevel_no();
		sort_no					= tbean.getSort_no();
		title					= tbean.getTitle();
		content					= tbean.getContent();
		
		user_id					= tbean.getUser_id();
		user_name				= tbean.getUser_name();
		user_nick				= tbean.getUser_nick();
		user_level				= tbean.getUser_level();
		user_icon				= tbean.getUser_icon();
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		recomm_num				= tbean.getRecomm_num();
		comment_num				= tbean.getComment_num();
		board_top_no			= tbean.getBoard_top_no();
		edit_yn					= tbean.getEdit_yn();
		use_yn					= tbean.getUse_yn();
		point					= tbean.getPoint();
		password				= tbean.getPassword();
		isbest					= tbean.getBest().trim();
	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	

content = Util.encodeHTMLSpecialChar(content,11);

int comment_seq		= 0;

int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType		= "09";


// 검색 - 컬럼명
String subpart       = ParamUtil.getReqParameter(request.getParameter("subpart"));
// 검색 - 검색어
String subkeyword    = ParamUtil.getReqParameter(request.getParameter("subkeyword"));
// 검색 - 파라메터
String subkey_str = "&board_seq="+board_seq+"&subpart="+subpart+"&subkeyword="+subkeyword;

if(subpart.equals("")){
	subpart = "3";
}

//요청된 페이지 넘버
int subrequestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// 게시물 목록
Tbrd_comment_de_bean record [] = stardao.getCommentAdminList(subrequestedPage, pageSize, subpart, subkeyword ,board_seq);

// 전체 게시물 수
int allCount = stardao.getCommentAdminTotalCount(subpart, subkeyword ,board_seq );

// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, subrequestedPage, allCount);

%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<SCRIPT LANGUAGE="JavaScript">
<!--
    function colDel(val) {
        var form=document.listForm;
        
       if(confirm("댓글을 삭제하시겠습니까?")){
                     form.cmd.value = "comment_del";
                     form.comment_seq.value = val;
                     form.action="tour_praise_ok.jsp";
                     form.submit();
	}else{
		return;
	}  
	
    }
    
    function data_del() {
        var form=document.listForm;
       if(confirm("게시물을 삭제하시겠습니까?")){
                    form.cmd.value = "board_del";
                    form.action="tour_praise_ok.jsp";
                    form.submit();
	}else{
		return;
	}          

    }
//-->
</SCRIPT>
<%@ include file="/asanway/common/head.jsp" %>

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
          		        <TD height=50 align=right style='padding-top: 10'>
          		        <img src="../img/tour_img//bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>커뮤니티</A> > 
          		        <span class=locon>칭찬하기</span>
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
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>칭찬하기</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
							
							<table width=100% border=0 cellspacing=0 cellpadding=0>
							  <tr>
								<td height=2 class=linec1></td>
							  </tr>
							  <tr> 
								<td style='padding:7;' width="76%"><%=title%><br>
								  <%=content%> </td>
							  </tr>
							  <tr>
								<td height=1 class=linec1></td>
							  </tr>
							</table>
                      
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                             <tr><td height=10></td></tr>
                             <tr>
                             	<td align=left>
								<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=삭제 class=btn onclick="javascript:data_del();"><img src=../img/tour_img/btn_r.gif align=absmiddle>&nbsp;
								<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='tour_praise.jsp?page=<%=requestedPage%><%=key_str%>'"><img src=../img/tour_img/btn_r.gif align=absmiddle>&nbsp;
                             	</td>
                             	<td align=right>
								  <%if(prev_board_seq > 0){%>
								  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=이전 class=btn onclick="javascript:location.href='tour_praise_view.jsp?board_seq=<%=prev_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>'"><img src=../img/tour_img/btn_r.gif align=absmiddle>&nbsp;
								  <% } %>
								  <%if(next_board_seq > 0){%>
								  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=다음 class=btn onclick="javascript:location.href='tour_praise_view.jsp?board_seq=<%=next_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>'"><img src=../img/tour_img/btn_r.gif align=absmiddle>   
								  <% } %>
                             	</td>
                             </tr>
                			</table>
                           <br>
                           <form  method=post  name=listForm  >
                           <input type="hidden" name="cmd" >
                           <input type="hidden" name="comment_seq">
                           <input type="hidden" name="board_seq" value="<%=board_seq%>">
                           <input type="hidden" name="requestedPage" value="<%=requestedPage%>">
                           <input type="hidden" name="subrequestedPage" value="<%=subrequestedPage%>">
                           <input type="hidden" name="part" value="<%=part%>">
                           <input type="hidden" name="keyword" value="<%=keyword%>">
                           <input type="hidden" name="subpart" value="<%=subpart%>">
                           <input type="hidden" name="subkeyword" value="<%=subkeyword%>">
                           <input type="hidden" name="delcount">

                           <table width="100%" border="0" cellspacing="0" cellpadding="0">
                           	<tr><td colspan=6 height=2 class=linec1></td></tr>
                           	<tr height=28 align=center>
                                <td class=th>번호</td>
                                <td class=th>내용</td>
                                <td class=th>등록일</td>
                                <td class=th>작성자</td>
                                <td class=th>
                               &nbsp;
                                </td>
                                <!-- <td class=th>Best</td> -->
                           	</tr>
                           	<tr><td colspan=6 height=1 class=linec1></td></tr>
							<% 
							//out.println(list.size());
							if(record.length <= 0){ %>	
							
							<tr align=center height=28 align=center height=35>
								<td colspan="6" align="center" height="30">데이타가 존재하지 않습니다.</td>
							</tr>
							<tr><td colspan=6 height=1 class=linec1></td></tr>
							<%
							}else{
								//리스트 화면에 전시
								for(int i=0;i<record.length; i++){ 
									Tbrd_comment_de_bean tbean = record[i];
									comment_seq			= tbean.getComment_seq();
									//board_seq			= tbean.getBoard_seq();
									title				= tbean.getTitle(); 
									content				= tbean.getContent(); 
									user_name			= tbean.getUser_name(); 									
									user_id				= tbean.getUser_id();
									isbest				= tbean.getBest().trim();
									
									java.util.Date writeday = tbean.getReg_date();
									String reg_date_string = tbean.getReg_date_String();
									
							%>

                           	<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><%=BoardUtil.getNum(allCount,subrequestedPage,rowsPerPage,(i+1))%></td>
                                <td><%=content%></td>
                                <td><%=reg_date_string%></td>
                                <td><%=user_name%>(<%=user_id%>)</td>
                                <td><img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=삭제 onclick="javascript:colDel(<%=comment_seq%>);" class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;></td>
                           	</tr>
                           	<tr><td colspan=6 height=1 class=linec1></td></tr>
							<%
								isbest = "";
								}
							}

							%> 	
                           </table>
                           </FORM>
                           <table width=100% border=0 cellspacing=0 cellpadding=0>
                           	<tr>
                                 <td width=50%></td>
                                 <td align=center>
                                   <!--페이징 -->
                                   <table width=600 border=0 cellspacing=0 cellpadding=0>
                                    <tr>
                           	        <td align=center>
                           	        <%=HtmlUtil.doPageCut(subrequestedPage, pageCount , position , 
			                      "tour_sympathy_view.jsp", "500", subkey_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
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
                           		<FORM METHOD=POST ACTION="tour_praise_view.jsp">
								<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
								<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
								<INPUT TYPE="hidden" name="part" value="<%=part%>">
								<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
                           		<tr>
                           		  <td>
                                    <select name="subpart" style='width:80;'>
                           			<option value='3'>아이디</option>
                           			<option value='2'>이름</option>
                           			</select>

                                     <input type=text style='width:200;' name="subkeyword">
                                     <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=submit value="검색" class="btn" onfocus="this.blur();"><img src=../img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                                     <td>                                  
                           		</tr>
                           		</FORM>
                           		</table>
                           	</td>
                           </tr>
                           <tr><td height=6></td></tr>
                           </table> 
                
                			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
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
<FORM METHOD=POST name="delform">
<INPUT TYPE="hidden" name="cmd">
<INPUT TYPE="hidden" name="board_seq" value=<%=board_seq%>>
</FORM>
</body>
</html>

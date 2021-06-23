<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="java.util.*"%>

<%
int board_seq		= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);

String part			= Util.toKSC(ParamUtil.getReqParameter(request.getParameter("part")));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&board_seq="+board_seq+"&part="+part+"&keyword="+keyword;


//String session_id =  Util.getString((String)session.getAttribute("memberid"),"");

//session_id = "odyssey";

//############### Connection생성 ##########################
TourSympathy  dao  = new TourSympathy();

TourSympathyComment stardao = new TourSympathyComment();
//#########################################################

int current_board_seq	= 0;
String title			= "";
String content			= "";
String virtual_name		= "";
String real_name		= "";
String img_name			= "";
String best_content		= "";
String use_yn			= "";

Tbrd_board_ma_bean[] recordview = null;

if(board_seq > 0){
	current_board_seq = board_seq;

	recordview = dao.getBoardView(board_seq);

	if(recordview.length > 0){
		Tbrd_board_ma_bean tbean = recordview[0];
		
		current_board_seq		= tbean.getBoard_seq();
		title					= Util.getString(tbean.getTitle(),"");
		content					= Util.getString(tbean.getContent(),"");
		virtual_name			= Util.getString(tbean.getVirtual_name(),"");
		real_name				= Util.getString(tbean.getReal_name(),"");

		img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+virtual_name;

	}
}else{
	recordview = dao.getBoardView();

	if(recordview.length > 0){
		Tbrd_board_ma_bean tbean = recordview[0];
		
		current_board_seq		= tbean.getBoard_seq();
		title					= Util.getString(tbean.getTitle(),"");
		content					= Util.getString(tbean.getContent(),"");
		virtual_name			= Util.getString(tbean.getVirtual_name(),"");
		real_name				= Util.getString(tbean.getReal_name(),"");

		img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+virtual_name;

	}
}

dao.updateReadnum(current_board_seq);

Tbrd_comment_de_bean[] bestcommentview =  stardao.getBestCommentView(current_board_seq);

if(bestcommentview.length > 0){
	Tbrd_comment_de_bean cbean = bestcommentview[0];
	best_content = Util.getString(cbean.getContent(),"");
}


int comment_seq		= 0;
String user_name	= "";
String user_id		= "";
String isbest		= "";


int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType		= "09";


//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// 게시물 목록
Tbrd_comment_de_bean record [] = stardao.getCommentList(requestedPage, pageSize, part, keyword ,current_board_seq);

// 전체 게시물 수
int allCount = stardao.getCommentTotalCount(part, keyword ,current_board_seq );

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

function chk(){
	var obj = document.f1;
	var uid = "<%=session_id%>";

	if(uid == ""){
		alert("로그인이 필요한 서비스입니다.");
		return false;
	}	

	if(obj.content.value == ""){
		alert("내용을 입력하세요.");
		return false;
	}

	obj.cmd.value = "insert";

	return true;

}

function del(idx){
	if(confirm("삭제하시겠습니까?")){
		var obj = document.f1;
		obj.comment_seq.value = idx;
		obj.cmd.value = "del";

		obj.submit();
	}
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
                        <table width=100% border=0 cellspacing=0 cellpadding=0>
                          <tr><td height=10></td></tr>
                          <tr>
                           <td align=center><img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=Special Them class=btn><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle></td>
                           <td>&nbsp;</td>
                           <td>
                             <%if(recordview.length > 0){%>
								<img src="<%=img_name%>"><br>
								<b><%=title%></b><br>
								<%=content%>	
							 <% }else{%>
								최근에 등록된 주제가 없습니다.
							 <% } %>
                           </td>
                          </tr>
                        </table>                
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
                          <td align=right>
                           <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td class="dblue rpad5">
							  <% if(board_seq > 0){ %>
							  <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value="현재주제보기" class="btn" onclick="location.href='sympathy_list.jsp'" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
							  <% }else{ %>
                              <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value="지난주제보기" class="btn" onclick="location.href='sympathy_prelist.jsp'" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
							  <% } %>
							  </td>                                                                
                            </tr>
                           </table>                           
                          </td>
						</tr>
						</table>                          
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=20></td></tr></table>
                        <table width=100% border=0 cellspacing=0 cellpadding=0>
                          <tr><td height=10></td></tr>
                          <tr>
                           <td align=center><img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=BEST class=btn><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle></td>
                           <td>&nbsp;</td>
                           <td>
                              <% if(bestcommentview.length > 0){ %>
								<%=best_content%>
							  <% }else{ %>
								등록된 Best가 없습니다.		
							  <% } %>
                           </td>
                          </tr>
                        </table>
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=20></td></tr></table>    						
						<br>													
         			     
						 <% if(recordview.length > 0){ %>
						 <!--댓글-->
         			     전체 공감 <%=allCount%>건
         			     <table width=100% border=0 cellspacing=0 cellpadding=0>
         			     	<FORM METHOD=POST name="f1" ACTION="sympathy_ok.jsp" onsubmit="return chk();">
							<INPUT TYPE="hidden" name="cmd">
							<INPUT TYPE="hidden" name="board_seq" value="<%=current_board_seq%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
							<INPUT TYPE="hidden" name="comment_seq">
         			     	<tr height=28 >
                               <td colspan=2 class=lpad10 style='padding-top:7;padding-bottom:7;'>
                               <textarea name=content cols=80 rows=2></textarea><br>
                               <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=submit value=나의공감등록하기 class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                               </td>
         			     	</tr>     
         			     	</FORM>    			
         			     	<% 
							if(record.length <= 0){ %>	
							<tr>
								<td colspan="2" align="center" height="30">데이타가 존재하지 않습니다.</td>
							</tr>
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
									use_yn				= tbean.getUse_yn();
									
									out.println(use_yn);
									
									java.util.Date writeday = tbean.getReg_date();
									String reg_date_string = tbean.getReg_date_String();

									if(use_yn.equals("1")){ 
									
							%>
							
										<tr height=28>
										   <td width=100><%=user_name%>(<%=user_id%>)</td>
										   <td class=tdcolor th style='padding-top:7;padding-bottom:7;'>
										  <%=content%>  <%=reg_date_string%>
										  <% if(session_id.equals(user_id)){ %>
										   <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=X class=btn onclick="javascript:del('<%=comment_seq%>');"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
										   <% } %>
										   </td>
										</tr>
							<%
									}else{
							%>
										<tr height=28>
											<td colspan="2" height="20">
												관리자에 의해 삭제되었습니다.
											</td>
										</tr>
							<%

									}

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
			                      "sympathy_list.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
							        </td>
                                 </tr>
                                </table>
                                <!--페이징 -->
                              </td>
                              <td width=50% align=right></td>
							</tr>
						</table>
                      <% } %>
					 </td>
				   </tr>
				</table>
			 </TD>
			<!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>
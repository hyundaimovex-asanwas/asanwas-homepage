<%--
  - 작성자: 박상배
  - 일자: 2006.05.26
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 여행후기 게시판 상세보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourReview"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>
<%
int board_seq		= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));
int listnum			= ParamUtil.getIntParameter(request.getParameter("listnum"));
String part			= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));	

String key_str = "&part="+part+"&keyword="+keyword;
String board_type	= "01";


//String Session_id	= Util.getString((String)session.getAttribute("memberid"),"");


//out.println("Session_id : " + Session_id);

//############### Connection생성 ##########################
TourReview dao	= new TourReview();
//#########################################################

int ref_board_seq		= 0;
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
int board_top_no		= 0;
String edit_yn			= "";
String use_yn			= "";
int point				= 0;
String password			= "";
String isbest			= "";
java.util.Date writeday = null;
String reg_date_string	= "";



int prev_board_seq  = 0;
int next_board_seq	= 0;

String prev_title		= "";
String next_title		= "";

Tbrd_board_ma_bean[] record = dao.getPrevAndNextBoard(board_seq);

int totalCount = record.length;


dao.updateReadnum(board_seq);
	
for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = record[i];
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
		writeday				= tbean.getReg_date();
		reg_date_string			= tbean.getReg_date_String();
	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	

//content = Util.encodeHTMLSpecialChar(content,11);


%>
<HTML>
<HEAD>
<title></title>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<SCRIPT LANGUAGE="JavaScript">
<!--
function openDel(){
	if(confirm("삭제하시겠습니까?")){
		obj = document.goform;
		obj.action = "review_ok.jsp";
		obj.cmd.value = "del";
		obj.submit();
	}
}

function goReply(){

	document.goform.cmd.value = "reply";
	document.goform.action = "review_reply.jsp";
	document.goform.submit();
	
}


function recommend(){
	if(confirm("추천하시겠습니까?")){
		obj = document.f1;

		obj.cmd.value = "recomm";
		obj.submit();
	}
}

//코멘트 웹페이지 싸이즈 게산 1 
function resize_frame(){
	
	var name = "myframe";
	
	var oBody =  document.frames[name].document.body;
	var oFrame =  document.all[name];

	oFrame.style.height =  oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);	
}
//코멘트 웹페이지 싸이즈 게산 2
function resize_frame1(){
	myframe.history.go(0);
	var name = "myframe";	
	var oBody =  document.frames[name].document.body;
	var oFrame =  document.all[name];
	
	//oFrame.style.height =  453;
	oFrame.style.height =  oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);	
}

//-->
</SCRIPT>
</HEAD>
<!-- mid -->
<body >
<FORM METHOD=POST name="goform">
<INPUT TYPE="hidden" name="cmd">
<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
<INPUT TYPE="hidden" name="part" value="<%=part%>">
<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
<INPUT TYPE="hidden" name="bestidx" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="ref_no" value="<%=ref_no%>">
<INPUT TYPE="hidden" name="level_no" value="<%=level_no%>">
<INPUT TYPE="hidden" name="sort_no" value="<%=sort_no%>">
</FORM>
   <TABLE cellspacing=0 cellpadding=0 width=650>
         <TR>
	        <TD>
		      <TABLE cellspacing=0 cellpadding=0 width=650>
		       <!-- loc -->
		         <TR valign=top>
			        <TD height=50 align=right style='padding-top: 10'>
			        <img src="../../asanway/img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
			        <A HREF=# class=loc>커뮤니티</A> > 
			        <span class=locon>여행후기</span>
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
         				<td class='title'><img src=../../asanway/img/tour_img/bu_blue_title.gif align=texttop class=rmar10>여행후기</td>
         			</tr>
         			<tr><td height=17></td></tr>
         			</table>
         
         			<table width=100% border=0 cellspacing=0 cellpadding=0>
         				<col width=100>
         				<tr><td colspan=8 height=2 class=linec1></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>제목</td>
         					<td class=lpad10 colspan=7>
         					<%=title%>
         					</td>
         				</tr>
         				<tr><td colspan=8 height=1 class=linec0></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>작성자</td>
         					<td class=lpad10><%=user_name%>(<%=user_id%>)</td>
         					<td class='tdcolor th' align=center>등록일</td>
         					<td class=lpad10><%=reg_date_string%></td>
         					<td class='tdcolor th' align=center>조회</td>
         					<td class=lpad10><%=read_num%></td>
         					<td class='tdcolor th' align=center>추천</td>
         					<td class=lpad10><%=recomm_num%></td>
         				</tr>
         				<tr><td colspan=8 height=1 class=linec0></td></tr>         				    
         				<tr height=28>
                          <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=150 valign=top  colspan=8>
                          <%=content%>
                          </td>
         				</tr>
                        <tr><td colspan=8 height=1 class=linec1></td></tr>
						<tr>
							<td colspan=8 height=10></td>
						</tr>
						<% 
						Tbrd_board_ma_bean[] refRecord = dao.getRefList(ref_no); 
						%>
			
						<!-- <tr><td colspan=8 height=1 class=linec1></td></tr> -->
						<tr>
							<td colspan="8">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<col width=10%>
									<col width=40% style='padding:5 3 3 3;'>
									<col width=20%>
									<col width=10%>
									<col width=10%>
									<col width=10%>
									<tr><td colspan=6 height=2 class=linec1></td></tr>
									<tr height=28 align=center>
									 <td class=th>번호</td>
									 <td class=th>제목</td>
									 <td class=th>작성일</td>
									 <td class=th>작성자</td>
									 <td class=th>조회수</td>
									 <td class=th>추천수</td>
									</tr>
									<tr><td colspan=6 height=1 class=linec1></td></tr>
									<% 
									//out.println(list.size());
									if(refRecord.length <= 0){ %>	
									
									<tr align=center height=28 align=center height=35>
										<td colspan="7" align="center" height="30">데이타가 존재하지 않습니다.</td>
									</tr>
									<tr><td colspan=7 height=1 class=linec1></td></tr>
									<%
									}else{
										//리스트 화면에 전시
										for(int i=0;i<refRecord.length; i++){ 
											Tbrd_board_ma_bean tbean = refRecord[i];
											
											ref_board_seq		= tbean.getBoard_seq();
											ref_no				= tbean.getRef_no(); 
											level_no			= tbean.getLevel_no(); 
											sort_no				= tbean.getSort_no(); 
											read_num			= tbean.getRead_num(); 
											title				= tbean.getTitle(); 
											content				= tbean.getContent(); 
											user_name			= tbean.getUser_name(); 
											use_yn				= tbean.getUse_yn(); 
											user_level			= tbean.getUser_level(); 
											board_top_no		= tbean.getBoard_top_no(); 
											user_id				= tbean.getUser_id();
											recomm_num			= tbean.getRecomm_num();
											isbest				= tbean.getBest().trim();
											use_yn				= tbean.getUse_yn().trim();
											
											
											writeday = tbean.getReg_date();
											reg_date_string = tbean.getReg_date_String();
											String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
											String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
									%>
									<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
									 <td>
										<% if(isbest.equals("1")){ %>
											<font color="red">BEST</font>
										<% }else{ %>
											<%=listnum%>
										<% } %>
									 </td>
									 <td>
										<% if(use_yn.equals("0")){ %>
										삭제된 게시물 입니다.
										<% }else{ %>
								&nbsp;&nbsp;<%=re_img%><a href="review_view.jsp?board_seq=<%=ref_board_seq%>&requestedPage=<%=requestedPage%>&listnum=<%=listnum%><%=key_str%>"><%=Util.getStringLimit((title).trim(),30)%></a><%=new_img%>
										<% } %>
									</td>
									<td>
										<% if(use_yn.equals("0")){ %>
										삭제된 게시물 입니다.
										<% }else{ %>
										<%=reg_date_string%>
										<% } %>
									</td>
									<td>
										<% if(use_yn.equals("0")){ %>
										삭제된 게시물 입니다.
										<% }else{ %>
										<%=user_id%>
										<% } %>
									</td>
									<td>
										<% if(use_yn.equals("0")){ %>
										삭제된 게시물 입니다.
										<% }else{ %>
										<%=read_num%>
										<% } %>
									</td>
									<td>
										<% if(use_yn.equals("0")){ %>
										삭제된 게시물 입니다.
										<% }else{ %>
										<%=recomm_num%>
										<% } %>
									</td>
									</tr>
									<tr><td colspan=6 height=1 class=linec1></td></tr>
									<%
										}
									}
									
									%>
								</table>
							</td>
						</tr>
                        <!-- <tr height=28>
                        	<td class='tdcolor th' align=center>이전글</td>
                        	<td class=lpad10>&nbsp;</td>
                        </tr>
                        <tr><td colspan=8 height=1 class=linec0></td></tr>
                        <tr height=28>
                        	<td class='tdcolor th' align=center>다음글</td>
                        	<td class=lpad10>&nbsp;</td>
                        </tr> -->
                        <!-- <tr><td colspan=8 height=1 class=linec1></td></tr>  -->




         			</table><br>
         			<table width=100% border=0 cellspacing=0 cellpadding=0>
         				<% if(session_id.equals(user_id)){ %>
						<tr>
         					<td align=left>
         						<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=수정하기 onclick="location.href='review_edit.jsp?board_seq=<%=board_seq%>'" class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
         						<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=삭제하기 onclick="javascript:openDel()" class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
         					</td>
         				</tr>
						<% } %>
						
         				<tr>
         					<td align=right>
         						<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=추천하기 onclick="location.href='javascript:recommend()'" class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
         						<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=답글쓰기 onclick="location.href='javascript:goReply();'" class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
         						<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=새글쓰기 class=btn onclick="location.href='review_edit.jsp'"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
         						<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록보기 class=btn onclick="location.href='review_list.jsp'"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
         					</td>
         				</tr>
         			</table>
         			<br>
         			<!--댓글-->
					<iframe id="myframe" src="../comment/listComment.jsp?board_seq=<%=board_seq%>" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"  vspace="0" hspace="0" style="overflow:visible; width:100%;"></iframe>
         			
                         			
         			<!--댓글-->
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

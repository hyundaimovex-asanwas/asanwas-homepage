<%--
  - 작성자: 박상배 
  - 일자: 2006.05.26
    -수정자:이소연(2006.07)
  - 저작권 표시: IMJ Korea  
  - 설명: 사용자 - 여행후기 게시판 상세보기
  - 2006.7.24 이소연 추가 : 댓글관련 
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourLove"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>

<%
int board_seq		= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));
int listnum			= ParamUtil.getIntParameter(request.getParameter("listnum"));
String part			= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));	

String key_str = "&part="+part+"&keyword="+keyword;
String board_type	= "13";


//String Session_id	= Util.getString((String)session.getAttribute("memberid"),"");


//out.println("Session_id : " + Session_id);

//############### Connection생성 ##########################
TourLove dao	= new TourLove();
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

String McNum = "5";
String sub = "2";
String pageNum = "2";
String subNum = "2";

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
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function openDel(){
	if(confirm("삭제하시겠습니까?")){
		obj = document.goform;
		obj.action = "event_ok.jsp";
		obj.cmd.value = "del";
		obj.submit();
	}
}

function goReply(){

	document.goform.cmd.value = "reply";
	document.goform.action = "event_reply.jsp";
	document.goform.submit();
	
}


function recommend(){
	if(confirm("추천하시겠습니까?")){
		obj = document.goform;

		obj.cmd.value = "recomm";
		obj.action = "event_ok.jsp";
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

</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/community/tour_gallery_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../../include/community/tour_gallery_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/event/s_event_1_1title.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#">이벤트</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">금강산 Cool Summer Idea Contest</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

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

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/event/s_event_1_bigtitle_1.jpg" border="0" usemap="#Map"></td>
				</tr>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td width="496" height="25" valign="top"><img src="<%=imageServer%>/tour_img/com/0_px.gif" width="8" height="1"><img src="<%=imageServer%>/tour_img/event/s_event_1_love_stitle_1.gif"></td>
								<td width="194"></td>
							</tr>
						</table>
					</td>
				</tr>

				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="70"><col width="148" class="lpad_15 tpad_3">
						<col width="78"><col width="105" class="lpad_15 tpad_3">
						<col width="58"><col width="51" class="lpad_15 tpad_3">
						<col width="58"><col width="62" class="lpad_15 tpad_3">
						<tr><td height="2" colspan="8" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view01.gif"><!-- 제목 --></td>
							<td colspan="7"><strong><%=title%></strong></td>
						</tr>
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view02.gif"><!-- 작성자 --></td>
							<td><%=user_name%>(<%=user_id%>)</td>
							<td><img src="<%=imageServer%>/tour_img/txt_view03.gif"><!-- 등록일 --></td>
							<td><%=reg_date_string%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view04.gif"><!-- 조회 --></td>
							<td><%=read_num%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view05.gif"><!-- 추천 --></td>
							<td><%=recomm_num%></td>
						</tr>
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						<tr>
							<td colspan="8" style="padding:15 15 25 13px;" valign="top" height="230"><%=content%></td>
						</tr>
						</table>
						<!-- view table / -->

						<!-- / list table  -->


						<!-- / list table  -->
						<% 
						Tbrd_board_ma_bean[] refRecord = dao.getRefList(ref_no); 
						%>						
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="370"><col width="80"><col width="90"><col width="45"><col width="45">
						<tr><td height="2" colspan="6" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- 번호 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- 제목 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt03.gif"><!-- 작성일 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt04.gif"><!-- 작성자 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- 조회수 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt06.gif"><!-- 추천수 --></td>
						</tr>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
<% 
if(refRecord.length <= 0){ %>							
						<tr align="center">
							<td height="26" colspan="6" align="center"></td>
							<td align="left" class="tpad_3 lpad_10">데이타가 존재하지 않습니다.</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
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
		use_yn				= tbean.getUse_yn(); 
		user_level			= tbean.getUser_level(); 
		board_top_no		= tbean.getBoard_top_no(); 
		user_id				= tbean.getUser_id();
		user_name           = tbean.getUser_name();
		recomm_num			= tbean.getRecomm_num();
		isbest				= tbean.getBest().trim();
		use_yn				= tbean.getUse_yn().trim();
		
		
		writeday = tbean.getReg_date();
		reg_date_string = tbean.getReg_date_String();
		String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
		String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
%>						
						<tr align="center">
							<td height="26">
                               <% if(isbest.equals("1")){ %>
                               	<font color="red">BEST</font>
                               <% }else{ %>
                               	<%=listnum%>
                               <% } %>							
							</td>
							<td align="left" class="tpad_3 lpad_10">
                               <% if(use_yn.equals("0")){ %>
                               삭제된 게시물 입니다.
                               <% }else{ %>
                                     &nbsp;&nbsp;<%=re_img%><a href="event_view.jsp?board_seq=<%=ref_board_seq%>&requestedPage=<%=requestedPage%>&listnum=<%=listnum%><%=key_str%>"><%=Util.getStringLimit((title).trim(),30)%></a><%=new_img%>
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
                               <%=user_name%>(<%=user_id%>)
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
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
<%
	}
}
%>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->

						<!-- / button  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="13"></td></tr>
						<tr>
							<td class="lpad_5">
							<% if(session_id.equals(user_id)){ %>
							  <a href="event_edit.jsp?board_seq=<%=board_seq%>"><img src="<%=imageServer%>/tour_img/btn/btn_comm_modify.gif" class="btn"></a>
							  <a href="javascript:openDel()"><img src="<%=imageServer%>/tour_img/btn/btn_comm_delete.gif" class="btn"></a>
							<% } %>
							</td>
							<td align="right">
							  <a href="javascript:recommend();"><img src="<%=imageServer%>/tour_img/btn/btn_comm_recommand.gif" class="btn"></a>
							  <% if(!session_id.equals("")){ %>
							  <a href="javascript:goReply();"><img src="<%=imageServer%>/tour_img/btn/btn_comm_replywrite.gif" class="btn"></a>
							  <a href="event_edit.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_newwrite.gif" class="btn"></a>
							  <% } %>
							  <a href="event_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_listview.gif" class="btn"></a>
							</td>
						</tr>
						<tr><td height="50"></td></tr>
						</table>
						<!-- button / -->
						

					</td>
				</tr>
				</table>
				<!--  content / -->
				<table width="750" cellpadding="0" cellspacing="0" border="0">
				<tr><td align="center">
				<!-- / 댓글쓰기 -->
				<iframe id="myframe" src="../comment/listComment.jsp?board_seq=<%=board_seq%>" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"  vspace="0" hspace="0" style="overflow:visible; width:100%;"></iframe>
				<!-- 댓글목록 / -->
				</td></tr>
				</table>
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
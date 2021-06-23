<%--

--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourLove"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
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

		content					= content.replaceAll("\n", "<BR>");
		
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
		obj.action = "loveletter_ok.jsp";
		obj.cmd.value = "del";
		obj.submit();
	}
}

function goReply(){

	document.goform.cmd.value = "reply";
	document.goform.action = "loveletter_reply.jsp";
	document.goform.submit();
	
}


function recommend(){
	if(confirm("추천하시겠습니까?")){
		obj = document.goform;

		obj.cmd.value = "recomm";
		obj.action = "loveletter_ok.jsp";
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
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#">이벤트</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">사랑의 편지 </span></td>
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
				<tr><td><img src="<%=imageServer%>/tour_img/event/s_event_1_bigtitle_1.jpg" border="0" usemap="#Map"></td></tr>
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
						<!-- / read table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="77"><col width="613">
						<tr><td height="2" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view01.gif"><!-- 제목 --></td>
							<td class="tpad_3 lpad_10"><strong><%=title%></strong></td>
						</tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0">
						<col width="142"><col width="204"><col width="152"><col width="192">
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/event_title_4.gif"><!-- 보내는 분 --></td>
							<td class="tpad_3 lpad_10"><%=user_name%>(<%=user_id%>)</td>
							<td><img src="<%=imageServer%>/tour_img/txt_view03.gif"><!-- 등록일 --></td>
							<td><%=reg_date_string%></td>
							<!-- <td align="right" valign="middle" class="rpad_10"><a href="#" class="trad_5"><img src="<%=imageServer%>/tour_img/event_print.gif" border="0"></a> --> <!--인쇄하기--><!-- </td> -->
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr height=26>
							<td><img src="<%=imageServer%>/tour_img/txt_view04.gif"><!-- 조회 --></td>
							<td><%=read_num%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view05.gif"><!-- 추천 --></td>
							<td><%=recomm_num%></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr><td height="10" colspan="4"></td></tr>
						<tr>
							<td class="lpad_10 rpad_10" colspan="4" valign="top" height=250><%=content%></td>
						</tr>
						<tr><td height="10" colspan="4"></td></tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- read table / -->

						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td colspan="2" height="13"></td></tr>
						<tr>
							<td class="lpad_5"><a href="javascript:recommend();"><img src="<%=imageServer%>/tour_img/btn/btn_comm_recommand.gif" class="btn"></a><!-- 추천하기 --></td>
							<td align="right" class="rpad_5">
							  <% if(session_id.equals(user_id)){ %>
							  <a href="loveletter_edit.jsp?board_seq=<%=board_seq%>"><img src="<%=imageServer%>/tour_img/btn/btn_comm_modify.gif" class="btn"></a>
							  <a href="javascript:openDel()"><img src="<%=imageServer%>/tour_img/btn/btn_comm_delete.gif" class="btn"></a>
							  <% } %>
							  <a href="loveletter_list.jsp"><img src="<%=imageServer%>/tour_img/event_bt_4.gif" border="0" class="btn"></a><!-- 목록 보기 --></td>
						</tr>
						</table>
						<!-- button/ -->
					</td>
				</tr>
				</table>
				<!--  content / -->
				<table width="750" cellpadding="0" cellspacing="0" border="0">
				<tr><td align="center">
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
<map name="Map"><area shape="rect" coords="394,16,495,36" href="prevent_list.jsp" onFocus="this.blur();"></map>
</body>
</html>
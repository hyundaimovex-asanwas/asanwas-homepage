<%@ page contentType="text/html;charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<%@ page import="kr.co.imjk.util.StringUtil" %>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%> 
<%@ page import="kr.co.imjk.board.dao.TourPraise"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>
<%
int board_seq		= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));
int listnum			= ParamUtil.getIntParameter(request.getParameter("listnum"));
int position		= Util.parseInt(request.getParameter("position"), 1);
String part			= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));	

String key_str = "&part="+part+"&keyword="+keyword;
String board_type	= "01";


//String Session_id	= Util.getString((String)session.getAttribute("memberid"),"");


//out.println("Session_id : " + Session_id);

//############### Connection생성 ##########################
TourPraise dao	= new TourPraise();
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
String sub = "3";
String pageNum = "3";
String subNum = "1";

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
		title					= clearXSS(tbean.getTitle(),avatag );
		content					= clearXSS(tbean.getContent(),avatag );
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
		prev_title			= clearXSS(tbean.getTitle(),avatag );

	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= clearXSS(tbean.getTitle(),avatag );
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

function openDel(){
	var obj = document.delform;
	if(confirm("정말 삭제하시겠습니까? 원본게시물 삭제 시 답글,댓글도 삭제됩니다. ")){
		obj.cmd.value = "del";
		obj.action = "praise_ok.jsp";
		obj.submit();
	}else{
		return;
	}
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
            <!--  left menu flash --></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm03.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">칭찬하기</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="6"></td></tr>
				<tr>
					<td>
						<table width="690" height="171" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm03.jpg');fixed no-repeat left top;">
						<tr><td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/community/stit_comm03.gif" hspace="5"></td></tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="82"><col width="136" class="lpad_15 tpad_3">
						<col width="78"><col width="105" class="lpad_15 tpad_3">
						<col width="58"><col width="51" class="lpad_15 tpad_3">
						<col width="58"><col width="62" class="lpad_15 tpad_3">
						<tr><td height="2" colspan="8" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view06.gif"><!-- 칭찬할사람 --></td>
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
							<td colspan="8" style="padding:15 15 25 13px;" valign="top" height="230"><%= Util.replaceAll(content,"\n","<br>")%></td>
						</tr>
						</table>
						<!-- view table / -->

						<!-- / 이전글,다음글  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td width="70" height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_prev.gif"></td>
							<td class="lpad_15 tpad_3">
								<%if(prev_board_seq > 0){%>									
							       <a href="praise_view.jsp?board_seq=<%=prev_board_seq%>&requestedPage=<%=requestedPage%>&position=<%=position%><%=key_str%>" class="listtxt05"><%=prev_title%></a>
								<% }else{ %>
                               		이전글이 존재하지 않습니다.
								<% } %>	
							</td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_next.gif"></td>
							<td class="lpad_15 tpad_3">
								<%if(next_board_seq > 0){%>
								  <a href="praise_view.jsp?board_seq=<%=next_board_seq%>&requestedPage=<%=requestedPage%>&position=<%=position%><%=key_str%>" class="listtxt05"><%=next_title%></a>
								<% }else{ %>
								  다음글이 존재하지 않습니다.	
								<% } %>
							</td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						</table>
						<!-- 이전글,다음글 / -->

						<!-- / button  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="13"></td></tr>
						<tr>
							<td class="lpad_5"><!-- <a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_comm_modify.gif" class="btn"></a> -->
							<% if(session_id.equals(user_id)){ %>
							<a href="javascript:openDel();"><img src="<%=imageServer%>/tour_img/btn/btn_comm_delete.gif" class="btn"></a>
							<% } %>
							</td>
							<td align="right"><!-- <a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_comm_recommand.gif" class="btn"></a><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_comm_replywrite.gif" class="btn"></a><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_comm_newwrite.gif" class="btn"></a> --><a href="praise_list.jsp?page=<%=requestedPage%>&position=<%=position%><%=key_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_comm_listview.gif" class="btn"></a></td>
						</tr>
						<tr><td height="50"></td></tr>
						</table>
						<!-- button / -->
						
						
						<table width="750" cellpadding="0" cellspacing="0" border="0">
							<Tr>
								<Td>
						<!-- / 댓글쓰기 -->
						<iframe id="myframe" src="../comment/listComment.jsp?board_seq=<%=board_seq%>" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"  vspace="0" hspace="0" style="overflow:visible; width:100%;"></iframe>
						<!-- 댓글목록 / -->
								</td>
							<tr>
						</table>

						
					</td>
				</tr>
				</table>
				<!--  content / -->
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
<FORM METHOD=POST name="delform">
<INPUT TYPE="hidden" name="cmd">
<INPUT TYPE="hidden" name="board_seq" value=<%=board_seq%>>
<INPUT TYPE="hidden" name="requestedPage" value=<%=requestedPage%>>
<INPUT TYPE="hidden" name="position" value=<%=position%>>
<INPUT TYPE="hidden" name="user_id" value="<%=user_id%>">
</FORM>


</body>
</html>
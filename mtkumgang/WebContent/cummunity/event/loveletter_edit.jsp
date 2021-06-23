<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%> 
<%@ page import="kr.co.imjk.board.dao.TourLove"%>
<%@ page import="kr.co.imjk.util.*"%>


<%
int board_seq 			= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage		= Util.parseInt(request.getParameter("requestedPage"), 1);
String con        		= ParamUtil.getReqParameter(request.getParameter("con"));
String keyword    		= ParamUtil.getReqParameter(request.getParameter("keyword"));

String cmd				= "";

String board_type		= "";
int ref_no				= 0;
int level_no			= 0;
int sort_no				= 0;
String title			= "";
String content			= "";
String user_id			= "";
String user_name		= "";
String user_nick		= "";
String email			= "";
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

String McNum = "5";
String sub = "2";
String pageNum = "2";
String subNum = "2";


if (board_seq > 0){
	//############### Connection생성 ##########################
	TourLove dao = new TourLove();
	//#########################################################

	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	
	ref_no					= bean[0].getRef_no();
	level_no				= bean[0].getLevel_no();
	sort_no					= bean[0].getSort_no();
	title					= bean[0].getTitle();
	content					= bean[0].getContent();
	
	content					= content.replaceAll("\"", "'");
	
	user_id					= bean[0].getUser_id();
	user_name				= bean[0].getUser_name();
//	user_nick				= bean[0].getUser_nick();
	user_level				= bean[0].getUser_level();
//	user_icon				= bean[0].getUser_icon();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	recomm_num				= bean[0].getRecomm_num();
	comment_num				= bean[0].getComment_num();
	board_top_no			= bean[0].getBoard_top_no();
	edit_yn					= bean[0].getEdit_yn();
	use_yn					= bean[0].getUse_yn();
	point					= bean[0].getPoint();
	password				= bean[0].getPassword();
	email					= bean[0].getEmail();
	
	
	//out.println("user_name : " + user_name + "<BR>");
	
	cmd = "edit";
}else{
	cmd = "insert";
	
	user_id		= session_id;
	user_name	= session_name;
	//email		= Util.getString((String)session.getAttribute("memberemail"),"");
}



String saveDirName 		=  Config.getInstance().getProperty("imjkmd","reviewUpload");
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


function chk(f){	
	var uid = "<%=session_id%>";

	if(uid == ""){
		alert("로그인이 필요한 서비스입니다.");
		return;
	}
	
	if(f.title.value==""){
		alert("제목을 입력하세요.");
		f.title.focus();
		return false;
	}
	
	var body1 = document.getElementById("editBox1").html;
	
	var len1=0, j1;
  for (i=0, j1=body1.length;i<j1;i++, len1++){
	if((body1.charCodeAt(i)<0)||(body1.charCodeAt(i)>127)){ 
		len1 = len1+1;
	}
  }
  
  if(len1 <= 0){
		alert ("내용을 입력해주세요");
		document.all.editBox1.focus();
		return false;
	}else{
		document.getElementById("content").value = body1;
	}

	

	return true;

}


function chk1(){	
	var f = document.f1;
	var uid = "<%=session_id%>";

	if(uid == ""){
		alert("로그인이 필요한 서비스입니다.");
		return;
	}
	
	if(f.title.value==""){
		alert("제목을 입력하세요.");
		f.title.focus();
		return;
	}
	
	f.submit();

}

var blnBodyLoaded = false;
var blnEditorLoaded = false;
    
function init(){
	//초기 에디터의 적용해줌
	bodyHtml1 = document.getElementById("content").value;
	
	
	if (bodyHtml1 != "") {
		document.getElementById("editBox1").html = bodyHtml1;
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


<FORM METHOD=POST name="f1" ACTION="loveletter_ok.jsp">
<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="con" value="<%=con%>">
<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
<input type=hidden name=user_name style=width:100; value="<%=user_name%>">
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
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="132"><col width="213" class="lpad_10"><col width="133"><col width="212" class="lpad_10">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/event/event_s_03.gif"><!-- 제목 --></td>
							<td colspan="3"><input type="text" name="title" style="width:555px;" value="<%=title%>"></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_write02.gif"><!-- 보내는 분 --></td>
							<td><%=user_name%>(<%=user_id%>)</td>
							<td></td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="218" align="right"><img src="<%=imageServer%>/tour_img/event/event_s_18.gif"><!-- 내용입력 --></td>
							<td colspan="3"><textarea style="width:555px;height:218px;" name="content" id="content"><%=content%></textarea></td>
						</tr>
						<tr><td height="6" colspan="4"></td></tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- write table / -->
</FORM>
						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="13"></td></tr>
						<tr>
							<td align="right">
                            <%
								if (board_seq > 0){
							%>
							   <a href="javascript:chk1();"><img src="<%=imageServer%>/tour_img/btn/btn_comm_modify.gif" class="btn"></a>
							<% }else{ %>					
							   <a href="javascript:chk1();"><img src="<%=imageServer%>/tour_img/event/s_event_1_lovego_bt_2.gif"  class="btn"></a>
							<% } %>
							   <a href="loveletter_list.jsp"><img src="<%=imageServer%>/tour_img/event_bt_4.gif" border="0"></a>
							</td>
						</tr>
						</table>
						<!-- button/ -->
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


</body>
</html>
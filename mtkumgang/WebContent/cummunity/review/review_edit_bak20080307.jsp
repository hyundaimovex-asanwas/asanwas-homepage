<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%> 
<%@ page import="kr.co.imjk.board.dao.TourReview"%>
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
String sub = "1";
String pageNum = "1";
String subNum = "0";

if (board_seq > 0){
	//############### Connection생성 ##########################
	TourReview dao = new TourReview();
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
	user_nick				= bean[0].getUser_nick();
	user_level				= bean[0].getUser_level();
	user_icon				= bean[0].getUser_icon();
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
		return;
	}else{
		document.getElementById("content").value = body1;
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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">여행후기</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<FORM METHOD=POST name="f1" ACTION="review_ok.jsp">
<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="con" value="<%=con%>">
<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
<input type=hidden name=user_name style=width:100; value="<%=user_name%>">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" height="166" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm011.gif');fixed no-repeat left top;">
						<tr><td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/community/stit_comm01.gif" hspace="5"></td></tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / write table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="72"><col width="1"><col width="284" class="lpad_10">
						<col width="96"><col width="217" class="lpad_10">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write01.gif"><!-- 제목 --></td>
							<td colspan="3">
							<input type="text" name="title" style="width:597px;" value="<%=title%>"></td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write02.gif"><!-- 작성자 --></td>
							<td class="tpad_3"><%=user_name%>(<%=user_id%>)</td>
							<td><img src="<%=imageServer%>/tour_img/txt_write03.gif"><!-- 이메일 --></td>
							<td>
							<input type="text" name="email" style="width:207px;" value="<%=email%>"></td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr><td height="6" colspan="5"></td></tr>
						<tr>
							<td height="218" align="right"><img src="<%=imageServer%>/tour_img/txt_write04.gif" style="margin-right:17px;"><!-- 내용 --></td>
							<td class="bg_dgray"></td>
							<td colspan="3">
                                                                           <OBJECT id="editBox1" style="LEFT: 0px; TOP: 0px" 
							  type=text/x-scriptlet height=340 width=580
							  data="<%=rootServer%>/asanway/edit_tool/editer.jsp?saveDirName=<%=saveDirName%>" VIEWASTEXT>
							</OBJECT>
                            <SCRIPT event="onscriptletevent(name, eventData)" for="editBox1">
                            	if (name == "onafterload") {
                            		blnEditorLoaded = true;
                            		blnBodyLoaded = true;
                            		window.setTimeout(init, 500);
                            	}
                            </SCRIPT>
						    <input type=hidden value="<%=content%>" name="content" id="content">
							</td>
						</tr>
						<tr><td height="6" colspan="5"></td></tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
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
							   <a href="javascript:chk1();"><img src="<%=imageServer%>/tour_img/btn/btn_coom_modify.gif" class="btn"></a>
							<% }else{ %>					
							   <a href="javascript:chk1();"><img src="<%=imageServer%>/tour_img/btn/btn_comm_regis.gif" class="btn"></a>
							<% } %>
							   <a href="review_list.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_listview.gif" class="btn"></a>
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
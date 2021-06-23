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
<HTML>
<HEAD>
<title></title>
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
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
</HEAD>
<!-- mid -->
<body >
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
         
         			<FORM METHOD=POST ACTION="review_ok.jsp" onSubmit="return chk(this);">
					<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
					<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
					<INPUT TYPE="hidden" name="con" value="<%=con%>">
					<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
					<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
					<input type=hidden name=user_name style=width:100; value="<%=user_name%>">
         			<table width=100% border=0 cellspacing=0 cellpadding=0>
         				<col width=100>
         				<tr><td colspan=4 height=2 class=linec1></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>제목</td>
         					<td class=lpad10 colspan=3>
         					<input type=text name=title style=width:300; value="<%=title%>">
         					</td>
         				</tr>
         				<tr><td colspan=4 height=1 class=linec0></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>작성자</td>
         					<td class=lpad10><%=user_name%>(<%=user_id%>)</td>
         					<td class='tdcolor th' align=center>이메일</td>
         					<td class=lpad10><input type=text name=email style=width:100; value="<%=email%>"></td>
         				</tr>
         				<tr><td colspan=4 height=1 class=linec0></td></tr>         				    
         				<tr height=28 colspan=4>
                          <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=150 valign=top colspan=4>
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
         			</table><br>
         			<table width=100% border=0 cellspacing=0 cellpadding=0>         				     			
         				<tr>
         					<td align=right>
         						<%
								if (board_seq > 0){
								%>
								<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=submit value=수정하기 class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								
								<% }else{ %>
								<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=submit value=등록하기 class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								<% } %>
         						<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록보기 class=btn onclick="location.href='review_list.jsp'"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
         					</td>
         				</tr>
         			</table>
         			</FORM>
         			<br>

         			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
         		</td>
         	</tr>
         	</table>
         </TD>
         <!-- //main -->
       </TR>
    </TABLE>
</form>

</BODY>
</HTML>

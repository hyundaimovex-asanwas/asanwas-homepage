<%--
  - 작성자: 임형수
  - 일자: 2006.04.17
  - 에러 수정자 : 이소연 (2006.07)
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 별점코멘트 게시판 처리 페이지 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
int comment_seq			= 0;
String user_id			= "";
String user_name		= "";
String user_level		= "";
String user_icon		= "";
String content			= "";
int star_num			=0;
String title			= ""; 
String use_yn			= "";
String regdate			= "";
String virtual_name		= "";
String real_name		= "";
int star_aver			= 0;
int pageSize			= 5;
int blockSize			= 10;

//String sess_id			= Util.getString((String)session.getAttribute("memberid"),"");

String boardType	= "07";

TourSympathyComment stardao = new TourSympathyComment();

int board_seq = Util.parseInt(request.getParameter("board_seq"), 0);

//out.println("board_seq : " + board_seq + "<BR>");

String part       = ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    = ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&board_seq="+board_seq;

int requestedPage = Util.parseInt(request.getParameter("page"), 1);

int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

int position = Util.parseInt(request.getParameter("position"), 1);

int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


Tbrd_comment_de_bean record [] = stardao.getCommentList(requestedPage, pageSize, part, keyword ,board_seq);

int allCount = stardao.getCommentTotalCount(part, keyword ,board_seq );
int pageCount = Util.getPageCount(rowsPerPage, allCount);
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

%>
<HTML>
<HEAD>
<title></title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--

function chk(){
	var obj = document.f1;
	
	var id = "<%=session_id%>";

	if(id == ""){
		//alert("로그인이 필요한 서비스입니다.");
		popLogin();
		return;
	}

        if(obj.content.value == "" || obj.content.value == "댓글은 500자 이내로 등록할 수 있으며 로그인 후 이용하시기 바랍니다."){
		alert("댓글을 입력해주세요.");
		obj.content.focus();
		return;
	}else{
		if(obj.content.value.length > 500){
			alert("500자 내외로 입력해주세요.");
			obj.content.value = (obj.content.value).substr(0, 500);
			return;
		}else{
			obj.cmd.value = "insertComment";
			obj.target = "ifr";	
			obj.submit();
		}
	}

	


}


function resize_frame(){
	parent.resize_frame();
}

function resize_frame1(){
	parent.resize_frame1();
}

function moveNextObject(currObject)
{
	var strValue = currObject.value;
	var intDataLength = strValue.length;
	if(intDataLength > 100)
	{
		alert("댓글은 500자 이내로만 입력이 가능합니다.");
		currObject.value = strValue.substr(0, 500);
	}
	
}

function colDeleteComment(board_seq, comment_seq){
	if(confirm("삭제 하시겠습니까?")){
		document.f1.comment_seq.value = comment_seq;
		document.f1.board_seq.value = board_seq;
		document.f1.cmd.value = "deleteComment";
		document.f1.action = "comment_ok.jsp";
		document.f1.target = "ifr";
		document.f1.submit();

	}
}

function clearText(thefield){
    if (thefield.defaultValue==thefield.value)
        thefield.value = ""
}

function popLogin() {
   var winOpts="width=370,height=320,scrollbars=no";
   var url = "/member/pop_login.jsp";
   window.open(url,"LoginCheck",winOpts);
}
//-->
</SCRIPT>
</head>

<body onLoad="resize_frame()">
	<FORM METHOD=POST name="f1" ACTION="comment_ok.jsp">
	<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
	<INPUT TYPE="hidden" name="comment_seq" value="">
	<INPUT TYPE="hidden" name="cmd">
						<!-- / 댓글쓰기 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td><img src="<%=imageServer%>/tour_img/community/txt_comm_replytit.gif"></td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="reply_bg05">
						<tr>
							<td><textarea name=content style="width:616px;height:39px;overflow:auto;" onFocus="clearText(this)">댓글은 500자 이내로 등록할 수 있으며 로그인 후 이용하시기 바랍니다.</textarea>
							<img src="<%=imageServer%>/tour_img/btn/btn_reply_regis.gif" class="btnl7" align="absmiddle" style="cursor:hand" onClick="javascript:chk();"></td>
						</tr>
						</table>
</FORM>						
						<!-- 댓글쓰기 / -->

						<!-- / 댓글목록 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="80" style="padding:0 12 0 12"><col width="1"><col width="560" style="padding:0 10 0 15">
	<% 						
	if(record.length <= 0){ 
	%>
						<tr><td colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" colspan="3" align="center">등록된 데이터가 없습니다.</td>
						</tr>
						<tr><td colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
	<%
	}else{
		String starString = "";
		
		int listNum = 0;
		//리스트 화면에 전시
		for(int i=0;i<record.length; i++){ 
			Tbrd_comment_de_bean tbean = record[i];
			
			comment_seq			= tbean.getComment_seq();
			content				= tbean.getContent_de(); 
			user_name			= tbean.getUser_name(); 
			user_id				= tbean.getUser_id(); 
			regdate				= tbean.getReg_date_String();
			star_num			= tbean.getStar_num();
			listNum = BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1));
	%> 
						<tr><td class="bg_lpurple" colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" class="bg_lpurple"><strong><%=user_name%></strong><br>(<%=user_id%>)</td>
							<td class="bg_dgray"></td>
							<td class="bg_lpurple">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><%=content%></td>
								</tr>
								<tr>
									<td class="tpad_5"><img src="<%=imageServer%>/tour_img/bu/bu_dgray_rec.gif" align="texttop" vspace="5"> 
									<span class="fs11"><%=regdate%></span> 
									<% if(session_id.equals(user_id)){ %>
									<a href="javascript:colDeleteComment('<%=board_seq%>', '<%=comment_seq%>');"><img src="<%=imageServer%>/tour_img/btn/btn_s_delete.gif" align="absmiddle"></a>
									<% } %>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td class="bg_lpurple" colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>

	<%
		}
	 }
	%>
						</table>
						<!-- 댓글목록 / -->

						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="60">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "listComment.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
			                 </td>
						</tr>
						</table>
						<!-- paging/ -->
</body>

</html>
<iframe name="ifr" width="0"  height="0"></iframe>
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


Tbrd_comment_de_bean record [] = stardao.getCommentAdminList(requestedPage, pageSize, part, keyword ,board_seq);

int allCount = stardao.getCommentAdminTotalCount(part, keyword ,board_seq );
int pageCount = Util.getPageCount(rowsPerPage, allCount);
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


//String Session_id	= Util.getString((String)session.getAttribute("memberid"),"");
//out.println("Session_id : " + Session_id);

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
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
		alert("댓글은 100자 이내로만 입력이 가능합니다.");
		currObject.value = strValue.substr(0, 100);
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
//-->
</SCRIPT>
<body class="content_bg" onLoad="resize_frame();">
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<FORM METHOD=POST name="f1" ACTION="comment_ok.jsp"  onsubmit="return chk();" >
<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="comment_seq" value="">
<INPUT TYPE="hidden" name="cmd">
</form>
<table width=100% border=0 cellspacing=0 cellpadding=0>
	<% 						
	if(record.length <= 0){ 
	%>
	<tr height=28>
		<td colspan="2" align="center">
			데이타가 존재하지 않습니다.
		</td>
	</tr>
	<%
	}else{
		String starString = "";
		
		int listNum = 0;
		//리스트 화면에 전시
		for(int i=0;i<record.length; i++){ 
			Tbrd_comment_de_bean tbean = record[i];
			
			comment_seq			= tbean.getComment_seq();
			content				= tbean.getContent(); 
			user_name			= tbean.getUser_name(); 
			user_id				= tbean.getUser_id(); 
			regdate				= tbean.getReg_date_String();
			star_num			= tbean.getStar_num();
			listNum = BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1));			  
							
							
							
	%> 
	<tr height=28>
	  <td width="20%" align="center">
		<%=user_name%><br>
		<%=user_id%>
	  </td>
	  <td>
	  <%=content%>  <%=regdate%> 
	  
	  <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=X class=btn onClick="javascript:colDeleteComment('<%=board_seq%>', '<%=comment_seq%>')"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
	  
	  </td>
	</tr>
	<%
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
			                      "listComment.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
			</td>
		 </tr>
		</table>
		<!--페이징 -->
	  </td>
	  <td width=50% align=right></td>
	</tr>
</table>    
<body>

<iframe name="ifr" width="0"  height="0"></iframe>
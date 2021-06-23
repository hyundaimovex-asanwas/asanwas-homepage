<%--
  - 작성자: 임형수
  - 일자: 2006.04.17
  - 에러 수정자 : 이소연 (2006.07)
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 별점코멘트 게시판 처리 페이지 
--%>


<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
//변수 선언
String user_level			="";
String user_icon			="";
String user_nick			="";
String use_yn				= "";
String regdate				= "";
String virtual_name			= "";
String real_name			= "";
int star_aver				= 0;
int pageSize				= 5;
int blockSize				= 10;
//게시판 타입결정
String board_type			= "07";
String comment				= "";
int result					= 0;

// DB연결 객체(ibatis사용)    
TourSympathyComment dao = new TourSympathyComment();

int board_seq				= Util.parseInt(request.getParameter("board_seq"), 0);
int comment_seq				= Util.parseInt(request.getParameter("comment_seq"), 0);
String title				= Util.getString(request.getParameter("title"), "");
String content				= Util.getString(request.getParameter("content"), "");
String cmd					= Util.getString(request.getParameter("cmd"), "");
int star_num				= Util.parseInt(request.getParameter("star_num"), 0);

//if(session_id.equals("")){
%>
	<!--<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert("로그인이 필요한 서비스입니다.");
	history.back();
	//-->
	</SCRIPT>-->
<%
	//return;
//}


Tbrd_comment_de_bean  commentBean = new Tbrd_comment_de_bean();
commentBean.setBoard_seq(board_seq);
commentBean.setComment_seq(comment_seq);
commentBean.setContent(content);
commentBean.setUser_id(session_id);
commentBean.setUser_name(session_name);
//commentBean.setStar_num(star_num);


if(cmd.equals("insertComment")){
	result = dao.insertComment(commentBean);
}else if(cmd.equals("deleteComment")){
	result = dao.deleteUpdate(comment_seq);
	//result = dao.deleteComment(board_seq,comment_seq);
}


if(result>0){
%>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
			alert('성공적으로 처리하였습니다.');
			location.href="listComment.jsp";
			
			parent.resize_frame1();
			//-->
			</SCRIPT>
<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert("실패하였습니다.");
		history.back();
		//-->
		</SCRIPT>
<%
}		
%>
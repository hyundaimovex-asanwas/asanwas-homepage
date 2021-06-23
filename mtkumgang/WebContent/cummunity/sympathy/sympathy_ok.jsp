<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
String cmd					  	= Util.getString(request.getParameter("cmd"),"");

int board_seq					= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage				= ParamUtil.getIntParameter(request.getParameter("requestedPage"));

int comment_seq					= ParamUtil.getIntParameter(request.getParameter("comment_seq"));
String title					= ParamUtil.getReqParameter(request.getParameter("title"));
String content					= ParamUtil.getReqParameter(request.getParameter("content"));
String part						= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword					= ParamUtil.getReqParameter(request.getParameter("keyword"));


//############### Connection생성 ##########################
TourSympathy dao = new TourSympathy();
TourSympathyComment stardao = new TourSympathyComment();
//#########################################################


//String sess_id		= Util.getString((String)session.getAttribute("memberid"),"");
//String sess_name	= Util.getString((String)session.getAttribute("membername"),"");

if(session_id.equals("")){
%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert("회원만 가능한 서비스입니다.");
	history.back();
	//-->
	</SCRIPT>
<%
	return;
}


Tbrd_comment_de_bean bean = new Tbrd_comment_de_bean();

bean.setComment_seq(comment_seq);
bean.setUser_id(session_id);
bean.setUser_name(session_name);
bean.setContent(content);
bean.setBoard_seq(board_seq);

int result = 0;

if(cmd.equals("insert")){
	result = stardao.insertComment(bean);
}else if(cmd.equals("del")){
	result = stardao.deleteComment(board_seq,comment_seq);
}

if(result > 0){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("성공적으로 처리되었습니다.");
location.href="sympathy_list.jsp";
//-->
</SCRIPT>
<%
}else{
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("처리가 실패하였습니다..");
location.href="sympathy_list.jsp";
//-->
</SCRIPT>
<% 
}
%>
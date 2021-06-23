<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.board.dao.TourLove"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage		= ParamUtil.getIntParameter(request.getParameter("requestedPage"));
int bestidx				= ParamUtil.getIntParameter(request.getParameter("bestidx"));

int ref_no 				= Util.parseInt(request.getParameter("ref_no"), 0);
int level_no			= Util.parseInt(request.getParameter("level_no"), 0);
int sort_no				= Util.parseInt(request.getParameter("sort_no"), 0);

String title			= ParamUtil.getReqParameter(request.getParameter("title"));
String content			= ParamUtil.getReqParameter(request.getParameter("content"));
String email			= ParamUtil.getReqParameter(request.getParameter("email"));
String user_name		= ParamUtil.getReqParameter(request.getParameter("user_name"));
String user_nick		= ParamUtil.getReqParameter(request.getParameter("user_nick"));	//사랑의편지: 받는 사람
String user_icon		= ParamUtil.getReqParameter(request.getParameter("user_icon"));	//사랑의편지: 출발일

content					= content.replaceAll("'", "\"");
String cmd				= ParamUtil.getReqParameter(request.getParameter("cmd"));

String con				= ParamUtil.getReqParameter(request.getParameter("con"));
String keyword			= Util.toKSC(ParamUtil.getReqParameter(request.getParameter("keyword")));
String check_y_seq		= Util.getString(request.getParameter("check_y_seq"),"");
String board_type		= "13";

//############### Connection생성 ##########################
TourLove dao = new TourLove();
CommonBoard commonDao = new CommonBoard();
//#########################################################


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

Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

//bean.setBoard_seq(board_seq);




int result = 0;

if(cmd.equals("insert")){
	bean.setBoard_type(board_type);
	bean.setRef_no(0);
	bean.setLevel_no(0);
	bean.setSort_no(0);
	bean.setTitle(title);
	bean.setContent(content);
	bean.setUser_id(session_id);
	bean.setUser_name(user_name);
	bean.setEmail(email);
	bean.setUser_nick(user_nick);
	bean.setUser_level("");
	bean.setUser_icon(user_icon);

	result = dao.insert(bean);
}else if(cmd.equals("edit")){
	bean.setBoard_seq(board_seq);
	bean.setTitle(title);
	bean.setContent(content);
	bean.setUser_name(user_name);
	bean.setEmail(email);
	bean.setUser_nick(user_nick);
	bean.setUser_icon(user_icon);


	result = dao.update(bean);
}else if(cmd.equals("del")){
	result = dao.delete(board_seq);
}else if(cmd.equals("recomm")){
	result = dao.updateRecommnum(board_seq);
}else if(cmd.equals("reply")){
	bean.setBoard_seq(board_seq);
	bean.setBoard_type(board_type);
	bean.setRef_no(ref_no);
	bean.setLevel_no(level_no);
	bean.setSort_no(sort_no);
	bean.setTitle(title);
	bean.setContent(content);
	bean.setUser_id(session_id);
	bean.setUser_name(user_name);
	bean.setEmail(email);
	bean.setUser_nick("");
	bean.setUser_level("");
	bean.setUser_icon("");

	result = dao.reply(bean);
}

if(result > 0){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("성공적으로 처리되었습니다.");
location.href="loveletter_list.jsp";
//-->
</SCRIPT>
<%
}else{
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("처리가 실패하였습니다..");
location.href="loveletter_list.jsp";
//-->
</SCRIPT>
<% 
}
%>
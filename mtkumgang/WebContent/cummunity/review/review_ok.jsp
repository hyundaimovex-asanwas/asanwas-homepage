<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<%@ page import="kr.co.imjk.board.dao.TourReview"%>
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

String title			= clearXSS(ParamUtil.getReqParameter(request.getParameter("title")),avatag );
String content			= clearXSS(ParamUtil.getReqParameter(request.getParameter("content")),avatag );
String email			= clearXSS(ParamUtil.getReqParameter(request.getParameter("email")),avatag );
String user_name		= clearXSS(ParamUtil.getReqParameter(request.getParameter("user_name")),avatag );

content					= content.replaceAll("'", "\"");
String cmd				= ParamUtil.getReqParameter(request.getParameter("cmd"));

String con				= ParamUtil.getReqParameter(request.getParameter("con"));
String keyword			= Util.toKSC(ParamUtil.getReqParameter(request.getParameter("keyword")));
String check_y_seq		= Util.getString(request.getParameter("check_y_seq"),"");
String board_type		= "01";

//############### Connection���� ##########################
TourReview dao = new TourReview();
CommonBoard commonDao = new CommonBoard();
//#########################################################


if(session_id.equals("")){
%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert("ȸ���� ������ �����Դϴ�.");
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
	bean.setUser_nick("");
	bean.setUser_level("");
	bean.setUser_icon("");

	result = dao.insert(bean);
}else if(cmd.equals("edit")){
	bean.setBoard_seq(board_seq);
	bean.setTitle(title);
	bean.setContent(content);
	bean.setUser_name(user_name);
	bean.setEmail(email);

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
alert("���������� ó���Ǿ����ϴ�.");
location.href="review_list.jsp";
//-->
</SCRIPT>
<%
}else{
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("ó���� �����Ͽ����ϴ�..");
location.href="review_list.jsp";
//-->
</SCRIPT>
<% 
}
%>
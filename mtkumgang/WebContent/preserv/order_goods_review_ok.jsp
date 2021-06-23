<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>  
<%@ page import="kr.co.imjk.board.dao.TourProductReview"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage		= ParamUtil.getIntParameter(request.getParameter("requestedPage"));

String title			= ParamUtil.getReqParameter(request.getParameter("reviewType"));
String content			= ParamUtil.getReqParameter(request.getParameter("content"));

String returnUrl        = ParamUtil.getReqParameter(request.getParameter("returnUrl"));

content					= content.replaceAll("'", "\"");
String cmd				= ParamUtil.getReqParameter(request.getParameter("cmd"));
String mode				= ParamUtil.getReqParameter(request.getParameter("mode"));
String board_type		= "11";

//############### Connection생성 ##########################
TourProductReview dao = new TourProductReview();
CommonBoard commonDao = new CommonBoard();
//#########################################################

String sess_id	= "";

Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

bean.setBoard_seq(board_seq);
bean.setBoard_type(board_type);
bean.setRef_no(0);
bean.setLevel_no(0);
bean.setSort_no(0);
bean.setTitle(title);
bean.setContent(content);
bean.setUser_id(session_id);
bean.setUser_name(session_name);
bean.setUser_nick("");
bean.setUser_level("");
bean.setUser_icon("");

int result = 0;

if(cmd.equals("insert")){
	result = dao.insert(bean);
}else if(cmd.equals("del")){
	result = dao.delete(board_seq);
}

if(result > 0){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("성공적으로 처리되었습니다.");
location.href="<%=returnUrl%>";
//-->
</SCRIPT>
<%
}else{
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("처리가 실패하였습니다..");
location.href="<%=returnUrl%>";
//-->
</SCRIPT>
<% 
}
%>
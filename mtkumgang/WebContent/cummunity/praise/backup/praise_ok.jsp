<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.board.dao.TourPraise"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
String cmd					  	= Util.getString(request.getParameter("cmd"),"");

int board_seq					= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage				= ParamUtil.getIntParameter(request.getParameter("requestedPage"));
int position		= Util.parseInt(request.getParameter("position"), 1);

int comment_seq					= ParamUtil.getIntParameter(request.getParameter("comment_seq"));
String title					= ParamUtil.getReqParameter(request.getParameter("title"));
String content					= ParamUtil.getReqParameter(request.getParameter("content"));
String part						= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword					= ParamUtil.getReqParameter(request.getParameter("keyword"));
String user_id					= ParamUtil.getReqParameter(request.getParameter("user_id"));

String key_str = "&part="+part+"&keyword="+keyword;

String board_type				= "03";

//############### Connection생성 ##########################
TourPraise dao = new TourPraise();
TourSympathyComment stardao = new TourSympathyComment();
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

bean.setBoard_type(board_type);
bean.setRef_no(0);
bean.setLevel_no(0);
bean.setSort_no(0);
bean.setTitle(title);
bean.setContent(content);
bean.setUser_id(session_id);
bean.setUser_name(session_name);
bean.setEmail("");
bean.setUser_nick("");
bean.setUser_level("");
bean.setUser_icon("");


int result = 0;

if(cmd.equals("insert")){
	result = dao.insert(bean);
}else if(cmd.equals("del")){
	if(session_id.equals(user_id)){
		result = dao.delete(board_seq);
	}else{
		%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert("아이디가 일치하지 않습니다.");
		history.back();
		//-->
		</SCRIPT>
		<%
		return;
	}
}

if(result > 0){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("성공적으로 처리되었습니다.");
location.href="praise_list.jsp?page=<%=requestedPage%>&position=<%=position%><%=key_str%>";
//-->
</SCRIPT>
<%
}else{
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("처리가 실패하였습니다..");
location.href="praise_list.jsp?page=<%=requestedPage%>&position=<%=position%><%=key_str%>";
//-->
</SCRIPT>
<% 
}
%>
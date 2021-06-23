<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.board.dao.KsTourPrevent"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage		= ParamUtil.getIntParameter(request.getParameter("requestedPage"));


//String title			= Util.toKSC(ParamUtil.getReqParameter(request.getParameter("title")));
//String content			= Util.toKSC(ParamUtil.getReqParameter(request.getParameter("content")));
String title			= ParamUtil.getReqParameter(request.getParameter("title"));
String content			= ParamUtil.getReqParameter(request.getParameter("content"));
content					= content.replaceAll("'", "\"");
String cmd				= ParamUtil.getReqParameter(request.getParameter("cmd"));
String mode				= ParamUtil.getReqParameter(request.getParameter("mode"));
String part				= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword			= ParamUtil.getReqParameter(request.getParameter("keyword"));
String board_type		= "18";

//############### Connection생성 ##########################
KsTourPrevent dao = new KsTourPrevent();
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
bean.setUser_id(sess_id);
bean.setUser_name("어드민");
bean.setUser_nick("");
bean.setUser_level("");
bean.setUser_icon("");


int result = 0;

if(cmd.equals("insert")){
	result = dao.insert(bean);
}else if(cmd.equals("edit")){
	result = dao.update(bean);
}else if(cmd.equals("del")){
	result = dao.delete(board_seq);
}
//out.println(cmd + "<BR>");

//out.println(result);

if(result>0){
   if(cmd.equals("attachDel")){
%>

      <SCRIPT LANGUAGE="JavaScript">
	<!--
	 alert('성공적으로 처리 되었습니다.');
	 parent.delAttachRow();
	
	//-->
	</SCRIPT>
<%
   }else{
%>
    
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	 alert('성공적으로 처리 되었습니다.');
	 parent.location.href="kstour_prevent.jsp";
	//-->
	</SCRIPT>
<%
   }
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert('처리에 실패하였습니다. 잠시후 다시 사용하여 주십시요.');
		history.back();
		//-->
		</SCRIPT>
<%
}		
%>
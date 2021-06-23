<%--
  - 작성자: 임형수
  - 일자: 2006.05.26
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 고객센터>자주 묻는 질문 처리
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
//request parameters
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));

String title			= ParamUtil.getReqParameter(request.getParameter("title"));
String content		= ParamUtil.getReqParameter(request.getParameter("content"));
content						= content.replaceAll("'", "\"");
String cmd				= ParamUtil.getReqParameter(request.getParameter("cmd"));
String part				= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));
String type_code		= ParamUtil.getReqParameter(request.getParameter("type_code"));



//변수 선언
String board_type	= "06";

//DAO
BestQuestion dao = new BestQuestion();
//DTO
Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

bean.setBoard_seq(board_seq);
bean.setBoard_type(board_type);
bean.setTitle(title);
bean.setContent(content);
bean.setUser_id("admin");
bean.setType_code(type_code);



int result = 0;

if(cmd.equals("insert")){
	result = dao.insert(bean);
}else if(cmd.equals("edit")){
	result = dao.update(bean);
}else if(cmd.equals("del")){
	result = dao.delete(board_seq);
}


//out.println("result : " + result);
if(result>0){
%>

	<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert('성공적으로 처리 되었습니다.');
	location.href="tour_question.jsp";
	
	//-->
	</SCRIPT>
<%
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
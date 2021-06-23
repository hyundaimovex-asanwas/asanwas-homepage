<%--
  - �ۼ���: ������
  - ����: 2006.05.26
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ��������>���� ���� ���� ó��
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.board.dao.KsQnABoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
//request parameters
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));

String title			=ParamUtil.getReqParameter(request.getParameter("qnaTitle"));
String content		= ParamUtil.getReqParameter(request.getParameter("content"));
String reply_content		= ParamUtil.getReqParameter(request.getParameter("reply_content"));
content						= content.replaceAll("'", "\"");
reply_content						= reply_content.replaceAll("'", "\"");
String open_yn		= ParamUtil.getReqParameter(request.getParameter("open_yn"));
String cmd				= ParamUtil.getReqParameter(request.getParameter("cmd"));
String part				= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));
String type_code		= ParamUtil.getReqParameter(request.getParameter("type_code"));
String user_id		= ParamUtil.getReqParameter(request.getParameter("user_id"));
String user_name		= ParamUtil.getReqParameter(request.getParameter("user_name"));
String email		=ParamUtil.getReqParameter(request.getParameter("email"));
String tel01		= ParamUtil.getReqParameter(request.getParameter("tel01"));
String tel02		= ParamUtil.getReqParameter(request.getParameter("tel02"));
String tel03		= ParamUtil.getReqParameter(request.getParameter("tel03"));
String password		= ParamUtil.getReqParameter(request.getParameter("password"));
String tel =  tel01+"-"+tel02+"-"+tel03;




//���� ����
String board_type	= "07";

//DAO
KsQnABoard dao = new KsQnABoard();
CommonBoard commonDao = new CommonBoard();
//DTO
Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

bean.setBoard_seq(board_seq);
bean.setBoard_type(board_type);
bean.setTitle(title);
bean.setContent(content);
bean.setReply_content(reply_content);
bean.setUser_id(user_id);
bean.setUser_name(user_name);
bean.setOpen_yn(open_yn);
bean.setTel(tel);
bean.setEmail(email);
bean.setPassword(password);



int result = 0;

if(cmd.equals("insert")){
	result = dao.insert(bean);
}else if(cmd.equals("edit")){
	result = dao.update(bean);
}else if(cmd.equals("insertReply")){
	result = dao.updateReply(bean);
	//���Ϲ߼�
	commonDao.SendMailQnA(request, response);
}else if(cmd.equals("editReply")){
	result = dao.updateReply(bean);
	//���Ϲ߼�
	commonDao.SendMailQnA(request, response);
}else if(cmd.equals("del")){
	result = dao.delete(board_seq);
}


//out.println("result : " + result);
if(result>0){
%>

	<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert('���������� ó�� �Ǿ����ϴ�.');
	location.href="kstour_qna.jsp";
	
	//-->
	</SCRIPT>
<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert('ó���� �����Ͽ����ϴ�. ����� �ٽ� ����Ͽ� �ֽʽÿ�.');
		history.back();
		//-->
		</SCRIPT>
<%
}		
%>
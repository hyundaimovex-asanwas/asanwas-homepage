<%--
  - �ۼ���: ������
  - ����: 2006.04.17
  - ���� ������ : �̼ҿ� (2006.07)
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - �����ڸ�Ʈ �Խ��� ó�� ������ 
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
//���� ����
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
//�Խ��� Ÿ�԰���
String board_type			= "07";
String comment				= "";
int result					= 0;

// DB���� ��ü(ibatis���)    
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
	alert("�α����� �ʿ��� �����Դϴ�.");
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
			alert('���������� ó���Ͽ����ϴ�.');
			location.href="listComment.jsp";
			
			parent.resize_frame1();
			//-->
			</SCRIPT>
<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert("�����Ͽ����ϴ�.");
		history.back();
		//-->
		</SCRIPT>
<%
}		
%>
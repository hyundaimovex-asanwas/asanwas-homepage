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
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
//���� ����
String comment			= "";
int result					= 0;

// DB���� ��ü(ibatis���)    
TourSympathy dao = new TourSympathy();
TourSympathyComment dao2 = new TourSympathyComment();

int board_seq		= Util.parseInt(request.getParameter("board_seq"), 0);
int comment_seq	= Util.parseInt(request.getParameter("comment_seq"), 0);
String cmd       = ParamUtil.getReqParameter(request.getParameter("cmd"));
String return_url = "";

 if(cmd.equals("comment_del")){
	result = dao2.deleteUpdate(comment_seq);
	return_url = "tour_praise_view.jsp?board_seq="+board_seq;
}else if(cmd.equals("board_del")){
        
	result = dao.deleteUpdate(board_seq);
	return_url = "tour_praise.jsp";
}


if(result > 0){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("���������� ó���Ǿ����ϴ�.");
         location.href='<%=return_url%>';
//-->
</SCRIPT>
<%
}else{
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
       alert("ó���� �����Ͽ����ϴ�..");
       location.href='<%=return_url%>';
//-->
</SCRIPT>
<% 
}
%>
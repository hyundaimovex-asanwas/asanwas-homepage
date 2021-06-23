<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
	Plz_BoardBean pb = new Plz_BoardBean();
	CommonBoard commonDao = new CommonBoard();
	
	int result = pb.Update_adm(request, response);
	//commonDao.SendPLZMailQnA(request, response);
	
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('수정되었습니다.');
			location.href = "go4peace_qna.jsp?category=go4qna";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 수정되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>
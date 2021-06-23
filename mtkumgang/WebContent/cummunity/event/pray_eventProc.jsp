<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.net.*"%>
<%@ page import="com.hmm.ejb.common.UtilDB"%>
<%

String id = session_id;
String name       = session_name;
String content       = ParamUtil.getReqParameter(request.getParameter("content"));

String query = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs    = null;
int result = 0;
try{
		conn = UtilDB.getConnection("jdbc/tourds"); 
		query = "INSERT INTO ASAN.EVENT_WISH (ID, NAME, CONTENT, I_DATE) VALUES ('"+id+"', '"+name+"','"+content+"', CURRENT TIMESTAMP)";
		pstmt=conn.prepareStatement(query);
		pstmt.executeUpdate();
	}catch (Exception e) {
		e.printStackTrace();
		System.out.println("Exception during connection :"+e.getMessage());
	} finally {
		UtilDB.closeConnection(conn, pstmt, rs);
	}

%>

<script language="javascript">
<!--
function frmchk(){
	var f = document.frm;
	alert("등록 되었습니다");
	f.action = "pray_event_write.jsp";
	f.submit();
}
-->
</script>

<form name="frm" method="post">
</form>

<script language="javascript">frmchk();</script>
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

if( id == null || id.equals("") ){
%>
<script language="javascript">
		alert("로그인을 하여주세요.");
		opener.location.href = "../../member/login.jsp";
		window.close();
</script>
<%
}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	
	String name = session_name;
	String query = "";
	
	try{
		conn = UtilDB.getConnection("jdbc/tourds"); 
		
		query = " select count(*) as cnt from ASAN.EVENT_MTKG where ev_id=? and id=? ";
		pstmt = conn.prepareStatement(query);
		pstmt.setInt(1, 2);
		pstmt.setString(2, id);
		
		rs   = pstmt.executeQuery();
		
		int cnt = 0;
		if( rs.next() ){
			cnt = rs.getInt("cnt");
		}
		
		if( cnt > 0 ){
%>
<script language="javascript">
	alert("이미 응모하셧습니다.");
	window.close();
</script>
<%
		}
		
	}catch(Exception ex){
		out.println(ex.getMessage());
		ex.printStackTrace();
		System.out.println("Exception during connection :"+ex.getMessage());
	}finally{
		UtilDB.closeConnection(conn, pstmt, rs);
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>같은그림 찾기 카드게임~</title>
<script language="javascript">
<!--
	function chkConfirm(){
		obj = document.getElementById("frm");
		
		obj.action = "./event_1_proc.jsp";
		obj.target = "hiddenFrame";
		obj.submit();
	}
	
	function chkComplete(){
		window.close();
	}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="javascript">
                  writeObject("/asanway/img/swf/071110_event/event1.swf","899","680","transparent")
              </script>
</body>
<form name="frm" id="frm" method="post">
</form>
<iframe name="hiddenFrame" id="hiddenFrame" src="" frameborder="0" width="0" height="0"></iframe>
</html>

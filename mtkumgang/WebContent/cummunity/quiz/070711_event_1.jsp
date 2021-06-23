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
String evtchk = "";
String query = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs    = null;
int result = 0;
try{
		conn = UtilDB.getConnection("jdbc/tourds"); 
		//탈퇴 회원 은 로그인 할수없다.
		pstmt = conn.prepareStatement("select * from asan.MT_EVENT  where ID = ?");
		pstmt.setString(1, id);
		rs   = pstmt.executeQuery();
		if( rs.next() ) {
			evtchk = "Y";
			query = "DELETE ASAN.MT_EVENT WHERE ID='lyjtotoro'";
			pstmt=conn.prepareStatement(query);
            pstmt.executeUpdate();
		}else{
			evtchk = "N";
		}
	}catch (Exception e) {
		e.printStackTrace();
		System.out.println("Exception during connection :"+e.getMessage());
	} finally {
		UtilDB.closeConnection(conn, pstmt, rs);
	}


if(session_id.equals("")){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("로그인 해주세요.");
opener.location.href= "http://www.mtkumgang.com/member/login.jsp";
window.self.close();
//-->
</SCRIPT>
<%
}
%>
<html>
<head>
<title>금강산 광관 퀴즈풀기 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script language="javascript">
<!--
function evtend(){
	alert("이미 이벤트에 참여하셨습니다.");
	return;
}

function goevt(){
	var f = document.frm;
	f.action = "070711_event_2.jsp";
	f.submit();
}
-->
</script>
</head>
<body>
<table cellpadding="0" cellspacing="0">
<tr>
	<td background="<%=imageServer%>/quiz_img/bg.gif" width="700" height="650">
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td height="166"></td>
	</tr>
	<tr>
		<td height="428" valign="top">
		<table cellpadding="0" cellspacing="0">
		<tr>
			<td width="118"></td>
			<td valign="top"><img src="<%=imageServer%>/quiz_img/event_ima_1.gif"></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="56" valign="top">
		<table cellpadding="0" cellspacing="0">
		<tr>
			<td width="62"></td>
			<td><img src="<%=imageServer%>/quiz_img/event_ima_2.gif"></td>
			<td>
			<%if(evtchk.equals("Y")){%>
			<a href="javascript:evtend();">
			<%}else{%>
			<a href="javascript:goevt();">
			<%}%>
			<img src="<%=imageServer%>/quiz_img/event_bt_1.gif" border="0"></a></td>
			<td width="74"></td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	</td>
</tr>
</table>
<form name="frm" method="post">
</form>
</body>
</html>

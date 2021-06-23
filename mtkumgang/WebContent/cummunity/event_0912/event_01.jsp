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
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	
	String id = session_id;
	int cnt = 0;
	
	try{
		conn = UtilDB.getConnection("jdbc/tourds"); 
		
		String query = " select count(*) as cnt from ASAN.EVENT_MTKG where id=? ";
		
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		
		rs   = pstmt.executeQuery();
		
		if( rs.next() ){
			cnt = rs.getInt("cnt");
		}
		
		
	}catch(Exception ex){
		out.println(ex.getMessage());
		ex.printStackTrace();
		System.out.println("Exception during connection :"+ex.getMessage());
	}finally {
		UtilDB.closeConnection(conn, pstmt, rs);
	}
%>

<html>
<head>
<title>금강송이 찾기 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="javascript">
<!--
	function goEvent(URL){
		<%
			if( cnt > 0 ){
		%>
		alert("이미 이벤트에 참여하셨습니다.");
		<%
			}else{
		%>
		this.location.href = URL;
		<%
			}
		%>
	}
//-->
</script>
</head>

<body style="margin:0">
<table width="800" height="600" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td colspan="3"><img src="<%=imageServer%>song_img/img_tit.jpg" width="800" height="178"></td>
  </tr>
  <tr> 
    <td width="110"><img src="<%=imageServer%>song_img/img_01.jpg" width="110" height="380"></td>
    <td width="580"><img src="<%=imageServer%>song_img/img_map.jpg" width="580" height="380" border="0" usemap="#Map"></td>
    <td width="110"><img src="<%=imageServer%>song_img/img_02.jpg" width="110" height="380"></td>
  </tr>
  <tr> 
    <td colspan="3"><img src="<%=imageServer%>song_img/img_03.jpg" width="800" height="42"></td>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="20,117,185,358" href="javascript:goEvent('event_02a.jsp');">
  <area shape="rect" coords="207,116,372,357" href="javascript:goEvent('event_02b.jsp');">
  <area shape="rect" coords="392,115,559,358" href="javascript:goEvent('event_02c.jsp');">
</map>
</body>
</html>

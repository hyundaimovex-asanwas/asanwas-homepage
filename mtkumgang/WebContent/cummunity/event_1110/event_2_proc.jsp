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
	String name = session_name;
	String query = "";
	
	try{
		conn = UtilDB.getConnection("jdbc/tourds"); 
		
		query = " select count(*) as cnt from ASAN.EVENT_MTKG where ev_id=? and id=? ";
		pstmt = conn.prepareStatement(query);
		pstmt.setInt(1, 3);
		pstmt.setString(2, id);
		
		rs   = pstmt.executeQuery();
		
		int cnt = 0;
		if( rs.next() ){
			cnt = rs.getInt("cnt");
		}
		
		if( cnt <= 0 ){
			query = "insert into ASAN.EVENT_MTKG(EV_ID, ID, NAME) values(?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, 3);
			pstmt.setString(2, id);
			pstmt.setString(3, name);
			
			int result = pstmt.executeUpdate();
		}
		
	}catch(Exception ex){
		out.println(ex.getMessage());
		ex.printStackTrace();
		System.out.println("Exception during connection :"+ex.getMessage());
	}finally{
		UtilDB.closeConnection(conn, pstmt, rs);
	}
%>
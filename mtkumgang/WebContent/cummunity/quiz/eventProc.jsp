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
int quiz1 = ParamUtil.getIntParameter(request.getParameter("quiz1"));
int quiz2 = ParamUtil.getIntParameter(request.getParameter("quiz2"));
int quiz3 = ParamUtil.getIntParameter(request.getParameter("quiz3"));
int quiz4 = ParamUtil.getIntParameter(request.getParameter("quiz4"));
int quiz5 = ParamUtil.getIntParameter(request.getParameter("quiz5"));
int quiz6 = ParamUtil.getIntParameter(request.getParameter("quiz6"));
int quiz7 = ParamUtil.getIntParameter(request.getParameter("quiz7"));


int totcnt = quiz1 + quiz2 + quiz3 + quiz4 + quiz5 + quiz6 + quiz7;
String imgurl = "";
if(totcnt < 4){
	imgurl = "quiz_fin_3.gif";
}else if(totcnt > 3 && totcnt <= 5){
	imgurl = "quiz_fin_2.gif";	
}else if(totcnt > 5){
	imgurl = "quiz_fin_1.gif";
}

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
			query = "INSERT INTO ASAN.MT_EVENT (EVENT_SID, ID, ITEM1, I_DATE) VALUES (1, '"+id+"', '"+totcnt+"', CURRENT TIMESTAMP)";
			pstmt=conn.prepareStatement(query);
            pstmt.executeUpdate();
		}
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
	f.action = "070711_event_9.jsp";
	f.submit();
}
-->
</script>

<form name="frm" method="post">
<input type="hidden" name="totcnt" value="<%=totcnt%>">
<input type="hidden" name="imgurl" value="<%=imgurl%>">
</form>

<script language="javascript">frmchk();</script>
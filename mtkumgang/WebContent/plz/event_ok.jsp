<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>

<%@ page import="java.util.Calendar" %>

<%
	Calendar today=Calendar.getInstance();

	int year=today.get(Calendar.YEAR);
	int month=today.get(Calendar.MONTH)+1;
	int day=today.get(Calendar.DATE);

	String reg_date = year + "-" + month + "-" +day;
%>

<%
String name = request.getParameter("name");
String hp1 = request.getParameter("hp1");
String hp2 = request.getParameter("hp2");
String hp3 = request.getParameter("hp3");

String sql="INSERT INTO ASAN.PLZ_EVENT_090419 (NAME, HP1, HP2, HP3, REG_DATE) VALUES ('"+name+"', '"+hp1+"', '"+hp2+"', '"+hp3+"', '"+reg_date+"')";

Connection conn = null;
Statement stmt = null;

int result = 0;

try {
	Context ctx = new InitialContext();
	DataSource ds = (DataSource) ctx.lookup("jdbc/tourds");

	if (ds != null) {
		conn = ds.getConnection();
	}

	stmt = conn.createStatement();
	result = stmt.executeUpdate(sql);

} catch(SQLException e) {
	out.println(e.toString());
} finally {
	if(stmt != null) {
		stmt.close();
	}

	if(conn != null) {
		conn.close();
	}
}
%>

<% if(result <= 0) { %>
	<script>alert("등록 중 에러가 발생하였습니다.");</script>
<% } else { %>
	<script>alert("응모가 완료되었습니다.");parent.close();</script>
<% } %>
	
	
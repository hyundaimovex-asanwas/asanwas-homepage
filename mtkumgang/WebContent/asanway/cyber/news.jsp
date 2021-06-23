<%@page contentType="text/html;charset=EUC_KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.hmm.ejb.common.*" %>
<html>
<body>


<%
        Connection conn = null;
        Statement  stmt = null;
        ResultSet rs    = null;
		PreparedStatement pstmt = null;

        try {
                conn = UtilDB.getConnection("java:comp/env/jdbc/asands");
				 stmt = conn.createStatement();

				 String sqlQuery =   "SELECT * FROM asan.notice where category='news' order by idx desc FETCH FIRST 10 ROWS ONLY ";
			rs = stmt.executeQuery(sqlQuery);
				
%>
        <center><b>JDBC SAMPLE</b><br></center>
        <table>
        <tr>
	        <td>IDX
	        <td>category
	        <td>ID
	        <td>name
	        <td>title
	        
	        <td>
	        <td>content
	        <td>
	        <td>filename	        
	        <td>sysfilename

	        <td>
	        <td>
	        <td>
	        <td>
	        <td>

	        <td>reguser
	        <td>regtime
	        <td>regip
	        <td>lastuser
	        <td>lasttime
	        
	        <td>lastip
	        <td>status
	        <td>isdel


<%
                while (rs.next()) {
%>
                <tr bgcolor=#F0EEEE>
                        <td><%=rs.getString(1)%>
                        <td><%=rs.getString(2)%>
                        <td><%=rs.getString(3)%>
                        <td><%=rs.getString(4)%>
                        <td><%=rs.getString(5)%>
                        <td><%=rs.getString(6)%>
                        <td><%=rs.getString(7)%>
                        <td><%=rs.getString(8)%>
                        <td><%=rs.getString(9)%>
                        <td><%=rs.getString(10)%>
                        <td><%=rs.getString(11)%>
                        <td><%=rs.getString(12)%>
                        <td><%=rs.getString(13)%>
                        <td><%=rs.getString(14)%>
                        <td><%=rs.getString(15)%>
                        <td><%=rs.getString(16)%>
                        <td><%=rs.getString(17)%>
                        <td><%=rs.getString(18)%>
                        <td><%=rs.getString(19)%>
                        <td><%=rs.getString(20)%>                                                                                                                                                                                                
                        <td><%=rs.getString(21)%>                                                                                                                                                                                                
                        <td><%=rs.getString(22)%>                                                                                                                                                                                                
                        <td><%=rs.getString(23)%>                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                        
                </tr>
<%
                }				
                rs.close();
                stmt.close();
                conn.close();
        } catch(Exception e) {
                        out.println("Exception during connection:"+e.getMessage());
        } finally {     
                if ( stmt != null ) try {stmt.close();}catch(Exception e){}
                if ( conn != null ) try {conn.close();}catch(Exception e){}
        }
%>      
        </table>
        
        
</body>
</html>

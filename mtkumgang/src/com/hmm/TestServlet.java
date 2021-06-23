package com.hmm;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hmm.ejb.common.*;

/**
 * @author csangsu
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TestServlet extends HttpServlet 
{
    public void doGet(HttpServletRequest re, HttpServletResponse res)
    throws ServletException, IOException
    {
    	Connection conn = null;
    	Statement  stmt = null;
    	ResultSet rs    = null;
    	PrintWriter out;
    	out = res.getWriter();
    	res.setContentType("text/html; charset=EUC-KR");
    	re.setCharacterEncoding("EUC-KR");
    	try {
	    	conn = UtilDB.getConnection("jdbc/asands");
	    	stmt = conn.createStatement();
	    	String sqlQuery =   "SELECT * FROM asan.notice";
	
	    	rs   = stmt.executeQuery(sqlQuery);
	    	out.println("<html>");
	    	out.println("<head><title>테스트페이지입니다.</title></head>");
	    	out.println("<body>");
	    	out.println("<center><b>JDBC SAMPLE</b><br></center>");
	    	out.println("<table>");
	    	out.println("        <tr bgcolor=#D8D8BD>");
	    	out.println("                <td align=center>=====</td>");
	    	out.println("        </tr>");
	        while (rs.next()) {
		    	out.println("                <tr bgcolor=#F0EEEE>");
		    	out.println("                        <td>" + rs.getString(1) + "</td>");
		    	out.println("                </tr>");
	        }
	
	        rs.close();
	        stmt.close();
	        conn.close();
        } catch(Exception e) {
            System.out.println("Exception during connection:"+e.getMessage());
        } finally {     
            UtilDB.closeConnection(conn, stmt, rs);
        }
    	out.println("        </table>");
    	out.println("</body>");
    	out.println("</html>");
    }
}
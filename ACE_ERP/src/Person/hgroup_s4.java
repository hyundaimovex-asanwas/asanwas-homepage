package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import common.*;

//근태신청
public class hgroup_s4 extends HttpServlet {
 public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException  {
	 res.setContentType("text/html;charset=ksc5601");
   Connection conn = null;
	 PreparedStatement stmt =null;
	 StringBuffer UpdateSql = null;
	 PrintWriter out = res.getWriter();
	 String strFlag="N";

	 //CallableStatement stmt =null;
   //
	 try {   

				String strParam = req.getParameter("v_str");
				String strParam2 = req.getParameter("detail");

				String [] strTemp= strParam.split(";");   // 0 - flag(CLOSYN)  //1 - docid
				String [] strTemp2= strParam2.split(";");  // HLNO
        
				strFlag = strTemp[0];

        hdconn hdasanconn = new hdconn();
        conn = hdasanconn.getHdConnection();

				//out.println("<html>");
				//out.println("<head><title>Hello Servlet</title><meta http-equiv='Content-Type' content='text/html; charset=euc-kr'></head>");
				//out.println("<body>");

				for(int i=0;i<strTemp2.length;i++){
					 
					UpdateSql = new StringBuffer();
					UpdateSql.append( " UPDATE PAYROLL.HLDUTY SET CLOSYN='"+strFlag+"'");
					UpdateSql.append( "  WHERE HLNO ='"+strTemp2[i]+"'");
				
					stmt = conn.prepareStatement(UpdateSql.toString());						
					stmt.executeUpdate();
					stmt.close();		
				}
			
			  /*
        for(int j =0;j<strTemp.length;j++){
					out.println("strTemp["+j+"] ::" + strTemp[j]);
				}

				for(int k =0;k<strTemp2.length;k++){
					out.println("strTemp2["+k+"] ::" + strTemp2[k]);
				}
        */

				//out.println("iTcnt::" + iTcnt);
				//out.println("icnt::" + icnt);
				//out.println("UpdateSql.toString()::" + UpdateSql.toString());
				//out.println("</body>");
				//out.println("</html>");
				
        out.println("<root><result>OK</result><flag>"+strFlag+"</flag></root>");
				out.close();
	 } catch (Exception e) {
		    out.println("<root><result>FAILL</result><flag>"+strFlag+"</flag></root>");
				out.close();
	 } finally {
			  if (stmt != null) try { stmt.close();} catch (Exception e) {}
				if (conn != null) try { conn.close();} catch (Exception e) {}
	 }
  }
}

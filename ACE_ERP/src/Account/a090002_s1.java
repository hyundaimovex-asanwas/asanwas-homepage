package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a090002_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
	
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //자산분류
				String  str3 = req.getParameter("v_str3");    //자산명

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ASNBR", "ASNAM", "ASAQSDAT","ASLIFYER", "QSAMT", "DSANGAMT", "JANAMT" ,"LASTYM", "ASTNUM", "CDNAM" }; 

				int[] intArrCN = new int[]{11, 30, 8, 3, 13, 13, 13, 6, 11, 30}; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, 0, 0, 0, 0, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT (CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S' \n");
					sql.append( " WHEN '03' THEN 'K' WHEN '04' THEN 'G' END|| \n");
					sql.append( " CASE A.AST2ND WHEN '11' THEN 'L'  WHEN '12' THEN 'B'  WHEN '13' THEN 'S' \n");
					sql.append( " WHEN '14' THEN 'V' WHEN '15' THEN 'I' WHEN '16' THEN 'F' WHEN '17' THEN 'E' \n");
					sql.append( " END||CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B' WHEN '03' THEN 'C' \n");
					sql.append( " WHEN '04' THEN 'O'  WHEN '05' THEN 'T' WHEN '06' THEN 'F' \n");
					sql.append( " WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ) as ASNBR, \n");
					sql.append( " B.ASTNAME AS ASNAM, ASAQSDAT, \n");
					sql.append( " COALESCE(C.ASTYUSE,0) AS ASLIFYER, COALESCE(C.ASTAQAMT,0) AS QSAMT, COALESCE(A.ACDEPRAMT,0) AS DSANGAMT, \n");
					sql.append( " (COALESCE(C.ASTAQAMT,0) - COALESCE(A.ABDEPRAMT,0) - COALESCE(A.ACDEPRAMT,0)) AS JANAMT, \n");
					sql.append( " COALESCE(SUBSTR(A.DEPRENDDT,1,6),'') AS LASTYM, \n");	    
					sql.append( " (A.AST1ST||A.AST2ND||A.AST3RD||A.ASTSEQ) AS ASTNUM, X.CDNAM \n");
					sql.append( " FROM (account.astdepr A left outer join account.astmst B on  \n");
					sql.append( " A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE AND A.AST1ST=B.AST1ST AND \n");
					sql.append( " A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ ) left outer join account.astbasic C on \n");
					sql.append( " A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE AND A.AST1ST=C.AST1ST AND \n");
					sql.append( " A.AST2ND=C.AST2ND AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ \n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL X ON B.ASTNAME=X.CDCODE AND X.CMTYPE='2161' \n");
					sql.append( " WHERE A.AST2ND>'11' \n");
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' \n" );
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' \n" );
					if (!str3.equals("")) sql.append( " AND B.ASTNAME LIKE '" + str3 + "%' \n" );
			
					//logger.dbg.println( this, sql.toString() );
					
/*********************************************************************************************/

				stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		
		  
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}
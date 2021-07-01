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
public class a090024_s2 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //지점      
				String  str2 = req.getParameter("v_str2");    //자산분류  
				String  str3 = req.getParameter("v_str3");    //자산명코드
				String  str4 = req.getParameter("v_str4");    //상태      
                String  str5 = req.getParameter("v_str5");    //원가코드  

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"FDCODE",  "ATCODE",  "AST1ST", "AST2ND",  "AST3RD",
					                               "ASTSEQ",  "CHGNO",   "CHGDATE","CHGTYPE", "CHGAMT",
					                               "CHGAMT2", "CHGAMT3", "COSTCD", "ASTNAME", "COSTNM",
					                               "ASTNM",   "ASTNBR"
				                                };  
				int[] intArrCN = new int[]{ 2,  7, 2,  2,  2, 
                                    5,  4, 8,  1, 13,
                                   13, 13, 6,  5, 40,
					                        100,  8
					                        };  
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1,  0,
					                            0,  0, -1, -1, -1,
					                           -1, -1
  			                            }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.FDCODE,  A.ATCODE,  A.AST1ST,  A.AST2ND,  A.AST3RD,             \n");
					sql.append( "        A.ASTSEQ,  A.CHGNO,   A.CHGDATE, A.CHGTYPE, A.CHGAMT,             \n");
					sql.append( "        A.CHGAMT2, A.CHGAMT3, B.COSTCD,  C.ASTNAME, D.CDNAM AS COSTNM,    \n");
					sql.append( "        E.ASTNM,   C.ASTNBR                                               				\n");
					sql.append( "   FROM ACCOUNT.ASTCHG A                                                  		\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTBASICN B ON A.FDCODE = B.FDCODE        \n");
					sql.append( "                                AND A.ATCODE = B.ATCODE                   			\n");
					sql.append( "                                AND A.AST1ST = B.AST1ST                   			\n");
					sql.append( "                                AND A.AST2ND = B.AST2ND                   			\n");
					sql.append( "                                AND A.AST3RD = B.AST3RD                   			\n");
					sql.append( "                                AND A.ASTSEQ = B.ASTSEQ                   			\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN C ON A.FDCODE = C.FDCODE           \n");
					sql.append( "                              AND A.ATCODE = C.ATCODE                     			\n");
					sql.append( "                              AND A.AST1ST = C.AST1ST                     			\n");
					sql.append( "                              AND A.AST2ND = C.AST2ND                     			\n");
					sql.append( "                              AND A.AST3RD = C.AST3RD                     			\n");
					sql.append( "                              AND A.ASTSEQ = C.ASTSEQ                     			\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL D ON B.COSTCD = D.CDCODE AND CMTYPE='0030'  \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME  E ON E.AST2ND = A.AST2ND        \n");
					sql.append( "                               AND E.AST3RD = A.AST3RD                    		\n");
					sql.append( "                               AND E.ASTCD = C.ASTNAME                    		\n");
					sql.append( "  WHERE 1=1                                                               				\n");			
					if (!str1.equals(""))sql.append( " AND A.FDCODE ='" + str1 + "'                        		\n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND ='" + str2 + "'                        		\n");
					if (!str3.equals(""))sql.append( " AND C.ASTNAME ='" + str3 + "'                        	\n");
					if (!str4.equals(""))sql.append( " AND A.CHGTYPE ='" + str4 + "'                        	\n");
					if (!str5.equals(""))sql.append( " AND B.COSTCD ='" + str5 + "'                        		\n");
					sql.append( " ORDER BY C.ASAQSDAT, C.ASTNBR                                            \n");

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
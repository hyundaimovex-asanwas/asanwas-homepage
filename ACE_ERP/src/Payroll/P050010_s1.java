package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class P050010_s1 extends HttpServlet {

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
				// 웹페이지에서 조건값을 넘겨받기



				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2"); 
				String  str3	= req.getParameter("v_str3"); 


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "SEQID", "RESINO", "EMPNMK", "CARDNO", "DIVNM",
					                              "APPNO", "APPDT", "SALEDT", "SETTDT", "SALAMT", 
				                                  "CANAMT", "REQAMT", "MBERNO", "MEMBER", "MBERRESINO",
																					"MBERCD", "MBERNM","CLOSEYN","I_EMPNO","U_EMPNO"
				}; 

				int[] intArrCN = new int[]{5,  13,  20,  16,  60,
					                        8,  8,  8,  8, 7, 
				                           7,  7, 9, 100, 10,
																		4, 100, 1, 7, 7
				}; 
			
				int[] intArrCN2 = new int[]{ 0, -1, -1, -1, -1, 
					                         -1, -1, -1, -1, 0,
					                         0, 0, -1, -1, -1,
																		-1, -1, -1, -1, -1
				}; 



				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(SEQID) SEQID, RTRIM(RESINO) RESINO, RTRIM(EMPNMK) EMPNMK, RTRIM(CARDNO) CARDNO, RTRIM(DIVNM) DIVNM,  \n" );
					sql.append( "        RTRIM(APPNO) APPNO, RTRIM(APPDT) APPDT, RTRIM(SALEDT) SALEDT, RTRIM(SETTDT) SETTDT, RTRIM(SALAMT) SALAMT,   \n" );
					sql.append( "        RTRIM(CANAMT) CANAMT, RTRIM(REQAMT) REQAMT, RTRIM(MBERNO) MBERNO, RTRIM(MEMBER) MEMBER, RTRIM(MBERRESINO) MBERRESINO,   \n" );
					sql.append( "        RTRIM(MBERCD) MBERCD, RTRIM(MBERNM) MBERNM, RTRIM(CLOSEYN) CLOSEYN, I_EMPNO, U_EMPNO   \n" );
					sql.append( "   FROM PAYROLL.PWCARDUP                       \n" );
					sql.append( "  WHERE RTRIM(SETTDT) LIKE '"+str1+"%'        \n" );	
					sql.append( "  AND RTRIM(EMPNMK) LIKE '"+str2+"%'    \n" );	
					if(!str3.equals("")) { sql.append( "  AND RTRIM(RESINO) = '"+str3+"'        \n" );	}

					sql.append( "  ORDER BY SEQID    \n" );	
                    
					//logger.dbg.println(this,sql.toString());
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
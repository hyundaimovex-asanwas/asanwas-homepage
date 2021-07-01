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
public class a040020_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");  //지점
				String  str2  = req.getParameter("v_str2");  //년월
				String  stryyyy="";
				String  strmm="";

				if(str1 == null) str1 = ""; //지점코드
				if(str2 == null) str2 = ""; //계산서기간 년월
				
				stryyyy=str2.substring(0,4);
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "ATCODE",  "ATKORNAM", "ATPRTSEQ",	"BFDETOT",	"BFCRTOT", 
				                                    "AFDETOT", "AFCRTOT",  "DESUM", "CRSUM"
				                                }; 

				int[] intArrCN = new int[]{ 7,  66,  7, 15,	15, 
					                          15, 15, 15, 15 }; 
			
				int[] intArrCN2 = new int[]{-1, -1,  -1,  0,	 0,  
					                           0,  0,   0,  0    }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();

					sql.append(" SELECT X.ATCODE, X.ATKORNAM, X.ATPRTSEQ ,                                                                 \n" );
					sql.append("        SUM(X.BFDETOT) AS BFDETOT,                                           										\n" );
					sql.append("        SUM(X.BFCRTOT) AS BFCRTOT,                                           										\n" );
					sql.append("        SUM(X.MODETOT) AFDETOT, SUM(X.MOCRTOT)AFCRTOT,                       						\n" );
					sql.append("        SUM(X.BFDETOT)+SUM(X.MODETOT) DESUM,                                 								\n" );
					sql.append("        SUM(X.BFCRTOT)+SUM(X.MOCRTOT) CRSUM                                  								\n" );
					sql.append(" FROM (                                                                                                    						\n" );
					sql.append(" 	--월합계잔액(전기이후:시산표)                                                                           				\n" );
					sql.append(" 	SELECT A.ATCODE, B.ATKORNAM, B.ATPRTSEQ,                                                                \n" );
					sql.append(" 				 SUM(A.DETOT)BFDETOT, SUM(A.CRTOT)BFCRTOT, 0 MODETOT , 0 MOCRTOT          \n" );
					sql.append(" 		FROM ACCOUNT.MTOTALBAL A                                                                              		\n" );
					sql.append(" 		LEFT JOIN ACCOUNT.ACTCODE B ON B.ATCODE = A.ATCODE                                           \n" );
					sql.append(" 	 WHERE FDCODE IS NOT NULL                                                                                  		\n" );
					if(!str1.equals("")) sql.append(" 	 AND FDCODE = '"+str1+"'            																\n" );
					sql.append(" 		 AND (ACTYYMM >= '"+stryyyy+"01' AND ACTYYMM <= '"+str2+"')                                     	\n" );
					sql.append(" 		 AND B.ATUSEYN='Y'                                                                                    				\n" );
					sql.append(" 	 GROUP BY A.ATCODE ,B.ATKORNAM, B.ATPRTSEQ                                                            \n" );
					sql.append("                                                                                                           								\n" );
					sql.append(" 	UNION ALL                                                                                               						\n" );
					sql.append("                                                                                                           								\n" );
					sql.append(" 	--(전기이전 : 분개전표  )                                                                    								\n" );
					sql.append(" 	SELECT C.ATCODE,E.ATKORNAM, E.ATPRTSEQ,                                                                 \n" );
					sql.append(" 				 0 BFDETOT, 0 BFCRTOT,                                                                            			\n" );
					sql.append(" 				 SUM(CASE WHEN SUBSTR(C.FSNBR,1,1)='9'  AND C.ATDECR = '1' THEN C.FSAMT ELSE 0 END) AS MODETOT,   \n" );
					sql.append(" 				 SUM(CASE WHEN SUBSTR(C.FSNBR,1,1)='9'  AND C.ATDECR = '2' THEN C.FSAMT ELSE 0 END) AS MOCRTOT   \n" );
					sql.append("                                                                                                           					\n" );
					sql.append(" 		FROM ACCOUNT.FSLIPDTL C                                                           					\n" );
					sql.append(" 		LEFT JOIN ACCOUNT.FSLIPMST D ON C.FDCODE = D.FDCODE                                  \n" );
					sql.append(" 		LEFT JOIN ACCOUNT.ACTCODE E ON C.ATCODE = E.ATCODE                                   \n" );
					sql.append(" 	 WHERE 1 = 1                                                                              						\n" );
					sql.append(" 		 AND C.FSDAT = D.FSDAT                                                                                	\n" );
					sql.append(" 		 AND C.FSNBR = D.FSNBR                                                                                \n" );
					if(!str1.equals(""))sql.append(" 		 AND C.FDCODE = '"+str1+"'                                                       \n" );
					sql.append(" 		 AND SUBSTR(D.ACTDAT,1,6)='"+str2+"'                                                                \n" );
					sql.append(" 		 AND E.ATUSEYN='Y'                                                                                    	\n" );
					sql.append(" 		 AND D.FSSTAT = 'R'                                                                                  		\n" );
					sql.append(" 	 GROUP BY C.ATCODE ,E.ATKORNAM, E.ATPRTSEQ                                                \n" );
					sql.append(" )X                                                                                                        				\n" );
					sql.append("                                                                                                           					\n" );
					sql.append(" GROUP BY X.ATCODE, X.ATKORNAM, X.ATPRTSEQ                                                  \n" );
					sql.append(" ORDER BY  X.ATPRTSEQ                                                                                      \n" );
					
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
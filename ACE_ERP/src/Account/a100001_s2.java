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
public class a100001_s2 extends HttpServlet {
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
				String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//당기기간fr            
				str[2]	= req.getParameter("v_str3");		//당기기간to            
				str[3]	= req.getParameter("v_str4");		//사업장      
				str[4]	= req.getParameter("v_str5");		//원가 fr NAME
				str[5]	= req.getParameter("v_str6");		//원가 FR CD
				str[6]	= req.getParameter("v_str7");		//전기기간FR
				str[7]	= req.getParameter("v_str8");		//전기기간to 
				
				
				for (int s=0;s<=7;s++) {
					if (str[s]==null) str[s] = "";
				}
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE","PRTNAM","PRTSEQ","GUBUN", 
					                                "XLTTOT","XRTTOT","YLTTOT","YRTTOT"
				}; 

				int[] intArrCN = new int[]{  7, 66, 5, 1,
					                          15, 15,15, 15
				}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1, -1, 
					                            0, 0,  0,  0
				                           
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  --집계계정                                                                                                                                                                                     \n " );
					sql.append( "  SELECT D.ATCODE AS ATCODE,  D.PRTNAM AS PRTNAM,  D.PRTSEQ AS PRTSEQ, Y.GUBUN,                                                                                                                  \n " );
					sql.append( "         CASE WHEN D.LRDIV = 'L' THEN CASE WHEN Y.ATDECR = '1' THEN COALESCE(Y.DETOT,0) - COALESCE(Y.CRTOT,0) ELSE COALESCE(Y.CRTOT,0) - COALESCE(Y.DETOT,0) END ELSE 0 END AS XLTTOT,           \n " );
					sql.append( "         CASE WHEN D.LRDIV = 'R' THEN CASE WHEN Y.ATDECR = '1' THEN COALESCE(Y.DETOT,0) - COALESCE(Y.CRTOT,0) ELSE COALESCE(Y.CRTOT,0) - COALESCE(Y.DETOT,0) END ELSE 0 END AS XRTTOT,           \n " );
					sql.append( "         CASE WHEN D.LRDIV = 'L' THEN CASE WHEN Y.ATDECR = '1' THEN COALESCE(Y.BDETOT,0) - COALESCE(Y.BCRTOT,0) ELSE COALESCE(Y.BCRTOT,0) - COALESCE(Y.BDETOT,0) END ELSE 0 END AS YLTTOT,       \n " );
					sql.append( "         CASE WHEN D.LRDIV = 'R' THEN CASE WHEN Y.ATDECR = '1' THEN COALESCE(Y.BDETOT,0) - COALESCE(Y.BCRTOT,0) ELSE COALESCE(Y.BCRTOT,0) - COALESCE(Y.BDETOT,0) END ELSE 0 END AS YRTTOT        \n " );
					sql.append( "                                                                                                                                                                                                 \n " );
					sql.append( "    FROM ACCOUNT.RPTPRTACT D                                                                                                                                                                     \n " );
					sql.append( "    LEFT JOIN ( SELECT U.ATUPCODE AS ATCODE, U.ATDECR AS ATDECR, 'Y' GUBUN,                                                                                                                      \n " );
					sql.append( "                       SUM(COALESCE(U.DETOT,0))DETOT, SUM(COALESCE(U.CRTOT,0))CRTOT,                                                                                                             \n " );
					sql.append( "                       SUM(COALESCE(U.BDETOT,0))BDETOT, SUM(COALESCE(U.BCRTOT,0))BCRTOT                                                                                                          \n " );
					sql.append( "                  FROM (                                                                                                                                                                         \n " );
					sql.append( "                       --당기                                                                                                                                                                    \n " );
					sql.append( "                       SELECT C.ATCODE  AS ATCODE, B.ATDECR, B.ATUPCODE,  C.DETOT, C.CRTOT ,0 BDETOT , 0 BCRTOT                                                                                  \n " );
					sql.append( "                         FROM ACCOUNT.MFSREFTOT C, ACCOUNT.ACTCODE B                                                                                                                             \n " );
					sql.append( "                        WHERE C.ATCODE = B.ATCODE                                                                                                                                                \n " );
					if(!str[0].equals(""))sql.append( "              AND C.FDCODE = '"+str[0]+"'                                                                                                                                            \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND C.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                                                                                                            \n " );
					sql.append( "                          AND C.FSREFCD ='0030'                                                                                                                                                  \n " );
					sql.append( "                          AND C.ATCODE LIKE '43%'                                                                                                                                                \n " );
					sql.append( "                        UNION ALL                                                                                                                                                                \n " );
					sql.append( "                        --전기                                                                                                                                                                   \n " );
					sql.append( "                        SELECT C.ATCODE  AS ATCODE, B.ATDECR, B.ATUPCODE, 0 DETOT, 0 CRTOT , C.DETOT BDETOT, C.CRTOT BCRTOT                                                                      \n " );
					sql.append( "                         FROM ACCOUNT.MFSREFTOT C, ACCOUNT.ACTCODE B                                                                                                                             \n " );
					sql.append( "                        WHERE C.ATCODE = B.ATCODE                                                                                                                                                \n " );
					if(!str[0].equals(""))sql.append( "              AND C.FDCODE = '"+str[0]+"'                                                                                                                                            \n " );
					if(!str[6].equals("")&&!str[7].equals("")) sql.append( " AND C.ACTYYMM BETWEEN '"+str[6]+"' AND '"+str[7]+"'                                                                                                            \n " );
					sql.append( "                          AND C.FSREFCD ='0030'                                                                                                                                                  \n " );
					sql.append( "                          AND C.ATCODE LIKE '43%'                                                                                                                                                \n " );
					sql.append( "                        )U, ACCOUNT.ACTCODE D                                                                                                                                                    \n " );
					sql.append( "                WHERE U.ATUPCODE = D.ATCODE                                                                                                                                                      \n " );
					sql.append( "                GROUP BY U.ATUPCODE, U.ATDECR                                                                                                                                                    \n " );
					sql.append( "                UNION ALL                                                                                                                                                                        \n " );
					sql.append( "                --DETIAL DATA                                                                                                                                                                    \n " );
					sql.append( "                SELECT Z.ATCODE, Z.ATDECR, Z.GUBUN,                                 \n " );
					sql.append( "                			 nvl(SUM(Z.DETOT),0)DETOT,  nvl(SUM(Z.CRTOT),0)CRTOT,   \n " );
					sql.append( "                			 nvl(SUM(Z.BDETOT),0)BDETOT,nvl(SUM(Z.BCRTOT),0)BCRTOT  \n " );
					sql.append( "                	FROM(                                                             \n " );
					sql.append( "                      --당기                                                                                                                                                                           \n " );
					sql.append( "                      SELECT C.ATCODE  AS ATCODE, B.ATDECR AS ATDECR, '' GUBUN,                                                                                                                         \n " );
					sql.append( "                             SUM(COALESCE(C.DETOT,0))DETOT, SUM(COALESCE(C.CRTOT,0))CRTOT,                                                                                                               \n " );
					sql.append( "                             0 BDETOT, 0 BCRTOT                                                                                                                                                          \n " );
					sql.append( "                        FROM ACCOUNT.MFSREFTOT C, ACCOUNT.ACTCODE B                                                                                                                                     \n " );
					sql.append( "                       WHERE C.ATCODE = B.ATCODE                                                                                                                                                        \n " );
					if(!str[0].equals(""))sql.append( "             AND C.FDCODE = '"+str[0]+"'                                                                                                                                                    \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND C.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                                                                                                            \n " );
					sql.append( "                         AND C.FSREFCD ='0030'                                                                                                                                                          \n " );
					sql.append( "                         AND C.ATCODE LIKE '43%'                                                                                                                                                        \n " );
					sql.append( "                       GROUP BY C.ATCODE, B.ATDECR                                                                                                                                                      \n " );
					sql.append( "                       UNION ALL                                                                                                                                                                        \n " );
					sql.append( "                       --전기                                                                                                                                                                         \n " );
					sql.append( "                      SELECT C.ATCODE  AS ATCODE, B.ATDECR AS ATDECR, '' GUBUN,                                                                                                                         \n " );
					sql.append( "                             0 DETOT, 0 CRTOT,                                                                                                                                                          \n " );
					sql.append( "                             SUM(COALESCE(C.DETOT,0))BDETOT, SUM(COALESCE(C.CRTOT,0))BCRTOT                                                                                                             \n " );
					sql.append( "                        FROM ACCOUNT.MFSREFTOT C, ACCOUNT.ACTCODE B                                                                                                                                     \n " );
					sql.append( "                       WHERE C.ATCODE = B.ATCODE                                                                                                                                                        \n " );
					if(!str[0].equals(""))sql.append( "             AND C.FDCODE = '"+str[0]+"'                                                                                                                                                    \n " );
					if(!str[6].equals("")&&!str[7].equals("")) sql.append( " AND C.ACTYYMM BETWEEN '"+str[6]+"' AND '"+str[7]+"'                                                                                                            \n " );
					sql.append( "                         AND C.FSREFCD ='0030'                                                                                                                                                          \n " );
					sql.append( "                         AND C.ATCODE LIKE '43%'                                                                                                                                                        \n " );
					sql.append( "                       GROUP BY C.ATCODE, B.ATDECR                                                                                                                                                      \n " );
					sql.append( "                       ORDER BY ATCODE                                                                                                                                                                  \n " );
					sql.append( "                   )Z \n " );
					sql.append( "                  GROUP BY Z.ATCODE, Z.ATDECR, Z.GUBUN  \n " );
					sql.append( "               ) Y  ON Y.ATCODE = D.ATCODE                                                                                                                                                       \n " );
					sql.append( "    WHERE D.PRTCODE ='08'                                                                                                                                                                        \n " );
					sql.append( "                                                                                                                                                                                                 \n " );
					sql.append( "  ORDER BY PRTSEQ                                                                                                                                                                                \n " );
				
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
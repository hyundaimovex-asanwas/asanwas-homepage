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
public class a100006_s1 extends HttpServlet {
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
				// 외화금액 가져옴.
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//fr년월            
				str[2]	= req.getParameter("v_str3");		//to년월            
				str[3]	= req.getParameter("v_str4");		//사업장      
				str[4]	= req.getParameter("v_str5");		//원가
				str[5]	= req.getParameter("v_str6");		//
				
				
				for (int s=0;s<=5;s++) {
					if (str[s]==null) str[s] = "";
				}
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE","PRTNAM","FSREFVAL","FSREFNM","PRTSEQ",
					                                "AMT" 
				}; 

				int[] intArrCN = new int[]{  7, 66, 6, 66, 5,
					                          15
				}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1, -1, -1,
					                            0
				                           
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.ATCODE,X.PRTNAM,X.FSREFVAL, X.FSREFNM,X.PRTSEQ, SUM(X.AMT) AMT                                     \n " );
					sql.append( "     FROM(                                                                                                    \n " );
					sql.append( "      --매출액                                                                                                \n " );
					sql.append( "       SELECT '0000001' ATCODE, '매출액' PRTNAM, A.FSREFVAL, C.GBCD||C.CDNAM FSREFNM, '00001'PRTSEQ, B.ATDECR,        \n " );
					sql.append( "             CASE WHEN B.ATDECR='1' THEN SUM(A.FODETOT)-SUM(A.FOCRTOT) ELSE SUM(A.FOCRTOT)-SUM(A.FODETOT) END AMT     \n " );
					sql.append( "          FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B                                                         \n " );
					sql.append( "          LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.FSREFVAL AND C.CMTYPE='0030'                           \n " );
					sql.append( "       WHERE A.ATCODE LIKE '41%'                                                                              \n " );
					sql.append( "           AND A.FSREFCD ='0030'                                                                              \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE ='"+str[0]+"'      					                                                       \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                         \n " );					
					if(!str[3].equals(""))sql.append( " AND C.GBCD='"+str[3]+"'                                                                          \n " );					
					if(!str[4].equals(""))sql.append( " AND A.FSREFVAL ='"+str[4]+"'                                                                     \n " );										
					sql.append( "           AND A.ATCODE = B.ATCODE                                                                            \n " );
					sql.append( "           AND B.ATUSEYN='Y'                                                                                  \n " );
					sql.append( "          -- AND F.PRTCODE='08'                                                                               \n " );
					sql.append( "           --AND A.FSREFVAL BETWEEN '05401' AND '05404'                                                       \n " );
					sql.append( "          -- AND C.GBCD='03'                                                                                  \n " );
					sql.append( "       GROUP BY B.ATDECR, A.FSREFVAL,C.GBCD||C.CDNAM                                                                \n " );
					sql.append( "       UNION ALL                                                                                              \n " );
					sql.append( "      --매출액 세부                                                                                         \n " );
					sql.append( "      SELECT                                                                                                                \n " );
					sql.append( "             CASE WHEN SUBSTR(A.ATCODE,1,3)='411' THEN '4110000'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='412' THEN '4120000'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='413' THEN '4130000'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='414' THEN '4140000'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='415' THEN '4150000'ELSE '' END ATCODE,                                              \n " );
					sql.append( "             CASE WHEN SUBSTR(A.ATCODE,1,3)='411' THEN '[1].관광수입'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='412' THEN '[2].공사수입'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='413' THEN '[3].용역수입'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='414' THEN '[4].운송수입'                                                                 \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='415' THEN '[5].기타수입'ELSE '' END PRTNAM,                                              \n " );
					sql.append( "              A.FSREFVAL, C.GBCD||C.CDNAM FSREFNM,                                                                                   \n " );
					sql.append( "             CASE WHEN SUBSTR(A.ATCODE,1,3)='411' THEN '00002'                                                                       \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='412' THEN '00003'                                                                       \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='413' THEN '00004'                                                                       \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='414' THEN '00005'                                                                       \n " );
					sql.append( "                  WHEN SUBSTR(A.ATCODE,1,3)='415' THEN '00006'ELSE '00007' END PRTSEQ,                                               \n " );
					sql.append( "            B.ATDECR,                                                                                                                \n " );
					sql.append( "            CASE WHEN B.ATDECR='1' THEN SUM(A.FODETOT)-SUM(A.FOCRTOT) ELSE SUM(A.FOCRTOT)-SUM(A.FODETOT) END AMT                             \n " );
					sql.append( "         FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B                                                                                 \n " );
					sql.append( "         LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.FSREFVAL AND C.CMTYPE='0030'                                                   \n " );
					sql.append( "        WHERE (A.ATCODE LIKE '411%' OR A.ATCODE LIKE '412%' OR A.ATCODE LIKE '413%' OR A.ATCODE LIKE '414%' OR A.ATCODE LIKE '415%' )\n " );
					sql.append( "          AND A.FSREFCD ='0030'                                                                                                      \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE ='"+str[0]+"'      					                                                       \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                         \n " );					
					if(!str[3].equals(""))sql.append( " AND C.GBCD='"+str[3]+"'                                                                          \n " );					
					if(!str[4].equals(""))sql.append( " AND A.FSREFVAL ='"+str[4]+"'                                                                     \n " );										
					sql.append( "          AND A.ATCODE = B.ATCODE                                                                                                    \n " );
					sql.append( "          AND B.ATUSEYN='Y'                                                                                                          \n " );
					sql.append( "      GROUP BY A.ATCODE,B.ATDECR, A.FSREFVAL,C.GBCD||C.CDNAM                                                                         \n " );
					sql.append( "     UNION ALL \n " );					
					sql.append( "      --매출원가 전체                                                                                         \n " );
					sql.append( "      SELECT '0000002' ATCODE, '매출원가' PRTNAM, A.FSREFVAL, C.GBCD||C.CDNAM FSREFNM,'00009' PRTSEQ, B.ATDECR,       \n " );
					sql.append( "             CASE WHEN B.ATDECR='1' THEN SUM(A.FODETOT)-SUM(A.FOCRTOT) ELSE SUM(A.FOCRTOT)-SUM(A.FODETOT) END AMT     \n " );
					sql.append( "          FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B, ACCOUNT.RPTPRTACT F                                    \n " );
					sql.append( "          LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.FSREFVAL AND C.CMTYPE='0030'                           \n " );
					sql.append( "       WHERE A.ATCODE LIKE '43%'                                                                              \n " );
					sql.append( "           AND A.FSREFCD ='0030'                                                                              \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE ='"+str[0]+"'      					                                                       \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                         \n " );					
					if(!str[3].equals(""))sql.append( " AND C.GBCD='"+str[3]+"'                                                                          \n " );					
					if(!str[4].equals(""))sql.append( " AND A.FSREFVAL ='"+str[4]+"'                                                                     \n " );					
					sql.append( "           AND A.ATCODE = B.ATCODE                                                                            \n " );
					sql.append( "           AND B.ATUSEYN='Y'                                                                                  \n " );
					sql.append( "           AND B.ATCODE = F.ATCODE                                                                            \n " );
					sql.append( "           AND A.ATCODE = F.ATCODE                                                                            \n " );
					sql.append( "           AND F.PRTCODE='08'                                                                                 \n " );
					sql.append( "           --AND A.FSREFVAL BETWEEN '05401' AND '05404'                                                       \n " );
					sql.append( "          -- AND C.GBCD='03'                                                                                  \n " );
					sql.append( "       GROUP BY B.ATDECR, A.FSREFVAL,C.GBCD||C.CDNAM                                                                 \n " );
					sql.append( "   --원가집계                                                                                                    \n " );
					sql.append( "			 UNION ALL                                                                                                     \n " );
					sql.append( "			 SELECT D.ATCODE AS ATCODE,  D.PRTNAM AS PRTNAM,           \n " );
					sql.append( "			        IFNULL(Y.FSREFVAL,CASE WHEN '01' = '"+str[3]+"' THEN '061001'      \n " );
					sql.append( "			                               WHEN '02' = '"+str[3]+"' THEN '066001'      \n " );
					sql.append( "			                               WHEN '03' = '"+str[3]+"' THEN '069001'      \n " );
					sql.append( "			                               ELSE '061001' END) FSREFVAL,                         \n " );
					sql.append( "			        IFNULL(Y.FSREFNM,CASE WHEN '01' = '"+str[3]+ "' THEN '개성시범공장건축공사(공통)' \n " );
					sql.append( "			                               WHEN '02' = '"+str[3]+"' THEN '구룡마을'       \n " );
					sql.append( "			                               WHEN '03' = '"+str[3]+"' THEN '개성출입'       \n " ); 
					sql.append( "			                               ELSE '개성시범공장건축공사(공통)' END) FSREFNM ,         \n " );               
					sql.append( "			       D.PRTSEQ AS PRTSEQ, Y.ATDECR, \n " );					
					sql.append( "			 			 CASE WHEN Y.ATDECR='1' THEN COALESCE(Y.FODETOT-Y.FOCRTOT,0) ELSE COALESCE(Y.FOCRTOT-Y.FODETOT,0) END AMT                               \n " );
					sql.append( "			 	FROM ACCOUNT.RPTPRTACT D                                                                                    \n " );
					sql.append( "			 	LEFT JOIN ( SELECT U.ATUPCODE AS ATCODE, U.ATDECR AS ATDECR, 'Y' GUBUN,  U.FSREFVAL, U.FSREFNM,             \n " );
					sql.append( "			 								 SUM(COALESCE(U.FODETOT,0))FODETOT, SUM(COALESCE(U.FOCRTOT,0))FOCRTOT,                                \n " );
					sql.append( "			 								 SUM(COALESCE(U.BDETOT,0))BDETOT, SUM(COALESCE(U.BCRTOT,0))BCRTOT                             \n " );
					sql.append( "			 								FROM (                                                                                        \n " );
					sql.append( "			 										 SELECT C.ATCODE  AS ATCODE, B.ATDECR, B.ATUPCODE, C.FODETOT, C.FOCRTOT, 0 BDETOT, 0 BCRTOT , \n " );
					sql.append( "			 														C.FSREFVAL, K.GBCD||K.CDNAM FSREFNM                                                       \n " );
					sql.append( "			 											 FROM ACCOUNT.MFSREFTOT C, ACCOUNT.ACTCODE B                                            \n " );
					sql.append( "			 											 LEFT JOIN ACCOUNT.COMMDTIL K ON C.FSREFVAL = K.CDCODE AND K.CMTYPE='0030'              \n " );
					sql.append( "			 											WHERE C.ATCODE = B.ATCODE                                                               \n " );
					if(!str[0].equals(""))sql.append( "                 AND C.FDCODE ='"+str[0]+"'      					                                            \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND C.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                              \n " );					
					if(!str[3].equals(""))sql.append( "                 AND K.GBCD='"+str[3]+"'                                                               \n " );					
					if(!str[4].equals(""))sql.append( "                 AND C.FSREFVAL ='"+str[4]+"'                                                          \n " );
					sql.append( "			 												AND C.FSREFCD ='0030'                                                                 \n " );
					sql.append( "			 												AND C.ATCODE LIKE '43%'                                                               \n " );
					sql.append( "			 											)U, ACCOUNT.ACTCODE D                                                                   \n " );
					sql.append( "			 							WHERE U.ATUPCODE = D.ATCODE                                                                     \n " );
					sql.append( "			 							GROUP BY U.ATUPCODE, U.ATDECR , U.FSREFVAL, U.FSREFNM                                           \n " );
					sql.append( "			 					 ) Y  ON  D.ATCODE = Y.ATCODE                                                                       \n " );
					sql.append( "			 WHERE D.PRTCODE ='08'                                                                                         \n " );
					sql.append( "			 	AND D.ATCODE IN ('4310000','4320000','4330000','4340000')                                                   \n " );
					sql.append( "      UNION ALL                                                                                               \n " );
					sql.append( "      --원가                                                                                                  \n " );
					sql.append( "      SELECT A.ATCODE, F.PRTNAM, A.FSREFVAL, C.GBCD||C.CDNAM FSREFNM, F.PRTSEQ, B.ATDECR ,                            \n " );
					sql.append( "             CASE WHEN B.ATDECR='1' THEN SUM(A.FODETOT)-SUM(A.FOCRTOT) ELSE SUM(A.FOCRTOT)-SUM(A.FODETOT) END AMT     \n " );
					sql.append( "          FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B, ACCOUNT.RPTPRTACT F                                    \n " );
					sql.append( "          LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.FSREFVAL AND C.CMTYPE='0030'                           \n " );
					sql.append( "       WHERE A.ATCODE LIKE '43%'                                                                              \n " );
					sql.append( "           AND A.FSREFCD ='0030'                                                                              \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE ='"+str[0]+"'      					                                                       \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                         \n " );					
					if(!str[3].equals(""))sql.append( " AND C.GBCD='"+str[3]+"'                                                                          \n " );					
					if(!str[4].equals(""))sql.append( " AND A.FSREFVAL ='"+str[4]+"'                                                                     \n " );					
					sql.append( "           AND A.ATCODE = B.ATCODE                                                                            \n " );
					sql.append( "           AND B.ATUSEYN='Y'                                                                                  \n " );
					sql.append( "           AND B.ATCODE = F.ATCODE                                                                            \n " );
					sql.append( "           AND A.ATCODE = F.ATCODE                                                                            \n " );
					sql.append( "           AND F.PRTCODE='08'                                                                                 \n " );
					sql.append( "          -- AND C.GBCD='03'                                                                                  \n " );
					sql.append( "       GROUP BY A.ATCODE,A.ACTYYMM, F.PRTNAM,F.PRTSEQ,B.ATDECR, A.FSREFVAL,C.GBCD||C.CDNAM                            \n " );
					sql.append( "			  UNION ALL \n " );
					sql.append( "			  SELECT '9999999' ATCODE, '매출총이익' PRTNAM, Z.FSREFVAL,Z.FSREFNM,Z.PRTSEQ,''ATDECR,                          \n " );
					sql.append( "			         SUM(AMT1) - SUM(AMT2) AS AMT                                                                            \n " );
					sql.append( "			     FROM(                                                                                                       \n " );
					sql.append( "			    --매출액                                                                                                     \n " );
					sql.append( "			     SELECT '0000001' ATCODE, '매출액' PRTNAM, A.FSREFVAL, C.GBCD||C.CDNAM FSREFNM, '99999' PRTSEQ, B.ATDECR,            \n " );
					sql.append( "			           CASE WHEN B.ATDECR='1' THEN SUM(A.FODETOT)-SUM(A.FOCRTOT) ELSE SUM(A.FOCRTOT)-SUM(A.FODETOT) END AMT1, 0 AMT2 \n " );
					sql.append( "			        FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B                                                              \n " );
					sql.append( "			        LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.FSREFVAL AND C.CMTYPE='0030'                                \n " );
					sql.append( "			     WHERE A.ATCODE LIKE '41%'                                                                                   \n " );
					sql.append( "			        AND A.FSREFCD ='0030'                                                                                   \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE ='"+str[0]+"'      					                                                       \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                         \n " );					
					if(!str[3].equals(""))sql.append( " AND C.GBCD='"+str[3]+"'                                                                          \n " );					
					if(!str[4].equals(""))sql.append( " AND A.FSREFVAL ='"+str[4]+"'                                                                     \n " );										
					sql.append( "			         AND A.ATCODE = B.ATCODE                                                                                 \n " );
					sql.append( "			         AND B.ATUSEYN='Y'                                                                                       \n " );
					sql.append( "			     GROUP BY B.ATDECR, A.FSREFVAL,C.GBCD||C.CDNAM                                                                      \n " );
					sql.append( "			     UNION ALL                                                                                                   \n " );
					sql.append( "			    --매출원가 전체                                                                                              \n " );
					sql.append( "			    SELECT '0000002' ATCODE, '매출원가' PRTNAM, A.FSREFVAL, C.GBCD||C.CDNAM FSREFNM,'99999' PRTSEQ, B.ATDECR, 0 AMT1,    \n " );
					sql.append( "			           CASE WHEN B.ATDECR='1' THEN SUM(A.FODETOT)-SUM(A.FOCRTOT) ELSE SUM(A.FOCRTOT)-SUM(A.FODETOT) END AMT2         \n " );
					sql.append( "			        FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B, ACCOUNT.RPTPRTACT F                                         \n " );
					sql.append( "			        LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.FSREFVAL AND C.CMTYPE='0030'                                \n " );
					sql.append( "			     WHERE A.ATCODE LIKE '43%'                                                                                   \n " );
					sql.append( "			         AND A.FSREFCD ='0030'                                                                                   \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE ='"+str[0]+"'      					                                                       \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'                         \n " );					
					if(!str[3].equals(""))sql.append( " AND C.GBCD='"+str[3]+"'                                                                          \n " );					
					if(!str[4].equals(""))sql.append( " AND A.FSREFVAL ='"+str[4]+"'                                                                     \n " );					
					sql.append( "			         AND A.ATCODE = B.ATCODE                                                                                 \n " );
					sql.append( "			         AND B.ATUSEYN='Y'                                                                                       \n " );
					sql.append( "			         AND B.ATCODE = F.ATCODE                                                                                 \n " );
					sql.append( "			         AND A.ATCODE = F.ATCODE                                                                                 \n " );
					sql.append( "			         AND F.PRTCODE='08'                                                                                      \n " );
					sql.append( "			     GROUP BY B.ATDECR, A.FSREFVAL,C.GBCD||C.CDNAM                                                                       \n " );
					sql.append( "			   )Z                                                                                                            \n " );
					sql.append( "			  GROUP BY Z.ATCODE, Z.FSREFVAL,Z.FSREFNM,Z.PRTSEQ                                                               \n " );
					sql.append( "      ) X                                                                                                     \n " );
					sql.append( "     GROUP BY X.ATCODE,X.PRTNAM,X.FSREFVAL, X.FSREFNM,X.PRTSEQ                                                \n " );
					sql.append( "     ORDER BY X.PRTSEQ                                                                                        \n " );
					
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
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
public class a090032_s3 extends HttpServlet {
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
				// 감가상각 총괄표 조회

				String  str1 = req.getParameter("v_str1");    //지점
				String  str2 = req.getParameter("v_str2");    //TO년월
				String  str3 = req.getParameter("v_str3");    //당기년도
				String  str4 = req.getParameter("v_str4");    //전기년도
				

				String  strcstddt ="" ;    //당기01월01
				String  strcenddt ="" ;    //당기 검색 TO년월 최종월 31일
				String  strcyymm ="" ;     //당기년도의 01월
				String  strbstddt ="" ;    //전기01월01
				String  strbenddt ="" ;    //전기12월31일
	
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";

				strcstddt = str3 + "0101";
				strcenddt = str2 + "31";
				strcyymm  = str3 + "01";
				strbstddt = str4 + "0101";
				strbenddt = str4 + "1231";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",   "AST2ND",   "AST2NDNM",  "ASTYUSE",
																			  	"BEFAQAMT", "CURAQAMT", "CLSAQAMT",  "MOVAQAMT", "AQAMTSUM",
																			  	"ABDEPRAMT","ACDEPRAMT","ACDEPRSUM", "REDUAMT",  "DEAMTSUM",  "JAAMTSUM"
																	  		}; 

				int[] intArrCN = new int[]{ 2,  2,  60,  5, 
																	 13, 13 , 13,  13, 13,
																	 13, 13 , 13,  13, 13, 13
				 }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1,  2, 
																		 0,  0,  0,  0, 0,
																		 0,  0,  0,  0, 0, 13
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT Q.FDCODE, Q.AST2ND, CASE WHEN Q.AST2ND='99' THEN '건설중인자산' ELSE G.CDNAM END  AS AST2NDNM, Q.ASTYUSE,                                                  \n");
					sql.append( "        SUM(Q.BEFAQAMT)BEFAQAMT,   SUM(Q.CURAQAMT)CURAQAMT,   SUM(Q.CLSAQAMT)CLSAQAMT,   SUM(Q.MOVAQAMT)MOVAQAMT,  0 AS AQAMTSUM,                                    \n");
					sql.append( "        SUM(Q.ABDEPRAMT)ABDEPRAMT, SUM(Q.ACDEPRAMT)ACDEPRAMT, SUM(Q.ACDEPRSUM)ACDEPRSUM, SUM(Q.REDUAMT)REDUAMT,                                                   \n");  
					sql.append( "        (SUM(Q.ABDEPRAMT)+SUM(Q.ACDEPRAMT)+SUM(Q.REDUAMT)) AS DEAMTSUM, 0 AS JAAMTSUM                                                                      \n");  
					sql.append( "   FROM (                                                                                                                                                          \n");     
													//여기 부터는 감가상각누계액
					sql.append( " 	SELECT Z.FDCODE, Z.AST2ND, S.ASTYUSE,                                                                                                                              \n");
					sql.append( " 		   0 AS BEFAQAMT,                                                                                                                                              \n");  
					sql.append( " 		   0 AS CURAQAMT,                                                                                                                                              \n");
					sql.append( " 		   0 AS CLSAQAMT,                                                                                                                                              \n");
					sql.append( " 		   0 AS MOVAQAMT,                                                                                                                                              \n");  
					sql.append( " 		   SUM(Z.ABDEPRAMT)ABDEPRAMT,                                                                                                                                  \n");
					sql.append( " 		   SUM(Z.ACDEPRAMT)ACDEPRAMT, (SUM(Z.ABDEPRAMT)+SUM(Z.ACDEPRAMT)) AS ACDEPRSUM, SUM(Z.REDUAMT)REDUAMT                                                          \n");
					sql.append( " 	   FROM (                                                                                                                                                          \n");  
					sql.append( " 		 SELECT X.FDCODE, X.ATCODE, X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ,                                                                                               \n");
					sql.append( " 				X.COSTCD, X.RCOSTCD,                                                                                                                                   \n");
					sql.append( " 				SUM(X.ASTAQAMT)ASTAQAMT, SUM(X.ABDEPRAMT)ABDEPRAMT, SUM(X.ACDEPRAMT)ACDEPRAMT,                                                                         \n");  
					sql.append( " 				0 ASTRMAMT, X.GUBUN, 0 REDUAMT                                                                                                                         \n");
					sql.append( " 		   FROM (                                                                                                                                                      \n");
					sql.append( "           --전기누계액 ( 완료건중 당기에 존재하지 않는 건 )                                                                                                            \n");  
					sql.append( "                     SELECT A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND,A.AST3RD,A.ASTSEQ,                                                                                     \n");
					sql.append( "                            ACCOUNT.FN_COSTCD('"+str2+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS COSTCD,                                        \n");
					sql.append( "                            ACCOUNT.FN_COSTCD('"+str2+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,                                       \n");  
					sql.append( "                            MAX(A.ASTAQAMT)ASTAQAMT,  0 ABDEPRAMT, 0 ACDEPRAMT,'0' GUBUN                                                                                \n");
					sql.append( "                       FROM ACCOUNT.ASTYEPR A                                                                                                                           \n");
					sql.append( "                      WHERE 1=1                                                                                                                                         \n");  
					sql.append( "                        AND A.FDCODE ='"+str1+"'                                                                                                                              \n");
					sql.append( "                        AND (A.ASTYM) < '"+strcyymm+"'                                                                                                                      \n");
					sql.append( "                        AND NOT EXISTS ( SELECT K.FDCODE,K.ATCODE,K.AST1ST,K.AST2ND,K.AST3RD,K.ASTSEQ                                                                   \n");  
					sql.append( "                                           FROM ACCOUNT.ASTYEPR K                                                                                                       \n");
					sql.append( "                                          WHERE 1=1                                                                                                                     \n");
					sql.append( "                                            AND K.FDCODE='"+str1+"'                                                                                                           \n");  
					sql.append( "                                            AND K.ASTYM >='"+strcyymm+"'                                                                                                        \n");
					sql.append( "                                            AND A.FDCODE = K.FDCODE                                                                                                     \n");
					sql.append( "                                            AND A.ATCODE = K.ATCODE                                                                                                     \n");  
					sql.append( "                                            AND A.AST1ST = K.AST1ST                                                                                                     \n");
					sql.append( "                                            AND A.AST2ND = K.AST2ND                                                                                                     \n");
					sql.append( "                                            AND A.AST3RD = K.AST3RD                                                                                                     \n");  
					sql.append( "                                            AND A.ASTSEQ = K.ASTSEQ                                                                                                     \n");
					sql.append( "                                          GROUP BY K.FDCODE,K.ATCODE,K.AST1ST,K.AST2ND,K.AST3RD,K.ASTSEQ                                                                \n");
					sql.append( "                                        )                                                                                                                               \n");  
					sql.append( "                      GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                                                          \n");
					sql.append( "                     UNION ALL                                                                                                                                          \n");
					sql.append( "                     --전기 누계액( 완료 안된건은 나오는데, 완료 된건은 안나옴.)                                                                                        \n");  
					sql.append( "                     SELECT A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ,                                                                                      \n");
					sql.append( "                            ACCOUNT.FN_COSTCD('"+str2+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS COSTCD,                                        \n");
					sql.append( "                            ACCOUNT.FN_COSTCD('"+str2+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,                                       \n");  
					sql.append( "                            0 ASTAQAMT, SUM(A.ASTAMT) ABDEPRAMT, 0 ACDEPRAMT, '0' GUBUN                                                                                 \n");
					sql.append( "                       FROM ACCOUNT.ASTYEPR A                                                                                                                           \n");
					sql.append( "                      WHERE 1=1                                                                                                                                         \n");  
					sql.append( "                        AND A.FDCODE ='"+str1+"'                                                                                                                              \n");
					sql.append( "                        AND A.ASTYM <'"+strcyymm+"'                                                                                                                             \n");
					sql.append( "                      GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                                                          \n");
					sql.append( "                     UNION ALL                                                                                                                                          \n");
					sql.append( "                     -- 당기 (이체전 )                                                                                                                                  \n");  
					sql.append( "                     SELECT A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ,                                                                                      \n");
					sql.append( "                            A.COSTCD,                                                                                                                                   \n");
					sql.append( "                            ACCOUNT.FN_COSTCD('"+str2+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,                                       \n");  
					sql.append( "                            0 ASTAQAMT, 0 ABDEPRAMT, SUM(A.ASTAMT) ACDEPRAMT, '1' GUBUN                                                                                 \n");
					sql.append( "                       FROM ACCOUNT.ASTYEPR A                                                                                                                           \n");
					sql.append( "                      WHERE 1=1                                                                                                                                         \n");  
					sql.append( "                        AND A.FDCODE='"+str1+"'                                                                                                                               \n");
					sql.append( "                        AND A.ASTYM >='"+strcyymm+"'                                                                                                                             \n");
					sql.append( "                        AND A.COSTCD <> (SELECT COSTCD                                                                                                                  \n");  
					sql.append( "                                          FROM ACCOUNT.ASTYEPR C                                                                                                        \n");
					sql.append( "                                         WHERE C.FDCODE =A.FDCODE                                                                                                       \n");
					sql.append( "                                           AND C.ATCODE =A.ATCODE                                                                                                       \n");  
					sql.append( "                                           AND C.AST1ST =A.AST1ST                                                                                                       \n");
					sql.append( "                                           AND C.AST2ND =A.AST2ND                                                                                                       \n");
					sql.append( "                                           AND C.AST3RD =A.AST3RD                                                                                                       \n");  
					sql.append( "                                           AND C.ASTSEQ= A.ASTSEQ                                                                                                       \n");
					sql.append( "                                           AND C.ASTYM =( SELECT MAX(B.ASTYM)                                                                                           \n");
					sql.append( "                                                            FROM ACCOUNT.ASTYEPR B                                                                                      \n");  
					sql.append( "                                                           WHERE A.FDCODE = B.FDCODE                                                                                    \n");
					sql.append( "                                                             AND A.ATCODE = B.ATCODE                                                                                    \n");
					sql.append( "                                                             AND A.AST1ST = B.AST1ST                                                                                    \n");  
					sql.append( "                                                             AND A.AST2ND = B.AST2ND                                                                                    \n");
					sql.append( "                                                             AND A.AST3RD = B.AST3RD                                                                                    \n");
					sql.append( "                                                             AND A.ASTSEQ = B.ASTSEQ                                                                                    \n");  
					sql.append( "                                                           GROUP BY B.FDCODE, B.ATCODE, B.AST1ST, B.AST2ND, B.AST3RD, B.ASTSEQ                                          \n");
					sql.append( "                                                         )                                                                                                              \n");
					sql.append( "                                         )                                                                                                                              \n");  
					sql.append( "                      GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                                                          \n");
					sql.append( "                     UNION ALL                                                                                                                                          \n");
					sql.append( "                     -- 당기 (이체후 )                                                                                                                                  \n");  
					sql.append( "                      SELECT A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ,                                                                                     \n");
					sql.append( "                             A.COSTCD,                                                                                                                                  \n");
					sql.append( "                             ACCOUNT.FN_COSTCD('"+str2+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,                                      \n");  
					sql.append( "                             MAX(A.ASTAQAMT)ASTAQAMT, 0 ABDEPRAMT, SUM(A.ASTAMT) ACDEPRAMT, '0' GUBUN                                                                   \n");
					sql.append( "                       FROM ACCOUNT.ASTYEPR A                                                                                                                           \n");
					sql.append( "                      WHERE 1=1                                                                                                                                         \n");  
					sql.append( "                        AND A.FDCODE ='"+str1+"'                                                                                                                              \n");
					sql.append( "                        AND A.ASTYM >='"+strcyymm+"'                                                                                                                             \n");
					sql.append( "                        AND A.COSTCD = (SELECT COSTCD                                                                                                                   \n");  
					sql.append( "                                          FROM ACCOUNT.ASTYEPR C                                                                                                        \n");
					sql.append( "                                         WHERE C.FDCODE =A.FDCODE                                                                                                       \n");
					sql.append( "                                           AND C.ATCODE =A.ATCODE                                                                                                       \n");  
					sql.append( "                                           AND C.AST1ST =A.AST1ST                                                                                                       \n");
					sql.append( "                                           AND C.AST2ND =A.AST2ND                                                                                                       \n");
					sql.append( "                                           AND C.AST3RD =A.AST3RD                                                                                                       \n");  
					sql.append( "                                           AND C.ASTSEQ= A.ASTSEQ                                                                                                       \n");
					sql.append( "                                           AND C.ASTYM = ( SELECT MAX(B.ASTYM)                                                                                          \n");
					sql.append( "                                                            FROM ACCOUNT.ASTYEPR B                                                                                      \n");  
					sql.append( "                                                           WHERE A.FDCODE = B.FDCODE                                                                                    \n");
					sql.append( "                                                             AND A.ATCODE = B.ATCODE                                                                                    \n");
					sql.append( "                                                             AND A.AST1ST = B.AST1ST                                                                                    \n");  
					sql.append( "                                                             AND A.AST2ND = B.AST2ND                                                                                    \n");
					sql.append( "                                                             AND A.AST3RD = B.AST3RD                                                                                    \n");
					sql.append( "                                                             AND A.ASTSEQ = B.ASTSEQ                                                                                    \n");  
					sql.append( "                                                           GROUP BY B.FDCODE, B.ATCODE, B.AST1ST, B.AST2ND, B.AST3RD, B.ASTSEQ                                          \n");
					sql.append( "                                                         )                                                                                                              \n");
					sql.append( "                                         )                                                                                                                              \n");  
					sql.append( "                      GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                                                          \n");
					sql.append( "                     )X                                                                                                                                                 \n");
					sql.append( "                 WHERE 1=1                                                                                                                                              \n");  
					sql.append( "                 GROUP BY X.FDCODE,X.ATCODE,X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ, X.COSTCD, X.GUBUN,X.RCOSTCD                                                            \n");
					sql.append( "                 UNION ALL                                                                                                                                              \n");  
					sql.append( "                 SELECT  X.FDCODE, X.ATCODE, X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ,                                                                                       \n");
					sql.append( "                         '' COSTCD, '' RCOSTCD,                                                                                                                         \n");  
					sql.append( "                         0 ASTAQAMT, 0 ABDEPRAMT, 0 ACDEPRAMT, 0 ASTRMAMT, '0'GUBUN ,  X.REDUAMT                                                                        \n");
					sql.append( "                   FROM ACCOUNT.ASTDEPR X                                                                                                                               \n");
					sql.append( "                  WHERE X.FDCODE ='"+str1+"'                                                                                                                                  \n");  
					sql.append( "                    AND X.REDUYM<='"+strcyymm+"'                                                                                                                                 \n");
					sql.append( "         )Z                                                                                                                                                             \n");
					sql.append( " 	 LEFT JOIN ACCOUNT.ASTBASICN S ON S.FDCODE = Z.FDCODE  AND S.ATCODE = Z.ATCODE                                                                                     \n");
					sql.append( " 														   AND S.AST1ST = Z.AST1ST  AND S.AST2ND = Z.AST2ND                                                            \n");
					sql.append( " 														   AND S.AST3RD = Z.AST3RD  AND S.ASTSEQ = Z.ASTSEQ                                                            \n");  
					sql.append( " 	 WHERE 1=1                                                                                                                                                         \n");
					sql.append( " 	   AND S.ASTSTAT NOT IN ( '1','2' ,'8')                                                                                                                                \n");
					sql.append( " 	   AND Z.FDCODE = '"+str1+"'                                                                                                                                             \n");  
					sql.append( " 	 GROUP BY Z.FDCODE, Z.AST2ND ,S.ASTYUSE                                                                                                                            \n");
					sql.append( " )Q                                                                                                                                                                     \n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL G ON G.CDCODE = Q.AST2ND   AND G.CMTYPE ='2101'  \n");
					sql.append( " WHERE Q.FDCODE ='"+str1+"'                                                                                                                                                  \n");
					sql.append( " GROUP BY Q.FDCODE, Q.AST2ND , G.CDNAM,  Q.ASTYUSE                                                                                                                            \n");
					sql.append( " ORDER BY Q.FDCODE, Q.AST2ND , G.CDNAM,  Q.ASTYUSE                                                                                                                            \n");

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
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
public class a090030_s3 extends HttpServlet {
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
				// 감가상각 조회 쿼리

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //자산분류
				String  str3 = req.getParameter("v_str3");    //원화,외화 구분 1-원화, 2-외화
				String  str4 = req.getParameter("v_str4");    //원가코드
				String  str5 = req.getParameter("v_str5");    //당기년도의 01월
				String  str6 = req.getParameter("v_str6");    //최종상각년월
				String  str7 = req.getParameter("v_str7");    //원가구분

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"FDCODE",    "ATCODE",    "AST1ST",     "AST2ND",    "AST3RD", "ASTSEQ",
					                             "COSTCD",    "RCOSTCD",   "ASTNBR",     "ASTNAME",   "ASTNM",  "ASAQSDAT",
				                                 "ASTAQAMT",  "ABDEPRAMT", "ACDEPRAMT",  "ASTRMAMT" , "GUBUN"
					                              }; 

				int[] intArrCN = new int[]{ 2,  7,  2,   2,  2,  5,
					                          6,  6,  8,  30, 100, 8,
					                         13, 13,  13, 13,  1
					                        }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1, -1, 
                                             -1, -1, -1, -1, -1, -1, 
					                           0,  0,  0,  0, -1
					                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( "     SELECT X.FDCODE, X.ATCODE, X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ,                                                     \n");
					if (str7.equals("1")){
					 sql.append( "            X.COSTCD, '' RCOSTCD,                                                                                         \n");
					}else if (str7.equals("2")){
					 sql.append( "            '' COSTCD, X.RCOSTCD,                                                                                         \n");
					}
					sql.append( "            D.ASTNBR, D.ASTNAME, E.ASTNM,  D.ASAQSDAT,                                                                   \n");
					sql.append( "            SUM(X.ASTAQAMT)ASTAQAMT, SUM(X.ABDEPRAMT)ABDEPRAMT, SUM(X.ACDEPRAMT)ACDEPRAMT,                               \n");
					sql.append( "            0 ASTRMAMT, X.GUBUN                                                                                          \n");
					sql.append( "       FROM (                                                                                                            \n");
					sql.append( "          --전기누계액 ( 완료건중 당기에 존재하지 않는 건 )                                                              \n");
					sql.append( "					SELECT A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND,A.AST3RD,A.ASTSEQ,                                                  \n");
					sql.append( "					       ACCOUNT.FN_COSTCD('"+str6+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS COSTCD,   \n");
					sql.append( "					       ACCOUNT.FN_COSTCD('"+str6+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,  \n");
					sql.append( "					       MAX(A.ASTAQAMT)ASTAQAMT,  0 ABDEPRAMT, 0 ACDEPRAMT,'0' GUBUN                                             \n");
					sql.append( "					  FROM ACCOUNT.ASTYEPR A                                                                                        \n");
					sql.append( "					 WHERE 1=1                                                                                                      \n");
					if (!str1.equals(""))sql.append( " AND A.FDCODE ='"+str1+"'                                                                           \n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND ='"+str2+"'                                                                           \n");
					sql.append( "					   AND (A.ASTYM) < '"+str5+"'                                                                                   \n");
					sql.append( "					   AND NOT EXISTS ( SELECT K.FDCODE,K.ATCODE,K.AST1ST,K.AST2ND,K.AST3RD,K.ASTSEQ                                \n");
					sql.append( "					                      FROM ACCOUNT.ASTYEPR K                                                                    \n");
					sql.append( "					                     WHERE 1=1                                                                                  \n");
					if (!str1.equals(""))sql.append( "	         AND K.FDCODE='"+str1+"'                                                                  \n");
					if (!str2.equals(""))sql.append( "	         AND K.AST2ND='"+str2+"'                                                                  \n");
					sql.append( "					                       AND K.ASTYM >='"+str5+"'                                                                 \n");
					sql.append( "					                       AND A.FDCODE = K.FDCODE                                                                  \n");
					sql.append( "					                       AND A.ATCODE = K.ATCODE                                                                  \n");
					sql.append( "					                       AND A.AST1ST = K.AST1ST                                                                  \n");
					sql.append( "					                       AND A.AST2ND = K.AST2ND                                                                  \n");
					sql.append( "					                       AND A.AST3RD = K.AST3RD                                                                  \n");
					sql.append( "					                       AND A.ASTSEQ = K.ASTSEQ                                                                  \n");
					sql.append( "					                     GROUP BY K.FDCODE,K.ATCODE,K.AST1ST,K.AST2ND,K.AST3RD,K.ASTSEQ                             \n");
					sql.append( "					                   )                                                                                            \n");
					sql.append( "					 GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                       \n");
					sql.append( "					UNION ALL                                                                                                       \n");
					sql.append( "					--전기 누계액( 완료 안된건은 나오는데, 완료 된건은 안나옴.)                                                     \n");
					sql.append( "					SELECT A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ,                                                   \n");
					sql.append( "					       ACCOUNT.FN_COSTCD('"+str6+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS COSTCD,   \n");
					sql.append( "					       ACCOUNT.FN_COSTCD('"+str6+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,  \n");
					sql.append( "					       0 ASTAQAMT, SUM(A.ASTAMT) ABDEPRAMT, 0 ACDEPRAMT, '0' GUBUN                                              \n");
					sql.append( "					  FROM ACCOUNT.ASTYEPR A                                                                                        \n");
					sql.append( "					 WHERE 1=1                                                                                                      \n");
					if (!str1.equals(""))sql.append( " AND A.FDCODE ='"+str1+"'                                                                           \n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND ='"+str2+"'                                                                           \n");
					sql.append( "					   AND A.ASTYM <'"+str5+"'                                                                                      \n");
					sql.append( "					 GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                       \n");
					sql.append( "					UNION ALL                                                                                                       \n");
					sql.append( "					-- 당기 (이체전 )                                                                                               \n");
					sql.append( "					SELECT A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ,                                                   \n");
					sql.append( "					       A.COSTCD,                                                                                                \n");
					sql.append( "					       ACCOUNT.FN_COSTCD('"+str6+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,  \n");
					sql.append( "					       0 ASTAQAMT, 0 ABDEPRAMT, SUM(A.ASTAMT) ACDEPRAMT, '1' GUBUN                                              \n");
					sql.append( "					  FROM ACCOUNT.ASTYEPR A                                                                                        \n");
					sql.append( "					 WHERE 1=1                                                                                                      \n");
					if (!str1.equals(""))sql.append( " AND A.FDCODE='"+str1+"'                                                                            \n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND='"+str2+"'                                                                            \n");
					sql.append( "					   AND A.ASTYM >='"+str5+"'                                                                                     \n");
					sql.append( "					   AND A.COSTCD <> (SELECT COSTCD                                                                               \n");
					sql.append( "					                     FROM ACCOUNT.ASTYEPR C                                                                     \n");
					sql.append( "					                    WHERE C.FDCODE =A.FDCODE                                                                    \n");
					sql.append( "					                      AND C.ATCODE =A.ATCODE                                                                    \n");
					sql.append( "					                      AND C.AST1ST =A.AST1ST                                                                    \n");
					sql.append( "					                      AND C.AST2ND =A.AST2ND                                                                    \n");
					sql.append( "					                      AND C.AST3RD =A.AST3RD                                                                    \n");
					sql.append( "					                      AND C.ASTSEQ= A.ASTSEQ                                                                    \n");
					sql.append( "					                      AND C.ASTYM = ( SELECT MAX(B.ASTYM)                                                       \n");
					sql.append( "					                                       FROM ACCOUNT.ASTYEPR B                                                   \n");
					sql.append( "					                                      WHERE A.FDCODE = B.FDCODE                                                 \n");
					sql.append( "					                                        AND A.ATCODE = B.ATCODE                                                 \n");
					sql.append( "					                                        AND A.AST1ST = B.AST1ST                                                 \n");
					sql.append( "					                                        AND A.AST2ND = B.AST2ND                                                 \n");
					sql.append( "					                                        AND A.AST3RD = B.AST3RD                                                 \n");
					sql.append( "					                                        AND A.ASTSEQ = B.ASTSEQ                                                 \n");
					sql.append( "					                                      GROUP BY B.FDCODE, B.ATCODE, B.AST1ST, B.AST2ND, B.AST3RD, B.ASTSEQ       \n");
					sql.append( "					                                    )                                                                           \n");
					sql.append( "					                    )                                                                                           \n");
					sql.append( "					 GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                       \n");
					sql.append( "					UNION ALL                                                                                                       \n");
					sql.append( "					-- 당기 (이체후 )                                                                                               \n");
					sql.append( "					 SELECT A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ,                                                  \n");
					sql.append( "					        A.COSTCD,                                                                                               \n");
					sql.append( "					        ACCOUNT.FN_COSTCD('"+str6+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD, \n");
					sql.append( "					        MAX(A.ASTAQAMT)ASTAQAMT, 0 ABDEPRAMT, SUM(A.ASTAMT) ACDEPRAMT, '0' GUBUN                                \n");
					sql.append( "					  FROM ACCOUNT.ASTYEPR A                                                                                        \n");
					sql.append( "					 WHERE 1=1                                                                                                      \n");
					if (!str1.equals(""))sql.append( " AND A.FDCODE ='"+str1+"'                                                                           \n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND ='"+str2+"'                                                                           \n");
					if (!str4.equals(""))sql.append( " AND A.COSTCD ='"+str4+"'                                                                           \n");
					sql.append( "					   AND A.ASTYM >='"+str5+"'                                                                                     \n");
					sql.append( "					   AND A.COSTCD = (SELECT COSTCD                                                                                \n");
					sql.append( "					                     FROM ACCOUNT.ASTYEPR C                                                                     \n");
					sql.append( "					                    WHERE C.FDCODE =A.FDCODE                                                                    \n");
					sql.append( "					                      AND C.ATCODE =A.ATCODE                                                                    \n");
					sql.append( "					                      AND C.AST1ST =A.AST1ST                                                                    \n");
					sql.append( "					                      AND C.AST2ND =A.AST2ND                                                                    \n");
					sql.append( "					                      AND C.AST3RD =A.AST3RD                                                                    \n");
					sql.append( "					                      AND C.ASTSEQ= A.ASTSEQ                                                                    \n");
					sql.append( "					                      AND C.ASTYM = ( SELECT MAX(B.ASTYM)                                                       \n");
					sql.append( "					                                       FROM ACCOUNT.ASTYEPR B                                                   \n");
					sql.append( "					                                      WHERE A.FDCODE = B.FDCODE                                                 \n");
					sql.append( "					                                        AND A.ATCODE = B.ATCODE                                                 \n");
					sql.append( "					                                        AND A.AST1ST = B.AST1ST                                                 \n");
					sql.append( "					                                        AND A.AST2ND = B.AST2ND                                                 \n");
					sql.append( "					                                        AND A.AST3RD = B.AST3RD                                                 \n");
					sql.append( "					                                        AND A.ASTSEQ = B.ASTSEQ                                                 \n");
					sql.append( "					                                      GROUP BY B.FDCODE, B.ATCODE, B.AST1ST, B.AST2ND, B.AST3RD, B.ASTSEQ       \n");
					sql.append( "					                                    )                                                                           \n");
					sql.append( "					                    )                                                                                           \n");
					sql.append( "					 GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                       \n");
					sql.append( "					)X                                                                                                              \n");
					sql.append( "        LEFT JOIN ACCOUNT.ASTMSTN D ON D.FDCODE = X.FDCODE    \n");
					sql.append( " 						                     	AND D.ATCODE = X.ATCODE    \n");
					sql.append( " 						                     	AND D.AST1ST = X.AST1ST    \n");
					sql.append( " 					                    		AND D.AST2ND = X.AST2ND    \n");
					sql.append( " 							                    AND D.AST3RD = X.AST3RD    \n");
					sql.append( " 						                    	AND D.ASTSEQ = X.ASTSEQ    \n");
					sql.append( "        LEFT JOIN ACCOUNT.ASTNAME E ON E.AST2ND = D.AST2ND    \n");
					sql.append( "  							                    AND E.AST3RD = D.AST3RD    \n");
					sql.append( "  					                    		AND E.ASTCD  = D.ASTNAME   \n");
					sql.append( "				 LEFT JOIN ACCOUNT.ASTBASICN S ON S.FDCODE = X.FDCODE  AND S.ATCODE = X.ATCODE  \n"); 
					sql.append( "					  													 AND S.AST1ST = X.AST1ST  AND S.AST2ND = X.AST2ND \n");
					sql.append( "																		   AND S.AST3RD = X.AST3RD  AND S.ASTSEQ = X.ASTSEQ \n");
					sql.append( "				WHERE 1=1                                                                                                         \n");
					sql.append( "         AND S.ASTSTAT NOT IN ( '1','2','8' )                                                                                \n");
					if (str7.equals("1")){
						if (!str4.equals("")) sql.append( " AND X.COSTCD  = '" + str4 + "'                                                                 \n");
						sql.append( "				GROUP BY X.FDCODE,X.ATCODE,X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ, X.COSTCD, X.GUBUN, D.ASTNBR, D.ASTNAME,E.ASTNM, D.ASAQSDAT   \n");
					}else if (str7.equals("2")){
						if (!str4.equals("")) sql.append( " AND X.RCOSTCD  = '" + str4 + "'                                                                 \n");
					  sql.append( "				GROUP BY X.FDCODE,X.ATCODE,X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ, X.GUBUN,X.RCOSTCD, D.ASTNBR, D.ASTNAME,E.ASTNM, D.ASAQSDAT   \n");
					}
					sql.append( "  			ORDER BY D.ASAQSDAT,  D.ASTNBR,  X.GUBUN   \n");
					
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
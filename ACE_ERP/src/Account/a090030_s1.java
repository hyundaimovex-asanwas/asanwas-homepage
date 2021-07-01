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
public class a090030_s1 extends HttpServlet {

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

				String[] strArrCN = new String[]{"FDCODE",    "RCOSTCD",    "COSTCD",   "COSTNM",     "ATCODE",  "AST2ND", "AST2NDNM",
					                               "ASTAQAMT",  "ABDEPRAMT", "ACDEPRAMT", "ACDEPRSUM",  "ASTRMAMT" ,"REDUAMT" 
					                              }; 

				int[] intArrCN = new int[]{ 2,  6,   6, 100,  7, 2, 30,
					                         13, 13,  13, 13,  13, 13  }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1, -1, -1, 
					                           0,  0,  0,  0, 0, 0 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT Z.FDCODE,                                                                                                       \n");
					if (str7.equals("1")){
					sql.append( "        '0' RCOSTCD, Z.COSTCD,                                                                                            \n");
                	}else if (str7.equals("2")){
					sql.append( "        Z.RCOSTCD,  '0' COSTCD,                                                                                           \n");
					}
					sql.append( "         TRIM(D.CDNAM) AS COSTNM,   Z.ATCODE,  Z.AST2ND, E.CDNAM AS AST2NDNM,                                             \n");
					sql.append( "         SUM(Z.ASTAQAMT)ASTAQAMT, (SUM(Z.ABDEPRAMT))ABDEPRAMT, SUM(Z.ACDEPRAMT)ACDEPRAMT,                 \n");
					sql.append( "         (SUM(Z.ABDEPRAMT)+SUM(Z.ACDEPRAMT)+SUM(Z.REDUAMT)) AS ACDEPRSUM,                                                \n");
					sql.append( "         (SUM(Z.ASTAQAMT)-SUM(Z.ABDEPRAMT)-SUM(Z.ACDEPRAMT)- SUM(Z.REDUAMT)) AS ASTRMAMT, SUM(Z.REDUAMT)REDUAMT          \n");
					sql.append( "   FROM (                                                                                                                \n");
					sql.append( "     SELECT X.FDCODE, X.ATCODE, X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ,                                                     \n");
					sql.append( "            X.COSTCD, X.RCOSTCD,                                                                                         \n");
					sql.append( "            SUM(X.ASTAQAMT)ASTAQAMT, SUM(X.ABDEPRAMT)ABDEPRAMT, SUM(X.ACDEPRAMT)ACDEPRAMT,                               \n");
					sql.append( "            0 ASTRMAMT, X.GUBUN , 0 REDUAMT                                                                              \n");
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
					//if (!str4.equals(""))sql.append( " AND A.COSTCD ='"+str4+"'                                                                           \n");
					sql.append( "					   AND (A.ASTYM) < '"+str5+"'                                                                                   \n");
					sql.append( "					   AND NOT EXISTS ( SELECT K.FDCODE,K.ATCODE,K.AST1ST,K.AST2ND,K.AST3RD,K.ASTSEQ                                \n");
					sql.append( "					                      FROM ACCOUNT.ASTYEPR K                                                                    \n");
					sql.append( "					                     WHERE 1=1                                                                                  \n");
					if (!str1.equals(""))sql.append( "	         AND K.FDCODE='"+str1+"'                                                                  \n");
					if (!str2.equals(""))sql.append( "	         AND K.AST2ND='"+str2+"'                                                                  \n");
					//if (!str4.equals(""))sql.append( "	         AND K.COSTCD='"+str4+"'                                                                  \n");
					sql.append( "					                       AND K.ASTYM >='"+str5+"'                                                                 \n");
					sql.append( "					                       AND A.FDCODE = K.FDCODE                                                                  \n");
					sql.append( "					                       AND A.ATCODE = K.ATCODE                                                                  \n");
					sql.append( "					                       AND A.AST1ST = K.AST1ST                                                                  \n");
					sql.append( "					                       AND A.AST2ND = K.AST2ND                                                                  \n");
					sql.append( "					                       AND A.AST3RD = K.AST3RD                                                                  \n");
					sql.append( "					                       AND A.ASTSEQ = K.ASTSEQ                                                                  \n");
					sql.append( "					                     GROUP BY K.FDCODE,K.ATCODE,K.AST1ST,K.AST2ND,K.AST3RD,K.ASTSEQ                             \n");
                    sql.append( "					                   )                                                                                            \n");
					sql.append( "					 GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ                                    \n");
					//sql.append( "					 GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                       \n");
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
					//if (!str4.equals(""))sql.append( " AND A.COSTCD ='"+str4+"'                                                                           \n");
					sql.append( "					   AND A.ASTYM <'"+str5+"'                                                                                      \n");
					sql.append( "					 GROUP BY A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ, A.COSTCD                                       \n");
					sql.append( "					UNION ALL                                                                                                       \n");
					sql.append( "					-- 당기 (이체전 )                                                                                               \n");
					sql.append( "					SELECT A.FDCODE,A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,A.ASTSEQ,                                                   \n");
					sql.append( "					       A.COSTCD,                                                                                                \n");
					sql.append( "					       ACCOUNT.FN_COSTCD('"+str6+"', A.FDCODE,A.ATCODE,A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ,'0') AS RCOSTCD,  \n");
					sql.append( "					       0 ASTAQAMT, 0 ABDEPRAMT, SUM(A.ASTAMT) ACDEPRAMT, '1' GUBUN                                              \n");
					sql.append( "					  FROM ACCOUNT.ASTYEPR A                                                                                        \n");
					sql.append( "					 WHERE 1=1                                                                                                          \n");
					
					//2012.05.10 JYS 이체 받은 건은 이체전 당기상각액은 제외하고 조회함.
					sql.append( "					     AND  A.REGIGB='1'                                                                                          \n");
					if (!str1.equals(""))sql.append( " AND A.FDCODE='"+str1+"'                                                                            \n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND='"+str2+"'                                                                            \n");
					//if (!str4.equals(""))sql.append( " AND A.COSTCD='"+str4+"'                                                                            \n");
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
                    sql.append( "				WHERE 1=1                                                                                                         \n");
					if (str7.equals("1")){
					  if (!str4.equals("")) sql.append( " AND X.COSTCD  = '" + str4 + "'                                                                  \n");
					}else if (str7.equals("2")){
						if (!str4.equals("")) sql.append( " AND X.RCOSTCD  = '" + str4 + "'                                                                 \n");
          }
					sql.append( "				GROUP BY X.FDCODE,X.ATCODE,X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ, X.COSTCD, X.GUBUN,X.RCOSTCD                       \n");
			
			       sql.append( "	      UNION ALL \n");
					//손상차손누계액 
					sql.append( "				 SELECT  X.FDCODE, X.ATCODE, X.AST1ST,X.AST2ND,X.AST3RD,X.ASTSEQ,                 \n");
					sql.append( "				 		B.COSTCD, B.COSTCD RCOSTCD,                                                   \n");
					sql.append( "				 		0 ASTAQAMT, 0 ABDEPRAMT, 0 ACDEPRAMT, 0 ASTRMAMT, '0'GUBUN ,  X.REDUAMT       \n");
					sql.append( "				   FROM ACCOUNT.ASTDEPR X, ACCOUNT.ASTBASICN B                                    \n");
					sql.append( "				  WHERE X.FDCODE =B.FDCODE                                                        \n");
					sql.append( "				    AND X.ATCODE =B.ATCODE                                                        \n");
					sql.append( "				    AND X.AST1ST =B.AST1ST                                                        \n");
					sql.append( "				    AND X.AST2ND =B.AST2ND                                                        \n");
					sql.append( "				    AND X.AST3RD =B.AST3RD                                                        \n");
					sql.append( "				    AND X.ASTSEQ= B.ASTSEQ                                                        \n");
					if (!str1.equals(""))sql.append( " AND X.FDCODE ='"+str1+"'                                           \n");
					if (!str1.equals(""))sql.append( " AND X.REDUYM<='"+str6+"'                                           \n");
					sql.append( "				    AND X.REDUAMT<>0                                                              \n");									
					sql.append( "		)Z                                                                                    \n");
					 
					sql.append( " LEFT JOIN ACCOUNT.ASTBASICN S ON S.FDCODE = Z.FDCODE  AND S.ATCODE = Z.ATCODE \n"); 
					sql.append( "	  													 AND S.AST1ST = Z.AST1ST  AND S.AST2ND = Z.AST2ND \n");
					sql.append( "														   AND S.AST3RD = Z.AST3RD  AND S.ASTSEQ = Z.ASTSEQ \n");

					if (str7.equals("1")){
					  sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON D.CDCODE = Z.COSTCD AND D.CMTYPE='0030'                                               \n");
					}else if (str7.equals("2")){
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON D.CDCODE = Z.RCOSTCD AND D.CMTYPE='0030'                                              \n");
					}
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = Z.AST2ND AND E.CMTYPE='2101'                                                 \n");
					sql.append( " WHERE 1=1                                                                                                               \n");
					sql.append( "   AND S.ASTSTAT NOT IN ( '1','2','8' )                                                                                      \n");
					if (!str1.equals("")) sql.append( " AND Z.FDCODE = '" + str1 + "'                                                                     \n");
					if (!str2.equals("")) sql.append( " AND Z.AST2ND = '" + str2 + "'                                                                     \n");
					//if (!str4.equals("")) sql.append( " AND Z.RCOSTCD  = '" + str4 + "'                                                                   \n");				
					if (str7.equals("1")){
					  if (!str4.equals("")) sql.append( " AND Z.COSTCD  = '" + str4 + "'                                                                  \n");
					  sql.append( " GROUP BY Z.FDCODE, Z.AST2ND,  E.CDNAM,  D.CDNAM, Z.ATCODE, Z.COSTCD                                                   \n");		
					}else if (str7.equals("2")){
						if (!str4.equals("")) sql.append( " AND Z.RCOSTCD  = '" + str4 + "'                                                                 \n");
						sql.append( " GROUP BY Z.FDCODE, Z.AST2ND,   Z.RCOSTCD,  E.CDNAM,  D.CDNAM, Z.ATCODE                                                \n");		
          }
									
					sql.append( " ORDER BY Z.AST2ND, D.CDNAM                                                                                              \n");		

					logger.dbg.println( this, sql.toString() );
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
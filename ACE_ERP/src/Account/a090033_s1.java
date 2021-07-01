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
public class a090033_s1 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //지점
				String  str2 = req.getParameter("v_str2");    //자산분류
				String  str3 = req.getParameter("v_str3");    //자산코드
				String  str4 = req.getParameter("v_str4");    //원화,외화 구분 1-원화, 2-외화
				String  str5 = req.getParameter("v_str5");    //실사상태  1-보유 2-부족 3-불용
				String  str6 = req.getParameter("v_str6");    //원가코드


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);
				

				String[] strArrCN = new String[]{"FDCODE",    "ATCODE",    "AST1ST",   "AST2ND",    "AST3RD", "ASTSEQ",
					                               "ASTNBR",    "ASTNAME",   "ASTNM",    "ASAQSDAT",  "ASTQTY",
					                               "USELOC",    "ASTSTAT",   "ASTSTATNM", 
					                               "COSTCD",    "COSTNM",    "AST2NDNM", 
					                               "ASTAQAMT",  "ABDEPRAMT", "ACDEPRAMT","ASTRMAMT", "REDUAMT",
					                               "USEDPT",    "DEPTNM",   
                                                   "ASAQSDIV",  "ASAQSNM",   "ASTYUSE",
					                               "ACARNO",    "ACARDRVID", "ASTSIZE",  "ASTPYUNG", "DDSTS", "DDNOTE", "CHK",
					                               "BARCODE"
					                              }; 

				int[] intArrCN = new int[]{ 2,  7,   2,  2,  2, 5,
					                          8, 30, 100,  8, 10,
					                        100,  1,  20, 
					                          6,100,  30, 
					                         13, 13, 13, 13, 13,
                                              4, 60,
                                              1, 20,  5,
					                         20, 25, 20, 20 ,1,50,1 ,
					                         10
					                      
					                        }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1, -1, 
					                          -1, -1, -1, -1,  0,
					                          -1, -1, -1,
					                          -1, -1, -1,
					                           0,  0,  0,  0, 0,
					                          -1, -1, 
                                              -1, -1,  2,
					                          -1, -1, -1, -1, -1, -1,-1,
					                          -1
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
/*
					sql.append( " SELECT A.FDCODE,    A.ATCODE,    A.AST1ST,   A.AST2ND,  A.AST3RD,   A.ASTSEQ,   \n");
					sql.append( "        A.ASTNBR,    A.ASTNAME,   TRIM(D.ASTNM) ASTNM,   A.ASAQSDAT, B.ASTQTY,   \n");
					sql.append( "        B.USELOC,    B.ASTSTAT,   E.CDNAM AS ASTSTATNM,                          \n");
					sql.append( "        B.COSTCD,    F.CDNAM AS COSTNM,       G.CDNAM AS AST2NDNM,               \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(B.ASTAQAMT,0)   ELSE COALESCE(B.ASTAQAMTY,0) END AS ASTAQAMT,  \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ABDEPRAMT,0)  ELSE COALESCE(C.FOBDAMT,0)   END AS ABDEPRAMT, \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ACDEPRAMT,0)  ELSE COALESCE(C.FOCDAMT,0)   END AS ACDEPRAMT, \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ASTRMAMT,0)   ELSE COALESCE(C.FORMAMT,0)   END AS ASTRMAMT,  \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.REDUAMT,0)    ELSE COALESCE(C.FOREAMT,0)    END AS REDUAMT,  \n");
                    sql.append( "				 B.USEDPT,    L.DEPTNM,                                                   \n");
					sql.append( "				 B.ASAQSDIV,  K.CDNAM AS ASAQSNM,      B.ASTYUSE,                                  	 \n");
					sql.append( "				 nvl(I.ACARNO,'')ACARNO,   nvl(I.ACARDRVID,'')ACARDRVID,                    	 \n");
					sql.append( "				 nvl(H.ASTSIZE,'')ASTSIZE, nvl(H.ASTPYUNG,'') ASTPYUNG,                      	 \n");
					sql.append( "		 B.DDSTS, B.DDNOTE , 'F' CHK, '*'||A.ASTNBR||'*' AS BARCODE                                                               	\n");
					sql.append( "   FROM ACCOUNT.ASTMSTN A, ACCOUNT.ASTBASICN B                                   \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTDEPR C ON A.FDCODE = C.FDCODE                          \n");
                    sql.append( "                              AND A.ATCODE = C.ATCODE                            \n");
					sql.append( "                              AND A.AST1ST = C.AST1ST                            \n");
					sql.append( "                              AND A.AST2ND = C.AST2ND                            \n");
                    sql.append( "                              AND A.AST3RD = C.AST3RD                            \n");
					sql.append( "                              AND A.ASTSEQ = C.ASTSEQ                            \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME D ON A.AST2ND = D.AST2ND                            \n");
                    sql.append( "                              AND A.AST3RD = D.AST3RD                            \n");
					sql.append( "                              AND A.ASTNAME = D.ASTCD                            \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = B.ASTSTAT  AND E.CMTYPE ='2106'    \n");
                    sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = B.COSTCD   AND F.CMTYPE ='0030'    \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL G ON G.CDCODE = A.AST2ND   AND G.CMTYPE ='2101'    \n");
                    sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL K ON K.CDCODE = B.ASAQSDIV AND K.CMTYPE ='2103'    \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT L ON L.DEPTCD = B.USEDPT                             \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTADINFO1N H ON A.FDCODE = H.FDCODE                        \n");
					sql.append( "   							  AND A.ATCODE = H.ATCODE																				\n");
					sql.append( "   							  AND A.AST1ST = H.AST1ST																				\n");
					sql.append( "   							  AND A.AST2ND = H.AST2ND																				\n");
					sql.append( "   							  AND A.AST3RD = H.AST3RD																				\n");
					sql.append( "   							  AND A.ASTSEQ = H.ASTSEQ																				\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTADINFO2N I ON A.FDCODE = I.FDCODE                        \n");
					sql.append( "   							  AND A.ATCODE = I.ATCODE																			  \n");
					sql.append( "   							  AND A.AST1ST = I.AST1ST																			  \n");
					sql.append( "   							  AND A.AST2ND = I.AST2ND																			  \n");
					sql.append( "   							  AND A.AST3RD = I.AST3RD																			  \n");
					sql.append( "   							  AND A.ASTSEQ = I.ASTSEQ																			  \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTADINFO3N J ON A.FDCODE = J.FDCODE                        \n");
					sql.append( "   							  AND A.ATCODE = J.ATCODE																		    \n");
					sql.append( "   							  AND A.AST1ST = J.AST1ST																		    \n");
					sql.append( "   							  AND A.AST2ND = J.AST2ND																		    \n");
					sql.append( "   							  AND A.AST3RD = J.AST3RD																		    \n");
					sql.append( "   							  AND A.ASTSEQ = J.ASTSEQ																		    \n");
					sql.append( "  WHERE A.FDCODE = B.FDCODE                                                    \n");
                    sql.append( "       AND A.ATCODE = B.ATCODE                                                    \n");
					sql.append( "       AND A.AST1ST = B.AST1ST                                                      \n");
					sql.append( "       AND A.AST2ND = B.AST2ND                                                      \n");
                    sql.append( "	    AND A.AST3RD = B.AST3RD                                                      \n");
					sql.append( "	    AND A.ASTSEQ = B.ASTSEQ                                                     \n");
					sql.append( "       AND B.ASTSTAT ='0'                                                                 \n"); //정상건만 조회 
					if (!str1.equals(""))sql.append( " AND A.FDCODE='"+str1+"'                                    \n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND='"+str2+"'                                     \n");
					if (!str3.equals(""))sql.append( " AND A.ASTNAME='"+str3+"'                                  \n");
					if (!str5.equals(""))sql.append( " AND B.DDSTS='"+str5+"'                                      \n"); //실사상태 
					if (!str6.equals(""))sql.append( " AND B.COSTCD='"+str6+"'                                    \n");
					sql.append( "	 ORDER BY A.ASAQSDAT, A.ASTNBR                                             \n");
*/
					sql.append( " SELECT A.FDCODE,    A.ATCODE,    A.AST1ST,   A.AST2ND,  A.AST3RD,   A.ASTSEQ,   \n");
					sql.append( "        A.ASTNBR,    A.ASTNAME,   TRIM(D.ASTNM) ASTNM,   A.ASAQSDAT, B.ASTQTY,   	\n");
					sql.append( "        B.USELOC,    B.ASTSTAT,   E.CDNAM AS ASTSTATNM,                          				\n");
					sql.append( "        B.COSTCD,    F.CDNAM AS COSTNM,       G.CDNAM AS AST2NDNM,               		\n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(B.ASTAQAMT,0)   ELSE COALESCE(B.ASTAQAMTY,0) END AS ASTAQAMT,  \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ABDEPRAMT,0)  ELSE COALESCE(C.FOBDAMT,0)   END AS ABDEPRAMT, \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ACDEPRAMT,0)  ELSE COALESCE(C.FOCDAMT,0)   END AS ACDEPRAMT, \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ASTRMAMT,0)   ELSE COALESCE(C.FORMAMT,0)   END AS ASTRMAMT,  \n");
					sql.append( "        CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.REDUAMT,0)    ELSE COALESCE(C.FOREAMT,0)    END AS REDUAMT,  \n");
                    sql.append( "				 B.USEDPT,    ASNHR.SF_GET_DPTNAME0('01','A6',B.USEDPT )  DEPTNM,                                                   	\n");
					sql.append( "				 B.ASAQSDIV,  K.CDNAM AS ASAQSNM,      B.ASTYUSE,                                  	 	\n");
					sql.append( "				 nvl(I.ACARNO,'')ACARNO,   nvl(I.ACARDRVID,'') ACARDRVID,                    	 			\n");
					sql.append( "				 nvl(H.ASTSIZE,'')ASTSIZE, nvl(H.ASTPYUNG,'') ASTPYUNG,                      	 		\n");
					sql.append( "		 		B.DDSTS, B.DDNOTE , 'F' CHK, '*'||A.ASTNBR||'*' AS BARCODE                    		\n");
					sql.append( "   FROM ACCOUNT.ASTMSTN A                                   														\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTBASICN B ON A.FDCODE = B.FDCODE                          \n");
                    sql.append( "       AND A.ATCODE = B.ATCODE                                                    \n");
					sql.append( "       AND A.AST1ST = B.AST1ST                                                      \n");
					sql.append( "       AND A.AST2ND = B.AST2ND                                                      \n");
                    sql.append( "	    AND A.AST3RD = B.AST3RD                                                      \n");
					sql.append( "	    AND A.ASTSEQ = B.ASTSEQ                                                     \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTDEPR C ON A.FDCODE = C.FDCODE                          \n");
                    sql.append( "                              AND A.ATCODE = C.ATCODE                            \n");
					sql.append( "                              AND A.AST1ST = C.AST1ST                            \n");
					sql.append( "                              AND A.AST2ND = C.AST2ND                            \n");
                    sql.append( "                              AND A.AST3RD = C.AST3RD                            \n");
					sql.append( "                              AND A.ASTSEQ = C.ASTSEQ                            \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME D ON A.AST2ND = D.AST2ND                            \n");
                    sql.append( "                              AND A.AST3RD = D.AST3RD                            \n");
					sql.append( "                              AND A.ASTNAME = D.ASTCD                            \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = B.ASTSTAT  AND E.CMTYPE ='2106'    \n");
                    sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = B.COSTCD   AND F.CMTYPE ='0030'    \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL G ON G.CDCODE = A.AST2ND   AND G.CMTYPE ='2101'    \n");
                    sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL K ON K.CDCODE = B.ASAQSDIV AND K.CMTYPE ='2103'    \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTADINFO1N H ON A.FDCODE = H.FDCODE                        \n");
					sql.append( "   							  AND A.ATCODE = H.ATCODE																				\n");
					sql.append( "   							  AND A.AST1ST = H.AST1ST																				\n");
					sql.append( "   							  AND A.AST2ND = H.AST2ND																				\n");
					sql.append( "   							  AND A.AST3RD = H.AST3RD																				\n");
					sql.append( "   							  AND A.ASTSEQ = H.ASTSEQ																				\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTADINFO2N I ON A.FDCODE = I.FDCODE                        \n");
					sql.append( "   							  AND A.ATCODE = I.ATCODE																			  \n");
					sql.append( "   							  AND A.AST1ST = I.AST1ST																			  \n");
					sql.append( "   							  AND A.AST2ND = I.AST2ND																			  \n");
					sql.append( "   							  AND A.AST3RD = I.AST3RD																			  \n");
					sql.append( "   							  AND A.ASTSEQ = I.ASTSEQ																			  \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTADINFO3N J ON A.FDCODE = J.FDCODE                        \n");
					sql.append( "   							  AND A.ATCODE = J.ATCODE																		    \n");
					sql.append( "   							  AND A.AST1ST = J.AST1ST																		    \n");
					sql.append( "   							  AND A.AST2ND = J.AST2ND																		    \n");
					sql.append( "   							  AND A.AST3RD = J.AST3RD																		    \n");
					sql.append( "   							  AND A.ASTSEQ = J.ASTSEQ																		    \n");
					sql.append( "  WHERE 1 = 1                                                    \n");
					sql.append( "       AND B.ASTSTAT ='0'                                                                 \n"); //정상건만 조회 
					if (!str1.equals(""))sql.append( " AND A.FDCODE='"+str1+"'                                    \n");
					if (!str2.equals(""))sql.append( " AND A.AST2ND='"+str2+"'                                     \n");
					if (!str3.equals(""))sql.append( " AND A.ASTNAME='"+str3+"'                                  \n");
					if (!str5.equals(""))sql.append( " AND B.DDSTS='"+str5+"'                                      \n"); //실사상태 
					if (!str6.equals(""))sql.append( " AND B.COSTCD='"+str6+"'                                    \n");
					sql.append( "	 ORDER BY A.ASAQSDAT, A.ASTNBR                                             \n");
					
					//System.out.println("# Query : \n" + sql);
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
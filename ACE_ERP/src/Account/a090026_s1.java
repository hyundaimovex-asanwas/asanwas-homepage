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
public class a090026_s1 extends HttpServlet {
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
				// 자산 이체 및 이동

				String  str1 = req.getParameter("v_str1");    //지점    
				String  str2 = req.getParameter("v_str2");    //원가명  
				String  str3 = req.getParameter("v_str3");    //원가코드
				String  str4 = req.getParameter("v_str4");    //중분류  
				String  str5 = req.getParameter("v_str5");    //소분류	
				String  str6 = req.getParameter("v_str6");    //자산코드
				String  str7 = req.getParameter("v_str7");    //자산명  
				String  str8 = req.getParameter("v_str8");    //상태      8-이체, 9-이동 
				String  str9 = req.getParameter("v_str9");    //원가명                    
				String  str10= req.getParameter("v_str10");   //원가코드 ( 이동/이체 전 ) 
				String  str11= req.getParameter("v_str11");   //이동일자 FR               
				String  str12= req.getParameter("v_str12");   //이동일자 TO               

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";
				if (str9 == null) str9 = "";
				if (str10== null) str10= "";
				if (str11== null) str11= "";
				if (str12== null) str12= "";

				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CHK",      "ASTNBR",    "ASTNAME",   "ASTNM",   "FDCODE",
					                               "ATCODE",   "AST1ST",    "AST2ND",    "AST3RD",  "ASTSEQ",
                                         "ASTSTAT",  "BUSEDPT",   "BUSEDPTNM", "BMNGDPT", "BMNGDPTNM",
                                         "BCOSTCD",  "BCOSTNM",   "BDEPTGB",   "BUSER",   "BUSERNM",
					                               "ASAQSDAT", "ASTAQAMT",  "UFDCODE",   "ASTGUBUN", "WRID", "WRNM"
				                                }; 

				int[] intArrCN = new int[]{ 1, 8,30,60, 2,
					                          7, 2, 2, 2, 5,
				                            1, 4,50, 4,50,
					                          6,40, 1,10,20,
					                          8,13, 2, 1, 7, 20
				                           }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1,
                                    -1, -1, -1, -1, -1, 
					                          -1,  0,  2, -1, -1, -1 
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
					sql.append( " SELECT 'F' CHK,   B.ASTNBR, B.ASTNAME, TRIM(X.ASTNM) AS ASTNM, A.FDCODE,                                            \n");
					sql.append( "        A.ATCODE,  A.AST1ST, A.AST2ND,  A.AST3RD, A.ASTSEQ,                                                          \n");
					sql.append( "        A.ASTSTAT, A.USEDPT AS BUSEDPT, TRIM(D.DEPTNM) AS BUSEDPTNM,A.MNGDPT AS BMNGDPT, TRIM(C.DEPTNM) AS BMNGDPTNM,\n");
					sql.append( "        A.COSTCD AS BCOSTCD, TRIM(Y.CDNAM) AS BCOSTNM,																															  \n");
					sql.append( "        A.DEPRGB AS BDEPTGB, A.ASTUSER AS BUSER,   Z.EMPNMK AS BUSERNM,																						  \n");
					sql.append( "        B.ASAQSDAT, COALESCE(A.ASTAQAMT,0) AS ASTAQAMT, D.FDCODE AS UFDCODE, G.ASTGUBUN,G.WRID, Q.EMPNMK AS WRNM     \n");
					sql.append( "   FROM ACCOUNT.ASTBASICN A, ACCOUNT.ASTMSTN B																																			  \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.MNGDPT=C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)						  \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.USEDPT=D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)						  \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD								  \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL Y ON A.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'																						  \n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON Z ON A.ASTUSER = Z.EMPNO AND Z.USESTS IN ('1','2','3')																  \n");
					sql.append( "   LEFT JOIN (  SELECT Y.FDCODE,   Y.ATCODE,  Y.AST1ST,  Y.AST2ND,  Y.AST3RD,  Y.ASTSEQ,                           	\n");
					sql.append( "                       Y.ASTGUBUN, Y.WRID,    Y.MOVDATE, Y.BCOSTCD AS BBCOSTCD                                      	\n");
					sql.append( "                  FROM ACCOUNT.ASTMOVINGN Y																																					\n");
					sql.append( "                 WHERE ASTGUBUN ='"+str8+"'																																					\n");
					sql.append( "                   AND ASTMOVNO  =( SELECT MAX(X.ASTMOVNO)																														\n");
					sql.append( "                                      FROM ACCOUNT.ASTMOVINGN X																											\n");
					sql.append( "                                     WHERE Y.FDCODE = X.FDCODE																												\n");
					sql.append( "                                       AND Y.ATCODE = X.ATCODE																												\n");
					sql.append( "                                       AND Y.AST1ST = X.AST1ST																												\n");
					sql.append( "                                       AND Y.AST2ND = X.AST2ND																												\n");
					sql.append( "                                       AND Y.AST3RD = X.AST3RD																												\n");
					sql.append( "                                       AND Y.ASTSEQ = X.ASTSEQ																												\n");
					sql.append( "                                       AND Y.ASTGUBUN = '"+str8+"'			  																						\n");              
					sql.append( "                                   )																																									\n");
					sql.append( "            ) G ON G.FDCODE = A.FDCODE																																								\n");
					sql.append( "               AND G.ATCODE = A.ATCODE																																								\n");
					sql.append( "               AND G.AST1ST = A.AST1ST																																								\n");
					sql.append( "               AND G.AST2ND = A.AST2ND																																								\n");
					sql.append( "               AND G.AST3RD = A.AST3RD																																								\n");
					sql.append( "               AND G.ASTSEQ = A.ASTSEQ																																								\n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON Q ON G.WRID = Q.EMPNO AND Q.USESTS IN ('1','2','3')      														  \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL L ON G.BBCOSTCD=L.CDCODE AND L.CMTYPE='0030'               														  \n");				
					sql.append( "  WHERE A.FDCODE = B.FDCODE																																											    \n");
					sql.append( "    AND A.AST1ST = B.AST1ST																																											    \n");
					sql.append( "    AND A.AST2ND = B.AST2ND																																											    \n");
					sql.append( "    AND A.AST3RD = B.AST3RD																																											    \n");
					sql.append( "    AND A.ASTSEQ = B.ASTSEQ																																											    \n");
					if (!str1.equals(""))sql.append( "  AND  B.FDCODE = '"+str1+"'    									\n");    //지점     
					if (!str2.equals(""))sql.append( "  AND  Y.CDNAM LIKE '"+str2+"%' 									\n");		 //원가명   
					if (!str3.equals(""))sql.append( "  AND  A.COSTCD = '"+str3+"'    									\n");		 //원가코드 
					if (!str4.equals(""))sql.append( "  AND  A.AST2ND = '"+str4+"'    									\n");		 //중분류   
					if (!str5.equals(""))sql.append( "  AND  A.AST3RD = '"+str5+"'    									\n");		 //소분류	 
					if (!str6.equals(""))sql.append( "  AND  B.ASTNAME = '"+str6+"'   									\n");		 //자산코드 
					if (!str7.equals(""))sql.append( "  AND  X.ASTNM LIKE '"+str7+"%' 									\n");		 //자산명   
					if (!str8.equals("")&&!str8.equals("9"))sql.append( " AND  A.ASTSTAT = '"+str8+"'    			\n");		 //상태   
					if (!str8.equals("")&&str8.equals("9"))sql.append( "  AND  G.ASTGUBUN = '"+str8+"'   		\n");		 //이동   
					if (!str9.equals(""))sql.append( "  AND  L.CDNAM LIKE '"+str9+"%'  								\n");    //이체/이동 전 원가명     
					if (!str10.equals(""))sql.append( " AND  G.BBCOSTCD = '"+str10+"' 								\n");    //이체/이동 전 원가코드          
					if (!str11.equals("")&&!str12.equals(""))sql.append( "  AND  G.MOVDATE BETWEEN '"+str11+"' AND '"+str12+"'  	\n");    //이동일자     
					sql.append( "  ORDER BY B.ASTNBR                                  																		\n");
*/					
					sql.append( " SELECT 'F' CHK,   B.ASTNBR, B.ASTNAME, TRIM(X.ASTNM) AS ASTNM, A.FDCODE,                  \n");
					sql.append( "        A.ATCODE,  A.AST1ST, A.AST2ND,  A.AST3RD, A.ASTSEQ,                                             \n");
					sql.append( "        A.ASTSTAT, A.USEDPT AS BUSEDPT, 																			\n");
					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.USEDPT )  AS BUSEDPTNM,									\n");
					sql.append( "        A.MNGDPT AS BMNGDPT, 																							\n");
					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.MNGDPT )  AS BMNGDPTNM,								\n");
					sql.append( "        A.COSTCD AS BCOSTCD, TRIM(Y.CDNAM) AS BCOSTNM,												\n");
					sql.append( "        A.DEPRGB AS BDEPTGB, A.ASTUSER AS BUSER,   												  		\n");
					sql.append( "        ASNHR.SF_GET_ENONAME('01',A.ASTUSER ) AS BUSERNM,											\n");
					sql.append( "        B.ASAQSDAT, COALESCE(A.ASTAQAMT,0) AS ASTAQAMT,      										\n");
					sql.append( "        A.FDCODE AS UFDCODE, G.ASTGUBUN,G.WRID,      														\n");
					sql.append( "        ASNHR.SF_GET_ENONAME('01',G.WRID ) AS WRNM     													\n");
					sql.append( "   FROM ACCOUNT.ASTBASICN A																							\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN B ON A.FDCODE = B.FDCODE								  				\n");
					sql.append( "    AND A.AST1ST = B.AST1ST																	    						\n");
					sql.append( "    AND A.AST2ND = B.AST2ND															    								\n");
					sql.append( "    AND A.AST3RD = B.AST3RD																								\n");
					sql.append( "    AND A.ASTSEQ = B.ASTSEQ																				    		\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD								  \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL Y ON A.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'																						  \n");
					sql.append( "   LEFT JOIN (  SELECT Y.FDCODE,   Y.ATCODE,  Y.AST1ST,  Y.AST2ND,  Y.AST3RD,  Y.ASTSEQ,                           	\n");
					sql.append( "                       Y.ASTGUBUN, Y.WRID,    Y.MOVDATE, Y.BCOSTCD AS BBCOSTCD                                      	\n");
					sql.append( "                  FROM ACCOUNT.ASTMOVINGN Y																																					\n");
					sql.append( "                 WHERE ASTGUBUN ='"+str8+"'																																					\n");
					sql.append( "                   AND ASTMOVNO  =( SELECT MAX(X.ASTMOVNO)																														\n");
					sql.append( "                                      FROM ACCOUNT.ASTMOVINGN X																											\n");
					sql.append( "                                     WHERE Y.FDCODE = X.FDCODE																												\n");
					sql.append( "                                       AND Y.ATCODE = X.ATCODE																												\n");
					sql.append( "                                       AND Y.AST1ST = X.AST1ST																												\n");
					sql.append( "                                       AND Y.AST2ND = X.AST2ND																												\n");
					sql.append( "                                       AND Y.AST3RD = X.AST3RD																												\n");
					sql.append( "                                       AND Y.ASTSEQ = X.ASTSEQ																												\n");
					sql.append( "                                       AND Y.ASTGUBUN = '"+str8+"'			  																						\n");              
					sql.append( "                                   )																																									\n");
					sql.append( "            ) G ON G.FDCODE = A.FDCODE																																								\n");
					sql.append( "               AND G.ATCODE = A.ATCODE																																								\n");
					sql.append( "               AND G.AST1ST = A.AST1ST																																								\n");
					sql.append( "               AND G.AST2ND = A.AST2ND																																								\n");
					sql.append( "               AND G.AST3RD = A.AST3RD																																								\n");
					sql.append( "               AND G.ASTSEQ = A.ASTSEQ																																								\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL L ON G.BBCOSTCD=L.CDCODE AND L.CMTYPE='0030'               														  \n");				
					sql.append( "  WHERE 1 = 1																		    		\n");
					if (!str1.equals(""))sql.append( "  AND  B.FDCODE = '"+str1+"'    									\n");    //지점     
					if (!str2.equals(""))sql.append( "  AND  Y.CDNAM LIKE '"+str2+"%' 									\n");		 //원가명   
					if (!str3.equals(""))sql.append( "  AND  A.COSTCD = '"+str3+"'    									\n");		 //원가코드 
					if (!str4.equals(""))sql.append( "  AND  A.AST2ND = '"+str4+"'    									\n");		 //중분류   
					if (!str5.equals(""))sql.append( "  AND  A.AST3RD = '"+str5+"'    									\n");		 //소분류	 
					if (!str6.equals(""))sql.append( "  AND  B.ASTNAME = '"+str6+"'   									\n");		 //자산코드 
					if (!str7.equals(""))sql.append( "  AND  X.ASTNM LIKE '"+str7+"%' 									\n");		 //자산명   
					if (!str8.equals("")&&!str8.equals("9"))sql.append( " AND  A.ASTSTAT = '"+str8+"'    			\n");		 //상태   
					if (!str8.equals("")&&str8.equals("9"))sql.append( "  AND  G.ASTGUBUN = '"+str8+"'   		\n");		 //이동   
					if (!str9.equals(""))sql.append( "  AND  L.CDNAM LIKE '"+str9+"%'  								\n");    //이체/이동 전 원가명     
					if (!str10.equals(""))sql.append( " AND  G.BBCOSTCD = '"+str10+"' 								\n");    //이체/이동 전 원가코드          
					if (!str11.equals("")&&!str12.equals(""))sql.append( "  AND  G.MOVDATE BETWEEN '"+str11+"' AND '"+str12+"'  	\n");    //이동일자     
					sql.append( "  ORDER BY B.ASTNBR                                  																		\n");
					
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
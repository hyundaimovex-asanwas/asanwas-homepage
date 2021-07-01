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
public class a020013_s1 extends HttpServlet {
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
				String [] str = new String [11];
				str[0]	= req.getParameter("v_str1");		//현장                  
				str[1]	= req.getParameter("v_str2");		//처리기간fr            
				str[2]	= req.getParameter("v_str3");		//처리기간to            
				str[3]	= req.getParameter("v_str4");		//담당부서              
				str[4]	= req.getParameter("v_str5");		//회계팀/재무팀 구별 "A"
				str[5]	= req.getParameter("v_str6");		//결재유무              
				str[6]	= req.getParameter("v_str7");		//건명     
				str[7]	= req.getParameter("v_str8");		//지점구분              
				str[8]	= req.getParameter("v_str9");		//업무구분   
				str[9]	= req.getParameter("v_str10");	//empno  
				str[10]	= req.getParameter("v_str11");	//복사전표 
			
				for (int s=0;s<=10;s++) {
					if (str[s]==null) str[s] = "";
				}

				if (str[3]=="C210") str[3]="";
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK", "FDCODE",	  "FSDAT",	"FSDAT1", "CDNAM",   "FSDAT2", "FSNBR",  "FSDTNB",  "FSKND",
					                                "FSWRTDAT",	"COCODE",	"DEPTCD", "EMPNO",	 "DIVCD",
					                                "FSAMT",    "FSVAT",	"DETOT",	"CRTOT",	 "REMARK",	 
					                                "SGNDAT",	  "FSSTAT",	"ACTDAT",  
					                                "WRDT",	    "WRID",	  "UPDT",	  "UPID",
					                                "EMPNMK",   "DEPTNM", "DIVNM",  "SSDTNB", "SSDAT","SSNBR", "SSDAT1","SSDAT2","TOGB", "CHGDT"
				}; 

				int[] intArrCN = new int[]{  1, 2, 9, 1, 40, 8,  6, 16,  1,
					                           8, 2, 4,  7,  4,
																		15,15,15, 15, 132 ,  	
 					                           8, 1,  8, 
					                           8, 7, 8,  7,
					                          20, 70,70, 16, 9, 6, 1,8,2, 8
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,-1, -1, -1,-1, -1,
					                           -1, -1, -1,-1, -1,
				                              0,  0,  0, 0, -1,
					                           -1, -1,-1,
					                           -1, -1, -1,-1,
					                           -1, -1, -1,-1, -1, -1,-1,-1,-1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ''CHK, A.FDCODE,   A.FSDAT,    SUBSTR(A.FSDAT,1,1)FSDAT1, '회계' AS CDNAM, SUBSTR(A.FSDAT,2,9)FSDAT2,  A.FSNBR, \n " );
					sql.append( "        CASE  WHEN (A.FSDAT=''OR A.FSDAT IS NULL) THEN '' ELSE A.FSDAT||'-'||A.FSNBR END  FSDTNB,  				    \n " );
					sql.append( "        A.FSKND,                                                                                   					\n " );
					sql.append( "        A.FSWRTDAT, A.COCODE,   A.DEPTCD,  A.EMPNO,   A.DIVCD,                                     					\n " );
					sql.append( "        A.FSAMT,    A.FSVAT,    COALESCE(A.DETOT,0)DETOT,   COALESCE(A.CRTOT,0)CRTOT,   A.REMARK,   			        \n " );
					sql.append( "        A.SGNDAT,   A.FSSTAT,   A.ACTDAT,                          													\n " );
					sql.append( "        A.WRDT, A.WRID, A.UPDT, A.UPID ,  																				\n " );
					sql.append( "        C.ENO_NM AS EMPNMK, 																							\n " );
					sql.append( "        D.DPT_NM AS DEPTNM, E.DPT_NM AS DIVNM,                                                                  	    \n " );
					sql.append( "        CASE  WHEN (A.SSDAT=''OR A.SSDAT IS NULL) THEN '' ELSE A.SSDAT||'-'||A.SSNBR END  SSDTNB,         	            \n " );
					sql.append( "        A.SSDAT, A.SSNBR ,SUBSTR(A.SSDAT,1,1)SSDAT1,SUBSTR(A.SSDAT,2,9)SSDAT2,G.TOGB, '' CHGDT     		            \n " );
					sql.append( "   FROM ACCOUNT.FSLIPMST A,                                                                        					\n " );
					sql.append( "   ASNHR.T_CM_PERSON C, ASNHR.T_CM_DEPT D, ASNHR.T_CM_DEPT E,                           				                \n " );
					sql.append( "   ( SELECT F.FDCODE, F.FSDAT, F.FSNBR, MAX(F.SEQ)SEQ, MAX(F.TOGB)TOGB                                                 \n " );
					sql.append( "       FROM ACCOUNT.ACTSGNSTS F, ACCOUNT.FSLIPMST B                                                                    \n " );
					sql.append( "      WHERE 1=1                                                                                                        \n " );
					sql.append( "        AND F.FDCODE = B.FDCODE                                                                                        \n " );
					sql.append( "        AND F.FSDAT = B.FSDAT                                                                                          \n " );
					sql.append( "        AND F.FSNBR = B.FSNBR                                                                                          \n " );
					if (!str[1].equals("")&&!str[2].equals("")) sql.append( "  AND B.ACTDAT BETWEEN '"+str[1]+"'  AND '"+str[2]+"'                      \n " );
					if (!str[7].equals(""))sql.append( " AND F.FDCODE ='"+str[7]+"'                                                                     \n " );             				
					sql.append( "        AND F.SEQ  = ( SELECT MAX(H.SEQ) FROM ACCOUNT.ACTSGNSTS H                                                      \n " );
					sql.append( "                        WHERE H.FDCODE = F.FDCODE                                                                      \n " );
					sql.append( "                          AND H.FSDAT = F.FSDAT                                                                        \n " );
					sql.append( "                          AND H.FSNBR = F.FSNBR )                                                                      \n " );
					sql.append( "                        GROUP BY  F.FDCODE, F.FSDAT, F.FSNBR ) G                                                       \n " );			
/*					
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL B ON SUBSTR(A.FSDAT,1,1) = RTRIM(B.CDCODE) AND CMTYPE='1155'  				\n " );
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO = C.EMPNO 																\n " );
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.DEPTCD = D.DEPTCD 																	\n " );
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON A.DIVCD = E.DEPTCD  																	\n " );
					sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON F ON A.EMPNO = F.EMPNO  																\n " );
					sql.append( "   LEFT JOIN ACCOUNT.ACTSGNSTS G ON A.FDCODE = G.FDCODE                                                  			\n " );
					sql.append( "   																 AND A.FSDAT = G.FSDAT                                                \n " );
					sql.append( "   																 AND A.FSNBR = G.FSNBR                                                \n " );
					sql.append( "   																 AND G.SEQ = ( SELECT MAX(H.SEQ) FROM ACCOUNT.ACTSGNSTS H             \n " );
					sql.append( "   																								WHERE A.FDCODE = H.FDCODE                             \n " );
					sql.append( "   																									AND A.FSDAT = H.FSDAT                               \n " );
					sql.append( "   																									AND A.FSNBR = H.FSNBR                               \n " );
					sql.append( "   																									AND A.FSNBR < '900000'                              \n " );
					if (!str[1].equals("")&&!str[2].equals(""))sql.append( "					AND A.ACTDAT BETWEEN '"+str[1]+"'  AND '"+str[2]+"'   \n " );
					if (!str[7].equals(""))sql.append( "  														AND A.FDCODE ='"+str[7]+"')                            \n " );
*/			
					sql.append( "  WHERE A.FDCODE IS NOT NULL  	\n " );
					sql.append( "    AND A.FSNBR < '900000'     \n " );
					sql.append( "    AND A.EMPNO = C.ENO_NO 	\n " );
					sql.append( "    AND A.DEPTCD= D.DPT_CD(+)  \n " );
					sql.append( "    AND A.DIVCD = E.DPT_CD(+)  \n " );
					sql.append( "    AND A.FDCODE= G.FDCODE(+)  \n " );
					sql.append( "    AND A.FSDAT = G.FSDAT(+)   \n " );
					sql.append( "    AND A.FSNBR = G.FSNBR(+)   \n " );
		
					/*
					sql.append( "    AND A.FDCODE = G.FDCODE AND A.FSDAT = G.FSDAT AND A.FSNBR = G.FSNBR 																\n " );
					sql.append( "    AND G.SEQ = ( SELECT MAX(H.SEQ) FROM ACCOUNT.ACTSGNSTS H																				\n " );
					sql.append( "    						WHERE A.FDCODE = H.FDCODE AND A.FSDAT = H.FSDAT																			\n " );
					sql.append( "    						AND A.FSNBR = H.FSNBR AND A.FSNBR < '900000' 																					\n " );
					if (!str[1].equals("")&&!str[2].equals(""))sql.append( "					AND A.ACTDAT BETWEEN '"+str[1]+"'  AND '"+str[2]+"'   								\n " );
					if (!str[7].equals(""))sql.append( "  														AND A.FDCODE ='"+str[7]+"')                            								\n " );				
					*/
					
					if (!str[1].equals("")&&!str[2].equals("")) sql.append( "  AND A.ACTDAT BETWEEN '"+str[1]+"'  AND '"+str[2]+"'  \n" );
					if (!str[5].equals("A")) sql.append( "    AND A.FSSTAT='" +str[5]+"'  											\n" );
					if (!str[6].equals(""))sql.append( "    AND A.REMARK LIKE '%"+str[6]+"%'   							   	        \n" );
					if (!str[7].equals(""))sql.append( "    AND A.FDCODE ='"+str[7]+"'         									    \n" );
					if (!str[8].equals(""))sql.append( "    AND SUBSTR(A.FSDAT,1,1) = '"+str[8]+"'   						        \n" );
					
					//2017.11.07 예외처리 김원규 ( 김원규 / 임보이 모두 조회가능 ) 
					if(str[9].equals("2080003")){                                   
						sql.append( "    AND A.EMPNO IN ('2080003','2140002')  	\n" );
					}else if(str[9].equals("6180022")){  //2018.12.06 예외처리 김원규 ( 관리센터 일경우 과거 김원규 데이터 조회 가능 ) 
						sql.append( "    AND A.EMPNO IN ('2080003','6180022')  	\n" );
					
					}else if(str[9].equals("6180021")){  //2018.12.11 예외처리 이정식 ( 관리센터 일경우 과거 김원규 데이터 조회 가능 ) 
						sql.append( "    AND A.EMPNO IN ('2040080','6180021')  	\n" );
						
					}else{
						if (!str[9].equals(""))sql.append( "  AND A.EMPNO = '"+str[9]+"'  \n" );
					}
					
					
					if (!str[10].equals(""))sql.append( "   AND A.FSKND = '"+str[10]+"'   \n" );
					sql.append( "  ORDER BY  A.FDCODE,   A.FSDAT DESC, A.FSNBR DESC  	  \n" );
					
					//System.out.println("a020013_s1 : " + sql.toString());
					
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
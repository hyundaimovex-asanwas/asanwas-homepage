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
public class a030008_s2_y extends HttpServlet {
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
				// 전체조회
				String  str1	= req.getParameter("v_str1");
				String  str2  = req.getParameter("v_str2");
				String  str3  = req.getParameter("v_str3");
				String  str4  = "";
				String  str5  = req.getParameter("v_str5");

				if(str1 == null) str1 = ""; //지점코드
				if(str2 == null) str2 = ""; //계산서기간 년월
				if(str3 == null) str3 = ""; 
				if(str4 == null) str4 = ""; 
				if(str5 == null) str5 = ""; 
        
				str4 = str2.substring(0,4);

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "ATCODE", "ATKORNAM", "ATPRTSEQ","ATUSEYN", "DEVAL", "DETOT",
																						"CRTOT", "CRVAL"
				}; 

				int[] intArrCN = new int[]{ 7, 66, 7, 1, 15, 15, 15,	15
				}; 
			
				int[] intArrCN2 = new int[]{-1, -1, -1,-1, 0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					if(str5.equals("A")){ //전체
						
						sql.append(" SELECT C.ATCODE ATCODE, C.ATKORNAM ATKORNAM, C.ATPRTSEQ, ATUSEYN ATUSEYN,   \n");
						sql.append("        CASE WHEN C.ATDECR='1' THEN  nvl(B.DETOT - B.CRTOT,0) ELSE 0 END DEVAL,  \n");
						sql.append("        B.DETOT DETOT,                                                              								\n");
						sql.append("        B.CRTOT CRTOT,                                                              								\n");
						sql.append("        CASE WHEN C.ATDECR='2' THEN  nvl(B.CRTOT - B.DETOT,0) ELSE 0 END CRVAL   \n");
						sql.append("  FROM(                                                                             									\n");
						sql.append("        SELECT Y.ATCODE, SUM(DETOT) DETOT, SUM(CRTOT)CRTOT                          	\n");
						sql.append("        FROM (                                                                      									\n");
						sql.append(" 				 SELECT A.ATCODE ATCODE,                                                    				\n");
						sql.append(" 								SUM(A.DETOT) DETOT,                                                 			\n");
						sql.append(" 								SUM(A.CRTOT) CRTOT                                                  			\n");
						sql.append(" 					 FROM ACCOUNT.MTOTALBAL A                                                 			\n");
						sql.append(" 					WHERE A.FDCODE IN ('01','02','04')                                        				\n");
						sql.append(" 						AND (A.ACTYYMM >= '"+str4+"00' AND A.ACTYYMM <= '"+str2+"')             \n");
						sql.append(" 					GROUP BY A.ATCODE                                                         					\n");
						sql.append(" 					UNION ALL                                                                 							\n");
						sql.append(" 					SELECT A.ATCODE ATCODE,                                                   				\n");
						sql.append(" 								SUM(A.FODETOT) DETOT,                                               			\n");
						sql.append(" 								SUM(A.FOCRTOT) CRTOT                                                			\n");
						sql.append(" 					 FROM ACCOUNT.MTOTALBAL A                                                 			\n");
						sql.append(" 					WHERE A.FDCODE = '03'                                                     					\n");
						sql.append(" 						AND (A.ACTYYMM >= '"+str4+"00' AND A.ACTYYMM <= '"+str2+"')             \n");
						sql.append(" 					GROUP BY A.ATCODE                                                         					\n");
						sql.append("				  UNION ALL --2010.04.07 JYS 수정분개는 서울건만 적용함.							\n");
						sql.append("				 SELECT A.ATCODE,SUM(A.DETOT) DETOT,SUM(A.CRTOT) CRTOT				\n");
						sql.append("				   FROM ACCOUNT.MDMTOTAL A																\n");
						sql.append("				  WHERE A.FDCODE = '02'																		\n");
						sql.append("				    AND (A.ACTYYMM >= '"+str4+"00' AND A.ACTYYMM <= '"+str2+"')					\n");
						sql.append("				  GROUP BY A.ATCODE																			\n");
						sql.append(" 					)Y                                                                        								\n");
						sql.append(" 				GROUP BY ATCODE                                                             					\n");
						sql.append(" 			)B                                                                            									\n");
						sql.append("  LEFT JOIN ACCOUNT.ACTCODE C  ON B.ATCODE = C.ATCODE                               		\n");
						if(str3.equals("Y"))sql.append(" WHERE C.ATUSEYN = 'Y'                                          						\n");
						if(str3.equals("N"))sql.append(" WHERE C.ATUSEYN!= 'Y'                                          						\n");
						sql.append(" ORDER BY C.ATPRTSEQ                                                                							\n");
					
					}else if(str5.equals("K")){ //금강산 : 금강산건은 수정분개 사용안함.
												
						sql.append(" SELECT C.ATCODE ATCODE, C.ATKORNAM ATKORNAM, C.ATPRTSEQ, ATUSEYN ATUSEYN,          \n");
						sql.append("        CASE WHEN C.ATDECR='1'  THEN  nvl(B.DETOT - B.CRTOT,0) ELSE 0 END DEVAL, \n");
						sql.append("        B.DETOT DETOT,                                                              \n");
						sql.append("        B.CRTOT CRTOT,                                                              \n");
						sql.append("        CASE WHEN C.ATDECR='2'  THEN  nvl(B.CRTOT - B.DETOT,0) ELSE 0 END CRVAL  \n");
						sql.append("  FROM(                                                                             \n");
						sql.append(" 				 SELECT A.ATCODE ATCODE,                                                    \n");
						sql.append(" 								SUM(A.FODETOT) DETOT,                                               \n");
						sql.append(" 								SUM(A.FOCRTOT) CRTOT                                                \n");
						sql.append(" 					 FROM ACCOUNT.MTOTALBAL A                                                 \n");
						sql.append(" 					WHERE A.FDCODE IN ('03')                                                  \n");
						sql.append(" 						AND (A.ACTYYMM >= '"+str4+"00' AND A.ACTYYMM <= '"+str2+"')             \n");
						sql.append(" 					GROUP BY A.ATCODE                                                         \n");
						sql.append(" 			)B                                                                            \n");
						sql.append("  LEFT JOIN ACCOUNT.ACTCODE C  ON B.ATCODE = C.ATCODE                               \n");
						if(str3.equals("Y"))sql.append(" WHERE C.ATUSEYN = 'Y'                                          \n");
						if(str3.equals("N"))sql.append(" WHERE C.ATUSEYN!= 'Y'                                          \n");
						sql.append(" ORDER BY C.ATPRTSEQ                                                                \n");
					}
					
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
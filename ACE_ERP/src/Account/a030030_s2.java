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
public class a030030_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");  //지점
				String  str2  = req.getParameter("v_str2");  //회계년월
				String  str3  = req.getParameter("v_str3");  //구분
				String  str4  = "";
				String  stryymmdd="";

				str4 = str2.substring(0,4);
			
				if(str1 == null) str1 = ""; //지점       
				if(str2 == null) str2 = ""; //회계년월   
				if(str3 == null) str3 = ""; //구분       
				if(str4 == null) str4 = ""; //회계년도     
				

			//회계년월의 월이 00 일때 TOTALBAL 와 GENENLED	다른 조회일자적용		
				if(str2.substring(4,6).equals("00")){
					stryymmdd = str4+"0100";
				}else{
					stryymmdd = str2+"31";
				}			        

			        

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE","ATKORNAM", "DEAMT", "CRAMT","DETOT","CRTOT", "MDETOT", "MCRTOT"
																						
				}; 

				int[] intArrCN = new int[]{ 7,66,15, 15, 15, 15, 15,	15
				}; 
			
				int[] intArrCN2 = new int[]{-1,-1, 0, 0, 0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					if(str1.equals("A")){ //전체
						
						sql.append(" SELECT X.ATCODE, X.ATKORNAM,                                                         \n");
						sql.append("       SUM(X.DEAMT) DEAMT, SUM(X.CRAMT)CRAMT,                                         \n");
						sql.append("       SUM(X.DETOT)DETOT,  SUM(X.CRTOT)CRTOT,                                         \n");
						sql.append("       SUM(X.MDETOT)MDETOT,SUM(X.MCRTOT)MCRTOT                                        \n");
						sql.append("   FROM (                                                                             \n");
						sql.append("		SELECT (SUM(DEAMT)) DEAMT , (SUM(CRAMT))CRAMT,0 DETOT,0 CRTOT,0 MDETOT,0 MCRTOT,  \n");
						sql.append("		       A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                           \n");
						sql.append("		  FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE B                                      \n");
						sql.append("		 WHERE A.ATCODE = B.ATCODE                                                        \n");
						sql.append("		   AND A.FDCODE IN ('02','03','04')                                               \n");
						sql.append("		   AND B.ATUSEYN='Y'                                                              \n"); 
 						sql.append("		   AND A.ACTDAT BETWEEN '"+str4+"0100' AND '"+stryymmdd+"'                        \n"); 
 						sql.append("		 GROUP BY A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                        \n"); 
						sql.append("		UNION ALL                                                                         \n"); 
						sql.append("		SELECT 0 DEAMT,0 CRAMT,SUM(DETOT)DETOT, SUM(CRTOT)CRTOT,0 MDETOT,0 MCRTOT,        \n");
						sql.append("		       A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                           \n");
						sql.append("		  FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                      \n"); 
						sql.append("		 WHERE A.ATCODE = B.ATCODE                                                        \n"); 
						sql.append("		   AND A.FDCODE IN ('02','03','04')                                               \n"); 
						sql.append("		   AND B.ATUSEYN='Y'                                                              \n"); 
						sql.append("			AND A.ACTDAT BETWEEN '"+str4+"0100' AND '"+stryymmdd+"'                         \n");
						sql.append("		 GROUP BY A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                        \n"); 
						sql.append("		UNION ALL                                                                         \n"); 
						sql.append("		SELECT 0 DEAMT,0 CRAMT,0 DETOT,0 CRTOT,SUM(DETOT)MDETOT,SUM(CRTOT) MCRTOT,        \n"); 
						sql.append("		       A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                           \n");
						sql.append("		  FROM ACCOUNT.MTOTALBAL A, ACCOUNT.ACTCODE B                                     \n"); 
						sql.append("		 WHERE A.ATCODE = B.ATCODE                                                        \n"); 
						sql.append("		   AND A.FDCODE IN ('02','03','04')                                               \n"); 
						sql.append("		   AND B.ATUSEYN='Y'                                                              \n"); 
						sql.append("		   AND ACTYYMM BETWEEN '"+str4+"00' AND '"+str2+"'                                \n"); 
						sql.append("		 GROUP BY A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                        \n"); 
						sql.append("      )X                                                                              \n");  
						sql.append("    GROUP BY X.ATCODE, X.ATKORNAM,X.ATPRTSEQ                                          \n"); 
						sql.append("    ORDER BY X.ATPRTSEQ                                                               \n"); 
					}else{ 
						sql.append(" SELECT X.ATCODE, X.ATKORNAM,                                                         \n");
						sql.append("       SUM(X.DEAMT) DEAMT, SUM(X.CRAMT)CRAMT,                                         \n");
						sql.append("       SUM(X.DETOT)DETOT,  SUM(X.CRTOT)CRTOT,                                         \n");
						sql.append("       SUM(X.MDETOT)MDETOT,SUM(X.MCRTOT)MCRTOT                                        \n");
						sql.append("   FROM (                                                                             \n");
						sql.append("		SELECT (SUM(DEAMT)) DEAMT , (SUM(CRAMT))CRAMT,0 DETOT,0 CRTOT,0 MDETOT,0 MCRTOT,  \n");
						sql.append("		       A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                           \n");
						sql.append("		  FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE B                                      \n");
						sql.append("		 WHERE A.ATCODE = B.ATCODE                                                        \n");
						sql.append("		   AND A.FDCODE ='"+str1+"'                                                       \n");
						sql.append("		   AND B.ATUSEYN='Y'                                                              \n"); 
 						sql.append("		   AND A.ACTDAT BETWEEN '"+str4+"0100' AND '"+stryymmdd+"'                        \n"); 
						sql.append("		 GROUP BY A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                        \n"); 
						sql.append("		UNION ALL                                                                         \n"); 
						sql.append("		SELECT 0 DEAMT,0 CRAMT,SUM(DETOT)DETOT, SUM(CRTOT)CRTOT,0 MDETOT,0 MCRTOT,        \n");
						sql.append("		       A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                           \n");
						sql.append("		  FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                      \n"); 
						sql.append("		 WHERE A.ATCODE = B.ATCODE                                                        \n"); 
						sql.append("		   AND A.FDCODE ='"+str1+"'                                                       \n"); 
						sql.append("		   AND B.ATUSEYN='Y'                                                              \n"); 
						sql.append("			AND A.ACTDAT BETWEEN '"+str4+"0100' AND '"+stryymmdd+"'                         \n"); 
						sql.append("		 GROUP BY A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                        \n"); 
						sql.append("		UNION ALL                                                                         \n"); 
						sql.append("		SELECT 0 DEAMT,0 CRAMT,0 DETOT,0 CRTOT,SUM(DETOT)MDETOT,SUM(CRTOT) MCRTOT,        \n"); 
						sql.append("		       A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                           \n");
						sql.append("		  FROM ACCOUNT.MTOTALBAL A, ACCOUNT.ACTCODE B                                     \n"); 
						sql.append("		 WHERE A.ATCODE = B.ATCODE                                                        \n"); 
						sql.append("		   AND A.FDCODE ='"+str1+"'                                                       \n"); 
						sql.append("		   AND B.ATUSEYN='Y'                                                              \n"); 
						sql.append("		   AND ACTYYMM BETWEEN '"+str4+"00' AND '"+str2+"'                                \n");
						sql.append("		 GROUP BY A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                        \n"); 

						if(str1.equals("02")){
							sql.append("		UNION ALL                                                                       \n"); 
							sql.append("		SELECT SUM(DETOT) DEAMT,SUM(CRTOT) CRAMT,0 DETOT, 0 CRTOT,0 MDETOT,0 MCRTOT,    \n");
							sql.append("		       A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                         \n");
							sql.append("		  FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                    \n"); 
							sql.append("		 WHERE A.ATCODE = B.ATCODE                                                      \n"); 
							sql.append("		   AND A.FDCODE ='"+str1+"'                                                     \n"); 
							sql.append("		   AND B.ATUSEYN='Y'                                                            \n"); 
							sql.append("		   AND A.ATCODE ='3302210'                                                      \n"); 
							sql.append("			 AND A.ACTDAT BETWEEN '"+str4+"0100' AND '"+stryymmdd+"'                    \n"); 
							sql.append("		 GROUP BY A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                                      \n"); 
                        }
						sql.append("      )X                                                                              \n"); 
						sql.append("    GROUP BY X.ATCODE, X.ATKORNAM,X.ATPRTSEQ                                          \n"); 
						sql.append("    ORDER BY X.ATPRTSEQ                                                               \n"); 
					}
					//logger.dbg.println(this,sql.toString());
					
					//System.out.println("a030030_s2"+sql.toString());
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
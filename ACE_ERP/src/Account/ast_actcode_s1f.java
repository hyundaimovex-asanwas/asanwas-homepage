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
public class ast_actcode_s1f extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //계정코드 또는 계정명
				String  str2	= req.getParameter("v_str2"); //전표사용유무  "ATCODE : 계정코드로 관리항목 갯수 설정시만 사용
				String  str3	= req.getParameter("v_str3"); //지점코드  01 본사 02 서울 03 금강산 04 개성 , A 회계부서
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE",	 "ATKORNAM","ATDEBTYN",
					                                "CDCODE1", "CDNAM1",  "CDCODE2", "CDNAM2", 
					                                "CDCODE3", "CDNAM3",  "CDCODE4", "CDNAM4", 
					                                "CDCODE5", "CDNAM5",  "CDCODE6", "CDNAM6", 
					                                "CDCODE7", "CDNAM7",  "CDCODE8", "CDNAM8", 
					                                "CDCODE9", "CDNAM9",  
					                                "TYPE1", "TYPE2",  "TYPE3", "TYPE4", "TYPE5",
                                          "TYPE6", "TYPE7",  "TYPE8", "TYPE9",
					                                "ARBALDIV1", "ARBALDIV2",  "ARBALDIV3", "ARBALDIV4", "ARBALDIV5",
                                          "ARBALDIV6", "ARBALDIV7",  "ARBALDIV8", "ARBALDIV9",
				                                  "CNT"
																				 }; 

				int[] intArrCN = new int[]{ 7, 66, 1,
					                          4, 40, 4, 40, 
					                          4, 40, 4, 40, 
					                          4, 40, 4, 40, 
					                          4, 40, 4, 40, 
					                          4, 40, 
					                          1, 1, 1, 1, 1,
					                          1, 1, 1, 1,
					                          1, 1, 1, 1, 1,
					                          1, 1, 1, 1,
				                            1
					                          }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                           -1, -1,  
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1,  
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1,  
				                              0}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.ATCODE, X.ATKORNAM, X.ATDEBTYN,                                        ");
					sql.append( "         MAX(X.CDCODE1)CDCODE1, MAX(X.CDNAM1)CDNAM1,  MAX(X.TYPE1)TYPE1, MAX(X.ARBALDIV1)ARBALDIV1,   ");
					sql.append( "         MAX(X.CDCODE2)CDCODE2, MAX(X.CDNAM2)CDNAM2,  MAX(X.TYPE2)TYPE2, MAX(X.ARBALDIV2)ARBALDIV2,   ");
					sql.append( "         MAX(X.CDCODE3)CDCODE3, MAX(X.CDNAM3)CDNAM3,  MAX(X.TYPE3)TYPE3, MAX(X.ARBALDIV3)ARBALDIV3,   ");
					sql.append( "         MAX(X.CDCODE4)CDCODE4, MAX(X.CDNAM4)CDNAM4,  MAX(X.TYPE4)TYPE4, MAX(X.ARBALDIV4)ARBALDIV4,   ");
          sql.append( "         MAX(X.CDCODE5)CDCODE5, MAX(X.CDNAM5)CDNAM5,  MAX(X.TYPE5)TYPE5, MAX(X.ARBALDIV5)ARBALDIV5,   ");
					sql.append( "         MAX(X.CDCODE6)CDCODE6, MAX(X.CDNAM6)CDNAM6,  MAX(X.TYPE6)TYPE6, MAX(X.ARBALDIV6)ARBALDIV6,   ");
					sql.append( "         MAX(X.CDCODE7)CDCODE7, MAX(X.CDNAM7)CDNAM7,  MAX(X.TYPE7)TYPE7, MAX(X.ARBALDIV7)ARBALDIV7,   ");
					sql.append( "         MAX(X.CDCODE8)CDCODE8, MAX(X.CDNAM8)CDNAM8,  MAX(X.TYPE8)TYPE8, MAX(X.ARBALDIV8)ARBALDIV8,   ");
					sql.append( "         MAX(X.CDCODE9)CDCODE9, MAX(X.CDNAM9)CDNAM9,  MAX(X.TYPE9)TYPE9, MAX(X.ARBALDIV9)ARBALDIV9,   ");
          sql.append( "         COUNT(X.CDCODE1)+COUNT(X.CDCODE2)+COUNT(X.CDCODE3)+");
          sql.append( "         COUNT(X.CDCODE4)+COUNT(X.CDCODE5)+COUNT(X.CDCODE6)+");
          sql.append( "         COUNT(X.CDCODE7)+COUNT(X.CDCODE8)+COUNT(X.CDCODE9) AS CNT ");
					sql.append( "  FROM (                                                                          ");
					sql.append( "  			SELECT A.ATCODE, A.ATKORNAM, A.ATDEBTYN,                                   ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 1 THEN  B.CDCODE END CDCODE1,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 2 THEN  B.CDCODE END CDCODE2,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 3 THEN  B.CDCODE END CDCODE3,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 4 THEN  B.CDCODE END CDCODE4,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 5 THEN  B.CDCODE END CDCODE5,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 6 THEN  B.CDCODE END CDCODE6,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 7 THEN  B.CDCODE END CDCODE7,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 8 THEN  B.CDCODE END CDCODE8,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 9 THEN  B.CDCODE END CDCODE9,                  ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 1 THEN  C.CDNAM END CDNAM1,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 2 THEN  C.CDNAM END CDNAM2,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 3 THEN  C.CDNAM END CDNAM3,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 4 THEN  C.CDNAM END CDNAM4,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 5 THEN  C.CDNAM END CDNAM5,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 6 THEN  C.CDNAM END CDNAM6,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 7 THEN  C.CDNAM END CDNAM7,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 8 THEN  C.CDNAM END CDNAM8,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 9 THEN  C.CDNAM END CDNAM9,                     ");
          
					sql.append( "  						 CASE WHEN B.ARSEQ = 1 THEN  B.TYPE END TYPE1,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 2 THEN  B.TYPE END TYPE2,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 3 THEN  B.TYPE END TYPE3,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 4 THEN  B.TYPE END TYPE4,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 5 THEN  B.TYPE END TYPE5,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 6 THEN  B.TYPE END TYPE6,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 7 THEN  B.TYPE END TYPE7,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 8 THEN  B.TYPE END TYPE8,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 9 THEN  B.TYPE END TYPE9,                     ");
        
          sql.append( "  						 CASE WHEN B.ARSEQ = 1 THEN  B.ARBALDIV END ARBALDIV1,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 2 THEN  B.ARBALDIV END ARBALDIV2,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 3 THEN  B.ARBALDIV END ARBALDIV3,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 4 THEN  B.ARBALDIV END ARBALDIV4,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 5 THEN  B.ARBALDIV END ARBALDIV5,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 6 THEN  B.ARBALDIV END ARBALDIV6,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 7 THEN  B.ARBALDIV END ARBALDIV7,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 8 THEN  B.ARBALDIV END ARBALDIV8,                    ");
					sql.append( "  						 CASE WHEN B.ARSEQ = 9 THEN  B.ARBALDIV END ARBALDIV9                     ");

					sql.append( "  			FROM ACCOUNT.ACTCODE A                                                    ");
					sql.append( "  			LEFT JOIN ACCOUNT.ACTREFCODE B ON A.ATCODE = B.ATCODE                     ");
					sql.append( "  			LEFT JOIN ACCOUNT.COMMDTIL C ON B.CDCODE = C.CDCODE AND C.CMTYPE='0050'   ");
					if(!str2.equals("ATCODE")) sql.append( "  			WHERE (A.ATCODE LIKE '%"+str1+"%' OR A.ATKORNAM LIKE '%"+str1+"%')           ");
			  	if(str2.equals("ATCODE"))  sql.append( "  			WHERE  A.ATCODE = '"+str1+"'            ");
					
					if(!str2.equals("")) sql.append( "  			  AND  A.ATUSEYN='Y'     AND A.ATCODE LIKE '1220%'	 ");
					if(str3.equals("01")) sql.append( "  			  AND  A.COMMUSE IN ('1','2') ");
					if(str3.equals("02")) sql.append( "  			  AND  A.COMMUSE IN ('1','2') ");
					if(str3.equals("03")) sql.append( "  			  AND  A.COMMUSE IN ('1','3') ");
					if(str3.equals("04")) sql.append( "  			  AND  A.COMMUSE IN ('1','2') ");
			
					sql.append( "  ) X                                                                             ");
					sql.append( "  GROUP BY X.ATCODE,    X.ATKORNAM , X.ATDEBTYN                                   ");
				
			//	logger.dbg.println(this,sql.toString());
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
	} //public void
} //public class
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
public class a040091_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //입금구분  1-계약금, 2-중도금, 3-잔금
				String  str2	= req.getParameter("v_str2"); //회차 
				String  str3	= req.getParameter("v_str3"); //등록구분  1-미등록, 2-등록 
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				
	    		GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{   "CHK",
																		"BS_ID",           "BS_INGB",        "BS_SEQNO",  "BS_DNO",         "BS_HNO",
				                                                     	"BS_EMPNM",  "BS_EMAIL",      "BS_HPNO",     "BS_TELNO",
					                                                    "VEND_ID",       "VEND_CD",       "VEND_NM",     "VD_DIRECT",   "BSNS_CND",
					                                                    "BSNS_KND",   "VD_TELNO",     "VD_FAXNO",    "POST_NO1",   "POST_NO2",
					                                                    "ADDRESS1",   "ADDRESS2",    "COCOMYN",    "USE_TAG",
					                                                    "C_VEND_CD", "C_VEND_ID",     "C_SEQ",          "C_EMPNM",    "C_DEPTNM",
																		"C_EMAIL",      "C_HPNO",          "C_TELNO",      "C_ENDDT",     "C_USEGB",
																		"I_EMPNO",     "I_DATE",            "U_EMPNO",     "U_DATE",
																		"VEND_STS"
																	
														           }; 
														           

				int[] intArrCN = new int[]{ 1,     
					                                       10,      1,     2,     4,	  4, 
					                                       30,    30,	15,	15,   
					                                       15,	13,	 62,	62,    62,
					                                       62,    15,     15,  10,    10,
					                                     132,    72,       1,     1,
														    13,    15,      2,   30,   30,
														    30,    15,     15,    8,     1,
														    10,    10,     10,   10,
														    1
										                }; 

				int[] intArrCN2 = new int[]{ -1, 
					                                           0, -1, -1, -1, -1, 
					                                          -1, -1, -1, -1,
					                                          -1, -1, -1, -1, -1,
					                                          -1, -1, -1, -1, -1,
															  -1, -1, -1, -1,
					                                          -1, -1,   0, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1,
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
					sql.append( " SELECT '' CHK,                                                                                                                   \n" );
					sql.append( "              A.BS_ID,           A.BS_INGB,      A.BS_SEQNO,  A.BS_DNO,     A.BS_HNO,                                                            \n" );
					sql.append( "              A.BS_EMPNM,  A.BS_EMAIL,     A.BS_HPNO,    A.BS_TELNO,                                                                        \n" );
					sql.append( "              B.VEND_ID,       B.VEND_CD,     B.VEND_NM,    B.VD_DIRECT,  B.BSNS_CND,                                                          \n" );
					sql.append( "              B.BSNS_KND,   B.VD_TELNO,   B.VD_FAXNO,   B.POST_NO1,   B.POST_NO2,                                                          \n" );
					sql.append( "              B.ADDRESS1,   B.ADDRESS2,   B.COCOMYN,   B.USE_TAG,                                                                         \n" );
					sql.append( "              C.VEND_CD AS C_VEND_CD,    C.VEND_ID AS C_VEND_ID,    COALESCE(C.SEQ,0) AS C_SEQ,         C.EMPNM AS C_EMPNM,      C.DEPTNM AS C_DEPTNM,  \n" );
					sql.append( "              C.EMAIL   AS C_EMAIL,             C.HPNO AS C_HPNO,            C.TELNO AS C_TELNO,   C.ENDDT AS C_ENDDT,        C.USEGB AS C_USEGB,   \n" );
					sql.append( "              C.I_EMPNO,      C.I_DATE,         C.U_EMPNO,   C.U_DATE,                                                                           \n" );
					sql.append( "              CASE WHEN A.BS_EMAIL IS NOT NULL AND (C.EMAIL IS NULL OR C.EMAIL='') THEN 'N' ELSE 'Y' END VEND_STS     \n" );
					sql.append( "    FROM VNDUS.TBS010 A                                                                                                             \n" );
					sql.append( "    LEFT JOIN  ACCOUNT.GCZM_VENDER B ON A.BS_VENDID = B.VEND_ID   AND ( RTRIM(A.BS_VENDID)  IS NOT NULL AND A.BS_VENDID IS NOT NULL )     \n" );
					sql.append( "    LEFT JOIN  ACCOUNT.CUSTOMER C ON A.BS_VENDID = C.VEND_ID AND B.VEND_CD =C.VEND_CD AND A.BS_EMAIL = C.EMAIL                      \n" );					
					sql.append( "   WHERE A.BS_TAXKND='1'                                                                                                        \n" );
					
					if (!str1.equals("0")) sql.append( " AND A.BS_INGB = '"+str1+"' \n"); 
					if (!str2.equals("0")) sql.append( " AND A.BS_SEQNO = '"+str2+"' \n"); 
					if (str3.equals("1")) sql.append( " AND (  C.EMAIL IS NULL OR C.EMAIL =''  ) \n"); 
					if (str3.equals("2")) sql.append( " AND (  A.BS_EMAIL =C.EMAIL  AND A.BS_VENDID = C.VEND_ID )\n"); 
										
					sql.append( " ORDER BY VEND_CD ");
				   // System.out.println("a040091_s1::"+sql.toString());
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
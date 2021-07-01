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
public class a040090_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //입금구분  1^계약금,2^중도금1차 ,3^중도금2차 ,4^중도금3차 ,5^중도금4차 ,6^잔금
				String  str2	= req.getParameter("v_str2"); //회차 
				String  str3	= req.getParameter("v_str3"); //등록구분  1-미등록, 2-등록 
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				
	    		GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{   "CHK",
																		"BS_ID",           "BS_TAXKND",   "BS_DAT",       "BS_AMT",         "BS_TAXAMT",
																		"BS_TOTAMT", "BS_REMARK",  "BS_VENDID",  "BS_VENDNM",  "BS_DIRCNM",
																		"BS_CND",       "BS_KND",         "BS_COMYN",  "BS_PNO1",       "BS_PNO2",
																		"BS_ADDR1",    "BS_ADDR2",    "BS_USE",        "BS_STS",        "BS_EMPNM",
																		"BS_EMAIL",     "BS_HPNO",     "BS_TELNO",    "BS_INGB",       "BS_SEQNO",
																		"BS_DNO",       "BS_HNO",        "BS_TAXNO",
																		"I_EMPNO",      "I_DATE",          "U_EMPNO",     "U_DATE",
																		"VEND_ID",       "VEND_CD",      "VEND_NM",     "VD_DIRECT",   "BSNS_CND",
																		"BSNS_KND",   "VD_TELNO",    "VD_FAXNO",    "POST_NO1",   "POST_NO2",
																		"ADDRESS1",   "ADDRESS2",    "COCOMYN",    "USE_TAG",
																		"WRID",            "WRDT",
					                                                    "VEND_STS",   "VEND_UPT"
																	
														           }; 

				int[] intArrCN = new int[]{ 1,     
					                                       10,      1,      8,   15,	13, 
					                                       15,   132,	15,	62,    62,
					                                       62,	62,	  1,	10,    10,
					                                      132,    72,     1,  	  1,    30,
					                                        30,    15,    15,     1,     2,
														      4,     4,     11,
														     10,   10,     10,   10,
														    15,    13,     62,   62,   62,
														    62,    32,     32,   10,   10,
														   132,   72,       1,     1,
														     13,   10,
														     1 ,      1
										                }; 

				int[] intArrCN2 = new int[]{ -1, 
					                                            0, -1, -1,  0,   0, 
					                                            0, -1, -1, -1, -1,
					                                          -1, -1, -1, -1, -1,
					                                          -1, -1, -1, -1, -1,
					                                          -1, -1, -1, -1,  0,
															  -1, -1, -1, 
														      -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1,
															  -1, -1,
															  -1, -1                                          
					                                          
					                                    
												          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT '' CHK,                                                            											\n" );
					sql.append( "        A.BS_ID,           A.BS_TAXKND,   A.BS_DAT,      A.BS_AMT,         A.BS_TAXAMT, 		\n" );
					sql.append( "        A.BS_TOTAMT, A.BS_REMARK,  A.BS_VENDID, A.BS_VENDNM,  A.BS_DIRCNM, 			\n" );
					sql.append( "        A.BS_CND,        A.BS_KND,        A.BS_COMYN,  A.BS_PNO1,      A.BS_PNO2,   		\n" );
					sql.append( "        A.BS_ADDR1,    A.BS_ADDR2,    A.BS_USE,       A.BS_STS,         A.BS_EMPNM,  		\n" );
					sql.append( "        A.BS_EMAIL,     A.BS_HPNO,      A.BS_TELNO,  A.BS_INGB,        A.BS_SEQNO,  		\n" );
					sql.append( "        A.BS_DNO,       A.BS_HNO,         A.BS_TAXNO,                             						\n" );
					sql.append( "        A.I_EMPNO,      A.I_DATE,           A.U_EMPNO,   A.U_DATE,                  					\n" );
					sql.append( "        B.VEND_ID,       B.VEND_CD,    B.VEND_NM,   B.VD_DIRECT,  B.BSNS_CND,  				\n" );
					sql.append( "        B.BSNS_KND,  B.VD_TELNO,   B.VD_FAXNO,  B.POST_NO1,   B.POST_NO2,  			\n" );
					sql.append( "        B.ADDRESS1,  B.ADDRESS2,   B.COCOMYN,   B.USE_TAG,                 					\n" );
					sql.append( "        B.WRID,           B.WRDT,                                                									\n" );
					sql.append( "        CASE WHEN B.VEND_CD IS NULL OR B.VEND_CD='' THEN 'N' ELSE 'Y' END VEND_STS, \n" );
					sql.append( "        CASE WHEN A.BS_VENDID=B.VEND_ID AND (A.BS_VENDNM<>B.VEND_NM OR A.BS_DIRCNM<>B.VD_DIRECT) THEN 'U' ELSE 'N' END VEND_UPT \n" );
					sql.append( "  FROM VNDUS.TBS010 A                                                                                      		\n" );
					sql.append( "  LEFT JOIN  ACCOUNT.GCZM_VENDER B ON A.BS_VENDID = B.VEND_ID   AND RTRIM(A.BS_VENDID) IS NOT NULL           \n" );
					sql.append( "   WHERE A.BS_TAXKND='1'                                                                                	\n" );
					if (!str1.equals("0")) sql.append( " AND A.BS_INGB = '"+str1+"' 															\n"); 
					if (!str2.equals("0")) sql.append( " AND A.BS_SEQNO = '"+str2+"' 														\n"); 
					if (str3.equals("1")) sql.append( " AND RTRIM(B.VEND_ID) IS NULL 											\n"); 
					if (str3.equals("2")) sql.append( " AND RTRIM(B.VEND_ID) IS NOT NULL								\n"); 										
					sql.append( " ORDER BY  A.BS_VENDID ");
					
				   // System.out.println("a040090_s1 : \n" + sql.toString());
				   // logger.dbg.println(this,sql.toString());
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
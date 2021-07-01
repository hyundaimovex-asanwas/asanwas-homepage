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
public class a040092_s1 extends HttpServlet {
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
																		"BS_ID",           "BS_TAXKND",   "BS_DAT",       "BS_AMT",         "BS_TAXAMT",
																		"BS_TOTAMT", "BS_REMARK",  "BS_VENDID",  "BS_VENDNM",  "BS_DIRCNM",
																		"BS_CND",       "BS_KND",         "BS_COMYN",  "BS_PNO1",       "BS_PNO2",
																		"BS_ADDR1",    "BS_ADDR2",    "BS_USE",        "BS_STS",        "BS_EMPNM",
																		"BS_EMAIL",     "BS_HPNO",     "BS_TELNO",    "BS_INGB",       "BS_SEQNO",
																		"BS_DNO",       "BS_HNO",        "BS_TAXNO",   "BS_VENDCD",  "BS_PDTNM",   
																		"I_EMPNO",      "I_DATE",          "U_EMPNO",     "U_DATE",
																		"B_VEND_ID",   "B_VEND_CD",  "VEND_NM",     "VD_DIRECT",   "BSNS_CND",
																		"BSNS_KND",   "VD_TELNO",    "VD_FAXNO",    "POST_NO1",   "POST_NO2",
																		"ADDRESS1",   "ADDRESS2",    "COCOMYN",    "USE_TAG",
																																			
																		"C_SEQ",         "C_EMPNM",    "C_EMAIL",                     
																		"TAXNBR",       "COCODE",     "DEPTCD",          "EMPNO",         "TAXIODIV",  
																		"TAXDIV",         "TAXKND",      "VEND_CD",        "TAXDAT",         "TAXSUM",    
																		"TAXVATAMT", "TAXTOT",      "REMARK",          "TAXCDNBR",    "ATCODE",    
																		"TAXPRTYN",   "TAXCNT",      "LASTPRT",         "TAXTYPE",       "FSDAT",     
																		"FSNBR",         "TAXKIDIV",     "FDCODE",          "WORKTYPE",   "REPORT",    
																		"WRDT",          "WRID",           "UPDT",              "UPID",                    
																		"SSDAT",         "SSNBR",        "SEQ",                                  
																		"GUBUN",        "AMEND_CODE", "AMEND_REMARK",  "EXTCHK", "REMARK2",   
																		"REMARK3",     "S_BIZPLACE",    "B_BIZPLACE",                            
					                                                    
					                                                    "TAXSEQ",      "TAXPDTNAM", "TAXSTD",  "TAXQTY", "TAXPRIC",   
																		"BIGO",        "COSTCD"       
																		
																																	
														           }; 
														           
														        														           

				int[] intArrCN = new int[]{ 1,     
					                                       10,      1,      8,   15,	13, 
					                                       15,   132,	15,	62,    62,
					                                       62,	62,	  1,	10,    10,
					                                      132,    72,     1,  	  1,    30,
					                                        30,    15,    15,     1,     2,
														      4,     4,     11,   13,    36,
														     10,   10,     10,   10,
														    15,    13,     62,   62,   62,
														    62,    32,     32,   10,   10,
														   132,   72,       1,     1,
														   
														     2,    30,    30,
														     11,   2,     4,   7,    1,
														      4,    1,   13,   8,   15,
														     13,  15 , 132,  16,   7,
														     1,     3,   8,      1,    9, 
														     6,     1,    2,    1,    1, 
														     8,     7,    8,    7,
														     9,     6,    2,
														     1,     2, 100,   1,  150,
														     150,  4,    4,
														     
				                                          	 3,    70,  36,  13,  15,
														     66,    6
														     
										                }; 
										               										                

				int[] intArrCN2 = new int[]{ -1, 
					                                            0, -1, -1,  0,   0, 
					                                            0, -1, -1, -1, -1,
					                                          -1, -1, -1, -1, -1,
					                                          -1, -1, -1, -1, -1,
					                                          -1, -1, -1, -1,  0,
															  -1, -1, -1, -1, -1,
														      -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1,
																
																-1, -1, -1,
																-1, -1, -1, -1, -1,
																-1, -1, -1, -1,  0,
																 0,   0, -1, -1, -1,
																-1,  0, -1, -1, -1,
					                                        	-1, -1, -1, -1, -1,
																-1, -1, -1, -1, 
																-1, -1,  0, 
																-1, -1, -1, -1,-1,
																-1, -1, -1,
																
					                                            -1, -1, -1, 0,   0,
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
					
					
					sql.append( " SELECT '' CHK,                                                                                                                 \n" );
					sql.append( "        A.BS_ID,           A.BS_TAXKND,   A.BS_DAT,       A.BS_AMT,         A.BS_TAXAMT,       \n" );
					sql.append( "        A.BS_TOTAMT, A.BS_REMARK,  A.BS_VENDID,  A.BS_VENDNM,  A.BS_DIRCNM,       \n" );
					sql.append( "        A.BS_CND,        A.BS_KND,        A.BS_COMYN,  A.BS_PNO1,       A.BS_PNO2,           \n" );
					sql.append( "        A.BS_ADDR1,    A.BS_ADDR2,    A.BS_USE,        A.BS_STS,         A.BS_EMPNM,       \n" );
					sql.append( "        A.BS_EMAIL,     A.BS_HPNO,      A.BS_TELNO,   A.BS_INGB,        A.BS_SEQNO,        \n" );
					sql.append( "        A.BS_DNO,       A.BS_HNO,        A.BS_TAXNO,   A.BS_VENDCD,   A.BS_PDTNM,        \n" );
					sql.append( "        A.I_EMPNO,      A.I_DATE,          A.U_EMPNO,     A.U_DATE,                                        \n" );
					sql.append( "        B.VEND_ID AS B_VEND_ID,        B.VEND_CD AS B_VEND_CD,      B.VEND_NM,      B.VD_DIRECT,   B.BSNS_CND,        \n" );
					sql.append( "        B.BSNS_KND,   B.VD_TELNO,    B.VD_FAXNO,     B.POST_NO1,   B.POST_NO2,         \n" );
					sql.append( "        B.ADDRESS1,   B.ADDRESS2,    B.COCOMYN,     B.USE_TAG,                                   \n" );
					sql.append( "         COALESCE(C.SEQ,0) AS C_SEQ,          C.EMPNM AS C_EMPNM,             C.EMAIL AS C_EMAIL,        \n" );
					sql.append( "        D.TAXNBR,       D.COCODE,       D.DEPTCD,         D.EMPNO,      D.TAXIODIV,               \n" );
					sql.append( "        D.TAXDIV,         D.TAXKND,        D.VEND_CD,       D.TAXDAT,      COALESCE(D.TAXSUM,0)TAXSUM,                \n" );
					sql.append( "        COALESCE(D.TAXVATAMT,0)TAXVATAMT, COALESCE(D.TAXTOT,0)TAXTOT,        D.REMARK,         D.TAXCDNBR,   D.ATCODE,             \n" );
					sql.append( "        D.TAXPRTYN,   COALESCE(D.TAXCNT,0)TAXCNT,        D.LASTPRT,        D.TAXTYPE,    D.FSDAT,                    \n" );
					sql.append( "        D.FSNBR,         D.TAXKIDIV,       D.FDCODE,         D.WORKTYPE,   D.REPORT,                                 \n" );
					sql.append( "        D.WRDT,          D.WRID,             D.UPDT,             D.UPID,                                             \n" );
					sql.append( "        D.SSDAT,         D.SSNBR,           COALESCE(D.SEQ,0) SEQ,                                                   \n" );
					sql.append( "        D.GUBUN,        D.AMEND_CODE, D.AMEND_REMARK,  D.EXTCHK, D.REMARK2,                                          \n" );
					sql.append( "        D.REMARK3,     D.S_BIZPLACE, D.B_BIZPLACE,                                                                   \n" );
					sql.append( "        '' TAXSEQ,        ''TAXPDTNAM,  ''TAXSTD,          0 TAXQTY ,     0 TAXPRIC,                                 \n" );
					sql.append( "        '' BIGO,       ''COSTCD                                                                                      \n" );
					sql.append( "  FROM VNDUS.TBS010 A                                                                                                \n" );
					sql.append( "  LEFT JOIN  ACCOUNT.GCZM_VENDER B ON A.BS_VENDID = B.VEND_ID AND RTRIM(A.BS_VENDID) IS NOT NULL                     \n" );
					sql.append( "  LEFT JOIN  ACCOUNT.CUSTOMER C ON A.BS_VENDID = C.VEND_ID AND B.VEND_CD =C.VEND_CD AND A.BS_EMAIL =C.EMAIL          \n" );
					sql.append( "  LEFT JOIN  ACCOUNT.ATTAXMST D ON A.BS_TAXNO = D.TAXNBR                                                             \n" );
					sql.append( "   WHERE 1=1                                                                                                         \n" );
					
					if (!str1.equals("0")) sql.append( " AND A.BS_INGB = '"+str1+"' \n"); 
					if (!str2.equals("0")) sql.append( " AND A.BS_SEQNO = '"+str2+"' \n"); 
					if (str3.equals("1")) sql.append( " AND (A.BS_STS='N') \n"); 
					if (str3.equals("2")) sql.append( " AND (A.BS_STS='Y') \n"); 
										
					//sql.append( " ORDER BY VEND_CD ");
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
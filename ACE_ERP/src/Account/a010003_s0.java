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
public class a010003_s0 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{ "CORP_CD",   "VEND_GB",  "VEND_CD",	 "VEND_NM",   
													                "VD_DIRECT", "BSNS_CND", "BSNS_KND",  "VD_TELNO", 
													 	              "VD_FAXNO",  "POST_NO1", "POST_NO2", "ADDRESS1",
															            "ADDRESS2",  "C_BANKCD", "C_ACCTNO", "C_ACCTNO_NM",
																          "C_ACCTNM",  "B_BANKCD", "B_ACCTNO", "B_ACCTNO_NM",
																	        "B_ACCTNM",  "O_VENDGB", "O_VENDCD", "VEND_MAG",
																		      "USE_TAG",   "REMARK",   "CREAT_DT", "CREAT_NM",
																			    "MSN",       "MPWD",     "COCOMYN" , "VEND_ID", "VEND_NO","POST_NM",
					                                "H_VEND_CD", "H_VEND_NM","IUGB",     "C_BANK_NM",
					                                "WRDT",      "WRID",     "UPDT",     "UPID", "CREDGB"

														}; 

				int[] intArrCN = new int[]{ 1,  1, 13, 62,
												           62, 62, 62, 32,
													         32, 10, 10, 132,
														       72,  5, 22, 32,
															     32,  5, 22, 32,
																   32,  1, 13, 10,
																	  1, 66, 12, 10,
																	 13, 20,  1, 15, 13, 20,
					                         13, 62,  1, 32,
					                         10, 13, 10, 13, 1
				}; 
			
				int[] intArrCN2 = new int[]{-1, -1, -1, -1,
												            -1, -1, -1, -1,
												 	          -1, -1, -1, -1,
														        -1, -1, -1, -1,
															      -1, -1, -1, -1,
																    -1, -1, -1, -1,
																	  -1, -1, -1, -1,
																		-1, -1, -1, -1, -1,-1,
				                            -1, -1, -1, -1,
					                          -1, -1, -1, -1,-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT '' CORP_CD,''VEND_GB, RTRIM(A.VEND_CD) VEND_CD, RTRIM(A.VEND_NM) VEND_NM,  \n");
					sql.append( "		 A.VD_DIRECT, A.BSNS_CND, A.BSNS_KND, A.VD_TELNO,    						\n");
					sql.append( "		 A.VD_FAXNO,   A.POST_NO1, A.POST_NO2, A.ADDRESS1,     						\n");
					sql.append( "		 A.ADDRESS2,  A.C_BANKCD, A.C_ACCTNO, A.C_ACCTNO_NM,  						\n");
					sql.append( "		 A.C_ACCTNM, A.B_BANKCD, A.B_ACCTNO, A.B_ACCTNO_NM,  						\n");
					sql.append( "		 A.B_ACCTNM, A.O_VENDGB, A.O_VENDCD, A.VEND_MAG,     						\n");
					sql.append( "		 A.USE_TAG, A.REMARK, A.CREAT_DT, A.CREAT_NM,			   					\n");
					sql.append( "		 A.MSN, A.MPWD,A.COCOMYN, A.VEND_ID, A.VEND_NO,  							\n");
					sql.append( "		 A.POST_NO1||A.POST_NO2 as POST_NM, 										\n");
					sql.append( "		 nvl(H_VEND_CD,'')H_VEND_CD, nvl(H_VEND_NM,'')H_VEND_NM,IUGB, 				\n");
					sql.append( "		 nvl(RTRIM(B.BANNA1),'')C_BANK_NM, 											\n");
					sql.append( "		 A.WRDT  ,A.WRID,A.UPDT,A.UPID, 											\n");
					sql.append( "		 CASE WHEN T.CREDGB IN ('1','2') THEN '1' ELSE '' END CREDGB				\n");
                    sql.append( "		 FROM ACCOUNT.GCZM_VENDER A													\n");
					sql.append( "		 LEFT JOIN ACCOUNT.BANKCODE B ON A.C_BANKCD = B.BANCOD 						\n");
					sql.append( "        LEFT JOIN ( SELECT U.VEND_CD, MAX(U.CREDGB)CREDGB 							\n");
					sql.append( "                              FROM ACCOUNT.BOND_ATTACH U                 			\n");
					sql.append( "                            WHERE U.CREDGB IN ('1','2')                           	\n");
					sql.append( "                            GROUP BY U.VEND_CD                                     \n");
					sql.append( "                         ) T ON  A.VEND_CD = T.VEND_CD                          	\n");
					sql.append( "   WHERE A.VEND_CD IS NOT NULL 													\n");
					if (!str1.equals("")) sql.append( " AND A.VEND_CD = '" + str1 + "'								\n");
					if (!str2.equals("")) sql.append( " AND A.VEND_NM LIKE '%" + str2 + "%'							\n");
					if (!str3.equals("")) sql.append( " AND A.VEND_ID LIKE '" + str3 + "%' 							\n");

                    //System.out.println("a010003_s0"+sql.toString());
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
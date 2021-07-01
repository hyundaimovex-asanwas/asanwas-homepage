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
public class a010051_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //거래처코드 
				String  str2	= req.getParameter("v_str2"); //거래처명
				String  str3	= req.getParameter("v_str3"); //등록구분 
				String  str4	= req.getParameter("v_str4"); //등록번호
				String  str5	= req.getParameter("v_str5"); //사용구분  
				String  str6	= req.getParameter("v_str6"); //사업자구분 

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
	
	    		GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{  "VEND_CD",	       "VEND_NM",	    "VEND_ID",	   "VEND_NO",   	"VD_DIRECT",	
																		"BSNS_CND",	    "BSNS_KND",	"VD_TELNO",	"VD_FAXNO",	"POST_NO1",	
																		"POST_NO2",	    "ADDRESS1",	"ADDRESS2",	"C_BANKCD",	"C_ACCTNO",	
																		"C_ACCTNO_NM",	"C_ACCTNM",	"B_BANKCD",	"B_ACCTNO",	"B_ACCTNO_NM",	
																		"B_ACCTNM",	    "O_VENDGB",	"O_VENDCD",	"VEND_MAG",	"USE_TAG",	
																		"REMARK",	        "CREAT_DT",	"CREAT_NM",	"MSN",	            "MPWD",
																		"COCOMYN",	    "H_VEND_CD",	"H_VEND_NM",	"IUGB",	
																		"WRDT",	            "WRID",	        "UPDT",	        "UPID"
														           }; 

				int[] intArrCN = new int[]{ 13,	62,	15,	13,	62,	
															62,	62,	32,	32,	10,	
															10,	132, 72,	5,	    22,	
															32,	32,	5,	    22,	32,	
															32,	1,	   13,	10,	1,	
															66,	12,	10,	13,	20,	
															1,	    13,	62,	1,	
															19,	30,	10,	13
										                }; 

				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1,
												              -1, -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1, -1,
															  -1, -1, -1, -1,
					                                          -1, -1, -1, -1
												          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT VEND_CD,          VEND_NM,     VEND_ID,        VEND_NO,    VD_DIRECT,     			\n" );
					sql.append( "              BSNS_CND,        BSNS_KND,   VD_TELNO,    VD_FAXNO,   POST_NO1,     			\n" );
					sql.append( "              POST_NO2,        ADDRESS1,   ADDRESS2,    C_BANKCD,   C_ACCTNO,     			\n" );
					sql.append( "              C_ACCTNO_NM, C_ACCTNM,   B_BANKCD,    B_ACCTNO,   B_ACCTNO_NM,  		\n" );
					sql.append( "              B_ACCTNM,       O_VENDGB,    O_VENDCD,   VEND_MAG,   USE_TAG,      			\n" );
					sql.append( "              REMARK,           CREAT_DT,     CREAT_NM,    MSN,             MPWD,         			\n" );
					sql.append( "              COCOMYN,        H_VEND_CD,   H_VEND_NM,  IUGB,                    						\n" );
					sql.append( "              WRDT,               WRID||' '||B.EMPNMK      WRID,             UPDT,       UPID       \n" );
					sql.append( "   FROM ACCOUNT.GCZM_VENDER_USER                                                      				\n" );
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON B ON B.EMPNO =WRID AND B.USESTS IN ('1','2','3')   	\n" );
					sql.append( "   WHERE 1=1                                                                                       						\n" );
					if (!str1.equals("")) sql.append( " AND VEND_CD LIKE '%" + str1 + "%'									\n");
					if (!str2.equals("")) sql.append( " AND VEND_NM LIKE '%" + str2 + "%'									\n");
					if (!str3.equals("A")) sql.append( " AND VEND_CD LIKE   '" + str3 + "%'									\n");
					if (!str4.equals("")) sql.append( " AND VEND_ID LIKE   '%" + str4 + "%'									\n");
					if (!str5.equals("A")) sql.append( " AND USE_TAG = '"+str5+"'												\n");
					if (str6.equals("1")) sql.append( " AND LENGTH(VEND_ID)=10 												\n");
					if (str6.equals("2")) sql.append( " AND LENGTH(VEND_ID)=13 												\n");
					sql.append( " order by VEND_CD 																				\n");
					
					//System.out.println("a010001_s1 \n" + sql.toString());
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
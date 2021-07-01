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
public class a010050_s1 extends HttpServlet {
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
				String  str3	= req.getParameter("v_str3"); //상태구분 
				String  str4	= req.getParameter("v_str4"); //등록번호
				String  str5	= req.getParameter("v_str5"); //작성자  
				String  str6	= req.getParameter("v_str6"); //사업자구분 
				String  str7	= req.getParameter("v_str7"); //거래처코드 구분 

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
	
	    		GauceRes.enableFirstRow(dSet);
			String[] strArrCN = new String[]{   "CHK",          "VEND_CD",	  "VEND_NM",    "VEND_ID",	"VEND_NO",   	"VD_DIRECT",	
												"BSNS_CND",	    "BSNS_KND",	  "VD_TELNO",	"VD_FAXNO",	"POST_NO1",	
												"POST_NO2",	    "ADDRESS1",	  "ADDRESS2",	"USE_TAG",	
												"REMARK",	    "CREAT_DT",	  "CREAT_NM",	"MSN",	            "MPWD",
												"COCOMYN",	    "H_VEND_CD",  "H_VEND_NM",	"IUGB",	
												"WRDT",	        "WRID",	      "UPDT",	    "UPID",
                                                "STATUS",	    "RQID",	      "RQDT",	       
                                                "CFID",	        "CFDT",	      "BSID",	    "BSDT",   "EMPNMK",   "SB_REASON", "VENDER_USERGB",
                                                "REAL_FILE4",   "SYS_FILE4",  "REAL_FILE3", "SYS_FILE3",
                                                "REAL_FILE2",   "SYS_FILE2",  "REAL_FILE1", "SYS_FILE1"
										     }; 

				int[] intArrCN = new int[]{ 1,  13,	62,	15,	13,	62,	
											62,	 62,	32,	32,	10,	
											10,	132,    72,	 1,	
											66,	 12,	10,	13,	20,	
											1,	 13,	62,	1,	
											19,	 30,	19,	10,
											 1,  10,    19,    
	                                        10,  19,    10, 19, 30 , 100, 1,
	                                        50,  30,    50, 30,
	                                        50,  30,    50, 30
										    }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
								              -1, -1, -1, -1, -1,
											  -1, -1, -1, -1, 
											  -1, -1, -1, -1, -1,
											  -1, -1, -1, -1,
	                                          -1, -1, -1, -1,
											  -1, -1, -1, 
											  -1, -1, -1, -1,-1, -1, -1,
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
					sql.append( " SELECT  'F' CHK,              A.VEND_CD,     A.VEND_NM,     A.VEND_ID,    A.VEND_NO,    A.VD_DIRECT,     	\n" );
					sql.append( "          A.BSNS_CND,          A.BSNS_KND,    A.VD_TELNO,    A.VD_FAXNO,   A.POST_NO1,     				\n" );
					sql.append( "          A.POST_NO2,          A.ADDRESS1,    A.ADDRESS2,    A.USE_TAG,     								\n" );
					sql.append( "          A.REMARK,            A.CREAT_DT,    A.CREAT_NM,    A.MSN,        A.MPWD,           				\n" );
					sql.append( "          A.COCOMYN,           A.H_VEND_CD,   A.H_VEND_NM,   A.IUGB,                                      	\n" );
					sql.append( "          A.WRDT,              A.WRID||' '||B.EMPNMK  WRID,  A.UPDT,       A.UPID,    						\n" );
					sql.append( "          A.STATUS,            A.RQID,        A.RQDT,       												\n" );
					sql.append( "          A.CFID,              A.CFDT,        A.BSID,        A.BSDT,  B.EMPNMK, A.SB_REASON,''VENDER_USERGB, \n" );
					sql.append( "          A.REAL_FILE4,        A.SYS_FILE4,   A.REAL_FILE3,  A.SYS_FILE3,                                  \n" );
					sql.append( "          A.REAL_FILE2,        A.SYS_FILE2,   A.REAL_FILE1,  A.SYS_FILE1                                   \n" );
					sql.append( "   FROM ACCOUNT.GCZM_VENDER_USER A                                                      					\n" );
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON B ON B.EMPNO =WRID AND B.USESTS IN ('1','2','3')   							\n" );
					sql.append( "   WHERE 1=1                                             													\n" );
					if (!str1.equals("")) sql.append( " AND A.VEND_CD LIKE '%" + str1 + "%'			\n");
					if (!str2.equals("")) sql.append( " AND A.VEND_NM LIKE '%" + str2 + "%'			\n");
					if (!str3.equals("")) sql.append( " AND A.STATUS =  '" + str3 + "'				\n");
					if (!str4.equals("")) sql.append( " AND A.VEND_ID LIKE   '%" + str4 + "%'		\n");
					if (!str5.equals("")) sql.append( " AND A.WRID = '"+str5+"'						\n");
					if (str6.equals("1")) sql.append( " AND LENGTH(A.VEND_ID)=10 					\n");
					if (str6.equals("2")) sql.append( " AND LENGTH(A.VEND_ID)=13 					\n");
					if (str6.equals("3")) sql.append( " AND (A.VEND_CD LIKE 'F%' OR VEND_CD LIKE 'K%') \n");
					if (!str7.equals("")) sql.append( " AND A.VEND_CD LIKE '"+str7+"%'   			\n");
					sql.append( " ORDER BY VEND_CD 													\n");
					
				    //System.out.println("a010050_s1::"+sql.toString());
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
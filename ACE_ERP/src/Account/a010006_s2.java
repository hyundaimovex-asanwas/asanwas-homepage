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
public class a010006_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //사용유무
				String  str2	= req.getParameter("v_str2"); //결재은행
				String  str3	= req.getParameter("v_str3"); //계좌번호
				String  str4	= req.getParameter("v_str4"); //거래처

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CANBR", "CADIV", "CACARDSPEC", "CADEPTCD", "CAEMPNO",
					                              "CAISSYYMM", "CAUSEYYMM", "CASTTDAT", "CAACCBANK", "CABANKNO", 
				                                  "CACUST", "DSUDT", "BANNAM", "BANNA1", "EMPNMK",
																					"VEND_NM", "VEND_CD", "USE_TAG"
				}; 

				int[] intArrCN = new int[]{16,  1,  3,  4,  7,
					                        6,  6,  2,  4, 20, 
				                           16,  8, 30, 16, 20,
																		62, 13, 1
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
					                         -1, -1, -1, -1, -1,
					                         -1, -1, -1, -1, -1,
																		-1, -1, -1
				}; 



				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(A.CANBR) CANBR, RTRIM(A.CADIV) CADIV, RTRIM(A.CACARDSPEC) CACARDSPEC,   	\n" );
					sql.append( "        RTRIM(A.CADEPTCD) CADEPTCD, RTRIM(A.CAEMPNO) CAEMPNO,    										\n" );					
					sql.append( "        RTRIM(A.CAISSYYMM) CAISSYYMM, RTRIM(A.CAUSEYYMM) CAUSEYYMM,    								\n" );
					sql.append( "        RTRIM(A.CASTTDAT) CASTTDAT,    																						\n" );
					sql.append( "        RTRIM(A.CAACCBANK) CAACCBANK, RTRIM(A.CABANKNO) CABANKNO,   									\n" );
					sql.append( "        RTRIM(A.CACUST) CACUST, RTRIM(A.DSUDT) DSUDT,    														\n" );
					sql.append( "        RTRIM(B.BANNAM) BANNAM, RTRIM(B.BANNA1) BANNA1,    														\n" );
					sql.append( "        ASNHR.SF_GET_ENONAME('01',A.CAEMPNO) AS EMPNMK,   														\n" );	
					sql.append( "        RTRIM(A.VEND_NM) VEND_NM, RTRIM(A.VEND_CD) VEND_CD, RTRIM(A.USE_TAG) USE_TAG   		\n" );
					sql.append( "   FROM ACCOUNT.CARDCODE  A                       																			\n" );
					sql.append( "   LEFT JOIN ACCOUNT.BANKCODE B ON RTRIM(B.BANCOD) = RTRIM(A.CAACCBANK) 							\n" );
					//sql.append( "   LEFT JOIN PAYROLL.HIPERSON C ON RTRIM(C.EMPNO) = RTRIM(A.CAEMPNO) 								\n" );
					if(!str1.equals("")) { sql.append( "  WHERE RTRIM(A.USE_TAG) = '"+str1+"'        " );		}
					if(!str2.equals("")) { sql.append( "  AND RTRIM(B.BANNA1) LIKE '%" + str2 + "%'    " );		}
					if(!str3.equals("")) { sql.append( "  AND RTRIM(A.CABANKNO) = '"+str3+"'        " );		}
					if(!str4.equals("")) { sql.append( "  AND RTRIM(A.VEND_NM)  LIKE   '%" + str4 + "%'    " );		}
                    
					//System.out.println("a010006_s2 \n" + sql.toString());
					//logger.dbg.println(this,sql.toString());
					
					System.out.println("a010006_s2::"+sql.toString());
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
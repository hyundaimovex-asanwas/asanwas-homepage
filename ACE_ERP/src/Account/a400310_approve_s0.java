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
public class a400310_approve_s0 extends HttpServlet {
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
				String []  str	= new String [1];
				str[0] = req.getParameter("v_str1");	//신청번호
				
				for(int i=0;i<=0;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"APPNO",     "VENDCD",    "VENDNM",  "VENDID",   "VEND_ID_LEN",
						"OUTAMT",    "APPDATE",   "REQDATE", "COSTGB",   "COSTBGT",
						"COSTBGTNM", "PAYACCTNO", "BANK_CD", "BANK_NM",  "ACCT_AUTH",
						"PAYGB",     "PAYKND"
				}; 
				


				int[] intArrCN = new int[] { 
					14,  13, 100,  13,   2,
					15,   8,   8,   1,  10,
				   100,  20,   5, 100 , 100,
				     1,   1 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,   0,
					 0,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT A.APPNO, A.VENDCD,  A.VENDNM, G.VEND_ID AS VENDID, LENGTH(G.VEND_ID) VEND_ID_LEN, \n");
						sql.append( "        A.OUTAMT, A.APPDATE, A.REQDATE,   A.COSTGB, A.COSTBGT,  \n");
						sql.append( "        CASE WHEN A.COSTGB ='1' THEN C.CDNAM                    \n");
						sql.append( "             WHEN A.COSTGB ='2' THEN D.CDNAM                    \n");
						sql.append( "             ELSE 'XXXX' END COSTBGTNM,                         \n");
						sql.append( "        A.PAYACCTNO, N.BANK_CD, N.BANK_NM, A.ACCT_AUTH, A.PAYGB, A.PAYKND \n");
						sql.append( "   FROM ACCOUNT.ACAPPFUND A,                                    \n");
						sql.append( "        ACCOUNT.COMMDTIL C,  ACCOUNT.COMMDTIL D,                \n");
						sql.append( "        ACCOUNT.GCZM_VENDER G, ACCOUNT.ACCTNO N                 \n");
						sql.append( "  WHERE A.COSTBGT= C.CDCODE(+) AND C.CMTYPE(+) ='0030'          \n");
						sql.append( "    AND A.COSTBGT= D.CDCODE(+) AND D.CMTYPE(+) ='0003'          \n");
						sql.append( "    AND A.VENDCD= G.VEND_CD(+)                                  \n");
						sql.append( "    AND (A.VENDCD=N.VEND_CD(+) AND A.PAYACCTNO = N.ACCT_NO(+))  \n");
						sql.append( "    AND A.AP_M_SID ="+str[0]+"                                  \n");
						sql.append( "  ORDER BY A.APPNO                                              \n");

						//System.out.println("# a400140_approve_s0 Query : \n" + sql);
							
/*********************************************************************************************/
					
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  	System.err.println(e);
		    } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			System.err.println(e);
			//logger.dbg.println(this,e.toString());
			
		} finally {
			loader.restoreService(service);
  	}
	}
}
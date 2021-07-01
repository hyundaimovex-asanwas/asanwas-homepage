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
public class a400010_s1 extends HttpServlet {
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
				String []  str	= new String [5];
				str[0] = req.getParameter("v_str1");	//계좌코드
				str[1] = req.getParameter("v_str2");	//계좌번호
				str[2] = req.getParameter("v_str3");	//은행코드
				str[3] = req.getParameter("v_str4");	//은행명
				str[4] = req.getParameter("v_str5");	//상태
				
				
			
				for(int i=0;i<=4;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"ACCTNO",   "BANKCD",  "BANKNM",  "ACCTCD",
					"BRCHCD",   "BRCHNM",  "ACCTUSE", "ACCTGB",    "DEPOGB",
					"ACCTGBNM", "INRATE",  "REMARK",  "STATUS",    "ENDDAT",
					"TEAM",     "TEAMNM",  "RESULT",  "RSTREMARK", "RSTSEQ",
					"WRID",     "WRDT",    "UPID",    "UPDT",      "COSTCD", "COSTNM" }; 

				int[] intArrCN = new int[] { 
				    30,   3,  60,  10, 
				     6,  60,  60,   2,  2,
				    20,   4, 100,   1,  8,
				    10,  60,  10,  60,  3,
				    10,  20,  10,  10, 10, 100
					
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1, 
					-1,  -1,  -1,  -1, -1,
					-1,   2,  -1,  -1, -1,
					-1,  -1,  -1,  -1,  0,
 					-1,  -1,  -1,  -1, -1, -1  
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( "  SELECT A.ACCTNO, A.BANKCD, B.CDNAM AS BANKNM,  A.ACCTCD,               \n");
						sql.append( "         A.BRCHCD, C.CDNAM AS BRCHNM,  A.ACCTUSE, A.ACCTGB,  A.DEPOGB,   \n");
						sql.append( "         D.CDNAM AS ACCTGBNM , A.INRATE, A.REMARK, A.STATUS, A.ENDDAT,   \n");
						sql.append( "         A.TEAM,   E.DEPTNM AS TEAMNM, A.RESULT, A.RSTREMARK, A.RSTSEQ,  \n");
						sql.append( "         A.WRID,   A.WRDT,   A.UPID,   A.UPDT, A.COSTCD, G.CDNAM AS COSTNM \n");
						sql.append( "    FROM ACCOUNT.ACCTINFO A, ACCOUNT.COMMDTIL B,                         \n");
						sql.append( "         ACCOUNT.COMMDTIL C, ACCOUNT.COMMDTIL D,                         \n");
						sql.append( "         ACCOUNT.COMMDTIL G,                                             \n");
						sql.append( "         PAYROLL.HCDEPT E                                                \n");
						sql.append( "   WHERE A.BANKCD = B.CDCODE(+) AND B.CMTYPE(+)='2168'                   \n");
						sql.append( "     AND A.BRCHCD = C.CDCODE(+) AND C.CMTYPE(+)='0022'                   \n");
						sql.append( "     AND A.ACCTGB = D.CDCODE(+) AND D.CMTYPE(+)='2250'                   \n");
						sql.append( "     AND A.COSTCD = G.CDCODE(+) AND G.CMTYPE(+)='0030'                   \n");
						sql.append( "     AND A.TEAM = E.DEPTCD(+)                                            \n");
					
						System.out.println("# a400010_s1 Query : \n" + sql);
						
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
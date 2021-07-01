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
public class xat1005_s1 extends HttpServlet {
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
				String []  str	= new String [3];
				str[0] = req.getParameter("v_str1");	//매장코드
				str[1] = req.getParameter("v_str2");	//매출일자FR
				str[2] = req.getParameter("v_str3");	//매출일자TO
				
				
			
				for(int i=0;i<=2;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"DFSCD",	"DFSNM",    "GB",	"USD",	"CNY",	"UCWON", "CARD","CASH","WONSUM"
				}; 

				int[] intArrCN = new int[] { 
						6,	50,  10,  12,	12,	 12, 12, 12, 12
				}; 
			
				int[] intArrCN2 = new int[]{ 
						-1,	-1,	-1,	 2,	 2,  2, 2, 2, 2	
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT X.DFSCD,                                                                                       \n");
						sql.append( "        CASE WHEN X.DFSCD IS NULL AND X.GB IS NULL THEN '합계' ELSE  MAX(B.DETAIL_NAME)  END AS DFSNM,  \n");
						sql.append( "        CASE WHEN X.DFSCD IS NOT NULL AND X.GB IS NULL THEN '소계'                                      \n");
						sql.append( "              ELSE X.GB END GB,                                                                        \n");
						sql.append( "        SUM(X.USDAMT) USD,  SUM(X.CNYAMT)CNY, (SUM(X.CWONAMT)+SUM(X.UWONAMT))UCWON, SUM(CARDAMT) CARD, \n");
						sql.append( "        SUM(X.CASHAMT)CASH, (SUM(X.WONAMT)+SUM(X.CARDAMT))WONSUM                                       \n");
						sql.append( " FROM (                                                                                                \n");
						sql.append( "       SELECT A.DFSCD,                                                                                 \n");
						sql.append( "              CASE WHEN A.USDAMT<>0  THEN TO_CHAR('달러')                                               \n");
						sql.append( "                   WHEN A.CNYAMT<>0  THEN TO_CHAR('위안화')                                              \n");
						sql.append( "                   WHEN A.CASHAMT<>0  THEN TO_CHAR('원화')                                              \n");
						sql.append( "                   WHEN A.CARDAMT<>0 THEN TO_CHAR('카드')                                               \n");
						sql.append( "                   ELSE '0' END GB,                                                                    \n");
						sql.append( "              A.CASHAMT, A.CNYAMT, A.USDAMT, A.CARDAMT,                                                \n");
						sql.append( "              A.CWONAMT, A.UWONAMT,A.WONAMT                                                            \n");
						sql.append( "         FROM ACCOUNT.TBIF_POSDATA  A                                                                  \n");
						sql.append( "        WHERE 1=1   \n");
						if(!str[0].equals("")) sql.append( " AND A.DFSCD IN ( '"+str[0]+"')		                    \n"); // 매장코드 
						if(!str[1].equals("")) sql.append( " AND A.SALEDT BETWEEN '"+str[1]+"' AND  '"+str[2]+"'	\n"); // 매출일자 
						
						sql.append( " )X                                                                                                    \n");
						sql.append( " LEFT JOIN ACCOUNT.TBIF_COMSUB B ON X.DFSCD = B.DETAIL_CD AND  B.HEAD_CD ='001'                        \n");
						sql.append( " GROUP BY  ROLLUP(X.DFSCD, X.GB)                                                                       \n");
						sql.append( " ORDER BY X.DFSCD, X.GB                                                                                \n");
					
						//System.out.println("# xat1005_s1 Query : \n" + sql);
						
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
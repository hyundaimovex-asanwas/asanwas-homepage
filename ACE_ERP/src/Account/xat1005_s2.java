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
public class xat1005_s2 extends HttpServlet {
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
						"CARDCD",  "CARDNM",   "DFSCD1",	"DFSCD2",    "DFSCD3",	"DFSCD4",	"CARDSUM"
				}; 

				int[] intArrCN = new int[] { 
						6,	50,  12,  12,	12,	 12,  12
				}; 
			
				int[] intArrCN2 = new int[]{ 
						-1,	-1,  2,	 2,	 2,  2, 2	
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( "  SELECT  X.CARDCD,                                                             \n");
						sql.append( "          CASE WHEN X.CARDCD IS NULL THEN '합   계' ELSE  MAX(X.CARDNM) END CARDNM,\n");
						sql.append( "          SUM(CASE WHEN X.DFSCD ='S16744' THEN  X.CARDAMT ELSE 0 END)AS DFSCD1, \n");
						sql.append( "          SUM(CASE WHEN X.DFSCD ='S16745' THEN  X.CARDAMT ELSE 0 END)AS DFSCD2, \n");
						sql.append( "          SUM(CASE WHEN X.DFSCD ='T20096' THEN  X.CARDAMT ELSE 0 END)AS DFSCD3, \n");
						sql.append( "          SUM(CASE WHEN X.DFSCD ='T69142' THEN  X.CARDAMT ELSE 0 END)AS DFSCD4, \n");
						sql.append( "          SUM(X.CARDAMT) CARDSUM                                                \n");
						sql.append( "    FROM (                                                                      \n");
						sql.append( "          SELECT A.DFSCD, A.CARDCD, A.CARDNM, SUM(A.CARDAMT)CARDAMT             \n");
						sql.append( "            FROM ACCOUNT.TBIF_POSDATA  A                                        \n");
						sql.append( "           WHERE 1=1                                                            \n");
						sql.append( "             AND CARDCD IS NOT NULL                                             \n");
						if(!str[1].equals("")) sql.append( " AND A.SALEDT BETWEEN '"+str[1]+"' AND  '"+str[2]+"'   	 \n"); // 매출일자 
						sql.append( "          GROUP BY A.DFSCD, A.CARDCD,A.CARDNM                                   \n");
						sql.append( "         ) X                                                                    \n");
						sql.append( "   GROUP BY ROLLUP(X.CARDCD)                                                    \n");
						sql.append( "   ORDER BY X.CARDCD                                                            \n");

					
					//	System.out.println("# xat1005_s2 Query : \n" + sql);
						
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
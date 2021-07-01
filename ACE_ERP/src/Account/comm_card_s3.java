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
public class comm_card_s3 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //카드구분
				String  str2	= req.getParameter("v_str2"); //카드회사구분
				String  str3	= req.getParameter("v_str3"); //카드번호 

				if (str1 == null) str1 = "";     
				if (str2 == null) str2 = "";     
				if (str3 == null) str3 = "";     
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "GBCD",	  "GUBUN", "CARDCD", "CARDNM",   "CARDNO",	"CARDNONM", "REAL_CARDNO"
				                                 }; 

				int[] intArrCN = new int[] {  2, 20,  3, 20, 16, 20, 16			                          
				                           }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.GBCD, X.GUBUN, X.CARDCD, X.CARDNM, X.CARDNO, X.CARDNONM, REPLACE(X.CARDNONM,'-','') AS REAL_CARDNO \n ");
					sql.append( "    FROM (                                                                                             						\n ");
					sql.append( "          SELECT '01' AS GBCD, '법인카드' AS GUBUN , A.GBCD AS CARDCD, B.CDNAM AS CARDNM,              \n ");
					sql.append( "                 A.CDCODE AS CARDNO, A.CDNAM AS CARDNONM                                            \n ");
					sql.append( "            FROM ACCOUNT.COMMDTIL A                                                                    			\n ");
					sql.append( "            LEFT JOIN ACCOUNT.COMMDTIL B ON A.GBCD=B.CDCODE AND B.CMTYPE='1134'     \n ");
					sql.append( "           WHERE A.CMTYPE='1133'                                                                   					\n ");
					sql.append( "             AND TRIM(A.DSUDT) IS NULL                                                   			\n ");
					sql.append( "             AND A.CDCODE IS NOT NULL                                                                     			\n ");
					sql.append( "         UNION ALL                                                                                     						\n ");
					sql.append( "         SELECT '02' AS GBCD, '개인명법인카드' AS GUBUN, A.CACARDSPEC AS CARDCD, B.CDNAM AS CARDNM,    	\n ");
					sql.append( "                A.CANBR AS CARDNO , C.CDNAM AS CARDNONM                                                								\n ");
					sql.append( "           FROM ACCOUNT.CARDCODE A                                                                     										\n ");
					sql.append( "           LEFT JOIN ACCOUNT.COMMDTIL B ON A.CACARDSPEC=B.CDCODE AND B.CMTYPE='1134'                   		\n ");
					sql.append( "           LEFT JOIN ACCOUNT.COMMDTIL C ON A.CANBR=C.CDCODE AND C.CMTYPE='2167'                        				\n ");
					sql.append( "          WHERE A.CANBR IS NOT NULL                                                                          \n ");
					sql.append( "            AND A.USE_TAG='Y'                                                                          				\n ");
					sql.append( "        ) X                                                                                        							\n ");
					sql.append( "  WHERE 1=1                                    		 				\n ");
					if(!str1.equals(""))sql.append( " AND X.GBCD = '"+str1+"'          						\n ");
					if(!str2.equals(""))sql.append( " AND X.CARDCD = '"+str2+"'        					\n ");
					if(!str3.equals(""))sql.append( " AND X.CARDNONM LIKE '%"+str3+"%' 				\n ");

					//System.out.println("comm_card_s3 : \n" + sql);
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
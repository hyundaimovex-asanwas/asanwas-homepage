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
public class xat_exchange_popup_s1 extends HttpServlet {

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
		
		System.out.println(" 시작 \n");	

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
				String  str1	= req.getParameter("v_str1");  //매장코드 또는 매장명
				
				if (str1 == null) str1 = "";
				
								
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DFSCD",   "DFSNM",	 "SALEDT",   "CNYER",  "USDER",
				                                   "CREATE_ID", "CREATE_DATE", "UPDATE_ID","UPDATE_DATE" 
				                                 }; 

				int[] intArrCN = new int[]{ 6,  50,  8, 6, 6,
					                         10 , 10, 10,  10
					                        }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  2, 2, 
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
					
					sql.append( " SELECT A.DFSCD,  B.DETAIL_NAME AS DFSNM, A.SALEDT, A.CNYER, A.USDER, 	     \n");
					sql.append( "        A.CREATE_ID, A.CREATE_DATE, A.UPDATE_ID, A.UPDATE_DATE	 \n");
					sql.append( "   FROM ACCOUNT.TBIF_POSEXG A 									 \n");
					sql.append( "   LEFT JOIN ACCOUNT.TBIF_COMSUB B ON A.DFSCD = B.DETAIL_CD AND B.HEAD_CD ='001'	\n");  
					sql.append( "  WHERE 1=1													 \n");
					if (!str1.equals(""))  sql.append( " AND A.DFSCD  IN ('" + str1 + "')	  		 \n");
					sql.append( "  ORDER BY  A.SALEDT DESC										 \n");
								
					//System.out.println("xat_posmap_s1 \n" + sql.toString());					
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
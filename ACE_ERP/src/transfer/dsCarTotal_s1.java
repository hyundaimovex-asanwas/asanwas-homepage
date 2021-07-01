package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsCarTotal_s1 extends HttpServlet {

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
				String  str9	= req.getParameter("v_str1");    //프로젝트
					
				if (str9 == null) str9 = "";
	
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "START_DATE", "ACCSECTION", "START_TIME", "TOT_CNT", "BUS_CNT",
					"CAR_CNT", "TRUCK_CNT", "TRAIL_CNT", "ETC_CNT"
															
																	};

				int[] intArrCN = new int[]{ 10, 10, 10, 10, 10,
					10,10,10,10
																	
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, 0 ,0 ,
										0, 0, 0, 0
																	
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT   \n" );
					sql.append( " MAX(START_DATE) AS START_DATE, \n" );
					sql.append( " MAX(CASE WHEN ACCSECTION = 'O' THEN 'S->N' ELSE 'N->S' END) AS ACCSECTION,  \n" );
					sql.append( " START_TIME, \n" );
					sql.append( " COUNT(SEQ_NO) AS TOT_CNT,  \n" );
					sql.append( " 0 AS BUS_CNT,   \n" );
					sql.append( " 0 AS CAR_CNT,   \n" );
					sql.append( " SUM(CASE WHEN CAR_TYPE != '9999' AND CAR_TYPE != '0013' THEN 1 ELSE 0 END) AS TRUCK_CNT,  \n" );
					sql.append( " SUM(CASE WHEN CAR_TYPE = '0013' THEN 1 ELSE 0 END) AS TRAIL_CNT,   \n" );
					sql.append( " SUM(CASE WHEN CAR_TYPE = '9999' THEN 1 ELSE 0 END) AS ETC_CNT   \n" );
					
					 
					sql.append( " FROM TRANSFER.LTACCPLCAR   \n" );
					
					sql.append( " WHERE ACCSECTION = 'O'  \n");
					
					//sql.append( " AND ACCESSNO='0605160001' \n");
					

										
					if (!str9.equals("")) sql.append( " AND ACCESS_NO = '"+str9+"' \n" );
					
					sql.append( " GROUP BY START_TIME \n");	
					sql.append( " ORDER BY START_TIME ASC \n");	

						
					//logger.dbg.println( this, sql.toString() );
/*********************************************************************************************/
		//			GauceRes.writeException("Sql",":",sql.toString());
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
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
public class dsTotal_s2 extends HttpServlet {

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
				String  str9	= req.getParameter("v_str1");    //출입번호
				String  str2	= req.getParameter("v_str2");    //투입목적
				String  str3	= req.getParameter("v_str3");    //출경일자 FROM
				
				
				if (str9 == null) str9 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "RTRN_TIME", "TOT_PER_CNT", "PER_CNT", "DRIVER_CNT","RTRN_DATE",
				"RT_DATE_TIME", "R_DATE_TIME"
												
															
																	};

				int[] intArrCN = new int[]{ 10, 10, 10, 10, 30, 30, 30
																	
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

					sql.append( " SELECT   \n" );
					sql.append( " SUBSTR(RTRN_TIME,1,2)||':'||SUBSTR(RTRN_TIME,3,2) AS RTRN_TIME, \n" );
					sql.append( " COUNT(SEQ_NO) AS TOT_PER_CNT,  \n" );
					sql.append( " SUM(CASE WHEN DRIVE_DIV != 'Y' THEN 1 ELSE 0 END) AS PER_CNT, \n" );
					sql.append( " SUM(CASE WHEN DRIVE_DIV = 'Y' THEN 1 ELSE 0 END) AS DRIVER_CNT, RTRN_DATE, \n" );

					sql.append( " SUBSTR(RTRN_DATE,1,4)||'.'||SUBSTR(RTRN_DATE,5,2)||'.'||SUBSTR(RTRN_DATE,7,2)||' '|| \n" );
					sql.append( " SUBSTR(RTRN_TIME,1,2)||':'||SUBSTR(RTRN_TIME,3,2)  AS RT_DATE_TIME, \n" );
					sql.append( " SUBSTR(RTRN_DATE,1,4)||'.'||SUBSTR(RTRN_DATE,5,2)||'.'||SUBSTR(RTRN_DATE,7,2)||' '|| \n" );
					//sql.append( " SUBSTR((CAST(SUBSTR(RTRN_TIME,1,2)||':'||SUBSTR(RTRN_TIME,3,4) AS TIME)- 20 MINUTE),1,5) AS R_DATE_TIME  \n" );
					sql.append( " SUBSTR(cast(CAST(SUBSTR(RTRN_TIME,1,2)||':'||SUBSTR(RTRN_TIME,3,4) AS TIME)- 20 MINUTE as varchar(30)),1,5) R_DATE_TIME  \n" );


					sql.append( " FROM TRANSFER.LTPSRNACC   \n" );
					
					sql.append( " WHERE ACCSECTION = 'I'  \n");
					
					if (!str9.equals("")) sql.append( " AND ACCESSNO = '"+str9+"' \n" );
					//if (!str2.equals("")) sql.append( " AND A.PURPOSE = '"+str2+"' \n" );
					//if (!str3.equals("")) sql.append( "  AND  A.START_DATE BETWEEN '"+str3+"' AND '"+str4+"' \n");
         
					
					sql.append( " GROUP BY RTRN_TIME, RTRN_DATE \n");	
					sql.append( " ORDER BY RTRN_TIME ASC \n");	

						
					logger.dbg.println( this, sql.toString() );
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
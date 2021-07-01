package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class dsTotal_s1 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
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
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String  str9	= req.getParameter("v_str1");    //���Թ�ȣ
				
				if (str9 == null) str9 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "START_TIME", "TOT_PER_CNT", "PER_CNT", "DRIVER_CNT", "START_DATE", "ST_DATE_TIME", 
					"S_DATE_TIME"
															
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
					sql.append( " SUBSTR(START_TIME,1,2)||':'||SUBSTR(START_TIME,3,2) AS START_TIME, \n" );
					sql.append( " COUNT(SEQ_NO) AS TOT_PER_CNT,  \n" );
					sql.append( " SUM(CASE WHEN DRIVE_DIV != 'Y' THEN 1 ELSE 0 END) AS PER_CNT, \n" );
					sql.append( " SUM(CASE WHEN DRIVE_DIV = 'Y' THEN 1 ELSE 0 END) AS DRIVER_CNT, START_DATE, \n" );

					sql.append( " SUBSTR(START_DATE,1,4)||'.'||SUBSTR(START_DATE,5,2)||'.'||SUBSTR(START_DATE,7,2)||' '|| \n" );
					sql.append( " SUBSTR(START_TIME,1,2)||':'||SUBSTR(START_TIME,3,2)  AS ST_DATE_TIME, \n" );

					sql.append( " SUBSTR(START_DATE,1,4)||'.'||SUBSTR(START_DATE,5,2)||'.'||SUBSTR(START_DATE,7,2)||' '|| \n" );
					sql.append( " SUBSTR(cast(CAST(SUBSTR(START_TIME,1,2)||':'||SUBSTR(START_TIME,3,4) AS TIME)- 20 MINUTE as varchar(30)),1,5) S_DATE_TIME  \n" );

					sql.append( " FROM TRANSFER.LTPSRNACC   \n" );
					
					sql.append( " WHERE ACCSECTION = 'O'  \n");
					
					if (!str9.equals("")) sql.append( " AND ACCESSNO = '"+str9+"' \n" );
					
					sql.append( " GROUP BY START_TIME, START_DATE \n");	
					sql.append( " ORDER BY START_TIME ASC \n");	

						
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
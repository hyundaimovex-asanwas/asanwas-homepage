package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h050009_s1 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		//GauceStatement stmt =null;
		GauceDataSet dSet = null;

		Statement stmt  =null;
		//Connection conn =null;

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
				String  str1	= req.getParameter("v_str1");  //년월

				GauceRes.enableFirstRow(dSet);

			/*	String[] strArrCN = new String[]{ "EMPNO,FRDT,TODT,CNT" }; 

				int[] intArrCN = new int[]{ 7,8,8,2 }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,0}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				*/

				dSet.addDataColumn(new GauceDataColumn("EMPNO", GauceDataColumn.TB_STRING, 7));    // 
				dSet.addDataColumn(new GauceDataColumn("FRDT", GauceDataColumn.TB_STRING, 8));     // 
				dSet.addDataColumn(new GauceDataColumn("TODT", GauceDataColumn.TB_STRING, 8));     // 
				dSet.addDataColumn(new GauceDataColumn("CNT", GauceDataColumn.TB_DECIMAL, 2,0));    //

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT X.EMPNO, X.FRDT, X.TODT,                                                              " );
					sql.append( "      (DAYS(SUBSTR(X.TODT,1,4)||'-'||SUBSTR(X.TODT,5,2)||'-'||SUBSTR(X.TODT,7,2)) -         " );
          sql.append( "       DAYS(SUBSTR(X.FRDT,1,4)||'-'||SUBSTR(X.FRDT,5,2)||'-'||SUBSTR(X.FRDT,7,2))+1) CNT    " );
          sql.append( " FROM                                                                                         " );
					sql.append( " (SELECT EMPNO,                                                                               " );
          sql.append( "        CASE WHEN FRDT >= '20050701' THEN FRDT                                                " );
					sql.append( "             ELSE '20050701' END FRDT,                                                        " );
					sql.append( "        CASE WHEN TODT>='20050801' THEN '20050731'                                            " );
          sql.append( "             ELSE TODT END TODT                                                               " );
					sql.append( "                                                                                              " );
					sql.append( "  FROM PAYROLL.HLDUTY                                                                         " );
          sql.append( " WHERE (SGNID <>'' AND  SGNID <>'9999999')                                                    " );
					sql.append( "   AND (AGRID <>'' AND  AGRID <>'9999999')                                                    " );
					sql.append( "   AND LAZCD = 'C07'                                                                          " );
          sql.append( "   AND EMPNO = '2030029') X                                                                   " );
				
/*********************************************************************************************/

					//stmt = conn.getGauceStatement(sql.toString());
	 		    //stmt.executeQuery(dSet);

          stmt = conn.createStatement();
		      ResultSet rs = stmt.executeQuery(sql.toString());

			    GauceDataRow row =null;

				  while(rs.next()){

				    row = dSet.newDataRow();

						row.addColumnValue(rs.getString(1));  //      
						row.addColumnValue(rs.getString(2));	//      
						row.addColumnValue(rs.getString(3)); 	//      
						row.addColumnValue(rs.getInt(4));	//  

						//logger.dbg.println(this,"rs.getString(1)" + rs.getString(1));
						//logger.dbg.println(this,"rs.getString(2)" + rs.getString(2));
						//logger.dbg.println(this,"rs.getString(3)" + rs.getString(3));
						//logger.dbg.println(this,"rs.getInt(4)" + rs.getInt(4));

						dSet.addDataRow(row);
					}


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
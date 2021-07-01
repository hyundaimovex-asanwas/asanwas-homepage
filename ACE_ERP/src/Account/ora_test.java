package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
//import common.hdoraconn;
import com.hmm.ejb.common.UtilDB;
/*
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
*/

// class 이름은 화일명과 항상 동일해야 함.
public class ora_test extends HttpServlet {
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
		Connection conn = null;
		//CallableStatement cstmt =null;
		Statement stmt  =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
	        GauceResponse GauceRes = service.getGauceResponse();

			try {
		      
		/*
				String dbUrl    = "";
				String driver   = "";
				String userName = "";
				String userPass = "";
		*/ 
		        //conn = service.getDBConnection();
        
				logger.dbg.println(this,"step1::");

   		

			   dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				GauceRes.enableFirstRow(dSet);
				String [] str = new String [4];
				/**
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//년월
				str[2]	= req.getParameter("v_str3");		//사번
				str[3]	= "N";													//Default 'N'
				**/

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				String[] strArrCN = new String[]{ "EMPNO", "SEQ", "EDCCD", "GRAYY", "SCHNM" };

				int[] intArrCN = new int[] {  7,  2, 4, 4 , 60}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {		

						StringBuffer query = new StringBuffer();
					
            
			      //hdoraconn hdora_conn = new hdoraconn();
				
			//conn = hdora_conn.getHdConnection();
			//Connection conn = null;
			/**
						String dbUrl    = "";
						String driver   = "";
						String userName = "";
						String userPass = "";

				  dbUrl    = "jdbc:oracle:thin:@203.228.216.102:1521:DBTEST";
				  driver   = "oracle.jdbc.driver.OracleDriver";
				  userName = "asnhr2";
				  userPass = "asnhr2";
				  logger.dbg.println(this,"step621::");
				  Class.forName(driver);
				  logger.dbg.println(this,"step622::");
				  conn = DriverManager.getConnection(dbUrl, userName, userPass);

*/
						conn = UtilDB.getConnection("jdbc/asanhr");
					/**
					Context initContext = new InitialContext();
				   // Context envContext = (Context)initContext.lookup("java:/comp/env");
				   //Object datasourceRef=initContext.lookup("java:/comp/env/jdbc/asanhr1");

				    DataSource ds = (DataSource)initContext.lookup("jdbc/asanhr");
				
					//DataSource ds = (Datasource)datasourceRef;
            
				    // 커넥션 얻기
					conn = ds.getConnection();
					
					    **/

						
						

						///////http://erp.hdasan.com/services/servlet/Account.ora_test
   
					logger.dbg.println(this,"step63::");

				    query.append("  SELECT EMPNO, SEQ, EDCCD, GRAYY, SCHNM FROM ASNHR2.YA_T_HIEDUC ");
						
					logger.dbg.println(this,"step7::");
 					  
					stmt = conn.createStatement();

					logger.dbg.println(this,"step8::");

			         ResultSet rs = stmt.executeQuery(query.toString());
					logger.dbg.println(this,"step9::");
			        GauceDataRow row =null;
					logger.dbg.println(this,"step10::");
					while(rs.next()){
							row = dSet.newDataRow();
							row.addColumnValue(rs.getString(1));  //      
							row.addColumnValue(rs.getString(2));	//  
							row.addColumnValue(rs.getString(3));	//  
							row.addColumnValue(rs.getString(4));	//  
							row.addColumnValue(rs.getString(5));	//  
							dSet.addDataRow(row);
							logger.dbg.println(this,"step11::");
						}
						logger.dbg.println(this,"step12::");
						rs.close();
						logger.dbg.println(this,"step13::");
				         stmt.close();
						logger.dbg.println(this,"step14::");

		/*********************************************************************************************/

				}
			} catch(Exception e) {
		    logger.err.println(this,"오류");
			logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try { conn.close();} catch (Exception e) {}
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
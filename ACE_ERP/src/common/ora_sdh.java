package common;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
//import common.hdoraconn;
//import com.hmm.ejb.common.UtilDB;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


// class 이름은 화일명과 항상 동일해야 함.
public class ora_sdh extends HttpServlet {

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
			//logger = context.getLogger();

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
        
				System.out.println("step1::");

   		

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

				System.out.println("step4::");

				if (!GauceReq.isBuilderRequest()) {		
		                System.out.println("step5::");
						StringBuffer query = new StringBuffer();
						System.out.println("step6::");
            
			      //hdoraconn hdora_conn = new hdoraconn();
					System.out.println("step62::");
			//conn = hdora_conn.getHdConnection();
			//Connection conn = null;
					//	conn = UtilDB.getConnection("jdbc/asanhr");
					
					Context initContext = new InitialContext();
				   // Context envContext = (Context)initContext.lookup("java:/comp/env");
				    DataSource ds = (DataSource)initContext.lookup("jdbc/asanhr");
            
				    // 커넥션 얻기
					conn = ds.getConnection();

						
						

						///////http://erp.hdasan.com/services/servlet/Account.ora_test
   
					System.out.println("step63::");

				    query.append("  SELECT EMPNO, SEQ, EDCCD, GRAYY, SCHNM FROM ASNHR2.YA_T_HIEDUC ");
						
					System.out.println("step7::");
 					  
					stmt = conn.createStatement();

					System.out.println("step8::");

			         ResultSet rs = stmt.executeQuery(query.toString());
					System.out.println("step9::");
			        GauceDataRow row =null;
					System.out.println("step10::");
					while(rs.next()){
							row = dSet.newDataRow();
							row.addColumnValue(rs.getString(1));  //      
							row.addColumnValue(rs.getString(2));	//  
							row.addColumnValue(rs.getString(3));	//  
							row.addColumnValue(rs.getString(4));	//  
							row.addColumnValue(rs.getString(5));	//  
							dSet.addDataRow(row);
							System.out.println("step11::");
						}
						System.out.println("step12::");
						rs.close();
						System.out.println("step13::");
				stmt.close();
						System.out.println("step14::");

		/*********************************************************************************************/

				}
			} catch(Exception e) {
				System.out.println("eee"+ e.toString());
			
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try { conn.close();} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			
			System.out.println(e.toString());
		} finally {
			loader.restoreService(service);
		}
	}
}
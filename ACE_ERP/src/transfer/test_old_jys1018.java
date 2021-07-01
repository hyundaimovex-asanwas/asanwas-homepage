package transfer;

import com.gauce.*;
import com.gauce.http.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import javax.naming.*;	// 추가필요

import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class test_old_jys1018 extends HttpServlet {
 
	/**
	 * 
	 */
	private static final long serialVersionUID = -8099656142797795728L;

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		Connection conn = null;
		//GauceStatement stmt =null;
		Statement stmt =null;
		GauceDataSet dSet = null;
		DataSource dataSrc = null;
     
		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq  = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				//conn = service.getDBConnection();
				
				System.out.println("1::");
				dSet = new GauceDataSet();
				System.out.println("2::");				
				//Gauce connection
				//dataSrc = (DataSource)req.getAttribute("GauceDB$default");
				dataSrc = (DataSource)((HttpGauceRequest) req).getAttribute("GauceDB$default");
				System.out.println("3:dataSrc:"+dataSrc);
				//conn = dataSrc.getConnection();
				System.out.println("4::");
				
				conn = dataSrc.getConnection();
				System.out.println("55::");
				//conn = dataSrc.getConnection();
				
				//stmt = conn.createStatement();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				  
				System.out.println("5::");
				String str1 = GauceReq.getParameter("gstr1");   
				
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }

				GauceRes.enableFirstRow(dSet);

				System.out.println("6::");
				String[] strArrCN = new String[]{ "LINE_PART", "APP_DT1","APP_DT2","APP_DT3"}; 

				int[] intArrCN = new int[] { 10, 8, 8, 8 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1 }; 
				System.out.println("7::");
 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				System.out.println("8::");

					//if (isNotOnlyHeader) {
						
						System.out.println("9::");
						StringBuffer sql = new StringBuffer();

							sql.append( " SELECT  					\n																	") ; 
							sql.append( " LINE_PART, 				\n				 													") ; 
							sql.append( " APP_DT1, 					\n			 														") ; 				
							sql.append( " APP_DT2, 					\n			 														") ; 		
							sql.append( " APP_DT3 					\n			 														") ; 	
							sql.append( " FROM TRANSFER.LTCALENDAR  \n 												                	") ; 
							sql.append( " WHERE 1 = 1  																			    	") ; 
							
							sql.append( " AND CAL_DT = TO_CHAR(SYSDATE,'YYYYMMDD')	") ;
							
							//sql.append( " AND CAL_DT = SUBSTRING(CHAR(CURRENT DATE,ISO),1,4)  		") ; 												
							//sql.append( " CONCAT SUBSTRING(CHAR(CURRENT DATE,ISO),6,2) 				") ; 
							//sql.append( " CONCAT SUBSTRING(CHAR(CURRENT DATE,ISO),9,2)  				") ;					
																								
				    if(str1 != null ) 	{ sql.append( " AND  LINE_PART = '" + str1 + "'					") ; } 

					if (isDebug) {	GauceRes.writeException("Sql",":",sql.toString()); }
					
					System.out.println("Sql::"+sql.toString());
				
					stmt = conn.createStatement();
					System.out.println("1000::");
					ResultSet rs = stmt.executeQuery(sql.toString());
					//stmt = conn.createStatement();
			        //stmt.executeQuery(sql.toString());
					GauceDataRow row =null;
					
					while(rs.next()){

					    row = dSet.newDataRow();
					
					    row.addColumnValue(rs.getString(1));
					    row.addColumnValue(rs.getString(2));
					    row.addColumnValue(rs.getString(3));
					    row.addColumnValue(rs.getString(4));
					    
					    dSet.addDataRow(row);	    
					}
						
				//}
					System.out.println("10::");
/*********************************************************************************************/

			} 
			
			catch(Exception e) {
		  	logger.err.println(this,e);
			GauceRes.writeException("Sql",":",e.toString());
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
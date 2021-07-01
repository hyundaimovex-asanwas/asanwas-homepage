package transfer;

import com.gauce.*;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.sql.*;

import transfer.common.HDConnJndi;
import transfer.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

//class 이름은 화일명과 항상 동일해야 함.
public class dsGetDates extends HttpServlet  {

	
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");	
		//System.out.println("시작::");
		//추가
		Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
		GauceDataSet dSet = null;
	
		try {
			
			try {
								
				String str1 = req.getParameter("gstr1");			
	            GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
	            GauceOutputStream gos = ((HttpGauceResponse) res).getGauceOutputStream();
				
	            HDConnJndi JndiConn = new HDConnJndi();
	            conn  = JndiConn.getHdConnection(req, res);
	            
	            /*
				//JNDI connection 호출 : import javax.naming.*; 필요
	            Context initContext = (Context) new InitialContext();
	        	DataSource ds = (DataSource) initContext.lookup("CforTransfer");
	        	conn = ds.getConnection();
	        	//JNDI connection 호출
	            */          
	            //
	            
	        	//System.out.println("step4");
	        	dSet = new GauceDataSet();	
				gos.fragment(dSet);
				
/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				//System.out.println("step5");
				
				if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				
				
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT  						   	       \n") ; 
						sql.append( " LINE_PART, 							   \n") ; 
						sql.append( " APP_DT1, 								   \n") ; 				
						sql.append( " APP_DT2, 								   \n") ; 		
						sql.append( " APP_DT3 								   \n") ; 	
						sql.append( " FROM TRANSFER.LTCALENDAR   			   \n") ; 
						sql.append( " WHERE 1 = 1  							   \n") ; 
						sql.append( " AND CAL_DT = TO_CHAR(SYSDATE,'YYYYMMDD') \n") ;		
						//sql.append( " AND  LINE_PART = '0001'					") ;  
						//sql.append( " AND CAL_DT = SUBSTRING(CHAR(CURRENT DATE,ISO),1,4)  		") ; 												
						//sql.append( " CONCAT SUBSTRING(CHAR(CURRENT DATE,ISO),6,2) 				") ; 
						//sql.append( " CONCAT SUBSTRING(CHAR(CURRENT DATE,ISO),9,2)  				") ;
																		
				   if(str1 != null ) 	{ sql.append( " AND  LINE_PART = '" + str1 + "'	\n") ; } 
				
					
					//System.out.println("Sql::"+sql.toString());
				
					//stmt = conn.getGauceStatement(sql.toString());
					//stmt.executeQuery(dSet);		
										
					stmt = conn.createStatement();
			        rs=stmt.executeQuery(sql.toString());		    
						
			        gos.write(SuperServlet.getDataSet(rs, dSet));
			        gos.close();
			        
		            rs.close();
		            stmt.close();
		            conn.close();
		            
		            
				
/*********************************************************************************************/

			} 	
			catch(Exception e) {
		  	//logger.err.println(this,e);
			//GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try { conn.close();} catch (Exception e) {}
		  }

		  //dSet.flush();
		  //GauceRes.commit();
		  //GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		} finally {
			//loader.restoreService(service);
  	}
	}
}
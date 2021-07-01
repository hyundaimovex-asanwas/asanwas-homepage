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

// class 이름은 화일명과 항상 동일해야 함.
public class tr00501_s4 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;		
		GauceDataSet dSet = null;
		try {
			try {
				GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
	            GauceOutputStream gos = ((HttpGauceResponse) res).getGauceOutputStream();
						
				//JNDI connection 호출 : import javax.naming.*; 필요
	            Context initContext = (Context) new InitialContext();
	        	DataSource ds = (DataSource) initContext.lookup("CforTransfer");
	        	conn = ds.getConnection();
	            //JNDI connection 호출
	        	
	        	dSet = new GauceDataSet();	
				gos.fragment(dSet);


/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String str1	= req.getParameter("v_str1"); 
				String str2	= req.getParameter("v_str2"); 

				

					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT RTRIM(MAJORCD) MAJORCD,RTRIM(MINORCD) MINORCD,RTRIM(MINORNM) MINORNM,SEQ,RTRIM(USEYN) USEYN,RTRIM(MEMO) MEMO \n" )
						   .append( "		FROM TRANSFER.LTLCODE \n" )
						   .append( "	 WHERE MAJORCD = '0009' \n" )
//						   .append( "    AND MINORCD IN ('0001','0002') \n" )
						   .append( " ORDER BY SEQ ASC ");

		 				stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
				
						gos.write(sales.common.SuperServlet.getDataSet(rs, dSet));
			            
			            rs.close();
			            stmt.close();
			            conn.close();

/*********************************************************************************************/

			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
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
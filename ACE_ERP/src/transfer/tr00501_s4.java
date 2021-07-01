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

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class tr00501_s4 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
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
						
				//JNDI connection ȣ�� : import javax.naming.*; �ʿ�
	            Context initContext = (Context) new InitialContext();
	        	DataSource ds = (DataSource) initContext.lookup("CforTransfer");
	        	conn = ds.getConnection();
	            //JNDI connection ȣ��
	        	
	        	dSet = new GauceDataSet();	
				gos.fragment(dSet);


/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
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
package transfer;

/*
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.gauce.GauceContext;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.log.Logger;
*/
import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;

//import transfer.common.HDConnJndi;

public class trRateChange extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		
		com.gauce.ServiceLoader loader = new com.gauce.ServiceLoader(req, res);
		//GauceService service = null;
		//GauceContext context = null;
		//Logger logger = null;
		GauceDBConnection conn = null;
		
		System.out.println("시작");		
		//Connection conn = null;
		//GauceDataSet dSet = null;
		//PreparedStatement pstmt = null;

		try{
			
			//loader = new com.gauce.ServiceLoader(req, res);
			/*
			service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
            */
            
            
			//context = service.getContext();
			//GauceDBConnection conn = null;
			//loader = new 채ㅡ.ㅎㅁServiceLoader(request, response);
		/*	System.out.println("서비스");		
			service = loader.newService();
			System.out.println("conn");		
			conn = service.getDBConnection();*/
			
			System.out.println("11");	
			
			//DataSource dataSrc = (DataSource)req.getAttribute("GauceDB");
			//conn = dataSrc.getConnection();
						
			
			/* GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
	         GauceOutputStream gos = ((HttpGauceResponse) res).getGauceOutputStream();
	        */ 
	         //HDConnJndi JndiConn = new HDConnJndi();
	         //conn  = JndiConn.getHdConnection(req, res);
             
			try {
				
				/*
				conn = service.getDBConnection();
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
                */	
				
				System.out.println("서비스");		
    			GauceService service = loader.newService();

    			GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
    			GauceOutputStream gos = ((HttpGauceResponse)res).getGauceOutputStream();
    			
    			System.out.println("conn");		
    			conn = service.getDBConnection();

				System.out.println("22");	 
				GauceDataSet userSet = gis.read("DATA");
				System.out.println("33");	
					
				int idxORDER_NO	= userSet.indexOfColumn("ORDER_NO");
						
				String str1 = req.getParameter("v_str1");
				String str2 = req.getParameter("v_str2");
				System.out.println("44");	
				
				if (str2==null || str2=="") str2 = "0";
				int itr1 = Integer.parseInt(str2);
				
				GauceDataRow[] rows = userSet.getDataRows();
				
				System.out.println("55");	

				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT ) {
						
						System.out.println("66");	

						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE TRANSFER.LTORDERDTL \n" )
								 .append( "	   SET CUR_CODE = '" + str1 + "', \n" )
								 .append( "	       FR_UNTPRCE = (UNIT_PRICE/" + itr1 + "), \n" )
								 .append( "		   FR_PRICE = (PRICE/" + itr1 + ") \n" )
								 //.append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' \n" );
						         .append( "  WHERE ORDER_NO = ? \n" );
						
						System.out.println(UpdateSql.toString());						
						System.out.println( rows[j].getString(idxORDER_NO) );
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//PreparedStatement pstmt = conn.prepareCall(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]); 
						gsmt.bindColumn(1,  idxORDER_NO ) ;
						//pstmt.setString(1,rows[j].getString(idxORDER_NO) );
						
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
				
			  gos.close();	//Component와의 통신을 끊는다
			  
			}catch(Exception e){
			  //resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			  conn.rollback();	
			  e.printStackTrace();
			}
			conn.commit();
			//resGauce.flush();
			//resGauce.commit();
			//resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			//loader.restoreService(service);
	 	}
	}
}
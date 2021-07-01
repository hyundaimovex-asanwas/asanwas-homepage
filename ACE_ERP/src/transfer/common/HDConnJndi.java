package transfer.common;


import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class HDConnJndi {
    public HDConnJndi(){};

    //db connection
	public Connection getHdConnection(HttpServletRequest req, HttpServletResponse res) throws Exception{
      Connection conn = null;	
    try{
    	
        //JNDI connection 호출 : import javax.naming.*; 필요
        Context initContext = (Context) new InitialContext();
    	DataSource ds = (DataSource) initContext.lookup("CforTransfer");
    	conn = ds.getConnection();
   	
        //JNDI connection 호출   	
		}catch(SQLException se) {
            System.out.println(se.toString());
		}catch(Exception e){
			System.out.println(e.toString());
		    throw e;
		}
    
		return conn;
	}
}
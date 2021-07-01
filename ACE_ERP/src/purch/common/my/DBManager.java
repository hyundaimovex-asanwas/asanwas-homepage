package purch.common.my;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.sql.DataSource;

import sales.common.StringUtil;

public class DBManager {
	private static DBManager 	fInstance = null;
	static 	boolean 			fUseKtConn = false;
	private DataSource 			fDataSource = null;
	
	Connection conn = null;
	
	// AS 400
	String url = "jdbc:as400://203.242.32.199/SALES";
	String driver = "com.ibm.as400.access.AS400JDBCDriver";
	String user = "USERKG";
	String password = "PWDKG";
	/**
	 * 
	 * @return
	 */
	public static DBManager getInstance() {
		
		if (fInstance == null) {
			fInstance = new DBManager();
		}
		
		return fInstance;
	}
    
	/**
	 * 
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public synchronized Connection getConnection() throws ClassNotFoundException, SQLException {	    
		Connection conn = null;
		try{
			Class.forName(driver);
			conn = DriverManager.getConnection(url,user,password);
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException se){
			se.printStackTrace();
		}
		return conn;
	}
    

	
}

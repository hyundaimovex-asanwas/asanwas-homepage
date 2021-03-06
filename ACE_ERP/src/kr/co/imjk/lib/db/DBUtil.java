/*
 * Created on 2004. 8. 18.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.lib.db;

import java.sql.*;
import java.util.*;
import javax.naming.*;

import kr.co.imjk.lib.Config;


/**
 * @author kyuha94
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DBUtil {

	/** 시스템 설정. DataSource 설정의 조회를 위해 사용된다. */
	static Config config=Config.getInstance();
 
	
	/**
	 * 	Autocommit을 하는 Connection
	**/
	public static Connection getConnection (String dbName) {
		Connection con = null;

		try {

	      	Properties p = new Properties();
	      	String factory = config.getProperty(dbName, "factory");
	      	String url = config.getProperty(dbName, "url");
	      	String dataSourceName = config.getProperty(dbName, "dsname");

		//System.out.println("factory : " + factory);
		//System.out.println("url : " + url);
		//System.out.println("dataSourceName : " + dataSourceName);
			
	      	p.put(Context.INITIAL_CONTEXT_FACTORY,factory);//"weblogic.jndi.WLInitialContextFactory");
	      	p.put(Context.PROVIDER_URL, url);//"t3://localhost:19025");
	
		    Context ctx 	= new InitialContext(p);
	
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup(dataSourceName);//"PRISMTXDS");
	
			con = ds.getConnection();
			 
		}
		catch (Exception e) {
		    e.printStackTrace();
		}
		finally {
		
		}
		return con;
	}
	
	
	/**
	 *   AutoCommit을 하지 않는 것.
	**/
	public static Connection getTranConnection(String dbName) throws Exception {
	    Connection con = null;
	    try {
	
	      	Properties p = new Properties();
	      	String factory = config.getProperty(dbName, "factory");
	      	String url = config.getProperty(dbName, "url");
	      	String dataSourceName = config.getProperty(dbName, "dsname");
			
	      	p.put(Context.INITIAL_CONTEXT_FACTORY,factory);//"weblogic.jndi.WLInitialContextFactory");
	      	p.put(Context.PROVIDER_URL, url);//"t3://localhost:19025");
	
		    Context ctx 	= new InitialContext(p);
	
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup(dataSourceName);//"PRISMTXDS");
			con = ds.getConnection();
			con.setAutoCommit(false);
			
	    } catch (Exception e){
	         e.printStackTrace();
	    } finally {
	    	
		}
	
	    return con;
	
	}
	
	
	
	/**
		Connection Close
		@param con connection 객체
		@param stmt Statement 객체
		@param rs ResultSet 객체	
	*/
	public static void closeConnection (Connection con, Statement stmt, ResultSet rs) {
		try {
			if (rs != null)		rs.close();
			if (stmt != null)	stmt.close();
			if (con != null)	con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
		Connection Close
		@param con connection 객체
		@param stmt Statement 객체
	*/	
	public static void closeConnection (Connection con, Statement stmt) {
		try {
			if (stmt != null)	stmt.close();
			if (con != null)	con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
		Connection Close
		@param con connection 객체
		@param stmt PreparedStatement 객체
		@param rs ResultSet 객체			
	*/	
	public static void closeConnection (Connection con, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (rs != null)		rs.close();
			if (pstmt != null)	pstmt.close();
			if (con != null)	con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
		Connection Close
		@param con connection 객체
		@param stmt PreparedStatement 객체
	*/		
	public static void closeConnection (Connection con, PreparedStatement pstmt) {
		try {
			if (pstmt != null)	pstmt.close();
			if (con != null)	con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}

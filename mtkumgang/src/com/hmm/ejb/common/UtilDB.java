/**
 * 작성일 : 2005-01-13
 * 작성자 : csangsu : 최상수 과장님으로 생각됨.
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.common;

import com.hmm.ejb.util.HMMException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * HMM EJB Common.UtilDB.java.java
 */
public class UtilDB {
	public static Connection getConnection(String jndiName) throws HMMException
	{
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			
			DataSource ds = (DataSource) ctx.lookup(jndiName);

			if (ds != null) {
				conn = ds.getConnection();
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new HMMException(e);
		}
		return conn;
	}
	
	public static Connection getRemoteConnection(String jndiName) throws HMMException
	{
		Connection conn = null;
		try {
			Context ctx = ServiceLocator.getInstance().getInitialContext();
			DataSource ds = (DataSource) ctx.lookup(jndiName);
			if(ds != null) {
				conn = ds.getConnection();
			}
		}catch(Exception e) {
			throw new HMMException(e);
		}
		return conn;
	}
	
	public static void closeConnection(Connection con) 
	{
		if(con != null)
		{
			try {
				con.close();
				con = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void closeConnection(Connection con, PreparedStatement pstmt) 
	{
		if(pstmt != null)
		{
			try {
				pstmt.close();
				pstmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null)
		{
			try {
				con.close();
				con = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void closeConnection(Connection con, PreparedStatement pstmt, ResultSet rs) 
	{
		if(rs != null)
		{
			try {
				rs.close();
				rs = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(pstmt != null)
		{
			try {
				pstmt.close();
				pstmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null)
		{
			try {
				con.close();
				con = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public static void closeConnection(Connection con, Statement stmt) 
	{
		if(stmt != null)
		{
			try {
				stmt.close();
				stmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null)
		{
			try {
				con.close();
				con = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public static void closeConnection(Connection con, Statement stmt, ResultSet rs) 
	{
		if(rs != null)
		{
			try {
				rs.close();
				rs = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(stmt != null)
		{
			try {
				stmt.close();
				stmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null)
		{
			try {
				con.close();
				con = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void closeConnection(Connection con, CallableStatement cstmt) 
	{
		if(cstmt != null)
		{
			try {
				cstmt.close();
				cstmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null)
		{
			try {
				con.close();
				con = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public static void closeConnection(Connection con, CallableStatement cstmt, ResultSet rs) 
	{
		if(rs != null)
		{
			try {
				rs.close();
				rs = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(cstmt != null)
		{
			try {
				cstmt.close();
				cstmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null)
		{
			try {
				con.close();
				con = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}

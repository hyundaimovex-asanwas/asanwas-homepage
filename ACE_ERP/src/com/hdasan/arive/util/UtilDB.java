/**
 * 작성일 : 2011-08-08
 * 작성자 : sdh
 * copy & paste & STUDY
 */
package com.hdasan.arive.util;

import com.hdasan.arive.util.ARIVEException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UtilDB {
	public static Connection getConnection(String jndiName) throws ARIVEException
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
			throw new ARIVEException(e);
		}
		return conn;
	}
	
	public static Connection getRemoteConnection(String jndiName) throws ARIVEException
	{
		Connection conn = null;
		try {
			Context ctx = ServiceLocator.getInstance().getInitialContext();
			DataSource ds = (DataSource) ctx.lookup(jndiName);
			if(ds != null) {
				conn = ds.getConnection();
			}
		}catch(Exception e) {
			throw new ARIVEException(e);
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

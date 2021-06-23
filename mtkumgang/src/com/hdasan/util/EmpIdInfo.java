package com.hdasan.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import javax.servlet.http.*;

import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import com.hmm.ejb.common.UtilDB;
/**
 * 계정테이블 세션 값 불러오기
 * 2011-09-09 심동현 
 */
public class EmpIdInfo extends DAOHome{

	public String FPwd(HttpServletRequest request, HttpServletResponse response) {
		CallableStatement cstmt = null;
		String empid 		= SecUtil.sqlFilter(request.getParameter("empid"));
		String qry ="";
		//System.out.println("111==");
		//System.out.println("empid=="+empid);
		
		Connection conn = null;
		ResultSet rs    = null;
		String result = "e";
		
		try{
			conn = getConnection();
			qry ="{call COMMON.PR_CM110I_01(?,?,?,?,?,   ?,?,?,?,?) }";
			
			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, empid);
			cstmt.setString	(2, "");
			cstmt.setString (3, "");	
			cstmt.setString	(4, "");	  
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");								//5세션id(INOUT)  
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "5");								//
			cstmt.setString	(7, "w5");								//7프로시저 호출 
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//성공여부
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//메세지 코드
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//메세지
					
			cstmt.executeUpdate();

			if(cstmt.getString(8).equals("Y")){	// 성공여부
				result = cstmt.getString(5);
			}else{
				throw new Exception(cstmt.getString(10));
			}
		
		
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception during connection :"+e.getMessage());
		} finally {
			UtilDB.closeConnection(conn, cstmt, rs);
		}
		return result;
	}

}

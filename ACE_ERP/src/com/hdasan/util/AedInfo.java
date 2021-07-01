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
 * �������̺� ���� �� �ҷ�����
 * 2011-09-09 �ɵ��� 
 */
public class AedInfo extends DAOHome{

	public String Pwd(HttpServletRequest request, HttpServletResponse response) {
		CallableStatement cstmt = null;
		String aed 		= SecUtil.sqlFilter(request.getParameter("aed"));
		String qry ="";

		Connection conn = null;
		ResultSet rs    = null;
		String result = "e";
		
		try{
			conn = getConnection();
			qry ="{call COMMON.PR_CM100I_01(?,?,?,?,?,   ?,?,?,?,?) }";
			
			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, aed);
			cstmt.setString	(2, "");
			cstmt.setString (3, "");	
			cstmt.setString	(4, "");	  
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");								//5����id(INOUT)  
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "5");								//
			cstmt.setString	(7, "w5");								//7���ν��� ȣ�� 
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//��������
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//�޼���
					
			cstmt.executeUpdate();

			if(cstmt.getString(8).equals("Y")){	// ��������
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

package com.hmm.asan.asanway.admin;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.ejb.common.UtilDB;

/**
 */
public class LoginBean {

    /**
     * 관리자 로그인
     * @author : Czar
     * @2005. 10. 10
     */
    public int Login(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Admin Login *****");

        String id = request.getParameter("id");
        String password = request.getParameter("password");

    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs    = null;
    	int result = 0;

            try{
    	    	conn = UtilDB.getConnection("jdbc/asands");
    	    	pstmt = conn.prepareStatement("select * from asan.admin where id = ? and isdel = 0 and status = '1' ");
    	    	pstmt.setString(1, id);
    	    	rs   = pstmt.executeQuery();

    	    	if( rs.next() ) {
        	    	/**
        	    	 * 해당 아이디가 있을 경우
        	    	 */
    	    	    pstmt = conn.prepareStatement("select * from asan.admin where id = ? and password = ? and isdel = 0 and status = '1' ");
    	    	    pstmt.setString(1, id);
    	    	    pstmt.setString(2, password);
    	    	    rs = pstmt.executeQuery();

    	    	    if( rs.next() ) {
    	    	        /**
        	    	     * 아이디와 패스워드가 맞을 경우
        	    	     */
    	    	        result = 1;

    	    	        HttpSession session = request.getSession();
    	    	        session.setAttribute("adminidx", rs.getString("idx") );
    	    	        session.setAttribute("adminid", rs.getString("id") );
    	    	        session.setAttribute("adminname", rs.getString("name") );
    	    	        session.setAttribute("admingrade", rs.getString("grade") );

    	    	    } else {
    	    	        /**
    	    	         * 패스워드 틀렸을 경우
    	    	         */
    	    	        result = -1;
    	    	    }
    	    	} else {
        	    	/**
        	    	 * 해당 아이디가 없을 경우
        	    	 */
    	    	    result = 0;
    	    	}
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Exception during connection :"+e.getMessage());
            } finally {
                UtilDB.closeConnection(conn, pstmt, rs);
            }

            return result;

    }

    /**
     * 관리자 로그아웃
     * @author : Czar
     * @2005. 10. 10
     */
    public void Logout(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Admin Logout *****");

        HttpSession session = request.getSession();
        session.invalidate();
    }
}

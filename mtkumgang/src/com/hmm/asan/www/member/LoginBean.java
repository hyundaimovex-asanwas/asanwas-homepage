package com.hmm.asan.www.member;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.net.*;

import javax.servlet.http.*;

import com.hmm.ejb.common.UtilDB;
import com.hdasan.util.SecUtil;
/**
 */

public class LoginBean {

    /**
     * 회원 로그인
     * @author : ikara
     * @Last Modify : Kim , Jong seob ( IMJK ) , 2006.06.09
     */
    public int Login(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Admin Login *****");

        String id = SecUtil.sqlFilter(request.getParameter("id"));
        String pwd = SecUtil.sqlFilter(request.getParameter("pwd"));
        String sDomain = request.getParameter("domain");

    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs    = null;
    	int result = 0;
        try{
	    	conn = UtilDB.getConnection("jdbc/tourds"); 
	    	//탈퇴 회원 은 로그인 할수없다.
	    	pstmt = conn.prepareStatement("select * from asan.member where id = ? and (level = '0' OR level = '2') and (case when isdel = 'y' then 0 else 1 end) = 1 ");
	    	pstmt.setString(1, id);
	    	rs   = pstmt.executeQuery();


	    	if( rs.next() ) {
    	    	/**
    	    	 * 해당 아이디가 있을 경우
    	    	 */
	    	    pstmt = conn.prepareStatement("select * from asan.member where id = ? and pwd = ? and (level = '0' OR level = '2') and (case when isdel = 'y' then 0 else 1 end) = 1 ");
	    	    pstmt.setString(1, id);
	    	    pstmt.setString(2, pwd);
	    	    rs = pstmt.executeQuery();

	    	    if( rs.next() ) {
	    	        /**
    	    	     * 아이디와 패스워드가 맞을 경우
    	    	     */
	    	        result = 1;
	    	        
	    	        /* session 생성 */ 
	    	        HttpSession session = request.getSession();
	    	        session.setAttribute("memberidx", rs.getString("idx") );
	    	        session.setAttribute("memberid", rs.getString("id") );
	    	        session.setAttribute("membername", rs.getString("name") );
					session.setAttribute("memberemail", rs.getString("email") );
					session.setAttribute("membertel", rs.getString("tel") );
					session.setAttribute("memberisfrom", rs.getString("isfrom") );
					session.setAttribute("memberclient_sid", rs.getString("client_sid") );
	    	        session.setAttribute("memberlevel", rs.getString("level") );
                     
                    
	    	        
	    	        //Cookie 생성
	    	        /*setCookie(response, "id", rs.getString("id"), sDomain, -1);
	    	        setCookie(response, "name", URLEncoder.encode(rs.getString("name")), sDomain, -1);
	    	        setCookie(response, "email", URLEncoder.encode(rs.getString("email")), sDomain, -1);
	    	        setCookie(response, "tel", URLEncoder.encode(rs.getString("tel")), sDomain, -1);
	    	        setCookie(response, "isfrom", rs.getString("isfrom"), sDomain, -1);
	    	        setCookie(response, "client_sid", rs.getString("client_sid"), sDomain, -1);
	    	        */
 

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
     * 회원  로그아웃
     * @author : ikara
     * @2005. 10. 31
     * @Last Modify : Kim , Jong seob ( IMJK ) , 2006.06.09
     */
    public void Logout(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Member Logout *****");

        HttpSession session = request.getSession();
        session.invalidate();
        
        //Cookie 삭제
        /*Cookie[] cookies = request.getCookies();
        if ((cookies != null) && (cookies.length > 0)) {
	        for(int i=0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
			    if (thisCookie.getName().equals("id") || thisCookie.getName().equals("name") || thisCookie.getName().equals("email") || thisCookie.getName().equals("tel") || thisCookie.getName().equals("isfrom") || thisCookie.getName().equals("client_sid")) {
				    thisCookie.setMaxAge(0);
				    thisCookie.setPath("/");
					response.addCookie(thisCookie); 
				}
            }
        }*/
    } 
    
    /**
     * Cookie set
     * @author : Kim , Jong seob ( IMJK )
     * @2006.06.09
     */
    public static void setCookie(HttpServletResponse response, String name, String value, String domain, int expiry){
	    if ((name != null) && (value != null)) {
	        Cookie aCookie = new Cookie(name, value);
			if (domain != null) {
			    aCookie.setDomain(domain); 
			}
			aCookie.setMaxAge(expiry);
			aCookie.setPath("/");
			response.addCookie(aCookie);
		}
	}
}

/*
 * 20091017 심동현 보안강화를 위한 request 파라미타 받는 부분 SQL 인젝션 방지 유틸 추가
 * SecUtil.sqlFilter(파라미터)
 * 
 * 20111128 심동현 통합 웹 회원용 서블릿 복사 생성 
 * */
package com.hmm.asan.www.member;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.net.*;

import javax.servlet.http.*;

import com.hmm.ejb.common.UtilDB;
import com.hdasan.util.SecUtil;



public class ALoginBean {

	/**
	 * 회원  가입 확인
	 * @author : sdh
	 * @2011. 12. 07
	 */
    public int Login(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Admin Login *****");

		String m_aed = SecUtil.sqlFilter(request.getParameter("email"));
		String bmilno = SecUtil.sqlFilter(request.getParameter("pwd"));
		//System.out.println("***** m_aed *****" + m_aed);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs    = null;
		int result = 0;
		try{
			conn = UtilDB.getConnection("jdbc/tourds"); 

			pstmt = conn.prepareStatement("select * from asan.wb0080 " +
				" where m_aed = ? " +
				" and isdel in ('N','n')  ");
			pstmt.setString(1, m_aed);
			rs   = pstmt.executeQuery();


			if( rs.next() ) {
				/**
				 * 해당 아이디가 있을 경우
				 */
				pstmt = conn.prepareStatement("select * from asan.wb0080 " +
					" where m_aed = ? " +
					" and bmilno = ENCRYPT('"+ bmilno +"','a$an1108') " +
					" and isdel in ('N','n')  ");
				pstmt.setString(1, m_aed);
				rs = pstmt.executeQuery();

				if( rs.next() ) {
					/**
					 * 아이디와 패스워드가 맞을 경우
					 */
					result = 1;
	    	        
					/* session 생성 */ 
					HttpSession session = request.getSession();
					session.setAttribute("membersid", rs.getString("wb_sid") );
					session.setAttribute("memberaed", rs.getString("m_aed") );
					session.setAttribute("membernm", rs.getString("nm") );
					session.setAttribute("memberpnm", rs.getString("pnm") );
					session.setAttribute("membertouch", rs.getString("touch") );
					session.setAttribute("memberisfrom", rs.getString("isfrom") );
					session.setAttribute("memberisgubn", rs.getString("isgubn") );
					session.setAttribute("memberoldid", rs.getString("oldid") );
					session.setAttribute("memberok", "evagelion" );

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

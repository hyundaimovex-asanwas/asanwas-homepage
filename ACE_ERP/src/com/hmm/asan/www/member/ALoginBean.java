/*
 * 20091017 �ɵ��� ���Ȱ�ȭ�� ���� request �Ķ��Ÿ �޴� �κ� SQL ������ ���� ��ƿ �߰�
 * SecUtil.sqlFilter(�Ķ����)
 * 
 * 20111128 �ɵ��� ���� �� ȸ���� ���� ���� ���� 
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
	 * ȸ��  ���� Ȯ��
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
				 * �ش� ���̵� ���� ���
				 */
				pstmt = conn.prepareStatement("select * from asan.wb0080 " +
					" where m_aed = ? " +
					" and bmilno = ENCRYPT('"+ bmilno +"','a$an1108') " +
					" and isdel in ('N','n')  ");
				pstmt.setString(1, m_aed);
				rs = pstmt.executeQuery();

				if( rs.next() ) {
					/**
					 * ���̵�� �н����尡 ���� ���
					 */
					result = 1;
	    	        
					/* session ���� */ 
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
					 * �н����� Ʋ���� ���
					 */
					result = -1;
				}
			} else {
				/**
				 * �ش� ���̵� ���� ���
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
     * ȸ��  �α׾ƿ�
     * @author : ikara
     * @2005. 10. 31
     * @Last Modify : Kim , Jong seob ( IMJK ) , 2006.06.09
     */
    public void Logout(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Member Logout *****");

        HttpSession session = request.getSession();
        session.invalidate();
        
        //Cookie ����
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

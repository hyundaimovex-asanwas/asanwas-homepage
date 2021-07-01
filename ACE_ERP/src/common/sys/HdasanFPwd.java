package common.sys;
/*
 * [ �������� ][������] ����   
 * [2011-06-13][�ɵ���] ���Ȱ�ȭ�� ���� request �Ķ��Ÿ �޴� �κ� SQL ������ ���� ��ƿ �߰�
 *                      SecUtil.sqlFilter(�Ķ����)
 * 
 * */
import java.sql.*;
import java.net.*;
import javax.servlet.http.*;
import sales.common.StringUtil;

import com.hdasan.arive.util.UtilDB;	// �̰� �ϴ� �÷�������..��.. -_-;
import com.hdasan.arive.util.SecUtil;	// 2011-06-13 �ɵ��� ������ƿ~ ������ó
//import sales.org.application.common.CommonManager;
import sales.org.common.db.DBConnection;		// 2011-06-02 �ɵ��� ���⼭ Ŀ�ؼ� ������ �մϴ�.


public class HdasanFPwd {

	/**
	 * ȸ�� ����
	 */
	public int FPwd(HttpServletRequest request, HttpServletResponse response) {

		CallableStatement cstmt = null;
		CallableStatement cstmt2 = null;
		String empid 	= SecUtil.sqlFilter(StringUtil.encoding(request.getParameter("txt_empid")));
		String jminno 	= SecUtil.sqlFilter(request.getParameter("txt_jminno"));
		
		String sDomain = request.getParameter("domain");
		String qry ="";
		String qry2 ="";
		String v_empnm="";
		//System.out.println("111==");
		//System.out.println("empid=="+empid);
		//System.out.println("jminno=="+jminno);
		
		
		Connection conn = null;
		ResultSet rs    = null;
		int result = 0;
		
		try{
			conn = DBConnection.getConnection(); 
			qry ="{call COMMON.PR_CM110I_01(?,?,?,?,?,   ?,?,?,?,?) }";
			
			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, empid);		//pempid			VARCHAR(10),		-- 1���,
			//StringUtil.printMsg("1", empid, this);	
			cstmt.setString	(2, "");	//pBMILNO			VARCHAR(32),		-- 2���,
			//StringUtil.printMsg("2", "", this);	
			cstmt.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3����,
			//StringUtil.printMsg("3", empnm, this);	
			cstmt.setString	(4, jminno);	//pJMINNO			VARCHAR(13),		-- 4�ֹι�ȣ(INOUT)  
			//StringUtil.printMsg("4", jminno, this);	
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");	//pSSID			VARCHAR(24),		-- 5����id(INOUT)  
			//StringUtil.printMsg("5", "", this);	
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "2");		//pEDITSTATUS		VARCHAR(1),	-- 6�۾����� 1=�α�, 2=����Ȯ��, 3=��� �缳��
			//StringUtil.printMsg("6", "2���۾�", this);	
			cstmt.setString	(7, "c2");	//pSEND_ID		VARCHAR(3),       	-- 7���ν��� ȣ�� 
			//StringUtil.printMsg("7", "����� �شٴ�!���", this);	
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//�������� : �̰� ����� �ȳѾ�� ����..
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//�޼���
					
			cstmt.executeUpdate();

			if(cstmt.getString(8).equals("Y")){	// ��������
				/* session ���� */ 
				HttpSession session = request.getSession();
				String sessionid = session.getId();
				// ���� ���̺� ���� �����ϱ�.
				StringUtil.printMsg("ssID:::", sessionid, this);
				
				qry2 = "{call COMMON.PR_CM110I_01(?,?,?,?,?,   ?,?,?,?,?) }";
				
				//���Ǳ��� �����ؼ� �Ķ���� 10���� �����!!
				
				cstmt2 = conn.prepareCall(qry2);
				cstmt2.setString (1, empid);		//pempid			VARCHAR(10),		-- 1���,
				//StringUtil.printMsg("1", empid, this);	
				cstmt2.setString	(2, "");	//pBMILNO			VARCHAR(32),		-- 2���,
				//StringUtil.printMsg("2", "", this);	
				cstmt2.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3����,
				//StringUtil.printMsg("3", empnm, this);	
				cstmt2.setString	(4, jminno);	//pJMINNO			VARCHAR(13),		-- 4�ֹι�ȣ(INOUT)  
				//StringUtil.printMsg("4", jminno, this);	
				cstmt2.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt2.setString	(5, sessionid);	//pSSID			VARCHAR(24),		-- 5����id(INOUT)  
				//StringUtil.printMsg("5", sessionid, this);	
				cstmt2.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt2.setString	(6, "4");		//pEDITSTATUS		VARCHAR(1),       	-- 6�۾����� 1=�α�, 2=����Ȯ��, 3=��� �缳��, 4=����
				//StringUtil.printMsg("6", "4���۾�", this);	
				cstmt2.setString	(7, "c4");	//pSEND_ID		VARCHAR(3),       	-- 7���ν��� ȣ�� 
				//StringUtil.printMsg("7", "�����϶� ����", this);	
				cstmt2.registerOutParameter(8, java.sql.Types.VARCHAR);	//�������� : �̰� ����� �ȳѾ�� ����..
				cstmt2.registerOutParameter(9, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
				cstmt2.registerOutParameter(10, java.sql.Types.VARCHAR);	//�޼���
					
				cstmt2.executeUpdate();
				if(cstmt2.getString(8).equals("Y")){	// ��������
					result = 537;
				}
			}else{
				result = -1;				
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
	
	

	/**
	 * ��й�ȣ ����
	 */
	public int SetFPwd(HttpServletRequest request, HttpServletResponse response) {

		CallableStatement cstmt = null;
		
		String pwd1 		= SecUtil.sqlFilter(StringUtil.encoding(request.getParameter("txt_pwd1")));
		String pwd2 		= SecUtil.sqlFilter(request.getParameter("txt_pwd2"));
		String empid		= SecUtil.sqlFilter(request.getParameter("SEmpId"));
		String aed			= SecUtil.sqlFilter(request.getParameter("txt_aed"));
		//String aed 		= "";
		String jminno 	= "";
		String empnm 	= "";
		String sDomain = request.getParameter("domain");
		String qry ="";
		String ECqry ="";
		String v_empnm="";
		//System.out.println("111==");
		//System.out.println("aed=="+aed);
		//System.out.println("empid=="+empid);
		//System.out.println("pwd1=="+pwd1);
		//System.out.println("pwd2=="+pwd2);
		//System.out.println("empnm=="+empnm);
		//String empid_digit1 = empid.substring(0,1);//��� ù°�ڸ� �� 
		//System.out.println("empid_digit1=="+empid_digit1);
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs    = null;
		int result = 0;
	
		try{
			conn = DBConnection.getConnection(); 
			qry ="{call COMMON.PR_CM110I_02(?,?,?,?,?,   ?,?,?,?,?) }"; 

			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, empid);		//pAED			VARCHAR(10),		-- 1���,
			//StringUtil.printMsg("1", empid, this);	
			cstmt.setString	(2, pwd1);	//pBMILNO			VARCHAR(32),		-- 2���,
			//StringUtil.printMsg("2", pwd1, this);	
			cstmt.setString (3, aed);	//pEMPNM			VARCHAR(24),		-- 3���̵�,
			//StringUtil.printMsg("3", aed, this);	
			cstmt.setString	(4, jminno);	//pJMINNO			VARCHAR(13),		-- 4�ֹι�ȣ(INOUT)  
			//StringUtil.printMsg("4", jminno, this);	
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");	//pSSID			VARCHAR(24),		-- 5����id(INOUT)  
			//StringUtil.printMsg("5", "", this);	
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "3");		//pEDITSTATUS		VARCHAR(1),	-- 6�۾����� 1=�α�, 2=����Ȯ��, 3=��� �缳��
			//StringUtil.printMsg("6", "3���۾�", this);	
			cstmt.setString	(7, "c3");	//pSEND_ID		VARCHAR(3),       	-- 7���ν��� ȣ�� 
			//StringUtil.printMsg("7", "����� �شٴ�!���", this);	
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//�������� : �̰� ����� �ȳѾ�� ����..
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//�޼���
		
			cstmt.executeUpdate();
			
			if(cstmt.getString(8).equals("Y")){	// ��������
				result = 537;
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
	 * ����Ȯ��
	 */
	public String FSsn(HttpServletRequest request, HttpServletResponse response) {
		CallableStatement cstmt = null;
		//String aed 		= SecUtil.sqlFilter(request.getParameter("aed"));
		String empid	 			= request.getParameter("SEmpId");
		String qry ="";
		System.out.println("empid=="+empid);
		Connection conn = null;
		ResultSet rs    = null;
		String result = "e";
		
		try{
			conn = DBConnection.getConnection();
			qry ="{call COMMON.PR_CM110I_01(?,?,?,?,?,   ?,?,?,?,?) }";
			
			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, empid);
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


	/**
	 * ȸ��  �α׾ƿ�
	 */
	public void Logout(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("***** Member Logout *****");

		HttpSession session = request.getSession();
		session.invalidate();
        
		//Cookie ����
		Cookie[] cookies = request.getCookies();
		if ((cookies != null) && (cookies.length > 0)) {
			for(int i=0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
				if (thisCookie.getName().equals("vcurdate") || thisCookie.getName().equals("vautlevel") || thisCookie.getName().equals("vdeptcd") || thisCookie.getName().equals("vdeptnm") || thisCookie.getName().equals("vfdcode") || thisCookie.getName().equals("vfdname") || thisCookie.getName().equals("vcocode") || thisCookie.getName().equals("vconame") || thisCookie.getName().equals("vjobdty") ) {
					thisCookie.setMaxAge(0);
					thisCookie.setPath("/");
					response.addCookie(thisCookie); 
				}
			}
		}
	} 
    
	/**
	 * Cookie set
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
/*	public static void SetCookie (String name, String value){
	// ��Ű ������ ���ڿ��� ����� �ݴϴ�.
		var argv = SetCookie.arguments
		var argc = SetCookie.arguments.length
		
		var expires = (2 < argc) ? argv[2] : null
		var path =    (3 < argc) ? argv[3] : null
		var domain = (4 < argc) ? argv[4] : null
		var secure = (5 < argc) ? argv[5] : false
         
		document.cookie = name + "=" + escape (value) +
		((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
		((path == null) ? "" : ("; path=" + path)) +
		((domain == null) ? "" : ("; domain=" + domain)) +
		((secure == true) ? ";secure" : "")
	}
*/
	
	
	
	
}
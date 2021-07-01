package common.sys;
/*
 * [ �������� ][������] ����   
 * [2011-06-13][�ɵ���] ���Ȱ�ȭ�� ���� request �Ķ��Ÿ �޴� �κ� SQL ������ ���� ��ƿ �߰�
 *                      SecUtil.sqlFilter(�Ķ����)
 * 
 * */
 
import java.sql.*;

import javax.naming.*;
import javax.servlet.http.*;
import javax.sql.DataSource;



import sales.common.StringUtil;

import com.hdasan.arive.util.UtilDB;	// �̰� �ϴ� �÷�������..��.. -_-;
import com.hdasan.arive.util.SecUtil;	// 2011-06-13 �ɵ��� ������ƿ~ ������ó

//import sales.org.application.common.CommonManager;
import common.sys.KISA_SHA256;  //2015-04-15 KISA ��ȣȭ  test by ������

//���� ������ �ٲ�� �ڴ�. 
// 1 �н����� üũ
// 2 ���� ���� ������ CM100I_02


public class HdasanLogin {


	
	/**
	 * ȸ�� �α��� üũ array
	 */
	public String[] LoginA(HttpServletRequest request, HttpServletResponse response) {
		Connection conn = null;
		CallableStatement cstmt = null;
		CallableStatement cstmt2 = null;
		String aed 				= SecUtil.sqlFilter(request.getParameter("txt_id"));

		//20150512 �ɵ���, test by JYS----------------------------------------------------------------
		byte pbData[]   = new byte[0];      //������Է� ��
		byte pbCipher[] = new byte[32];     //��ȣ��
		int Plaintext_length=0;  //�򹮱��� 
		String strEncryptPW="";  //��ȣ��
		StringBuffer sb = new StringBuffer();
		String strEncodePW = "";             //��ȣ���� ���ڵ� �� ����

		String pwd 				= SecUtil.sqlFilter(request.getParameter("txt_pass"));
		pbData =  pwd.getBytes();
		Plaintext_length = pwd.length();
							
	    //param///////////////////////////////////////////////////////
		//pbData : ��
		//Plaintext_length : �򹮱���
		//pbCipher : ��ȣ��
		//////////////////////////////////////////////////////////////
	    KISA_SHA256.SHA256_Encrpyt(pbData, Plaintext_length, pbCipher);
		
		 sb = new StringBuffer(); 
		 for(int j = 0 ; j < pbCipher.length ; j++){
                sb.append(Integer.toString((pbCipher[j]&0xff) + 0x100, 16).substring(1));
          }
		 //��ȣ�� 
		strEncryptPW = sb.toString();
		//System.out.println("strEncryptPW::"+strEncryptPW+"::::");
        //------------------------------------------------------------------------------------
		
		String remotePosition 	= SecUtil.sqlFilter(request.getParameter("remotePosition")); 
		
		String qry 		= "";
		String qry2 	= "";
				

		PreparedStatement pstmt = null;
		ResultSet rs    = null;
		String[] results = new String[4];

	
		try{
	        //JNDI connection ȣ�� : import javax.naming.*; �ʿ�
	        Context initContext = (Context) new InitialContext();
	    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
	    	conn = ds.getConnection();
	        //JNDI connection ȣ��		
			
			qry ="{call COMMON.PR_CM100I_01(?,?,?,?,?,   ?,?,?,?,?) }";	
			
			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, aed);	//pAED			VARCHAR(10),		-- 1���̵�,
			cstmt.setString	(2, strEncryptPW);	//pBMILNO			VARCHAR(32),		-- 2���,	
			cstmt.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3����,
			cstmt.setString	(4, "");	//pJMINNO			VARCHAR(13),		-- 4�ֹι�ȣ(INOUT)  
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");	//pSSID			VARCHAR(24),		-- 5����id(INOUT)  1�� �۾��ÿ� ��� ����~!
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "1");		//pEDITSTATUS		VARCHAR(1),	-- 6�۾����� 1=�α�, 2=����Ȯ��, 3=��� �缳��
			cstmt.setString	(7, "c1");	//pSEND_ID		VARCHAR(3),       	-- 7���ν��� ȣ�� 
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//�������� : �̰� ����� �ȳѾ�� ����..
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//�޼���
					
			cstmt.executeUpdate();
			//StringUtil.printMsg("�α� ���ν��� ���?", cstmt.getString(8), this);
			//StringUtil.printMsg("����4", cstmt.getString(4), this);
			//StringUtil.printMsg("����5", cstmt.getString(5), this);
			
			if(cstmt.getString(8).equals("Y")){	// ��������
				results[0] = "1";
				results[1] = "����ó��(i)";
				results[2] = cstmt.getString(5);	//����
				results[3] = cstmt.getString(4);	//�ֹ�
				
				if( remotePosition.equals("true") ) {	//���
					//���� �����, �����ϰ�  ������������
					HttpSession session = request.getSession();
					String sessionid = session.getId();
						
					qry2 = "{call COMMON.PR_CM100I_01(?,?,?,?,?,   ?,?,?,?,?) }";

					//���Ǳ��� �����ؼ� �Ķ���� 10���� �����!!
					cstmt2 = conn.prepareCall(qry2);
					cstmt2.setString (1, aed);		//pAED			VARCHAR(10),		-- 1���̵�,
					//StringUtil.printMsg("1", aed, this);	
					cstmt2.setString	(2, "");	//pBMILNO			VARCHAR(32),		-- 2���,
					//StringUtil.printMsg("2", "", this);	
					cstmt2.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3����,
					//StringUtil.printMsg("3", empnm, this);	
					cstmt2.setString	(4, "");	//pJMINNO			VARCHAR(13),		-- 4�ֹι�ȣ(INOUT)  
					//StringUtil.printMsg("4", jminno, this);	
					cstmt2.registerOutParameter(4, java.sql.Types.VARCHAR);
					cstmt2.setString	(5, sessionid);	//pSSID			VARCHAR(24),		-- 5����id(INOUT)
					System.out.println( "HdasanLogin ====== " + sessionid +"��");
					StringUtil.printMsg("5", sessionid, this);	
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
						results[0] = "537";
						results[1] = "����ó��(o)";
						results[2] = cstmt.getString(5);	//����
						results[3] = cstmt.getString(4);	//�ֹ�
					}
											
				}//remotePosition.equals("true") ) {	//���
			}else{
				results[0] = "10";
				results[1] = "�ش� ���̵��� ���������� ã�� �� �����ϴ�.(10)";	//���̵� ��ȸ �ȵǴ� ���
				results[2] = "";
				results[3] = "";
			}//if(cstmt.getString(8).equals("Y")){

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception during connection :"+e.getMessage());
			//���� ó�� : ��ȣ�� Ʋ���� SQL���� ������ ���� 15
			results[0] = "15";
			results[1] = "�ش� ���̵��� ���������� ã�� �� �����ϴ�.(15)";
			results[2] = "";
			results[3] = "";
		} finally {
			UtilDB.closeConnection(conn, pstmt, rs);
		}

		return results;

	}

	/**
	 * ȸ�� ���� ��ȸ �� ����
	 */
	public String[] setInfo(HttpServletRequest request, HttpServletResponse response, String aed) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs    = null;
		
		String qry 		= "";
		String[] results = new String[4];
		


		try{
	        //JNDI connection ȣ�� : import javax.naming.*; �ʿ�
	        Context initContext = (Context) new InitialContext();
	    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
	    	conn = ds.getConnection();
	        //JNDI connection ȣ��		
		
			
			qry = "SELECT * FROM (	"
				+ "	 SELECT TRIM(B.EMPNO) AS USERID, B.EMPNMK AS USERNAME, "
				+ "	        TO_CHAR(CURRENT_DATE,'YYYY-MM-DD') as toDATE,	"
				+ "	       B.DEPTCD, RTRIM(C.DEPTNM)DEPTNM, C.FDCODE, RTRIM(D.FDNAME)FDNAME, C.COCODE, RTRIM(E.CONAME)CONAME, B.JOBDTY	"
				+ "	FROM        PAYROLL.HIPERSON B  "
				+ "	  LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD	"
				+ "	  LEFT JOIN ACCOUNT.FIELDCODE D ON C.FDCODE = D.FDCODE	"
				+ "	  LEFT JOIN ACCOUNT.COMPANY E ON C.COCODE = E.COCODE	"
				+ "	UNION ALL	"
				+ "	 SELECT TRIM(B.EMPNO) AS USERID, B.EMPNMK AS USERNAME, "
				+ "	        TO_CHAR(CURRENT_DATE,'YYYY-MM-DD') as toDATE,	"
				+ "	        B.DEPTCD, RTRIM(C.DEPTNM)DEPTNM, C.FDCODE, RTRIM(D.FDNAME)FDNAME, C.COCODE, RTRIM(E.CONAME)CONAME, B.JOBDTY	"
				+ "	 FROM        PAYROLL.T_HIPERSON B 	"
				+ "	   LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD	"
				+ "	   LEFT JOIN ACCOUNT.FIELDCODE D ON C.FDCODE = D.FDCODE	"
				+ "	   LEFT JOIN ACCOUNT.COMPANY E ON C.COCODE = E.COCODE ) X	"
				+ "WHERE X.USERID  = (select empid from common.gd0080 where aed= ? )	";
			
			pstmt = conn.prepareStatement(qry);
			pstmt.setString(1, aed);
			rs = pstmt.executeQuery();
					
			
			
	
			
			
			if( rs.next() ) {
				
				/* 2018.4.4 mobile ������ ���� �Ǵ� �� ó���̶� �����ְ��� */ 
				String userAgent = request.getHeader("User-Agent");
				
				System.out.println( "userAgent :::::: " + userAgent +"::" );				
			
				boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
				
				if ( ie )
				{
					
					results[2] = "pc";
				
				}else
				{
					
					results[2] = "mobile";
				}		
				
				
				//���� ��ȸ�ϸ� (��/�� ����)
				results[0] = "10";
				results[1] = "������";
				//results[2] = "";
				results[3] = "";
						
				/* session ���� */ 
				HttpSession session = request.getSession();
				/* ������ �����ϰ� ����*/					
				session.setAttribute("vusrid", rs.getString("USERID") );
				
				//session.setAttribute("vusrip", request.getHeader("Proxy-Client-IP") ); // ������
				session.setAttribute("vusrip", request.getRemoteAddr() ); // ����
				session.setAttribute("vusrnm", rs.getString("USERNAME") );
				session.setAttribute("vusrpos", "Tadaima" );	//�α� ���� ��~!
				session.setAttribute("vediusr", "") ; 			//", rs.getString("EDIUSR") );
				session.setAttribute("vusraed", aed );
						
				//���������� �ϴ� ��Ű���� �־����. 
				session.setAttribute("vcurdate", rs.getString("toDATE") );
				session.setAttribute("vautlevel","" );
				session.setAttribute("vdeptcd", rs.getString("DEPTCD") );
				session.setAttribute("vdeptnm", rs.getString("DEPTNM") );
				session.setAttribute("vfdcode", rs.getString("FDCODE") );
				session.setAttribute("vfdname", rs.getString("FDNAME") );
				session.setAttribute("vcocode", rs.getString("COCODE") );
				session.setAttribute("vconame", rs.getString("CONAME") );
				session.setAttribute("vjobdty", rs.getString("JOBDTY") );
	
				/* ��Ű�� ���� ����  */
				setCookie(response, "vcurdate", rs.getString("toDATE"), null , -1);
				setCookie(response, "vautlevel", "" , null , -1);
				setCookie(response, "vdeptcd", rs.getString("DEPTCD"), null , -1);
				setCookie(response, "vdeptnm", rs.getString("DEPTNM"), null , -1);
				setCookie(response, "vfdcode", rs.getString("FDCODE"), null , -1);
				setCookie(response, "vfdname", rs.getString("FDNAME"), null , -1);
				setCookie(response, "vcocode", rs.getString("COCODE"), null , -1);
				setCookie(response, "vconame", rs.getString("CONAME"), null , -1);
				setCookie(response, "vjobdty", rs.getString("JOBDTY"), null , -1);
						
			} else { 
				// ���̵�� ������ �λ����� ��ȸ ����
				results[0] = "20";
				results[1] = "���̵� ���ų� �ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�.(20)";
				results[2] = "";
				results[3] = "";
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception during connection :"+e.getMessage());
		} finally {
			UtilDB.closeConnection(conn, pstmt, rs);
		}

		return results;
		
		
		
		
		
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
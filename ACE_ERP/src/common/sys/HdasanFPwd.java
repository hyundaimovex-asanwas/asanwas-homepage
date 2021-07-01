package common.sys;
/*
 * [ 수정일자 ][수정자] 내용   
 * [2011-06-13][심동현] 보안강화를 위한 request 파라미타 받는 부분 SQL 인젝션 방지 유틸 추가
 *                      SecUtil.sqlFilter(파라미터)
 * 
 * */
import java.sql.*;
import java.net.*;
import javax.servlet.http.*;
import sales.common.StringUtil;

import com.hdasan.arive.util.UtilDB;	// 이건 일단 올려놓았음..음.. -_-;
import com.hdasan.arive.util.SecUtil;	// 2011-06-13 심동현 보안유틸~ 인젝션처
//import sales.org.application.common.CommonManager;
import sales.org.common.db.DBConnection;		// 2011-06-02 심동현 여기서 커넥션 설정을 합니다.


public class HdasanFPwd {

	/**
	 * 회원 정보
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
			cstmt.setString (1, empid);		//pempid			VARCHAR(10),		-- 1사번,
			//StringUtil.printMsg("1", empid, this);	
			cstmt.setString	(2, "");	//pBMILNO			VARCHAR(32),		-- 2비번,
			//StringUtil.printMsg("2", "", this);	
			cstmt.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3성명,
			//StringUtil.printMsg("3", empnm, this);	
			cstmt.setString	(4, jminno);	//pJMINNO			VARCHAR(13),		-- 4주민번호(INOUT)  
			//StringUtil.printMsg("4", jminno, this);	
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");	//pSSID			VARCHAR(24),		-- 5세션id(INOUT)  
			//StringUtil.printMsg("5", "", this);	
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "2");		//pEDITSTATUS		VARCHAR(1),	-- 6작업구분 1=로긴, 2=계정확인, 3=비번 재설정
			//StringUtil.printMsg("6", "2번작업", this);	
			cstmt.setString	(7, "c2");	//pSEND_ID		VARCHAR(3),       	-- 7프로시저 호출 
			//StringUtil.printMsg("7", "비번을 잊다니!밥붕", this);	
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//성공여부 : 이게 제대로 안넘어온 듯한..
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//메세지 코드
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//메세지
					
			cstmt.executeUpdate();

			if(cstmt.getString(8).equals("Y")){	// 성공여부
				/* session 생성 */ 
				HttpSession session = request.getSession();
				String sessionid = session.getId();
				// 계정 테이블에 세션 저장하기.
				StringUtil.printMsg("ssID:::", sessionid, this);
				
				qry2 = "{call COMMON.PR_CM110I_01(?,?,?,?,?,   ?,?,?,?,?) }";
				
				//세션까지 포함해서 파라미터 10개로 만들기!!
				
				cstmt2 = conn.prepareCall(qry2);
				cstmt2.setString (1, empid);		//pempid			VARCHAR(10),		-- 1사번,
				//StringUtil.printMsg("1", empid, this);	
				cstmt2.setString	(2, "");	//pBMILNO			VARCHAR(32),		-- 2비번,
				//StringUtil.printMsg("2", "", this);	
				cstmt2.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3성명,
				//StringUtil.printMsg("3", empnm, this);	
				cstmt2.setString	(4, jminno);	//pJMINNO			VARCHAR(13),		-- 4주민번호(INOUT)  
				//StringUtil.printMsg("4", jminno, this);	
				cstmt2.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt2.setString	(5, sessionid);	//pSSID			VARCHAR(24),		-- 5세션id(INOUT)  
				//StringUtil.printMsg("5", sessionid, this);	
				cstmt2.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt2.setString	(6, "4");		//pEDITSTATUS		VARCHAR(1),       	-- 6작업구분 1=로긴, 2=계정확인, 3=비번 재설정, 4=세션
				//StringUtil.printMsg("6", "4번작업", this);	
				cstmt2.setString	(7, "c4");	//pSEND_ID		VARCHAR(3),       	-- 7프로시저 호출 
				//StringUtil.printMsg("7", "저장하라 세숑", this);	
				cstmt2.registerOutParameter(8, java.sql.Types.VARCHAR);	//성공여부 : 이게 제대로 안넘어온 듯한..
				cstmt2.registerOutParameter(9, java.sql.Types.VARCHAR);	//메세지 코드
				cstmt2.registerOutParameter(10, java.sql.Types.VARCHAR);	//메세지
					
				cstmt2.executeUpdate();
				if(cstmt2.getString(8).equals("Y")){	// 성공여부
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
	 * 비밀번호 설정
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
		//String empid_digit1 = empid.substring(0,1);//사번 첫째자리 수 
		//System.out.println("empid_digit1=="+empid_digit1);
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs    = null;
		int result = 0;
	
		try{
			conn = DBConnection.getConnection(); 
			qry ="{call COMMON.PR_CM110I_02(?,?,?,?,?,   ?,?,?,?,?) }"; 

			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, empid);		//pAED			VARCHAR(10),		-- 1사번,
			//StringUtil.printMsg("1", empid, this);	
			cstmt.setString	(2, pwd1);	//pBMILNO			VARCHAR(32),		-- 2비번,
			//StringUtil.printMsg("2", pwd1, this);	
			cstmt.setString (3, aed);	//pEMPNM			VARCHAR(24),		-- 3아이디,
			//StringUtil.printMsg("3", aed, this);	
			cstmt.setString	(4, jminno);	//pJMINNO			VARCHAR(13),		-- 4주민번호(INOUT)  
			//StringUtil.printMsg("4", jminno, this);	
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");	//pSSID			VARCHAR(24),		-- 5세션id(INOUT)  
			//StringUtil.printMsg("5", "", this);	
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "3");		//pEDITSTATUS		VARCHAR(1),	-- 6작업구분 1=로긴, 2=계정확인, 3=비번 재설정
			//StringUtil.printMsg("6", "3번작업", this);	
			cstmt.setString	(7, "c3");	//pSEND_ID		VARCHAR(3),       	-- 7프로시저 호출 
			//StringUtil.printMsg("7", "비번을 잊다니!밥붕", this);	
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//성공여부 : 이게 제대로 안넘어온 듯한..
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//메세지 코드
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//메세지
		
			cstmt.executeUpdate();
			
			if(cstmt.getString(8).equals("Y")){	// 성공여부
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
	 * 세션확인
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


	/**
	 * 회원  로그아웃
	 */
	public void Logout(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("***** Member Logout *****");

		HttpSession session = request.getSession();
		session.invalidate();
        
		//Cookie 삭제
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
	// 쿠키 형식의 문자열을 만들어 줍니다.
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
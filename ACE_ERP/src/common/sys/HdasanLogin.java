package common.sys;
/*
 * [ 수정일자 ][수정자] 내용   
 * [2011-06-13][심동현] 보안강화를 위한 request 파라미타 받는 부분 SQL 인젝션 방지 유틸 추가
 *                      SecUtil.sqlFilter(파라미터)
 * 
 * */
 
import java.sql.*;

import javax.naming.*;
import javax.servlet.http.*;
import javax.sql.DataSource;



import sales.common.StringUtil;

import com.hdasan.arive.util.UtilDB;	// 이건 일단 올려놓았음..음.. -_-;
import com.hdasan.arive.util.SecUtil;	// 2011-06-13 심동현 보안유틸~ 인젝션처

//import sales.org.application.common.CommonManager;
import common.sys.KISA_SHA256;  //2015-04-15 KISA 암호화  test by 정영식

//쿼리 순서를 바꿔야 겠다. 
// 1 패스워드 체크
// 2 세부 정보 가져오 CM100I_02


public class HdasanLogin {


	
	/**
	 * 회원 로그인 체크 array
	 */
	public String[] LoginA(HttpServletRequest request, HttpServletResponse response) {
		Connection conn = null;
		CallableStatement cstmt = null;
		CallableStatement cstmt2 = null;
		String aed 				= SecUtil.sqlFilter(request.getParameter("txt_id"));

		//20150512 심동현, test by JYS----------------------------------------------------------------
		byte pbData[]   = new byte[0];      //사용자입력 평문
		byte pbCipher[] = new byte[32];     //암호문
		int Plaintext_length=0;  //평문길이 
		String strEncryptPW="";  //암호문
		StringBuffer sb = new StringBuffer();
		String strEncodePW = "";             //암호문이 인코딩 된 상태

		String pwd 				= SecUtil.sqlFilter(request.getParameter("txt_pass"));
		pbData =  pwd.getBytes();
		Plaintext_length = pwd.length();
							
	    //param///////////////////////////////////////////////////////
		//pbData : 평문
		//Plaintext_length : 평문길이
		//pbCipher : 암호문
		//////////////////////////////////////////////////////////////
	    KISA_SHA256.SHA256_Encrpyt(pbData, Plaintext_length, pbCipher);
		
		 sb = new StringBuffer(); 
		 for(int j = 0 ; j < pbCipher.length ; j++){
                sb.append(Integer.toString((pbCipher[j]&0xff) + 0x100, 16).substring(1));
          }
		 //암호문 
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
	        //JNDI connection 호출 : import javax.naming.*; 필요
	        Context initContext = (Context) new InitialContext();
	    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
	    	conn = ds.getConnection();
	        //JNDI connection 호출		
			
			qry ="{call COMMON.PR_CM100I_01(?,?,?,?,?,   ?,?,?,?,?) }";	
			
			cstmt = conn.prepareCall(qry);
			cstmt.setString (1, aed);	//pAED			VARCHAR(10),		-- 1아이디,
			cstmt.setString	(2, strEncryptPW);	//pBMILNO			VARCHAR(32),		-- 2비번,	
			cstmt.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3성명,
			cstmt.setString	(4, "");	//pJMINNO			VARCHAR(13),		-- 4주민번호(INOUT)  
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.setString	(5, "");	//pSSID			VARCHAR(24),		-- 5세션id(INOUT)  1번 작업시엔 사번 리턴~!
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.setString	(6, "1");		//pEDITSTATUS		VARCHAR(1),	-- 6작업구분 1=로긴, 2=계정확인, 3=비번 재설정
			cstmt.setString	(7, "c1");	//pSEND_ID		VARCHAR(3),       	-- 7프로시저 호출 
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	//성공여부 : 이게 제대로 안넘어온 듯한..
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//메세지 코드
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//메세지
					
			cstmt.executeUpdate();
			//StringUtil.printMsg("로긴 프로시저 결과?", cstmt.getString(8), this);
			//StringUtil.printMsg("리턴4", cstmt.getString(4), this);
			//StringUtil.printMsg("리턴5", cstmt.getString(5), this);
			
			if(cstmt.getString(8).equals("Y")){	// 성공여부
				results[0] = "1";
				results[1] = "정상처리(i)";
				results[2] = cstmt.getString(5);	//구분
				results[3] = cstmt.getString(4);	//주번
				
				if( remotePosition.equals("true") ) {	//사외
					//세션 만들고, 저장하고  본인인증으로
					HttpSession session = request.getSession();
					String sessionid = session.getId();
						
					qry2 = "{call COMMON.PR_CM100I_01(?,?,?,?,?,   ?,?,?,?,?) }";

					//세션까지 포함해서 파라미터 10개로 만들기!!
					cstmt2 = conn.prepareCall(qry2);
					cstmt2.setString (1, aed);		//pAED			VARCHAR(10),		-- 1아이디,
					//StringUtil.printMsg("1", aed, this);	
					cstmt2.setString	(2, "");	//pBMILNO			VARCHAR(32),		-- 2비번,
					//StringUtil.printMsg("2", "", this);	
					cstmt2.setString (3, "");	//pEMPNM			VARCHAR(24),		-- 3성명,
					//StringUtil.printMsg("3", empnm, this);	
					cstmt2.setString	(4, "");	//pJMINNO			VARCHAR(13),		-- 4주민번호(INOUT)  
					//StringUtil.printMsg("4", jminno, this);	
					cstmt2.registerOutParameter(4, java.sql.Types.VARCHAR);
					cstmt2.setString	(5, sessionid);	//pSSID			VARCHAR(24),		-- 5세션id(INOUT)
					System.out.println( "HdasanLogin ====== " + sessionid +"끝");
					StringUtil.printMsg("5", sessionid, this);	
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
						results[0] = "537";
						results[1] = "정상처리(o)";
						results[2] = cstmt.getString(5);	//구분
						results[3] = cstmt.getString(4);	//주번
					}
											
				}//remotePosition.equals("true") ) {	//사외
			}else{
				results[0] = "10";
				results[1] = "해당 아이디의 계정정보를 찾을 수 없습니다.(10)";	//아이디가 조회 안되는 경우
				results[2] = "";
				results[3] = "";
			}//if(cstmt.getString(8).equals("Y")){

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception during connection :"+e.getMessage());
			//예외 처리 : 암호가 틀려서 SQL에서 오류가 나면 15
			results[0] = "15";
			results[1] = "해당 아이디의 계정정보를 찾을 수 없습니다.(15)";
			results[2] = "";
			results[3] = "";
		} finally {
			UtilDB.closeConnection(conn, pstmt, rs);
		}

		return results;

	}

	/**
	 * 회원 정보 조회 및 세팅
	 */
	public String[] setInfo(HttpServletRequest request, HttpServletResponse response, String aed) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs    = null;
		
		String qry 		= "";
		String[] results = new String[4];
		


		try{
	        //JNDI connection 호출 : import javax.naming.*; 필요
	        Context initContext = (Context) new InitialContext();
	    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
	    	conn = ds.getConnection();
	        //JNDI connection 호출		
		
			
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
				
				/* 2018.4.4 mobile 에서도 뭔가 되는 것 처럼이라도 보여주고자 */ 
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
				
				
				//정상 조회하면 (내/외 공용)
				results[0] = "10";
				results[1] = "정상세팅";
				//results[2] = "";
				results[3] = "";
						
				/* session 생성 */ 
				HttpSession session = request.getSession();
				/* 기존과 동일하게 생성*/					
				session.setAttribute("vusrid", rs.getString("USERID") );
				
				//session.setAttribute("vusrip", request.getHeader("Proxy-Client-IP") ); // 서버용
				session.setAttribute("vusrip", request.getRemoteAddr() ); // 로컬
				session.setAttribute("vusrnm", rs.getString("USERNAME") );
				session.setAttribute("vusrpos", "Tadaima" );	//로긴 상태 값~!
				session.setAttribute("vediusr", "") ; 			//", rs.getString("EDIUSR") );
				session.setAttribute("vusraed", aed );
						
				//이하정보는 일단 쿠키에도 넣어두자. 
				session.setAttribute("vcurdate", rs.getString("toDATE") );
				session.setAttribute("vautlevel","" );
				session.setAttribute("vdeptcd", rs.getString("DEPTCD") );
				session.setAttribute("vdeptnm", rs.getString("DEPTNM") );
				session.setAttribute("vfdcode", rs.getString("FDCODE") );
				session.setAttribute("vfdname", rs.getString("FDNAME") );
				session.setAttribute("vcocode", rs.getString("COCODE") );
				session.setAttribute("vconame", rs.getString("CONAME") );
				session.setAttribute("vjobdty", rs.getString("JOBDTY") );
	
				/* 쿠키도 같이 쓰기  */
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
				// 아이디는 있으나 인사정보 조회 실패
				results[0] = "20";
				results[1] = "아이디가 없거나 필요한 값이 정상적으로 입력되지 않았습니다.(20)";
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
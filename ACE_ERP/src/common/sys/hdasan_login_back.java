package common.sys;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.net.*;
import javax.servlet.http.*;
import com.hmm.ejb.common.UtilDB;// 이건 일단 올려놓았음..음.. -_-;
import sales.org.application.common.CommonManager;

import sales.org.common.db.DBConnection;		// 2011-06-02 심동현 여기서 커넥션 설정을 합니다.
import com.hdasan.util.SecUtil;					// 2011-06-13 심동현 보안유틸~ 인젝션처
//쿼리 순서를 바꿔야 겠다. 
// 1 패스워드 체크
// 2 세부 정보 가져오

public class hdasan_login_back {

	/**
	 * 회원 로그인
	 */
	public int Login(HttpServletRequest request, HttpServletResponse response) {

		String id 	= SecUtil.sqlFilter(request.getParameter("txt_id"));
		String pwd 	= SecUtil.sqlFilter(request.getParameter("txt_pass"));
		String sDomain = request.getParameter("domain");
		String query ="";
		String id_digit1 = id.substring(1,1);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs    = null;
		int result = 0;
		try{
			conn = DBConnection.getConnection(); 

			//탈퇴 회원 은 로그인 할수없다.
			/*pstmt = conn.prepareStatement("select * from asan.member where id = ? and (level = '0' OR level = '2') and (case when isdel = 'y' then 0 else 1 end) = 1 ");
			pstmt.setString(1, id);
			rs   = pstmt.executeQuery();

			if( rs.next() ) {*/
				//해당 아이디가 있을 경우


				if(id_digit1.equals("1")||id_digit1.equals("2")){ //정규직
					query = " SELECT A.USERID||'a' as userid , A.PASSWORD, A.USERNAME, A.AUTLEVEL, A.IPADDR, A.STRSYS, A.STRDATE, "
								+ "        A.ENDDATE, A.REGMAN, A.REGDATE, A.MODMAN, A.MODDATE,'' AS PCIPADR, SUBSTRING(CHAR(current timestamp),1,10) as toDATE,"
								+ "        B.DEPTCD, RTRIM(C.DEPTNM)DEPTNM, C.FDCODE, RTRIM(D.FDNAME)FDNAME, C.COCODE, RTRIM(E.CONAME)CONAME, B.JOBDTY"
								+ " FROM COMMON.USERFILE A  "
								+ "   LEFT JOIN PAYROLL.HIPERSON B ON A.USERID =  B.EMPNO"
								+ "   LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD"
								+ "   LEFT JOIN ACCOUNT.FIELDCODE D ON C.FDCODE = D.FDCODE"
								+ "   LEFT JOIN ACCOUNT.COMPANY E ON C.COCODE = E.COCODE"
								+ " WHERE A.USERID  = ? AND A.PASSWORD = ? ";
				}else{				//계약직
					query = " SELECT A.USERID||'a' as userid, A.PASSWORD, A.USERNAME, A.AUTLEVEL, A.IPADDR, A.STRSYS, A.STRDATE, "
								+ "        A.ENDDATE, A.REGMAN, A.REGDATE, A.MODMAN, A.MODDATE,'' AS PCIPADR, CHAR(CURDATE()) as toDATE,"
								+ "        B.DEPTCD, RTRIM(C.DEPTNM)DEPTNM, C.FDCODE, RTRIM(D.FDNAME)FDNAME, C.COCODE, RTRIM(E.CONAME)CONAME, B.JOBDTY"
								+ " FROM COMMON.USERFILE A  "
								+ "   LEFT JOIN PAYROLL.T_HIPERSON B ON A.USERID =  B.EMPNO"
								+ "   LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD"
								+ "   LEFT JOIN ACCOUNT.FIELDCODE D ON C.FDCODE = D.FDCODE"
								+ "   LEFT JOIN ACCOUNT.COMPANY E ON C.COCODE = E.COCODE"
								+ " WHERE A.USERID  = ? AND A.PASSWORD = ? ";
				}

				pstmt = conn.prepareStatement(query);
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
					
					/* 기존과 동일하게 생성*/					
					session.setAttribute("vusrid", rs.getString("USERID") );
					session.setAttribute("vusrip", request.getRemoteAddr() );
					session.setAttribute("vusrnm", rs.getString("USERNAME") );
					session.setAttribute("vusrpos", "Tadaima" );	//로긴 상태 값~!
					session.setAttribute("vediusr", "") ; 						//", rs.getString("EDIUSR") );
					//session.setAttribute("vsecurity", rs.getString("SECURITY") );
					
					//이하정보는 일단 쿠키에도 넣어두자. 
					session.setAttribute("vcurdate", rs.getString("toDATE") );
					session.setAttribute("vautlevel", rs.getString("AUTLEVEL") );
					session.setAttribute("vdeptcd", rs.getString("DEPTCD") );
					session.setAttribute("vdeptnm", rs.getString("DEPTNM") );
					session.setAttribute("vfdcode", rs.getString("FDCODE") );
					session.setAttribute("vfdname", rs.getString("FDNAME") );
					session.setAttribute("vcocode", rs.getString("COCODE") );
					session.setAttribute("vconame", rs.getString("CONAME") );
					session.setAttribute("vjobdty", rs.getString("JOBDTY") );

					System.out.println("login_java1=="+rs.getString("USERID"));
					System.out.println("login_java2=="+rs.getString("toDATE"));
						/* 쿠키도 같이 쓰기  */
					String sessionid = session.getId();
					//System.out.println("login_java=="+sessionid);
					//response.setHeader("SET-COOKIE", "JSESSIONID=" + sessionid + "; HttpOnly");
						//헐.. 이걸 세팅해 버리면 세션id를 새로 받네유..-_-

					setCookie(response, "vcurdate", rs.getString("toDATE"), null , -1);
					setCookie(response, "vautlevel", rs.getString("AUTLEVEL"), null , -1);
					setCookie(response, "vdeptcd", rs.getString("DEPTCD"), null , -1);
					setCookie(response, "vdeptnm", rs.getString("DEPTNM"), null , -1);
					setCookie(response, "vfdcode", rs.getString("FDCODE"), null , -1);
					setCookie(response, "vfdname", rs.getString("FDNAME"), null , -1);
					setCookie(response, "vcocode", rs.getString("COCODE"), null , -1);
					setCookie(response, "vconame", rs.getString("CONAME"), null , -1);
					setCookie(response, "vjobdty", rs.getString("JOBDTY"), null , -1);

					
					
					
					
					
					
				} else { 
					/**
					 * 패스워드 틀렸을 경우
					 */
					result = -1;
				}
				
				
				
			/*} else {*/
				/**
				 * 해당 아이디가 없을 경우
				 */
				/*result = 0;
			}*/
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
		Cookie[] cookies = request.getCookies();
		if ((cookies != null) && (cookies.length > 0)) {
			for(int i=0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
				if (thisCookie.getName().equals("id") || thisCookie.getName().equals("name") || thisCookie.getName().equals("email") || thisCookie.getName().equals("tel") || thisCookie.getName().equals("isfrom") || thisCookie.getName().equals("client_sid")) {
					thisCookie.setMaxAge(0);
					thisCookie.setPath("/");
					response.addCookie(thisCookie); 
				}
			}
		}
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




/* 
				dSet.addDataColumn(new GauceDataColumn("userid", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("password", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("username", GauceDataColumn.TB_STRING, 30));
				dSet.addDataColumn(new GauceDataColumn("autlevel", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("ipaddr", GauceDataColumn.TB_STRING, 15));
				dSet.addDataColumn(new GauceDataColumn("strsys", GauceDataColumn.TB_STRING, 3));
				dSet.addDataColumn(new GauceDataColumn("strdate", GauceDataColumn.TB_STRING, 8));
				dSet.addDataColumn(new GauceDataColumn("enddate", GauceDataColumn.TB_STRING, 8));
				dSet.addDataColumn(new GauceDataColumn("regman", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("regdate", GauceDataColumn.TB_STRING, 8));
 				dSet.addDataColumn(new GauceDataColumn("modman", GauceDataColumn.TB_STRING, 10));
 				dSet.addDataColumn(new GauceDataColumn("moddate", GauceDataColumn.TB_STRING, 8));
 				dSet.addDataColumn(new GauceDataColumn("pcipadr", GauceDataColumn.TB_STRING, 15));
				dSet.addDataColumn(new GauceDataColumn("curdate", GauceDataColumn.TB_STRING, 10));

				dSet.addDataColumn(new GauceDataColumn("DEPTCD", GauceDataColumn.TB_STRING, 4));
				dSet.addDataColumn(new GauceDataColumn("DEPTNM", GauceDataColumn.TB_STRING, 70));
 				dSet.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING, 2));
 				dSet.addDataColumn(new GauceDataColumn("FDNAME", GauceDataColumn.TB_STRING, 20));
 				dSet.addDataColumn(new GauceDataColumn("COCODE", GauceDataColumn.TB_STRING, 2));
				dSet.addDataColumn(new GauceDataColumn("CONAME", GauceDataColumn.TB_STRING, 20));
				dSet.addDataColumn(new GauceDataColumn("JOBDTY", GauceDataColumn.TB_STRING, 4));

		    if (!GauceReq.isBuilderRequest()) {		


				  }
*/

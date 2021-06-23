<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.12
  - 저작권 표시: IMJ Korea
  - 설명: 로그인 처리

  - 2009-10-14 심동현
  - 로긴 인증 우회 방지 처리 (인젝션)
--%>

<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%
	String url = request.getParameter("url");
	String sPopupLogin = request.getParameter("popuplogin");
	if ( sPopupLogin == null ) sPopupLogin = "0";

	if(url == null || url.trim().equals("")) url = "/";
	
	String query = request.getParameter("query");
	if(query == null || query.trim().equals("")) query = "";
	
	query = query.replaceAll("/", "&");

	//login
	LoginBean lb = new LoginBean();
	int result = lb.Login(request, response);

	//popup login check
	int nPopCheck = 0;
	if ( sPopupLogin.equals("1") ) nPopCheck = 1; 

	//처리
	out.println("<script language=javascript>\n");
	if(result == 1 ) 
	{ 
		//정상인 경우
		if(url != null && !url.trim().equals(""))
		{ 
			if ( nPopCheck == 1 ) //popup login 경우
				out.println("opener.location.reload();\n this.close();\n");
			else
//				out.println("alert("+url+");\n");
				out.println("location.href(\"http://www.mtkumgang.com"+url+"?"+query+"\");\n");
		} 
		else 
		{ 
			if ( nPopCheck == 1 ) //popup login 경우
				out.println("opener.location.reload();\n this.close();\n");
			else
				out.println("location.href(\"http://www.mtkumgang.com/\");\n");
		 } 
	} 
	else if(result == 0) //ID 없는경우
	{ 
		if ( nPopCheck == 1 ) //popup login 경우
			out.println("location.replace(\"http://www.mtkumgang.com/member/pop_login.jsp?sErrStr=2\");\n");
		else
			out.println("location.replace(\"http://www.mtkumgang.com/member/login.jsp?sErrStr=2\");\n");
	} 
	else //비밀번호가 틀린경우
	{ 
		if ( nPopCheck == 1 ) //popup login 경우
			out.println("location.replace(\"http://www.mtkumgang.com/member/pop_login.jsp?sErrStr=3\");\n");
		else
			out.println("location.replace(\"http://www.mtkumgang.com/member/login.jsp?sErrStr=3\");\n");
	}
	out.println("</script>\n");
 %>
<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.12
  - 저작권 표시: IMJ Korea
  - 설명: 로그인 처리
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%
	String url = request.getParameter("url");
	String sPopupLogin = request.getParameter("popuplogin");
	if ( sPopupLogin == null ) sPopupLogin = "0";

	if(url == null || url.trim().equals("")) url = "/index.jsp";
	
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
				out.println("location.replace(\""+url+"?"+query+"\");\n");
		} 
		else 
		{ 
			if ( nPopCheck == 1 ) //popup login 경우
				out.println("opener.location.reload();\n this.close();\n");
			else
				out.println("location.replace(\"/index.jsp\");\n");
		 } 
	} 
	else if(result == 0) //ID 없는경우
	{ 
		if ( nPopCheck == 1 ) //popup login 경우
			out.println("location.replace(\"/member/pop_login.jsp?sErrStr=2\");\n");
		else
			out.println("location.replace(\"/member/login.jsp?sErrStr=2\");\n");
	} 
	else //비밀번호가 틀린경우
	{ 
		if ( nPopCheck == 1 ) //popup login 경우
			out.println("location.replace(\"/member/pop_login.jsp?sErrStr=3\");\n");
		else
			out.println("location.replace(\"/member/login.jsp?sErrStr=3\");\n");
	}
	out.println("</script>\n");
 %>
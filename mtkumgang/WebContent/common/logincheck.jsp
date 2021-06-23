<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.05
  - 저작권 표시: IMJ Korea
  - 설명: Cookie 체크 , 로그인 체크
--%>
<%
	String request_uri = request.getRequestURI();
	if(request_uri == null) request_uri = "";
	
	String request_query = request.getQueryString();
	if(request_query == null) request_query = "";
	request_query = request_query.replaceAll("&", "/");
    
    
    
	////cookie read
	//int nCookie = 0;
	//Cookie[] cookies = request.getCookies();
	//if ((cookies != null) && (cookies.length > 0)) 
	//{
	//	for(int i=0; i < cookies.length; i++) 
	//	{
	//		Cookie thisCookie = cookies[i];
	//		if (thisCookie.getName().equals("id") ) 
	//		{
	//			nCookie = 1;
	//			break;
	//		}
	//	}
	//}

	//cookie 없으면. 로그인 화면으로 이동.
	if ( nCookie != 1  ) 
	{
		response.sendRedirect("/member/login.jsp?url=" + request_uri + "&query=" + request_query);
		return;
	}
	
	/* session old 버전
	if(session == null){
			response.sendRedirect("/member/login.jsp?url=" + request_uri + "&query=" + request_query);
			return;
	}

	String memberidx= (String)session.getAttribute("memberidx");

	if(memberidx == null || memberidx.trim().equals("") || memberidx.trim().equals("null")){
		response.sendRedirect("/member/login.jsp?url=" + request_uri + "&query=" + request_query);
		return;
	}
	*/

%>
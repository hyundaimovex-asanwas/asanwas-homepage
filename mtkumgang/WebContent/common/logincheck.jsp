<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.05
  - ���۱� ǥ��: IMJ Korea
  - ����: Cookie üũ , �α��� üũ
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

	//cookie ������. �α��� ȭ������ �̵�.
	if ( nCookie != 1  ) 
	{
		response.sendRedirect("/member/login.jsp?url=" + request_uri + "&query=" + request_query);
		return;
	}
	
	/* session old ����
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
<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 11��
* ��༳�� : ������ �α��� üũ
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%
	response.setHeader("Pragma","No-cache");
	response.setDateHeader("Expires",0);
	response.setHeader("Cache-Control","no-cache");

	String request_uri = request.getRequestURI();
	if(request_uri == null) request_uri = "";
	String request_query = request.getQueryString();
	if(request_query == null) request_query = "";
	request_query = request_query.replaceAll("&", "/");
%>

<%
	if(session == null){
			response.sendRedirect("/asanway/admin_login.jsp?url=" + request_uri + "&query=" + request_query);
			return;
	}

	String adminlogin = (String)session.getAttribute("adminidx");
		if(adminlogin == null || adminlogin.trim().equals("") || adminlogin.trim().equals("null")){
			response.sendRedirect("/asanway/admin_login.jsp?url=" + request_uri + "&query=" + request_query);
			return;
		}

	String menuidx = "";
%>

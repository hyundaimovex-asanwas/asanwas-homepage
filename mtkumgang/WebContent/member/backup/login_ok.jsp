<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.12
  - ���۱� ǥ��: IMJ Korea
  - ����: �α��� ó��
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

	//ó��
	out.println("<script language=javascript>\n");
	if(result == 1 ) 
	{ 
		//������ ���
		if(url != null && !url.trim().equals(""))
		{ 
			if ( nPopCheck == 1 ) //popup login ���
				out.println("opener.location.reload();\n this.close();\n");
			else
				out.println("location.replace(\""+url+"?"+query+"\");\n");
		} 
		else 
		{ 
			if ( nPopCheck == 1 ) //popup login ���
				out.println("opener.location.reload();\n this.close();\n");
			else
				out.println("location.replace(\"/index.jsp\");\n");
		 } 
	} 
	else if(result == 0) //ID ���°��
	{ 
		if ( nPopCheck == 1 ) //popup login ���
			out.println("location.replace(\"/member/pop_login.jsp?sErrStr=2\");\n");
		else
			out.println("location.replace(\"/member/login.jsp?sErrStr=2\");\n");
	} 
	else //��й�ȣ�� Ʋ�����
	{ 
		if ( nPopCheck == 1 ) //popup login ���
			out.println("location.replace(\"/member/pop_login.jsp?sErrStr=3\");\n");
		else
			out.println("location.replace(\"/member/login.jsp?sErrStr=3\");\n");
	}
	out.println("</script>\n");
 %>
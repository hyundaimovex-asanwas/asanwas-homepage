<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*
' 	�������� ��û ���� �Է� ȭ��
'    (�� �������� KCB�˾�â���� �Է¿�)
*/ 
%>
194

<%@ page import="com.hdasan.util.AedInfo" %>
<%
	//���� üũ ///////////////////////////////////////////////////////////////////////
	String ssID 			= request.getParameter("ssID");
	String aed	 			= request.getParameter("aed");
	String ssn	 			= request.getParameter("ssn");

	AedInfo AI = new AedInfo();
	String result = AI.Pwd(request, response); //�α� ó��
	//���� üũ ///////////////////////////////////////////////////////////////////////

	if(!result.equals(ssID)){	//���н�

		return;
	}else{//üũ ����!





	}//if(!result.equals(ssID))
%>

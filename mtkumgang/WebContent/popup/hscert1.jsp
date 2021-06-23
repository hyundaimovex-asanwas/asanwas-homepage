<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*
' 	본인인증 요청 정보 입력 화면
'    (고객 인증정보 KCB팝업창에서 입력용)
*/ 
%>
194

<%@ page import="com.hdasan.util.AedInfo" %>
<%
	//세션 체크 ///////////////////////////////////////////////////////////////////////
	String ssID 			= request.getParameter("ssID");
	String aed	 			= request.getParameter("aed");
	String ssn	 			= request.getParameter("ssn");

	AedInfo AI = new AedInfo();
	String result = AI.Pwd(request, response); //로긴 처리
	//세션 체크 ///////////////////////////////////////////////////////////////////////

	if(!result.equals(ssID)){	//실패시

		return;
	}else{//체크 성공!





	}//if(!result.equals(ssID))
%>

<%@page language="java" contentType="text/html;charset=EUC-KR"  pageEncoding="EUC-KR"%>
<%@page import="sun.misc.BASE64Encoder"%>
<%@page import="java.io.*"%>
<%@page import="KISA.SHA256"%>
<%
	request.setCharacterEncoding("UTF-8"); // �ѱ��Է��� ���� UTF-8 ���ڵ� ����
	String sPlainText = request.getParameter( "iPlainText" );
	SHA256 s = new SHA256( sPlainText.getBytes() );
	BASE64Encoder Base64Encoder = new BASE64Encoder();	
	out.print( Base64Encoder.encode(s.GetHashCode()) );
%>

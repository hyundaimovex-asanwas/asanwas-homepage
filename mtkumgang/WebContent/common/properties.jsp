<%@ page import="kr.co.imjk.util.Config"%>
<%!
//DNS
public static final String ROOT_DNS= Config.getInstance().getProperty("imjkmd","rootDomain");
//public static final String ROOT_DNS= "test1.hdasan.com";
%>
<%
//이미지 서버 위치
String imageServer = Config.getInstance().getProperty("imjkmd","imageServer");
String rootServer = Config.getInstance().getProperty("imjkmd","rootServer");

imageServer = "/asanway/img"; //sdh


//현재 URL FULL 경로
String qryStr = request.getQueryString();
qryStr = (qryStr!=null && !qryStr.equals(""))?"?"+qryStr:"";
String requestUri = request.getRequestURI();
String nowUri = requestUri+qryStr; 
nowUri = java.net.URLEncoder.encode(nowUri);

%>

<div id="TourRia"></div> 
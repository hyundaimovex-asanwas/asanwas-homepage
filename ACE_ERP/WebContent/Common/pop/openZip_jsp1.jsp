<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<%@ page 
language="java"
contentType="text/html; charset=EUC-KR"
pageEncoding="EUC-KR"
%>
<%@ page import="common.pop.JDomReadFile"%>
<%@ page import="java.util.*" %>
<%
//	String url = "/samp.xml";
	String xmlData = "" ;
	xmlData = getURLContents("http://biz.epost.go.kr/KpostPortal/openapi?regkey=af1300d3f6c467d601306735007670&target=post&query=연지동"); // url 은 xml데이터를 불러오는 실제 경로 
	
	JDomReadFile read = new JDomReadFile(); //import 하고.. 

	 List list = new ArrayList();
//	List list = null;
	list = read.returnXMLList(url);

%>

<META http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<META name="GENERATOR" content="IBM WebSphere Studio">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../../theme/Master.css" rel="stylesheet" type="text/css">
<TITLE>openZip.jsp</TITLE>
</HEAD>
<script language="javascript">
	<!--

	-->
</script>
<BODY>
<%//=list%>

</BODY>
</HTML>



 

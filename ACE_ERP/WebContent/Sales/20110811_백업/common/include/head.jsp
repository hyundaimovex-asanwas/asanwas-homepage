<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
	String dirPath = request.getContextPath();
%>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	
	<title></title>
		
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/
%>		

		<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">

<%//css 는 일단 경로는 그대로. html5+CSS3 적용시 수정하자.%>
	<link href="<%=dirPath%>/Sales/common/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=dirPath%>/Sales/common/css/em.css" rel="stylesheet" type="text/css">

<%//1200행 : 퍼블릭 펑션. 로그인 등의 공용처리... %>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/PubFun.js"></script>
<%//IE패치 object 삽입 script 필수!%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/embedControl.js"></script>

<script language="javascript" src="<%=dirPath%>/Sales/common/js/menu.js"></script>
<%//15000행 : 이상이나 됨-_- 코니스 소스%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>


<%//200행 : 관광시스템 사용 - 주로 검색 help창 띄우는 공용 펑션%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_pop.js"></script>      

<%//1900행 : 코니스 소스%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common.js"></script>        

	<script language="javascript" src="<%=dirPath%>/Sales/common/js/em.js"></script>  








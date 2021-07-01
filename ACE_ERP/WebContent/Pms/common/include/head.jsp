	<%@ page language="java" contentType="text/html;charset=euc-kr" %>
	<%	// ContextPath 변수 설정.
		String dirPath = request.getContextPath(); //HDASan
	%>	
	<%
	/******************************************************************************
	 * 시스템명     : PMS
	 * J  S  P      : head.jsp
	 * [ 수정일자 ][수정자] 내용
	 * [2013-12-04][심동현] 시스템 이전용 새 개발 , js,CSS 일부 간소화
	 *****************************************************************************/
	%>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<meta http-equiv="Cache-control" content="no-cache"/>
		<meta http-equiv="Cache-control" content="no-store"/>
		<meta http-equiv="pragma" content="no-cache" />
		<meta name="viewport" content="width=1080" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<title></title>
	<%
	/*=============================================================================
				Style Sheet, Common Java Script Link
	=============================================================================*/
	%>		

	<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">


	<%//공사관리용... %>
	<link href="<%=dirPath%>/Pms/common/css/common.css" rel="stylesheet" type="text/css">

	<%//개별 시스템 사용 - 주로 검색 help창 띄우는 공용 펑션%>
	<script language="javascript" src="<%=dirPath%>/Pms/common/js/common_pop.js"></script>
	<%//15000행 : 이상이나 됨-_- GAUCE 기본 소스%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>
	<%//공사관리용... %>
	<script language="javascript" src="<%=dirPath%>/Pms/common/include/PubFun.js"></script>
<!-- 
	<%//css 는 일단 경로는 그대로. html5+CSS3 적용시 수정하자.%>
	<link href="<%=dirPath%>/Sales/common/css/common.css" rel="stylesheet" type="text/css">


<script language="javascript" src="<%=dirPath%>/Sales/common/js/PubFun.js"></script><%//1200행 : 퍼블릭 펑션. 로그인 등의 공용처리... %>
<script language="javascript" src="<%=dirPath%>/Sales/common/js/embedControl.js"></script><%//IE패치 object 삽입 script 필수!%>
<script language="javascript" src="<%=dirPath%>/Sales/common/js/menu.js"></script><%//나모? %>

      
<script language="javascript" src="<%=dirPath%>/Sales/common/js/common.js"></script><%//1900행 : 코니스 소스%>        
<script language="javascript" src="<%=dirPath%>/Sales/common/js/em.js"></script>  <%//종합관리 소스%>
 -->
	

	<script language="javascript">
		<%//공사관리 사용자 %>
		var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
		var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
		var  gcurdate	="<%=(String)session.getAttribute("vcurdate")%>";
		var  gautlevel	="<%=(String)session.getAttribute("vautlevel")%>";
		var  gdeptcd	="<%=(String)session.getAttribute("vdeptcd")%>";
		var  gdeptnm	="<%=(String)session.getAttribute("vdeptnm")%>";
		var  gfdcode	="<%=(String)session.getAttribute("vfdcode")%>";
		var  gfdname	="<%=(String)session.getAttribute("vfdname")%>";
		var  gcocode	="<%=(String)session.getAttribute("vcocode")%>";
		var  gconame	="<%=(String)session.getAttribute("vconame")%>";
		var  gjobdty	="<%=(String)session.getAttribute("vjobdty")%>";
	</script>  


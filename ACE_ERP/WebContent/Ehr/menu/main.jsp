<!--
*****************************************************
* @source       : main.jsp
* @description : POTENTIAL MDI MAIN PAGE :: POTENTIAL MDI OBJECT 생성
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/09/05      한학현        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.support.collection.CBox,com.shift.gef.support.collection.CollectionUtility,com.shift.gef.support.utility.SessionUtil,com.shift.gef.configuration.Configuration" %>

<%
    String menu_id  = "";

    if(request.getParameter("MENU_ID") != null){
        menu_id = request.getParameter("MENU_ID");
    }

    String LocationDNS = Configuration.getInstance().get("framework.print.ezgen.locationDNS");
    String DPT_NM = (String)session.getAttribute("SESSION_DPTNM");
    String ENO_NM = (String)session.getAttribute("SESSION_ENONM");

    String Header = " - " + DPT_NM + "&nbsp;" + ENO_NM;


out.print("<html>");

%>
<%="<head>" %>
<%
 if (LocationDNS.substring(0,5).equals("10.61")){
%>
<title>[개발-ASAN] 신인사시스템 <%=Header%></title>
<%
}else{
%>
<title>현대아산 신인사시스템 <%=Header%></title>
<%
}
%>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="/common/common.js"></script>
<SCRIPT LANGUAGE="JavaScript">

<!--
	/* 익월근태 독려 경고창 Start
	var YYYYMMDD = getToday().replace("-","").replace("-","");
	var NEXTYYYYMM = next_month(getToday());
	var NEXTMONTH = NEXTYYYYMM.replace("-","").substring(4);
	var MM       = YYYYMMDD.substring(4,6);
	var DD       = YYYYMMDD.substring(6);

	if( DD == "24" ||  DD == "25" ){
		alert(NEXTMONTH+"월 익월근태 25일 마감\n기한내에 신청바랍니다");
	}
	익월근태 독려 경고창 End*/

//-->
</SCRIPT>
</head>

<body scroll="no">
<div style="position:absolute;top:0px;left:0px;background-color:red;width:105%;height:100%;background-color:red">
	<comment id="__NSID__">
    <OBJECT ID="Potential" CLASSID="CLSID:1C18220D-EC23-48C8-B35E-857ADE9D1465"  width="100%" height="100%">
       <PARAM name=src value="pmain.jsp?MENU_ID=<%=menu_id%>">
    </OBJECT>
	</comment>
	  <script language="javascript"> __ShowEmbedObject(__NSID__); </script>
</comment>

<script>

	//외부에서 Potential을 접근해야할경우 아래와같이 반드시 선언해 놓아야한다.
	Potential.OuterWindow = window;

	function do_go(){
		location.href="../../hrms_login.jsp";
	}
</script>

<script language=JavaScript for=window event=onresize>
	//메인창의 크기가 변할경우 내부의frame의 크기도 같이 변경시켜준다.

	if ( document.body == "object" ) {
		do_resize(document.body.offsetHeight);
	}
	/*
	try {
		do_resize(document.body.offsetHeight);
	} catch(e) {

	}
	*/

</script>

</div>
</body>

</html>
<!--
*****************************************************
* @source       : main.jsp
* @description : POTENTIAL MDI MAIN PAGE :: POTENTIAL MDI OBJECT ����
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/09/05      ������        �����ۼ�.
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
<title>[����-ASAN] ���λ�ý��� <%=Header%></title>
<%
}else{
%>
<title>����ƻ� ���λ�ý��� <%=Header%></title>
<%
}
%>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="/common/common.js"></script>
<SCRIPT LANGUAGE="JavaScript">

<!--
	/* �Ϳ����� ���� ���â Start
	var YYYYMMDD = getToday().replace("-","").replace("-","");
	var NEXTYYYYMM = next_month(getToday());
	var NEXTMONTH = NEXTYYYYMM.replace("-","").substring(4);
	var MM       = YYYYMMDD.substring(4,6);
	var DD       = YYYYMMDD.substring(6);

	if( DD == "24" ||  DD == "25" ){
		alert(NEXTMONTH+"�� �Ϳ����� 25�� ����\n���ѳ��� ��û�ٶ��ϴ�");
	}
	�Ϳ����� ���� ���â End*/

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

	//�ܺο��� Potential�� �����ؾ��Ұ�� �Ʒ��Ͱ��� �ݵ�� ������ ���ƾ��Ѵ�.
	Potential.OuterWindow = window;

	function do_go(){
		location.href="../../hrms_login.jsp";
	}
</script>

<script language=JavaScript for=window event=onresize>
	//����â�� ũ�Ⱑ ���Ұ�� ������frame�� ũ�⵵ ���� ��������ش�.

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
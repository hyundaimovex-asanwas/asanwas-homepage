<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.DateUtils"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>PLZ관광 예약판매</title>
<link rel="STYLESHEET" type="text/css" href="/asanway/img/tour_common/common.css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script>
function underConst(){
	alert("준비중입니다.");
}

function goRes(){
	window.open('http://www.mtkumgang.com/preserv/res_srch1.jsp','resRsv','width=810,height=550,top=0,left=0, scrollbars=yes');
	this.close();
}

function goTheOne(){
	window.open('http://www.mtkumgang.com/reservation/theone_step_agree.jsp','theOneRsv','width=810,height=550,top=0,left=0, scrollbars=yes');
	
	this.close();
}

function goTheOne2(){
	window.open('http://www.mtkumgang.com/reservation/theone_srch1.jsp','theOneRsv','width=810,height=550,top=0,left=0, scrollbars=yes');
	
	this.close();
}

</script>
</head>
<body>
<table cellpadding="0" cellspacing="0" width="743" border="0">
  <tr>
    <td><img src="/asanway/img//tour_img/plz/online090813_popup1.jpg" usemap="#Map"/></td>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="77,462,280,489" href="javascript:goRes()">

  <area shape="rect" coords="456,462,550,490" href="javascript:goTheOne();">
  <area shape="rect" coords="562,462,658,489" href="javascript:goTheOne2();">
</map>

</body>
</html>

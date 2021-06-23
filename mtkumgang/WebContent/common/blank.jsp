<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<html> 
<head>
<title> ±Ý°­»ê°ü±¤   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="javascript">
<!--
  function printBody()
  {
       document.all.allBody.innerHTML = opener.document.all.print_area.innerHTML;
       window.resizeTo(opener.document.all.print_area.offsetWidth + 18,  opener.document.all.print_area.offsetHeight);
       window.print();
       window.close();
  }
  //-->
</script>
</head>
<body onload="printBody()" topMargin="0" leftMargin="0" marginWidth="0" marginHeight="0">
<div id="allBody">
</div>
</body>
</html>
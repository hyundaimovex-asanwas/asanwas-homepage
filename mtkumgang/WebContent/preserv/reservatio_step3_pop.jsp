<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 

<%
	String img_nm = "";
	String upjang_sid = request.getParameter("upjang_sid");											//호텔구분
	String room_type_sid = request.getParameter("room_sid");										//룸 SID
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>::온라인예약::</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>

<body>
<table width="535" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="<%=imageServer%>/tour_img/reservation/room_pop/img_<%=upjang_sid%>_<%=room_type_sid%>.jpg" width="535" height="320"></td>
  </tr>
</table>
</body>

</html>
 
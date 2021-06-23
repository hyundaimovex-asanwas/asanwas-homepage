<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>



<html>
<head>
<title>금강산|개성 예약판매　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
</head>

<body>
<table width="720" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/tit_res01.gif" width="70" height="21" /></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
  <tr>
    <td height="16">&nbsp;</td>
  </tr>
  <tr>
    <td align=center><img src="<%=imageServer%>/reservation/img/img_res01.gif" width="689" height="403" border="0" usemap="#Map" /></td>
  </tr>
</table>

<map name="Map" id="Map">
<area shape="rect" coords="247,334,343,362" href="res_step1.jsp" /><!-- 예약하기 -->
<area shape="rect" coords="352,333,449,363" href="res_srch1.jsp" /><!-- 예약조회 -->
</map>
</body>
</html>

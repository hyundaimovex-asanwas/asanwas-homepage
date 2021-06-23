<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>제휴카드사할인</title>
<script language="javascript">
<!--
    function closeWin(){
    	setCookie( "cardDC", "done" , 1);
    	self.close();
    }
    
    function setCookie( name, value, expiredays ){
    	var todayDate = new Date();
    	todayDate.setDate( todayDate.getDate() + expiredays );
    	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }

//-->
</script>

</head>

<body leftmargin="0" topmargin="0">
<table width="438" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="<%=imageServer%>/tour_img/mypage/pop061109.jpg" width="438" height="193" border="0" usemap="#Map"></td>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="292,173,437,200" href="javascript:closeWin();">
</map>
</body>
</html>

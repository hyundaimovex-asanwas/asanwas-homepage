<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>:: Notice ::</title>
<script language="javascript">
<!--
	
    function closeWin(){
    	setCookie( "pop080811eng", "done" , 1);	//쿠키명
    	self.close();
    }
    
    function setCookie( name, value, expiredays ){
    	var todayDate = new Date();
    	todayDate.setDate( todayDate.getDate() + expiredays );
    	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }
	
</script>

</head>

<body leftmargin="0" topmargin="0">

<table width="400" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/popup_20080811_eng.jpg" width="400" height="278" border="0"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000" align=center><a href="javascript:closeWin();" onFocus="this.blur()"><FONT size=2 COLOR="white">click to close pop for 24 hours</FONT></a></td>
  </tr>
</table>
</body>
</html>

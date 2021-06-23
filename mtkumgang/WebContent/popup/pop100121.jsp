<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>알려드립니다.</title>
<script language="javascript">
<!--
    function closeWin(){
    	setCookie("mt100121","done",1);	//쿠키명
		this.close();
    }
    
    function setCookie( name, value, expiredays ){
    	var todayDate = new Date();
    	todayDate.setDate( todayDate.getDate() + expiredays );
    	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }
-->
</script>

</head>

<body leftmargin="0" topmargin="0">

<table width="420" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/20100121_mtkg_pop.jpg"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>PLZ ??????ǰ</title>
<script language="javascript">
<!--
	
	//10?ָ? ?? 3
	function goPage1(){
		opener.location="http://www.hdasan.com"
				window.close();    
	}
    function closeWin(){
    	setCookie( "open", "done" , 1);	//??Ű??
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
    <td valign="top"><img src="/poping/popup_20090717.jpg" width="600" height="848" border="0" usemap="#Map"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>

<map name="Map"><area shape="rect" coords="249,534,774,780" href="javascript:goPage1();"></map></body>
</html>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta HTTP-EQUIV="imagetoolbar" CONTENT="no"> 
<title>축!개성관광 오픈</title>
<script language="javascript">
<!--
	function goPage1()
	{
		opener.location="/kaesong/main.jsp";
		window.close();    
	}
	
	

    function closeWin(){
    	setCookie( "open", "done" , 1);	//쿠키명
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

<table width="350" cellpadding="0" cellspacing="0">
  <tr> 
    <td><img src="/popimgs/popup_20071112.gif" width="350" height="325" border="0" usemap="#Map"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>

<map name="Map">
<area shape="poly" coords="226,281,241,274,268,272,283,272,299,273,317,278,327,290,327,303,321,309,309,312,298,312,278,312,266,312,255,311,240,309,232,308,224,303,221,293" href="http://www.ikaesong.com/" target="_blank" onFocus="this.blur()">
</map></body>
</html>

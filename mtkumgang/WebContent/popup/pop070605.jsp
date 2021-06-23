<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>세대공감 금강산주말콘서트</title>
<script language="javascript">
<!--
	function goPage1()
	{
		opener.location="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=1752&requestedPage=1&part=&keyword=";
		window.close();    
	}
	

    function closeWin(){
    	setCookie( "music", "done" , 1);	//쿠키명
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

<table width="400" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="/popimgs/popup_20070605.gif" width="400" height="310" border="0" usemap="#Map"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="239,266,372,297" href="javascript:goPage1();" onFocus="this.blur()">
</map>




</body>
</html>

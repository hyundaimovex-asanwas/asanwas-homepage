<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>개성관광 Grand Open!!</title>
<script language="javascript">
<!--
	
	function go1()
	{
		opener.location="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=2791&requestedPage=1&part=&keyword=";
		window.close();    
	}
	

    function closeWin(){
    	setCookie( "ksopen", "done" , 1);	//쿠키명
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

<table width="400" height="380" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/kaesong/images/popup/pop_20071112.jpg" width="400" height="355" border="0"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/kaesong/images/popup/popup_close.gif" width="132" height="24" border=0></a></td>
  </tr>
</table>
</body>
</html>

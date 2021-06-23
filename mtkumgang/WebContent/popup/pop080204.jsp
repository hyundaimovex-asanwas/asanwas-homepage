<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta HTTP-EQUIV="imagetoolbar" CONTENT="no"> 
<title>황진이와 서경덕의 퀴즈쑈!</title>
<script language="javascript">
<!--
	function goPage1()
	{
		opener.location="http://www.ikaesong.com/board/board_view.jsp?board_seq=3243&requestedPage=1&part=&keyword=";
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
    <td valign="top"><img src="/popimgs/080204_01.gif" border="0" usemap="#Map2"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>

<map name="Map2"><area shape="rect" coords="48,228,304,275" href="http://www.ikaesong.com/board/board_view.jsp?board_seq=3243&requestedPage=1&part=&keyword=" target="_blank">
</map>
</body>
</html>

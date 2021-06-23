<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>현대아산 공모전</title>
<script language="javascript">
<!--
	
	//10주면 빅 3
	function goPage1(){
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3962&requestedPage=1&part=&keyword=";
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
	
</script>

</head>

<body leftmargin="0" topmargin="0">

<table width="400" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/popup_20080623.jpg" width="420" height="390" border="0" usemap="#Map"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>

<map name="Map"><area shape="rect" coords="261,218,393,251" href="javascript:goPage1();"></map></body>
</html>

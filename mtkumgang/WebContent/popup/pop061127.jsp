<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>3가지 이벤트</title>
<script language="javascript">
<!--
    function closeWin(){
    	setCookie( "3events", "done" , 1);	//쿠키명
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

<table width="600" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/popimgs/pop061124_3pieces.jpg" width="600" height="250" border="0" usemap="#Map"></td>
  </tr>
</table>

<map name="Map">
  <area shape="rect" coords="148,201,194,251" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=677&requestedPage=1&part=&keyword=" target="_parent">
  <area shape="rect" coords="348,203,397,247" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=658&requestedPage=1&part=&keyword=" target="_blank>
  <area shape="rect" coords="550,199,598,247" href="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=678&requestedPage=1&part=&keyword=" target="_blank>
  <area shape="rect" coords="5,231,117,250" href="#">
</map>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::
금강산관광안내::</title>
<script language="javascript">
<!--
	
    function closeWin(){
    	setCookie( "ppl15000", "done" , 1);	//쿠키명
    	self.close();
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

<table width="650" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/ppl15000.jpg" width="500" height="450" border="0" ></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
</body>
</html>

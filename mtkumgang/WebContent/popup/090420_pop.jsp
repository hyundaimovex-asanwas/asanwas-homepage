 <%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::
금강산관광안내::</title>
<script language="javascript"> 
<!--
	
    function closeWin(){
    	setCookie( "090420", "done" , 1);	//쿠키명
    	self.close();
    }
    
    function setCookie( name, value, expiredays ){
    	var todayDate = new Date();
    	todayDate.setDate( todayDate.getDate() + expiredays );
    	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }
 

	function goPage() {
	    opener.location.href='/plz/event_page.jsp';
		this.close();
	}
	-->
</script>
 
</head>
 
<body leftmargin="0" topmargin="0">
 
<table width="400" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/sub_popup.jpg" width="400" border="0" usemap="#Map"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
 
 
<map name="Map">
  <area shape="circle" coords="345,367,32" href="javascript:goPage();">
</map>
</body>
</html>


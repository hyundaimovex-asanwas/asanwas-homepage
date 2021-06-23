<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>금강산 이벤트!!</title>
<script language="javascript">
<!--
	
	function goPage1()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3506&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
	function goPage2()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3543&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
		function goPage3()
	{
		opener.location="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=3167&requestedPage=1&part=&keyword=";
		window.close();    
	}
			function goPage4()
	{
		opener.location="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=3166&requestedPage=1&part=&keyword=";
		window.close();    
	}
			function goPage5()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3316&requestedPage=1&part=&keyword=";
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

<table width="400" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/imgevent080328.gif" width="400" height="195" border="0" usemap="#Map">
<map name="Map">
      
      <area shape="rect" coords="313,96,395,121" href="javascript:goPage2();" onFocus="this.blur()">
	  <area shape="rect" coords="315,155,395,185" href="javascript:goPage1();"  onFocus="this.blur()">
</map></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
</body>
</html>

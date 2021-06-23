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
		opener.location="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=2791&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
	function goPage2()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=2640&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
		function goPage3()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=2091&requestedPage=1&part=&keyword=";
		window.close();    
	}
		function goPage4()
	{
		opener.location="http://www.mtkumgang.com/cummunity/event/prevent_view.jsp?board_seq=2446&requestedPage=1&part=&keyword=";
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

<table width="400" height="380" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/popup_20071008.gif" width="400" height="355" border="0" usemap="#Map"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="320,305,395,328" href="javascript:goPage4();" onFocus="this.blur()">
  <area shape="rect" coords="318,226,397,248" href="javascript:goPage3();"onFocus="this.blur()">
  <area shape="rect" coords="319,143,396,163" href="javascript:goPage2();"onFocus="this.blur()">
  <area shape="rect" coords="319,69,396,89" href="javascript:goPage1();"onFocus="this.blur()">
</map>
</body>
</html>

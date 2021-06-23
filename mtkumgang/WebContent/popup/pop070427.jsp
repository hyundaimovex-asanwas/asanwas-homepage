<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>내금강오픈</title>
<script language="javascript">
<!--
	function goPage1()
	{
		opener.top.main.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=1515&requestedPage=1&part=&keyword=";
		window.close();    
	}
	

    function closeWin(){
    	setCookie( "nakumgang", "done" , 1);	//쿠키명
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

<table width="361" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/popimgs/pop0704027nakum.jpg" width="360" height="320" border="0" usemap="#Map"></td>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="262,223,339,303" href="javascript:goPage1();">
 
  <area shape="rect" coords="241,306,352,319" href="#">
</map>




</body>
</html>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>내금강오픈</title>
<script language="javascript">
<!--
	function goLink()
	{
		//alert(111);
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=1515&requestedPage=1&part=&keyword=";
		window.close();    
	}
	

    function closeWin(){
    	setCookie( "nakumgang", "done" , 1);	//쿠키명
    	window.close();
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

<table width="400" height="335" cellpadding="0" cellspacing="0">
  <tr> 
    <td>
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="javascript">
                  writeObject("/popimgs/pop070514.swf","400","310","transparent")
              </script>
			  
	</td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
</body>
</html>

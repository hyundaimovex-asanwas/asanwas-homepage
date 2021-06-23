<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
<title>평화생태체험과 함께하는 여행 </title>
<link rel="stylesheet" href="css/css.css" type="text/css">
<script>
function notice_setCookie( 
name, value, expiredays )
{
var todayDate = new 
Date();
todayDate.setDate( todayDate.getDate() + expiredays 
);
document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + 
todayDate.toGMTString() + ";"
}

function notice_closeWin() 
{ 

notice_setCookie( "popnew", "NOPOPnew" , 1); 
// 1=하룻동안 열지 않음
self.close(); 
}

</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td valign="top"><table width="401" border="0" cellspacing="0" cellpadding="0">
      <tr>
          <td><img src="/popimgs/plzpop_img.jpg" width="401" height="501" border="0" usemap="#Map">
            <map name="Map">
              <area shape="rect" coords="295,12,388,32" href="http://www.plztour.com/product/product01.jsp" target="_blank">
              <area shape="rect" coords="295, 442, 399, 479" href="http://www.plztour.com/product/product01.jsp" target="_blank" onFocus="this.blur();">
              <area shape="rect" coords="3,476,131,497" href="javascript:notice_closeWin();">
            </map></td>
      </tr>
    </table></td>
</tr>
</table>
</body>
</html>

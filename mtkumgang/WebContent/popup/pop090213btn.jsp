<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::
�ݰ�������ȳ�::</title>
</head>


<script language="javascript">

	
    function closeWin(){
    	setCookie( "pop090213btn", "done" , 1);	//��Ű��
    	self.close();
    }
    
    function setCookie( name, value, expiredays ){
    	var todayDate = new Date();
    	todayDate.setDate( todayDate.getDate() + expiredays );
    	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }

	function goRsv(){
		//����â�� �����.
	    window.open('http://www.mtkumgang.com/preserv/res_login.jsp','preRsv','width=760,height=530,scrollbars=yes,top=0,left=0,toolbar=no,location=no,directories=no');

		//���� �˾�â�� �ݾ���.
		this.close();
	}
	
</script>

<body leftmargin="0" topmargin="0">




<table width="486" cellpadding="0" cellspacing="0">
  <tr> 
    <td valign="top"><img src="/popimgs/popup_20090213_btn.jpg" width="486" height="725" border="0"  usemap="#Map1"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>


<map name="Map" id="Map1">
<area shape="rect" coords="20,648,353,715" href="javascript:goRsv();"><!-- �����ϱ� -->
</map>

</body>
</html>

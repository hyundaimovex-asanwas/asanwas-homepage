<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>�ݰ���</title>
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="javascript">
<!--
	
	//10�ָ� �� 3
	function goPage1(){
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3891&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
	//��ȭ����
	function goPage2()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3993&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
	//�����ް�
	function goPage3()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3944&requestedPage=1&part=&keyword=";
		window.close();    
	}


	

	//������ ����
	function goPage5()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3543&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
	

    function closeWin(){
    	setCookie( "music", "done" , 1);	//��Ű��
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
<table width="446" height="385" cellpadding="0" cellspacing="0">
	  <tr> 
		<td valign="top">
<script language="javascript">
                  writeObject("<%=imageServer%>/tour_swf/popup_kumgangmt.swf","446","385","transparent")
</script>
              
</td>
	  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>금강산 이벤트!!</title>
<script language="javascript">
<!--
	
	//10주면 빅 3
	function goPage1(){
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3891&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
	//문화유적
	function goPage2()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3878&requestedPage=1&part=&keyword=";
		window.close();    
	}
	
	//여름휴가
	function goPage3()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3944&requestedPage=1&part=&keyword=";
		window.close();    
	}


	

	//내차로 즐기는
	function goPage5()
	{
		opener.location="http://www.mtkumgang.com/utility/notice/notice_view.jsp?board_seq=3543&requestedPage=1&part=&keyword=";
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
    <td valign="top"><img src="/popimgs/imgevent080624.gif" width="400" height="437" border="0" usemap="#Map">
      <map name="Map">
        <area shape="rect" coords="318,86,397,111" href="javascript:goPage1();" onFocus="this.blur()">
        <area shape="rect" coords="317,168,396,192" href="javascript:goPage2();" onFocus="this.blur()">
        <area shape="rect" coords="319,245,396,271" href="javascript:goPage3();" onFocus="this.blur()">
        <area shape="rect" coords="319,327,396,354" href="http://gen.gmarket.co.kr/challenge/neo_sangsul/html_sangsul/plan_display_43766.asp?sid=43766&goodscode=&stat=S3&subkind=" target="_blank" onFocus="this.blur()">
        <area shape="rect" coords="318,408,397,430" href="javascript:goPage5();" onFocus="this.blur()">
    </map></td>
  </tr>
  <tr>
    <td height="25" bgcolor="#000000"><a href="javascript:closeWin();" onFocus="this.blur()"><img src="/popimgs/popup_close.gif" border=0></a></td>
  </tr>
</table>
</body>
</html>

<script>
<!--
function hold()
{
	alert("서비스 준비 중입니다.");

}
-->
</script>

<% if( session.getAttribute("memberidx") != null ) { %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="/img/common/top_bg.gif" >
<tr>
	<td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" 	width="850" height="96">
        <param name="movie" value="/swf/HA_topnavi.swf?login=Y">
        <param name="quality" value="high">
		<param name="wmode" value="opaque">
        <embed src="/swf/HA_topnavi.swf?login=Y" quality="high"
		pluginspage="http://www.macromedia.com/go/getflashplayer"
		type="application/x-shockwave-flash"
		wmode="opaque"
		width="850" height="96"></embed>
		</object></td>
</tr>
</table>
<% } else { %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="/img/common/top_bg.gif" >
<tr>
	<td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" 	width="850" height="96">
        <param name="movie" value="/swf/HA_topnavi.swf?login=N">
        <param name="quality" value="high">
		<param name="wmode" value="opaque">
        <embed src="/swf/HA_topnavi.swf?login=N" quality="high"
		pluginspage="http://www.macromedia.com/go/getflashplayer"
		type="application/x-shockwave-flash"
		wmode="opaque"
		width="850" height="96"></embed>
		</object></td>
</tr>
</table>
<% } %>
<MAP NAME="gnb">
	<AREA SHAPE="" HREF="/index.jsp" COORDS="32,32,154,74" onFocus="blur()">
	<AREA SHAPE="" HREF="#" COORDS="682,14,850,30" onFocus="blur()" onClick="javascript:hold();">
	<AREA SHAPE="" HREF="/company/sub_company.jsp" COORDS="204,41,270,60" onFocus="blur()">
	<AREA SHAPE="" HREF="#" COORDS="284,41,795,60" onFocus="blur()" onClick="javascript:hold();">


	<AREA SHAPE="" HREF="/company/overview.jsp" COORDS="204,72,232,87" onFocus="blur()">
	<AREA SHAPE="" HREF="/company/history.jsp" COORDS="232,72,263,87" onFocus="blur()">
	<AREA SHAPE="" HREF="/company/ceo01.jsp" COORDS="263,72,294,87" onFocus="blur()">
	<AREA SHAPE="" HREF="/company/business01.jsp" COORDS="294,72,346,87" onFocus="blur()">
	<AREA SHAPE="" HREF="/company/good.jsp" COORDS="346,72,384,87" onFocus="blur()">
	<AREA SHAPE="" HREF="#" COORDS="384,72,416,87" onFocus="blur()" onClick="javascript:hold();">
	<AREA SHAPE="" HREF="/company/org.jsp" COORDS="416,72,455,87" onFocus="blur()">
	<AREA SHAPE="" HREF="/company/ci01.jsp" COORDS="455,72,479,87" onFocus="blur()">
	<AREA SHAPE="" HREF="/company/map01.jsp" COORDS="479,72,536,87" onFocus="blur()">
</MAP>
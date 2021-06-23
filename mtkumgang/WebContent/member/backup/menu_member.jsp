<%
	int navia = 0;
	int navib = 0;
	int navic = 0;
	String pageNavi = request.getParameter("navi");
	if(pageNavi == null || pageNavi.equals("") || pageNavi.equals("null")){
		//response.sendRedirect("/index.jsp");
	}else if(pageNavi.length() != 6){
		//response.sendRedirect("/index.jsp");
	} else {
		navia = Integer.parseInt(pageNavi.substring(0,2));
		navib = Integer.parseInt(pageNavi.substring(2,4));
		navic = Integer.parseInt(pageNavi.substring(4,6));
	}
%>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" 	width="206" height="276">
<param name="movie" value="/swf/HA_subVisual_8.swf?a=<%=navia%>&b=<%=navib%>&c=<%=navic%>">
<param name="quality" value="high">
<param name="wmode" value="opaque">
<embed src="/swf/HA_subVisual_8.swf?a=<%=navia%>&b=<%=navib%>&c=<%=navic%>" quality="high" 
pluginspage="http://www.macromedia.com/go/getflashplayer" 
type="application/x-shockwave-flash" 
wmode="opaque"
width="206" height="276"></embed>
</object>

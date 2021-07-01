<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.*" %>

<%
	String dirPath = request.getContextPath();
	
	//최초 tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //받아온 현재 메뉴 값! fnOnLoad() 함수에 파라미터로 전달하여 메뉴구성!
%>

<% //로그인 체크 : 2011-07-24 심동현 수정 ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//페이지 이동시 세션ID 체크(이건 웬만한 곳은 하지 말끄나?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//페이지 이동시 세션변수("로긴") 체크
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크

//	out.println("ssID===="+ssID+ "<BR>");
//	out.println("portal=="+session.getId()+"<BR>");
//	out.println(gusrid+"<BR>");
//	out.println(gusrnm+"<BR>");
	
		
	// (ssID + 유저포지션값 + IP) 비교
	if(!ssID.equals(session.getId()) || !gusrip.equals(request.getRemoteAddr()) || !gusrpos.equals("Tadaima") ){
	//경고와 함께 메인 화면으로 
		%>
		<script language="javascript">
			alert("시간이 오래되어 자동 로그아웃되었거나\n정상 접근이 아닙니다.\n\n새로 로그인 해주세요.");
			top.location.href="<%=dirPath%>/newIndeX.jsp";
		</script>
		<%
//		response.sendRedirect(dirPath+"/newIndeX.jsp");
		return;
	}
	//로그인 체크 끝 ///////////////////////////////////////////////////////////////////////////////////////
%>
	<form name="movForm" id="movForm" method="post">
		<input name="ssID" type="hidden" value="<%=session.getId()%>" />
	</form>


<script language="JavaScript">
	document.onkeydown = function() {	<%//전 페이지에 걸쳐 공용 스크립트%>
		if( event.keyCode ==119 ) { //F2=113, F8=119
			helpme();
            event.keyCode = 0;
            event.cancelBubble = true;
            event.returnValue = false;
		}
	}

	function helpme(){	<%//도움말 오픈 펑션%>
		window.open("<%=dirPath%>/Helpshop/baseFrame.jsp?menu_idx=<%=tree_idx%>","Helpshop","width=900px, height=700px, resizable=yes,");
	}
	
	function moveMove(page,param){	<%//페이지 이동 : self 창%>
		document.movForm.action=page+ "?"+ param;
		document.movForm.submit();
	}
	function moveMoveN(page,param){	<%//페이지 이동 : 새창%>
		document.movForm.target="_blank";
		document.movForm.action=page+ "?"+ param;
		document.movForm.submit();
	}

	
</script> 

<!-- BODY header begin-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad(<%=tree_idx%>);">

<%
/*=============================================================================
			Status Bar Falsh
	최신 : loadingBar
	지워야 할 것 : LowerFrame
=============================================================================*/
%>	
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Purch/common/include/loadingSales.jsp">
	</iframe>	

	<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>	
	





<!--||| HEADER START |||-->
<div id="haHeader">
	<div id="haHeaderTop">
	<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
	  <TR>
		<TD width="158px" ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:2px"><img src=<%=dirPath%>/images/Common/logo.gif border=0></TD>
		<TD width="150px" valign="bottom" style="padding-bottom:1px"><FONT COLOR=#696969 style="font-weight:bold;padding-left:12px"><font size="-1" face="돋움" id=loginNM><%=gusrnm%></font>(<font size="-1" face="돋움" id=loginID><%=gusrid%></font>)님</td>
		<TD ALIGN=LEFT VALIGN=BOTTOM >
			<jsp:include page="/Common/sys/body_s_topIcon.jsp"  flush="true"/>		</TD>
		<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:1px"><font style="padding-right:12px;cursor:hand;" onclick="helpme();">도움말(F8)</font></TD>
	  </TR>
	</TABLE>
	</div>
	<div id="haHeaderMenu">
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:4px"><a href="#" onclick="moveMove('<%=dirPath%>/portal.jsp','');"><FONT COLOR=#FFFFFF style="font-weight:bold;">Home</font></a> <FONT COLOR=#FFFFFF style="font-weight:bold;">|</font> <a href="#" onclick="moveMove('<%=dirPath%>/Common/sys/logout.jsp','');"><FONT COLOR=#FFFFFF style="font-weight:bold;">Logout</font></a></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM   style="padding-bottom:5px"><FONT COLOR=#FFFFFF style="font-weight:bold;font-size:14px;padding-left:12px;" name=menu_title id=menu_title></font></TD>
					<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:4px"><FONT COLOR=#FFFFFF style="padding-right:12px;" name=menu_full id=menu_full></font></TD>
				  </TR>
				</TABLE>

	</div>
</div>


<!--||| MAIN CONTENTS START |||-->
<div id="haSubBody">
	<!--||| basic page CONTENTS |||-->

		<TABLE border=0 cellspacing=0 cellpadding=0 height=100%>
		  <TR>
			<TD VALIGN=top BGCOLOR=#E9F8FE STYLE="border-right:1 solid #DFDFDF;">
				<!-- 레프트 메뉴 패널 -->
				<DIV style='width:100%;height:23px;padding:4px' align=right>
					<img ID=leftMenuArrow src='<%=dirPath%>/images/Common/arrow_menuClose.gif' border=0 style='cursor:hand' onclick='togLeftMenu();'>
					<!-- open여부에 따라 이미지 소스결정...쿠키로 저장할 것.. -->
				</DIV>
				<DIV ID=leftMenuLayer style='width:157px;height:100%;padding-left:0px;padding-right:1px;display:;'>
				  <jsp:include page="/Common/sys/cm010i_13.jsp"  flush="true"/>				  
				</DIV>
				<!-- 레프트 메뉴 패널 -->
			</TD>
			<TD WIDTH=100% STYLE="padding-left:12px;padding-top:10px;" VALIGN=top>
<!-- BODY header end-->
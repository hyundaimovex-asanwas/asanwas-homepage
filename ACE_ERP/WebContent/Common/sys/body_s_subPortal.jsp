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

<% //로그인 체크 : 2008-11-27 심동현추가 
String vusrid="";

	Cookie[] cookies = request.getCookies();
	if ((cookies != null) && (cookies.length > 0)) {
		for(int i=0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			if(thisCookie.getName().equals("vusrid"))  vusrid      = thisCookie.getValue();
		}
	}

	if (vusrid==""||vusrid.length()==0) {    //경고와 함께 메인 화면으로 
		%>
		<script language="javascript">
			alert("정상 로그인하지 않았습니다.\n\n새로 로그인 해주세요!");
//			top.location.href="http://erp.hdasan.com";	//로컬개발용은 주석으로 막는다.
		</script>
		<%
	}
	///////////////////////////////////////////
%>

<script language="JavaScript">
	document.onkeydown = function() {	//전 페이지에 걸쳐 공용 스크립트.
		if( event.keyCode ==113 ) { //F2
			helpme();				//펑션 호출
            event.keyCode = 0;
            event.cancelBubble = true;
            event.returnValue = false;
		}
	}

	function helpme(){	//도움말 오픈 펑션
		window.open("<%=dirPath%>/Helpshop/baseFrame.jsp?menu_idx=<%=tree_idx%>","Helpshop","width=900px, height=700px, resizable=yes,");
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
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	

	<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Sales/common/html/progress.htm" width="400px" height="146px"></iframe>	
	

<TABLE width=100% height=100% border=0 cellspacing="0" cellpadding="0">
	<TR WIDTH="100%">
	  <TD WIDTH="100%" HEIGHT=80 VALIGN=top><!-- 탑메뉴 -->
		<TABLE CELLPADDING="0" CELLSPACING="0" border=0 width=100%>
		  <TR STYLE="height:42px;">
			<TD>
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:2px"><img src=<%=dirPath%>/images/Common/logo.gif border=0></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM   style="padding-bottom:1px"><FONT COLOR=#696969 style="font-weight:bold;padding-left:12px"><font size="-1" face="돋움" id=loginNM>홍길동</font>(<font size="-1" face="돋움" id=loginID>9010</font>)님　<!--[관리본부 > 경리부 > 전산팀]--></font></TD>
					<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:1px"><font style="padding-right:12px;cursor:hand;" onclick="helpme();">도움말(F2)</font></TD>
				  </TR>
				</TABLE>
			</TD>
		  </TR>
		  <TR STYLE="height:35px;">
			<TD Background=<%=dirPath%>/images/Common/topMenu_back.gif>
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:4px"><a href="#" onclick="top.location.href='/bank/bnk_TopIndex.htm'"><FONT COLOR=#FFFFFF style="font-weight:bold;">Home</font></a> <FONT COLOR=#FFFFFF style="font-weight:bold;">|</font> <a href="#" onclick="top.location.href='/hdasan.html'"><FONT COLOR=#FFFFFF style="font-weight:bold;">Logout</font></a></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM   style="padding-bottom:5px"><FONT COLOR=#FFFFFF style="font-weight:bold;font-size:14px;padding-left:12px;" name=menu_title id=menu_title></font></TD>
					<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:4px"><FONT COLOR=#FFFFFF style="padding-right:12px;" name=menu_full id=menu_full></font></TD>
				  </TR>
				</TABLE>
			</TD>
		  </TR>
		  <TR STYLE="height:3px;">
			<TD bgcolor=#FFD104></TD>
		  </TR>
		</TABLE>
	  </TD>
	</TR>
	<TR WIDTH="100%">
	  <TD WIDTH="100%" VALIGN=top>
		<TABLE border=0 cellspacing=0 cellpadding=0 height=100%>
		  <TR>
			<TD VALIGN=top BGCOLOR=#E9F8FE STYLE="border-right:1 solid #DFDFDF;">
				<!-- 레프트 메뉴 패널 -->
				<DIV style='width:100%;height:23px;padding:4px' align=right>
					<img ID=leftMenuArrow src='<%=dirPath%>/images/Common/arrow_menuClose.gif' border=0 style='cursor:hand' onclick='togLeftMenu();'>
					<!-- open여부에 따라 이미지 소스결정...쿠키로 저장할 것.. -->
				</DIV>
				<DIV ID=leftMenuLayer style='width:157px;height:100%;padding-left:0px;padding-right:1px;display:;'>
				  <jsp:include page="/Common/sys/cm010i.jsp"  flush="true"/>				  
				</DIV>
				<!-- 레프트 메뉴 패널 -->
			</TD>
			<TD WIDTH=100% STYLE="padding-left:12px;padding-top:10px;" VALIGN=top>
<!-- BODY header end-->

<script language=javascript>
	get_cookdata();
	//alert(loginNM);
    loginNM.innerHTML=GetCookie("vusrnm");
    loginID.innerHTML=GetCookie("vusrid");
</script>

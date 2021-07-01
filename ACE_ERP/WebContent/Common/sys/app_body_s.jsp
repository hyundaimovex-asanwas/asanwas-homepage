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
	
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad(<%=tree_idx%>);">
<script language=javascript>
	get_cookdata();
	//alert(loginNM);
    loginNM.innerHTML=GetCookie("vusrnm");
    loginID.innerHTML=GetCookie("vusrid");
</script>

<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="pms.common.HDConstant"%>


<%
	String dirPath = request.getContextPath();
	
	//최초 tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //받아온 현재 메뉴 값! fnOnLoad() 함수에 파라미터로 전달하여 메뉴구성!

    //로그인 체크 : 2013-12-04 심동현 수정 ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//페이지 이동시 세션ID 체크(이건 웬만한 곳은 하지 말끄나?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//페이지 이동시 세션변수("로긴") 체크
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크

	// (ssID + 유저포지션값 + IP) 비교
	//if(!ssID.equals(session.getId()) || !gusrip.equals(request.getRemoteAddr()) || !gusrpos.equals("Tadaima") ){
	//경고와 함께 메인 화면으로 
		%>
		<script language="javascript">
		//alert("시간이 오래되어 자동 로그아웃되었거나\n정상 접근이 아닙니다.\n\n새로 로그인 해주세요.");

		//window.close();	//창모드로 변경(2013-12-04)
		</script>
		<%
//		response.sendRedirect(dirPath+"/newIndeX.jsp");
		//return;
	//}
	//로그인 체크 끝 ///////////////////////////////////////////////////////////////////////////////////////
%>
	<form name="movForm" id="movForm" method="post">
		<input name="ssID" type="hidden" value="<%=session.getId()%>" />
	</form>
	<object id=ds_title classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object  id="tr_title" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	
	<script language="JavaScript"  for="ds_title" event="OnLoadCompleted(row)">
		//로드 완료하면 메뉴명/타이틀 세팅
		//alert(ds_title.namevalue(ds_title.rowposition,"MENU_NM"));
		//alert(ds_title.namevalue(ds_title.rowposition,"FULL_DIR_NM"));	
		menu_title.innerHTML = ds_title.namevalue(ds_title.rowposition,"MENU_NM");
		menu_full.innerHTML = ds_title.namevalue(ds_title.rowposition,"FULL_DIR_NM");
		document.title = ds_title.namevalue(ds_title.rowposition,"MENU_NM")+"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
	</script>	

	<script language="JavaScript">
	
		/* 현재 메뉴 닫기 */
		function mclose(){	
			window.close();
		}
	
		/* 트리 조회 */
		function fnInit_tree(tree_idx){
			//메뉴명세팅
			fnSetTitle(tree_idx);
		}
	
		/* 메뉴트리 조회하기 */
		function fnSetTitle(tree_idx){
			if(tree_idx==0){	//초기 인덱스화면인 경우
				menu_title.innerHTML = "시작";
				menu_full.innerHTML = "홈>인사관리>시작 ";
				document.title = "시작　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
			} else{

		        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
		   	     	+ "tree_idx=" + tree_idx;	//선택된 메뉴 idx를 던진다.
		        ln_TRSetting(tr_title, 
		            "/HDAsan<%=HDConstant.PATH_ERP_COMMON%>Cm011I_10",
		        	"JSP(O:TITLE=ds_title)",
		       		param);
		        tr_post(tr_title);
		    };
		}	
	</script> 


<body onLoad="fnOnLoad(<%=tree_idx%>);">

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
			Frameborder="0" src="/HDAsan/Purch/common/include/loadingSales.jsp">
	</iframe>	

	<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="/HDAsan/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>	
	



<!--||| HEADER START |||-->
<div id="haHeader">
	<div id="haHeaderTop">
	<table width="1000" border='0'>
	  <TR>
		<td class="c b" width="158px" style="padding-bottom:2px"><img src="<%=dirPath%>/images/Common/logo.gif" /></td>
		<td class="r b" width="12px" style="padding-bottom:1px">★</td>
		<td class="l b" style="padding-left:2px;padding-bottom:1px" id="msgTxt">메세지 영역입니다.&nbsp;</td>
		<td width="40px" class="r b" style="padding-bottom:1px;cursor:pointer;" onclick="mclose()"><img src="<%=dirPath%>/images/Common/nClose.gif" /></td>
	  </TR>
	</table>
	</div>
	<div id="haHeaderMenu">
		<table width="1000" border='0'>
		  <TR>
			<td class="c b bold" width="158px" style="padding-bottom:0px; color:#111111;"><%=gusrnm%>(<%=gusrid%>)님</td>
			<td class="l b bold" style="padding-bottom:0px;color:#111111;font-size:14px;padding-left:12px;" id="menu_title">&nbsp;</td>
			<td class="r b" style="color:#111111; padding-bottom:0px;padding-right:1px;" id="menu_full">&nbsp;</td>
		  </TR>
		</table>

	</div>
</div><!-- //HEADER START -->


<!-- MAIN CONTENTS START -->
<div id="haSubBody">
		<table border=0 cellspacing=0 cellpadding=0 height=100% >
		  <TR>
			<td VALIGN=top BGCOLOR=#E9F8FE STYLE="border-right:1 solid #DFDFDF;">			</td>
			<td WIDTH=100% STYLE="padding-left:12px;padding-top:10px;" VALIGN=top>
<!-- BODY header end-->


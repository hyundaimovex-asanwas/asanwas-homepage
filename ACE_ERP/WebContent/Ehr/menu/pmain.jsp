<!--
*****************************************************
* @source       : pmain.jsp
* @description : MAIN PAGE :: 메인프레임
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/08/29      한학현        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.support.collection.CBox,com.shift.gef.support.collection.CollectionUtility,com.shift.gef.support.utility.SessionUtil,com.shift.gef.configuration.Configuration" %>
<%
	CBox box = CollectionUtility.getGauceDataBox(request);
	box  = SessionUtil.getSession(request, box);
%>

<!-- Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}</script>

<html>
<head>
<title>현대아산  신인사시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<script language=javascript src="/common/common.js"></script>

<!-- 프로그램 사용 로그 저장을 위한 데이터셋 -->
<comment id="__NSID__">
<object id=dsT_CM_ACCESSLOG classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
    <param name=Syncload    value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<!-- menu_id 조회용 -->
<comment id="__NSID__">
<object id=dsT_CM_MENULST classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
    <param name=Syncload    value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<script language="javascript">
//창고정 아이콘을 위한 이미지 데이터 로딩(16X16의 bmp파일만 가능하며 절대경로로 표현해주어야한다.)
//frame.SetInnerData("01", "/images/common/01.bmp");
//frame.SetInnerData("02", "/images/common/02.bmp");

//상단 메뉴 프레임
frame.CreateFrame("top", "/menu/top.jsp", "top", 0, 0, "100%", "70",  "sunken", 0, 0,false);
//프레임을 parent frame의 최상단에 고정시킨다.
frame.top.DockingTop();
//창의 네비게이션 이동을 제한한다.
frame.top.NavigateLock = true;

//좌측 트리메뉴 프레임
frame.CreateFrame("left", "/menu/leftmenu.jsp", "left", 0, 70, "170", "100%", "sunken", 0, 0, false);
//프레임을 parent frame의 왼쪽에 고정시킨다.
frame.left.DockingLeft();
//창의 네비게이션 이동을 제한한다.
frame.left.NavigateLock = true;
//창이 움직여지지 않게 막기
frame.FrameLock = true;

//alert( screen.width+",    "+screen.height);//해상도
//alert(frame.XPos+",  "+frame.YPos+",  "+frame.width+",  "+frame.height);

//바디 프레임
frame.CreateFrame("body", "/menu/body.jsp", "body", 170, 70, (frame.width-170),(frame.height-94), "sunken", 0, 0, false);//하단관련 설정
//frame.CreateFrame("body", "/menu/body.jsp", "body", 170, 70, (frame.width-170),(frame.height-70), "sunken", 0, 0, false);
frame.body.NavigateLock = true;


//하단 copyfright 프레임
frame.CreateFrame("bottom", "/menu/bottom.jsp", "bottom", 170, (frame.height-24), (frame.width-170), 24, "sunken", 0, 0, false);
//프레임을 parent frame의 하단에 고정시킨다.
frame.bottom.DockingBottom();
//창의 네비게이션 이동을 제한한다.
frame.bottom.NavigateLock = true;

if("<%=box.get("MENU_ID")%>" != ""){
    var curFrame = frame.Provider("body");

    dsT_CM_MENULST.DataId="../../servlet/GauceChannelSVL?cmd=common.menu.userauth.cmd.USERAUTHCMD&S_MODE=SHR_05&GUBUN="+"<%=box.get("SESSION_GUBUN")%>"+"&ENO_NO="+"<%=box.get("SESSION_ENONO")%>"+"&MENU_ID="+"<%=box.get("MENU_ID")%>";
    dsT_CM_MENULST.Reset();

    var MENU_ID      = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_ID");  //메뉴 ID
    var FORM_ID      = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"FORM_ID");  //JSP Form(File) ID
    var MENU_NM      = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_NM")+"("+ FORM_ID + ")"; //메뉴명
    var MENU_FLD     = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_FLD"); //메뉴 폴더
    var MENU_GBN     = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_GBN"); //메뉴구분(f:Form, m:Menu p:Popup)
    var MENU_URL     = MENU_FLD + FORM_ID + ".jsp";                                     //MENU URL

    //프로그램 사용 로그 저장
    if("<%=box.get("SESSION_ENONO")%>" != "90000160"){
        dsT_CM_ACCESSLOG.DataId="/servlet/GauceChannelSVL?cmd=common.menu.accesslog.cmd.ACCESSLOGCMD&S_MODE=SAV&PROG_ID="+FORM_ID+"&ACT_GBN=O";
        dsT_CM_ACCESSLOG.Reset();
    }

    curFrame.CreateFrame(MENU_ID, MENU_URL, MENU_NM, 0, 0, 860, 550, "window", 0,"showmaximized", true);
    curFrame.Provider(MENU_ID).ShowMaxCaption=false;     //Title Bar Hidden
}


// 전체 메인 창닫기
function cfClosePop(){
	opener.close();
}

// 리사이즈
function cfResize(){
    frame.body.width = (frame.width-170);
    frame.body.height = (frame.height-94);

    frame.bottom.width = (frame.width-170);
}

</script>

<body scroll="no" onResize="cfResize();" onload="">
</body>

</html>
<!--
*****************************************************
* @source       : pmain.jsp
* @description : MAIN PAGE :: ����������
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/08/29      ������        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.support.collection.CBox,com.shift.gef.support.collection.CollectionUtility,com.shift.gef.support.utility.SessionUtil,com.shift.gef.configuration.Configuration" %>
<%
	CBox box = CollectionUtility.getGauceDataBox(request);
	box  = SessionUtil.getSession(request, box);
%>

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>����ƻ�  ���λ�ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<script language=javascript src="/common/common.js"></script>

<!-- ���α׷� ��� �α� ������ ���� �����ͼ� -->
<comment id="__NSID__">
<object id=dsT_CM_ACCESSLOG classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
    <param name=Syncload    value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<!-- menu_id ��ȸ�� -->
<comment id="__NSID__">
<object id=dsT_CM_MENULST classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
    <param name=Syncload    value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<script language="javascript">
//â���� �������� ���� �̹��� ������ �ε�(16X16�� bmp���ϸ� �����ϸ� �����η� ǥ�����־���Ѵ�.)
//frame.SetInnerData("01", "/images/common/01.bmp");
//frame.SetInnerData("02", "/images/common/02.bmp");

//��� �޴� ������
frame.CreateFrame("top", "/menu/top.jsp", "top", 0, 0, "100%", "70",  "sunken", 0, 0,false);
//�������� parent frame�� �ֻ�ܿ� ������Ų��.
frame.top.DockingTop();
//â�� �׺���̼� �̵��� �����Ѵ�.
frame.top.NavigateLock = true;

//���� Ʈ���޴� ������
frame.CreateFrame("left", "/menu/leftmenu.jsp", "left", 0, 70, "170", "100%", "sunken", 0, 0, false);
//�������� parent frame�� ���ʿ� ������Ų��.
frame.left.DockingLeft();
//â�� �׺���̼� �̵��� �����Ѵ�.
frame.left.NavigateLock = true;
//â�� ���������� �ʰ� ����
frame.FrameLock = true;

//alert( screen.width+",    "+screen.height);//�ػ�
//alert(frame.XPos+",  "+frame.YPos+",  "+frame.width+",  "+frame.height);

//�ٵ� ������
frame.CreateFrame("body", "/menu/body.jsp", "body", 170, 70, (frame.width-170),(frame.height-94), "sunken", 0, 0, false);//�ϴܰ��� ����
//frame.CreateFrame("body", "/menu/body.jsp", "body", 170, 70, (frame.width-170),(frame.height-70), "sunken", 0, 0, false);
frame.body.NavigateLock = true;


//�ϴ� copyfright ������
frame.CreateFrame("bottom", "/menu/bottom.jsp", "bottom", 170, (frame.height-24), (frame.width-170), 24, "sunken", 0, 0, false);
//�������� parent frame�� �ϴܿ� ������Ų��.
frame.bottom.DockingBottom();
//â�� �׺���̼� �̵��� �����Ѵ�.
frame.bottom.NavigateLock = true;

if("<%=box.get("MENU_ID")%>" != ""){
    var curFrame = frame.Provider("body");

    dsT_CM_MENULST.DataId="../../servlet/GauceChannelSVL?cmd=common.menu.userauth.cmd.USERAUTHCMD&S_MODE=SHR_05&GUBUN="+"<%=box.get("SESSION_GUBUN")%>"+"&ENO_NO="+"<%=box.get("SESSION_ENONO")%>"+"&MENU_ID="+"<%=box.get("MENU_ID")%>";
    dsT_CM_MENULST.Reset();

    var MENU_ID      = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_ID");  //�޴� ID
    var FORM_ID      = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"FORM_ID");  //JSP Form(File) ID
    var MENU_NM      = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_NM")+"("+ FORM_ID + ")"; //�޴���
    var MENU_FLD     = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_FLD"); //�޴� ����
    var MENU_GBN     = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition,"MENU_GBN"); //�޴�����(f:Form, m:Menu p:Popup)
    var MENU_URL     = MENU_FLD + FORM_ID + ".jsp";                                     //MENU URL

    //���α׷� ��� �α� ����
    if("<%=box.get("SESSION_ENONO")%>" != "90000160"){
        dsT_CM_ACCESSLOG.DataId="/servlet/GauceChannelSVL?cmd=common.menu.accesslog.cmd.ACCESSLOGCMD&S_MODE=SAV&PROG_ID="+FORM_ID+"&ACT_GBN=O";
        dsT_CM_ACCESSLOG.Reset();
    }

    curFrame.CreateFrame(MENU_ID, MENU_URL, MENU_NM, 0, 0, 860, 550, "window", 0,"showmaximized", true);
    curFrame.Provider(MENU_ID).ShowMaxCaption=false;     //Title Bar Hidden
}


// ��ü ���� â�ݱ�
function cfClosePop(){
	opener.close();
}

// ��������
function cfResize(){
    frame.body.width = (frame.width-170);
    frame.body.height = (frame.height-94);

    frame.bottom.width = (frame.width-170);
}

</script>

<body scroll="no" onResize="cfResize();" onload="">
</body>

</html>
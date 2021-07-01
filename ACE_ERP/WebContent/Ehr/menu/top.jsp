<!--
*****************************************************
* @source       : top.jsp
* @description : TOP PAGE :: top menu
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/09/05      ������        ���� �ۼ�.
* 2006/10/25      �輮��        ���� ����
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>

<%@ include file="/common/sessionCheck.jsp" %>

<%
    String fileName = "HR_SYSTEM(USER)_MANUAL.doc";
    String downloadURL = Configuration.getInstance().get("framework.file.download")+"/"+fileName;
%>

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>top menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>

<script language="JavaScript">
<!-- // ��ũ �̹����� ���� ����
function bluring(){
if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus();
}
document.onfocusin=bluring;
// -->
</script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

	var curFrame = frame.opener.frame.Provider("body");
	var ROLE_CD = "<%=box.get("SESSION_ROLE_CD")%>";

	var imgFlag = "N";

	/************************************
	* MDI Child�� ������ ��� Form ���� *
	************************************/
	function fnc_FormSort(sType) {

		curFrame.ChildWndCollection();
		curFrame.SortFrameEx("cascade", "noresize", 0, 0);

	}

	/**********************
	*  Current Form Close *
	**********************/
	function fnc_FormManage(s_mode) {

		//Ȱ��ȭ�Ǿ� �ִ� ��� â�� ������ �����´�.
		curFrame.ChildWndCollection();

		if (curFrame.ActiveFrame==null) return;    //���õ� ȭ���� �ִ��� üũ
		var idx = curFrame.ActiveFrame.FrameID;    //Form Index ���

		if (s_mode == "Max") {
			curFrame.Provider(idx).ShowMaxCaption= true;
			curFrame.Provider(idx).FrameShow("maximize");
			curFrame.Provider(idx).ShowMaxCaption= false;
		} else if (s_mode == "Min") {
			curFrame.Provider(idx).ShowMaxCaption= true;
			curFrame.Provider(idx).FrameShow("minimize");
			curFrame.Provider(idx).ShowMaxCaption= false;
		} else if (s_mode == "Normal") {
			curFrame.Provider(idx).ShowMaxCaption= true;
			curFrame.Provider(idx).FrameShow("shownormal");
			curFrame.Provider(idx).ShowMaxCaption= false;
		} else if (s_mode == "Close") {
			curFrame.Provider(idx).CloseFrame();
		} else if (s_mode == "Excel") {
			curFrame.Provider(idx).window.fnc_ToExcel();
		}

	}

	/************************************
	* MDI Child�� ������ ��� Form �ݱ� *
	************************************/
	function fnc_FormCloseAll() {

		//Ȱ��ȭ�Ǿ� �ִ� ��� â�� ������ �����´�.
		curFrame.ChildWndCollection();

		//���� Open�Ǿ� �ִ� â�� ���ٸ� �׳� ����
		if (curFrame.CollectionLength < 1) return;

		//��� â�� ���� �� ������ Question
		if (confirm("���� Ȱ��ȭ�Ǿ� �ִ� ��� ���� �����ðڽ��ϱ�?") == false) return;

		//���� ��� Form�� �ݴ´�.
		var tmpVal = "body";
		var curMDIFrame = frame.opener.frame.Provider(tmpVal);
		curMDIFrame.CloseFrameAll();

	}


	/*****************
	* System Logout  *
	*****************/
	function fnc_LogOut() {

		//��� â�� ���� �� ������ Question
		if (confirm("�� �ý����� �α� �ƿ� �Ͻðڽ��ϱ�?") == false) return;

		ds_LOGOUT.DataId="/servlet/GauceChannelSVL?cmd=common.menu.logout.cmd.LOGOUTCMD";
		ds_LOGOUT.reset();

	}

	/*****************
	* �����ȣ ����  *
	*****************/
    function fnc_ChangePassword() {

        url = "/common/popup/chgpwd.jsp";
        //��й�ȣ ���� ȭ�� ȣ��
        window.showModalDialog(url, self, "dialogHeight:280px; dialogWidth:630px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}

	/******************
	* Left Menu ReSet *
	******************/
	function fnc_MenuSetting(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10) {

		//Left Tree Menu Reset
		frame.opener.window.frame.opener.window.frame.Provider("left").window.fnc_MenuReSet(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10);

	}

	//���ã��
	function fnc_FavoritesSetting(){

		//Left Tree Menu Reset
		frame.opener.window.frame.opener.window.frame.Provider("left").window.fnc_FavoritesReSet();

	}

    //Ȱ��ȭ �޴� ����
    function fnc_ChangeMenu(){

        curFrame.ChildWndCollection();
        if(curFrame.CollectionLength < 1){
            alert("Ȱ��ȭ�� �޴��� �����ϴ�.");
            return false;
        }

        imgFlag = "Y";

        var mList = new Array();
        var mValue;
        curFrame.ChildWndCollection();
        for(var i=0; i<curFrame.CollectionLength; i++){
            mValue = new Array(3);
            mValue[0] = curFrame.item(i).FrameID;
            mValue[1] = curFrame.item(i).Title;
            mValue[2] = "F";

            mList[i] = mValue;
        }


        //alert(window.pageXOffset+"  "+window.pageXOffset);//��ǥ���ϴ°��ε� ie������
        //alert(window.event.clientX+"  "+window.event.clientY);//Ŭ����ǥ
        //alert(curFrame.XPos+",  "+curFrame.YPos+",  "+curFrame.width+",  "+curFrame.height);

        var ua = window.navigator.appVersion;
        var msie = ua.indexOf ( "MSIE " );
        var version = ua.substring(msie+5,msie+8);

        //���µ� �޴� ǥ��
        if (version >= "7.0") {
            window.showModalDialog("/common/popup/chgmenu.jsp", mList, "dialogHeight:260px; dialogWidth:150px; help:No; resizable:No; status:No; scroll:No; center:Yes;");//��ǥ���� dialogTop:50; dialogLeft:50;
        }else{
            window.showModalDialog("/common/popup/chgmenu.jsp", mList, "dialogHeight:312px; dialogWidth:256px; help:No; resizable:No; status:Yes; scroll:No; center:Yes;");//��ǥ���� dialogTop:50; dialogLeft:50;
        }

        var tmp = "";
        for(var i=0; i<curFrame.CollectionLength; i++){

            //������ ������ Ȱ��ȭ
            if(mList[i][2] == "T"){
                curFrame.Provider(mList[i][0]).FrameShow("maximize");
                return true;
            }

        }

    }


    function fnc_Imsi(){

		//�ӽ÷� �޼��� ����....
		alert("�� �޴��� 2�� ���� �Ϸ� �� ���� �� ���� �Դϴ�!");

	}

    /********************************************
     * 14. Form Load �� Default �۾� ó�� �κ�  *
     *******************************************/
    function fnc_OnLoadProcess() {

	    MM_preloadImages('/images/top/over_01.gif','/images/top/over_02.gif','/images/top/over_03.gif','/images/top/over_04.gif','/images/top/over_05.gif','/images/top/over_06.gif','/images/top/over_07.gif','/images/top/over_08.gif','/images/top/over_09.gif','/images/top/over_10.gif');

        //��� �޴� �Ⱥ�������
        fnc_HiddenElement("menu_pir");
        fnc_HiddenElement("menu_gun");
        fnc_HiddenElement("menu_edu");
        fnc_HiddenElement("menu_vlu");
        fnc_HiddenElement("menu_sag");
        fnc_HiddenElement("menu_wel");
        fnc_HiddenElement("menu_ret");
        fnc_HiddenElement("menu_mis");
        fnc_HiddenElement("menu_law");
        fnc_HiddenElement("menu_cod");

        var GUBUN  = '<%=box.get("SESSION_GUBUN")%>';
        var ENO_NO = '<%=box.get("SESSION_ENONO")%>';

        ds_MENU.DataId="/servlet/GauceChannelSVL?cmd=common.menu.userauth.cmd.USERAUTHCMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&ENO_NO="+ENO_NO;
        ds_MENU.Reset();

        var menu_id;
        var cnt;
        for(var i=1; i<=ds_MENU.CountRow; i++) {
            menu_id = ds_MENU.NameString(i, "UPMENU_ID");
            cnt     = ds_MENU.NameString(i, "CNT");

            if(cnt > 0 && menu_id != "eis") {
                fnc_ShowElement("menu_"+menu_id);
            }
        }
    }

    /**
     * �Ŵ��� �ٿ�ε� �ϱ�
     */
    function fnc_DownloadManual() {
        var down = "<%=downloadURL %>/hlc_manual.doc";

        alert(down);

        cfDownload(down, down);
    }

</script>

</head>


	<!------------------------------------+
    | 1. Logout�� DataSet				  |
    | 2. �̸� : dsT_CM_EMPLIST            |
    | 3. Table List :T_CM_EMPLIST         |
    +------------------------------------->
    <Object ID="ds_LOGOUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="ds_MENU" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=ds_LOGOUT Event="OnLoadCompleted(iCount)">

		var frame = window.external.GetFrame(window);
		frame.outerWindow.do_go();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=ds_LOGOUT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="0" topmargin="0" rightmargin="0" marginwidth="0" marginheight="0" onLoad="fnc_OnLoadProcess();" scroll="no">
<table width="100%" height="70px" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="68" bgcolor="FFFFF9" style="BACKGROUND-POSITION: right; BACKGROUND-IMAGE: url(/images/top/bgRight3.jpg); BACKGROUND-REPEAT: no-repeat">

            <table width="100%" height="68" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="BACKGROUND-POSITION: left; BACKGROUND-IMAGE: url(/images/top/bgLeft3.jpg); BACKGROUND-REPEAT: no-repeat">

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="220"></col>
                                <col width="170"></col>
                                <col width=""></col>
                            </colgroup>
							<tr>
                                <td rowspan="2"><img src="/images/top/logo.gif" width="220" height="68"></td>

                                <!-- ���޴� ���̺� ���� -->
                                <td height="37" valign="top" style="padding-left:50px;">
									<table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td><img src="/images/top/quickBgLeft.gif" width="21" height="18"></td>
                                            <!-- <td><img src="/images/top/quick1.gif" width="40" height="18"></td>
                                            <td><img src="/images/top/quick2.gif" width="55" height="18"></td>  -->
                                            <td><img src="/images/top/quick5.gif" width="71" height="18" style="border:0px;padding:0 0 0 0;cursor:hand" onClick="fnc_ChangePassword();" ></td>
                                            <td><img src="/images/top/quick4.gif" width="55" height="18" style="border:0px;padding:0 0 0 0;cursor:hand" onClick="fnc_LogOut();"></td>
                                            <td><img src="/images/top/quickBgRight.gif" width="21" height="18"></td>
                                        </tr>
                                    </table>
                                </td>

                                <td height="37" valign="top">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
											<td width="5" ><img src="/images/top/windowBgL.gif" width="5" height="22"></td>

											<td width="25" bgcolor="FCFBD2" style="padding:4 0 0 0">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image50','','/images/top/win_SortOver.gif',1)"><img OnClick="fnc_FormSort(1)" src="/images/top/win_SortOn.gif" name="Image50" width="16" height="14" border="0"></a>
											</td>
											<td width="18" bgcolor="FCFBD2" style="padding:4 0 0 0">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image51','','/images/top/win_MinOver.gif',1)"><img OnClick="fnc_FormManage('Min')" src="/images/top/win_MinOn.gif" name="Image51" width="16" height="14" border="0"></a>
											</td>
											<td width="18" bgcolor="FCFBD2" style="padding:4 0 0 0">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image52','','/images/top/win_MaxOver.gif',1)"><img OnClick="fnc_FormManage('Max')" src="/images/top/win_MaxOn.gif" name="Image52" width="16" height="14" border="0"></a>
											</td>
											<td width="18" bgcolor="FCFBD2" style="padding:4 0 0 0">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image53','','/images/top/win_NorOver.gif',1)"><img OnClick="fnc_FormManage('Normal')" src="/images/top/win_NorOn.gif" name="Image53" width="16" height="14" border="0"></a>
											</td>
											<td width="25" bgcolor="FCFBD2" style="padding:4 0 0 0">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image54','','/images/top/win_CloseOver.gif',1)"><img OnClick="fnc_FormManage('Close')" src="/images/top/win_CloseOn.gif" name="Image54" width="16" height="14" border="0"></a>
											</td>
											<td width="50" bgcolor="FCFBD2" style="padding:4 0 0 0">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image55','','/images/top/win_CloseAllOver.gif',1)"><img OnClick="fnc_FormCloseAll();" src="/images/top/win_CloseAllOn.gif" ID="Image55" width="30" height="14" border="0"></a>
											</td>
                                            <td width="62" bgcolor="FCFBD2" style="padding:4 0 0 0" align="right">
                                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="if(imgFlag != 'Y'){MM_swapImage('Image56','','/images/top/win_ChangeMenuOver.gif',1);}else{imgFlag = 'N';}"><img OnClick="fnc_ChangeMenu()" src="/images/top/win_ChangeMenuOn.gif" name="Image56" width="52" height="14" border="0"></a>
                                            </td>

											<td width="5"><img src="/images/top/windowBgR.gif" width="5" height="22"></td>

											<!-- <td><input type="button" value="�����ٿ�" OnClick="fnc_FormManage('Excel')"></td> -->

                                        </tr>
                                    </table>
								</td>
								<!-- ���޴� ���̺� �� -->

                            </tr>
                            <tr >
                                <td height="31" background="/images/top/naviBg.gif" colspan="2" align="left" valign="bottom">

									<!-- ���θ޴����̺� ���� -->
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <!-- �λ���� -->
                                            <td><img src="/images/top/menu_01.gif" name="menu_pir" height="31" border="0" OnClick="fnc_MenuSetting('pir');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_pir','','/images/top/over_01.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- ���°��� -->
                                            <td><img src="/images/top/menu_02.gif" name="menu_gun" height="31" border="0" OnClick="fnc_MenuSetting('gun');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_gun','','/images/top/over_02.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- �������� -->
                                            <td><img src="/images/top/menu_03.gif" name="menu_edu" height="31" border="0" OnClick="fnc_MenuSetting('edu');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_edu','','/images/top/over_03.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                             <!-- �λ��� -->
                                            <td><img src="/images/top/menu_04.gif" name="menu_vlu" height="31" border="0" OnClick="fnc_MenuSetting('vlu');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_vlu','','/images/top/over_04.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- ������� -->
                                            <td><img src="/images/top/menu_05.gif" name="menu_sag" height="31" border="0" OnClick="fnc_MenuSetting('sag');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_sag','','/images/top/over_05.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- �����Ļ� -->
                                            <td><img src="/images/top/menu_06.gif" name="menu_wel" height="31" border="0" OnClick="fnc_MenuSetting('wel');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_wel','','/images/top/over_06.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- ���꼼�� -->
                                            <td><img src="/images/top/menu_07.gif" name="menu_ret" height="31" border="0" OnClick="fnc_MenuSetting('ret');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_ret','','/images/top/over_07.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- �濵���� -->
                                            <td><img src="/images/top/menu_08.gif" name="menu_mis" height="31" border="0" OnClick="fnc_MenuSetting('mis');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_mis','','/images/top/over_08.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- �������� -->
                                            <td><img src="/images/top/menu_09.gif" name="menu_law" height="31" border="0" OnClick="fnc_MenuSetting('law');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_law','','/images/top/over_09.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>
                                            <!-- �������� -->
                                            <td><img src="/images/top/menu_10.gif" name="menu_cod" height="31" border="0" OnClick="fnc_MenuSetting('cod');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('menu_cod','','/images/top/over_10.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></td>

                                        </tr>
                                    </table>
									<!-- ���θ޴� ���̺� �� -->

								</td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </table>

        </td>
        <td width="30">
        </td>
    </tr>
    <tr>
        <td height="2" bgcolor="#97C821"></td>
        <td></td>
    </tr>
</table>
</body>

</html>
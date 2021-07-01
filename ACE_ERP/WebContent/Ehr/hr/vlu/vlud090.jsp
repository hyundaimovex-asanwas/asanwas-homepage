<!--
    ************************************************************************************
    * @Source         : vlud090.jsp                                                    *
    * @Description    : ���κ��򰡰����Ȳ PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/05  |  ������   | �����ۼ�                                               *
    * 2007/03/19  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>���κ��򰡰����Ȳ(vlud090)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY1 = form1.txtEVL_YY1_SHR.value;
            var EVL_YY2 = form1.txtEVL_YY2_SHR.value;
            var ENO_NO  = form1.txtENO_NO_SHR.value;

            // ��ȸ�� �� �ʵ��� ��ȿ��üũ
            if (!fnc_SearchItemCheck()) {
                return;
            }

            // �׸��� ������ ��ȸ ��
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud090.cmd.VLUD090CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2;
            dsT_EV_TYPE.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

 			var EVL_YY1 = form1.txtEVL_YY1_SHR.value;
            var EVL_YY2 = form1.txtEVL_YY2_SHR.value;
            var ENO_NO  = form1.txtENO_NO_SHR.value;

			params = "GUBUN=" + GUBUN + "&EVL_YY1="+EVL_YY1 + "&EVL_YY2="+EVL_YY2+"&ENO_NO="+ENO_NO;

			var url = "vlud090_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            form1.txtEVL_YY1_SHR.value = getToday().substr(0,4);
            form1.txtEVL_YY2_SHR.value = getToday().substr(0,4);

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_TYPE.ClearData();
            dsT_EV_ABLRST.ClearData();

            document.form1.txtENO_NO_SHR.focus();

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            if (form1.txtEVL_YY1_SHR.value == "") {
                alert("���۳⵵�� �ʼ��Է»����Դϴ�.");
                form1.txtEVL_YY1_SHR.focus();
                return false;
            }

            if (form1.txtEVL_YY2_SHR.value == "") {
                alert("����⵵�� �ʼ��Է»����Դϴ�.");
                form1.txtEVL_YY2_SHR.focus();
                return false;
            }


            if (form1.txtENO_NO_SHR.value == "") {
                alert("����� �ʼ��Է»����Դϴ�.");
                form1.txtENO_NO_SHR.focus();
                return false;
            }

            if( !cfCheckYearTerm('txtEVL_YY1_SHR','txtEVL_YY1_SHR','txtEVL_YY2_SHR') )
                return false;
            else
                return true;

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            var EVL_YY1  = null;
            var EVL_YY2  = null;

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","false");

            form1.txtEVL_YY1_SHR.value = getToday().substr(0,4);
            form1.txtEVL_YY2_SHR.value = getToday().substr(0,4);

            EVL_YY1 = form1.txtEVL_YY1_SHR.value;
            EVL_YY2 = form1.txtEVL_YY2_SHR.value;

            // Form Load ��
            form1.txtFLAG.value = "0";

            // ��������
            if (frameid == "vlud090") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            // DATASET �ʱ�ȭ
            fnc_Clear();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud090.cmd.VLUD090CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2;
            dsT_EV_TYPE.Reset();

            form1.txtEVL_YY1_SHR.focus();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /*****************************************************
         * �����ʵ� �� ����� �׸��� �÷� SETTING ó�� �κ�  *
         ****************************************************/
        function fnc_ChangeColumn() {

            var ABL_CNT = dsT_EV_TYPE.NameValue(1, "ABL_CNT");
            var ACH_CNT = dsT_EV_TYPE.NameValue(1, "ACH_CNT");

            // ������
            // �׸��忡�� ������ ������ŭ ������ �����÷��� �����ش�.
            if (ABL_CNT == '1') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "false";

            }
            else if (ABL_CNT == '2') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "false";

            }
            else if (ABL_CNT == '3') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "false";

            }
            else if (ABL_CNT == '4') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "true";

            }

            // ������
            // �׸��忡�� ������ ������ŭ ������ �����÷��� �����ش�.
            if (ACH_CNT == '1') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "false";

            }
            else if (ACH_CNT == '2') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "false";

            }
            else if (ACH_CNT == '3') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "false";

            }
            else if (ACH_CNT == '4') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "true";

            }

        }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)    |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_TYPE)      |
    | 3. ���Ǵ� Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ABLRST.CountRow);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var EVL_YY1 = form1.txtEVL_YY1_SHR.value;
        var EVL_YY2 = form1.txtEVL_YY2_SHR.value;
        var ENO_NO  = form1.txtENO_NO_SHR.value;

        if (iCount < 1) {

            alert("�򰡱��������� �Ǿ� ���� �ʽ��ϴ�.");
            document.getElementById("resultMessage").innerText = '* �򰡱��������� �Ǿ� ���� �ʽ��ϴ�.';

            dsT_EV_TYPE.ClearData();
            dsT_EV_ABLRST.ClearData();

        }
        else {

            // ���а��� ���� �׸��忡 ������/������ ���� �÷��� ��������.
            fnc_ChangeColumn();

            if (form1.txtFLAG.value == "1") {

                dsT_EV_ABLRST.ClearData();

                dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud090.cmd.VLUD090CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2+"&ENO_NO="+ENO_NO;
                dsT_EV_ABLRST.Reset();

                form1.grdT_EV_ABLRST.Focus();
            }
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>



<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ��򰡰����Ȳ</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">���κ��򰡰����Ȳ</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="150"></col>
                                <col width="50"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtEVL_YY1_SHR" name="txtEVL_YY1_SHR" size="4" maxlength="4" style="ime-mode:disabled" onKeyPress="cfNumberCheck();" onChange="if(!cfCheckYearTerm('txtEVL_YY1_SHR','txtEVL_YY1_SHR','txtEVL_YY2_SHR')) return;">�� ~ <input id="txtEVL_YY2_SHR" name="txtEVL_YY2_SHR" size="4" maxlength="4" style="ime-mode:disabled" onKeyPress="cfNumberCheck();" onChange="if(!cfCheckYearTerm('txtEVL_YY2_SHR','txtEVL_YY1_SHR','txtEVL_YY2_SHR')) return;">��
                                </td>
                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="9" maxlength="9" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();  cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="16" class="input_ReadOnly" readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle"   onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1')"></a>
                                <input type=hidden name=txtFLAG>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"               value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"             value="false">
                            <param name="DragDropEnable"       value="true">
                            <param name="SortView"             value="Left">
                            <param name="ColSizing"            value="true">
                            <param name="FixSizing"            value="true">
                            <param name="VIEWSUMMARY"          value=0>
                            <param name="Format"               value="
                                <FC> id='EVL_YY'               width=95    name='�⵵'     align=center </FC>
                                <G> name='������'   HeadBgColor='#F7DCBB'
                                    <C> id='FINAL_GRD11'       width=95    name='1ȸ��'    align=center </C>
                                    <C> id='FINAL_GRD12'       width=95    name='2ȸ��'    align=center </C>
                                    <C> id='FINAL_GRD13'       width=95    name='3ȸ��'    align=center show=false </C>
                                    <C> id='FINAL_GRD14'       width=95    name='4ȸ��'    align=center show=false </C>
                                </G>
                                <G> name='������'   HeadBgColor='#F7DCBB'
                                    <C> id='FINAL_GRD21'       width=95    name='1ȸ��'     align=center </C>
                                    <C> id='FINAL_GRD22'       width=95    name='2ȸ��'     align=center show=false </C>
                                    <C> id='FINAL_GRD23'       width=95    name='3ȸ��'     align=center show=false </C>
                                    <C> id='FINAL_GRD24'       width=95    name='4ȸ��'     align=center show=false </C>
                                </G>
                                <G> name='������'   HeadBgColor='#F7DCBB'
                                    <C> id='FINAL_GRD31'       width=95    name='1ȸ��'     align=center </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>
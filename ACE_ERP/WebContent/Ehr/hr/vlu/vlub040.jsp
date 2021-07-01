<!--
    ************************************************************************************
    * @Source         : vlub040.jsp                                                    *
    * @Description    : ������ó�� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/26  |  ������   | �����ۼ�                                               *
    * 2007/03/16  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>������(vlub040)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //��������
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFFFFFFT';
        var EVL_GBN = "1";

        //���â���� ����� ��� �����ϱ� ���� ��� by DS
        var modal_yn = window.dialogArguments;

        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            // DATASET �ʱ�ȭ
            fnc_Clear();

            // �⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.reset();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            document.getElementById("resultMessage").innerText = ' ';

            dsT_EV_ESTINFO.ClearData();
            dsT_EV_SCHCHG.ClearData();
            dsT_EV_EVLIST_DT.ClearData();

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_EVLIST_DT,0,"false","right");

            if (modal_yn == null) {
                var frameid = window.external.GetFrame(window).FrameId;
            }

            // ��������
            if (frameid == "vlub040" || "<%=GUBUN%>" == "01") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            // �׸��忡 ���κ������򰡴���ڼ��� ������ ��ȸ
            fnc_SearchList();

            form1.grdT_EV_EVLIST_DT.ColumnProp("{currow}", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("DEGREE_GBN", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("GROUP_CD", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("HEAD_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("DPT_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("JOB_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("ENO_NO", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("ENO_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("HIRG_YMD", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("DPA_YMD", "Sort") = "false";

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if(modal_yn != null){
                window.close();
            } else {
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(TEST_MAIN)      |
    | 3. ���Ǵ� Table List(TEST_MAIN)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_SCHCHG)    |
    | 3. ���Ǵ� Table List(T_EV_SCHCHG)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_SCHCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(TEST_MAIN)      |
    | 3. ���Ǵ� Table List(TEST_MAIN)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">
        if ( iCount == 0 )    {

            alert("������Ⱓ�� �ƴմϴ�.");
            document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';

        } else {

            form1.txtEVL_YY_SHR.value    = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value   = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");
            form1.txtEVLENO_NO_SHR.value = '<%=box.get("SESSION_ENONO")%>';
            form1.txtEVLENO_NM_SHR.value = '<%=box.get("SESSION_ENONM")%>';
            form1.txtEVLDPT_NM_SHR.value = '<%=box.get("SESSION_DPTNM")%>';

            // ��ܺ� ������ ��ȸ
            dsT_EV_SCHCHG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub040.cmd.VLUB040CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtEVLENO_NO_SHR.value;
            dsT_EV_SCHCHG.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_SCHCHG Event="OnLoadCompleted(iCount)">

        var EVL_YY  = null;
        var EVL_FRQ = null;

        if ( iCount == 0 )    {

            form1.txtIPT_STDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
            form1.txtIPT_ENDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

        } else {

            if (dsT_EV_SCHCHG.NameValue(1, "IPT_STDT") == "") {

                form1.txtIPT_STDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
                form1.txtIPT_ENDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

            }
            else {

                form1.txtIPT_STDT_SHR.value = dsT_EV_SCHCHG.NameValue(1, "IPT_STDT");
                form1.txtIPT_ENDT_SHR.value = dsT_EV_SCHCHG.NameValue(1, "IPT_ENDT");
            }
        }


        EVL_YY  = form1.txtEVL_YY_SHR.value;
        EVL_FRQ = form1.txtEVL_FRQ_SHR.value;
        ENO_NO  = form1.txtEVLENO_NO_SHR.value;

        // �׸��� ������ ��ȸ
        dsT_EV_EVLIST_DT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub040.cmd.VLUB040CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO;
        dsT_EV_EVLIST_DT.Reset();

        form1.grdT_EV_EVLIST_DT.Focus();

        // �������ڰ� ���Է±Ⱓ������ ���̸� ��ǥ �˾� Ŭ�� �����ϵ��� ��
        if (form1.txtIPT_STDT_SHR.value <= getToday() &&
            form1.txtIPT_ENDT_SHR.value >= getToday()) {

            ;

        }
        else {

            alert('���Է±Ⱓ�� �ƴմϴ�.');
            document.getElementById("resultMessage").innerText = '* ���Է±Ⱓ�� �ƴմϴ�.';
            form1.txtFLAG.value = "1";

        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_EVLIST_DT.CountRow);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- �׸����� �˾��ʵ� Ŭ���� -->
    <script language="javascript" for=grdT_EV_EVLIST_DT event=OnDblClick(Row,Colid)>

        var EVL_YY     = form1.txtEVL_YY_SHR.value;
        var EVL_FRQ    = form1.txtEVL_FRQ_SHR.value;
        var IPT_STDT   = form1.txtIPT_STDT_SHR.value;
        var IPT_ENDT   = form1.txtIPT_ENDT_SHR.value;
        var EVLENO_NO  = form1.txtEVLENO_NO_SHR.value;
        var EVLENO_NM  = form1.txtEVLENO_NM_SHR.value;
        var GROUP_CD   = dsT_EV_EVLIST_DT.NameValue(Row, "GROUP_CD");
        var DEGREE_GBN = dsT_EV_EVLIST_DT.NameValue(Row, "DEGREE_GBN");
        var ENO_NO     = dsT_EV_EVLIST_DT.NameValue(Row, "ENO_NO");
        var ENO_NM     = dsT_EV_EVLIST_DT.NameValue(Row, "ENO_NM");
        var DPT_NM     = dsT_EV_EVLIST_DT.NameValue(Row, "DPT_NM");
        var UPDN_GBN   = dsT_EV_EVLIST_DT.NameValue(Row, "UPDN_GBN");

        var revck    = null;

        // �򰡱Ⱓ�� �ƴ� ��� �˾�â ���� �ʵ��� ��.
        if (form1.txtFLAG.value == "1") {
        }
        else {

            //modal������ ���� ���� confirm�� ���ڸ��� �޾� �´�.
            url = "/hr/" + "vlu" + "/" + "vlub041.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&IPT_STDT="+IPT_STDT+"&IPT_ENDT="+IPT_ENDT+
                                                              "&EVLENO_NO="+EVLENO_NO+"&EVLENO_NM="+EVLENO_NM+"&GROUP_CD="+GROUP_CD+"&DEGREE_GBN="+DEGREE_GBN+
                                                              "&ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM+"&UPDN_GBN="+UPDN_GBN;

            // ������ǥ ȭ�� ȣ��
            revck = window.showModalDialog(url, Colid, "dialogHeight:850px; dialogWidth:1080px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null) {
                ;
            }
            else {
                // ������ ������ǥ�� �������� �ش� �÷��� �־���
                dsT_EV_EVLIST_DT.NameValue(Row,"EVL_PNT") = revck;
            }

            dsT_EV_EVLIST_DT.RowPosition = Row;
            form1.grdT_EV_EVLIST_DT.focus();
        }

    </script>



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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image8" width="60" height="20" border="0" align="absmiddle"  onClick="fnc_Exit()"></a>
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
                                    <col width="60"></col>
                                    <col width="40 "></col>
                                    <col width="40 "></col>
                                    <col width="30 "></col>
                                    <col width="70 "></col>
                                    <col width="180"></col>
                                    <col width="40 "></col>
                                    <col width="80"></col>
                                    <col width="40 "></col>
                                    <col width="65 "></col>
                                    <col width="45 "></col>
                                    <col width="65 "></col>
                                </colgroup>
                            <tr>
                                <td align="center" class="searchState">�򰡳⵵</td>
                                <td class="padding2423"><input id=txtEVL_YY_SHR name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">ȸ��</td>
                                <td class="padding2423"><input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">�򰡱Ⱓ</td>
                                <td class="padding2423">
                                    <input id=txtIPT_STDT_SHR name=txtIPT_STDT_SHR size="10" class="input_ReadOnly" readonly> ~
                                    <input id=txtIPT_ENDT_SHR name=txtIPT_ENDT_SHR size="10" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">�Ҽ�</td>
                                <td class="padding2423"><input id=txtEVLDPT_NM_SHR name=txtEVLDPT_NM_SHR size="14" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">���</td>
                                <td class="padding2423"><input id=txtEVLENO_NO_SHR name=txtEVLENO_NO_SHR size="8" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">����</td>
                                <td class="padding2423"><input id=txtEVLENO_NM_SHR name=txtEVLENO_NM_SHR size="8" class="input_ReadOnly" readonly></td>
                                <!-- Hidden Filed -->
                                <input type=hidden id=txtEVL_GBN_SHR  name=txtEVL_GBN_SHR>
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
                        <object    id="grdT_EV_EVLIST_DT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_EVLIST_DT">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="ColSizing"               value="true">
                            <param name="IndWidth"                value=0>
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id={currow}       width=33    name='����',         align=center </C>
                                <C> id='GROUP_NM'     width=75    name='�򰡱׷�'      align=left   </C>
                                <C> id='HEAD_NM'      width=80    name='����'          align=left   </C>
                                <C> id='DPT_NM'       width=80    name='�Ҽ�'          align=left   </C>
                                <C> id='DEGREE_GBN'   width=60    name='��������'      align=center </C>
                                <C> id='JOB_NM'       width=75    name='����'          align=center </C>
                                <C> id='ENO_NO'       width=75    name='���'          align=center </C>
                                <C> id='ENO_NM'       width=75    name='����'          align=center </C>
                                <C> id='HIRG_YMD'     width=75    name='�Ի���'        align=center </C>
                                <C> id='DPA_YMD'      width=75    name='�Ҽӹ߷���'    align=center </C>
                                <C> id='EVL_PNT'      width=75    name='������'      align=right   sort='true'</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td class="searchState"><br> * �ش� ������ �׸��� ����Ŭ�� �ϼ���~! </td>
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
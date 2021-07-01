<!--
*****************************************************
* @source       : vlue010.jsp
* @description : �����޹ݿ� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/27      ���ؼ�        �����ۼ�.
* 2007/03/19      ������        ����. (�����򰡾������� �߰�)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����޹ݿ�(vlue010)</title>
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

        var saveDiv = false;    //save���� ����
        var btnList = 'TFTTFTFT';
        var year = getToday().substr(0, 4);

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����(�����޹ݿ���ȸ)
            dsT_EV_EVLAPPLY.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SHR&GUBUN="+GUBUN+"&cmbEVL_YY_SHR="+document.getElementById("cmbEVL_YY_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value;
            dsT_EV_EVLAPPLY.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�����ͼ� ����(�򰡱����������� ��ȸ)
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck('0') )    return;

            //Ʈ����� ����
            trT_EV_EVLAPPLY.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SAV";
            trT_EV_EVLAPPLY.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_EVLAPPLY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_EVLAPPLY.GridToExcel("�����޹ݿ�", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_EVLAPPLY_01.CountColumn == 0) {
                dsT_EV_EVLAPPLY_01.setDataHeader("EVL_YY:STRING, ENO_NO:STRING, DPT_CD:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_EVLAPPLY_01.AddRow();
            dsT_EV_EVLAPPLY_01.NameValue(1,"EVL_YY") = document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_EVLAPPLY_01.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;
            dsT_EV_EVLAPPLY_01.NameValue(1,"DPT_CD") = document.getElementById("txtDPT_CD_SHR").value;
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            form1.txtENO_NO_SHR.value = '';
            form1.txtENO_NM_SHR.value = '';
            form1.txtDPT_CD_SHR.value = '';
            form1.txtDPT_NM_SHR.value = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_EV_EVLAPPLY.ClearData();

            document.form1.txtDPT_CD_SHR.focus();
        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_EVLAPPLY.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck(saveDiv) {

            //����� ��ȿ�� üũ
            if( saveDiv == '0' ) {
                if ( dsT_EV_EVLAPPLY.isUpdated ) {
                    if (new Number(form1.cmbEVL_YY_SHR.value) < new Number(year) - 1) {
                        alert("�ش� �⵵ �̿��� �ڷ�� ���� �� ������ �Ұ��մϴ�!");
                        fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                        document.form1.cmbEVL_YY_SHR.focus();
                        return false;
                    }
                } else {
                    fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                    alert("���� �� �ڷᰡ �����ϴ�!");
                    return false;
                }
                return true;
            }
            //�����޹ݿ��� ��ȿ�� üũ
            else if( saveDiv == '1' ) {
                if( document.getElementById("cmbEVL_YY_SHR").value == '' ) {
                    alert("�ش�⵵�� �ʼ� �Է»����Դϴ�.");
                    document.getElementById("cmbEVL_YY_SHR").focus();
                    return false;
                }
                return true;
            }

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_EVLAPPLY,15,"true","false");      // Grid Style ����
            getSelYy2('cmbEVL_YY_SHR');                                  //�ش� �⵵ AddItem

            // ��������
            if (frameid == "vlue010") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡹ݿ�/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡹ݿ�/";
            }

            //�򰡱����������� ��ȸ
            fnc_SearchItem();

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /******************
         * 16. ������ �ݿ�  *
         ******************/
        function fnc_EvlApply() {

            if( !fnc_SaveItemCheck('1') ) return;

            // �����޹ݿ� ���θ� ���� ����.
            if (confirm(document.getElementById("cmbEVL_YY_SHR").value+"�⵵ �� ���� ������ �ݿ��� �Ͻðڽ��ϱ�?\n������ �ݿ��� �ڷ�� �����˴ϴ�.") == false) return;

            dsT_EV_DEPTRATE.ClearData();

            //���κ������, �򰡹ݿ����� �� ��޺������ ���翩�� Ȯ��
            dsT_EV_DEPTRATE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_DEPTRATE.Reset();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLAPPLY)  |
    | 3. ���Ǵ� Table List(T_EV_EVLAPPLY)         |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLAPPLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_EVLAPPLY_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_DEPTRATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_EVLAPPLY)  |
    | 3. ���Ǵ� Table List(T_EV_EVLAPPLY)         |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLAPPLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_EVLAPPLY)">
    </Object>

    <Object ID ="trT_EV_EVLAPPLY_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_EVLAPPLY_01,O:SHR=dsT_EV_EVLAPPLY)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLAPPLY Event="OnLoadCompleted(iCount)">

        if( saveDiv == false ) {
            if (iCount == 0)    {

                fnc_Message(document.getElementById("resultMessage"),"MSG_02");
                alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

            } else {

                fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_EVLAPPLY.CountRow);

            }
        }
        else  {

            document.getElementById("resultMessage").innerText = '* ������ �ݿ��� �Ϸ� �Ǿ����ϴ�.';

        }

        if (new Number(form1.cmbEVL_YY_SHR.value) < new Number(year) - 1) {
            form1.grdT_EV_EVLAPPLY.Editable = "false";
            form1.btn.disabled = true;
        }
        else {
            form1.grdT_EV_EVLAPPLY.Editable = "true";
            form1.btn.disabled = false;
        }

        saveDiv = false;
        grdT_EV_EVLAPPLY.SetColumn("APPLY_RATE");//set focus

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //�ش�⵵�� ����,���� hiddenó��
            for( i=1; i<=4; i++ ) {
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_1_"+i, "show") = 'false';
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_2_"+i, "show") = 'false';
            }

        } else {

            //�ش�⵵�� ���� ����,���� show,hiddenó��
            for( i=1; i<=4; i++ ) {
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_1_"+i, "show") = 'true';
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_2_"+i, "show") = 'true';
            }

            for( i=4; i>dsT_EV_TYPE.NameValue(1,"ABL_CNT"); i-- )
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_1_"+i, "show") = 'false';

            for( i=4; i>dsT_EV_TYPE.NameValue(1,"ACH_CNT"); i-- )
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_2_"+i, "show") = 'false';

        }

    </Script>

    <Script For=dsT_EV_DEPTRATE Event="OnLoadCompleted(iCount)">


        if (iCount > 0) {
            for (var i = 1; i <= iCount; i++) {
                // ���� '1'(���κ������)�̸�
                if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "1") {
                    alert("�򰡴���ڼ����� �����ϴ� ���ΰ� ���κ�������Է� �����Ϳ� �������մϴ�.\n���κ�������Է� �����͸� Ȯ���Ͻ� �� �۾��Ͻñ� �ٶ��ϴ�.");
                    return;
                }
                // ���� '3'(�����޿� ���� ��޺����� ����)�̸�
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "3" && dsT_EV_DEPTRATE.NameValue(i, "VAL") == "0") {
                    alert("�����޿� ���� ��޺�������� �������մϴ�.\n��޺���������� �����͸� Ȯ���Ͻ� �� �۾��Ͻñ� �ٶ��ϴ�.");
                    return;
                }
                // ���� '4'(�򰡹ݿ�����)�̸�  �����ϸ�
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "4") {
                    alert("�򰡴���ڼ����� �����ϴ� �򰡱׷��� �򰡹ݿ����� �����Ϳ� �������մϴ�.\n�򰡹ݿ��������� �����͸� Ȯ���Ͻ� �� �۾��Ͻñ� �ٶ��ϴ�.");
                    return;
                }
                // ���� '5'(�������������)�̸�
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "5" && dsT_EV_DEPTRATE.NameValue(i, "VAL") == "0") {
                    alert("�����򰡵������Ȯ���� �����Ͱ� �������մϴ�.\n�����򰡵������Ȯ�� �����͸� Ȯ���Ͻ� �� �۾��Ͻñ� �ٶ��ϴ�.");
                    return;
                }
                // ���� '6'(�������������)�̸�
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "5" && dsT_EV_DEPTRATE.NameValue(i, "VAL") == "0") {
                    alert("�����򰡵������Ȯ���� �����Ͱ� �������մϴ�.\n�����򰡵������Ȯ�� �����͸� Ȯ���Ͻ� �� �۾��Ͻñ� �ٶ��ϴ�.");
                    return;
                }
            }

            dsT_EV_EVLAPPLY.ClearData();

            saveDiv = true;

            //�����ͼ� ����(�����޹ݿ���ȸ)
            dsT_EV_EVLAPPLY.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&cmbEVL_YY_SHR="+document.getElementById("cmbEVL_YY_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value;
            dsT_EV_EVLAPPLY.Reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_DEPTRATE Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_DEPTRATE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_EVLAPPLY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_EVLAPPLY event="OnFail()">

        saveDiv = false;
        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <script for=trT_EV_EVLAPPLY_01 event="OnSuccess()">

        document.getElementById("resultMessage").innerText = '* ������ �ݿ��� �Ϸ� �Ǿ����ϴ�.';
        dsT_EV_EVLAPPLY_01.ClearAll();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_EVLAPPLY_01 event="OnFail()">

        saveDiv = false;
        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);
        dsT_EV_EVLAPPLY_01.ClearAll();

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����޹ݿ�</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�����޹ݿ�</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif" name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="60"></col>
                                    <col width="40"></col>
                                    <col width="60"></col>
                                    <col width="160"></col>
                                    <col width="60"></col>
                                    <col width="180"></col>
                                    <col width="200"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�ش�⵵</td>
                                    <td class="padding2423"><select id=cmbEVL_YY_SHR name=cmbEVL_YY_SHR onChange="fnc_SearchItem();"><select></td>
                                        <td align="right" class="searchState">�μ�&nbsp;</td>
                                        <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="8" maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input id=txtDPT_NM_SHR size="8" class="input_ReadOnly" readOnly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                                        </td>
                                        <td align="right" class="searchState">���&nbsp;</td>
                                        <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                        <input id=txtENO_NM_SHR size="8" class="input_ReadOnly" readOnly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                        </td>
                                    <td align="left" width="200"></td>
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
                            <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                            <td align="right">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="btn" name="btn" width="80" height="20" border="0" align="absmiddle"  onClick="fnc_EvlApply();"></a>
                            </td>
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
                            <object    id="grdT_EV_EVLAPPLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                                <param name="DataID"                  value="dsT_EV_EVLAPPLY">
                                <param name="Editable"                value="true">
                                <param name="DragDropEnable"          value="true">
                                <param name="SortView"                value="Left">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="Format"                  value="
                                    <C> id='{String(currow)}'    width=50    name='����'      align=center </C>
                                    <C> id='HEAD_NM'             width=100   name='����'      align=left    edit=none </C>
                                    <C> id='DPT_NM'              width=100   name='�μ�'      align=left    edit=none </C>
                                    <C> id='JOB_NM'              width=100   name='����'      align=left    edit=none </C>
                                    <C> id='ENO_NO'              width=100   name='���'      align=center  edit=none </C>
                                    <C> id='ENO_NM'              width=100   name='����'      align=center  edit=none </C>
                                    <G> name='����' HeadBgColor='#F7DCBB'
                                    <C> id='EVL_GBN_1_1'         width=45    name='1ȸ'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_1_2'         width=45    name='2ȸ'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_1_3'         width=45    name='3ȸ'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_1_4'         width=45    name='4ȸ'       align=center  edit=none </C>
                                    </G>
                                    <G> name='����' HeadBgColor='#F7DCBB'
                                    <C> id='EVL_GBN_2_1'         width=45    name='1ȸ'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_2_2'         width=45    name='2ȸ'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_2_3'         width=45    name='3ȸ'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_2_4'         width=45    name='4ȸ'       align=center  edit=none </C>
                                    </G>
                                    <C> id='APPLY_RATE'          width=77    name='������(%)'     align=right </C>

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
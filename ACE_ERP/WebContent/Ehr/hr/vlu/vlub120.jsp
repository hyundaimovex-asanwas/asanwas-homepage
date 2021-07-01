<!--
*****************************************************
* @source       : vlub120.jsp
* @description : ��������Ȳ_���� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/09/04      ���뼺        �����ۼ�.
* 2007/03/16      ������        ����. (�����򰡾������� �߰�)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��������Ȳ_����(vlub120)</title>
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

        var btnList = 'TFFTFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var year = document.form1.txtEVL_YY_SHR.value;          //�ش�⵵
            var frq  = document.form1.txtEVL_FRQ_SHR.value;         //ȸ��

            var eno_no = document.form1.txtENO_NO_SHR.value;        //���
            var dpt_cd = document.form1.txtDPT_CD_SHR.value;        //�Ҽ�
            var group_cd = document.form1.cmbGROUP_CD_SHR.value;    //�򰡱׷�
            var end_yn   = document.form1.chkEND_YN_SHR.checked;    //�̿Ϸ���

            if(end_yn == true){
                checked = 'T';
            } else {
                checked = 'F';
            }

            cfCreateBar;

            //���� �� ���� ��� ���� ��ȸ
            trT_EV_EVLIST_HD.KeyValue = "SVL(O:dsT_EV_EVLIST_HD=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_HD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub120.cmd.VLUB120CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+year+"&EVL_FRQ="+frq+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&GROUP_CD="+group_cd+"&END_YN="+checked;
            trT_EV_EVLIST_HD.post();

            form1.grdT_EV_EVLIST_HD.Focus();

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
        function fnc_Save(s_mode) {

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_EVLIST_HD.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_EVLIST_HD.GridToExcel("������������Ȳ_����", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

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

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbGROUP_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';
            dsT_EV_EVLIST_HD.ClearAll();

            // DataSet Clear
            dsT_EV_ESTINFO.ClearData();
            dsT_EV_TYPE.ClearData();

            document.form1.txtDPT_CD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_EVLIST_HD, 0, "false", "false");

            // ��������
            if (frameid == "vlub120") {
                // �λ���
                GUBUN = "01";

                //�򰡱׷�
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);

                }

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";

            }

            // �⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.reset();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /****************************************
         * �˻����� �ʵ� ����� �����÷� �ʱ�ȭ *
         ***************************************/
        function fnc_FldChange() {

            if (document.getElementById("txtENO_NO_SHR").value == '') {
                document.getElementById("txtENO_NM_SHR").value = '';
            }

            if (document.getElementById("txtDPT_CD_SHR").value == '') {
                document.getElementById("txtDPT_NM_SHR").value = '';
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ESTINFO)   |
    | 3. ���Ǵ� Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. ��ȸ�� DataSet                                 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_EV_TYPE)        |
    | 3. ���Ǵ� Table List(dsT_EV_TYPE,dsT_EV_ESTINFO)|
    +--------------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                           |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD)                       |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD,) |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �򰡱׷� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_EV_EVLIST_HD                  |
    | 3. Table List : T_EV_EVLIST_HD              |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLIST_HD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
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

            //alert("������ �� ȸ�� ���� �Ǵ� �� ���� ���� ������\n �Ǿ� ���� �ʽ��ϴ�.");
            //document.getElementById("resultMessage").innerText = '* ������ �� ȸ�� ���� �Ǵ� �� ���� ���� ������ �Ǿ� ���� �ʽ��ϴ�.';
            alert("������Ⱓ�� �ƴմϴ�.");
            document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';

            dsT_EV_TYPE.ClearData();

            dsT_EV_ESTINFO.ClearData();
            dsT_EV_TYPE.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value    = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value   = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");

            dsT_EV_TYPE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub120.cmd.VLUB120CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value;
            dsT_EV_TYPE.reset();

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
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("�򰡱��������� �Ǿ� ���� �ʽ��ϴ�.");
            document.getElementById("resultMessage").innerText = '* �򰡱��������� �Ǿ� ���� �ʽ��ϴ�.';

        } else {

            //Grid Setting
            if(dsT_EV_TYPE.NameValue(1,"DOWN_YN") == '0') {

                grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = false;

            } else {

                if(dsT_EV_TYPE.NameValue(1,"DOWN_CNT") == 1) {
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = false;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"DOWN_CNT") == 2) {
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"DOWN_CNT") == 3) {
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = true;
                }

            }

            if(dsT_EV_TYPE.NameValue(1,"UP_YN") == '0') {

                grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = false;

            } else {
                if(dsT_EV_TYPE.NameValue(1,"UP_CNT") == 1) {

                    grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = false;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"UP_CNT") == 2) {
                    grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"UP_CNT") == 3) {
                    grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = true;
                }

            }

            document.form1.txtDPT_CD_SHR.focus();
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

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_EV_EVLIST_HD event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_EV_EVLIST_HD event="OnFail()">

        cfErrorMsg(this);

    </script>
<!--
**************************************************************
* BODY START
**************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������Ȳ_����</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">��������Ȳ_����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                                <col width="35"></col>
                                <col width="35"></col>
                                <col width="25"></col>
                                <col width="20"></col>
                                <col width="55"></col>
                                <col width="90"></col>
                                <col width="30"></col>
                                <col width="125"></col>
                                <col width="30"></col>
                                <col width="145"></col>
                                <col width="5"></col>
                                <col width="50"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�⵵</td>
                                <td class="padding2423"><input id=txtEVL_YY_SHR name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">ȸ��</td>
                                <td class="padding2423"><input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">�򰡱׷�</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList()">
                                        <option value=''>�� ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�Ҽ�</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="3"  maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="10" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="10" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
                                <td align="right" class="padding2423">
                                    <input type="checkbox" name="chkEND_YN_SHR" id=chkEND_YN_SHR style="border:0" align="absmiddle">
                                </td>
                                <td align="left" class="searchState">�̿Ϸ���</td>
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
                    <td align="right">&nbsp;</td>
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
                        <object    id="grdT_EV_EVLIST_HD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                value="dsT_EV_EVLIST_HD">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"        value="false">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"            value=0>
                            <param name="Format"                value="
                                <FC> id='GROUP_NM'      width=90        name='�򰡱׷�'       align=center Suppress=1 show=false</FC>
                                <FC> id='HEAD_NM'       width=90        name='����'           align=center Suppress=1 </FC>
                                <FC> id='DPT_NM'        width=90        name='�Ҽ�'           align=center Suppress=1 </FC>
                                <FC> id='JOB_NM'        width=49        name='����'           align=center Suppress=1 </FC>
                                <FC> id='ENO_NO'        width=60        name='���',          align=center Suppress=1 </FC>
                                <FC> id='ENO_NM'        width=50        name='����'           align=center Suppress=1 </FC>
                                <C>  id='DOWN_01'       width=220       name='1����'        align=left   </C>
                                <C>  id='DOWN_02'       width=220       name='2����'        align=left   </C>
                                <C>  id='DOWN_03'       width=220       name='3����'        align=left   </C>
                                <C>  id='UP_01'         width=220       name='����1����'    align=left   </C>
                                <C>  id='UP_02'         width=220       name='����2����'    align=left   </C>
                                <C>  id='UP_03'         width=220       name='����3����'    align=left   </C>
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
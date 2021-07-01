<!--
***********************************************************************
* @source      : vlua010.jsp
* @description : �򰡱������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/20      ���뼺        �����ۼ�.
* 2007/03/15      ������        ����. (�����򰡾������� �߰�)
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�򰡱�������(vlua010)</title>
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

        var btnList = 'FFFFFFFT';
        var year    = getToday().substring(0,4);
        var GUBUN   = '';
        var frameid = window.external.GetFrame(window).FrameId;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_EV_TYPE.ClearAll();
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua010.cmd.VLUA010CMD&S_MODE=SHR&GUBUN="+document.getElementById('txtGUBUN').value+"&EVL_YY="+document.getElementById('selEVL_YY').value;
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

            if(!fnc_SaveItemCheck()){
                return;
            } else {
                trT_EV_TYPE.KeyValue = "tr01(I:dsT_EV_TYPE=dsT_EV_TYPE)";
                trT_EV_TYPE.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua010.cmd.VLUA010CMD&S_MODE=SAV";
                trT_EV_TYPE.post();
            }

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

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
            // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_TYPE.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            var form = document.form1;

            if (form.selEVL_YY.value != year) {
                alert("����⵵ �̿��� �ڷ�� ���� �� ������ �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                form.selEVL_YY.focus();
                return false;
            }

            if (!dsT_EV_TYPE.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            //CheckBox�� Check���θ� DateSet�� Setting
            if (form.chkDOWN_YN.checked == true) {

                dsT_EV_TYPE.NameValue(1,"DOWN_YN") = '1';

                if(100 != eval(form.txtSubDown.value)){
                    alert("���� ���������� ���� 100�� �Ǿ�� �մϴ�.");
                    form1.txtDOWN_RATE1.focus();//set focus
                    return false;
                }
            } else {
                dsT_EV_TYPE.NameValue(1,"DOWN_YN") = '0';
            }

            if(form.chkUP_YN.checked == true) {
                dsT_EV_TYPE.NameValue(1,"UP_YN") = '1';
                if(100 != eval(form.txtSubUp.value)){
                    alert("���� ���������� ���� 100�� �Ǿ�� �մϴ�.");
                    form1.txtUP_RATE1.focus();//set focus
                    return false;
                }
            } else {
                dsT_EV_TYPE.NameValue(1,"UP_YN") = '0';
            }

            if(100 != eval(form.txtSubAch.value)){
                alert("���� ���������� ���� 100�� �Ǿ�� �մϴ�.");
                form1.txtACH_RATE1.focus();//set focus
                return false;
            }

            if(form.chkHEAD_YN.checked == true) {
                dsT_EV_TYPE.NameValue(1,"HEAD_YN") = '1';
            } else {
                dsT_EV_TYPE.NameValue(1,"HEAD_YN") = '0';
            }

            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //SelectBox�⵵ Setting
            getSelYy2('selEVL_YY');

            if (frameid == "vlua010") {
                // �λ���
                GUBUN = "01";
                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";
            }
            else {
                // ������
                GUBUN = "02";
                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }

            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua010.cmd.VLUA010CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+getToday().substring(0,4);
            dsT_EV_TYPE.Reset();
            form1.txtDOWN_RATE1.focus();                               // ó�� �׸� Focus

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /****************************************************
         * 16. ������ ���� ������ ���� ���� ������ ����    *
         ***************************************************/
        function checkDownRate() {

            var form = document.form1;

            if(form.chkDOWN_YN.checked == true) {
                form.selDOWN_CNT.readOnly = false;

                switch (form.selDOWN_CNT.value) {
                    case '1':
                        form.txtDOWN_RATE1.readOnly = false;
                        form.txtDOWN_RATE2.readOnly = true;
                        form.txtDOWN_RATE3.readOnly = true;
                        form.txtDOWN_RATE2.value = 0;
                        form.txtDOWN_RATE3.value = 0;
                        form.txtDOWN_RATE1.className='';
                        form.txtDOWN_RATE2.className="input_ReadOnly";
                        form.txtDOWN_RATE3.className="input_ReadOnly";
                        break;

                    case '2':
                        form.txtDOWN_RATE1.readOnly = false;
                        form.txtDOWN_RATE2.readOnly = false;
                        form.txtDOWN_RATE3.readOnly = true;
                        form.txtDOWN_RATE3.value = 0;
                        form.txtDOWN_RATE1.className = '';
                        form.txtDOWN_RATE2.className = '';
                        form.txtDOWN_RATE3.className="input_ReadOnly";
                        break;

                    case '3':
                        form.txtDOWN_RATE1.readOnly = false;
                        form.txtDOWN_RATE2.readOnly = false;
                        form.txtDOWN_RATE3.readOnly = false;
                        form.txtDOWN_RATE1.className = '';
                        form.txtDOWN_RATE2.className = '';
                        form.txtDOWN_RATE3.className = '';
                        break;

                }
            } else {
                form.selDOWN_CNT.readOnly = true;
                form.txtDOWN_RATE1.readOnly = true;
                form.txtDOWN_RATE2.readOnly = true;
                form.txtDOWN_RATE3.readOnly = true;
                form.txtDOWN_RATE1.value = 0;
                form.txtDOWN_RATE2.value = 0;
                form.txtDOWN_RATE3.value = 0;
                form.txtDOWN_RATE1.className="input_ReadOnly";
                form.txtDOWN_RATE2.className="input_ReadOnly";
                form.txtDOWN_RATE3.className="input_ReadOnly";
            }

            form.txtSubDown.value = eval(form.txtDOWN_RATE1.value)+eval(form.txtDOWN_RATE2.value)+eval(form.txtDOWN_RATE3.value);
        }

        /****************************************************
         * 17. ������ ���� ������ ���� ���� ������ ����    *
         ***************************************************/
        function checkUpRate() {

            var form = document.form1;

            if(form.chkUP_YN.checked == true) {
                form.selUP_CNT.readOnly = false;

                switch (form.selUP_CNT.value) {

                    case '1':
                        form.txtUP_RATE1.readOnly = false;
                        form.txtUP_RATE2.readOnly = true;
                        form.txtUP_RATE3.readOnly = true;
                        form.txtUP_RATE2.value = 0;
                        form.txtUP_RATE3.value = 0;
                        form.txtUP_RATE1.className = '';
                        form.txtUP_RATE2.className="input_ReadOnly";
                        form.txtUP_RATE3.className="input_ReadOnly";
                        break;

                    case '2':
                        form.txtUP_RATE1.readOnly = false;
                        form.txtUP_RATE2.readOnly = false;
                        form.txtUP_RATE3.readOnly = true;
                        form.txtUP_RATE3.value = 0;
                        form.txtUP_RATE1.className = '';
                        form.txtUP_RATE2.className = '';
                        form.txtUP_RATE3.className="input_ReadOnly";
                        break;

                    case '3':
                        form.txtUP_RATE1.readOnly = false;
                        form.txtUP_RATE2.readOnly = false;
                        form.txtUP_RATE3.readOnly = false;
                        form.txtUP_RATE1.className = '';
                        form.txtUP_RATE2.className = '';
                        form.txtUP_RATE3.className = '';
                        break;

                }
            } else {

                form.selUP_CNT.readOnly = true;
                form.txtUP_RATE1.readOnly = true;
                form.txtUP_RATE2.readOnly = true;
                form.txtUP_RATE3.readOnly = true;
                form.txtUP_RATE1.value = 0;
                form.txtUP_RATE2.value = 0;
                form.txtUP_RATE3.value = 0;
                form.txtUP_RATE1.className="input_ReadOnly";
                form.txtUP_RATE2.className="input_ReadOnly";
                form.txtUP_RATE3.className="input_ReadOnly";

            }

            form.txtSubUp.value = eval(form.txtUP_RATE1.value)+eval(form.txtUP_RATE2.value)+eval(form.txtUP_RATE3.value);
        }


        /************************************************
         * 18. ���������������� ����� �հ� ���� ǥ��    *
         ***********************************************/
        function showTotal(object) {
            var form = document.form1;
            var obj  = object.id;
            var down_rate1 = Number(form.txtDOWN_RATE1.value);
            var down_rate2 = Number(form.txtDOWN_RATE2.value);
            var down_rate3 = Number(form.txtDOWN_RATE3.value);
            var up_rate1   = Number(form.txtUP_RATE1.value);
            var up_rate2   = Number(form.txtUP_RATE2.value);
            var up_rate3   = Number(form.txtUP_RATE3.value);
            var ach_rate1  = Number(form.txtACH_RATE1.value);

            if((obj == 'txtDOWN_RATE1')||(obj == 'txtDOWN_RATE2')||(obj == 'txtDOWN_RATE3')) {
                form.txtSubDown.value = down_rate1 + down_rate2 + down_rate3;
                form.txtDOWN_RATE1.value = down_rate1;
                form.txtDOWN_RATE2.value = down_rate2;
                form.txtDOWN_RATE3.value = down_rate3;
            }
            else if((obj == 'txtUP_RATE1')||(obj == 'txtUP_RATE2')||(obj == 'txtUP_RATE3')) {
                form.txtSubUp.value = up_rate1 + up_rate2 + up_rate3;
                form.txtUP_RATE1.value = up_rate1;
                form.txtUP_RATE2.value = up_rate2;
                form.txtUP_RATE3.value = up_rate3;
            }
            else if((obj == 'txtACH_RATE1')) {
                form.txtSubAch.value = ach_rate1;
                form.txtACH_RATE1.value = ach_rate1;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_TYPE)      |
    | 3. ���Ǵ� Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_TYPE)      |
    | 3. ���Ǵ� Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_TYPE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:VLUA010=dsT_EV_TYPE">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ͽ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var form = document.form1;
        if (iCount < 1)    {

            dsT_EV_TYPE.addRow();

            //default setting
            dsT_EV_TYPE.NameValue(1,"GUBUN")    = GUBUN;
            dsT_EV_TYPE.NameValue(1,"EVL_YY")   = form.selEVL_YY.value;    //�ش�⵵ = ���س⵵
            dsT_EV_TYPE.NameValue(1,"ABL_CNT")  = 1;                       //������ȸ�� 1
            dsT_EV_TYPE.NameValue(1,"DOWN_CNT") = 1;                       //�������������� 1
            dsT_EV_TYPE.NameValue(1,"UP_CNT")   = 1;                       //�������������� 1
            dsT_EV_TYPE.NameValue(1,"ACH_CNT")  = 1;                       //������ȸ�� 1

            form.chkDOWN_YN.checked = false;            //������ checked
            document.getElementById("resultMessage").innerText = '* ' + form.selEVL_YY.value+"�⵵ �ڷ�� �����ϴ�.";

            checkDownRate();
            checkUpRate();

        } else {
            form.chkDOWN_YN.checked = false;

            if(dsT_EV_TYPE.NameValue(1,"DOWN_YN") == 1) {
                form.chkDOWN_YN.checked = true;
            }

            if(dsT_EV_TYPE.NameValue(1,"UP_YN") == 1) {
                form.chkUP_YN.checked = true;
            }

            if(dsT_EV_TYPE.NameValue(1,"HEAD_YN") == 1) {
                form.chkHEAD_YN.checked = true;
            }

            document.getElementById("resultMessage").innerText = '* ' + form.selEVL_YY.value+ '�⵵ �ڷᰡ ��ȸ�Ǿ����ϴ�.';
            checkDownRate();
            checkUpRate();

        }

        //�հ� Setting
        form.txtSubDown.value = dsT_EV_TYPE.NameValue(1,"DOWN_RATE1")+dsT_EV_TYPE.NameValue(1,"DOWN_RATE2")+dsT_EV_TYPE.NameValue(1,"DOWN_RATE3");
        form.txtSubUp.value   = dsT_EV_TYPE.NameValue(1,"UP_RATE1")+dsT_EV_TYPE.NameValue(1,"UP_RATE2")+dsT_EV_TYPE.NameValue(1,"UP_RATE3");
        form.txtSubAch.value  = dsT_EV_TYPE.NameValue(1,"ACH_RATE1");

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
    | �����͸� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_TYPE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_TYPE event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�򰡱�������</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�򰡱�������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�򰡱������� </strong></td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="50"></col>
                    <col width="80"></col>
                    <col width="30"></col>
                    <col width="80"></col>
                    <col width="30"></col>
                    <col width="80"></col>
                    <col width="30"></col>
                </colgroup>
                <tr>
                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                    <td align="center" class="creamBold">�ش�⵵</td>
                    <td class="padding2423" colspan="6">
                        <select id="selEVL_YY" name="selEVL_YY" onChange="fnc_SearchList(this.value)">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">������</td>
                    <td align="center" class="creamBold">���ֱ�(��)</td>
                    <td class="padding2423">
                        <select name=selABL_CNT id=selABL_CNT>
                            <option value="1">1ȸ</option>
                            <option value="2">2ȸ</option>
                            <option value="3">3ȸ</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">
                        <input type="checkbox" name="chkDOWN_YN" id=chkDOWN_YN style="border:0" align="absmiddle" onclick="checkDownRate()">������(����)</td>
                    <td class="padding2423">
                        <select name="selDOWN_CNT" id=selDOWN_CNT onChange="checkDownRate()">
                            <option value="1">1��</option>
                            <option value="2">2��</option>
                            <option value="3">3��</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">
                        <input type="checkbox" name="chkUP_YN" id=chkUP_YN style="border:0" align="absmiddle" onclick="checkUpRate()">�ٸ��򰡽ǽ�</td>
                    <td class="padding2423">
                        <select name="selUP_CNT" id=selUP_CNT onChange="checkUpRate()">
                            <option value="1">1��</option>
                            <option value="2">2��</option>
                            <option value="3">3��</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">������</td>
                    <td align="center" class="creamBold">���ֱ�(��)</td>
                    <td class="padding2423">
                        <select name=selACH_CNT id=selACH_CNT>
                            <option value="1">1ȸ</option>
                            <option value="2">2ȸ</option>
                            <option value="3">3ȸ</option>
                        </select>
                    </td>
                    <td class="padding2423" colspan="4">
                        <input type="hidden" name="chkHEAD_YN" id=chkHEAD_YN value="yes" style="border:0" align="absmiddle"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� 1 -->

<!-- ���� �Է� ���̺� ���� 2 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������������ </strong></td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                <colgroup>
                    <col width="100"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" colspan="2">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td align="center" class="creamBold">1��</td>
                    <td align="center" class="creamBold">2��</td>
                    <td align="center" class="creamBold">3��</td>
                    <td align="center" class="creamBold">�հ�</td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">�� ��<br>�� ��</td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input name=txtDOWN_RATE1 id=txtDOWN_RATE1 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtDOWN_RATE2 id=txtDOWN_RATE2 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtDOWN_RATE3 id=txtDOWN_RATE3 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423"><input name=txtSubDown readonly class="input_ReadOnly" style="width 75px; font-color:#DDDDDD; font-weight: bold; text-align:right">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ٸ���</td>
                    <td class="padding2423">
                        <input name=txtUP_RATE1 id=txtUP_RATE1 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtUP_RATE2 id=txtUP_RATE2 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtUP_RATE3 id=txtUP_RATE3 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423"><input name=txtSubUp readOnly class="input_ReadOnly" style="width 75px; font-color:#DDDDDD; font-weight: bold; text-align:right">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" colspan="2">������</td>
                    <td class="padding2423">
                        <input name=txtACH_RATE1 id=txtACH_RATE1 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <!-- <input name=txtACH_RATE2 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"> -->
                    </td>
                    <td class="padding2423">
                        <!-- <input name=txtACH_RATE3 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"> -->
                    </td>
                    <td class="padding2423"><input name=txtSubAch readOnly class="input_ReadOnly" style="width 75px; font-color:#DDDDDD; font-weight: bold; text-align:right">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
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
<!-- ���� �Է� ���̺� �� 2 -->

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �� ���� ���� ���� ���̺� -->
<object id="bndT_EV_TYPE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_TYPE">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN        Ctrl=txtGUBUN            Param=value            Disable=disabled</C>
        <C>Col=EVL_YY       Ctrl=txtEVL_YY           Param=value            Disable=disabled</C>
        <C>Col=ABL_CNT      Ctrl=selABL_CNT          Param=value</C>
        <C>Col=DOWN_YN      Ctrl=chkDOWN_YN          Param=value</C>
        <C>Col=DOWN_CNT     Ctrl=selDOWN_CNT         Param=value</C>
        <C>Col=UP_YN        Ctrl=chkUP_YN            Param=value</C>
        <C>Col=UP_CNT       Ctrl=selUP_CNT           Param=value</C>
        <C>Col=ACH_CNT      Ctrl=selACH_CNT          Param=value</C>
        <C>Col=HEAD_YN      Ctrl=chkHEAD_YN          Param=value</C>
        <C>Col=UP_RATE1     Ctrl=txtUP_RATE1         Param=value</C>
        <C>Col=UP_RATE2     Ctrl=txtUP_RATE2         Param=value</C>
        <C>Col=UP_RATE3     Ctrl=txtUP_RATE3         Param=value</C>
        <C>Col=DOWN_RATE1   Ctrl=txtDOWN_RATE1       Param=value</C>
        <C>Col=DOWN_RATE2   Ctrl=txtDOWN_RATE2       Param=value</C>
        <C>Col=DOWN_RATE3   Ctrl=txtDOWN_RATE3       Param=value</C>
        <C>Col=ACH_RATE1    Ctrl=txtACH_RATE1        Param=value</C>
        <C>Col=ACH_RATE2    Ctrl=txtACH_RATE2        Param=value</C>
        <C>Col=ACH_RATE3    Ctrl=txtACH_RATE3        Param=value</C>
    '>
</object>
<!--
    ************************************************************************************
    * @Source         : vlua070.jsp                                                    *
    * @Description    : �򰡴���� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/04  |  ���뼺   | �����ۼ�                                               *
    * 2006/09/20  |  ������   | ����                                                   *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�򰡴����(vlua070)</title>
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

        var year = getToday().substring(0,4);
        var btnList = 'TTTTFFTT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;

            // �׸��� ������ ��ȸ��
            form1.txtFLAG.value = "1";

            dsT_EV_EVLIST_HD2.ClearData();

            // ������ǥ�� ���翩�� üũ
            dsT_EV_EVLIST_HD2.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ;
            dsT_EV_EVLIST_HD2.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;

            // �׸��� ������ ��ȸ��
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            // ����� �� �ʵ��� ��ȿ��üũ
            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_EVLIST_HD.KeyValue = "tr01(I:SAV=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_HD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SAV";
            trT_EV_EVLIST_HD.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_EVLIST_HD.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (form1.cmbEVL_YY_SHR.value != year) {
                alert("�ش�⵵ �̿��� �ڷ�� ���� �� �� �����ϴ�!");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.cmbEVL_YY_SHR.focus();
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,"ENO_NO") + "][" + dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,"ENO_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_EV_EVLIST_HD.DeleteRow(dsT_EV_EVLIST_HD.RowPosition);

            trT_EV_EVLIST_HD.KeyValue = "tr01(I:SAV=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_HD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=DEL";
            trT_EV_EVLIST_HD.post();

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_EVLIST_HD.SetColumn(form1.grdT_EV_EVLIST_HD.GetColumnID(0));
            form1.grdT_EV_EVLIST_HD.Focus();

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

            form1.grdT_EV_EVLIST_HD.GridToExcel("�򰡴���ڼ���", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �򰡴���ڵ�Ϲ׼��� �˾�â�� �ű�ȭ������ ���
            fnc_openPopup('I', '');

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

            document.getElementById("txtENO_NO_SHR").value     = '';
            document.getElementById("txtENO_NM_SHR").value     = '';
            document.getElementById("txtDPT_CD_SHR").value     = '';
            document.getElementById("txtDPT_NM_SHR").value     = '';
            document.getElementById("txtKIJUN_YMD_SHR").value  = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_EVLIST_HD.ClearData();
            dsT_EV_EVLIST_HD2.ClearData();

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

            if (document.getElementById("cmbEVL_YY_SHR").value != year) {
                alert("����⵵ �̿��� �ڷ�� ���� �� ������ �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                document.form1.cmbEVL_YY_SHR.focus();
                return false;
            }

            // DataSet�� ���� ���� Ȯ��
            if ( !dsT_EV_EVLIST_HD.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            var EVL_YY  = null;

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_EVLIST_HD, 0,"true","false");

            // DATASET �ʱ�ȭ
            fnc_Clear();

            getSelYy2('cmbEVL_YY_SHR');

            EVL_YY = form1.cmbEVL_YY_SHR.value;

            // Form Load��
            form1.txtFLAG.value = "0";

            // ��������
            if (frameid == "vlua070") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

            form1.cmbEVL_YY_SHR.focus();

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


        /***************************************
         * ���������ư Ŭ���� �۾� ó�� �κ�  *
         **************************************/
        function fnc_CopyBatch() {

            // �ٷ� �� �����͸� �����Ͽ� ����
            var EVL_YY    = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN   = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ   = form1.cmbEVL_FRQ_SHR.value;
            var KIJUN_YMD = form1.txtKIJUN_YMD_SHR.value;

            // �򰡴������� ��ȿ�� üũ (���� �򰡴������� ������ �������� �Ʒ��κ� Ǯ� ����� ��)
            if( form1.txtKIJUN_YMD_SHR.value == '' ) {
                alert("�򰡴��������� �ʼ� �Է»����Դϴ�.");
                form1.txtKIJUN_YMD_SHR.focus();
                return;
            }

            if(!confirm("������ ������ �򰡴���� ������ ��� �ʱ�ȭ �˴ϴ�.\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) return;

            dsT_EV_EVLIST_HD.ClearData();

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&KIJUN_YMD="+KIJUN_YMD;
            dsT_EV_EVLIST_HD.Reset();

        }


        /***************************************
         * �ϰ�������ư Ŭ���� �۾� ó�� �κ�  *
         **************************************/
        function fnc_CreateBatch() {

            var EVL_YY    = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN   = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ   = form1.cmbEVL_FRQ_SHR.value;
            var KIJUN_YMD = form1.txtKIJUN_YMD_SHR.value;

            // �򰡴������� ��ȿ�� üũ (���� �򰡴������� ������ �������� �Ʒ��κ� Ǯ� ����� ��)
            if( form1.txtKIJUN_YMD_SHR.value == '' ) {
                alert("�򰡴��������� �ʼ� �Է»����Դϴ�.");
                form1.txtKIJUN_YMD_SHR.focus();
                return;
            }

            if(!confirm("������ ������ �򰡴���� ������ ��� �ʱ�ȭ �˴ϴ�.\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) return;

            dsT_EV_EVLIST_HD.ClearData();

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&KIJUN_YMD="+KIJUN_YMD;
            dsT_EV_EVLIST_HD.Reset();

        }

        /*****************************************************
         * �����ʵ� �� ����� �׸��� �÷� SETTING ó�� �κ�  *
         ****************************************************/
        function fnc_ChangeEVL_GBN(EVL_GBN) {

            var DOWN_CNT = dsT_EV_TYPE.NameValue(1, "DOWN_CNT");

            // ������
            // �׸��忡�� ������ �����÷��� �����ְ�, ������ �����÷��� �������� �ʰ� �Ѵ�.
            if (EVL_GBN == '1') {

                // ���������� ��ŭ �÷��� ������
                if (DOWN_CNT == 1) {
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM11", "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO11",  "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM12", "Show") = "false";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO12",  "Show") = "false";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM13", "Show") = "false";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO13",  "Show") = "false";
                }
                else if (DOWN_CNT == 2) {
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM11", "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO11",  "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM12", "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO12",  "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM13", "Show") = "false";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO13",  "Show") = "false";
                }
                else if (DOWN_CNT == 3) {
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM11", "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO11",  "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM12", "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO12",  "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM13", "Show") = "true";
                    form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO13",  "Show") = "true";
                }

                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM20", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO20",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM21", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO21",  "Show") = "false";

            }

            // ������
            // �׸��忡�� ������ �����÷��� �����ְ�, ������ �����÷��� �������� �ʰ� �Ѵ�.
            else  if (EVL_GBN == '2') {
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM11", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO11",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM12", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO12",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM13", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO13",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM20", "Show") = "true";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO20",  "Show") = "true";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM21", "Show") = "true";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO21",  "Show") = "true";

            }
            // ������
            // �׸��忡�� ������ �����÷��� �����ְ�, �׿� �����÷��� �������� �ʰ� �Ѵ�.
            else {
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM11", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO11",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM12", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO12",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM13", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO13",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM20", "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO20",  "Show") = "false";
                form1.grdT_EV_EVLIST_HD.ColumnProp("IEVLENO_NM21", "Show") = "true";
                form1.grdT_EV_EVLIST_HD.ColumnProp("EVLENO_NO21",  "Show") = "true";

            }
        }

        /*****************************************************
         * ��¥ ���� ��ȿ�� üũ                             *
         ****************************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;

            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }


        /*****************************************************
         * �򰡴���ڵ�Ϲ׼��� �˾�â�� ���                *
         ****************************************************/
        function fnc_openPopup(mode, eno_no) {

            var url = "/hr/vlu/vlua073.jsp?T_MODE="+mode+"&GUBUN="+GUBUN+"&EVL_YY="+form1.cmbEVL_YY_SHR.value+"&EVL_GBN="+form1.cmbEVL_GBN_SHR.value+"&EVL_FRQ="+form1.cmbEVL_FRQ_SHR.value+"&ENO_NO="+eno_no;
            var revck = null;

            revck = window.showModalDialog(url, self, "dialogWidth:600px; dialogHeight:300px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null) {

                return;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLIST_HD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_EVLIST_HD)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_EVLIST_HD.CountRow);

        }

        if (document.form1.cmbEVL_YY_SHR.value != year) {
            form1.grdT_EV_EVLIST_HD.Editable = "false";
        }
        else {
            form1.grdT_EV_EVLIST_HD.Editable = "true";
        }

    </Script>

    <Script For=dsT_EV_EVLIST_HD2 Event="OnLoadCompleted(iCount)">

        var EVL_YY  = form1.cmbEVL_YY_SHR.value;
        var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
        var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
        var ENO_NO  = form1.txtENO_NO_SHR.value;
        var DPT_CD  = form1.txtDPT_CD_SHR.value;

        if (document.form1.cmbEVL_YY_SHR.value != year) {

            form1.imgCreate.disabled = true;
            form1.imgInforcopy.disabled   = true;
        }
        else {

            form1.imgCreate.disabled = false;
            form1.imgInforcopy.disabled   = false;
        }

        // �׸��� ������ ��ȸ��
        if (form1.txtFLAG.value == "1") {

            dsT_EV_EVLIST_HD.ClearData();

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;
            dsT_EV_EVLIST_HD.Reset();

        }

    </Script>

    <Script For=dsT_EV_EVLIST_HD3 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_EVLIST_HD3.CountRow);

        }

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var oOption;
        var Index = document.getElementById("cmbEVL_FRQ_SHR").length;

        if (iCount == 0)    {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ȸ���޺� ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = 1;
            oOption.text  = '1ȸ';
            document.getElementById("cmbEVL_FRQ_SHR").add(oOption);

            //form1.imgCreate.disabled = true;
            //form1.imgInforcopy.disabled   = true;

        }
        else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ȸ���޺� ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            //����
            if( document.getElementById("cmbEVL_GBN_SHR").value == '1' ) {

                //������ȸ��
                for( i = 1; i<= Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text  = i+'ȸ';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
                }

            }

            //����
            if( document.getElementById("cmbEVL_GBN_SHR").value == '2' ) {

                //������ȸ��
                for( i=1; i<=dsT_EV_TYPE.NameValue(1,"ACH_CNT"); i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text  = i+'ȸ';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
                }

            }
            //����
            if( document.getElementById("cmbEVL_GBN_SHR").value == '3' ) {

                //������ȸ��

                    oOption = document.createElement("OPTION");
                    oOption.value = 1;
                    oOption.text  =1+'ȸ';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);


            }
            form1.txtDOWN_RATE1.value = dsT_EV_TYPE.NameValue(1, "DOWN_RATE1");
            form1.txtDOWN_RATE2.value = dsT_EV_TYPE.NameValue(1, "DOWN_RATE2");
            form1.txtDOWN_RATE3.value = dsT_EV_TYPE.NameValue(1, "DOWN_RATE3");
            form1.txtACH_RATE1.value  = dsT_EV_TYPE.NameValue(1, "ACH_RATE1");

        }

        // ���а��� ���� �׸��忡 ������/������ ���� �÷��� ��������.
        fnc_ChangeEVL_GBN(form1.cmbEVL_GBN_SHR.value);

        dsT_EV_EVLIST_HD2.ClearData();

        // ������ǥ�� ���翩�� üũ
        dsT_EV_EVLIST_HD2.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+form1.cmbEVL_YY_SHR.value+"&EVL_GBN="+form1.cmbEVL_GBN_SHR.value+"&EVL_FRQ="+form1.cmbEVL_FRQ_SHR.value;
        dsT_EV_EVLIST_HD2.Reset();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_EVLIST_HD2 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_EVLIST_HD3 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_EVLIST_HD2 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-- Ʈ������ ����. -->
    <script for=trT_EV_EVLIST_HD event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EV_EVLIST_HD event="OnFail()">

        cfErrorMsg(this);

    </script>


    <!-- �׸����� �˾��ʵ� Ŭ���� -->
    <script language="javascript" for=grdT_EV_EVLIST_HD event=OnPopup(Row,Colid,data)>

        var EVL_YY    = form1.cmbEVL_YY_SHR.value;
        var EVL_GBN   = form1.cmbEVL_GBN_SHR.value;
        var EVL_FRQ   = form1.cmbEVL_FRQ_SHR.value;
        var DPT_NM    = dsT_EV_EVLIST_HD.NameValue(Row, "DPT_NM");
        var GROUP_CD  = dsT_EV_EVLIST_HD.NameValue(Row, "GROUP_CD");
        var ENO_NO    = dsT_EV_EVLIST_HD.NameValue(Row, "ENO_NO");
        var ENO_NM    = dsT_EV_EVLIST_HD.NameValue(Row, "ENO_NM");
        var DOWN_RATE = 0;
        var ACH_RATE  = 0;
        var revck     = null;

        if ( Colid == 'EVLENO_NO11' ) {
            DOWN_RATE = form1.txtDOWN_RATE1.value;
        }
        else if ( Colid == 'EVLENO_NO12' ) {
            DOWN_RATE = form1.txtDOWN_RATE2.value;
        }
        else if ( Colid == 'EVLENO_NO13' ) {
            DOWN_RATE = form1.txtDOWN_RATE3.value;
        }
        else {
            ACH_RATE = form1.txtACH_RATE1.value;
        }

        //modal������ ���� ���� confirm�� ���ڸ��� �޾� �´�.
        // �����򰡴����
        if ( Colid == 'EVLENO_NO11' ||
             Colid == 'EVLENO_NO12' ||
             Colid == 'EVLENO_NO13' ) {
            url = "/hr/" + "vlu" + "/" + "vlua071.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DOWN_RATE="+DOWN_RATE;
        }
        // �����򰡴����
        else {
            url = "/hr/" + "vlu" + "/" + "vlua072.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&ACH_RATE="+ACH_RATE;
        }

        // ���κ� �� ����� ���� ȭ�� ȣ��
        revck = window.showModalDialog(url, Colid, "dialogHeight:490px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        if (revck == -1 || revck == null)
            return;

        var firstList = new Array ();
        firstList = revck.split(";");

        // ������ �����򰡴���� ���ڸ��� �ش� �÷��� �־���
        if ( Colid == 'EVLENO_NO11' ||
             Colid == 'EVLENO_NO12' ||
             Colid == 'EVLENO_NO13' ) {
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,"GROUP_CD") = firstList[0];
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,Colid) = firstList[1];
        }
        // ������ �����򰡴���� ���ڸ��� �ش� �÷��� �־���
        else {
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,'GROUP_CD') = firstList[0];
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,'EVLENO_NO20') = firstList[1];
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,'EVLENO_NO21') = firstList[2];

            if (revck == '') {
                dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,'EVLENO_NO21') = '';
            }
        }

    //    fnc_SearchList();

    </script>

    <!-- �׸��� ����Ŭ���� -->
    <script language="javascript" for=grdT_EV_EVLIST_HD event=OnDblClick(Row,Colid)>

        if (Colid != 'IEVLENO_NM11' &&
            Colid != 'EVLENO_NO11'  &&
            Colid != 'IEVLENO_NM12' &&
            Colid != 'EVLENO_NO12'  &&
            Colid != 'IEVLENO_NM13' &&
            Colid != 'EVLENO_NO13'  &&
            Colid != 'IEVLENO_NM20' &&
            Colid != 'EVLENO_NO20'  &&
            Colid != 'IEVLENO_NM21' &&
            Colid != 'EVLENO_NO21'  &&
            Colid != 'EXCEPT_YN'    &&
            Colid != 'NULL' ) {

            // �򰡴���ڵ�Ϲ׼��� �˾�â�� ����ȭ������ ���
            fnc_openPopup('U', dsT_EV_EVLIST_HD.NameValue(Row,"ENO_NO"));
        }

    </script>

    <script language="javascript" for=grdT_EV_EVLIST_HD event=OnKeyPress(kcode)>

        var row = dsT_EV_EVLIST_HD.RowPosition;
        var column1 = grdT_EV_EVLIST_HD.GetColumn();
        var column2 = "";
        var column3 = "";
        var degree_gbn = "";
        var apply_rate = "";
        var rate = "";
        var obj = new String;

        if ((column1 == 'IEVLENO_NM11' ||
             column1 == 'IEVLENO_NM12' ||
             column1 == 'IEVLENO_NM13' ||
             column1 == 'IEVLENO_NM20' ||
             column1 == 'IEVLENO_NM21')
            && kcode == "13"){

            if(column1 == 'IEVLENO_NM11'){//���� 1������
                column2 = "IEVLENO_NO11";
                column3 = "EVLENO_NO11";
                degree_gbn = "1";
                apply_rate = "50";

            }else if(column1 == 'IEVLENO_NM12'){//���� 2������
                column2 = "IEVLENO_NO12";
                column3 = "EVLENO_NO12";
                degree_gbn = "2";
                apply_rate = "50";

            }else if(column1 == 'IEVLENO_NM13'){//���� 3������
                column2 = "IEVLENO_NO13";
                column3 = "EVLENO_NO13";
                degree_gbn = "3";
                apply_rate = "50";

            }else if(column1 == 'IEVLENO_NM20'){//���� ��������
                column2 = "IEVLENO_NO20";
                column3 = "EVLENO_NO20";
                degree_gbn = "1";
                apply_rate = "";

                //�������ڴ� �켱 1�����ڰ� ���־���Ѵ�.
                if(dsT_EV_EVLIST_HD.NameValue(row, "EVLENO_NO21") == null || dsT_EV_EVLIST_HD.NameValue(row, "EVLENO_NO21") == ""){
                    alert("�������� ������ ���� 1������ ������ �Ǿ� �־�� �����մϴ�.");
                    //�ʱ�ȭ
	                dsT_EV_EVLIST_HD.NameValue(row, column2) = "";
	                dsT_EV_EVLIST_HD.NameValue(row, column1) = "";
                    return false;
                }

            }else if(column1 == 'IEVLENO_NM21'){//���� 1������
                column2 = "IEVLENO_NO21";
                column3 = "EVLENO_NO21";
                degree_gbn = "1";
                apply_rate = "100";
            }

            //�򰡱׷��� ������ �ʵȴ�.
            if(dsT_EV_EVLIST_HD.NameValue(row, "GROUP_NM") == null || dsT_EV_EVLIST_HD.NameValue(row, "GROUP_NM").trim() == ""){
                alert("�򰡱׷��� ���� �����ڴ� ���� ������ �� �� �����ϴ�.");
                //�ʱ�ȭ
                dsT_EV_EVLIST_HD.NameValue(row, column2) = "";
                dsT_EV_EVLIST_HD.NameValue(row, column1) = "";
                return false;
            }

            document.getElementById("txtENO_NM").value = dsT_EV_EVLIST_HD.NameValue(row, column1);

	        //�������� ����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            /*
            alert(document.getElementById("txtENO_NO").value+",  "+
                  document.getElementById("txtENO_NM").value+",  "+
                  document.getElementById("hidEMPL_DPT_CD").value);
            */

            //������� ��������˻�
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                dsT_EV_EVLIST_HD.NameValue(row, column2) = obj.eno_no;
                dsT_EV_EVLIST_HD.NameValue(row, column1) = obj.eno_nm;

                //�����÷� ������ ǥ��
                if(apply_rate != ""){
                    rate = "("+apply_rate+"%)";
                }

                dsT_EV_EVLIST_HD.NameValue(row, column3) = obj.eno_nm+rate;

                //�ʱ�ȭ
                dsT_EV_EVLIST_HD.NameValue(row, column2) = "";
                dsT_EV_EVLIST_HD.NameValue(row, column1) = "";

                //�ٷ� ���� �ϱ�
                dsT_EV_EVLIST_HD3.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SAV_01"+
                                          "&EVLENO_NO_COL="+column3+
                                          "&GUBUN="+GUBUN+
                                          "&EVL_YY="+dsT_EV_EVLIST_HD.NameValue(row, "EVL_YY")+
                                          "&EVL_GBN="+dsT_EV_EVLIST_HD.NameValue(row, "EVL_GBN")+
                                          "&EVL_FRQ="+dsT_EV_EVLIST_HD.NameValue(row, "EVL_FRQ")+
                                          "&ENO_NO="+dsT_EV_EVLIST_HD.NameValue(row, "ENO_NO")+
                                          "&DEGREE_GBN="+degree_gbn+
                                          "&EVLENO_NO="+obj.eno_no+
                                          "&APPLY_RATE="+apply_rate;
                dsT_EV_EVLIST_HD3.reset();

            }else{
	            //����� ������ �ʱ�ȭ
	            dsT_EV_EVLIST_HD.NameValue(row, column2) = "";
	            dsT_EV_EVLIST_HD.NameValue(row, column1) = "";
	        }

         }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�򰡴����</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�򰡴����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
                                <col width="50"></col>
                                <col width="50"></col>
                                <col width="30"></col>
                                <col width="40"></col>
                                <col width="30"></col>
                                <col width="40"></col>
                                <col width="30"></col>
                                <col width="160"></col>
                                <col width="30"></col>
                                <col width="160"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_GBN_SHR onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="1">����</option>
                                        <option value="2">����</option>
                                        <option value="3">����</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">ȸ��</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">�Ҽ�</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="10"  maxlength="6" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input name=txtDPT_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>

                                <td align="right" class="searchState">���</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="10"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','0','0');"> <input name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>

                                <!-- Hidden Filed -->
                                <input type=hidden name=txtDOWN_RATE1>
                                <input type=hidden name=txtDOWN_RATE2>
                                <input type=hidden name=txtDOWN_RATE3>
                                <input type=hidden name=txtACH_RATE1>
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
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=50%><span id="resultMessage">&nbsp;</span></td>
                    <td align="left" class="searchState">�򰡴�������</td>
                    <td class="padding2423">
                        <input type=text id=txtKIJUN_YMD_SHR style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"  onclick="calendarBtn('datetype1','txtKIJUN_YMD_SHR','','500','125');"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInforcopy','','/images/button/btn_InforcopyOver.gif',1)"><img src="/images/button/btn_InforcopyOn.gif" id="imgInforcopy" name="imgInforcopy" width="100" height="20" border="0" align="absmiddle" onClick="fnc_CopyBatch()"></a>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','/images/button/BatchCreateOver.gif',1)"><img src="/images/button/BatchCreateOn.gif" id="imgCreate" name="imgCreate" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CreateBatch()"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>

	                    <!-- ��� �˻��� ���� �ӽ� ���� ��ü -->
	                    <input type="hidden" name="txtENO_NO">
	                    <input type="hidden" name="txtENO_NM">
	                    <input type="hidden" name="hidEMPL_DPT_CD">

                        <comment id="__NSID__">
                        <object    id="grdT_EV_EVLIST_HD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_EVLIST_HD">
                            <param name="Editable"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="ColSizing"               value="true">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id=GROUP_NM        width=60   name='�򰡱׷�'    align=center Edit=None </FC>
                                <FC> id=HEAD_NM         width=75   name='����'        align=center Edit=None </FC>
                                <FC> id=DPT_NM          width=80   name='�Ҽ�'        align=center Edit=None </FC>
                                <FC> id=JOB_NM          width=44   name='����',       align=center Edit=None </FC>
                                <FC> id=ENO_NO          width=54   name='���'        align=center Edit=None </FC>
                                <FC> id=ENO_NM          width=48   name='����'        align=center Edit=None </FC>
                                <C>  id=HIRG_YMD        width=65   name='�Ի���'      align=center Edit=None </C>
                                <C>  id=DPA_YMD         width=65   name='�Ҽӹ߷���'  align=center Edit=None </C>
                                <G>  name='������' HeadBgColor='#F7DCBB'
                                     <C> id=IEVLENO_NM11 width=54   name='�Է�'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO11  width=90   name='1������'   align=left   EditStyle=PopupFix </C>
                                     <C> id=IEVLENO_NM12 width=54   name='�Է�'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO12  width=90   name='2������'   align=left   EditStyle=PopupFix </C>
                                     <C> id=IEVLENO_NM13 width=54   name='�Է�'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO13  width=90   name='3������'   align=left   EditStyle=PopupFix </C>
                                </G>
                                <G>  name='������' HeadBgColor='#F7DCBB'
                                     <C> id=IEVLENO_NM21 width=54   name='�Է�'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO21  width=90   name='1������'   align=left   EditStyle=PopupFix </C>
                                     <C> id=IEVLENO_NM20 width=54   name='�Է�'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO20  width=90   name='��������'  align=left   EditStyle=PopupFix </C>
                                </G>
                                <C>  id=EXCEPT_YN       width=40   name='��;����'   align=center EditStyle=CheckBox </C>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>

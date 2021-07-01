<!--
    ************************************************************************************
    * @Source         : memb040.jsp                                                    *
    * @Description    : �İ߻���޿�ó�� PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/01  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�İ߻���޿�ó��(memb040)</title>
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

        var btnList = 'TFTTTTFT';
        var Month   = getToday().substr(0,7);

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YM     = document.getElementById("txtPIS_YM_SHR").value;

            if (PIS_YM == "") {
                alert("����� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // ��� CHECK
            if (!fnc_CheckDate(document.getElementById("txtPIS_YM_SHR"), '���')) {
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // �޿�ó�� �۾��α� ������ ��ȸ
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_00&PIS_YM="+PIS_YM;
            dsT_CP_WORKLOG.Reset();

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

            if(fnc_SaveItemCheck()) {

                trT_ME_APYMST.action = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SAV";
                trT_ME_APYMST.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ME_APYMST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_APYMST.RowStatus(dsT_ME_APYMST.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_APYMST.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("���[" + dsT_ME_APYMST.NameValue(dsT_ME_APYMST.RowPosition,"ENO_NO") + "] ����[" + dsT_ME_APYMST.NameValue(dsT_ME_APYMST.RowPosition,"ENO_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ME_APYMST.DeleteRow(dsT_ME_APYMST.RowPosition);

            if (status != 1) {
                trT_ME_APYMST.action = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=DEL";
                trT_ME_APYMST.post();
            }

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ME_APYMST.SetColumn(form1.grdT_ME_APYMST.GetColumnID(0));
            form1.grdT_ME_APYMST.Focus();

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

            if (dsT_ME_APYMST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_ME_APYMST.GridToExcel("�İ߻���޿�ó��", '', 225);


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

            document.getElementById("txtPIS_YM_SHR").value  = '';
            document.getElementById("txtDISCOMP_CD_SHR").value  = '';
            document.getElementById("txtDISCOMP_NM_SHR").value  = '';
            document.getElementById("txtENO_NO_SHR").value  = '';
            document.getElementById("txtENO_NM_SHR").value  = '';

            // ��ư ��Ȱ��ȭ
            document.getElementById("btnMEMB01").disabled = true;
            document.getElementById("btnMEMB02").disabled = true;
            document.getElementById("btnMEMB03").disabled = true;
            document.getElementById("btnMEMB04").disabled = true;
            document.getElementById("btnMEMB05").disabled = true;

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CP_WORKLOG.ClearData();
            dsT_ME_APYMST.ClearData();

            document.getElementById("txtPIS_YM_SHR").value = Month;
            document.getElementById("txtPIS_YM_SHR").focus();

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

            var f = document.form1;

            if (dsT_CP_WORKLOG.NameValue(1, "PRO_STS") != "2") {
                return false;
            }

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_ME_APYMST.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_APYMST.CountRow; i++ ) {
                if ( dsT_ME_APYMST.RowStatus(i) == 1 ||
                     dsT_ME_APYMST.RowStatus(i) == 3 ) {

                    // �ٹ��ϼ�
                    if( dsT_ME_APYMST.NameValue(i, "GUN_CNT") == 0 ) {
                        alert("�ٹ��ϼ��� �ʼ� �Է»����Դϴ�.");
                        form1.grdT_ME_APYMST.focus();
                        form1.grdT_ME_APYMST.setColumn("GUN_CNT");
                        dsT_ME_APYMST.RowPosition = i;

                        return false;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_ME_APYMST,0,"false","false");

            // ��ư ��Ȱ��ȭ
            document.getElementById("btnMEMB01").disabled = true;
            document.getElementById("btnMEMB02").disabled = true;
            document.getElementById("btnMEMB03").disabled = true;
            document.getElementById("btnMEMB04").disabled = true;
            document.getElementById("btnMEMB05").disabled = true;

            document.getElementById("txtPIS_YM_SHR").value = Month;
            document.getElementById("txtPIS_YM_SHR").focus();

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


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/


        /********************************************
         * �۾�OPEN ��ư Ŭ���� ó��                *
         *******************************************/
        function fnc_PROSTS_01() {

            // �۾��α� ������ ����
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("����� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // �޿�ó�� �۾��α� ������ ��ȸ
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_02&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * ����ڼ��� ��ư Ŭ���� ó��              *
         *******************************************/
        function fnc_PROSTS_02() {

            // �İ߻���޿�ó�� ������ ����
            // �۾��α� ������ ����
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("����� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // �޿�ó�� �۾��α� ������ ��ȸ
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_03&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * �޿���� ��ư Ŭ���� ó��                *
         *******************************************/
        function fnc_PROSTS_03() {

            // ���� �޿��� ���� �İ߻���޿�ó�� �ݿ�
            // �۾��α� ������ ����
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("����� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_APYMST.IsUpdated ) {
                alert("��������� �����մϴ�.\n������ �� �۾��Ͻñ� �ٶ��ϴ�.");
                return false;
            }

            // �޿�ó�� �۾��α� ������ ��ȸ
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_04&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * �۾��Ϸ� ��ư Ŭ���� ó��                *
         *******************************************/
        function fnc_PROSTS_04() {

            // �۾��α׿� �۾��Ϸ� ���� �ݿ�
            // �۾��α� ������ ����
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("����� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // �޿�ó�� �۾��α� ������ ��ȸ
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_05&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * ���۾� ��ư Ŭ���� ó��                  *
         *******************************************/
        function fnc_PROSTS_05() {

            // �۾��α׿� �۾��Ϸ� ���� �ݿ�
            // �۾��α� ������ ����
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("����� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            document.getElementById("resultMessage").innerText = ' ';

            // �޿���� ��ư�� Ȱ��ȭ�� ��� ����ڼ����� �Ϸ�Ǿ����Ƿ�
            // ����ڼ��� ���۾��� �� �ְ� ��
            if (document.getElementById("btnMEMB03").disabled == false) {

                if(!confirm("������ ������ ����� ������ �����ϰ� �˴ϴ�..\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) return;

                // �޿�ó�� �۾��α� ������ ��ȸ
                dsT_CP_WORKLOG.ClearData();

                dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_06&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
                dsT_CP_WORKLOG.Reset();
            }
            // �۾��Ϸ� ��ư�� Ȱ��ȭ�� ��� �޿����Ϸ�����Ƿ�
            // �޿���� ���۾��� �� �ֵ��� ��
            else if (document.getElementById("btnMEMB04").disabled == false) {

                if(!confirm("������ ���� �޿������� �ʱ�ȭ�ϰ� �˴ϴ�..\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) return;

                // �޿�ó�� �۾��α� ������ ��ȸ
                dsT_CP_WORKLOG.ClearData();

                dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_07&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
                dsT_CP_WORKLOG.Reset();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ME_APYMST)    |
    | 3. ���Ǵ� Table List(T_ME_APYMST)           |
    +----------------------------------------------->
    <Object ID="dsT_ME_APYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)   |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_APY                          |
    | 3. Table List : T_ME_APY                      |
    +----------------------------------------------->
    <Object ID ="trT_ME_APYMST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_APYMST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        var PIS_YM     = document.getElementById("txtPIS_YM_SHR").value;
        var DISCOMP_CD = document.getElementById("txtDISCOMP_CD_SHR").value;
        var ENO_NO     = document.getElementById("txtENO_NO_SHR").value;

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            // �����Ͱ� �������ϴ� ��� �۾�OPEN ��ư Ȱ��ȭ
            document.getElementById("btnMEMB01").disabled = false;
            document.getElementById("btnMEMB02").disabled = true;
            document.getElementById("btnMEMB03").disabled = true;
            document.getElementById("btnMEMB04").disabled = true;
            document.getElementById("btnMEMB05").disabled = true;

            // �İ߻���޿�ó�� GRID �ʱ�ȭ
            dsT_ME_APYMST.ClearData();

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CP_WORKLOG.CountRow );

            switch (dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) {
                case "1" :  // �۾�OPEN �Ϸ����
                    // ����ڼ��� ��ư Ȱ��ȭ
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = false;
                    document.getElementById("btnMEMB03").disabled = true;
                    document.getElementById("btnMEMB04").disabled = true;
                    document.getElementById("btnMEMB05").disabled = true;

                    form1.grdT_ME_APYMST.Editable = "false";

                    break;
                case "2" :  // ����ڼ��� �Ϸ����
                    // �޿���� ��ư Ȱ��ȭ
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = true;
                    document.getElementById("btnMEMB03").disabled = false;
                    document.getElementById("btnMEMB04").disabled = true;
                    document.getElementById("btnMEMB05").disabled = false;

                    form1.grdT_ME_APYMST.Editable = "true";

                    break;
                case "3" :  // �޿���� �Ϸ����
                    // �۾��Ϸ� ��ư Ȱ��ȭ
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = true;
                    document.getElementById("btnMEMB03").disabled = true;
                    document.getElementById("btnMEMB04").disabled = false;
                    document.getElementById("btnMEMB05").disabled = false;

                    form1.grdT_ME_APYMST.Editable = "false";

                    break;
                case "4" :  // �۾��Ϸ����
                    // ��� ��ư ��Ȱ��ȭ
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = true;
                    document.getElementById("btnMEMB03").disabled = true;
                    document.getElementById("btnMEMB04").disabled = true;
                    document.getElementById("btnMEMB05").disabled = true;


                    form1.grdT_ME_APYMST.Editable = "false";

                    break;
            }

            // �İ߻���޿�ó�� GRID �ʱ�ȭ
            dsT_ME_APYMST.ClearData();

            // �۾�OPEN Ȱ��ȭ�� ��� ���� ����ڰ� �����Ƿ�
            // �İ߻���޿�ó�� �����͸� ��ȸ���� ����
            if (dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                return;
            }

            document.getElementById("resultMessage").innerText = ' ';

            // �İ߻���޿�ó�� ������ ��ȸ
            dsT_ME_APYMST.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_01&PIS_YM="+PIS_YM+"&DISCOMP_CD="+DISCOMP_CD+"&ENO_NO="+ENO_NO;
            dsT_ME_APYMST.Reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_APYMST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_APYMST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ME_APYMST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_APYMST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_APYMST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_APYMST event="OnFail()">

        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�İ߻���޿�ó��</td>
                    <td align="right" class="navigator">HOME/�λ����/�İ߻��/<font color="#000000">�İ߻���޿�ó��</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="50"></col>
                                <col width="80"></col>
                                <col width="50"></col>
                                <col width="160"></col>
                                <col width="50"></col>
                                <col width="*"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState"> ���&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '���');"  onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPisYm','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPisYm" name="ImgPisYm" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','5','120');"></a>
                                </td>
                                <td align="right" class="searchState">��ü </td>
                                <td class="padding2423">
                                    <input id=txtDISCOMP_CD_SHR name=txtDISCOMP_CD_SHR size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('CA', 'txtDISCOMP_CD_SHR','txtDISCOMP_NM_SHR');"> <input id=txtDISCOMP_NM_SHR name=txtDISCOMP_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDiscompCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDiscompCd" name="ImgDiscompCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtDISCOMP_CD_SHR','txtDISCOMP_NM_SHR','�İ߾�ü','CA')"></a>
                                </td>
                                <td align="right" class="searchState">��� </td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetEnoNm('txtENO_NO_SHR')"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR', '2');}">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl3Popup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8">
                        <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="150"></col>
                                <col width="150"></col>
                                <col width="150"></col>
                                <col width="150"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB01"  style="cursor:hand" value=" �۾� OPEN "  style="width:70pt;"  onclick="fnc_PROSTS_01();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB02"  style="cursor:hand" value=" ����ڼ��� " style="width:70pt;"  onclick="fnc_PROSTS_02();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB03" style="cursor:hand" value=" �޿���� "    style="width:70pt;"  onclick="fnc_PROSTS_03();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB04" style="cursor:hand" value="�۾��Ϸ�"      style="width:70pt;"  onclick="fnc_PROSTS_04();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB05" style="cursor:hand" value="���۾�"        style="width:70pt;"  onclick="fnc_PROSTS_05();">
                                </td>
                            </tr>
                        </table>
                    <td>
                </tr>
            </table>
        </td>
    </tr>
</table>
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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ME_APYMST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:370px;">
                            <param name="DataID"                  value="dsT_ME_APYMST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id='{currow}'     width=39    name='����'           Edit='None'    align=center </FC>
                                <FC> id='DISCOMP_NM'   width=100   name='��ü��'         Edit='None'    align=left   </FC>
                                <FC> id='DPT_NM'       width=100   name='�Ҽ�'           Edit='None'    align=left   </FC>
                                <FC> id='ENO_NO'       width=70    name='���'           Edit='None'    align=center </FC>
                                <FC> id='ENO_NM'       width=70    name='����'           Edit='None'    align=center </FC>
                                <C> id='HIR_YMD'      width=70    name='�Ի���'         Edit='None'    align=center </C>
                                <C> id='RET_YMD'      width=70    name='�����'         Edit='None'    align=center </C>
                                <C> id='GUN_CNT'      width=60    name='�ٹ��ϼ�'       Edit='Numeric' align=right  </C>
                                <C> id='BAS_AMT'      width=90    name='�İߴܰ�'       Edit='None'    align=right </C>
                                <C> id='LSEV_AMT'     width=90    name='�ټ������'     Edit='None'    align=right </C>
                                <C> id='WEL_AMT'      width=90    name='��Ÿ����'       Edit='None'    align=right </C>
                                <C> id='SUM_AMT'      width=90    name='�뿪�� ��'      Edit='None'    align=right </C>
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
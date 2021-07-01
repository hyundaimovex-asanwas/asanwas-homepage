<!--
    ************************************************************************************
    * @Source         : vluc170.jsp                                                    *
    * @Description    : �������_���� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/13  |  ������   | �����ۼ�                                               *
    * 2007/03/18  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�������_����(vluc170)</title>
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

        // ������
        var EVL_GBN = "2";
        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY   = form1.cmbEVL_YY_SHR.value;
            var EVL_FRQ  = form1.cmbEVL_FRQ_SHR.value;
            var ENO_NO   = form1.txtENO_NO_SHR.value;
            var DPT_CD   = form1.txtDPT_CD_SHR.value;
            var HEAD_CD  = form1.cmbHEAD_CD_SHR.value;
            var GROUP_CD = form1.cmbGROUP_CD_SHR.value;
            var CHG_CHK  = "0";

            if(form1.chkCHG_CHK_SHR.checked){
                CHG_CHK = "1";
            } else {
                CHG_CHK = "0";
            }

            // �׸��� ������ ��ȸ��
            form1.txtFLAG.value = "1";

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc170.cmd.VLUC170CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD+"&HEAD_CD="+HEAD_CD+"&GROUP_CD="+GROUP_CD+"&CHG_CHK="+CHG_CHK;
            dsT_EV_ABLRST.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            var EVL_YY   = form1.cmbEVL_YY_SHR.value;

            // �׸��� ������ ��ȸ��
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc170.cmd.VLUC170CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
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

            trT_EV_ABLRST.KeyValue = "tr01(I:SAV=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc170.cmd.VLUC170CMD&S_MODE=SAV";
            trT_EV_ABLRST.post();

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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("�������_����", '', 225);

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

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbHEAD_CD_SHR").value = '';
            document.getElementById("cmbGROUP_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';

            document.getElementById("Image30").disabled = false;

            // DataSet Clear
            dsT_EV_ABLRST.ClearData();
            dsT_EV_ABLRST2.ClearData();

            document.form1.txtDPT_CD_SHR.focus();

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

            // DataSet�� ���� ���� Ȯ��
            if ( !dsT_EV_ABLRST.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            for( i = 1; i <= dsT_EV_ABLRST.CountRow; i++ ) {
                if( dsT_EV_ABLRST.RowStatus(i) == 1 ||
                    dsT_EV_ABLRST.RowStatus(i) == 3 ) {
                    // ���
                    if( dsT_EV_ABLRST.NameValue(i, "CHANGE_GRD") == '' ) {
                        alert("����� �ʼ� �Է»����Դϴ�.");
                        dsT_EV_ABLRST.RowPosition = i;
                        form1.grdT_EV_ABLRST.SetColumn("CHANGE_GRD");
                        form1.grdT_EV_ABLRST.focus();
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
            cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","false");

            // DATASET �ʱ�ȭ
            fnc_Clear();

            getSelYy('cmbEVL_YY_SHR');

            //�����ڵ�
            for( var i = 1; i <= dsCOMMON_B2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_B2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_B2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);

            }

            // ��������
            if (frameid == "vluc170") {
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

            // Form Load��
            form1.txtFLAG.value = "0";

            // �⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

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
         * �������������ư Ŭ���� �۾� ó�� �κ�  *
         **************************************/
        function fnc_CreateBatch() {

            var EVL_YY   = form1.cmbEVL_YY_SHR.value;
            var EVL_FRQ  = form1.cmbEVL_FRQ_SHR.value;
            var GROUP_CD = form1.cmbGROUP_CD_SHR.value;

            form1.txtFLAG.value = "2";

            if(!confirm("������ ����� ��� ���� �ڷ�� ��� �ʱ�ȭ �˴ϴ�.\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) return;

            dsT_EV_ABLRST2.ClearData();

            // ������ǥ�� ���翩�� üũ
            dsT_EV_ABLRST2.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc170.cmd.VLUC170CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ;
            dsT_EV_ABLRST2.Reset();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ESTINFO)   |
    | 3. ���Ǵ� Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ABLRST)">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �����ڵ� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B2"/>
       <jsp:param name="CODE_GUBUN"    value="B2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �򰡱׷� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("�򰡱Ⱓ �� ��ȸ��������\n�Ǿ����� �ʽ��ϴ�.");
            document.getElementById("resultMessage").innerText = '* �򰡱Ⱓ �� ��ȸ�������� �Ǿ����� �ʽ��ϴ�.';

            dsT_EV_TYPE.ClearData();
            dsT_EV_ABLRST.ClearData();
            dsT_EV_ABLRST2.ClearData();

        }
        else {

            form1.cmbEVL_YY_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc170.cmd.VLUC170CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+form1.cmbEVL_YY_SHR.value;
            dsT_EV_TYPE.Reset();

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

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
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

            form1.txtACH_CNT.value = 0;

        }
        else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ȸ���޺� ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }


            //������ȸ��
            for( i = 1; i<= Number(dsT_EV_TYPE.NameValue(1,"ACH_CNT")); i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = i;
                oOption.text  = i+'ȸ';
                document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
            }

            form1.txtACH_CNT.value = dsT_EV_TYPE.NameValue(1,"ACH_CNT");
            form1.cmbEVL_FRQ_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");

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

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        var CHIEP_GRD  = dsT_EV_ABLRST.NameValue(1, "CHIEP_GRD");
        var FEEDBK_GBN = dsT_EV_ABLRST.NameValue(1, "FEEDBK_GBN");

        if (iCount == 0)    {

             if (form1.txtFLAG.value == "2") {
                document.getElementById("resultMessage").innerText = '* �������� �ݿ��� �����Ͽ����ϴ�.';
                alert('�������� �ݿ��� �����Ͽ����ϴ�.\n���ڷᰡ �����ϴ��� Ȯ�ιٶ��ϴ�.');
            }
            else {
                fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            }

            form1.cmbEVL_YY_SHR.focus();

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ABLRST.CountRow);

            // ������������_������ ���
            if (CHIEP_GRD.trim() != "") {

                form1.grdT_EV_ABLRST.ColumnProp('CHANGE_GRD', 'Edit') = 'None';
                form1.grdT_EV_ABLRST.Editable = "false";
                document.getElementById("Image30").disabled = true;

                // ��������Ȯ���� ���
                if (FEEDBK_GBN.trim() == "T") {

                    alert("������ ��� ������ Ȯ���Ǿ����Ƿ� ���� �Ұ��մϴ�.");
                }
                else {

                    alert("������ ��� ������ �Ǿ����Ƿ� ���� �Ұ��մϴ�.");
                }
            } else {

                form1.grdT_EV_ABLRST.ColumnProp('CHANGE_GRD', 'Edit') = 'true';
                form1.grdT_EV_ABLRST.Editable = "true";
                document.getElementById("Image30").disabled = false;

            }

            if (form1.txtFLAG.value == "2") {

                // ������������_������ ���
                if (CHIEP_GRD.trim() == "") {
                    document.getElementById("resultMessage").innerText = '* �������� �ݿ��� �Ϸ�Ǿ����ϴ�.';
                }
            }

            form1.grdT_EV_ABLRST.Focus();

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
    <Script For=dsT_EV_ABLRST2 Event="OnLoadCompleted(iCount)">

        var EVL_YY    = form1.cmbEVL_YY_SHR.value;
        var EVL_FRQ   = form1.cmbEVL_FRQ_SHR.value;
        var GROUP_CD  = form1.cmbGROUP_CD_SHR.value;

        if (iCount > 0) {
            for (var i = 1; i <= iCount; i++) {
                // ���� '1'(���κ������)�̸�
                if (dsT_EV_ABLRST2.NameValue(i, "GBN") == "1") {
                    alert("�򰡴���ڼ����� �����ϴ� ���ΰ� ���κ�������Է� �����Ϳ� �������մϴ�.\n���κ�������Է� �����͸� Ȯ���Ͻ� �� �۾��Ͻñ� �ٶ��ϴ�.");
                    return;
                }
                // ���� '2'(�������ۼ�ǥ)�̸�
                else if (dsT_EV_ABLRST2.NameValue(i, "GBN") == "2" && dsT_EV_ABLRST2.NameValue(i, "VAL") == "0") {
                    alert("�����򰡸� �ۼ��� �����Ͱ� �������մϴ�.\n������ �����͸� Ȯ���Ͻ� �� �۾��Ͻñ� �ٶ��ϴ�.");
                    return;
                }
            }

            dsT_EV_ABLRST.ClearData();

            // ���������ݿ�
            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc170.cmd.VLUC170CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&GROUP_CD="+GROUP_CD;
            dsT_EV_ABLRST.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST2 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST2 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EV_ABLRST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EV_ABLRST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������_����</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�������_����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
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
                                <col width="25"></col>
                                <col width="30"></col>
                                <col width="25"></col>
                                <col width="55"></col>
                                <col width="85"></col>
                                <col width="30"></col>
                                <col width="100"></col>
                                <col width="27"></col>
                                <col width="122"></col>
                                <col width="30"></col>
                                <col width="142"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�⵵</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">ȸ��</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">�򰡱׷�</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">�� ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                    <select name="cmbHEAD_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">�� ü</option>
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">�Ҽ�</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="3"  maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_FldChange()"> <input name=txtDPT_NM_SHR size="8" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_FldChange()"> <input name=txtENO_NM_SHR size="6" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
                            <!-- Hidden Filed -->
                            <input type=hidden name=txtACH_CNT>
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
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right" class="searchState">
                        <input type="checkbox" name="chkCHG_CHK_SHR" id=chkCHG_CHK_SHR style="border:0" align="absmiddle" onClick="fnc_SearchList()">�����ο�
                    </td>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','/images/button/AdjustApplyOver.gif',1)"><img src="/images/button/AdjustApplyOn.gif" id="Image30" name="Image30" width="100" height="20" border="0" align="absmiddle" onClick="fnc_CreateBatch()"></a>
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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='GROUP_NM'     width=80    name='�򰡱׷�'      align=left   Edit='None' </C>
                                <C> id='HEAD_NM'      width=90    name='����'          align=left   Edit='None' </C>
                                <C> id='DPT_NM'       width=90    name='�Ҽ�'          align=left   Edit='None' </C>
                                <C> id='JOB_NM'       width=70    name='����'          align=left   Edit='None' </C>
                                <C> id='ENO_NO'       width=72    name='���'          align=center Edit='None' </C>
                                <C> id='ENO_NM'       width=90    name='����'          align=center Edit='None' </C>
                                <C> id='DNPNT_01'     width=60    name='������'        align=right  Edit='None' DEC=2</C>
                                <C> id='DNCVT_01'     width=60    name='ȯ������'      align=right  Edit='None' DEC=2</C>
                                <C> id='RNUM'         width=32    name='����'          align=center Edit='None' </C>
                                <C> id='ORIGINAL_GRD' width=60    name='���'          align=center Edit='None' EditStyle=Combo Data='S,A,B,C,D' </C>
                                <C> id='CHANGE_GRD'   width=60    name='�������'      align=center Edit='true' EditStyle=Combo Data='S,A,B,C,D' bgcolor={Decode(CHANGE_GRD,ORIGINAL_GRD,'#FFFFFF',NULL,'#FFFFFF','#F2AC47')}</C>
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
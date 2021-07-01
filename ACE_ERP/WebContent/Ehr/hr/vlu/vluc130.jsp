<!--
    ************************************************************************************
    * @Source         : vluc130.jsp                                                    *
    * @Description    : �������Է� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/04  |  ���뼺   | �����ۼ�                                               *
    * 2006/10/10  |  ������   | ����                                                   *
    * 2007/03/18  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�������Է�(vluc130)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //��������
    String EVLENO_NO  = request.getParameter("EVLENO_NO");      //���ڻ��
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        // ������
        var EVL_GBN = "2";
        var btnList = 'TFTFFFFT';

        //���â���� ����� ��� �����ϱ� ���� ��� by DS
        var modal_yn = window.dialogArguments;

        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY    = form1.txtEVL_YY_SHR.value;
            var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
            var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;
            var GBN       = form1.txtGBN_SHR.value;

            // DATASET �ʱ�ȭ
            fnc_Clear();

            dsT_EV_ACHTBL.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc130.cmd.VLUC130CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&EVLENO_NO="+EVLENO_NO+"&GBN="+GBN;

            dsT_EV_ACHTBL.Reset();

            if (dsT_EV_ACHTBL.CountRow == 0)    {

                form1.txtTOT_PNT.value = 0;

            } else {

                form1.txtTOT_PNT.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("SELF_ACHCVT"),0,0) +
                                         dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("SELF_DIFCVT"),0,0);

            }

            form1.grdT_EV_ACHTBL.Focus();

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

            // ����� �� �ʵ��� ��ȿ��üũ
            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_ACHTBL.KeyValue = "tr01(I:SAV=dsT_EV_ACHTBL)";
            trT_EV_ACHTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc130.cmd.VLUC130CMD&S_MODE=SAV";
            trT_EV_ACHTBL.post();

            dsT_EV_ACHTBL.UseChangeInfo = "true";

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

            if (dsT_EV_ACHTBL.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ACHTBL.GridToExcel("�������Է�", '', 225);

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

            // DataSet Clear
            dsT_EV_ACHTBL.ClearData();

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
            if ( !dsT_EV_ACHTBL.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            // �޼����� NULL ���� �����ϴ��� CHECK
            for (var i = 1; i <= dsT_EV_ACHTBL.CountRow; i++) {
                if (dsT_EV_ACHTBL.NameValue(i, "SELF_ACHRAT").trim() == "") {
                    alert("�޼����� �ʼ� �Է��׸��Դϴ�.");

                    form1.grdT_EV_ACHTBL.SetColumn("SELF_ACHRAT");
                    dsT_EV_ACHTBL.RowPosition = i;
                    form1.grdT_EV_ACHTBL.Focus();

                    return false;
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            var EVL_YY  = null;

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_ACHTBL,0,"true","false");
            cfStyleGrid2(form1.grdT_EV_AIMSUB);

            if (modal_yn == null) {
                var frameid = window.external.GetFrame(window).FrameId;
            }

            // ��������
            if (frameid == "vluc130" || "<%=GUBUN%>" == "01") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            // �⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_ACHTBL.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

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

        function fnc_Disp_RefColumn() {

            var str_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_STDT");
            var end_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_ENDT");
            var str_mm = Number(str_ymd.substring(5,7));
            var end_mm = Number(end_ymd.substring(5,7));

            for(var i=str_mm; i<=end_mm; i++){

                if(i == 1) {
                  form1.grdT_EV_AIMSUB.ColumnProp("JAN_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("JAN_DN", "Show") = "true";
                }

                if(i == 2) {
                  form1.grdT_EV_AIMSUB.ColumnProp("FEB_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("FEB_DN", "Show") = "true";
                }

                if(i == 3) {
                  form1.grdT_EV_AIMSUB.ColumnProp("MAR_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("MAR_DN", "Show") = "true";
                }

                if(i == 4) {
                  form1.grdT_EV_AIMSUB.ColumnProp("APR_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("APR_DN", "Show") = "true";
                }

                if(i == 5) {
                  form1.grdT_EV_AIMSUB.ColumnProp("MAY_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("MAY_DN", "Show") = "true";
                }

                if(i == 6) {
                  form1.grdT_EV_AIMSUB.ColumnProp("JUN_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("JUN_DN", "Show") = "true";
                }

                if(i == 7) {
                  form1.grdT_EV_AIMSUB.ColumnProp("JUL_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("JUL_DN", "Show") = "true";
                }

                if(i == 8) {
                  form1.grdT_EV_AIMSUB.ColumnProp("AUG_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("AUG_DN", "Show") = "true";
                }

                if(i == 9) {
                  form1.grdT_EV_AIMSUB.ColumnProp("SEP_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("SEP_DN", "Show") = "true";
                }

                if(i == 10) {
                  form1.grdT_EV_AIMSUB.ColumnProp("OCT_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("OCT_DN", "Show") = "true";
                }

                if(i == 11) {
                  form1.grdT_EV_AIMSUB.ColumnProp("NOV_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("NOV_DN", "Show") = "true";
                }

                if(i == 12) {
                  form1.grdT_EV_AIMSUB.ColumnProp("DEC_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("DEC_DN", "Show") = "true";
                }

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ACHTBL)    |
    | 3. ���Ǵ� Table List(T_EV_ACHTBL)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHTBL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_AIMLST)    |
    | 3. ���Ǵ� Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_AIMSUB)    |
    | 3. ���Ǵ� Table List(T_EV_AIMSUB)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMSUB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ACHPNT)    |
    | 3. ���Ǵ� Table List(T_EV_ACHPNT)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHPNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ACHTBL)    |
    | 3. ���Ǵ� Table List(T_EV_ACHTBL)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_ACHTBL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ACHTBL)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <script for=dsT_EV_ACHTBL Event=onColumnChanged(row,colid)>

        if ( colid == 'SELF_ACHCVT' ||
             colid == 'SELF_DIFCVT') {

            // �޼��� �Է½� �Ѱ踦 ���Ѵ�.
            form1.txtTOT_PNT.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("SELF_ACHCVT"),0,0) +
                                     dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("SELF_DIFCVT"),0,0);

        }

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHTBL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ACHTBL.CountRow);

            // ���ʵ���ڰ� ���ٸ� �����Ͱ� ������ǥ�� ���� �������� flag �ʵ忡 SETTING
            if (dsT_EV_ACHTBL.NameValue(1, "IPT_MAN").trim() == "") {

                dsT_EV_ACHTBL.UseChangeInfo = "false";
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">
        if ( iCount == 0 )    {

            alert("������Ⱓ�� �ƴմϴ�.");
            document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';

            dsT_EV_SCHCHG.ClearData();
            dsT_EV_ACHTBL.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value  = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");
            form1.txtENO_NO_SHR.value   = '<%=box.get("SESSION_ENONO")%>';
            form1.txtENO_NM_SHR.value   = '<%=box.get("SESSION_ENONM")%>';
            form1.txtDPT_NM_SHR.value   = '<%=box.get("SESSION_DPTNM")%>';

            //������Ⱓ�� ���� �׸��� ����
            fnc_Disp_RefColumn();

            // ��ܺ� ������ ��ȸ
            dsT_EV_SCHCHG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc130.cmd.VLUC130CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtENO_NO_SHR.value;
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

        var SELF_STDT = '';
        var SELF_ENDT = '';

        if ( iCount == 0 )    {

            SELF_STDT = dsT_EV_ESTINFO.NameValue(1, "SELF_STDT");
            SELF_ENDT = dsT_EV_ESTINFO.NameValue(1, "SELF_ENDT");

        } else {

            if (dsT_EV_SCHCHG.NameValue(1, "SELF_STDT") == "") {

                SELF_STDT = dsT_EV_ESTINFO.NameValue(1, "SELF_STDT");
                SELF_ENDT = dsT_EV_ESTINFO.NameValue(1, "SELF_ENDT");

            }
            else {

                SELF_STDT = dsT_EV_SCHCHG.NameValue(1, "SELF_STDT");
                SELF_ENDT = dsT_EV_SCHCHG.NameValue(1, "SELF_ENDT");
            }
        }

        EVL_YY  = form1.txtEVL_YY_SHR.value;
        EVL_FRQ = form1.txtEVL_FRQ_SHR.value;
        ENO_NO  = form1.txtENO_NO_SHR.value;

        // ���ڸ� ��ȸ
        dsT_EV_AIMLST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc130.cmd.VLUC130CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO;
        dsT_EV_AIMLST.Reset();

        // ���� �޼����� ���� ���� ���� ��ȸ
        dsT_EV_ACHPNT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc130.cmd.VLUC130CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
        dsT_EV_ACHPNT.Reset();

        if ("<%=EVLENO_NO%>" != "" && "<%=EVLENO_NO%>" != "null") {
            fnc_SearchList();
        }
        else {
            document.getElementById("cmbEVLENO_NO_SHR").focus();
        }

        // �������ڰ� �������Է±Ⱓ������ ���̸� �޼��� �� �޼��� �Է°����ϵ��� ��
        if (SELF_STDT <= getToday() && SELF_ENDT >= getToday()) {

            form1.grdT_EV_ACHTBL.Editable = 'true';

        }
        else {

            alert('������ �Է±Ⱓ�� �ƴմϴ�.');
            document.getElementById("resultMessage").innerText = '* ������ �Է±Ⱓ�� �ƴմϴ�.';
            form1.grdT_EV_ACHTBL.Editable = 'false';

        }


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        var oOption;

        if ( iCount != 0 )    {

            for(var i = 0 ; i < iCount ; i++) {

                oOption = document.createElement("OPTION");
                oOption.text  = dsT_EV_AIMLST.NameValue(i + 1, "EVLENO_NM");
                oOption.value = dsT_EV_AIMLST.NameValue(i + 1, "EVLENO_NO");

                document.getElementById("cmbEVLENO_NO_SHR").add(oOption);
            }

            if ("<%=EVLENO_NO%>" != "" && "<%=EVLENO_NO%>" != "null") {
                document.getElementById("cmbEVLENO_NO_SHR").value = "<%=EVLENO_NO%>";
                document.getElementById("cmbEVLENO_NO_SHR").readOnly = true;
            }
            else {
                document.getElementById("cmbEVLENO_NO_SHR")[0].selected = true;
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMSUB Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMSUB Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMSUB Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHPNT Event="OnLoadCompleted(iCount)">

        var i = 0;
        var ro = "";
        var ru = "";
        var ap = "";

        if (iCount > 0) {

            for (i = 1; i <= iCount; i++) {

                if (i > 5) {
                    return;
                }

                ro = "ro_" + i;
                ru = "ru_" + i;
                ap = "ap_" + i;

                document.getElementById(ro).innerText = dsT_EV_ACHPNT.NameValue(i, "RATE_OVER") + "% ~ ";
                document.getElementById(ru).innerText = dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER") + "%";
                document.getElementById(ap).innerText = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") + " ��";
            }
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. (����) -->
    <script for=trT_EV_ACHTBL event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EV_ACHTBL event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-----------------------------------------------------------------+
    | �׸��忡�� �޼��� �Է½� ������, ȯ������ �� �հ� �ڵ� ���    |
    +------------------------------------------------------------------>
    <script language="javascript"  for=grdT_EV_ACHTBL event=OnExit(row,colid,olddata)>

        var flag = 0;

        if (colid == "SELF_ACHRAT") {

            if (dsT_EV_ACHTBL.NameValue(row, colid) == "") {
                dsT_EV_ACHTBL.NameValue(row, "SELF_ACHPNT") = 0;
                dsT_EV_ACHTBL.NameValue(row, "SELF_ACHCVT") = 0;
                dsT_EV_ACHTBL.NameValue(row, "SELF_DIFPNT") = 0;
                dsT_EV_ACHTBL.NameValue(row, "SELF_DIFCVT") = 0;

                return;
            }

            if (dsT_EV_ACHTBL.NameValue(row, colid) < 0) {
                alert("������ �Է��Ͽ� �ֽʽÿ�");
                dsT_EV_ACHTBL.NameValue(row, colid) = olddata;
                dsT_EV_ACHTBL.RowPosition = row;
                return;
            }

            for (var i = 1; i <= dsT_EV_ACHPNT.CountRow; i++) {

                // �Է��� �޼����� �ش��ϴ� �޼��������� ã�� ������ �������� SET
                if (dsT_EV_ACHPNT.NameValue(i, "RATE_OVER") <= dsT_EV_ACHTBL.NameValue(row, colid) &&
                    dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER") > dsT_EV_ACHTBL.NameValue(row, colid) ) {

                    dsT_EV_ACHTBL.NameValue(row, "SELF_ACHPNT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT");
                    dsT_EV_ACHTBL.NameValue(row, "SELF_ACHCVT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);
                    flag = 1;
                    break;

                }
            }

            // �Է��� �޼����� �ش��ϴ� �޼��������� ã�� ���� ��� �޼�������(�̸�)�� �ִ밪���� �Էµ� �޼����� ũ�ٸ�
            if (flag == 0) {
                if (dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "RATE_UNDER") <= dsT_EV_ACHTBL.NameValue(row, colid)) {
                    dsT_EV_ACHTBL.NameValue(row, "SELF_ACHPNT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT");
                    dsT_EV_ACHTBL.NameValue(row, "SELF_ACHCVT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);

                }
            }

        }

    </script>

    <script language="javascript"  for=dsT_EV_ACHTBL event=OnRowPosChanged(row)>

        var EVL_YY    = form1.txtEVL_YY_SHR.value;
        var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
        var ENO_NO    = form1.txtENO_NO_SHR.value;
        var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;
        var AIM_YMD   = '';
        var AIM_SEQ   = '';

        if (row < 1) return;

        dsT_EV_AIMSUB.ClearData();

        AIM_YMD = dsT_EV_ACHTBL.NameValue(row, "AIM_YMD");
        AIM_SEQ = dsT_EV_ACHTBL.NameValue(row, "AIM_SEQ");

        //�����ͼ� ����
        dsT_EV_AIMSUB.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc130.cmd.VLUC130CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&AIM_YMD="+AIM_YMD+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO+"&AIM_SEQ="+AIM_SEQ;
        dsT_EV_AIMSUB.Reset();

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������Է�</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�������Է�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="480">
        <table width="480" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop3"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>���������� </strong></td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="480" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="90"></col>
                            <col width="380"></col>
                        </colgroup>
                        <tr>
                            <td align="center" height="25" class="creamBold">�򰡱���</td>
                            <td class="padding2423">
                                <input id=txtEVL_YY_SHR  name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly> ��&nbsp;
                                <input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly> ȸ��
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">������</td>
                            <td class="padding2423">
                                �Ҽ� <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly" readonly>&nbsp;&nbsp;
                                ��� <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly>&nbsp;&nbsp;
                                ���� <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="14" class="input_ReadOnly" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="creamBold">��&nbsp;��&nbsp;��</td>
                            <td class="padding2423">
                                ���� <select id="cmbEVLENO_NO_SHR" name="cmbEVL_YY_SHR" style="width:100" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                     </select>
                            </td>
                            <!-- Hidden Filed (���� : '2'�̸� ���ڰ� ������)-->
                            <input type=hidden name=txtGBN_SHR value="2">
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
        <td width="10">&nbsp;</td>
        <td width="310">
        <table width="310" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop3"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>�������� </strong></td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="310" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="105"></col>
                            <col width="50 "></col>
                            <col width="105"></col>
                            <col width="50 "></col>
                        </colgroup>
                        <tr>
                            <td height="25" class="creamBold" align="center"><span id=ro_1 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_1 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_1>&nbsp;</span></td>
                            <td class="creamBold" align="center"><span id=ro_2 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_2 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_2>&nbsp;</span></td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center"><span id=ro_3 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_3 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_3>&nbsp;</span></td>
                            <td class="creamBold" align="center"><span id=ro_4 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_4 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_4>&nbsp;</span></td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center"><span id=ro_5 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_5 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_5>&nbsp;</span></td>
                            <td class="padding2423" colspan="2"><input type=button name=btnACHPNT value="����������" onClick="fnc_achpntPopup(form1.txtEVL_YY_SHR.value, GUBUN)">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
<table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="50%" ><span id="resultMessage">&nbsp;</span></td>
                    <td class="searchState" valign="bottom" align="right">
                    &nbsp;������ ��&nbsp;<input id=txtTOT_PNT  name=txtTOT_PNT size="6" style="text-align:right;font-weight:bold;" readonly>
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
                        <object    id="grdT_EV_ACHTBL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:220px;">
                            <param name="DataID"                    value="dsT_EV_ACHTBL">
                            <param name="EdiTABLE"                  value="true">
                            <param name="DragDropEnable"            value="true">
                            <param name="SortView"                  value="Left">
                            <param name="ColSizing"                 value="true">
                            <param name="FixSizing"                 value="true">
                            <param name="IndWidth"                  value=0>
                            <param name="VIEWSUMMARY"               value=0>
                            <Param name="TranslateKeyDown"          value=1>
                            <param name="Format"                    value="
                                <FC> id='TASK_AIM'        width=130  name='�ֿ��ٽɰ���'  align=left   Edit='None' </FC>
                                <FC> id='TASK_CSF'   	  width=130  name='�ٽɼ������'  align=left   Edit='None' </FC>
                                <FC> id='BASIC_PAR'       width=130  name='KPI(�������)' align=left   Edit='None' </FC>
                                <FC> id='AIM_LEVEL'       width=90   name='��ǥ;(Target)' align=left   Edit='None' </FC>
                                <FC> id='ADDING_PCT'      width=40   name='����ġ'        align=center Edit='None' </FC>
                                <C>  id='SELF_ACHDEC'     width=130  name='�޼���'        align=left   Edit='true' </C>
                                <C>  id='SELF_ACHRAT'     width=40   name='�޼���;%'      align=right  Edit='Numeric' EditLimit=3</C>
                                <G>  name='�޼�������' HeadBgColor='#F7DCBB'
                                     <C> id='SELF_ACHPNT' width=40   name='��'          align=right  Edit='None' </C>
                                     <C> id='SELF_ACHCVT' width=40   name='ȯ��'          align=right  Edit='None' Dec=2 </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <comment id="__NSID__">
                <object    id="grdT_EV_AIMSUB" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:100px;">
                    <param name="DataID"                    value="dsT_EV_AIMSUB">
                    <param name="EdiTABLE"                  value="false">
                    <param name="DragDropEnable"            value="true">
                    <param name="SortView"                  value="Left">
                            <param name="ColSizing"                 value="true">
                            <param name="FixSizing"                 value="true">
                    <param name="VIEWSUMMARY"               value=0>
                    <param name="IndWidth"                  value=0>
                    <param name="UsingOneClick"             value="1">
                    <param name="AutoReSizing"              value="true">
                    <param name="ColSelect"                 value="true">
                    <param name="Format"                    value="
                        <C> id='ITEM_DEC'        width=100       name='�ֿ������׸�'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='����ǥ(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=110        name='S - (110%�̻�)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=180        name='A - (100%~110%�̸�)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=180        name='B - (95%~100%�̸�)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=180        name='C - (85%~95%�̸�)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=110        name='D - (85%�̸�)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
    							   </G>
                    ">
                </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>
<!--
    ************************************************************************************
    * @Source         : pira033.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/31  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>��������</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        var str_ymd = '';
        var seq_no  = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_ADDJOB.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira033.cmd.PIRA033CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_ADDJOB.Reset();

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

                trT_CM_ADDJOB.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira033.cmd.PIRA033CMD&S_MODE=SAV";
                trT_CM_ADDJOB.post();

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
            if (dsT_CM_ADDJOB.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_ADDJOB.RowStatus(dsT_CM_ADDJOB.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_ADDJOB.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("��������[" + dsT_CM_ADDJOB.NameValue(dsT_CM_ADDJOB.RowPosition,"STR_YMD") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_ADDJOB.DeleteRow(dsT_CM_ADDJOB.RowPosition);

            if (status != 1) {
                trT_CM_ADDJOB.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira033.cmd.PIRA033CMD&S_MODE=DEL";
                trT_CM_ADDJOB.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_ADDJOB.SetColumn(form1.grdT_CM_ADDJOB.GetColumnID(0));
            form1.grdT_CM_ADDJOB.Focus();

            bnd.ActiveBind = true;

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

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CM_ADDJOB.CountColumn == 0) {
                dsT_CM_ADDJOB.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, SEQ_NO:STRING:KEYVALUETYPE, END_YMD:STRING, DPT_CD:STRING, DPT_NM:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_ADDJOB.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_ADDJOB.setColumn(form1.grdT_CM_ADDJOB.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

            document.getElementById("txtSTR_YMD").focus();
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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_ADDJOB.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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
            var END_YMD = '';

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CM_ADDJOB.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_ADDJOB.CountRow; i++ ) {
                if ( dsT_CM_ADDJOB.RowStatus(i) == 1 ||
                     dsT_CM_ADDJOB.RowStatus(i) == 3 ) {


                    // ��������
                    if( dsT_CM_ADDJOB.NameValue(i, "STR_YMD") == '' ) {
                        alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_ADDJOB.NameValue(i, "STR_YMD"), "������") && dsT_CM_ADDJOB.NameValue(i, "STR_YMD") != "") {
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_ADDJOB.NameValue(i, "END_YMD"), "������") && dsT_CM_ADDJOB.NameValue(i, "END_YMD") != "") {
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // �������ڿ� �������� ��
                    if( dsT_CM_ADDJOB.NameValue(i, "STR_YMD") != '' && dsT_CM_ADDJOB.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_ADDJOB.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_CM_ADDJOB.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�������ڰ� �������ں��� �۽��ϴ�.");
                            dsT_CM_ADDJOB.RowPosition = i;
                            document.getElementById("txtEND_YMD").focus();
                            return false;
                        }
                    }


                    // ��������/�Ҽ�
                    if( dsT_CM_ADDJOB.NameValue(i, "DPT_CD") == '' && dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") == '') {
                        alert("��������, �Ҽ� �� �Ѱ����� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtHEAD_CD").focus();
                        return false;
                    }

                    // ��������
                    if (dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "HEAD_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtHEAD_CD").focus();
                        return;
                    }

                    // �����Ҽ�
                    if (dsT_CM_ADDJOB.NameValue(i, "DPT_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DPT_NM") == "") {
                        alert("�����Ҽ��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return;
                    }

                    // �������ڿ� �Ҽ� CHECK
                    for (var j = 1; j <= dsT_CM_ADDJOB.CountRow; j++ ) {

                        END_YMD1 = dsT_CM_ADDJOB.NameValue(j, "END_YMD");
                        END_YMD2 = dsT_CM_ADDJOB.NameValue(i, "END_YMD");

                        // �������ڰ� �ԷµǾ� ���� �ʴٸ�
                        if (END_YMD1 == "") {
                            END_YMD1 = '9999-12-31';
                        }

                        if (END_YMD2 == "") {
                            END_YMD2 = '9999-12-31';
                        }

                        if (!(dsT_CM_ADDJOB.NameValue(i, "STR_YMD") > END_YMD1 ||
                              END_YMD2 < dsT_CM_ADDJOB.NameValue(j, "STR_YMD"))) {

                            if (i == j) {
                                continue;
                            }


                            if ( dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") == dsT_CM_ADDJOB.NameValue(j, "HEAD_CD")  &&
                                dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") != ''                             ) {
                                alert("�ش� �Ⱓ�� �ߺ��Ǵ� �������ΰ� �ֽ��ϴ�. Ȯ�ιٶ��ϴ�.");
                                dsT_CM_ADDJOB.RowPosition = i;
                                document.getElementById("txtHEAD_CD").focus();
                                return;
                            }


                            if ( dsT_CM_ADDJOB.NameValue(i, "DPT_CD") == dsT_CM_ADDJOB.NameValue(j, "DPT_CD")  &&
                                dsT_CM_ADDJOB.NameValue(i, "DPT_CD") != ''                             ) {
                                alert("�ش� �Ⱓ�� �ߺ��Ǵ� �����Ҽ��� �ֽ��ϴ�. Ȯ�ιٶ��ϴ�.");
                                dsT_CM_ADDJOB.RowPosition = i;
                                document.getElementById("txtDPT_CD").focus();
                                return;
                            }
                        }
                    }

                    // ������å
                    if (dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") == '' ) {
                        alert("������å�� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return false;
                    }

                    // ������å
                    if (dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DUTY_NM") == "") {
                        alert("������å�ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return;
                    }

              /*      if (dsT_CM_ADDJOB.NameValue(i, "DPT_CD") == "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") == "" ) {
                        // �Ҽ�, ��å ��� �Է� ���� ���
                    }
                    else if (dsT_CM_ADDJOB.NameValue(i, "DPT_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") != "" ) {
                        // �Ҽ�,��å ��� �Է��� ���
                    }
                    else {
                        // �Ҽ�,��å �� �ϳ��� �Է��� ���
                        alert("�Ҽ�, ��å ��� �Է��ϼž� �մϴ�.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return;
                    } */

                    if ( dsT_CM_ADDJOB.RowStatus(i) == 1) {
                        document.getElementById("txtSTR_YMD").disabled = true;
                        document.getElementById("ImgStrYmd").disabled  = true;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style ����
            cfStyleGrid(form1.grdT_CM_ADDJOB, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_PERSON.IsUpdated)  {
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

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("txtSTR_YMD").disabled  = false;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtDUTY_CD").disabled  = false;

                document.getElementById("ImgStrYmd").disabled   = false;
                document.getElementById("ImgEndYmd").disabled   = false;
                document.getElementById("ImgDptCd").disabled    = false;
                document.getElementById("ImgDutyCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtDUTY_CD").disabled  = true;

                document.getElementById("ImgStrYmd").disabled   = true;
                document.getElementById("ImgEndYmd").disabled   = true;
                document.getElementById("ImgDptCd").disabled    = true;
                document.getElementById("ImgDutyCd").disabled   = true;

            }
        }

        function fnc_getSeqNo(obj) {
            var SysStatus = dsT_CM_ADDJOB.SysStatus(dsT_CM_ADDJOB.RowPosition);
            var SeqNo = 0;

            if (SysStatus == 1) {

                document.getElementById("txtSEQ_NO").value = '';

                if (obj.value != '') {

                    for (var i = 1; i <= dsT_CM_ADDJOB.CountRow; i++) {

                        if (dsT_CM_ADDJOB.NameValue(i, "STR_YMD") == obj.value &&
                            dsT_CM_ADDJOB.NameValue(i, "SEQ_NO") >= SeqNo &&
                            i != dsT_CM_ADDJOB.RowPosition) {

                           SeqNo = new Number(dsT_CM_ADDJOB.NameValue(i, "SEQ_NO")) + 1;

                        }
                    }

                    if (SeqNo == 0) {
                        SeqNo = 1;
                    }

                    document.getElementById("txtSEQ_NO").value = SeqNo;
                }
            }

            str_ymd = document.getElementById("txtSTR_YMD").value;
            seq_no  = document.getElementById("txtSEQ_NO").value;
        }

        function fnc_BlurYmd() {
            if (str_ymd == document.getElementById("txtSTR_YMD").value &&
                seq_no  == document.getElementById("txtSEQ_NO").value) {
                return;
            }

            fnc_getSeqNo(document.getElementById("txtSTR_YMD"));

        }

    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_ADDJOB                       |
    | 3. Table List : T_CM_ADDJOB                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_ADDJOB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_ADDJOB                       |
    | 3. Table List : T_CM_ADDJOB                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_ADDJOB" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_ADDJOB)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_ADDJOB Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_ADDJOB.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_ADDJOB Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_ADDJOB Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[��������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("�������ڿ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_ADDJOB event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_ADDJOB event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_ADDJOB Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_ADDJOB.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">   <img src="/images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="52 "></col>
                    <col width="100"></col>
                    <col width="52 "></col>
                    <col width="105"></col>
                    <col width="40 "></col>
                    <col width="133"></col>
                    <col width="40 "></col>
                    <col width="133"></col>
                    <col width="40 "></col>
                    <col width="133"></col>
                </colgroup>
                <tr>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden id="txtSEQ_NO">
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onBlur="fnc_BlurYmd();"  onChange="fnc_CheckDate(this, '������');fnc_getSeqNo(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','0','53');"></a>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','125','53');"></a>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id="txtHEAD_CD" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('B2', 'txtHEAD_CD','txtHEAD_NM');"> <input id="txtHEAD_NM" style="width:53%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHeadCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHeadCd" name="ImgHeadCd" width="21" height="20" border="0" align="absmiddle" onClick=fnc_commnmPopup('txtHEAD_CD','txtHEAD_NM','����','HEAD')></a>
                    </td>
                    <td align="center" class="creamBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:17%"  maxlength="2" onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');"> <input id="txtDPT_NM" style="width:53%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick=fnc_commnmPopup('txtDPT_CD','txtDPT_NM','�Ҽ�','DEPT')></a>
                    </td>
                    <td align="center" class="creamBold">��å</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('A7', 'txtDUTY_CD','txtDUTY_NM');"> <input id="txtDUTY_NM" style="width:53%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDutyCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDutyCd" name="ImgDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDUTY_CD','txtDUTY_NM','��å','A7')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
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
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_ADDJOB" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:210px;">
                            <param name="DataID"                  value="dsT_CM_ADDJOB">
                            <param name="Format"                  value="
                                <C> id={currow}        width=50   name='����'         align=center </C>
                                <C> id=STR_YMD         width=120  name='������'       align=center </C>
                                <C> id=END_YMD         width=120  name='������'       align=center </C>
                                <C> id=HEAD_NM         width=161  name='��������'     align=center </C>
                                <C> id=DPT_NM          width=161  name='�����Ҽ�'     align=center </C>
                                <C> id=DUTY_NM         width=161  name='������å'     align=center </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_ADDJOB">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=HEAD_CD       Ctrl=txtHEAD_CD      Param=value </C>
        <C> Col=HEAD_NM       Ctrl=txtHEAD_NM      Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=DUTY_CD       Ctrl=txtDUTY_CD      Param=value </C>
        <C> Col=DUTY_NM       Ctrl=txtDUTY_NM      Param=value </C>
    '>
</object>
<!--
    ************************************************************************************
    * @Source         : mema021.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/23  |  ������   | �����ۼ�                                               *
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

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ME_EDUCATION.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema021.cmd.MEMA021CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_EDUCATION.Reset();

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

                trT_ME_EDUCATION.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema021.cmd.MEMA021CMD&S_MODE=SAV";
                trT_ME_EDUCATION.post();

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
            if (dsT_ME_EDUCATION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_EDUCATION.RowStatus(dsT_ME_EDUCATION.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_EDUCATION.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("��������[" + dsT_ME_EDUCATION.NameValue(dsT_ME_EDUCATION.RowPosition,"STR_YMD") + "] ������[" + dsT_ME_EDUCATION.NameValue(dsT_ME_EDUCATION.RowPosition,"EDU_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ME_EDUCATION.DeleteRow(dsT_ME_EDUCATION.RowPosition);

            if (status != 1) {
                trT_ME_EDUCATION.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema021.cmd.MEMA021CMD&S_MODE=DEL";
                trT_ME_EDUCATION.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ME_EDUCATION.SetColumn(form1.grdT_ME_EDUCATION.GetColumnID(0));
            form1.grdT_ME_EDUCATION.Focus();

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
            if (dsT_ME_EDUCATION.CountColumn == 0) {
                dsT_ME_EDUCATION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, EDU_CD:STRING:KEYVALUETYPE, EDU_NM:STRING, INT_NAM:STRING, SBJ_CD:STRING:KEYVALUETYPE, EDU_TAG:STRING, APP_VAL:INT, DPT_CD:STRING, JOB_CD:STRING, EDU_AMT:INT, TRA_AMT:INT, BOLO_AMT:INT, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_EDUCATION.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_EDUCATION.setColumn(form1.grdT_ME_EDUCATION.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEDU_CD").disabled  = false;
            document.getElementById("txtSBJ_CD").disabled  = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEduCd").disabled   = false;
            document.getElementById("ImgSbjCd").disabled   = false;

            document.getElementById("cmbEDU_TAG").value = 'N';

            document.getElementById("txtDPT_CD").value = parent.document.getElementById("txtDPT_CD").value;
            document.getElementById("txtDPT_NM").value = parent.document.getElementById("txtDPT_NM").value;
            document.getElementById("txtJOB_CD").value = parent.document.getElementById("txtJOB_CD").value;
            document.getElementById("txtJOB_NM").value = parent.document.getElementById("txtJOB_NM").value;

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

			dsT_ME_EDUCATION.ClearData();
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

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_ME_EDUCATION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_EDUCATION.CountRow; i++ ) {
                if ( dsT_ME_EDUCATION.RowStatus(i) == 1 ||
                     dsT_ME_EDUCATION.RowStatus(i) == 3 ) {


                    // ��������
                    if( dsT_ME_EDUCATION.NameValue(i, "STR_YMD") == '' ) {
                        alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_EDUCATION.NameValue(i, "STR_YMD"), "��������") && dsT_ME_EDUCATION.NameValue(i, "STR_YMD") != "") {
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // ��������
                    if( dsT_ME_EDUCATION.NameValue(i, "END_YMD") == '' ) {
                        alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_EDUCATION.NameValue(i, "END_YMD"), "��������") && dsT_ME_EDUCATION.NameValue(i, "END_YMD") != "") {
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // �������ڿ� �������� ��
                    if( dsT_ME_EDUCATION.NameValue(i, "STR_YMD") != '' && dsT_ME_EDUCATION.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_EDUCATION.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_ME_EDUCATION.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�����Ⱓ �������ڰ� �������ں��� �۽��ϴ�.");
                            dsT_ME_EDUCATION.RowPosition = i;
                            document.getElementById("txtEND_YMD").focus();
                            return false;
                        }
                    }

                    // ���������ڵ�
                    if( dsT_ME_EDUCATION.NameValue(i, "EDU_CD") == '' ) {
                        alert("���������ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtEDU_CD").focus();
                        return false;
                    }

                    // ���������ڵ�
                    if (dsT_ME_EDUCATION.NameValue(i, "EDU_CD") != "" &&
                        dsT_ME_EDUCATION.NameValue(i, "EDU_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtEDU_CD").focus();
                        return;
                    }

                    // ���������ڵ�
                    if( dsT_ME_EDUCATION.NameValue(i, "SBJ_CD") == '' ) {
                        alert("���������ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtSBJ_CD").focus();
                        return false;
                    }

                    // �����ڵ�
                    if (dsT_ME_EDUCATION.NameValue(i, "SBJ_CD") != "" &&
                        dsT_ME_EDUCATION.NameValue(i, "SBJ_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtSBJ_CD").focus();
                        return;
                    }

                    // �Ҽ�
                    if (dsT_ME_EDUCATION.NameValue(i, "DPT_CD") != "" &&
                        dsT_ME_EDUCATION.NameValue(i, "DPT_NM") == "") {
                        alert("�Ҽ��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return;
                    }

                    // ����
                    if (dsT_ME_EDUCATION.NameValue(i, "JOB_CD") != "" &&
                        dsT_ME_EDUCATION.NameValue(i, "JOB_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_EDUCATION.RowPosition = i;
                        document.getElementById("txtJOB_CD").focus();
                        return;
                    }

                    if ( dsT_ME_EDUCATION.RowStatus(i) == 1) {
                       document.getElementById("txtSTR_YMD").disabled = false;
                       document.getElementById("txtEDU_CD").disabled  = false;
                       document.getElementById("txtSBJ_CD").disabled  = false;
                       document.getElementById("ImgStrYmd").disabled  = false;
                       document.getElementById("ImgEduCd").disabled   = false;
                       document.getElementById("ImgSbjCd").disabled   = false;

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
            cfStyleGrid(form1.grdT_ME_EDUCATION, 0,"false","false");

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
                document.getElementById("txtEDU_CD").disabled   = false;
                document.getElementById("txtINT_NAM").disabled  = false;
                document.getElementById("txtSBJ_CD").disabled   = false;
                document.getElementById("cmbEDU_TAG").disabled  = false;
                document.getElementById("txtAPP_VAL").disabled  = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtJOB_CD").disabled   = false;
                form1.medEDU_AMT.enabled                        = true;
                form1.medTRA_AMT.enabled                        = true;
                form1.medBOLO_AMT.enabled                       = true;
                document.getElementById("txtREMARK").disabled   = false;

                document.getElementById("ImgStrYmd").disabled = false;
                document.getElementById("ImgEndYmd").disabled = false;
                document.getElementById("ImgEduCd").disabled  = false;
                document.getElementById("ImgSbjCd").disabled  = false;
                document.getElementById("ImgDptCd").disabled  = false;
                document.getElementById("ImgJobCd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtEDU_CD").disabled   = true;
                document.getElementById("txtINT_NAM").disabled  = true;
                document.getElementById("txtSBJ_CD").disabled   = true;
                document.getElementById("cmbEDU_TAG").disabled  = true;
                document.getElementById("txtAPP_VAL").disabled  = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtJOB_CD").disabled   = true;
                form1.medEDU_AMT.enabled                        = false;
                form1.medTRA_AMT.enabled                        = false;
                form1.medBOLO_AMT.enabled                       = false;
                document.getElementById("txtREMARK").disabled   = true;

                document.getElementById("ImgStrYmd").disabled = true;
                document.getElementById("ImgEndYmd").disabled = true;
                document.getElementById("ImgEduCd").disabled  = true;
                document.getElementById("ImgSbjCd").disabled  = true;
                document.getElementById("ImgDptCd").disabled  = true;
                document.getElementById("ImgJobCd").disabled  = true;

            }
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
    | 2. �̸� : dsT_ME_EDUCATION                    |
    | 3. Table List : T_ME_EDUCATION                |
    +----------------------------------------------->
    <Object ID="dsT_ME_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_EDUCATION                    |
    | 3. Table List : T_ME_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_ME_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_EDUCATION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_EDUCATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_EDUCATION.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtEDU_CD").disabled  = true;
            document.getElementById("txtSBJ_CD").disabled  = true;
            document.getElementById("ImgStrYmd").disabled  = true;
            document.getElementById("ImgEduCd").disabled   = true;
            document.getElementById("ImgSbjCd").disabled   = true;
        }


    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_EDUCATION Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_EDUCATION Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {

            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEDU_CD").disabled  = false;
            document.getElementById("txtSBJ_CD").disabled  = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEduCd").disabled   = false;
            document.getElementById("ImgSbjCd").disabled   = false;

            alert("�ش� �ʼ��Է��׸�[��������/��������/�����ڵ�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {

            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEDU_CD").disabled  = false;
            document.getElementById("txtSBJ_CD").disabled  = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEduCd").disabled   = false;
            document.getElementById("ImgSbjCd").disabled   = false;

            alert("��������/��������/�����ڵ忡 ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_EDUCATION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_EDUCATION event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_EDUCATION Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_EDUCATION.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEDU_CD").disabled  = false;
            document.getElementById("txtSBJ_CD").disabled  = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEduCd").disabled   = false;
            document.getElementById("ImgSbjCd").disabled   = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtEDU_CD").disabled  = true;
            document.getElementById("txtSBJ_CD").disabled  = true;
            document.getElementById("ImgStrYmd").disabled  = true;
            document.getElementById("ImgEduCd").disabled   = true;
            document.getElementById("ImgSbjCd").disabled   = true;

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
                    <col width="80 "></col>
                    <col width="160"></col>
                    <col width="80 "></col>
                    <col width="80 "></col>
                    <col width="80 "></col>
                    <col width="80 "></col>
                    <col width="80 "></col>
                    <col width="160"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�����Ⱓ</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtSTR_YMD" style="width:33%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','5','53');"></a> -
                        <input id="txtEND_YMD" style="width:33%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','130','53');"></a>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtEDU_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('Q9', 'txtEDU_CD','txtEDU_NM');"> <input id="txtEDU_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEDU_CD','txtEDU_NM','��������','Q9')"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtINT_NAM" maxlength="22" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtSBJ_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('Q1', 'txtSBJ_CD','txtSBJ_NM');"> <input id="txtSBJ_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSbjCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgSbjCd" name="ImgSbjCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSBJ_CD','txtSBJ_NM','��������','Q1')"></a>
                    </td>
                    <td align="center" class="creamBold">���Ῡ��</td>
                    <td class="padding2423">
                        <select id="cmbEDU_TAG" style="width:100%" >
                            <option value="Y" >����</option>
                            <option value="N" >�̼���</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtAPP_VAL" maxlength="3" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:15%" maxlength="3" onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');"> <input id="txtDPT_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','�Ҽ�','DEPT')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('A2', 'txtJOB_CD','txtJOB_NM');"> <input id="txtJOB_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD','txtJOB_NM','����','A2')"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medTRA_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medBOLO_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="7">
                        <input id="txtREMARK" maxlength="60" style="width:100%">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtOCC_CD" size="1">
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
                        <object id="grdT_ME_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:128px;">
                            <param name="DataID"                  value="dsT_ME_EDUCATION">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'            align=center </C>
                                <C> id=STR_YMD         width=70   name='������'          align=center </C>
                                <C> id=END_YMD         width=70   name='������'          align=center </C>
                                <C> id=EDU_CD          width=60   name='�����ڵ�'        align=center </C>
                                <C> id=EDU_NM          width=70   name='������'                       </C>
                                <C> id=INT_NAM         width=100  name='����ó'                       </C>
                                <C> id=SBJ_CD          width=60   name='�����ڵ�'        align=center </C>
                                <C> id=SBJ_NM          width=140  name='������'                       </C>
                                <C> id=EDU_TAG         width=40   name='����'            align=center </C>
                                <C> id=APP_VAL         width=70   name='����'                         </C>
                                <C> id=DPT_CD          width=60   name='�Ҽ��ڵ�'        align=center </C>
                                <C> id=DPT_NM          width=100  name='�Ҽ�'                         </C>
                                <C> id=JOB_CD          width=60   name='�����ڵ�'        align=center </C>
                                <C> id=JOB_NM          width=70   name='����'                         </C>
                                <C> id=EDU_AMT         width=60   name='������'                       </C>
                                <C> id=TRA_AMT         width=60   name='�����'                       </C>
                                <C> id=BOLO_AMT        width=60   name='���ĺ�'                       </C>
                                <C> id=REMARK          width=110  name='���'                         </C>
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
    <Param Name="DataID",   Value="dsT_ME_EDUCATION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=EDU_CD        Ctrl=txtEDU_CD       Param=value </C>
        <C> Col=EDU_NM        Ctrl=txtEDU_NM       Param=value </C>
        <C> Col=INT_NAM       Ctrl=txtINT_NAM      Param=value </C>
        <C> Col=SBJ_CD        Ctrl=txtSBJ_CD       Param=value </C>
        <C> Col=SBJ_NM        Ctrl=txtSBJ_NM       Param=value </C>
        <C> Col=EDU_TAG       Ctrl=cmbEDU_TAG      Param=value </C>
        <C> Col=APP_VAL       Ctrl=txtAPP_VAL      Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
        <C> Col=EDU_AMT       Ctrl=medEDU_AMT      Param=text  </C>
        <C> Col=TRA_AMT       Ctrl=medTRA_AMT      Param=text  </C>
        <C> Col=BOLO_AMT      Ctrl=medBOLO_AMT     Param=text  </C>
    '>
</object>
<!--
    ************************************************************************************
    * @Source         : mema017.jsp                                                    *
    * @Description    : �ڰݸ��� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>�ڰݸ���</title>
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

            dsT_ME_QUALIFICATION.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema017.cmd.MEMA017CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_QUALIFICATION.Reset();

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

                trT_ME_QUALIFICATION.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema017.cmd.MEMA017CMD&S_MODE=SAV";
                trT_ME_QUALIFICATION.post();

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
            if (dsT_ME_QUALIFICATION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_QUALIFICATION.RowStatus(dsT_ME_QUALIFICATION.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_QUALIFICATION.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�ڰݸ���[" + dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition,"QUA_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ME_QUALIFICATION.DeleteRow(dsT_ME_QUALIFICATION.RowPosition);

            if (status != 1) {
                trT_ME_QUALIFICATION.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema017.cmd.MEMA017CMD&S_MODE=DEL";
                trT_ME_QUALIFICATION.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ME_QUALIFICATION.SetColumn(form1.grdT_ME_QUALIFICATION.GetColumnID(0));
            form1.grdT_ME_QUALIFICATION.Focus();

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
            if (dsT_ME_QUALIFICATION.CountColumn == 0) {
                dsT_ME_QUALIFICATION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, QUA_CD:STRING:KEYVALUETYPE, OCC_CD:STRING, QUA_NM:STRING, GAN_YMD:STRING:KEYVALUETYPE, CHG_YMD:STRING, DUE_YMD:STRING, QUA_NO:STRING, APP_ADM:STRING, ETG_YN:STRING, STS_YMD:STRING, STE_YMD:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_QUALIFICATION.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_QUALIFICATION.setColumn(form1.grdT_ME_QUALIFICATION.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtQUA_CD").disabled  = false;
            document.getElementById("ImgQuaCd").disabled   = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

            document.getElementById("cmbETG_YN").value = "X";

            document.getElementById("txtQUA_CD").focus();
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

			dsT_ME_QUALIFICATION.ClearData();
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
            if (!dsT_ME_QUALIFICATION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_QUALIFICATION.CountRow; i++ ) {
                if ( dsT_ME_QUALIFICATION.RowStatus(i) == 1 ||
                     dsT_ME_QUALIFICATION.RowStatus(i) == 3 ) {


                    // �ڰݸ���
                    if( dsT_ME_QUALIFICATION.NameValue(i, "txtQUA_CD") == '' ) {
                        alert("�ڰݸ���� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtQUA_CD").focus();
                        return false;
                    }

                    // �ڰݸ���
                    if (dsT_ME_QUALIFICATION.NameValue(i, "QUA_CD") != "" &&
                        dsT_ME_QUALIFICATION.NameValue(i, "QUA_NM") == "") {
                        alert("�ڰݸ����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtQUA_CD").focus();
                        return;
                    }

                    // �������
                    if( dsT_ME_QUALIFICATION.NameValue(i, "txtGAN_YMD") == '' ) {
                        alert("������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtGAN_YMD").focus();
                        return false;
                    }

                    // ������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD"), "�������") && dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD") != "") {
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtGAN_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_QUALIFICATION.NameValue(i, "CHG_YMD"), "������") && dsT_ME_QUALIFICATION.NameValue(i, "CHG_YMD") != "") {
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtCHG_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_QUALIFICATION.NameValue(i, "DUE_YMD"), "������") && dsT_ME_QUALIFICATION.NameValue(i, "DUE_YMD") != "") {
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtDUE_YMD").focus();
                        return false;
                    }

                    // ������ڿ� �������� ��
                    if( dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD") != '' && dsT_ME_QUALIFICATION.NameValue(i, "CHG_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD").replace(/\-/g,''),dsT_ME_QUALIFICATION.NameValue(i, "CHG_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("������ڰ� �������ں��� Ů�ϴ�.");
                            dsT_ME_QUALIFICATION.RowPosition = i;
                            document.getElementById("txtGAN_YMD").focus();
                            return false;
                        }
                    }

                    // ������ڿ� �������� ��
                    if( dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD") != '' && dsT_ME_QUALIFICATION.NameValue(i, "DUE_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD").replace(/\-/g,''),dsT_ME_QUALIFICATION.NameValue(i, "DUE_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("������ڰ� �������ں��� Ů�ϴ�.");
                            dsT_ME_QUALIFICATION.RowPosition = i;
                            document.getElementById("txtGAN_YMD").focus();
                            return false;
                        }
                    }

                    // ������������ CHECK
                    if (!fnc_CheckDate2(dsT_ME_QUALIFICATION.NameValue(i, "STS_YMD"), "����������") && dsT_ME_QUALIFICATION.NameValue(i, "STS_YMD") != "") {
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtSTS_YMD").focus();
                        return false;
                    }

                    // ������������ CHECK
                    if (!fnc_CheckDate2(dsT_ME_QUALIFICATION.NameValue(i, "STE_YMD"), "����������") && dsT_ME_QUALIFICATION.NameValue(i, "STE_YMD") != "") {
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtSTE_YMD").focus();
                        return false;
                    }

                    // �����������ڿ� ������������ ��
                    if( dsT_ME_QUALIFICATION.NameValue(i, "STS_YMD") != '' && dsT_ME_QUALIFICATION.NameValue(i, "STE_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_QUALIFICATION.NameValue(i, "STS_YMD").replace(/\-/g,''),dsT_ME_QUALIFICATION.NameValue(i, "STE_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�����������ڰ� �����������ں��� Ů�ϴ�.");
                            dsT_ME_QUALIFICATION.RowPosition = i;
                            document.getElementById("txtSTS_YMD").focus();
                            return false;
                        }
                    }

                    if ( dsT_ME_QUALIFICATION.RowStatus(i) == 1) {
                       document.getElementById("txtQUA_CD").disabled   = true;
                       document.getElementById("ImgQuaCd").disabled    = true;
                       document.getElementById("txtGAN_YMD").disabled  = true;
                       document.getElementById("ImgGanYmd").disabled   = true;
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
            cfStyleGrid(form1.grdT_ME_QUALIFICATION, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_ME_QUALIFICATION.IsUpdated)  {
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

                document.getElementById("txtQUA_CD").disabled  = false;
                document.getElementById("txtQUA_NM").disabled  = false;
                document.getElementById("txtGAN_YMD").disabled = false;
                document.getElementById("txtCHG_YMD").disabled = false;
                document.getElementById("txtDUE_YMD").disabled = false;
                document.getElementById("txtQUA_NO").disabled  = false;
                document.getElementById("txtAPP_ADM").disabled = false;
                document.getElementById("cmbETG_YN").disabled  = false;
                document.getElementById("txtSTS_YMD").disabled = false;
                document.getElementById("txtSTE_YMD").disabled = false;

                document.getElementById("ImgQuaCd").disabled   = false;
                document.getElementById("ImgGanYmd").disabled   = false;
                document.getElementById("ImgChgYmd").disabled   = false;
                document.getElementById("ImgDueYmd").disabled   = false;
                document.getElementById("ImgStsYmd").disabled   = false;
                document.getElementById("ImgSteYmd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtQUA_CD").disabled  = true;
                document.getElementById("txtQUA_NM").disabled  = true;
                document.getElementById("txtGAN_YMD").disabled = true;
                document.getElementById("txtCHG_YMD").disabled = true;
                document.getElementById("txtDUE_YMD").disabled = true;
                document.getElementById("txtQUA_NO").disabled  = true;
                document.getElementById("txtAPP_ADM").disabled = true;
                document.getElementById("cmbETG_YN").disabled  = true;
                document.getElementById("txtSTS_YMD").disabled = true;
                document.getElementById("txtSTE_YMD").disabled = true;

                document.getElementById("ImgQuaCd").disabled   = true;
                document.getElementById("ImgGanYmd").disabled   = true;
                document.getElementById("ImgChgYmd").disabled   = true;
                document.getElementById("ImgDueYmd").disabled   = true;
                document.getElementById("ImgStsYmd").disabled   = true;
                document.getElementById("ImgSteYmd").disabled   = true;

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
    | 2. �̸� : dsT_ME_QUALIFICATION                |
    | 3. Table List : T_ME_QUALIFICATION            |
    +----------------------------------------------->
    <Object ID="dsT_ME_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_QUALIFICATION                |
    | 3. Table List : T_ME_QUALIFICATION            |
    +----------------------------------------------->
    <Object ID ="trT_ME_QUALIFICATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_QUALIFICATION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_QUALIFICATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_QUALIFICATION.CountRow);

            document.getElementById("txtQUA_CD").disabled   = true;
            document.getElementById("ImgQuaCd").disabled    = true;
            document.getElementById("txtGAN_YMD").disabled  = true;
            document.getElementById("ImgGanYmd").disabled   = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_QUALIFICATION Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_QUALIFICATION Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

            alert("�ش� �ʼ��Է��׸�[�ڰݸ����ڵ�/�����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019 ) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

            alert("�ڰݸ����ڵ�/����Ͽ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("�ڰݸ����ڵ�/����Ͽ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_QUALIFICATION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_QUALIFICATION event="OnFail()">

        cfErrorMsg(this);

    </script>


    <script language=JavaScript for=dsT_ME_QUALIFICATION Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_QUALIFICATION.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

        }
        else {
            document.getElementById("txtQUA_CD").disabled   = true;
            document.getElementById("ImgQuaCd").disabled    = true;
            document.getElementById("txtGAN_YMD").disabled  = true;
            document.getElementById("ImgGanYmd").disabled   = true;

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
            <strong>�ڰݸ���</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">  <img src="/images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif"  name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                    <col width="187"></col>
                    <col width="80 "></col>
                    <col width="187"></col>
                    <col width="80 "></col>
                    <col width="187"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�ڰݸ���</td>
                    <td class="padding2423">
                        <input id="txtQUA_CD" style="width:22%" maxlength="3" onChange="fnc_GetCommNm('H1', 'txtQUA_CD','txtQUA_NM');"> <input id="txtQUA_NM" style="width:58%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgQuaCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgQuaCd" name="ImgQuaCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtQUA_CD','txtQUA_NM','�ڰݸ���','H1')"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtGAN_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�����');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGanYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGanYmd" name="ImgGanYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGAN_YMD','','340','52');"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtCHG_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgChgYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgChgYmd" name="ImgChgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCHG_YMD','','610','52');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtDUE_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDueYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDueYmd" name="ImgDueYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDUE_YMD','','80','77');"></a>
                    </td>
                    <td align="center" class="creamBold">������ȣ</td>
                    <td class="padding2423" >
                        <input id="txtQUA_NO" maxlength="50" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtAPP_ADM" maxlength="8" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <select id="cmbETG_YN" style="width:100%" >
                            <option value="O" >����</option>
                            <option value="X" >������</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">����������</td>
                    <td class="padding2423" >
                        <input id="txtSTS_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '����������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStsYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStsYmd" name="ImgStsYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTS_YMD','','340','102');"></a>
                    </td>
                    <td align="center" class="creamBold">����������</td>
                    <td class="padding2423" >
                        <input id="txtSTE_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '����������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSteYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgSteYmd" name="ImgSteYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTE_YMD','','610','102');"></a>
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
                        <object id="grdT_ME_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:153px;">
                            <param name="DataID"                  value="dsT_ME_QUALIFICATION">
                            <param name="Format"                  value="
                                <C> id={currow}        width=29   name='����'         align=center </C>
                                <C> id=QUA_CD          width=80   name='�ڰݸ����ڵ�' align=center </C>
                                <C> id=QUA_NM          width=80   name='�ڰݸ���'                  </C>
                                <C> id=GAN_YMD         width=70   name='�����'       align=center </C>
                                <C> id=CHG_YMD         width=70   name='������'       align=center </C>
                                <C> id=DUE_YMD         width=70   name='������'       align=center </C>
                                <C> id=QUA_NO          width=90   name='������ȣ'                  </C>
                                <C> id=APP_ADM         width=84   name='����ó'                    </C>
                                <C> id=ETG_YN          width=70   name='��������'     show=false   </C>
                                <C> id=ETG_YN1         width=60   name='��������'     align=center value={Decode(ETG_YN,'O','����','X','������','')} </C>
                                <C> id=STS_YMD         width=70   name='����������'   align=center </C>
                                <C> id=STE_YMD         width=70   name='����������'   align=center </C>
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
<!-- �ڰݸ��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_QUALIFICATION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=QUA_CD       Ctrl=txtQUA_CD       Param=value </C>
        <C> Col=OCC_CD       Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=QUA_NM       Ctrl=txtQUA_NM       Param=value </C>
        <C> Col=GAN_YMD      Ctrl=txtGAN_YMD      Param=value </C>
        <C> Col=CHG_YMD      Ctrl=txtCHG_YMD      Param=value </C>
        <C> Col=DUE_YMD      Ctrl=txtDUE_YMD      Param=value </C>
        <C> Col=QUA_NO       Ctrl=txtQUA_NO       Param=value </C>
        <C> Col=APP_ADM      Ctrl=txtAPP_ADM      Param=value </C>
        <C> Col=ETG_YN       Ctrl=cmbETG_YN       Param=value </C>
        <C> Col=STS_YMD      Ctrl=txtSTS_YMD      Param=value </C>
        <C> Col=STE_YMD      Ctrl=txtSTE_YMD      Param=value </C>
    '>
</object>
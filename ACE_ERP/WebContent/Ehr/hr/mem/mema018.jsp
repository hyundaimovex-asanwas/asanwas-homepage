<!--
    ************************************************************************************
    * @Source         : mema018.jsp                                                    *
    * @Description    : �Ի������ PAGE                                                *
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
    <title>�Ի������</title>
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

            dsT_ME_BHISTORY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema018.cmd.MEMA018CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_BHISTORY.Reset();

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

                trT_ME_BHISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema018.cmd.MEMA018CMD&S_MODE=SAV";
                trT_ME_BHISTORY.post();

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
            if (dsT_ME_BHISTORY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_BHISTORY.RowStatus(dsT_ME_BHISTORY.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_BHISTORY.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("ȸ���[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"CMP_NAM") + "] �Ի���[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"STR_YMD") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ME_BHISTORY.DeleteRow(dsT_ME_BHISTORY.RowPosition);

            if (status != 1) {
                trT_ME_BHISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema018.cmd.MEMA018CMD&S_MODE=DEL";
                trT_ME_BHISTORY.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ME_BHISTORY.SetColumn(form1.grdT_ME_BHISTORY.GetColumnID(0));
            form1.grdT_ME_BHISTORY.Focus();

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
            if (dsT_ME_BHISTORY.CountColumn == 0) {
                dsT_ME_BHISTORY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, CMP_NAM:STRING, GRP_CD:STRING, GRP_NM:STRING, DPT_NAM:STRING, JOB_CD:STRING, CHG_JOB:STRING, CAR_PCT:INT, CAR_YY:INT, CAR_MM:INT, SAL_AMT:INT, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_BHISTORY.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_BHISTORY.setColumn(form1.grdT_ME_BHISTORY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEND_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEndYmd").disabled  = false;

            document.getElementById("txtCMP_NAM").focus();
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

			dsT_ME_BHISTORY.ClearData();
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
            if (!dsT_ME_BHISTORY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_BHISTORY.CountRow; i++ ) {
                if ( dsT_ME_BHISTORY.RowStatus(i) == 1 ||
                     dsT_ME_BHISTORY.RowStatus(i) == 3 ) {


                    // �Ի�����
                    if( dsT_ME_BHISTORY.NameValue(i, "STR_YMD") == '' ) {
                        alert("�Ի����ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // �Ի����� CHECK
                    if (!fnc_CheckDate2(dsT_ME_BHISTORY.NameValue(i, "STR_YMD"), "�Ի���") && dsT_ME_BHISTORY.NameValue(i, "STR_YMD") != "") {
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // ������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_BHISTORY.NameValue(i, "END_YMD"), "�����") && dsT_ME_BHISTORY.NameValue(i, "END_YMD") != "") {
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // �Ի����ڿ� ������� ��
                    if( dsT_ME_BHISTORY.NameValue(i, "STR_YMD") != '' && dsT_ME_BHISTORY.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_BHISTORY.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_ME_BHISTORY.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�Ի����ڰ� ������ں��� Ů�ϴ�.");
                            dsT_ME_BHISTORY.RowPosition = i;
                            document.getElementById("txtSTR_YMD").focus();
                            return false;
                        }
                    }

                    // �׷��
                    if (dsT_ME_BHISTORY.NameValue(i, "GRP_CD") != "" &&
                        dsT_ME_BHISTORY.NameValue(i, "GRP_NM") == "") {
                        alert("�׷���ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtGRP_CD").focus();
                        return;
                    }

                    if ( dsT_ME_BHISTORY.RowStatus(i) == 1) {
                       document.getElementById("txtSTR_YMD").disabled = true;
                       document.getElementById("txtEND_YMD").disabled = false;
                       document.getElementById("ImgStrYmd").disabled  = true;
                       document.getElementById("ImgEndYmd").disabled  = false;
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
            cfStyleGrid(form1.grdT_ME_BHISTORY, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_ME_BHISTORY.IsUpdated)  {
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
                document.getElementById("txtCMP_NAM").disabled = false;
                document.getElementById("txtSTR_YMD").disabled = false;
                document.getElementById("txtEND_YMD").disabled = false;
                document.getElementById("txtGRP_CD").disabled  = false;
                document.getElementById("txtDPT_NAM").disabled = false;
                document.getElementById("txtJOB_CD").disabled  = false;
                form1.medSAL_AMT.enable                        = true;
                document.getElementById("txtCHG_JOB").disabled = false;
                document.getElementById("txtCAR_PCT").disabled = false;
                document.getElementById("txtCAR_YY").disabled  = false;
                document.getElementById("txtCAR_MM").disabled  = false;
                document.getElementById("txtREMARK").disabled  = false;

                document.getElementById("ImgStrYmd").disabled  = false;
                document.getElementById("ImgEndYmd").disabled  = false;
                document.getElementById("ImgGrpCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtCMP_NAM").disabled = true;
                document.getElementById("txtSTR_YMD").disabled = true;
                document.getElementById("txtEND_YMD").disabled = true;
                document.getElementById("txtGRP_CD").disabled  = true;
                document.getElementById("txtDPT_NAM").disabled = true;
                document.getElementById("txtJOB_CD").disabled  = true;
                form1.medSAL_AMT.enable                        = false;
                document.getElementById("txtCHG_JOB").disabled = true;
                document.getElementById("txtCAR_PCT").disabled = true;
                document.getElementById("txtCAR_YY").disabled  = true;
                document.getElementById("txtCAR_MM").disabled  = true;
                document.getElementById("txtREMARK").disabled  = true;

                document.getElementById("ImgStrYmd").disabled  = true;
                document.getElementById("ImgEndYmd").disabled  = true;
                document.getElementById("ImgGrpCd").disabled   = true;

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
    | 2. �̸� : dsT_ME_BHISTORY                     |
    | 3. Table List : T_ME_BHISTORY                 |
    +----------------------------------------------->
    <Object ID="dsT_ME_BHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_BHISTORY                     |
    | 3. Table List : T_ME_BHISTORY                 |
    +----------------------------------------------->
    <Object ID ="trT_ME_BHISTORY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_BHISTORY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_BHISTORY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_BHISTORY.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtEND_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;
            document.getElementById("ImgEndYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_BHISTORY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_BHISTORY Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[�Ի�����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("�Ի����ڿ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_BHISTORY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_BHISTORY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_BHISTORY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_BHISTORY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEND_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEndYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtEND_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;
            document.getElementById("ImgEndYmd").disabled  = true;

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
            <strong>�Ի������</strong>
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
                    <col width="85 "></col>
                    <col width="100"></col>
                    <col width="85 "></col>
                    <col width="105"></col>
                    <col width="102 "></col>
                    <col width="105"></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">ȸ �� ��</td>
                    <td class="padding2423" >
                        <input id="txtCMP_NAM" maxlength="22" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:72%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�Ի���');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','195','55');"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:72%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�����');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','395','55');"></a>
                    </td>
                    <td align="center" class="creamBold">�׷��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtGRP_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('B5', 'txtGRP_CD','txtGRP_NM');"> <input id="txtGRP_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGrpCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGrpCd" name="ImgGrpCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGRP_CD','txtGRP_NM','�׷��','B5')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtDPT_NAM" maxlength="22" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medSAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" >
                        <input id="txtCHG_JOB" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�����������</td>
                    <td class="padding2423" >
                        <input id="txtCAR_PCT" maxlength="3" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="creamBold">����������</td>
                    <td class="padding2423" >
                        <input id="txtCAR_YY" maxlength="2" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="creamBold">�������������</td>
                    <td class="padding2423" >
                        <input id="txtCAR_MM" maxlength="2" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtREMARK" maxlength="60" style="width:100%">
                    </td>
                    <input type=hidden  id="txtENO_NO" size="10">
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
                        <object id="grdT_ME_BHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:153px;">
                            <param name="DataID"                  value="dsT_ME_BHISTORY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'         align=center </C>
                                <C> id=CMP_NAM         width=100  name='ȸ���'                    </C>
                                <C> id=STR_YMD         width=80   name='�Ի���'       align=center </C>
                                <C> id=END_YMD         width=80   name='�����'       align=center </C>
                                <C> id=GRP_CD          width=70   name='�׷��ڵ�'     align=center </C>
                                <C> id=GRP_NM          width=90   name='�׷���'                  </C>
                                <C> id=DPT_NAM         width=90   name='�Ҽ�'                      </C>
                                <C> id=JOB_CD          width=70   name='����'                      </C>
                                <C> id=SAL_AMT         width=90   name='�޿���'                    </C>
                                <C> id=CHG_JOB         width=100  name='������'                  </C>
                                <C> id=CAR_PCT         width=90   name='�����������'              </C>
                                <C> id=CAR_YY          width=90   name='����������'              </C>
                                <C> id=CAR_MM          width=90   name='�����������'              </C>
                                <C> id=REMARK          width=150  name='���'                      </C>
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
<!-- �Ի������ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_BHISTORY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=CMP_NAM       Ctrl=txtCMP_NAM      Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=GRP_CD        Ctrl=txtGRP_CD       Param=value </C>
        <C> Col=GRP_NM        Ctrl=txtGRP_NM       Param=value </C>
        <C> Col=DPT_NAM       Ctrl=txtDPT_NAM      Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=SAL_AMT       Ctrl=medSAL_AMT      Param=text  </C>
        <C> Col=CHG_JOB       Ctrl=txtCHG_JOB      Param=value </C>
        <C> Col=CAR_PCT       Ctrl=txtCAR_PCT      Param=value </C>
        <C> Col=CAR_YY        Ctrl=txtCAR_YY       Param=value </C>
        <C> Col=CAR_MM        Ctrl=txtCAR_MM       Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
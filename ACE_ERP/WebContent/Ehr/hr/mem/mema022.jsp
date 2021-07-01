<!--
    ************************************************************************************
    * @Source         : mema022.jsp                                                    *
    * @Description    : ��ຯ�泻�� PAGE                                              *
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
    <title>��ຯ�泻��</title>
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

            dsT_ME_CONTRACT.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema022.cmd.MEMA022CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_CONTRACT.Reset();

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

                trT_ME_CONTRACT.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema022.cmd.MEMA022CMD&S_MODE=SAV&ENO_NO_SHR="+document.getElementById("ENO_NO").value;
                trT_ME_CONTRACT.post();

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
            if (dsT_ME_CONTRACT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_CONTRACT.RowStatus(dsT_ME_CONTRACT.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_CONTRACT.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�������[" + dsT_ME_CONTRACT.NameValue(dsT_ME_CONTRACT.RowPosition,"CON_YMD") + "] ����[" + dsT_ME_CONTRACT.NameValue(dsT_ME_CONTRACT.RowPosition,"DEGREE_GBN") + "], ��ü��[" + dsT_ME_CONTRACT.NameValue(dsT_ME_CONTRACT.RowPosition,"DISCOMP_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ME_CONTRACT.DeleteRow(dsT_ME_CONTRACT.RowPosition);

            if (status != 1) {
                trT_ME_CONTRACT.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema022.cmd.MEMA022CMD&S_MODE=DEL";
                trT_ME_CONTRACT.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ME_CONTRACT.SetColumn(form1.grdT_ME_CONTRACT.GetColumnID(0));
            form1.grdT_ME_CONTRACT.Focus();

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
            if (dsT_ME_CONTRACT.CountColumn == 0) {
                dsT_ME_CONTRACT.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, CON_YMD:STRING:KEYVALUETYPE, CONS_YMD:STRING, CONS_YMD:STRING, DEGREE_GBN:STRING:KEYVALUETYPE, DISCOMP_CD:STRING:KEYVALUETYPE, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_CONTRACT.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_CONTRACT.setColumn(form1.grdT_ME_CONTRACT.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtCON_YMD").disabled = false;
            document.getElementById("ImgConYmd").disabled  = false;

            document.getElementById("txtCON_YMD").focus();
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

			dsT_ME_CONTRACT.ClearData();
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
            if (!dsT_ME_CONTRACT.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_CONTRACT.CountRow; i++ ) {
                if ( dsT_ME_CONTRACT.RowStatus(i) == 1 ||
                     dsT_ME_CONTRACT.RowStatus(i) == 3 ) {


                    // �������
                    if( dsT_ME_CONTRACT.NameValue(i, "CON_YMD") == '' ) {
                        alert("������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCON_YMD").focus();
                        return false;
                    }

                    // ������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_CONTRACT.NameValue(i, "CON_YMD"), "�������") && dsT_ME_CONTRACT.NameValue(i, "CON_YMD") != "") {
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCON_YMD").focus();
                        return false;
                    }

                    // ����
                    if( dsT_ME_CONTRACT.NameValue(i, "DEGREE_GBN") == '' ) {
                        alert("������ �ʼ� �Է»����Դϴ�.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("cmbDEGREE_GBN").focus();
                        return false;
                    }

                    // ����������
                    if( dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") == '' ) {
                        alert("���������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCONS_YMD").focus();
                        return false;
                    }

                    // ���������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_CONTRACT.NameValue(i, "CONS_YMD"), "����������") && dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") != "") {
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCONS_YMD").focus();
                        return false;
                    }

                    // �����������
                    if( dsT_ME_CONTRACT.NameValue(i, "CONE_YMD") == '' ) {
                        alert("����������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCON_YMD").focus();
                        return false;
                    }

                    // ����������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_CONTRACT.NameValue(i, "CONE_YMD"), "�����������") && dsT_ME_CONTRACT.NameValue(i, "CONE_YMD") != "") {
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCONE_YMD").focus();
                        return false;
                    }

                    // ������ڿ� ���������� ��
                    if( dsT_ME_CONTRACT.NameValue(i, "CON_YMD") != '' && dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_CONTRACT.NameValue(i, "CON_YMD").replace(/\-/g,''),dsT_ME_CONTRACT.NameValue(i, "CONS_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("������ڰ� ���������ں��� Ů�ϴ�.");
                            dsT_ME_CONTRACT.RowPosition = i;
                            document.getElementById("txtCONS_YMD").focus();
                            return false;
                        }
                    }

                    // ���Ⱓ�� �������ڿ� �������� ��
                    if( dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") != '' && dsT_ME_CONTRACT.NameValue(i, "CONE_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_CONTRACT.NameValue(i, "CONS_YMD").replace(/\-/g,''),dsT_ME_CONTRACT.NameValue(i, "CONE_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�������ڰ� �������ں��� Ů�ϴ�.");
                            dsT_ME_CONTRACT.RowPosition = i;
                            document.getElementById("txtCONS_YMD").focus();
                            return false;
                        }
                    }

                    // �İ߾�ü
                    if( dsT_ME_CONTRACT.NameValue(i, "DISCOMP_CD") == '' ) {
                        alert("�İ߾�ü�ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtDISCOMP_CD").focus();
                        return false;
                    }

                    // �İ߾�ü
                    if (dsT_ME_CONTRACT.NameValue(i, "txtDISCOMP_CD") != "" &&
                        dsT_ME_CONTRACT.NameValue(i, "txtDISCOMP_NM") == "") {
                        alert("�İ߾�ü�ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtDISCOMP_CD").focus();
                        return;
                    }

                    if ( dsT_ME_CONTRACT.RowStatus(i) == 1) {
                       document.getElementById("txtCON_YMD").disabled = true;
                       document.getElementById("ImgConYmd").disabled  = true;

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
            cfStyleGrid(form1.grdT_ME_CONTRACT, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_ME_CONTRACT.IsUpdated)  {
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

                document.getElementById("txtCON_YMD").disabled    = false;
                document.getElementById("cmbDEGREE_GBN").disabled = false;
                document.getElementById("txtCONS_YMD").disabled   = false;
                document.getElementById("txtCONE_YMD").disabled   = false;
                document.getElementById("txtDISCOMP_CD").disabled = false;
                document.getElementById("txtREMARK").disabled     = false;

                document.getElementById("ImgConYmd").disabled    = false;
                document.getElementById("ImgConsYmd").disabled   = false;
                document.getElementById("ImgConeYmd").disabled   = false;
                document.getElementById("ImgDisCompCd").disabled = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtCON_YMD").disabled    = true;
                document.getElementById("cmbDEGREE_GBN").disabled = true;
                document.getElementById("txtCONS_YMD").disabled   = true;
                document.getElementById("txtCONE_YMD").disabled   = true;
                document.getElementById("txtDISCOMP_CD").disabled = true;
                document.getElementById("txtREMARK").disabled     = true;

                document.getElementById("ImgConYmd").disabled    = true;
                document.getElementById("ImgConsYmd").disabled   = true;
                document.getElementById("ImgConeYmd").disabled   = true;
                document.getElementById("ImgDisCompCd").disabled = true;

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
    | 2. �̸� : dsT_ME_CONTRACT                    |
    | 3. Table List : T_ME_CONTRACT                |
    +----------------------------------------------->
    <Object ID="dsT_ME_CONTRACT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_CONTRACT                    |
    | 3. Table List : T_ME_CONTRACT                |
    +----------------------------------------------->
    <Object ID ="trT_ME_CONTRACT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_CONTRACT)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_CONTRACT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_CONTRACT.CountRow);

            document.getElementById("txtCON_YMD").disabled = true;
            document.getElementById("ImgConYmd").disabled  = true;

        }


    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_CONTRACT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_CONTRACT Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[�������/����/��ü�ڵ�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("�������/����/��ü�ڵ忡 ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_CONTRACT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_CONTRACT event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_CONTRACT Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_CONTRACT.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtCON_YMD").disabled = false;
            document.getElementById("ImgConYmd").disabled  = false;

        }
        else {
            document.getElementById("txtCON_YMD").disabled = true;
            document.getElementById("ImgConYmd").disabled  = true;

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
            <strong>��ຯ�泻��</strong>
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
                    <col width="150"></col>
                    <col width="80 "></col>
                    <col width="100 "></col>
                    <col width="80 "></col>
                    <col width="* "></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423">
                        <input id="txtCON_YMD" style="width:80%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgConYmd" name="ImgConYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCON_YMD','','55','53');"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <select id="cmbDEGREE_GBN" style="width:100%" >
                            <option value="1" >1��</option>
                            <option value="2" >2��</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">���Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtCONS_YMD" style="width:34%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '����������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConsYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgConsYmd" name="ImgConsYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCONS_YMD','','450','53');"></a> -
                        <input id="txtCONE_YMD" style="width:34%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�����������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConeYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgConeYmd" name="ImgConeYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCONE_YMD','','590','53');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�İ߾�ü</td>
                    <td class="padding2423">
                        <input id="txtDISCOMP_CD" style="width:20%" maxlength="5" onChange="fnc_GetCommNm('CA', 'txtDISCOMP_CD','txtDISCOMP_NM');"> <input id="txtDISCOMP_NM" style="width:55%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisCompCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisCompCd" name="ImgDisCompCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDISCOMP_CD','txtDISCOMP_NM','�İ߾�ü','CA')"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtREMARK" maxlength="60" style="width:100%">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
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
                        <object id="grdT_ME_CONTRACT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:178px;">
                            <param name="DataID"                  value="dsT_ME_CONTRACT">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'         align=center </C>
                                <C> id=CON_YMD         width=100  name='�������'     align=center </C>
                                <C> id=DEGREE_GBN      width=100  name='����'         align=center </C>
                                <C> id=CONS_YMD        width=100  name='��������'   align=center </C>
                                <C> id=CONE_YMD        width=100  name='��ุ����'   align=center </C>
                                <C> id=DISCOMP_CD      width=100  name='��ü�ڵ�'     align=center </C>
                                <C> id=DISCOMP_NM      width=100  name='��ü��'                    </C>
                                <C> id=REMARK          width=130  name='���'                      </C>
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
<!-- ��ຯ�泻�� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_CONTRACT">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=CON_YMD       Ctrl=txtCON_YMD      Param=value </C>
        <C> Col=DEGREE_GBN    Ctrl=cmbDEGREE_GBN   Param=value </C>
        <C> Col=CONS_YMD      Ctrl=txtCONS_YMD     Param=value </C>
        <C> Col=CONE_YMD      Ctrl=txtCONE_YMD     Param=value </C>
        <C> Col=DISCOMP_CD    Ctrl=txtDISCOMP_CD   Param=value </C>
        <C> Col=DISCOMP_NM    Ctrl=txtDISCOMP_NM   Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
<!--
    ************************************************************************************
    * @Source         : mema015.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/30  |  ������   | �����ۼ�                                               *
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

            dsT_ME_ARMY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema015.cmd.MEMA015CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_ARMY.Reset();

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

                trT_ME_ARMY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema015.cmd.MEMA015CMD&S_MODE=SAV";
                trT_ME_ARMY.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ME_ARMY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("��������[" + dsT_ME_ARMY.NameValue(dsT_ME_ARMY.RowPosition,"GUB_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ME_ARMY.DeleteRow(dsT_ME_ARMY.RowPosition);

            trT_ME_ARMY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema015.cmd.MEMA015CMD&S_MODE=DEL";
            trT_ME_ARMY.post();

            fnc_SearchList();

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
            //if (dsT_ME_ARMY.CountColumn == 0) {
            //    dsT_ME_ARMY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, GUB_CD:STRING, GUB_NM:STRING, MIC_CD:STRING, MIC_NM:STRING, LOC_CD:STRING, LOC_NM:STRING, MIL_CD:STRING, MIL_NM:STRING, ENL_YMD:STRING, MIL_YMD:STRING, YSE_CD:STRING, YSE_NM:STRING, GRADE:STRING, GRADE_NM:STRING, MIL_NO:STRING, MBK_CD:STRING, MBK_NM:STRING, MIL_DES:STRING, REMARK:STRING");
            //}
            //
            //if (dsT_ME_ARMY.CountRow > 0) {
            //    return;
            //}
            //
            //// AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            //dsT_ME_ARMY.AddRow();
            //
            //fnc_ColEnabled('E');
            //
            //document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            //
            //document.getElementById("txtGUB_CD").focus();

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

			dsT_ME_ARMY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

            //document.getElementById("txtGUB_CD").value    = '';
            //document.getElementById("txtGUB_NM").value    = '';
            //document.getElementById("txtMIC_CD").value    = '';
            //document.getElementById("txtMIC_NM").value    = '';
            //document.getElementById("txtLOC_CD").value    = '';
            //document.getElementById("txtLOC_NM").value    = '';
            //document.getElementById("txtMIL_CD").value    = '';
            //document.getElementById("txtMIL_NM").value    = '';
            //document.getElementById("txtENL_YMD").value   = '';
            //document.getElementById("txtMIL_YMD").value   = '';
            //document.getElementById("txtYSE_CD").value    = '';
            //document.getElementById("txtYSE_NM").value    = '';
            //document.getElementById("txtGRADE").value     = '';
            //document.getElementById("txtGRADE_NM").value  = '';
            //document.getElementById("txtMIL_NO").value    = '';
            //document.getElementById("txtMBK_CD").value    = '';
            //document.getElementById("txtMBK_NM").value    = '';
            //document.getElementById("txtMIL_DES").value   = '';
            //document.getElementById("txtREMARK").value    = '';

            //document.getElementById("txtGUB_CD").focus();

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
            if (!dsT_ME_ARMY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_ARMY.CountRow; i++ ) {
                if ( dsT_ME_ARMY.RowStatus(i) == 1 ||
                     dsT_ME_ARMY.RowStatus(i) == 3 ) {

                    // ��������
                    if( dsT_ME_ARMY.NameValue(i, "GUB_CD") == '' ) {
                        alert("���������� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGUB_CD").focus();
                        return false;
                    }

                    // �����Ⱓ�� �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_ARMY.NameValue(i, "ENL_YMD"), "������������") && dsT_ME_ARMY.NameValue(i, "ENL_YMD") != "") {
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtENL_YMD").focus();
                        return false;
                    }

                    // �����Ⱓ�� �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_ARMY.NameValue(i, "MIL_YMD"), "������������") && dsT_ME_ARMY.NameValue(i, "MIL_YMD") != "") {
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMIL_YMD").focus();
                        return false;
                    }

                    // �����Ⱓ�� �������ڿ� �������� ��
                    if( dsT_ME_ARMY.NameValue(i, "ENL_YMD") != '' && dsT_ME_ARMY.NameValue(i, "MIL_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_ARMY.NameValue(i, "ENL_YMD").replace(/\-/g,''),dsT_ME_ARMY.NameValue(i, "MIL_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�������ڰ� �������ں��� Ů�ϴ�.");
                            dsT_ME_ARMY.RowPosition = i;
                            document.getElementById("txtENL_YMD").focus();
                            return false;
                        }
                    }

                    // ��������
                    if (dsT_ME_ARMY.NameValue(i, "GUB_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "GUB_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGUB_CD").focus();
                        return;
                    }

                    // ����
                    if (dsT_ME_ARMY.NameValue(i, "MIC_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "MIC_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMIC_CD").focus();
                        return;
                    }

                    // ����û
                    if (dsT_ME_ARMY.NameValue(i, "LOC_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "LOC_NM") == "") {
                        alert("����û�ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtLOC_CD").focus();
                        return;
                    }

                    // ����
                    if (dsT_ME_ARMY.NameValue(i, "MIL_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "MIL_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMIL_CD").focus();
                        return;
                    }

                    // ��������
                    if (dsT_ME_ARMY.NameValue(i, "YSE_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "YSE_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtYSE_CD").focus();
                        return;
                    }

                    // ���
                    if (dsT_ME_ARMY.NameValue(i, "GRADE") != "" &&
                        dsT_ME_ARMY.NameValue(i, "GRADE_NM") == "") {
                        alert("����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGRADE").focus();
                        return;
                    }

                    // ����
                    if (dsT_ME_ARMY.NameValue(i, "MBK_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "MBK_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMBK_CD").focus();
                        return;
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

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_ME_PERSON.IsUpdated)  {
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
                document.getElementById("txtGUB_CD").disabled   = false;
                document.getElementById("txtMIC_CD").disabled   = false;
                document.getElementById("txtLOC_CD").disabled   = false;
                document.getElementById("txtMIL_CD").disabled   = false;
                document.getElementById("txtENL_YMD").disabled  = false;
                document.getElementById("txtMIL_YMD").disabled  = false;
                document.getElementById("txtYSE_CD").disabled   = false;
                document.getElementById("txtGRADE").disabled    = false;
                document.getElementById("txtMIL_NO").disabled   = false;
                document.getElementById("txtMBK_CD").disabled   = false;
                document.getElementById("txtMIL_DES").disabled  = false;
                document.getElementById("txtREMARK").disabled   = false;

                document.getElementById("ImgGubCd").disabled    = false;
                document.getElementById("ImgMicCd").disabled    = false;
                document.getElementById("ImgLocCd").disabled    = false;
                document.getElementById("ImgMilCd").disabled    = false;
                document.getElementById("ImgEnlYmd").disabled   = false;
                document.getElementById("ImgMilYmd").disabled   = false;
                document.getElementById("ImgYseCd").disabled    = false;
                document.getElementById("ImgGrade").disabled    = false;
                document.getElementById("ImgMbkCd").disabled    = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtGUB_CD").disabled   = true;
                document.getElementById("txtMIC_CD").disabled   = true;
                document.getElementById("txtLOC_CD").disabled   = true;
                document.getElementById("txtMIL_CD").disabled   = true;
                document.getElementById("txtENL_YMD").disabled  = true;
                document.getElementById("txtMIL_YMD").disabled  = true;
                document.getElementById("txtYSE_CD").disabled   = true;
                document.getElementById("txtGRADE").disabled    = true;
                document.getElementById("txtMIL_NO").disabled   = true;
                document.getElementById("txtMBK_CD").disabled   = true;
                document.getElementById("txtMIL_DES").disabled  = true;
                document.getElementById("txtREMARK").disabled   = true;

                document.getElementById("ImgGubCd").disabled    = true;
                document.getElementById("ImgMicCd").disabled    = true;
                document.getElementById("ImgLocCd").disabled    = true;
                document.getElementById("ImgMilCd").disabled    = true;
                document.getElementById("ImgEnlYmd").disabled   = true;
                document.getElementById("ImgMilYmd").disabled   = true;
                document.getElementById("ImgYseCd").disabled    = true;
                document.getElementById("ImgGrade").disabled    = true;
                document.getElementById("ImgMbkCd").disabled    = true;

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
    | 2. �̸� : dsT_ME_ARMY                         |
    | 3. Table List : T_ME_ARMY                     |
    +----------------------------------------------->
    <Object ID="dsT_ME_ARMY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_ARMY                         |
    | 3. Table List : T_ME_ARMY                     |
    +----------------------------------------------->
    <Object ID ="trT_ME_ARMY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_ARMY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_ARMY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            if (dsT_ME_ARMY.CountColumn == 0) {
                dsT_ME_ARMY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, GUB_CD:STRING, GUB_NM:STRING, MIC_CD:STRING, MIC_NM:STRING, LOC_CD:STRING, LOC_NM:STRING, MIL_CD:STRING, MIL_NM:STRING, ENL_YMD:STRING, MIL_YMD:STRING, YSE_CD:STRING, YSE_NM:STRING, GRADE:STRING, GRADE_NM:STRING, MIL_NO:STRING, MBK_CD:STRING, MBK_NM:STRING, MIL_DES:STRING, REMARK:STRING");
            }

            if (dsT_ME_ARMY.CountRow > 0) {
                return;
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_ARMY.AddRow();

            fnc_ColEnabled('E');

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            document.getElementById("txtGUB_CD").focus();

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_ARMY.CountRow);

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_ARMY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_ARMY Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_ARMY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_ARMY event="OnFail()">

        cfErrorMsg(this);

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
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">  <img src="/images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                    <col width="60 "></col>
                    <col width="200"></col>
                    <col width="60 "></col>
                    <col width="220"></col>
                    <col width="60 "></col>
                    <col width="200"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <input id="txtGUB_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F1', 'txtGUB_CD','txtGUB_NM');"> <input id="txtGUB_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGubCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGubCd" name="ImgGubCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGUB_CD','txtGUB_NM','��������','F1')"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtMIC_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F2', 'txtMIC_CD','txtMIC_NM');"> <input id="txtMIC_NM" style="width:68%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMicCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMicCd" name="ImgMicCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMIC_CD','txtMIC_NM','����','F2')"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� û</td>
                    <td class="padding2423">
                        <input id="txtLOC_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F3', 'txtLOC_CD','txtLOC_NM');"> <input id="txtLOC_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgLocCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgLocCd" name="ImgLocCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtLOC_CD','txtLOC_NM','����û','F3')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtMIL_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F4', 'txtMIL_CD','txtMIL_NM');"> <input id="txtMIL_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMilCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMilCd" name="ImgMilCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMIL_CD','txtMIL_NM','����','F4')"></a>
                    </td>
                    <td align="center" class="creamBold">�����Ⱓ</td>
                    <td class="padding2423" >
                        <input id="txtENL_YMD" style="width:32%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnlYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnlYmd" name="ImgEnlYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtENL_YMD','','420','0');"></a> -
                        <input id="txtMIL_YMD" style="width:32%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMilYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMilYmd" name="ImgMilYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtMIL_YMD','','535','0');"></a>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <input id="txtYSE_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F5', 'txtYSE_CD','txtYSE_NM');"> <input id="txtYSE_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgYseCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgYseCd" name="ImgYseCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtYSE_CD','txtYSE_NM','��������','F5')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtGRADE" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F6', 'txtGRADE','txtGRADE_NM');"> <input id="txtGRADE_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGrade','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGrade" name="ImgGrade" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGRADE','txtGRADE_NM','���','F6')"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtMIL_NO" maxlength="10" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtMBK_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F7', 'txtMBK_CD','txtMBK_NM');"> <input id="txtMBK_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMbkCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMbkCd" name="ImgMbkCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMBK_CD','txtMBK_NM','����','F7')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtMIL_DES" maxlength="60" style="width:100%">
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
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

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
    <Param Name="DataID",   Value="dsT_ME_ARMY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=GUB_CD        Ctrl=txtGUB_CD       Param=value </C>
        <C> Col=GUB_NM        Ctrl=txtGUB_NM       Param=value </C>
        <C> Col=MIC_CD        Ctrl=txtMIC_CD       Param=value </C>
        <C> Col=MIC_NM        Ctrl=txtMIC_NM       Param=value </C>
        <C> Col=LOC_CD        Ctrl=txtLOC_CD       Param=value </C>
        <C> Col=LOC_NM        Ctrl=txtLOC_NM       Param=value </C>
        <C> Col=MIL_CD        Ctrl=txtMIL_CD       Param=value </C>
        <C> Col=MIL_NM        Ctrl=txtMIL_NM       Param=value </C>
        <C> Col=ENL_YMD       Ctrl=txtENL_YMD      Param=value </C>
        <C> Col=MIL_YMD       Ctrl=txtMIL_YMD      Param=value </C>
        <C> Col=YSE_CD        Ctrl=txtYSE_CD       Param=value </C>
        <C> Col=YSE_NM        Ctrl=txtYSE_NM       Param=value </C>
        <C> Col=GRADE         Ctrl=txtGRADE        Param=value </C>
        <C> Col=GRADE_NM      Ctrl=txtGRADE_NM     Param=value </C>
        <C> Col=MIL_NO        Ctrl=txtMIL_NO       Param=value </C>
        <C> Col=MBK_CD        Ctrl=txtMBK_CD       Param=value </C>
        <C> Col=MBK_NM        Ctrl=txtMBK_NM       Param=value </C>
        <C> Col=MIL_DES       Ctrl=txtMIL_DES      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
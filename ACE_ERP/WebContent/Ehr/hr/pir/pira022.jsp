<!--
    ************************************************************************************
    * @Source         : pira022.jsp                                                    *
    * @Description    : VISA PAGE                                                      *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/20  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>VISA</title>
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
        
            var radio = document.form1.rdoTMEN_TAG_SHR;
            var TMEN_TAG_SHR = "";
            
            for(i=0;i<radio.length;i++){
                if(radio[i].checked){
                     TMEN_TAG_SHR = radio[i].value;
                }
            }

            dsT_CM_VISA.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira022.cmd.PIRA022CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value+"&TMEN_TAG_SHR="+TMEN_TAG_SHR;
            dsT_CM_VISA.Reset();

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

                trT_CM_VISA.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira022.cmd.PIRA022CMD&S_MODE=SAV";
                trT_CM_VISA.post();

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
            if (dsT_CM_VISA.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_VISA.RowStatus(dsT_CM_VISA.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_VISA.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�߱ޱ���[" + dsT_CM_VISA.NameValue(dsT_CM_VISA.RowPosition,"NAT_NM") + "] �߱���[" + dsT_CM_VISA.NameValue(dsT_CM_VISA.RowPosition,"ISS_YMD") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_VISA.DeleteRow(dsT_CM_VISA.RowPosition);

            if (status != 1) {
                trT_CM_VISA.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira022.cmd.PIRA022CMD&S_MODE=DEL";
                trT_CM_VISA.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_VISA.SetColumn(form1.grdT_CM_VISA.GetColumnID(0));
            form1.grdT_CM_VISA.Focus();

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
            if (dsT_CM_VISA.CountColumn == 0) {
                dsT_CM_VISA.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, NAT_CD:STRING:KEYVALUETYPE, NAT_NM:STRING:KEYVALUETYPE, VISA_NO:STRING, ISS_YMD:STRING, DUE_YMD:STRING, TYPE_CD:STRING, TYPE_NM:STRING, TMEN_TAG:STRING, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_VISA.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_VISA.setColumn(form1.grdT_CM_VISA.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtNAT_CD").disabled  = false;
            document.getElementById("txtISS_YMD").disabled = false;
            document.getElementById("ImgNatCd").disabled   = false;
            document.getElementById("ImgIssYmd").disabled  = false;

            document.getElementById("txtNAT_CD").focus();
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

			dsT_CM_VISA.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.txtGET_RSN.focus();

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
            if (!dsT_CM_VISA.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_VISA.CountRow; i++ ) {
                if ( dsT_CM_VISA.RowStatus(i) == 1 ||
                     dsT_CM_VISA.RowStatus(i) == 3 ) {


                    // �����ڵ�
                    if( dsT_CM_VISA.NameValue(i, "NAT_CD") == '' ) {
                        alert("�����ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtNAT_CD").focus();
                        return false;
                    }

                    // �����ڵ�
                    if (dsT_CM_VISA.NameValue(i, "NAT_CD") != "" &&
                        dsT_CM_VISA.NameValue(i, "NAT_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtNAT_CD").focus();
                        return;
                    }

                    // ��������
                    if (dsT_CM_VISA.NameValue(i, "TYPE_CD") != "" &&
                        dsT_CM_VISA.NameValue(i, "TYPE_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtTYPE_CD").focus();
                        return;
                    }

                    // �߱���
                    if( dsT_CM_VISA.NameValue(i, "ISS_YMD") == '' ) {
                        alert("�߱����� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtISS_YMD").focus();
                        return false;
                    }

                    // �߱��� CHECK
                    if (!fnc_CheckDate2(dsT_CM_VISA.NameValue(i, "ISS_YMD"), "�߱���") && dsT_CM_VISA.NameValue(i, "ISS_YMD") != "") {
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtISS_YMD").focus();
                        return false;
                    }

                    // ������ CHECK
                    if (!fnc_CheckDate2(dsT_CM_VISA.NameValue(i, "DUE_YMD"), "������") && dsT_CM_VISA.NameValue(i, "DUE_YMD") != "") {
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtDUE_YMD").focus();
                        return false;
                    }

                    // �߱����ڿ� �������� ��
                    if( dsT_CM_VISA.NameValue(i, "ISS_YMD") != '' && dsT_CM_VISA.NameValue(i, "DUE_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_VISA.NameValue(i, "ISS_YMD").replace(/\-/g,''),dsT_CM_VISA.NameValue(i, "DUE_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�������ڰ� �߱����ں��� �۽��ϴ�.");
                            dsT_CM_VISA.RowPosition = i;
                            document.getElementById("txtDUE_YMD").focus();
                            return false;
                        }
                    }

                    if ( dsT_CM_VISA.RowStatus(i) == 1) {
                       document.getElementById("txtNAT_CD").disabled  = true;
                       document.getElementById("txtISS_YMD").disabled = true;
                       document.getElementById("ImgNatCd").disabled   = true;
                       document.getElementById("ImgIssYmd").disabled  = true;
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
            cfStyleGrid(form1.grdT_CM_VISA, 0,"false","false");

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
                document.getElementById("txtNAT_CD").disabled   = false;
                document.getElementById("txtVISA_NO").disabled  = false;
                document.getElementById("txtISS_YMD").disabled  = false;
                document.getElementById("txtDUE_YMD").disabled  = false;
                document.getElementById("txtTYPE_CD").disabled  = false;
                document.getElementById("txtREMARK").disabled   = false;

                document.getElementById("ImgNatCd").disabled   = false;
                document.getElementById("ImgIssYmd").disabled  = false;
                document.getElementById("ImgDueYmd").disabled  = false;
                document.getElementById("ImgTypeCd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtNAT_CD").disabled   = true;
                document.getElementById("txtVISA_NO").disabled  = true;
                document.getElementById("txtISS_YMD").disabled  = true;
                document.getElementById("txtDUE_YMD").disabled  = true;
                document.getElementById("txtTYPE_CD").disabled  = true;
                document.getElementById("txtREMARK").disabled   = true;

                document.getElementById("ImgNatCd").disabled   = true;
                document.getElementById("ImgIssYmd").disabled  = true;
                document.getElementById("ImgDueYmd").disabled  = true;
                document.getElementById("ImgTypeCd").disabled  = true;

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
    | 2. �̸� : dsT_CM_VISA                         |
    | 3. Table List : T_CM_VISA                     |
    +----------------------------------------------->
    <Object ID="dsT_CM_VISA" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_VISA                         |
    | 3. Table List : T_CM_VISA                     |
    +----------------------------------------------->
    <Object ID ="trT_CM_VISA" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_VISA)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_VISA Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_VISA.CountRow);

            document.getElementById("txtNAT_CD").disabled  = true;
            document.getElementById("txtISS_YMD").disabled = true;
            document.getElementById("ImgNatCd").disabled   = true;
            document.getElementById("ImgIssYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_VISA Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_VISA Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[�����ڵ�/�߱���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("�����ڵ�/�߱��Ͽ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_VISA event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_VISA event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_VISA Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_VISA.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtNAT_CD").disabled  = false;
            document.getElementById("txtISS_YMD").disabled = false;
            document.getElementById("ImgNatCd").disabled   = false;
            document.getElementById("ImgIssYmd").disabled  = false;

        }
        else {
            document.getElementById("txtNAT_CD").disabled  = true;
            document.getElementById("txtISS_YMD").disabled = true;
            document.getElementById("ImgNatCd").disabled   = true;
            document.getElementById("ImgIssYmd").disabled  = true;

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
            <strong>VISA</strong>
        </td>
        <td align="right">
	        <input type="radio" id="rdoTMEN_TAG_SHR" name="rdoTMEN_TAG_SHR" style="border:none" value=""  onClick="fnc_SearchList()" checked>��ü
	        <input type="radio" id="rdoTMEN_TAG_SHR" name="rdoTMEN_TAG_SHR" style="border:none" value="Y" onClick="fnc_SearchList()">���
	        <input type="radio" id="rdoTMEN_TAG_SHR" name="rdoTMEN_TAG_SHR" style="border:none" value="N" onClick="fnc_SearchList()">�̰��
        </td>
        <td width="340" height="25" align="right">
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
                    <col width="70 "></col>
                    <col width="140"></col>
                    <col width="70 "></col>
                    <col width="140"></col>
                    <col width="70 "></col>
                    <col width="120"></col>
                    <col width="70 "></col>
                    <col width="120"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtNAT_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('L2', 'txtNAT_CD','txtNAT_NM');"> <input id="txtNAT_NM" style="width:57%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNatCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgNatCd" name="ImgNatCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtNAT_CD','txtNAT_NM','����','L2')"></a>
                    </td>
                    <td align="center" class="creamBold">���ڹ�ȣ</td>
                    <td class="padding2423" >
                        <input id="txtVISA_NO" maxlength="15" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtISS_YMD" style="width:73%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�߱���');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgIssYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgIssYmd" name="ImgIssYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtISS_YMD','','410','55');"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtDUE_YMD" style="width:73%;ime-mode:disabled" maxlength="10" onChange="JavaScript : fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDueYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDueYmd" name="ImgDueYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDUE_YMD','','610','55');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <input id="txtTYPE_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('L5', 'txtTYPE_CD','txtTYPE_NM');"> <input id="txtTYPE_NM" style="width:57%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTypeCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTypeCd" name="ImgTypeCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtTYPE_CD','txtTYPE_NM','��������','L5')"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="5">
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
                        <object id="grdT_CM_VISA" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:190px;">
                            <param name="DataID"                  value="dsT_CM_VISA">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'         align=center </C>
                                <C> id=NAT_CD          width=75   name='�����ڵ�'     align=center </C>
                                <C> id=NAT_NM          width=75   name='�߱ޱ���'                  </C>
                                <C> id=VISA_NO         width=75   name='���ڹ�ȣ'                  </C>
                                <C> id=ISS_YMD         width=75   name='�߱���'       align=center </C>
                                <C> id=DUE_YMD         width=75   name='������'       align=center </C>
                                <C> id=TYPE_CD         width=80   name='���������ڵ�' align=center </C>
                                <C> id=TYPE_NM         width=75   name='��������'                  </C>
                                <C> id=TMEN_TAG        width=60   name='���Ѱ��'     align=center </C>
                                <C> id=REMARK          width=143  name='���'                      </C>
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
<!-- VISA ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_VISA">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=NAT_CD        Ctrl=txtNAT_CD       Param=value </C>
        <C> Col=NAT_NM        Ctrl=txtNAT_NM       Param=value </C>
        <C> Col=VISA_NO       Ctrl=txtVISA_NO      Param=value </C>
        <C> Col=ISS_YMD       Ctrl=txtISS_YMD      Param=value </C>
        <C> Col=DUE_YMD       Ctrl=txtDUE_YMD      Param=value </C>
        <C> Col=TYPE_CD       Ctrl=txtTYPE_CD      Param=value </C>
        <C> Col=TYPE_NM       Ctrl=txtTYPE_NM      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
<!--
    ************************************************************************************
    * @Source         : mema020.jsp                                                    *
    * @Description    : �뿪�񺯰泻�� PAGE                                            *
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
    <title>�뿪�񺯰泻��</title>
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

        var chn_ymd = '';
        var seq_no  = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ME_APY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema020.cmd.MEMA020CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_APY.Reset();

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

                trT_ME_APY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema020.cmd.MEMA020CMD&S_MODE=SAV";
                trT_ME_APY.post();

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
            if (dsT_ME_APY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_APY.RowStatus(dsT_ME_APY.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_APY.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("��������[" + dsT_ME_APY.NameValue(dsT_ME_APY.RowPosition,"CHN_YMD") + "] [" + dsT_ME_APY.NameValue(dsT_ME_APY.RowPosition,"SEQ_NO") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ME_APY.DeleteRow(dsT_ME_APY.RowPosition);

            if (status != 1) {
                trT_ME_APY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema020.cmd.MEMA020CMD&S_MODE=DEL";
                trT_ME_APY.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ME_APY.SetColumn(form1.grdT_ME_APY.GetColumnID(0));
            form1.grdT_ME_APY.Focus();

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
            if (dsT_ME_APY.CountColumn == 0) {
                dsT_ME_APY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, CHN_YMD:STRING:KEYVALUETYPE, SEQ_NO:INT:KEYVALUETYPE, OCC_CD:STRING, APP_CD:STRING, JOB_CD:STRING, JOB_NM:STRING, HOB_CD:STRING, HOB_NM:STRING, BAS_AMT:INT, WEL_AMT:INT, LSEV_AMT1:INT, LSEV_AMT2:INT, LSEV_AMT3:INT, SUM_AMT:INT, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_APY.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_APY.setColumn(form1.grdT_ME_APY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtCHN_YMD").disabled = false;
            document.getElementById("ImgChnYmd").disabled  = false;

            document.getElementById("txtCHN_YMD").focus();
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

			dsT_ME_APY.ClearData();
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
            if (!dsT_ME_APY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_APY.CountRow; i++ ) {
                if ( dsT_ME_APY.RowStatus(i) == 1 ||
                     dsT_ME_APY.RowStatus(i) == 3 ) {

                    // ��������
                    if( dsT_ME_APY.NameValue(i, "CHN_YMD") == '' ) {
                        alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_APY.RowPosition = i;
                        document.getElementById("txtCHN_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_APY.NameValue(i, "CHN_YMD"), "��������") && dsT_ME_APY.NameValue(i, "CHN_YMD") != "") {
                        dsT_ME_APY.RowPosition = i;
                        document.getElementById("txtCHN_YMD").focus();
                        return false;
                    }

                    // �İߴܰ�
                    if( dsT_ME_APY.NameValue(i, "BAS_AMT") == '' ) {
                        alert("�İߴܰ��� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_APY.RowPosition = i;
                        form1.medBAS_AMT.focus();
                        return false;
                    }

                    if ( dsT_ME_APY.RowStatus(i) == 1) {
                        document.getElementById("txtCHN_YMD").disabled = true;
                        document.getElementById("ImgChnYmd").disabled  = true;
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
            cfStyleGrid(form1.grdT_ME_APY, 0,"false","false");

            fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_ME_APY.IsUpdated)  {
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

                document.getElementById("txtCHN_YMD").disabled = false;
                form1.medBAS_AMT.enable                        = true;
                form1.medWEL_AMT.enable                        = true;
                form1.medLSEV_AMT1.enable                      = true;
                form1.medLSEV_AMT2.enable                      = true;
                form1.medLSEV_AMT3.enable                      = true;
                form1.medSUM_AMT.enable                        = false;
                document.getElementById("txtREMARK").disabled  = false;

                document.getElementById("ImgChnYmd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtCHN_YMD").disabled = true;
                form1.medBAS_AMT.enable                        = false;
                form1.medWEL_AMT.enable                        = false;
                form1.medLSEV_AMT1.enable                      = false;
                form1.medLSEV_AMT2.enable                      = false;
                form1.medLSEV_AMT3.enable                      = false;
                form1.medSUM_AMT.enable                        = false;
                document.getElementById("txtREMARK").disabled  = true;

                document.getElementById("ImgChnYmd").disabled  = true;

            }
        }


        function fnc_getSeqNo(obj) {
            var SysStatus = dsT_ME_APY.SysStatus(dsT_ME_APY.RowPosition);
            var SeqNo = 0;

            if (SysStatus == 1) {

                document.getElementById("txtSEQ_NO").value = '';

                if (obj.value != '') {

                    for (var i = 1; i <= dsT_ME_APY.CountRow; i++) {

                        if (dsT_ME_APY.NameValue(i, "CHN_YMD") == obj.value &&
                            dsT_ME_APY.NameValue(i, "SEQ_NO") >= SeqNo      &&
                            i != dsT_ME_APY.RowPosition) {

                           SeqNo = new Number(dsT_ME_APY.NameValue(i, "SEQ_NO")) + 1;

                        }
                    }

                    if (SeqNo == 0) {
                        SeqNo = 1;
                    }

                    document.getElementById("txtSEQ_NO").value = SeqNo;
                }
            }

            chn_ymd = document.getElementById("txtCHN_YMD").value;
            seq_no  = document.getElementById("txtSEQ_NO").value;

        }

        function fnc_BlurYmd() {
            if (chn_ymd == document.getElementById("txtCHN_YMD").value &&
                seq_no  == document.getElementById("txtSEQ_NO").value) {
                return;
            }

            fnc_getSeqNo(document.getElementById("txtCHN_YMD"));

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
    | 2. �̸� : dsT_ME_APY                          |
    | 3. Table List : T_ME_APY                      |
    +----------------------------------------------->
    <Object ID="dsT_ME_APY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_APY                          |
    | 3. Table List : T_ME_APY                      |
    +----------------------------------------------->
    <Object ID ="trT_ME_APY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_APY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �ش� ���� ����� �� �հ� ���� ����               |
    +-------------------------------------------------->
    <script language=JavaScript for= medBAS_AMT event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medLSEV_AMT1 event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medLSEV_AMT2 event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medLSEV_AMT3 event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <script language=JavaScript for= medWEL_AMT event="OnKillFocus()">

//        if (medBAS_AMT.Modified) {
//            form1.medSUM_AMT.Text = new Number(form1.medBAS_AMT.Text) + new Number(form1.medWEL_AMT.Text) +
//                                    new Number(form1.medLSEV_AMT1.Text) + new Number(form1.medLSEV_AMT2.Text) + new Number(form1.medLSEV_AMT3.Text);
//        }
//        return true;

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_APY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_APY.CountRow);

            document.getElementById("txtCHN_YMD").disabled = true;
            document.getElementById("ImgChnYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_APY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_APY Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[��������/SEQ��ȣ] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("��������/SEQ��ȣ�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_APY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_APY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_APY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_APY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtCHN_YMD").disabled = false;
            document.getElementById("ImgChnYmd").disabled  = false;

        }
        else {
            document.getElementById("txtCHN_YMD").disabled = true;
            document.getElementById("ImgChnYmd").disabled  = true;

        }

    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

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
            <strong>�뿪�񺯰泻��</strong>
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
                    <col width="95 "></col>
                    <col width="100"></col>
                    <col width="85"></col>
                    <col width="100"></col>
                    <col width="95 "></col>
                    <col width="100"></col>
                    <col width="95 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtCHN_YMD" style="width:68%;ime-mode:disabled" maxlength="10" onBlur="fnc_BlurYmd();" onChange="javascript : if (fnc_CheckDate(this, '��������')) {fnc_getSeqNo(this);}" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgChnYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgChnYmd" name="ImgChnYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCHN_YMD','','350','55');"></a>
                    </td>
                    <td align="center" class="creamBold">�İߴܰ�</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBAS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                    <td align="center" class="creamBold">�ټ������(6)</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLSEV_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                    <td align="center" class="creamBold">�ټ������(12)</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLSEV_AMT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                    <td align="center" class="creamBold">�ټ������(18)</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLSEV_AMT3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                    <td align="center" class="creamBold">��Ÿ����</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medWEL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                    <td align="center" class="creamBold">�뿪�� ��</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREMARK" maxlength="20" style="width:100%">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtSEQ_NO" size="1">
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
                        <object id="grdT_ME_APY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:178px;">
                            <param name="DataID"                  value="dsT_ME_APY">
                            <param name="Format"                  value="
                                <C> id={currow}       width=39    name='����'         align=center </C>
                                <C> id=CHN_YMD        width=90    name='����'         align=center </C>
                                <C> id=BAS_AMT        width=90    name='�İߴܰ�'                  </C>
                                <C> id=LSEV_AMT1      width=90    name='�ټ������(6)'             </C>
                                <C> id=LSEV_AMT2      width=90    name='�ټ������(12)'            </C>
                                <C> id=LSEV_AMT3      width=90    name='�ټ������(18)'            </C>
                                <C> id=WEL_AMT        width=90    name='��Ÿ����'                  </C>
                                <C> id=SUM_AMT        width=90    name='�뿪�� ��'                 </C>
                                <C> id=REMARK         width=104   name='���'                      </C>
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
<!-- �뿪�񺯰泻�� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_APY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=CHN_YMD       Ctrl=txtCHN_YMD      Param=value Disable=disabled</C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value Disable=disabled</C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=APP_CD        Ctrl=txtAPP_CD       Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=HOB_CD        Ctrl=txtHOB_CD       Param=value </C>
        <C> Col=BAS_AMT       Ctrl=medBAS_AMT      Param=text  </C>
        <C> Col=WEL_AMT       Ctrl=medWEL_AMT      Param=text  </C>
        <C> Col=LSEV_AMT1     Ctrl=medLSEV_AMT1    Param=text  </C>
        <C> Col=LSEV_AMT2     Ctrl=medLSEV_AMT2    Param=text  </C>
        <C> Col=LSEV_AMT3     Ctrl=medLSEV_AMT3    Param=text  </C>
        <C> Col=SUM_AMT       Ctrl=medSUM_AMT      Param=text  </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
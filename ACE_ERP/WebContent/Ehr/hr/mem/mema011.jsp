<!--
    ************************************************************************************
    * @Source         : mema011.jsp                                                    *
    * @Description    : �λ�⺻2 PAGE                                                 *
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
    <title>�λ�⺻2</title>
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

            if (form1.ENO_NO.value == "" || (parent.dsT_ME_PERSON.CountRow < 1 && parent.dsT_ME_PERSON.RowStatus(1) != 1)) {

                dsT_ME_PERSON.ClearData();
                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            dsT_ME_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema011.cmd.MEMA011CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_PERSON.Reset();

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

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_ME_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_ME_PERSON.KeyValue = "SVL(I:SAV=dsT_ME_PERSON)";
                trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema011.cmd.MEMA011CMD&S_MODE=SAV";
                trT_ME_PERSON.post();

            } else {

                return false;

            }

            return true;

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_PERSON.ClearData();
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

            // ä�뱸��
            if (document.getElementById("txtHIR_CD").value != "" &&
                document.getElementById("txtHIR_NM").value == "") {
                alert("ä�뱸���ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtHIR_CD").focus();
                return false;
            }

            // ��õ��
            if (document.getElementById("txtOK_ENO").value != "" &&
                document.getElementById("txtOK_MAN").value == "") {
                alert("��õ�λ���� �Է��Ͻ� ���� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtOK_ENO").focus();
                return false;
            }

            // �İߴ�����
            if (document.getElementById("txtDISJOB_CD").value != "" &&
                document.getElementById("txtDISJOB_NM").value == "") {
                alert("�İߴ������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtDISJOB_CD").focus();
                return false;
            }

            // ��������
            if (document.getElementById("txtDISDPT_CD").value != "" &&
                document.getElementById("txtDISDPT_NM").value == "") {
                alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtDISDPT_CD").focus();
                return false;
            }

            // ��������
            if (document.getElementById("txtRET_CD").value != "" &&
                document.getElementById("txtRET_NM").value == "") {
                alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtRET_CD").focus();
                return false;
            }
            
            // ����� CHECK
            if (!fnc_CheckDate(document.getElementById("txtRET_YMD"), "�����") && document.getElementById("txtRET_YMD").value != "") {
                document.getElementById("txtRET_YMD").focus();
                return false;
            }

            // �������ȯ�� CHECK
            if (!fnc_CheckDate(document.getElementById("txtCHNG_YMD"), "�������ȯ��") && document.getElementById("txtCHNG_YMD").value != "") {
                document.getElementById("txtCHNG_YMD").focus();
                return false;
            }

            // ��ŵ�
            /*if (document.getElementById("txtBCT_CD").value != "" &&
                document.getElementById("txtBCT_NM").value == "") {
                alert("��ŵ��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtBCT_CD").focus();
                return false;
            }*/

            // ���ΰ��ǰ���
            /*if (document.getElementById("txtHFRE_CD").value != "" &&
                document.getElementById("txtHFRE_NM").value == "") {
                alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtHFRE_CD").focus();
                return false;
            }*/

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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

                document.getElementById("txtHIR_CD").disabled     = false;
                document.getElementById("txtHIR_TAG").disabled     = false;
                document.getElementById("txtOK_ENO").disabled     = false;
                document.getElementById("txtOK_MAN").disabled     = false;
                document.getElementById("txtDISJOB_CD").disabled  = false;
                document.getElementById("txtDISDPT_CD").disabled  = false;
                document.getElementById("txtJOB_TAG").disabled    = false;
                document.getElementById("txtEDGR_CD").disabled    = false;
                document.getElementById("txtSCH_CD").disabled     = false;
                document.getElementById("txtMAJ_CD").disabled     = false;
                document.getElementById("txtGRD_CD").disabled     = false;
                document.getElementById("txtGUR_YMD").disabled    = false;
                
                document.getElementById("txtRET_CD").disabled      = false;
                document.getElementById("txtRET_YMD").disabled     = false;
                document.getElementById("txtCHNG_YMD").disabled    = false;
                document.getElementById("txtCOC_NAM").disabled     = false;
                document.getElementById("txtREMARK").disabled      = false;
                //document.getElementById("txtBCT_CD").disabled     = false;
                //document.getElementById("txtHF_NAM").disabled     = false;
                //document.getElementById("txtHFRE_CD").disabled    = false;
                //document.getElementById("txtPER_ADR").disabled    = false;

                document.getElementById("ImgHirCd").disabled      = false;
                document.getElementById("ImgOkEno").disabled      = false;
                document.getElementById("ImgDisJobCd").disabled   = false;
                document.getElementById("ImgDisDptCd").disabled   = false;
                
                document.getElementById("ImgRetCd").disabled       = false;
                document.getElementById("ImgRetYmd").disabled      = false;
                document.getElementById("ImgChngYmd").disabled     = false;
                //document.getElementById("ImgBctCd").disabled      = false;
                //document.getElementById("ImgHfreCd").disabled     = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtHIR_CD").disabled     = true;
                document.getElementById("txtHIR_TAG").disabled     = true;
                document.getElementById("txtOK_ENO").disabled     = true;
                document.getElementById("txtOK_MAN").disabled     = true;
                document.getElementById("txtDISJOB_CD").disabled  = true;
                document.getElementById("txtDISDPT_CD").disabled  = true;
                document.getElementById("txtJOB_TAG").disabled    = true;
                document.getElementById("txtEDGR_CD").disabled    = true;
                document.getElementById("txtSCH_CD").disabled     = true;
                document.getElementById("txtMAJ_CD").disabled     = true;
                document.getElementById("txtGRD_CD").disabled     = true;
                document.getElementById("txtGUR_YMD").disabled    = true;
                
                document.getElementById("txtRET_CD").disabled      = true;
                document.getElementById("txtRET_YMD").disabled     = true;
                document.getElementById("txtCHNG_YMD").disabled    = true;
                document.getElementById("txtCOC_NAM").disabled     = true;
                document.getElementById("txtREMARK").disabled      = true;
                //document.getElementById("txtBCT_CD").disabled     = true;
                //document.getElementById("txtHF_NAM").disabled     = true;
                //document.getElementById("txtHFRE_CD").disabled    = true;
                //document.getElementById("txtPER_ADR").disabled    = true;

                document.getElementById("ImgHirCd").disabled      = true;
                document.getElementById("ImgOkEno").disabled      = true;
                document.getElementById("ImgDisJobCd").disabled   = true;
                document.getElementById("ImgDisDptCd").disabled   = true;
                
                document.getElementById("ImgRetCd").disabled       = true;
                document.getElementById("ImgRetYmd").disabled      = true;
                document.getElementById("ImgChngYmd").disabled     = true;
                //document.getElementById("ImgBctCd").disabled      = true;
                //document.getElementById("ImgHfreCd").disabled     = true;

            }
        }

        function fnc_SchCd() {
            var EDGR_CD = document.getElementById("txtEDGR_CD").value;

            if (EDGR_CD == "") {
                alert("�з±����� ���� �Է��Ͽ��ֽñ� �ٶ��ϴ�.");
                document.getElementById("txtEDGR_CD").focus();
                return;
            }
            else if (EDGR_CD == "2") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','���б�','E8');
            }
            else if (EDGR_CD == "3") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','����б�','E2');
            }
            else if (EDGR_CD == "4") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','������','E3');
            }
            else if (EDGR_CD == "5") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','���б�','E4');
            }
            else if (EDGR_CD == "6" ||
                     EDGR_CD == "7" ||
                     EDGR_CD == "8" ) {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','���п�','E5');
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
    | 2. �̸� : dsT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        if (parent.savflag != '1') {
            parent.savflag = 1;
        }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

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
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�λ�⺻2</strong>
        </td>
        <td height="20" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="ImgClear" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>-->
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="65"></col>
                    <col width="90"></col>
                    <col width="142"></col>
                    <col width="95"></col>
                    <col width="142"></col>
                    <col width="95"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">�Ի�����</td>
                    <td align="center" class="creamBold">ä�뱸��</td>
                    <td class="padding2423">
                        <input id="txtHIR_CD" maxlength="3" style="width:17%"  onChange="fnc_GetCommNm('C1', 'txtHIR_CD','txtHIR_NM');"> <input id="txtHIR_NM" style="width:59%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirCd" name="ImgHirCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHIR_CD','txtHIR_NM','ä�뱸��','C1')"></a>
                    </td>
                    <td align="center" class="creamBold">�� õ ��</td>
                    <td class="padding2423">
                        <input id="txtOK_ENO" maxlength="8" style="width:37%;ime-mode:disabled" onKeyPress="JavaScript: cfNumberCheck();" onChange="fnc_GetEnoNm('txtOK_ENO','txtOK_MAN','1');"> <input id="txtOK_MAN" style="width:39%" onChange="fnc_GetEnoNo('txtOK_MAN','txtOK_ENO')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgOkEno','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgOkEno" name="ImgOkEno" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtOK_ENO','txtOK_MAN', '1')"></a>
                    </td>
                    <td align="center" class="creamBold">ä�����</td>
                    <td class="padding2423">
                        <input id="txtHIR_TAG" style="width:100%" maxlength="20">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�İߴ�����</td>
                    <td class="padding2423" >
                        <input id="txtDISJOB_CD" maxlength="5" style="width:25%" onChange="fnc_GetCommNm('C8', 'txtDISJOB_CD','txtDISJOB_NM');"> <input id="txtDISJOB_NM" style="width:51%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisJobCd" name="ImgDisJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDISJOB_CD','txtDISJOB_NM','�ٷ����İߴ�����','C8')"></a>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtDISDPT_CD" maxlength="2" style="width:17%" onChange="fnc_GetCommNm('C9', 'txtDISDPT_CD','txtDISDPT_NM');"> <input id="txtDISDPT_NM" style="width:59%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisDptCd" name="ImgDisDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDISDPT_CD','txtDISDPT_NM','�İ߻����������','C9')"></a>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" >
                        <input id="txtJOB_TAG" style="width:100%"  class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                
                <tr>
                    <td align="center" class="creamBold" rowspan="3">�İ�����</td>
                    <td align="center" class="creamBold">�İ߾�ü</td>
                    <td class="padding2423"><input id="txtDISCOMP_NM" style="width:100%" class="input_ReadOnly"  readonly></td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423"><input id="txtCONS_YMD" style="width:100%" class="input_ReadOnly"  readonly></td>
                    <td align="center" class="creamBold">��ุ����</td>
                    <td class="padding2423"><input id="txtCONE_YMD" style="width:100%" class="input_ReadOnly"  readonly></td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�İߴܰ�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medBAS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
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
                    <td class="padding2423" colspan="3">
                        <comment id="__NSID__"><object id="medLSEV_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:38%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
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
                    <td align="center" class="creamBold">�ټ������(6)</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medLSEV_AMT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
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
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medLSEV_AMT3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">�ټ������(18)</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medWEL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
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
                    <td align="center" class="creamBold" rowspan="2">�������</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtRET_CD" style="width:30%" maxlength="5" onChange="fnc_GetCommNm('C2', 'txtRET_CD','txtRET_NM');"> <input id="txtRET_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRetCd" name="ImgRetCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtRET_CD','txtRET_NM','��������','C2')"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtRET_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�����');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRetYmd" name="ImgRetYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRET_YMD','','335','80');"></a>
                    </td>
                    <td align="center" class="creamBold">�������ȯ��</td>
                    <td class="padding2423" >
                        <input id="txtCHNG_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�������ȯ��');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgChngYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgChngYmd" name="ImgChngYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCHNG_YMD','','335','105');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtCOC_NAM" style="width:100%" maxlength="14">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtREMARK" style="width:100%" maxlength="60">
                    </td>
                </tr>
                
                <tr>
                    <td align="center" class="creamBold" rowspan="2">�з»���</td>
                    <td align="center" class="creamBold">�з±���</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" maxlength="3" style="width:17%" class="input_ReadOnly"  readonly> <input id="txtEDGR_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtSCH_CD" maxlength="3" style="width:17%"  class="input_ReadOnly"  readonly> <input id="txtSCH_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD" maxlength="3" style="width:17%" class="input_ReadOnly"  readonly> <input id="txtMAJ_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <input id="txtGRD_CD" maxlength="3" style="width:17%" class="input_ReadOnly"  readonly> <input id="txtGRD_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtGUR_YMD" style="width:100%;ime-mode:disabled" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    </td>
                </tr>

                <!-- 
                <tr>
                    <td align="center" class="creamBold" rowspan="2">�Ż�����</td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtBCT_CD" maxlength="3" style="width:17%" onChange="fnc_GetCommNm('B4', 'txtBCT_CD','txtBCT_NM');"> <input id="txtBCT_NM" style="width:59%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBctCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgBctCd" name="ImgBctCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBCT_CD','txtBCT_NM','��ŵ�','B4')"></a>
                    </td>
                    <td align="center" class="creamBold">ȣ&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHF_NAM" maxlength="12" style="width:100%"></td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHFRE_CD" maxlength="3" style="width:17%" onChange="fnc_GetCommNm('G1', 'txtHFRE_CD','txtHFRE_NM');"> <input id="txtHFRE_NM" style="width:56%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHfreCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHfreCd" name="ImgHfreCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHFRE_CD','txtHFRE_NM','ȣ�ֿ��ǰ���','G1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="5"><input id="txtPER_ADR" maxlength="60" style="width:100%"></td>
                </tr>
                -->
                
           </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=HIR_CD        Ctrl=txtHIR_CD      Param=value </C>
        <C> Col=HIR_NM        Ctrl=txtHIR_NM      Param=value </C>
        <C> Col=HIR_TAG       Ctrl=txtHIR_TAG     Param=value </C>
        <C> Col=OK_ENO        Ctrl=txtOK_ENO      Param=value </C>
        <C> Col=OK_MAN        Ctrl=txtOK_MAN      Param=value </C>
        <C> Col=DISJOB_CD     Ctrl=txtDISJOB_CD   Param=value </C>
        <C> Col=DISJOB_NM     Ctrl=txtDISJOB_NM   Param=value </C>
        <C> Col=DISDPT_CD     Ctrl=txtDISDPT_CD   Param=value </C>
        <C> Col=DISDPT_NM     Ctrl=txtDISDPT_NM   Param=value </C>
        <C> Col=JOB_TAG       Ctrl=txtJOB_TAG     Param=value </C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD     Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM     Param=value </C>
        <C> Col=SCH_CD        Ctrl=txtSCH_CD      Param=value </C>
        <C> Col=SCH_NM        Ctrl=txtSCH_NM      Param=value </C>
        <C> Col=MAJ_CD        Ctrl=txtMAJ_CD      Param=value </C>
        <C> Col=MAJ_NM        Ctrl=txtMAJ_NM      Param=value </C>
        <C> Col=GRD_CD        Ctrl=txtGRD_CD      Param=value </C>
        <C> Col=GRD_NM        Ctrl=txtGRD_NM      Param=value </C>
        <C> Col=GUR_YMD       Ctrl=txtGUR_YMD     Param=value </C>

        <C> Col=RET_CD        Ctrl=txtRET_CD      Param=value </C>
        <C> Col=RET_NM        Ctrl=txtRET_NM      Param=value </C>
        <C> Col=RET_YMD       Ctrl=txtRET_YMD     Param=value </C>
        <C> Col=CHNG_YMD      Ctrl=txtCHNG_YMD    Param=value </C>
        <C> Col=COC_NAM       Ctrl=txtCOC_NAM     Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK      Param=value </C>
        
        <C> Col=DISCOMP_NM    Ctrl=txtDISCOMP_NM  Param=value </C>
        <C> Col=CONS_YMD      Ctrl=txtCONS_YMD    Param=value </C>
        <C> Col=CONE_YMD      Ctrl=txtCONE_YMD    Param=value </C>

        <C> Col=BAS_AMT       Ctrl=medBAS_AMT     Param=text </C>
        <C> Col=LSEV_AMT1     Ctrl=medLSEV_AMT1   Param=text </C>
        <C> Col=LSEV_AMT2     Ctrl=medLSEV_AMT2   Param=text </C>
        <C> Col=LSEV_AMT3     Ctrl=medLSEV_AMT3   Param=text </C>
        <C> Col=WEL_AMT       Ctrl=medWEL_AMT     Param=text </C>
    '>
</object>
<!-- 
        <C> Col=BCT_CD        Ctrl=txtBCT_CD      Param=value </C>
        <C> Col=BCT_NM        Ctrl=txtBCT_NM      Param=value </C>
        <C> Col=HF_NAM        Ctrl=txtHF_NAM      Param=value </C>
        <C> Col=HFRE_CD       Ctrl=txtHFRE_CD     Param=value </C>
        <C> Col=HFRE_NM       Ctrl=txtHFRE_NM     Param=value </C>
        <C> Col=PER_ADR       Ctrl=txtPER_ADR     Param=value </C>
 -->
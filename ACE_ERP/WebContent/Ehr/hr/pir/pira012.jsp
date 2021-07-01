<!--
    ************************************************************************************
    * @Source         : pira012.jsp                                                    		*
    * @Description    : �λ�⺻2 PAGE                                                	 	*
    * @Developer Desc :                                                                		*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            	*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�λ�⺻2</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

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

            if (form1.ENO_NO.value == "" || (parent.dsT_CM_PERSON.CountRow < 1 && parent.dsT_CM_PERSON.RowStatus(1) != 1)) {

                dsT_CM_PERSON.ClearData();
                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira012.cmd.PIRA012CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_PERSON.Reset();

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
            if (!dsT_CM_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira012.cmd.PIRA012CMD&S_MODE=SAV";
                trT_CM_PERSON.post();

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

			dsT_CM_PERSON.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.txtHIR_CD.focus();

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

            // �����Ի��� CHECK
            if (!fnc_CheckDate(document.getElementById("txtRHI_YMD"), "�����Ի���") && document.getElementById("txtRHI_YMD").value != "") {
                document.getElementById("txtRHI_YMD").focus();
                return false;
            }

            // ��õ��
            if (document.getElementById("txtOK_ENO").value != "" &&
                document.getElementById("txtOK_MAN").value == "") {
                alert("��õ�λ���� �Է��Ͻ� ���� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtOK_ENO").focus();
                return false;
            }

            // ����
            if (document.getElementById("txtNAT_CD").value != "" &&
                document.getElementById("txtNAT_NM").value == "") {
                alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtNAT_CD").focus();
                return false;
            }

            // �׷��
            if (document.getElementById("txtGROUP_CD").value != "" &&
                document.getElementById("txtGROUP_NM").value == "") {
                alert("�׷���ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtGROUP_CD").focus();
                return false;
            }

            // ��ŵ�
            if (document.getElementById("txtBCT_CD").value != "" &&
                document.getElementById("txtBCT_NM").value == "") {
                alert("��ŵ��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtBCT_CD").focus();
                return false;
            }

            // ���ΰ��ǰ���
            if (document.getElementById("txtHFRE_CD").value != "" &&
                document.getElementById("txtHFRE_NM").value == "") {
                alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtHFRE_CD").focus();
                return false;
            }

            // �߱��� CHECK
            if (!fnc_CheckDate(document.getElementById("txtPISS_YMD"), "�߱���") && document.getElementById("txtPISS_YMD").value != "") {
                document.getElementById("txtPISS_YMD").focus();
                return false;
            }

            // ������ CHECK
            if (!fnc_CheckDate(document.getElementById("txtPCHG_YMD"), "������") && document.getElementById("txtPCHG_YMD").value != "") {
                document.getElementById("txtPCHG_YMD").focus();
                return false;
            }

            // ������ CHECK
            if (!fnc_CheckDate(document.getElementById("txtPDUE_YMD"), "������") && document.getElementById("txtPDUE_YMD").value != "") {
                document.getElementById("txtPDUE_YMD").focus();
                return false;
            }

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
                document.getElementById("txtRHI_YMD").disabled    = false;
                document.getElementById("txtNAT_CD").disabled     = false;
                document.getElementById("txtGROUP_CD").disabled   = false;
                document.getElementById("txtOK_ENO").disabled     = false;
                document.getElementById("txtOK_MAN").disabled     = false;
                document.getElementById("txtEDGR_CD").disabled    = false;
                document.getElementById("txtSCH_CD").disabled     = false;
                document.getElementById("txtMAJ_CD").disabled     = false;
                document.getElementById("txtGRD_CD").disabled     = false;
                document.getElementById("txtGUR_YMD").disabled    = false;
                document.getElementById("txtBCT_CD").disabled     = false;
                document.getElementById("txtHF_NAM").disabled     = false;
                document.getElementById("txtHFRE_CD").disabled    = false;
                document.getElementById("txtPER_ADR").disabled    = false;
                document.getElementById("txtJAJ_YMD").disabled    = false;
                document.getElementById("txtFINJ_CD").disabled    = false;
                document.getElementById("txtTMR_YMD").disabled    = false;
                document.getElementById("txtTMR_DD").disabled     = false;
                document.getElementById("txtPAS_NO").disabled     = false;
                document.getElementById("txtPER_JOB").disabled    = false;
                document.getElementById("txtPISS_YMD").disabled   = false;
                document.getElementById("txtPCHG_YMD").disabled   = false;
                document.getElementById("txtPDUE_YMD").disabled   = false;

                document.getElementById("ImgHirCd").disabled      = false;
                document.getElementById("ImgRhiYmd").disabled     = false;
                document.getElementById("ImgNatCd").disabled      = false;
                document.getElementById("ImgGroupCd").disabled    = false;
                document.getElementById("ImgOkEno").disabled      = false;
                document.getElementById("ImgBctCd").disabled      = false;
                document.getElementById("ImgHfreCd").disabled     = false;
                document.getElementById("ImgPissYmd").disabled    = false;
                document.getElementById("ImgPchgYmd").disabled    = false;
                document.getElementById("ImgPdueYmd").disabled    = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtHIR_CD").disabled     = true;
                document.getElementById("txtRHI_YMD").disabled    = true;
                document.getElementById("txtNAT_CD").disabled     = true;
                document.getElementById("txtGROUP_CD").disabled   = true;
                document.getElementById("txtOK_ENO").disabled     = true;
                document.getElementById("txtOK_MAN").disabled     = true;
                document.getElementById("txtEDGR_CD").disabled    = true;
                document.getElementById("txtSCH_CD").disabled     = true;
                document.getElementById("txtMAJ_CD").disabled     = true;
                document.getElementById("txtGRD_CD").disabled     = true;
                document.getElementById("txtGUR_YMD").disabled    = true;
                document.getElementById("txtBCT_CD").disabled     = true;
                document.getElementById("txtHF_NAM").disabled     = true;
                document.getElementById("txtHFRE_CD").disabled    = true;
                document.getElementById("txtPER_ADR").disabled    = true;
                document.getElementById("txtJAJ_YMD").disabled    = true;
                document.getElementById("txtFINJ_CD").disabled    = true;
                document.getElementById("txtTMR_YMD").disabled    = true;
                document.getElementById("txtTMR_DD").disabled     = true;
                document.getElementById("txtPAS_NO").disabled     = true;
                document.getElementById("txtPER_JOB").disabled    = true;

                document.getElementById("txtPISS_YMD").disabled   = true;
                document.getElementById("txtPCHG_YMD").disabled   = true;
                document.getElementById("txtPDUE_YMD").disabled   = true;

                document.getElementById("ImgHirCd").disabled      = true;
                document.getElementById("ImgRhiYmd").disabled     = true;
                document.getElementById("ImgNatCd").disabled      = true;
                document.getElementById("ImgGroupCd").disabled    = true;
                document.getElementById("ImgOkEno").disabled      = true;
                document.getElementById("ImgBctCd").disabled      = true;
                document.getElementById("ImgHfreCd").disabled     = true;
                document.getElementById("ImgPissYmd").disabled    = true;
                document.getElementById("ImgPchgYmd").disabled    = true;
                document.getElementById("ImgPdueYmd").disabled    = true;

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
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = ' ';

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
          if (parent.savflag != '1') {
              parent.savflag = 1;
          }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�λ�⺻2</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="66 "></col>
                    <col width="80 "></col>
                    <col width="161"></col>
                    <col width="80 "></col>
                    <col width="161"></col>
                    <col width="79 "></col>
                    <col width="160"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">�Ի�����</td>
                    <td align="center" class="blueBold">ä�뱸��</td>
                    <td class="padding2423">
                        <input id="txtHIR_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('C1', 'txtHIR_CD','txtHIR_NM');"> <input id="txtHIR_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHirCd" name="ImgHirCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHIR_CD','txtHIR_NM','ä�뱸��','C1')"></a>
                    </td>
                    <td align="center" class="blueBold">�����Ի���</td>
                    <td class="padding2423">
                        <input id="txtRHI_YMD" style="width:81%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�����Ի���');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRhiYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRhiYmd" name="ImgRhiYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRHI_YMD','','360','55');"></a>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtNAT_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('L2', 'txtNAT_CD','txtNAT_NM');"> <input id="txtNAT_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNatCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgNatCd" name="ImgNatCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtNAT_CD','txtNAT_NM','����','L2')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�׷���</td>
                    <td class="padding2423">
                        <input id="txtGROUP_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('B5', 'txtGROUP_CD','txtGROUP_NM');"> <input id="txtGROUP_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGroupCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGroupCd" name="ImgGroupCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGROUP_CD','txtGROUP_NM','�׷��','B5')"></a>
                    </td>
                    <td align="center" class="blueBold">�� õ ��</td>
                    <td class="padding2423">
                        <input id="txtOK_ENO" maxlength="8" style="width:37%;ime-mode:disabled" onKeyPress="JavaScript: cfNumberCheck();"  onChange="fnc_GetEnoNm('txtOK_ENO','txtOK_MAN','1');"> <input id="txtOK_MAN" style="width:39%" onChange="fnc_GetEnoNo('txtOK_MAN','txtOK_ENO')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgOkEno','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgOkEno" name="ImgOkEno" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtOK_ENO','txtOK_MAN', '1')"></a>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">�з»���</td>
                    <td align="center" class="blueBold">�з±���</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtEDGR_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtSCH_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtSCH_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtMAJ_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtGRD_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtGRD_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                          <input id="txtGUR_YMD" style="width:100%;ime-mode:disabled" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    <!--      <input id="txtGUR_YMD" style="width:100%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly> -->
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">�Ż�����</td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtBCT_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('B4', 'txtBCT_CD','txtBCT_NM');"> <input id="txtBCT_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBctCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgBctCd" name="ImgBctCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBCT_CD','txtBCT_NM','��ŵ�','B4')"></a>
                    </td>
                    <td align="center" class="blueBold">ȣ&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHF_NAM" maxlength="12" style="width:100%"></td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHFRE_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('G1', 'txtHFRE_CD','txtHFRE_NM');"> <input id="txtHFRE_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHfreCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHfreCd" name="ImgHfreCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHFRE_CD','txtHFRE_NM','ȣ�ֿ��ǰ���','G1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="5"><input id="txtPER_ADR" maxlength="60" style="width:100%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="66 "></col>
                    <col width="83 "></col>
                    <col width="103"></col>
                    <col width="62 "></col>
                    <col width="142"></col>
                    <col width="62 "></col>
                    <col width="103"></col>
                    <col width="62 "></col>
                    <col width="100"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >�߷ɻ���</td>
                    <td align="center" class="blueBold">�����߷���</td>
                    <td class="padding2423">
                        <input id="txtJAJ_YMD" style="width:100%" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtFINJ_CD" maxlength="3" style="width:20%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtFINJ_NM" style="width:74%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtTMR_YMD" style="width:26%" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    </td>
                    <input type="hidden" id="txtTMR_DD" maxlength="5" style="width:100%"  class="input_ReadOnly"  readonly>
                </tr>
                <tr>
                    <td align="center" class="blueBold" >���ǻ���</td>
                    <td align="center" class="blueBold">���ǹ�ȣ</td>
                    <td class="padding2423"><input id="txtPAS_NO" maxlength="10" style="width:100%"></td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtPISS_YMD" style="width:78%" maxlength="10" onChange="fnc_CheckDate(this, '�߱���');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPissYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPissYmd" name="ImgPissYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPISS_YMD','','250','50');"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtPCHG_YMD" style="width:69%" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPchgYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPchgYmd" name="ImgPchgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPCHG_YMD','','430','50');"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtPDUE_YMD" style="width:69%" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPdueYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPdueYmd" name="ImgPdueYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPDUE_YMD','','600','50');"></a>
                    </td>
                </tr>


                <tr>
                    <td align="center" class="blueBold">��Ÿ����</td>
                    <td align="center" class="blueBold">������</td>
                    <td class="padding2423" colspan="3"><input id="txtPER_JOB" maxlength="40" style="width:100%"></td>
                </tr>






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
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=HIR_CD        Ctrl=txtHIR_CD      Param=value </C>
        <C> Col=HIR_NM        Ctrl=txtHIR_NM      Param=value </C>
        <C> Col=RHI_YMD       Ctrl=txtRHI_YMD     Param=value </C>
        <C> Col=NAT_CD        Ctrl=txtNAT_CD      Param=value </C>
        <C> Col=NAT_NM        Ctrl=txtNAT_NM      Param=value </C>
        <C> Col=GROUP_CD      Ctrl=txtGROUP_CD    Param=value </C>
        <C> Col=GROUP_NM      Ctrl=txtGROUP_NM    Param=value </C>
        <C> Col=OK_ENO        Ctrl=txtOK_ENO      Param=value </C>
        <C> Col=OK_MAN        Ctrl=txtOK_MAN      Param=value </C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD     Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM     Param=value </C>
        <C> Col=SCH_CD        Ctrl=txtSCH_CD      Param=value </C>
        <C> Col=SCH_NM        Ctrl=txtSCH_NM      Param=value </C>
        <C> Col=MAJ_CD        Ctrl=txtMAJ_CD      Param=value </C>
        <C> Col=MAJ_NM        Ctrl=txtMAJ_NM      Param=value </C>
        <C> Col=GRD_CD        Ctrl=txtGRD_CD      Param=value </C>
        <C> Col=GRD_NM        Ctrl=txtGRD_NM      Param=value </C>
        <C> Col=GUR_YMD       Ctrl=txtGUR_YMD     Param=value </C>
        <C> Col=BCT_CD        Ctrl=txtBCT_CD      Param=value </C>
        <C> Col=BCT_NM        Ctrl=txtBCT_NM      Param=value </C>
        <C> Col=HF_NAM        Ctrl=txtHF_NAM      Param=value </C>
        <C> Col=HFRE_CD       Ctrl=txtHFRE_CD     Param=value </C>
        <C> Col=HFRE_NM       Ctrl=txtHFRE_NM     Param=value </C>
        <C> Col=PER_ADR       Ctrl=txtPER_ADR     Param=value </C>
        <C> Col=JAJ_YMD       Ctrl=txtJAJ_YMD     Param=value </C>
        <C> Col=FINJ_CD       Ctrl=txtFINJ_CD     Param=value </C>
        <C> Col=FINJ_NM       Ctrl=txtFINJ_NM     Param=value </C>
        <C> Col=TMR_YMD       Ctrl=txtTMR_YMD     Param=value </C>
        <C> Col=TMR_DD        Ctrl=txtTMR_DD      Param=value </C>
        <C> Col=PAS_NO        Ctrl=txtPAS_NO      Param=value </C>
        <C> Col=PER_JOB       Ctrl=txtPER_JOB     Param=value </C>
        <C> Col=PISS_YMD      Ctrl=txtPISS_YMD    Param=value </C>
        <C> Col=PCHG_YMD      Ctrl=txtPCHG_YMD    Param=value </C>
        <C> Col=PDUE_YMD      Ctrl=txtPDUE_YMD    Param=value </C>
    '>
</object>
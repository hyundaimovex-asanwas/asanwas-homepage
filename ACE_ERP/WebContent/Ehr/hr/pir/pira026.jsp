<!--
    ************************************************************************************
    * @Source         : pira026.jsp                                                    		*
    * @Description    : ������� PAGE                                                  		*
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
<title>�������</title>
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

            dsT_CM_REWARD.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_REWARD.Reset();

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

                trT_CM_REWARD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=SAV";
                trT_CM_REWARD.post();

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
            if (dsT_CM_REWARD.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_REWARD.RowStatus(dsT_CM_REWARD.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_REWARD.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�������[" + dsT_CM_REWARD.NameValue(dsT_CM_REWARD.RowPosition,"REPU_YMD") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_REWARD.DeleteRow(dsT_CM_REWARD.RowPosition);

            if (status != 1) {
                trT_CM_REWARD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=DEL";
                trT_CM_REWARD.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_REWARD.SetColumn(form1.grdT_CM_REWARD.GetColumnID(0));
            form1.grdT_CM_REWARD.Focus();

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
            if (dsT_CM_REWARD.CountColumn == 0) {
                dsT_CM_REWARD.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, REPU_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, REPU_CD:STRING:KEYVALUETYPE, REPU_TAG:STRING:KEYVALUETYPE, SYC_NAM:STRING, REPU_RMK:STRING, REMARK1:STRING, REMARK2:STRING, REMARK3:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_REWARD.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_REWARD.setColumn(form1.grdT_CM_REWARD.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtREPU_YMD").disabled = false;
            document.getElementById("cmbREPU_CD").disabled  = false;
            document.getElementById("ImgRepuYmd").disabled  = false;
            document.getElementById("cmbREPU_CD").focus();
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

			dsT_CM_REWARD.ClearData();
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
            if (!dsT_CM_REWARD.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_REWARD.CountRow; i++ ) {
                if ( dsT_CM_REWARD.RowStatus(i) == 1 ||
                     dsT_CM_REWARD.RowStatus(i) == 3 ) {


                    // �������
                    if( dsT_CM_REWARD.NameValue(i, "REPU_CD") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("cmbREPU_CD").focus();
                        return false;
                    }

                    // �������
                    if( dsT_CM_REWARD.NameValue(i, "REPU_TAG") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_TAG").focus();
                        return false;
                    }

                    // �������
                    if (dsT_CM_REWARD.NameValue(i, "REPU_TAG") != "" &&
                        dsT_CM_REWARD.NameValue(i, "REPU_TNM") == "") {
                        alert("��������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_TAG").focus();
                        return;
                    }

                    // �������
                    if( dsT_CM_REWARD.NameValue(i, "REPU_YMD") == '' ) {
                        alert("������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_YMD").focus();
                        return false;
                    }

                    // ������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_REWARD.NameValue(i, "REPU_YMD"), "�������") && dsT_CM_REWARD.NameValue(i, "REPU_YMD") != "") {
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_YMD").focus();
                        return false;
                    }

                    // �빰
                    if( dsT_CM_REWARD.NameValue(i, "REMARK1") == '' ) {
                        dsT_CM_REWARD.NameValue(i, "REMARK1") = "N";
                    }

                    // ����
                    if( dsT_CM_REWARD.NameValue(i, "REMARK2") == '' ) {
                        dsT_CM_REWARD.NameValue(i, "REMARK2") = "N";
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_REWARD.NameValue(i, "END_YMD"), "������") && dsT_CM_REWARD.NameValue(i, "END_YMD") != "") {
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // ������ڿ� �������� ��
                    if( dsT_CM_REWARD.NameValue(i, "REPU_YMD") != '' && dsT_CM_REWARD.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_REWARD.NameValue(i, "REPU_YMD").replace(/\-/g,''),dsT_CM_REWARD.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�������ڰ� �������ں��� Ů�ϴ�.");
                            dsT_CM_REWARD.RowPosition = i;
                            document.getElementById("txtREPU_YMD").focus();
                            return false;
                        }
                    }


                    if ( dsT_CM_REWARD.RowStatus(i) == 1) {
                        document.getElementById("txtREPU_YMD").disabled = true;
                        document.getElementById("cmbREPU_CD").disabled  = true;
                        document.getElementById("ImgRepuYmd").disabled  = true;
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
            cfStyleGrid_New(form1.grdT_CM_REWARD, 0,"false","false");

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

                document.getElementById("txtREPU_YMD").disabled = false;
                document.getElementById("cmbREPU_CD").disabled  = false;
                document.getElementById("txtREPU_TAG").disabled = false;
                document.getElementById("txtSYC_NAM").disabled  = false;
                document.getElementById("txtREPU_RMK").disabled = false;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("txtREMARK3").disabled  = false;
                document.getElementById("ImgRepuYmd").disabled  = false;
                document.getElementById("ImgRepuTag").disabled  = false;
                document.getElementById("ImgEndYmd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtREPU_YMD").disabled = true;
                document.getElementById("cmbREPU_CD").disabled  = true;
                document.getElementById("txtREPU_TAG").disabled = true;
                document.getElementById("txtSYC_NAM").disabled  = true;
                document.getElementById("txtREPU_RMK").disabled = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtREMARK3").disabled  = true;
                document.getElementById("ImgRepuYmd").disabled  = true;
                document.getElementById("ImgRepuTag").disabled  = true;
                document.getElementById("ImgEndYmd").disabled   = true;

            }
        }

        function fnc_ChkBox(obj) {
        	
            if (document.getElementById(obj).checked == true) {
            	
                if (obj == "chkREMARK1") {
                    document.getElementById("txtREMARK1").value = "Y";
                }
                else {
                    document.getElementById("txtREMARK2").value = "Y";
                }
            }
            else {
            	
                if (obj == "chkREMARK1") {
                    document.getElementById("txtREMARK1").value = "N";
                }
                else {
                    document.getElementById("txtREMARK2").value = "N";
                }
            }
        }

        function fnc_GetRepuTag() {

                fnc_GetCommNm('K1', 'txtREPU_TAG','txtREPU_TNM');

        }

        function fnc_RepuTagPopup() {

                fnc_commonCodePopup('txtREPU_TAG','txtREPU_TNM','�������','K1');

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
    | 2. �̸� : dsT_CM_REWARD                       |
    | 3. Table List : T_CM_REWARD                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_REWARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_REWARD                       |
    | 3. Table List : T_CM_REWARD                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_REWARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_REWARD)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_REWARD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_REWARD.CountRow);

            document.getElementById("txtREPU_YMD").disabled = true;
            document.getElementById("cmbREPU_CD").disabled  = true;
            document.getElementById("ImgRepuYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_REWARD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_REWARD Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[�������/�������/�������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019 || this.ErrorCode == 50020) {
            alert("�������/�������/��������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_REWARD event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_REWARD event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_REWARD Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_REWARD.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtREPU_YMD").disabled = false;
            document.getElementById("cmbREPU_CD").disabled  = false;
            document.getElementById("ImgRepuYmd").disabled  = false;

        }else {
            document.getElementById("txtREPU_YMD").disabled = true;
            document.getElementById("cmbREPU_CD").disabled  = true;
            document.getElementById("ImgRepuYmd").disabled  = true;

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
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�������</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">   <img src="../../images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','../../images/button/btn_CancelOver.gif',1)"> <img src="../../images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <select id="cmbREPU_CD" style="width:100%" >
                            <option value="" >����</option>
                            <option value="1" >����(�系)</option>
                            <option value="2" >����(���)</option>
                            <option value="4" >����(�׷�)</option>                            
                            <option value="3" >¡��(�系)</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtREPU_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRepuYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRepuYmd" name="ImgRepuYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtREPU_YMD','','210','53');"></a>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtREPU_TAG" style="width:15%" maxlength="2" onChange="fnc_GetRepuTag();"> <input id="txtREPU_TNM" style="width:57%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRepuTag','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRepuTag" name="ImgRepuTag" width="21" height="20" border="0" align="absmiddle" onClick="fnc_RepuTagPopup();"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ó</td>
                    <td class="padding2423"  colspan="3">
                        <input id="txtSYC_NAM" style="width:100%" maxlength="22">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423"  colspan="3">
                        <input id="txtREPU_RMK" style="width:100%" maxlength="60">
                    </td>

                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','610','78');"></a>
                    </td>

                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423"  colspan="7">
                        <input id="txtREMARK3" style="width:100%" maxlength="120">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_REWARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                    value="dsT_CM_REWARD">
                            <param name="Format"                    value="
                                <C> id={currow}         width=40     name='����'           align=center </C>
                                <C> id=REPU_YMD       width=100     name='�������'       align=center </C>
                                <C> id=REPU_CD1        width=120     name='�������'       align=center value={Decode(REPU_CD,'1','����(�系)','2','����(���)','3','¡��(�系)','4','����(�׷�)','')} </C>
                                <C> id=REPU_TNM        width=150     name='�������'                    </C>
                                <C> id=SYC_NAM         width=120     name='����ó'                      </C>
                                <C> id=REPU_RMK        width=250    name='�������'                    </C>
                                <C> id=END_YMD         width=75     name='������'        align=center </C>
                                <C> id=REMARK3         width=100    name='���'                        </C>
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
<!-- ������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_REWARD">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=REPU_YMD      Ctrl=txtREPU_YMD     Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=REPU_CD       Ctrl=cmbREPU_CD      Param=value </C>
        <C> Col=REPU_TAG      Ctrl=txtREPU_TAG     Param=value </C>
        <C> Col=REPU_TNM      Ctrl=txtREPU_TNM     Param=value </C>
        <C> Col=SYC_NAM       Ctrl=txtSYC_NAM      Param=value </C>
        <C> Col=REPU_RMK      Ctrl=txtREPU_RMK     Param=value </C>
        <C> Col=REMARK1       Ctrl=txtREMARK1      Param=value </C>
        <C> Col=REMARK2       Ctrl=txtREMARK2      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=REMARK3       Ctrl=txtREMARK3      Param=value </C>
    '>
</object>
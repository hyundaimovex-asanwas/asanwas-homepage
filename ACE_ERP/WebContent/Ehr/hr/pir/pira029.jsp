<!--
    ************************************************************************************
    * @Source         : pira029.jsp                                                    *
    * @Description    : �����°��� PAGE                                              *
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
    <title>�����°���</title>
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

            dsT_CM_CAREER.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira029.cmd.PIRA029CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_CAREER.Reset();

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

                trT_CM_CAREER.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira029.cmd.PIRA029CMD&S_MODE=SAV";
                trT_CM_CAREER.post();

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
            if (dsT_CM_CAREER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_CAREER.RowStatus(dsT_CM_CAREER.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_CAREER.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�������[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"STR_YMD") + "] ���������[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"PJT_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_CAREER.DeleteRow(dsT_CM_CAREER.RowPosition);

            if (status != 1) {
                trT_CM_CAREER.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira029.cmd.PIRA029CMD&S_MODE=DEL";
                trT_CM_CAREER.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_CAREER.SetColumn(form1.grdT_CM_CAREER.GetColumnID(0));
            form1.grdT_CM_CAREER.Focus();

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
            if (dsT_CM_CAREER.CountColumn == 0) {
                dsT_CM_CAREER.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, PJT_NM:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, ODR_NM:STRING, CMP_NM:STRING, JOB_NM:STRING, CHG_CD1:STRING, CHG_CD2:STRING, CHG_CD3:STRING, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_CAREER.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_CAREER.setColumn(form1.grdT_CM_CAREER.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtPJT_NM").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

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

			dsT_CM_CAREER.ClearData();
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
            if (!dsT_CM_CAREER.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_CAREER.CountRow; i++ ) {
                if ( dsT_CM_CAREER.RowStatus(i) == 1 ||
                     dsT_CM_CAREER.RowStatus(i) == 3 ) {


                    // ��������
                    if( dsT_CM_CAREER.NameValue(i, "STR_YMD") == '' ) {
                        alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_CAREER.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_CAREER.NameValue(i, "STR_YMD"), "��������") && dsT_CM_CAREER.NameValue(i, "STR_YMD") != "") {
                        dsT_CM_CAREER.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // ���������
                    if( dsT_CM_CAREER.NameValue(i, "PJT_NM") == '' ) {
                        alert("����������� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_CAREER.RowPosition = i;
                        document.getElementById("txtPJT_NM").focus();
                        return false;
                    }

                    if ( dsT_CM_CAREER.RowStatus(i) == 1) {
                       document.getElementById("txtSTR_YMD").disabled = true;
                       document.getElementById("txtPJT_NM").disabled = true;
                       document.getElementById("ImgStrYmd").disabled  = true;
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
			//alert(document.getElementById("ENO_NO").value)
            //Grid Style ����
            cfStyleGrid(form1.grdT_CM_CAREER, 0,"false","false");

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
         /**
         * T_CM_COMMON(�����ڵ�) ��ȸ�� �˾� (�μ� �� ���δ� ����)
         * @param - ctrl_01 : ���Ϲ��� �ڵ��
         * @param - ctrl_02 : ���Ϲ��� �ڵ���Ӹ�
         * @param - ctrl_03 : Ÿ��Ʋ��
         * @param - ctrl_04 : cd_gbn �ڵ��
         * @param - ctrl_05 : �����ڵ� gbn2_tag ��� ����(Y/N)(20070313�߰�)
         * @param - ctrl_06 : �ٷα��п� ���� �ڵ屸��(20070704�߰�)
         */
        function fnc_careerCodePopup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06) {

            var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
            obj.title   = ctrl_03;
            obj.cd_gbn  = ctrl_04;

            //���� ������ N���� ����
            if(ctrl_05 == undefined || ctrl_05.trim() == ""){
                obj.gbn2_tag = "N";
            }else{
                obj.gbn2_tag = document.getElementById(ctrl_05).value;
            }

            //���� ���ų� �����̸� ��ü
            if(ctrl_06 == undefined){
                obj.occ_cd = "";
            }else{
                obj.occ_cd = ctrl_06;
            }

            window.showModalDialog("/common/popup/career.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.comm_cd != '' && obj.comm_nm != ''){
                document.getElementById(ctrl_01).value = obj.comm_cd;
                document.getElementById(ctrl_02).value = obj.comm_nm;
            }

        }

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {
                document.getElementById("txtSTR_YMD").disabled = false;
                document.getElementById("txtPJT_NM").disabled = false;
                document.getElementById("txtCMP_NM").disabled  = false;
                document.getElementById("txtODR_NM").disabled = false;

                document.getElementById("ImgStrYmd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled = true;
                document.getElementById("txtPJT_NM").disabled = true;
                document.getElementById("txtCMP_NM").disabled  = true;
                document.getElementById("txtODR_NM").disabled = true;

                document.getElementById("ImgStrYmd").disabled  = true;

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
    | 2. �̸� : dsT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_CAREER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_CAREER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_CAREER)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_CAREER.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtPJT_NM").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_CAREER Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[�������/���������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("�������/��������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_CAREER event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_CAREER event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_CAREER Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_CAREER.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtPJT_NM").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtPJT_NM").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

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
            <strong>��� ��� ����</strong>
        </td>
        <td height="25" align="right">
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
                    <col width="85 "></col>
                    <col width="175"></col>
                    <col width="97 "></col>
                    <col width="175"></col>
                    <col width="91 "></col>
                    <col width="175"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">���������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtPJT_NM" size="30" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="creamBold" rowspan="3">��������ڵ�</td>
                    <td class="padding2423" >
                        <input  id="txtCHG_CD1" name="txtCHG_CD1" maxlength="1" style="width:17%" onChange="fnc_GetCommNm('S1', 'txtCHG_CD1','txtCHG_NM1')";>
                        <input  id="txtCHG_NM1" name="txtCHG_NM1" style="width:60%"  class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHG_Cd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCHG_Cd1" name="ImgCHG_Cd1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtCHG_CD1','txtCHG_NM1','������ ��з�','S1')"></a>
                    </td>

                </tr>
                <tr>
                    <input type=hidden id="ENO_NO" size="10">
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','70','52');"></a>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgENDYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgENDYmd" name="ImgENDYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','70','52');"></a>
                    </td>
<!--                     <td align="center" class="creamBold">��������ڵ�2</td> -->
                    <td class="padding2423" >
                        <input  id="txtCHG_CD2" name="txtCHG_CD2" maxlength="2" style="width:17%" onChange="fnc_GetCommNm('S2', 'txtCHG_CD2','txtCHG_NM2')";>
                        <input  id="txtCHG_NM2" name="txtCHG_NM2" style="width:60%"  class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHG_Cd2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCHG_Cd2" name="ImgCHG_Cd2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtCHG_CD2','txtCHG_NM2','������ �ߺз�','S2')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">����ó</td>
                    <td class="padding2423" >
                        <input id="txtODR_NM" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">�Ҽӻ�</td>
                    <td class="padding2423" >
                        <input id="txtCMP_NM" maxlength="20" style="width:100%">
                    </td>
<!--                     <td align="center" class="creamBold">��������ڵ�3</td> -->
                    <td class="padding2423" >
                        <input  id="txtCHG_CD3" name="txtCHG_CD3" maxlength="4" style="width:17%" onChange="fnc_GetCommNm('S3', 'txtCHG_CD3','txtCHG_NM3')";>
                        <input  id="txtCHG_NM3" name="txtCHG_NM3" style="width:60%"  class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHG_Cd3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCHG_Cd3" name="ImgCHG_Cd3" width="21" height="20" border="0" align="absmiddle" onClick="fnc_careerCodePopup('txtCHG_CD3','txtCHG_NM3','������ �Һз�','S3','txtCHG_CD2')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO" maxlength="10" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423" >
                        <input id="txtJOB_NM" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423" >
                        <input id="txtREMARK" size="20" maxlength="60" style="width:100%">
                    </td>
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
                        <object id="grdT_CM_CAREER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:188px;">
                            <param name="DataID"                  value="dsT_CM_CAREER">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'         align=center    	</C>
                                <C> id=PJT_NM          width=300  name='���������'                  	</C>
                                <C> id=STR_YMD         width=80   name='��������'     align=center 		</C>
                                <C> id=END_YMD         width=80   name='��������'     align=center	 	</C>
                                <C> id=ODR_NM          width=150  name='����ó'                     	</C>
                                <C> id=CMP_NM          width=150  name='�Ҽӻ�'                    		</C>
                                <C> id=JOB_NM          width=100  name='����'                    		</C>
                                <C> id=CHG_CD1         width=40	  name='CD1'          align=center    	</C>
                                <C> id=CHG_NM1         width=100  name='���� ��з�'                  	</C>
                                <C> id=CHG_CD2         width=40	  name='CD2'          align=center     	</C>
                                <C> id=CHG_NM2         width=100  name='���� �ߺз�'                   	</C>
                                <C> id=CHG_CD3         width=40	  name='CD3'          align=center     	</C>
                                <C> id=CHG_NM3         width=150  name='���� �Һз�'                   	</C>
                                <C> id=REMARK          width=300  name='���'                    		</C>

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
"ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, ODR_NM:STRING, ATT_SBJ:STRING:KEYVALUETYPE,  CMP_NM:STRING"
**************************************************************
-->
<!-- �����°��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_CAREER">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=PJT_NM        Ctrl=txtPJT_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=ODR_NM        Ctrl=txtODR_NM       Param=value </C>
        <C> Col=CMP_NM        Ctrl=txtCMP_NM       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=CHG_CD1       Ctrl=txtCHG_CD1      Param=value </C>
        <C> Col=CHG_NM1       Ctrl=txtCHG_NM1      Param=value </C>
        <C> Col=CHG_CD2       Ctrl=txtCHG_CD2      Param=value </C>
        <C> Col=CHG_NM2       Ctrl=txtCHG_NM2      Param=value </C>
        <C> Col=CHG_CD3       Ctrl=txtCHG_CD3      Param=value </C>
        <C> Col=CHG_NM3       Ctrl=txtCHG_NM3      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
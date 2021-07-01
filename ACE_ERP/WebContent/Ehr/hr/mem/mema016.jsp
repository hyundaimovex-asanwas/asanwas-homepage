<!--
    ************************************************************************************
    * @Source         : mema016.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
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

            dsT_ME_FAMILY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema016.cmd.MEMA016CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_FAMILY.Reset();

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

                trT_ME_FAMILY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema016.cmd.MEMA016CMD&S_MODE=SAV";
                trT_ME_FAMILY.post();

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
            if (dsT_ME_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_FAMILY.RowStatus(dsT_ME_FAMILY.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_ME_FAMILY.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("����[" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"REL_NM") + "] [" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"ENO_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            dsT_ME_FAMILY.DeleteRow(dsT_ME_FAMILY.RowPosition);

            if (status != 1) {

                trT_ME_FAMILY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema016.cmd.MEMA016CMD&S_MODE=DEL";
                trT_ME_FAMILY.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_ME_FAMILY.SetColumn(form1.grdT_ME_FAMILY.GetColumnID(0));
            form1.grdT_ME_FAMILY.Focus();

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
            if (dsT_ME_FAMILY.CountColumn == 0) {
                dsT_ME_FAMILY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, REL_CD:STRING:KEYVALUETYPE, REL_NM:STRING, ENO_NM:STRING:KEYVALUETYPE,  BIR_YMD:STRING, EDGR_CD:STRING, EDGR_NM:STRING, OCC_NAM:STRING, JOB_CD:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_FAMILY.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_FAMILY.setColumn(form1.grdT_ME_FAMILY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtREL_CD").disabled = false;
            document.getElementById("txtENO_NM").disabled = false;
            document.getElementById("ImgRelCd").disabled  = false;

            document.getElementById("txtREL_CD").focus();
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

			dsT_ME_FAMILY.ClearData();
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
            if (!dsT_ME_FAMILY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_FAMILY.CountRow; i++ ) {
                if ( dsT_ME_FAMILY.RowStatus(i) == 1 ||
                     dsT_ME_FAMILY.RowStatus(i) == 3 ) {

                    // ��������
                    if( dsT_ME_FAMILY.NameValue(i, "REL_CD") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return false;
                    }

                    // ����
                    if( dsT_ME_FAMILY.NameValue(i, "ENO_NM") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtENO_NM").focus();
                        return false;
                    }

                    // ������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_FAMILY.NameValue(i, "BIR_YMD"), "�������") && dsT_ME_FAMILY.NameValue(i, "BIR_YMD") != "") {
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtBIR_YMD").focus();
                        return false;
                    }

                    // ��������
                    if (dsT_ME_FAMILY.NameValue(i, "REL_CD") != "" &&
                        dsT_ME_FAMILY.NameValue(i, "REL_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return;
                    }

                    // �з��ڵ�
                    if (dsT_ME_FAMILY.NameValue(i, "EDGR_CD") != "" &&
                        dsT_ME_FAMILY.NameValue(i, "EDGR_NM") == "") {
                        alert("�з��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return;
                    }

                    if ( dsT_ME_FAMILY.RowStatus(i) == 1) {
                       document.getElementById("txtREL_CD").disabled = true;
                       document.getElementById("txtENO_NM").disabled = true;
                       document.getElementById("ImgRelCd").disabled  = true;
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
            cfStyleGrid(form1.grdT_ME_FAMILY, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_ME_FAMILY.IsUpdated)  {
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
                document.getElementById("txtREL_CD").disabled  = false;
                document.getElementById("txtREL_NM").disabled  = false;
                document.getElementById("txtENO_NM").disabled  = false;
                document.getElementById("txtBIR_YMD").disabled = false;
                document.getElementById("txtEDGR_CD").disabled = false;
                document.getElementById("txtEDGR_NM").disabled = false;
                document.getElementById("txtOCC_NAM").disabled = false;
                document.getElementById("txtJOB_CD").disabled  = false;

                document.getElementById("ImgRelCd").disabled   = false;
                document.getElementById("ImgBirYmd").disabled  = false;
                document.getElementById("ImgEdgrCd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtREL_CD").disabled  = true;
                document.getElementById("txtREL_NM").disabled  = true;
                document.getElementById("txtENO_NM").disabled  = true;
                document.getElementById("txtBIR_YMD").disabled = true;
                document.getElementById("txtEDGR_CD").disabled = true;
                document.getElementById("txtEDGR_NM").disabled = true;
                document.getElementById("txtOCC_NAM").disabled = true;
                document.getElementById("txtJOB_CD").disabled  = true;

                document.getElementById("ImgRelCd").disabled   = true;
                document.getElementById("ImgBirYmd").disabled  = true;
                document.getElementById("ImgEdgrCd").disabled  = true;

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
    | 2. �̸� : dsT_ME_FAMILY                       |
    | 3. Table List : T_ME_FAMILY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_FAMILY                       |
    | 3. Table List : T_ME_FAMILY                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_FAMILY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_FAMILY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_FAMILY.CountRow);

            document.getElementById("txtREL_CD").disabled = true;
            document.getElementById("txtENO_NM").disabled = true;
            document.getElementById("ImgRelCd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_FAMILY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_FAMILY Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[��������/��������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("��������/�������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_FAMILY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_FAMILY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_FAMILY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_FAMILY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtREL_CD").disabled = false;
            document.getElementById("txtENO_NM").disabled = false;
            document.getElementById("ImgRelCd").disabled  = false;
        }
        else {
            document.getElementById("txtREL_CD").disabled = true;
            document.getElementById("txtENO_NM").disabled = true;
            document.getElementById("ImgRelCd").disabled  = true;

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
            <strong>��������</strong>
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
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtREL_CD" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('G1', 'txtREL_CD','txtREL_NM');"> <input id="txtREL_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRelCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRelCd" name="ImgRelCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREL_CD','txtREL_NM','��������','G1')"></a>
                    </td>
                    <td align="center" maxlength="12" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtBIR_YMD" style="width:75%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBirYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgBirYmd" name="ImgBirYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtBIR_YMD','','415','53');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�з��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('E1', 'txtEDGR_CD','txtEDGR_NM');"> <input id="txtEDGR_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEdgrCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEdgrCd" name="ImgEdgrCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEDGR_CD','txtEDGR_NM','�з±���','E1')"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtOCC_NAM" maxlength="30" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" maxlength="20" style="width:100%">
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
                        <object id="grdT_ME_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:178px;">
                            <param name="DataID"                  value="dsT_ME_FAMILY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=50   name='����'         align=center </C>
                                <C> id=REL_CD          width=90   name='�����ڵ�'     align=center </C>
                                <C> id=REL_NM          width=90   name='����'                      </C>
                                <C> id=ENO_NM          width=90   name='����'                      </C>
                                <C> id=BIR_YMD         width=90   name='�������'     align=center </C>
                                <C> id=EDGR_CD         width=90   name='�з��ڵ�'     align=center </C>
                                <C> id=EDGR_NM         width=90   name='�з�'                      </C>
                                <C> id=OCC_NAM         width=90   name='�ٹ�ó'                    </C>
                                <C> id=JOB_CD          width=90   name='����'                      </C>
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
<!-- �������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_FAMILY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=REL_CD        Ctrl=txtREL_CD       Param=value </C>
        <C> Col=REL_NM        Ctrl=txtREL_NM       Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM       Param=value </C>
        <C> Col=BIR_YMD       Ctrl=txtBIR_YMD      Param=value </C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD      Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM      Param=value </C>
        <C> Col=OCC_NAM       Ctrl=txtOCC_NAM      Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
    '>
</object>
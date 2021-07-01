<!--
    ************************************************************************************
    * @Source         : pira027.jsp                                                    		*
    * @Description    : ���м��� PAGE                                                  		*
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
<title>���м���</title>
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

            dsT_CM_EXAMINATION.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira027.cmd.PIRA027CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_EXAMINATION.Reset();

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

                trT_CM_EXAMINATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira027.cmd.PIRA027CMD&S_MODE=SAV";
                trT_CM_EXAMINATION.post();

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
            if (dsT_CM_EXAMINATION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_EXAMINATION.RowStatus(dsT_CM_EXAMINATION.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_EXAMINATION.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("��������[" + dsT_CM_EXAMINATION.NameValue(dsT_CM_EXAMINATION.RowPosition,"PRO_YMD") + "], �������[" + dsT_CM_EXAMINATION.NameValue(dsT_CM_EXAMINATION.RowPosition, "SBJ_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_EXAMINATION.DeleteRow(dsT_CM_EXAMINATION.RowPosition);

            if (status != 1) {
                trT_CM_EXAMINATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira027.cmd.PIRA027CMD&S_MODE=DEL";
                trT_CM_EXAMINATION.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_EXAMINATION.SetColumn(form1.grdT_CM_EXAMINATION.GetColumnID(0));
            form1.grdT_CM_EXAMINATION.Focus();

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
            if (dsT_CM_EXAMINATION.CountColumn == 0) {
                dsT_CM_EXAMINATION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, PRO_YMD:STRING:KEYVALUETYPE, INT_NAM:STRING, SBJ_CD:STRING:KEYVALUETYPE, SBJ_NM:STRING, SBJ_LSN:INT, SBJ_RED:INT, SBJ_SPC:INT, SBJ_VOC:INT, SBJ_IPT:INT, SBJ_TOT:INT, SBJ_ETC:INT, TTL_AVR:INT, GRADE:STRING, SBJ_AMT:INT, REMARK:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_EXAMINATION.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_EXAMINATION.setColumn(form1.grdT_CM_EXAMINATION.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtPRO_YMD").disabled = false;
            document.getElementById("ImgProYmd").disabled  = false;
            document.getElementById("txtPRO_YMD").focus();

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

			dsT_CM_EXAMINATION.ClearData();
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
            if (!dsT_CM_EXAMINATION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_EXAMINATION.CountRow; i++ ) {
                if ( dsT_CM_EXAMINATION.RowStatus(i) == 1 ||
                     dsT_CM_EXAMINATION.RowStatus(i) == 3 ) {


                    // ��������
                    if( dsT_CM_EXAMINATION.NameValue(i, "PRO_YMD") == '' ) {
                        alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_EXAMINATION.RowPosition = i;
                        document.getElementById("txtPRO_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_EXAMINATION.NameValue(i, "PRO_YMD"), "��������") && dsT_CM_EXAMINATION.NameValue(i, "PRO_YMD") != "") {
                        dsT_CM_EXAMINATION.RowPosition = i;
                        document.getElementById("txtPRO_YMD").focus();
                        return false;
                    }

                    // �����ڵ�
                    if( dsT_CM_EXAMINATION.NameValue(i, "SBJ_CD") == '' ) {
                        alert("�����ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_EXAMINATION.RowPosition = i;
                        document.getElementById("cmbSBJ_CD").focus();
                        return false;
                    }

                    if ( dsT_CM_EXAMINATION.RowStatus(i) == 1) {
                       document.getElementById("txtPRO_YMD").disabled = true;
                       document.getElementById("ImgProYmd").disabled  = true;
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
            cfStyleGrid_New(form1.grdT_CM_EXAMINATION, 0,"false","false");

            //�����ڵ�
            for( var i = 1; i <= dsCOMMON_M1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_M1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_M1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSBJ_CD").add(oOption);

            }

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_EXAMINATION.IsUpdated)  {
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
                document.getElementById("txtPRO_YMD").disabled = false;
                document.getElementById("txtINT_NAM").disabled = false;
                document.getElementById("cmbSBJ_CD").disabled  = false;
                document.getElementById("txtSBJ_LSN").disabled = false;
                document.getElementById("txtSBJ_RED").disabled = false;
                document.getElementById("txtSBJ_SPC").disabled = false;
                document.getElementById("txtSBJ_VOC").disabled = false;
                document.getElementById("txtSBJ_IPT").disabled = false;
                document.getElementById("txtSBJ_TOT").disabled = false;
                document.getElementById("txtSBJ_ETC").disabled = false;
                document.getElementById("txtTTL_AVR").disabled = false;
                document.getElementById("txtGRADE").disabled   = false;
                form1.medSBJ_AMT.enable                        = true;
                document.getElementById("txtREMARK").disabled  = false;

                document.getElementById("ImgProYmd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtPRO_YMD").disabled = true;
                document.getElementById("txtINT_NAM").disabled = true;
                document.getElementById("cmbSBJ_CD").disabled  = true;
                document.getElementById("txtSBJ_LSN").disabled = true;
                document.getElementById("txtSBJ_RED").disabled = true;
                document.getElementById("txtSBJ_SPC").disabled = true;
                document.getElementById("txtSBJ_VOC").disabled = true;
                document.getElementById("txtSBJ_IPT").disabled = true;
                document.getElementById("txtSBJ_TOT").disabled = false;
                document.getElementById("txtSBJ_ETC").disabled = true;
                document.getElementById("txtTTL_AVR").disabled = true;
                document.getElementById("txtGRADE").disabled   = true;
                form1.medSBJ_AMT.enable                        = false;
                document.getElementById("txtREMARK").disabled  = true;

                document.getElementById("ImgProYmd").disabled  = true;

            }
        }

        /********************************************
         * TTL_AVR �հ豸�ؼ� �ֱ�                         *
         ********************************************/
        function fnc_sbjSum(){
            var sbj_lsn = document.getElementById("txtSBJ_LSN").value;
            var sbj_red = document.getElementById("txtSBJ_RED").value;
            var sbj_spc = document.getElementById("txtSBJ_SPC").value;
            var sbj_voc = document.getElementById("txtSBJ_VOC").value;
            var sbj_ipt = document.getElementById("txtSBJ_IPT").value;
            var sbj_tot = document.getElementById("txtSBJ_TOT").value;
            var sbj_etc = document.getElementById("txtSBJ_ETC").value;

            if( sbj_lsn == "" ){ sbj_lsn = 0; }
            if( sbj_red == "" ){ sbj_red = 0; }
            if( sbj_spc == "" ){ sbj_spc = 0; }
            if( sbj_voc == "" ){ sbj_voc = 0; }
            if( sbj_ipt == "" ){ sbj_ipt = 0; }
            if( sbj_tot == "" ){ sbj_tot = 0; }
            if( sbj_etc == "" ){ sbj_etc = 0; }

            var sbjSum = eval( sbj_lsn+"+"+sbj_red+"+"+sbj_spc+"+"+sbj_voc+"+"+sbj_ipt+"+"+sbj_tot+"+"+sbj_etc )+"";


           if  (document.getElementById("cmbSBJ_CD").value != "E5")
                document.getElementById("txtTTL_AVR").value = sbjSum;
        }

        function fnc_ChgEnabled(){

           if (document.getElementById("cmbSBJ_CD").value == "E5"){
               document.getElementById("txtTTL_AVR").readOnly = false;
               document.getElementById("txtTTL_AVR").className = "";
           }
           else {
               document.getElementById("txtTTL_AVR").readOnly = true;
               document.getElementById("txtTTL_AVR").className = "input_ReadOnly";
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
    | 2. �̸� : dsT_CM_EXAMINATION                  |
    | 3. Table List : T_CM_EXAMINATION              |
    +----------------------------------------------->
    <Object ID="dsT_CM_EXAMINATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_EXAMINATION                  |
    | 3. Table List : T_CM_EXAMINATION              |
    +----------------------------------------------->
    <Object ID ="trT_CM_EXAMINATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_EXAMINATION)">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �������� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_M1"/>
       <jsp:param name="CODE_GUBUN"    value="M1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EXAMINATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_EXAMINATION.CountRow);

            document.getElementById("txtPRO_YMD").disabled = true;
            document.getElementById("ImgProYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_EXAMINATION Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EXAMINATION Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[��������/�������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("��������/������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_EXAMINATION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_EXAMINATION event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_EXAMINATION Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_EXAMINATION.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtPRO_YMD").disabled = false;
            document.getElementById("ImgProYmd").disabled  = false;

        }
        else {
            document.getElementById("txtPRO_YMD").disabled = true;
            document.getElementById("ImgProYmd").disabled  = true;

        }

        fnc_ChgEnabled();

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
            <strong>���м���</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">   <img src="../../images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtPRO_YMD" style="width:73%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgProYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgProYmd"  name="ImgProYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtPRO_YMD','','75','53');"></a>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <select id="cmbSBJ_CD" style="width:100%" disabled onchange="fnc_ChgEnabled();" onblur="fnc_ChgEnabled"></select>
                    </td>
                    <td align="center" class="blueBold">û&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtSBJ_LSN" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" onblur="fnc_sbjSum()" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtSBJ_RED" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" onblur="fnc_sbjSum()" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtSBJ_SPC" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" onblur="fnc_sbjSum()" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtSBJ_VOC" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" onblur="fnc_sbjSum()" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtSBJ_IPT" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" onblur="fnc_sbjSum()" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtSBJ_TOT" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" onblur="fnc_sbjSum()" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;Ÿ</td>
                    <td class="padding2423" >
                        <input id="txtSBJ_ETC" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" onblur="fnc_sbjSum()" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtTTL_AVR" maxlength="4" style="width:100%;ime-mode:disabled;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtGRADE" maxlength="10" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtINT_NAM" maxlength="22" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������÷�</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td width="90%"">
                                    <comment id="__NSID__"><object id="medSBJ_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left">��
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtREMARK" maxlength="60" style="width:100%">
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
                        <object id="grdT_CM_EXAMINATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_EXAMINATION">
                            <param name="Editable"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="ColSizing"               value="true">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'         align=center </C>
                                <C> id=PRO_YMD         width=70   name='��������'     align=center </C>
                                <C> id=SBJ_CD          width=60   name='�����ڵ�'     align=center </C>
                                <C> id=SBJ_NM          width=70   name='��������'                  </C>
                                <C> id=SBJ_LSN         width=55   name='û��'                      </C>
                                <C> id=SBJ_RED         width=55   name='�ʱ�'                      </C>
                                <C> id=SBJ_SPC         width=55   name='���ϱ�'                    </C>
                                <C> id=SBJ_VOC         width=55   name='����'                      </C>
                                <C> id=SBJ_IPT         width=55   name='����'                      </C>
                                <C> id=SBJ_TOT         width=55   name='����'                      </C>
                                <C> id=SBJ_ETC         width=55   name='��Ÿ'                      </C>
                                <C> id=TTL_AVR         width=55   name='�հ�'                      </C>
                                <C> id=GRADE           width=55   name='�޼�'                      </C>
                                <C> id=INT_NAM         width=80  name='����ó'                    </C>
                                <C> id=SBJ_AMT         width=80   name='�������÷�'                </C>
                                <C> id=REMARK          width=80  name='���'                      </C>
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
<!-- ���м��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_EXAMINATION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=PRO_YMD       Ctrl=txtPRO_YMD      Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=INT_NAM       Ctrl=txtINT_NAM      Param=value </C>
        <C> Col=SBJ_CD        Ctrl=cmbSBJ_CD       Param=value </C>
        <C> Col=SBJ_LSN       Ctrl=txtSBJ_LSN      Param=value </C>
        <C> Col=SBJ_RED       Ctrl=txtSBJ_RED      Param=value </C>
        <C> Col=SBJ_SPC       Ctrl=txtSBJ_SPC      Param=value </C>
        <C> Col=SBJ_VOC       Ctrl=txtSBJ_VOC      Param=value </C>
        <C> Col=SBJ_IPT       Ctrl=txtSBJ_IPT      Param=value </C>
        <C> Col=SBJ_TOT       Ctrl=txtSBJ_TOT      Param=value </C>
        <C> Col=SBJ_ETC       Ctrl=txtSBJ_ETC      Param=value </C>
        <C> Col=TTL_AVR       Ctrl=txtTTL_AVR      Param=value </C>
        <C> Col=GRADE         Ctrl=txtGRADE        Param=value </C>
        <C> Col=SBJ_AMT       Ctrl=medSBJ_AMT      Param=text  </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>
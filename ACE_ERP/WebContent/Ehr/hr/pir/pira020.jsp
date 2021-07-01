<!--
    ************************************************************************************
    * @Source         : pira020.jsp                                                    *
    * @Description    : �ڰݸ��� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�ڰݸ���</title>
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
    String p_mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
    String p_srcid = request.getParameter("srcid") != null ? request.getParameter("srcid") : "";
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >
    
        var p_mode = "<%=p_mode %>";
        var p_srcid = "<%=p_srcid %>";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_QUALIFICATION.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_QUALIFICATION.Reset();
            
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

                trT_CM_QUALIFICATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=SAV";
                trT_CM_QUALIFICATION.post();

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
            if (dsT_CM_QUALIFICATION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_QUALIFICATION.RowStatus(dsT_CM_QUALIFICATION.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_QUALIFICATION.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�ڰݸ���[" + dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"QUA_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_QUALIFICATION.DeleteRow(dsT_CM_QUALIFICATION.RowPosition);

            if (status != 1) {
                trT_CM_QUALIFICATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=DEL";
                trT_CM_QUALIFICATION.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_QUALIFICATION.SetColumn(form1.grdT_CM_QUALIFICATION.GetColumnID(0));
            form1.grdT_CM_QUALIFICATION.Focus();

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
            if (dsT_CM_QUALIFICATION.CountColumn == 0) {
                dsT_CM_QUALIFICATION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE,QUA_CD:STRING:KEYVALUETYPE,QUA_NM:STRING,GAN_YMD:STRING:KEYVALUETYPE,QUA_NO:STRING,APP_ADM:STRING,ETG_YN:STRING,QUA_AMT:DECIMAL");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_QUALIFICATION.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_QUALIFICATION.setColumn(form1.grdT_CM_QUALIFICATION.getColumnID(0));    
            
            dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
            dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"QUA_CD") = ' ';            
            dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"GAN_YMD") = ' ';            

            
            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtQUA_CD").disabled  = false;
            document.getElementById("ImgQuaCd").disabled   = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;
            document.getElementById("cmbETG_YN").value = "X";
            document.getElementById("txtQUA_CD").focus();
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

			dsT_CM_QUALIFICATION.ClearData();
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
            if (!dsT_CM_QUALIFICATION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_QUALIFICATION.CountRow; i++ ) {
                if ( dsT_CM_QUALIFICATION.RowStatus(i) == 1 ||
                     dsT_CM_QUALIFICATION.RowStatus(i) == 3 ) {


                    // �ڰݸ���
                    if( dsT_CM_QUALIFICATION.NameValue(i, "QUA_CD") == '' ) {
                        alert("�ڰݸ���� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtQUA_CD").focus();
                        return false;
                    }

                    // �ڰݸ���
                    if (dsT_CM_QUALIFICATION.NameValue(i, "QUA_CD") != "" &&
                        dsT_CM_QUALIFICATION.NameValue(i, "QUA_NM") == "") {
                        alert("�ڰݸ����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtQUA_CD").focus();
                        return;
                    }

                    // �������
                    if( dsT_CM_QUALIFICATION.NameValue(i, "GAN_YMD") == '' ) {
                        alert("������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtGAN_YMD").focus();
                        return false;
                    }

                    // ������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_QUALIFICATION.NameValue(i, "GAN_YMD"), "�������") && dsT_CM_QUALIFICATION.NameValue(i, "GAN_YMD") != "") {
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtGAN_YMD").focus();
                        return false;
                    }


                    if ( dsT_CM_QUALIFICATION.RowStatus(i) == 1) {
                       document.getElementById("txtQUA_CD").disabled   = true;
                       document.getElementById("ImgQuaCd").disabled    = true;
                       document.getElementById("txtGAN_YMD").disabled  = true;
                       document.getElementById("ImgGanYmd").disabled   = true;
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
            cfStyleGrid_New(form1.grdT_CM_QUALIFICATION, 0,"false","false");

            fnc_SearchList();

            //�������� ��ȸ�� ó��
            if(p_mode == "read" || p_srcid == 'pirc010'){
                document.getElementById("txtGAN_YMD").className = "input_ReadOnly";
                document.getElementById("txtGAN_YMD").readOnly     = true;
                document.getElementById("txtQUA_NO").className = "input_ReadOnly";
                document.getElementById("txtQUA_NO").readOnly     = true;
                document.getElementById("txtAPP_ADM").className = "input_ReadOnly";
                document.getElementById("txtAPP_ADM").readOnly     = true;
                document.getElementById("cmbETG_YN").disabled  = true;

                document.getElementById("ImgQuaCd").style.display = "none";
                document.getElementById("ImgGanYmd").style.display = "none";
                document.getElementById("ImgAdd").style.display = "none";
                document.getElementById("imgSave").style.display = "none";
                document.getElementById("imgClear").style.display = "none";
                document.getElementById("imgDelete").style.display = "none";

				//�������� �����
                document.getElementById("cmbETG_YN").style.display = "none";
                document.getElementById("txtETG_YN").style.display = "none";
                //form1.grdT_CM_QUALIFICATION.ColumnProp("ETG_YN1","Show") = false;
            }

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

                document.getElementById("txtQUA_CD").disabled  = false;
                document.getElementById("txtQUA_NM").disabled  = false;
                document.getElementById("txtGAN_YMD").disabled = false;
                document.getElementById("txtQUA_NO").disabled  = false;
                document.getElementById("txtAPP_ADM").disabled = false;
                document.getElementById("cmbETG_YN").disabled  = false;
                document.getElementById("ImgQuaCd").disabled    = false;
                document.getElementById("ImgGanYmd").disabled   = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("txtQUA_CD").disabled  = true;
                document.getElementById("txtQUA_NM").disabled  = true;
                document.getElementById("txtGAN_YMD").disabled = true;
                document.getElementById("txtQUA_NO").disabled  = true;
                document.getElementById("txtAPP_ADM").disabled = true;
                document.getElementById("cmbETG_YN").disabled  = true;
                document.getElementById("ImgQuaCd").disabled    = true;
                document.getElementById("ImgGanYmd").disabled   = true;

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
    | 2. �̸� : dsT_CM_QUALIFICATION                |
    | 3. Table List : T_CM_QUALIFICATION            |
    +----------------------------------------------->
    <Object ID="dsT_CM_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_QUALIFICATION                |
    | 3. Table List : T_CM_QUALIFICATION            |
    +----------------------------------------------->
    <Object ID ="trT_CM_QUALIFICATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_QUALIFICATION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_QUALIFICATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_QUALIFICATION.CountRow);

            document.getElementById("txtQUA_CD").disabled   = true;
            document.getElementById("ImgQuaCd").disabled    = true;
            document.getElementById("txtGAN_YMD").disabled  = true;
            document.getElementById("ImgGanYmd").disabled   = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_QUALIFICATION Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_QUALIFICATION Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

            //alert("�ش� �ʼ��Է��׸�[�ڰݸ����ڵ�/�����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019 ) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

            alert("�ڰݸ����ڵ�/����Ͽ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("�ڰݸ����ڵ�/����Ͽ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_QUALIFICATION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_QUALIFICATION event="OnFail()">

        cfErrorMsg(this);

    </script>


    <script language=JavaScript for=dsT_CM_QUALIFICATION Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_QUALIFICATION.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

        }
        else {
            document.getElementById("txtQUA_CD").disabled   = true;
            document.getElementById("ImgQuaCd").disabled    = true;
            document.getElementById("txtGAN_YMD").disabled  = true;
            document.getElementById("ImgGanYmd").disabled   = true;

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
            <strong>�ڰݸ���</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�ڰݸ���</td>
                    <td class="padding2423">
                        <input id="txtQUA_CD" style="width:22%" maxlength="3" onChange="fnc_GetCommNm('H1', 'txtQUA_CD','txtQUA_NM');"> <input id="txtQUA_NM" style="width:58%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgQuaCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgQuaCd" name="ImgQuaCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtQUA_CD','txtQUA_NM','�ڰݸ���','H1')"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtGAN_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�����');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGanYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGanYmd" name="ImgGanYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGAN_YMD','','340','52');"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtAPP_ADM" maxlength="50" style="width:100%">
                    </td>                    
                </tr>
                <tr>
                    <td align="center" class="blueBold">������ȣ</td>
                    <td class="padding2423" >
                        <input id="txtQUA_NO" maxlength="50" style="width:100%">
                    </td>                
                    <td align="center" class="blueBold"><span id="txtETG_YN">��������</span></td>
                    <td class="padding2423">
                        <select id="cmbETG_YN" style="width:100%" >
                            <option value="" ></option>
                            <option value="0" >��</option>
                            <option value="3" >��</option>
                            <option value="1" >1��</option>
                            <option value="2" >2��</option>
                            <option value="6" >Ư��</option>
                            <option value="4" >����</option>
                            <option value="5" >�Ϲ�</option>
                        </select>
                    </td>                
                    <td align="center" class="blueBold">�� �� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtQUA_AMT" style="width:83%;ime-mode:disabled" maxlength="10" >
                    </td>
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
                        <object id="grdT_CM_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:290px;">
                            <param name="DataID"                  value="dsT_CM_QUALIFICATION">
                            <param name="ViewSummary"  		value="1">
                            <param name="Format"                  value="
                                <C> id={currow}           width=42   	name='����'         	align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=QUA_CD           width=80   	name='�ڰݸ����ڵ�' 	align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=QUA_NM          width=150   name='�ڰݸ���'        align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=GAN_YMD         width=90   	name='�����'       	align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=QUA_NO           width=180   name='������ȣ'       align=center     SumBgColor=#C3D0DB</C>
                                <C> id=APP_ADM          width=250   name='����ó'          align=center    SumBgColor=#C3D0DB</C>
                                <C> id=ETG_YN           width=100    name='��������'     	align=center     SumBgColor=#C3D0DB SumText='�Ѱ�' value={Decode(ETG_YN,'0','������','1','1��','2','2��','3','����','4','����','5','�Ϲ�','6','Ư��',ETG_YN)} </C>
                                <C> id=QUA_AMT         width=100    name='�ݾ�'     		align=right 	    SumBgColor=#C3D0DB SumText=@sum</C>                                
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
<!-- �ڰݸ��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_QUALIFICATION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=QUA_CD       Ctrl=txtQUA_CD       Param=value </C>
        <C> Col=QUA_NM       Ctrl=txtQUA_NM       Param=value </C>
        <C> Col=GAN_YMD      Ctrl=txtGAN_YMD      Param=value </C>
        <C> Col=APP_ADM,      Ctrl=txtAPP_ADM      Param=value </C>        
        <C> Col=QUA_NO       Ctrl=txtQUA_NO       Param=value </C>
        <C> Col=ETG_YN         Ctrl=cmbETG_YN       Param=value </C>
        <C> Col=QUA_AMT      Ctrl=txtQUA_AMT       Param=value </C>
    '>
</object>
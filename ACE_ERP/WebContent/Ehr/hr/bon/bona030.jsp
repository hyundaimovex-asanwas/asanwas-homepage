<!--
    ************************************************************************************
    * @source         : bona030.jsp 				                                                                                     *
    * @description   : ��������Ȳ PAGE.                                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/16  |  ������   | �����ۼ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��������Ȳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���
			//var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var SAL_GBN_SHR = document.getElementById("txtSAL_GBN_SHR").value; // �޻󿩱���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ

			//�ش����� ������ ��ȸ����.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}
			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

            //�����ͼ� ����
			if(document.tabBONA030.ActiveIndex==1){
	            dsT_CP_PAYMASTER_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_01&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_01.Reset();
			}else if(document.tabBONA030.ActiveIndex==3){
	            dsT_CP_PAYMASTER_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_02&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_02.Reset();
			}else if(document.tabBONA030.ActiveIndex==5){
	            dsT_CP_PAYMASTER_03.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_03.Reset();
			}else if(document.tabBONA030.ActiveIndex==7){
	            dsT_CP_PAYMASTER_04.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_04&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_04.Reset();
			}else if(document.tabBONA030.ActiveIndex==2){
	            dsT_CP_PAYMASTER_05.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_05&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_05.Reset();
			}else if(document.tabBONA030.ActiveIndex==4){
	            dsT_CP_PAYMASTER_06.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_06&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_06.Reset();
			}else if(document.tabBONA030.ActiveIndex==6){
	            dsT_CP_PAYMASTER_07.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_07&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_07.Reset();
            }

        }

		/***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

        }

		/******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			if(document.tabBONA030.ActiveIndex==1){
	            if (dsT_CP_PAYMASTER_01.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_01.GridToExcel("��������������Ȳ", '', 225);

			}else if(document.tabBONA030.ActiveIndex==3){
	            if (dsT_CP_PAYMASTER_02.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_02.GridToExcel("�ߵ��Ի�����Ȳ", '', 225);

			}else if(document.tabBONA030.ActiveIndex==5){
	            if (dsT_CP_PAYMASTER_03.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_03.GridToExcel("���°�������Ȳ", '', 225);

			}else if(document.tabBONA030.ActiveIndex==7){
	            if (dsT_CP_PAYMASTER_04.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_04.GridToExcel("¡�谨������Ȳ", '', 225);

			}else if(document.tabBONA030.ActiveIndex==2){
	            if (dsT_CP_PAYMASTER_05.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_05.GridToExcel("�μ�����������Ȳ", '', 225);

			}else if(document.tabBONA030.ActiveIndex==4){
	            if (dsT_CP_PAYMASTER_06.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_06.GridToExcel("������������Ȳ", '', 225);

			}else if(document.tabBONA030.ActiveIndex==6){
	            if (dsT_CP_PAYMASTER_07.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_07.GridToExcel("������������Ȳ", '', 225);
			}

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			//ȭ���ħ���� �ӽ� �ذ�
			document.tabBONA030.ActiveIndex=2;
			document.tabBONA030.ActiveIndex=1;

			dsT_CP_PAYMASTER_01.ClearData();
			dsT_CP_PAYMASTER_02.ClearData();
			dsT_CP_PAYMASTER_03.ClearData();
			dsT_CP_PAYMASTER_04.ClearData();
			dsT_CP_PAYMASTER_05.ClearData();
			dsT_CP_PAYMASTER_06.ClearData();
			dsT_CP_PAYMASTER_07.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = ""; // �ٷα��б���
			//document.getElementById("cmbSAL_GBN_SHR").value = "";
			document.getElementById("cmbSEQ_SHR").value = "1";
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_PAYMASTER_01.IsUpdated || dsT_CP_PAYMASTER_02.IsUpdated || dsT_CP_PAYMASTER_03.IsUpdated || dsT_CP_PAYMASTER_04.IsUpdated ||
	            dsT_CP_PAYMASTER_05.IsUpdated || dsT_CP_PAYMASTER_06.IsUpdated || dsT_CP_PAYMASTER_07.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_CP_PAYMASTER.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//�ֱ� ������ �ش��� ��ȸ - ���κ��޿����װ��� Ŭ���� ����
			dsT_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga020.cmd.SAGA020CMD&S_MODE=SHR_01";
			dsT_CP_PAYMASTER.Reset();

			//���� ��� �����¸� �����°� ����
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(PIS_YYMM_SHR.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}

			//�ٷα���
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

			//ȭ���ħ���� �ӽ� �ذ�
			document.tabBONA030.ActiveIndex=2;
			document.tabBONA030.ActiveIndex=1;

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CP_PAYMASTER_01,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_02,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_03,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_04,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_05,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_06,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_07,0,"false","false");

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_01                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_02                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_03                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_04                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_05                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_06                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_06" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_07                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_07" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = dsT_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtPIS_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // �ش���

			document.getElementById("txtPIS_YYMM_SHR").focus();
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
        //alert(dsT_CP_PAYMASTER_01.ExportData(1, dsT_CP_PAYMASTER_01.CountRow, true));
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_04 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_05 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_06 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_07 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_04 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_05 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_06 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_07 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_04 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_05 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_06 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_07 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������Ȳ</td>
					<td align="right" class="navigator">HOME/�������/�󿩰���/<font color="#000000">��������Ȳ</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="30"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�ش���</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:80" onChange="fnc_SearchList();">
										<option value="" >��ü</option>
									</select>
								</td>
								<!--
								<td align="center" class="searchState">�޻󿩱���</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="0" >�޿�</option>
	                                    <option value="1" >��</option>
									</select>
								</td>
								-->
								<input type="hidden" id="txtSAL_GBN_SHR" value="1">
								<td align="center" class="searchState">�Ϸù�ȣ</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
								<td align="center">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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

<!-- �� ��� ���۳�Ʈ ���� -->
<comment id="__NSID__">
<object id=tabBONA030 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
		style="position:absolute; left:20; top:155; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#F8B97B">
	<param name="DisableBackColor"	value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 				value="1">

	<param name="Format"			value='
		<T>divid="tabBONA030_01"	title="������"</T>
		<T>divid="tabBONA030_05"	title="�μ���"</T>
		<T>divid="tabBONA030_02"	title="�ߵ��Ի���"</T>
		<T>divid="tabBONA030_06"	title="����������"</T>
		<T>divid="tabBONA030_03"	title="���°�����"</T>
		<T>divid="tabBONA030_07"	title="����������"</T>
		<T>divid="tabBONA030_04"	title="¡�谨����"</T>
		'>
</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!-- �� ��� ���۳�Ʈ �� -->

<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabBONA030_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:5;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_01">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="JOB_NM"				width=120		name="����"				align=center		subsumtext="�հ�"								</C>
						<C> id="ENO_CNT"			width=120		name="�ο�"				align=right		</C>
						<C> id="BAS_AMT"			width=120		name="���ޱ��ؾ�"	align=right		</C>
						<C> id="SALT_AMT"			width=120		name="�����Ѿ�"		align=right		</C>
						<C> id="PAY_PCT"				width=120		name="���޷�"			align=right		Value={Decode(CurLevel,9999,SubAvg(PAY_PCT),PAY_PCT)}		Dec=2	</C>
						<C> id="REMARK"				width=129		name="���"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��1 ���� �Է� ���̺� �� -->

<!-- ��2 ���� �Է� ���̺� ���� -->
<div class=page id="tabBONA030_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=100		name="�Ҽ�"				align=center		subsumtext="�հ�"								</C>
						<C> id="JOB_NM"				width=100		name="����"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  			</C>
						<C> id="ENO_NM"				width=100		name="����"				align=center		</C>
						<C> id="HIR_YMD"				width=100		name="�Ի���"			align=center		</C>
						<C> id="BAS_PCT"			width=100		name="���޷�"			align=right		Value={Decode(CurLevel,9999,SubAvg(BAS_PCT),BAS_PCT)}		Dec=2</C>
						<C> id="SALT_AMT"			width=115		name="�󿩱ݾ�"		align=right		</C>
						<C> id="REMARK"				width=114		name="���"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��2 ���� �Է� ���̺� �� -->

<!-- ��3 ���� �Է� ���̺� ���� -->
<div class=page id="tabBONA030_03" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=50		name="NO"			align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=100		name="�Ҽ�"			align=center		subsumtext="�հ�"								</C>
						<C> id="JOB_NM"				width=95		name="����"			align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  			</C>
						<C> id="ENO_NM"				width=95		name="����"			align=center	</C>
						<C> id="ATT_A"				width=85		name="����"			align=right		</C>
						<C> id="ATT_B"				width=85		name="����"			align=right		</C>
						<C> id="ATT_C"				width=85		name="����"			align=right		</C>
						<C> id="ATTD_PCT"			width=85		name="������"		align=right		Value={Decode(CurLevel,9999,SubAvg(ATTD_PCT),ATTD_PCT)}		Dec=2	</C>
						<C> id="REMARK"				width=98		name="���"			align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��3 ���� �Է� ���̺� �� -->

<!-- ��4 ���� �Է� ���̺� ���� -->
<div class=page id="tabBONA030_04" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_04">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=100		name="�Ҽ�"				align=center		subsumtext="�հ�"								</C>
						<C> id="JOB_NM"				width=100		name="����"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  									</C>
						<C> id="ENO_NM"				width=100		name="����"				align=center		</C>
						<C> id="PUD_PCT"			width=100		name="������"			align=right		Value={Decode(CurLevel,9999,SubAvg(PUD_PCT),PUD_PCT)}		Dec=2						</C>
						<C> id="JCD_CD"				width=114		name="¡������"		align=center		Value={Decode(JCD_CD,0,"~��",1,"��å,�������",2,"����",3,"����",4,"����/����")}				</C>
						<C> id="JCD_CNT"				width=100		name="Ƚ��"				align=right		</C>
						<C> id="REMARK"				width=115		name="���"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��4 ���� �Է� ���̺� �� -->

<!-- ��5 ���� �Է� ���̺� ���� -->
<div class=page id="tabBONA030_05" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_05">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=120		name="�Ҽ�"				align=center		subsumtext="�հ�"								</C>
						<C> id="ENO_CNT"			width=120		name="�ο�"				align=right		</C>
						<C> id="BAS_AMT"			width=120		name="���ޱ��ؾ�"	align=right		</C>
						<C> id="SALT_AMT"			width=120		name="�����Ѿ�"		align=right		</C>
						<C> id="PAY_PCT"				width=120		name="���޷�"			align=right		Value={Decode(CurLevel,9999,SubAvg(PAY_PCT),PAY_PCT)}		Dec=2	</C>
						<C> id="REMARK"				width=129		name="���"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��5 ���� �Է� ���̺� �� -->

<!-- ��6 ���� �Է� ���̺� ���� -->
<div class=page id="tabBONA030_06" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_06" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_06">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=145		name="�Ҽ�"				align=center		subsumtext="�հ�"								</C>
						<C> id="JOB_NM"				width=145		name="����"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)} 			</C>
						<C> id="ENO_NM"				width=145		name="����"				align=center		</C>
						<C> id="HIR_YMD"				width=145		name="�Ի���"			align=center		</C>
						<C> id="REMARK"				width=149		name="���"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��6 ���� �Է� ���̺� �� -->

<!-- ��7 ���� �Է� ���̺� ���� -->
<div class=page id="tabBONA030_07" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_07" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_07">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=105		name="�Ҽ�"				align=center		subsumtext="�հ�"								</C>
						<C> id="JOB_NM"				width=104		name="����"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  			</C>
						<C> id="ENO_NM"				width=105		name="����"				align=center		</C>
						<C> id="TMR_YMD"			width=105		name="��������"		align=center		</C>
						<C> id="TMR_DD"				width=105		name="�����ϼ�"		align=right		</C>
						<C> id="TRD_PCT"			width=100		name="������"			align=right		Value={Decode(CurLevel,9999,SubAvg(TRD_PCT),TRD_PCT)} Dec=2</C>
						<C> id="REMARK"				width=105		name="���"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��7 ���� �Է� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>
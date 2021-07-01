<!--
    ************************************************************************************
    * @source         : bona010.jsp 				                                   *
    * @description   : ���κ��󿩻��װ��� PAGE.                                        *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/13  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���κ��󿩻��װ���</title>
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
		var btnList = 'TFTTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var SAL_GBN_SHR = document.getElementById("txtSAL_GBN").value; // �޻󿩱���
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���
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

			//����� ������ ��ȸ ����.
			if(ENO_NO_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("����� �Է��ϼ���.");
					document.getElementById("txtENO_NO_SHR").focus();
					return false;
				}
			}

            //Ʈ����� ����
			trT_CP_PAYMASTER.KeyValue = "SVL(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
			trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona010.cmd.BONA010CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&SEQ_SHR="+SEQ_SHR;
			trT_CP_PAYMASTER.Post();

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
			if( !fnc_SaveItemCheck() )	return;

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var SAL_GBN_SHR = document.getElementById("txtSAL_GBN").value; // �޻󿩱���
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ

			//Ʈ����� ����
			tr01T_CP_PAYMASTER.KeyValue = "SVL(I:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
			tr01T_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona010.cmd.BONA010CMD&S_MODE=SAV&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&SEQ_SHR="+SEQ_SHR;
			tr01T_CP_PAYMASTER.Post();

        }

		/******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_CP_PAYMASTER.ColumnString(dsT_CP_PAYMASTER.RowPosition,1) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
            var SAL_GBN_SHR = document.getElementById("txtSAL_GBN").value; // �޻󿩱���
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���
            var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ

            dsT_CP_PAYMASTER.DeleteRow(dsT_CP_PAYMASTER.RowPosition);
            trT_CP_PAYMASTER.KeyValue = "SVL(I:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
            trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona010.cmd.BONA010CMD&S_MODE=DEL&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&SEQ_SHR="+SEQ_SHR;
            trT_CP_PAYMASTER.post();
            fnc_Clear();

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

			dsT_CP_PAYMASTER.ClearData();

			disableInput();

			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtENO_NO_SHR").value = "";
			document.getElementById("txtENO_NM_SHR").value = "";
			//document.getElementById("cmbSAL_GBN_SHR").value = "0";
			document.getElementById("cmbSEQ_SHR").value = "1";
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_PAYMASTER.IsUpdated)  {

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

        	if (!dsT_CP_PAYMASTER.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 1;
			var oPIS_YYMM;

			/*
			oPIS_YYMM = dsT_CP_PAYMASTER.NameValue(i,"PIS_YYMM");
			if(oPIS_YYMM.trim().length == 0){
				alert("�������� �߸��Ǿ����ϴ�.");
				dsT_CP_PAYMASTER.RowPosition = i;
				return false;
			}
			*/

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//�ֱ� ������ �ش��� ��ȸ
			ds01T_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona010.cmd.BONA010CMD&S_MODE=SHR_01";
			ds01T_CP_PAYMASTER.Reset();

			//���� ��� �����¸� �����°� ����
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(PIS_YYMM_SHR.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}

			disableInput();//�Է��ʵ� ��Ȱ��ȭ

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){

			document.form1.txtSOU_CNT.readOnly = false;
  			document.form1.txtSOU_CNT.className = "";
			document.form1.txtDFM_CNT.readOnly = false;
  			document.form1.txtDFM_CNT.className = "";
			document.form1.txtTRB_CNT.readOnly = false;
  			document.form1.txtTRB_CNT.className = "";
			document.form1.txtGOL_CNT.readOnly = false;
  			document.form1.txtGOL_CNT.className = "";
			document.form1.txtWCT_CNT.readOnly = false;
  			document.form1.txtWCT_CNT.className = "";
			document.form1.txtCHI_CNT.readOnly = false;
  			document.form1.txtCHI_CNT.className = "";
			document.form1.txtABA_CD.readOnly = false;
  			document.form1.txtABA_CD.className = "";
  			document.getElementById("imgABA_CD").disabled = false;
			document.form1.txtREC_NAM.readOnly = false;
  			document.form1.txtREC_NAM.className = "";
			document.form1.txtACC_NO.readOnly = false;
  			document.form1.txtACC_NO.className = "";

			form1.medBAS_PCT.Enable = "true";
			form1.medINC_PCT.Enable = "true";
            form1.medGOG_PCT.Enable = "true";
			form1.medATTD_PCT.Enable = "true";
			form1.medPUD_PCT.Enable = "true";
			form1.medTRD_PCT.Enable = "true";

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtSOU_CNT.readOnly = true;
  			document.form1.txtSOU_CNT.className = "input_ReadOnly";
			document.form1.txtDFM_CNT.readOnly = true;
  			document.form1.txtDFM_CNT.className = "input_ReadOnly";
			document.form1.txtTRB_CNT.readOnly = true;
  			document.form1.txtTRB_CNT.className = "input_ReadOnly";
			document.form1.txtGOL_CNT.readOnly = true;
  			document.form1.txtGOL_CNT.className = "input_ReadOnly";
			document.form1.txtWCT_CNT.readOnly = true;
  			document.form1.txtWCT_CNT.className = "input_ReadOnly";
			document.form1.txtCHI_CNT.readOnly = true;
  			document.form1.txtCHI_CNT.className = "input_ReadOnly";
			document.form1.txtABA_CD.readOnly = true;
  			document.form1.txtABA_CD.className = "input_ReadOnly";
  			document.getElementById("imgABA_CD").disabled = true;
			document.form1.txtREC_NAM.readOnly = true;
  			document.form1.txtREC_NAM.className = "input_ReadOnly";
			document.form1.txtACC_NO.readOnly = true;
  			document.form1.txtACC_NO.className = "input_ReadOnly";

			form1.medBAS_PCT.Enable = "false";
			form1.medINC_PCT.Enable = "false";
            form1.medGOG_PCT.Enable = "false";
			form1.medATTD_PCT.Enable = "false";
			form1.medPUD_PCT.Enable = "false";
			form1.medTRD_PCT.Enable = "false";

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
    | 2. �̸� : ds01T_CP_PAYMASTER                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_CP_PAYMASTER                                    |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : tr01T_CP_PAYMASTER                                    |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID ="tr01T_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

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
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = ds01T_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtPIS_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6);
			document.getElementById("txtPIS_YYMM_SHR").focus();
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

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�ش���/�ٷα���/����/ȣ��] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�ش���/�ٷα���/����/ȣ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">

   		var iCount1 = dsT_CP_PAYMASTER.CountRow;
		if (iCount1 != 0) {
			enableInput();//�Է��ʵ� Ȱ��ȭ
			document.getElementById("txtENO_NM_SHR").value = dsT_CP_PAYMASTER.NameValue(iCount1,"ENO_NM");
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount1);
		}else{
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
		}

		document.getElementById("txtENO_NO_SHR").focus();

    </script>

    <script for=tr01T_CP_PAYMASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CP_PAYMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=tr01T_CP_PAYMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script language=JavaScript for=medBAS_PCT event=onKillFocus()>
		var PAY_PCT = (Number(form1.medBAS_PCT.Text) +
                        Number(form1.medINC_PCT.Text) +
						Number(form1.medGOG_PCT.Text) -
						Number(form1.medATTD_PCT.Text) -
						Number(form1.medPUD_PCT.Text) -
						Number(form1.medTRD_PCT.Text));
		if(PAY_PCT >= 1000){
			form1.medBAS_PCT.Text = 0;
			alert("���������� 1000�� �ѱ�� �����ϴ�.");
			form1.medBAS_PCT.Focus();
		}else{
			form1.medPAY_PCT.Text = PAY_PCT;
		}
	</script>

	<script language=JavaScript for=medINC_PCT event=onKillFocus()>
		var PAY_PCT = (Number(form1.medBAS_PCT.Text) +
						Number(form1.medINC_PCT.Text) +
                        Number(form1.medGOG_PCT.Text) -
						Number(form1.medATTD_PCT.Text) -
						Number(form1.medPUD_PCT.Text) -
						Number(form1.medTRD_PCT.Text));
		if(PAY_PCT >= 1000){
			form1.medINC_PCT.Text = 0;
			alert("���������� 1000�� �ѱ�� �����ϴ�.");
			form1.medINC_PCT.Focus();
		}else{
			form1.medPAY_PCT.Text = PAY_PCT;
		}
	</script>

    <script language=JavaScript for=medGOG_PCT event=onKillFocus()>
        var PAY_PCT = (Number(form1.medBAS_PCT.Text) +
                        Number(form1.medINC_PCT.Text) +
                        Number(form1.medGOG_PCT.Text) -
                        Number(form1.medATTD_PCT.Text) -
                        Number(form1.medPUD_PCT.Text) -
                        Number(form1.medTRD_PCT.Text));
        if(PAY_PCT >= 1000){
            form1.medGOG_PCT.Text = 0;
            alert("���������� 1000�� �ѱ�� �����ϴ�.");
            form1.medGOG_PCT.Focus();
        }else{
            form1.medPAY_PCT.Text = PAY_PCT;
        }
    </script>

	<script language=JavaScript for=medATTD_PCT event=onKillFocus()>
		var PAY_PCT = (Number(form1.medBAS_PCT.Text) +
						Number(form1.medGOG_PCT.Text) +
                        Number(form1.medINC_PCT.Text) -
						Number(form1.medATTD_PCT.Text) -
						Number(form1.medPUD_PCT.Text) -
						Number(form1.medTRD_PCT.Text));
		if(PAY_PCT >= 1000){
			form1.medATTD_PCT.Text = 0;
			alert("���������� 1000�� �ѱ�� �����ϴ�.");
			form1.medATTD_PCT.Focus();
		}else{
			form1.medPAY_PCT.Text = PAY_PCT;
		}
	</script>

	<script language=JavaScript for=medPUD_PCT event=onKillFocus()>
		var PAY_PCT = (Number(form1.medBAS_PCT.Text) +
						Number(form1.medINC_PCT.Text) +
                        Number(form1.medGOG_PCT.Text) -
						Number(form1.medATTD_PCT.Text) -
						Number(form1.medPUD_PCT.Text) -
						Number(form1.medTRD_PCT.Text));
		if(PAY_PCT >= 1000){
			form1.medPUD_PCT.Text = 0;
			alert("���������� 1000�� �ѱ�� �����ϴ�.");
			form1.medPUD_PCT.Focus();
		}else{
			form1.medPAY_PCT.Text = PAY_PCT;
		}
	</script>

	<script language=JavaScript for=medTRD_PCT event=onKillFocus()>
		var PAY_PCT = (Number(form1.medBAS_PCT.Text) +
						Number(form1.medINC_PCT.Text) +
                        Number(form1.medGOG_PCT.Text) -
						Number(form1.medATTD_PCT.Text) -
						Number(form1.medPUD_PCT.Text) -
						Number(form1.medTRD_PCT.Text));
		if(PAY_PCT >= 1000){
			form1.medTRD_PCT.Text = 0;
			alert("���������� 1000�� �ѱ�� �����ϴ�.");
			form1.medTRD_PCT.Focus();
		}else{
			form1.medPAY_PCT.Text = PAY_PCT;
		}
	</script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ��󿩻��װ���</td>
					<td align="right" class="navigator">HOME/�������/�󿩰���/<font color="#000000">���κ��󿩻��װ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
								<col width="10"></col>
								<col width="70"></col>
								<col width="110"></col>
								<col width="80"></col>
								<col width="90"></col>
								<col width="70"></col>
								<col width="70"></col>
								<col width="70"></col>
								<col width="200"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�ش���</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">�޻󿩱���</td>
								<td>
									<input type="hidden" id="txtSAL_GBN" name="txtSAL_GBN" value="1">
									<input id="txtSAL_GBN_NM" name="txtSAL_GBN_NM" size="11" maxlength="10" class="input_ReadOnly"  readOnly value="��">
									<!--
									<select id="cmbSAL_GBN_SHR" style="width:80%" onChange="fnc_SearchList();">
										<option value="0" >�޿�</option>
	                                    <option value="1" >��</option>
									</select>
									  -->
								</td>
								<td align="center" class="searchState">�Ϸù�ȣ</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:50" onChange="fnc_SearchList();">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
								<td align="center" class="searchState">�����ȣ</td>
								<td>
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�λ�����</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="180"></col>
					<col width="80"></col>
					<col width="180"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtOCC_CD" size="4" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtOCC_NM" size="16" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtDPT_CD" size="4" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtDPT_NM" size="16" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtJOB_CD" size="4" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtJOB_NM" size="16" class="input_ReadOnly" readOnly>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">ȣ&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtHOB_CD" size="4" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtHOB_NM" size="16" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">�ֹι�ȣ</td>
					<td class="padding2423" colspan="3"><input id="txtCET_NO" size="23"  maxlength="14"  class="input_ReadOnly" readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" colspan="5">
						<input id="txtRZI_NO" size="10"  maxlength="6"  class="input_ReadOnly" readonly>
						<input id="txtRADR_CT" size="44"  maxlength="60"  class="input_ReadOnly" readonly>
						<input id="txtRADR" size="53"  maxlength="60"  class="input_ReadOnly" readonly>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�Ի���</td>
					<td class="padding2423"><input id="txtHIR_YMD" size="17"  maxlength="10"  class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423"><input id="txtRET_YMD" size="17"  maxlength="10"  class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423" colspan="3">
						<input id="txtTMR_YMD" size="17"  maxlength="10"  class="input_ReadOnly" readonly>
						<input id="txtTMR_DD" size="5"  maxlength="5"  class="input_ReadOnly" readonly>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="85"></col>
					<col width="135"></col>
					<col width="65"></col>
					<col width="145"></col>
					<col width="65"></col>
					<col width="90"></col>
					<col width="65"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">���������</td>
					<td class="padding2423">
						<input id="txtSOU_CNT" size="1" maxlength="1" onkeypress="cfCheckNumber();" style="ime-mode:disabled">
						<input id="txtDFM_CNT" size="1" maxlength="1" onkeypress="cfCheckNumber();" style="ime-mode:disabled">
						<input id="txtTRB_CNT" size="1" maxlength="1" onkeypress="cfCheckNumber();" style="ime-mode:disabled">
						<input id="txtGOL_CNT" size="1" maxlength="1" onkeypress="cfCheckNumber();" style="ime-mode:disabled">
						<input id="txtWCT_CNT" size="1" maxlength="1" onkeypress="cfCheckNumber();" style="ime-mode:disabled">
						<input id="txtCHI_CNT" size="1" maxlength="1" onkeypress="cfCheckNumber();" style="ime-mode:disabled">
					</td>
                    <td align="center" class="creamBold">�����ڵ�</td>
					<td class="padding2423">
                        <input id="txtABA_CD" style="width:20%" maxlength="2"> <input id="txtABA_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgABA_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgABA_CD" name="imgABA_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtABA_CD','txtABA_NM','����','BK');"></a>
					</td>
                    <td align="center" class="creamBold">������</td>
					<td class="padding2423"><input id="txtREC_NAM" size="12" maxlength="12"></td>
					<td align="center" class="creamBold">�������</td>
					<td class="padding2423"><input id="txtACC_NO" size="16" maxlength="16"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="150"></col>
					<col width="150"></col>
					<col width="150"></col>
                    <col width="150"></col>
                    <col width="150"></col>
                    <col width="150"></col>
         		</colgroup>
				<tr>
                    <td align="center" class="creamBold">�󿩱ݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medDOMT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">��������</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medPAY_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=3>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace     value=2>
							<param name=VisibleMaxDecimal   value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">�⺻������</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medBAS_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=3>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=MaxDecimalPlace     value=2>
                            <param name=VisibleMaxDecimal   value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="75"></col>
					<col width="95"></col>
					<col width="75"></col>
					<col width="70"></col>
					<col width="75"></col>
					<col width="70"></col>
					<col width="75"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�μ�Ƽ��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medINC_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=3>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace     value=2>
							<param name=VisibleMaxDecimal   value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                   <td align="center" class="creamBold">�򰡰�����</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medGOG_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=3>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=MaxDecimalPlace     value=2>
                            <param name=VisibleMaxDecimal   value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">���°�����</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medATTD_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=3>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace     value=2>
							<param name=VisibleMaxDecimal   value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">¡�谨����</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medPUD_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=3>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace     value=2>
							<param name=VisibleMaxDecimal   value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">����������</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medTRD_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=3>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=MaxDecimalPlace     value=2>
							<param name=VisibleMaxDecimal   value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="85"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�⺻��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medBAS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">��å����</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medDUTY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">�ð��ܼ���</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">��������</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medWEL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">�ڱⰳ��/����</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medOSE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">�߱ټ���</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medRUN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">�������</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medMH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">�ڵ����Լ���</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medTB3_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">��Ÿ����</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medSGF_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">�ټӼ���</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medLSEV_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">��Ÿ���Ҿ�</td>
					<td class="padding2423" colspan="3">
						<comment id="__NSID__"><object id="medOTH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:32%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_CP_PAYMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_PAYMASTER">
	<Param Name="BindInfo", Value='
		<C>Col=OCC_CD     		Ctrl=txtOCC_CD     		 	Param=value 		</C>
		<C>Col=OCC_NM     		Ctrl=txtOCC_NM    			Param=value 		</C>
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     			Param=value 		</C>
		<C>Col=DPT_NM     		Ctrl=txtDPT_NM    			Param=value 		</C>
		<C>Col=JOB_CD     		Ctrl=txtJOB_CD     			Param=value 		</C>
		<C>Col=JOB_NM     		Ctrl=txtJOB_NM    			Param=value 		</C>
		<C>Col=HOB_CD     		Ctrl=txtHOB_CD     		 	Param=value 		</C>
		<C>Col=HOB_NM     		Ctrl=txtHOB_NM     		 	Param=value 		</C>
		<C>Col=RZI_NO     		Ctrl=txtRZI_NO     			Param=value 		</C>
		<C>Col=RADR     		Ctrl=txtRADR     			Param=value 		</C>
		<C>Col=RADR_CT     	 	Ctrl=txtRADR_CT     		Param=value 		</C>
		<C>Col=CET_NO	     	Ctrl=txtCET_NO     			Param=value 		</C>
		<C>Col=HIR_YMD     		Ctrl=txtHIR_YMD     		Param=value 		</C>
		<C>Col=RET_YMD     	 	Ctrl=txtRET_YMD     		Param=value 		</C>
		<C>Col=TMR_YMD     	 	Ctrl=txtTMR_YMD     		Param=value 		</C>
		<C>Col=TMR_DD     		Ctrl=txtTMR_DD     		 	Param=value 		</C>
		<C>Col=SOU_CNT     	 	Ctrl=txtSOU_CNT     		Param=value 		</C>
		<C>Col=DFM_CNT     	 	Ctrl=txtDFM_CNT     		Param=value 		</C>
		<C>Col=TRB_CNT     	 	Ctrl=txtTRB_CNT     		Param=value 		</C>
		<C>Col=GOL_CNT     	 	Ctrl=txtGOL_CNT     		Param=value 		</C>
		<C>Col=WCT_CNT     	 	Ctrl=txtWCT_CNT     		Param=value 		</C>
		<C>Col=CHI_CNT 	    	Ctrl=txtCHI_CNT     		Param=value 		</C>
		<C>Col=ABA_CD     		Ctrl=txtABA_CD     			Param=value 		</C>
		<C>Col=ABA_NM     		Ctrl=txtABA_NM     		 	Param=value 		</C>
		<C>Col=REC_NAM     	 	Ctrl=txtREC_NAM     		Param=value 		</C>
		<C>Col=ACC_NO     		Ctrl=txtACC_NO     		 	Param=value 		</C>

		<C>Col=DOMT_AMT  	 	Ctrl=medDOMT_AMT      	    Param=text	 		</C>
		<C>Col=PAY_PCT     	 	Ctrl=medPAY_PCT     	 	Param=text	 		</C>

		<C>Col=BAS_PCT     	 	Ctrl=medBAS_PCT     	 	Param=text	 		</C>
		<C>Col=INC_PCT     		Ctrl=medINC_PCT     	 	Param=text	 		</C>
        <C>Col=GOG_PCT          Ctrl=medGOG_PCT             Param=text          </C>
		<C>Col=ATTD_PCT    	 	Ctrl=medATTD_PCT     	 	Param=text	 		</C>
		<C>Col=PUD_PCT     	 	Ctrl=medPUD_PCT     	 	Param=text	 		</C>
		<C>Col=TRD_PCT     	 	Ctrl=medTRD_PCT     	 	Param=text	 		</C>

		<C>Col=BAS_AMT     	 	Ctrl=medBAS_AMT     	 	Param=text	 		</C>
		<C>Col=DUTY_AMT   	 	Ctrl=medDUTY_AMT     	 	Param=text	 		</C>
		<C>Col=OT_AMT     		Ctrl=medOT_AMT     		 	Param=text	 		</C>
		<C>Col=WEL_AMT     	 	Ctrl=medWEL_AMT     	 	Param=text	 		</C>

		<C>Col=OSE_AMT     	 	Ctrl=medOSE_AMT     	 	Param=text	 		</C>
		<C>Col=RUN_AMT     	 	Ctrl=medRUN_AMT     	 	Param=text	 		</C>
		<C>Col=MH_AMT     		Ctrl=medMH_AMT     	 	    Param=text	 		</C>
		<C>Col=TB3_AMT     	 	Ctrl=medTB3_AMT     	 	Param=text	 		</C>

		<C>Col=SGF_AMT     	 	Ctrl=medSGF_AMT     	 	Param=text	 		</C>
		<C>Col=LSEV_AMT     	Ctrl=medLSEV_AMT     	 	Param=text	 		</C>
		<C>Col=OTH_AMT     	 	Ctrl=medOTH_AMT     	 	Param=text	 		</C>
    '>
</object>
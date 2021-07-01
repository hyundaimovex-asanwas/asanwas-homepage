<!--
    ************************************************************************************
    * @source         : sagd020.jsp 				                                   *
    * @description   : ��_���κ��޿����װ��� PAGE.                                        *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2016/01/08  |  �̵���   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��_���κ��޿����װ���</title>
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
		var btnList = 'TFTTTFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; 	// �ش���
			var SAL_GBN_SHR = document.getElementById("txtSAL_GBN").value; 			// �޻󿩱���
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; 		// ���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; 				// �Ϸù�ȣ

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
			trT_CP_PAYMASTER.KeyValue = "SVL(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER, O:dsT_CP_PAYMASTER_OFFICE=dsT_CP_PAYMASTER_OFFICE)";
			trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.sagd020.cmd.sagd020CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&SEQ_SHR="+SEQ_SHR;
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
			tr01T_CP_PAYMASTER.KeyValue = "SVL(I:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER, I:dsT_CP_PAYMASTER_OFFICE=dsT_CP_PAYMASTER_OFFICE)";
			tr01T_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.sagd020.cmd.sagd020CMD&S_MODE=SAV&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&SEQ_SHR="+SEQ_SHR;
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
			trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.sagd020.cmd.sagd020CMD&S_MODE=DEL&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&SEQ_SHR="+SEQ_SHR;
			trT_CP_PAYMASTER.post();
			fnc_Clear();

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var SAL_GBN_SHR = document.getElementById("txtSAL_GBN").value; // �޻󿩱���
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ

		    var url = "sagd020_PV.jsp?PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&SEQ_SHR="+SEQ_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYMASTER_OFFICE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYMASTER_OFFICE.GridToExcel("���κ��޿����װ���", '', 225);

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
			dsT_CP_PAYMASTER_OFFICE.AddRow();

			dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"OCC_CD") = dsT_CP_PAYMASTER.NameValue(1,"OCC_CD");
			dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"PIS_YY") = dsT_CP_PAYMASTER.NameValue(1,"PIS_YY");
			dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"PIS_MM") = dsT_CP_PAYMASTER.NameValue(1,"PIS_MM");
			dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"ENO_NO") = dsT_CP_PAYMASTER.NameValue(1,"ENO_NO");
			dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"SEQ") = dsT_CP_PAYMASTER.NameValue(1,"SEQ");

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {
				// ���� �� �ڷᰡ �ִ��� üũ�ϰ�
	            if (dsT_CP_PAYMASTER_OFFICE.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }

	            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
	            if (confirm("[" + dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"STR_YMD") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
	            dsT_CP_PAYMASTER_OFFICE.DeleteRow(dsT_CP_PAYMASTER_OFFICE.RowPosition);

	            // ���� �� �ش� �׸���� Focus �̵�
	            form1.grdT_CP_PAYMASTER_OFFICE.SetColumn(form1.grdT_CP_PAYMASTER_OFFICE.GetColumnID(form1.grdT_CP_PAYMASTER_OFFICE.GetColumnIndex("STR_YMD")));
	            form1.grdT_CP_PAYMASTER_OFFICE.Focus();
        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			dsT_CP_PAYMASTER.ClearData();
			dsT_CP_PAYMASTER_OFFICE.ClearData();

			disableInput();
            document.getElementById("txtDAYS1").value = "";
            document.getElementById("txtDAYS2").value = "";
            document.getElementById("txtDAYS3").value = "";
			document.getElementById("txtTOT_DAYS").value = "";

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
	        if (dsT_CP_PAYMASTER.IsUpdated || dsT_CP_PAYMASTER_OFFICE.IsUpdated)  {

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

        	if (!dsT_CP_PAYMASTER.isUpdated && !dsT_CP_PAYMASTER_OFFICE.isUpdated) {
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

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CP_PAYMASTER_OFFICE,0,"false","false");

			//�ֱ� ������ �ش��� ��ȸ
			ds01T_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.sagd020.cmd.sagd020CMD&S_MODE=SHR_01";
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
  			document.getElementById("cmbLAB_TAG").disabled = false;
			document.form1.txtABA_CD.readOnly = false;
  			document.form1.txtABA_CD.className = "";
  			document.getElementById("imgABA_CD").disabled = false;
			document.form1.txtREC_NAM.readOnly = false;
  			document.form1.txtREC_NAM.className = "";
			document.form1.txtACC_NO.readOnly = false;
  			document.form1.txtACC_NO.className = "";
  			document.getElementById("cmbHIU_TAG").disabled = false;
			document.form1.txtHIU_NO.readOnly = false;
  			document.form1.txtHIU_NO.className = "";
         	form1.medHINU_AMT.Enable = "true";
         	form1.medOLD_AMT.Enable = "true";
  			document.getElementById("cmbNPN_TAG").disabled = false;
			form1.medNPEN_AMT.Enable = "true";

  			document.getElementById("imgAppend").disabled = false;
  			document.getElementById("imgRemove").disabled = false;
			document.form1.txtSTR_YMD_SUB.readOnly = false;
			document.form1.txtSTR_YMD_SUB.className = "";
  			document.getElementById("imgSTR_YMD_SUB").disabled = false;
			document.form1.txtEND_YMD_SUB.readOnly = false;
			document.form1.txtEND_YMD_SUB.className = "";
  			document.getElementById("imgEND_YMD_SUB").disabled = false;
			document.form1.txtPDD_CNT_SUB.readOnly = false;
			document.form1.txtPDD_CNT_SUB.className = "";
			document.form1.txtDPT_CD_SUB.readOnly = false;
			document.form1.txtDPT_CD_SUB.className = "";
  			document.getElementById("imgDPT_CD_SUB").disabled = false;
			document.form1.txtJOB_CD_SUB.readOnly = false;
			document.form1.txtJOB_CD_SUB.className = "";
  			document.getElementById("imgJOB_CD_SUB").disabled = false;
			document.form1.txtJCD_CD_SUB.readOnly = false;
			document.form1.txtJCD_CD_SUB.className = "";
  			document.getElementById("imgJCD_CD_SUB").disabled = false;

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
  			document.getElementById("cmbLAB_TAG").disabled = true;
			document.form1.txtABA_CD.readOnly = true;
  			document.form1.txtABA_CD.className = "input_ReadOnly";
  			document.getElementById("imgABA_CD").disabled = true;
			document.form1.txtREC_NAM.readOnly = true;
  			document.form1.txtREC_NAM.className = "input_ReadOnly";
			document.form1.txtACC_NO.readOnly = true;
  			document.form1.txtACC_NO.className = "input_ReadOnly";
  			document.getElementById("cmbHIU_TAG").disabled = true;
			document.form1.txtHIU_NO.readOnly = true;
  			document.form1.txtHIU_NO.className = "input_ReadOnly";
  			form1.medHINU_AMT.Enable = "false";
  			form1.medOLD_AMT.Enable = "false";
  			document.getElementById("cmbNPN_TAG").disabled = true;
		    form1.medNPEN_AMT.Enable = "false";

  			document.getElementById("imgAppend").disabled = true;
  			document.getElementById("imgRemove").disabled = true;
			document.form1.txtSTR_YMD_SUB.readOnly = true;
			document.form1.txtSTR_YMD_SUB.className = "input_ReadOnly";
  			document.getElementById("imgSTR_YMD_SUB").disabled = true;
			document.form1.txtEND_YMD_SUB.readOnly = true;
			document.form1.txtEND_YMD_SUB.className = "input_ReadOnly";
  			document.getElementById("imgEND_YMD_SUB").disabled = true;
			document.form1.txtPDD_CNT_SUB.readOnly = true;
			document.form1.txtPDD_CNT_SUB.className = "input_ReadOnly";
			document.form1.txtDPT_CD_SUB.readOnly = true;
			document.form1.txtDPT_CD_SUB.className = "input_ReadOnly";
  			document.getElementById("imgDPT_CD_SUB").disabled = true;
			document.form1.txtJOB_CD_SUB.readOnly = true;
			document.form1.txtJOB_CD_SUB.className = "input_ReadOnly";
  			document.getElementById("imgJOB_CD_SUB").disabled = true;
			document.form1.txtJCD_CD_SUB.readOnly = true;
			document.form1.txtJCD_CD_SUB.className = "input_ReadOnly";
  			document.getElementById("imgJCD_CD_SUB").disabled = true;

  		}

  		//�������޿����� �ϼ� ��
  		function fnc_CalPDD_CNT(){
			var STR_YMD_SUB = dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"STR_YMD");
			var END_YMD_SUB = dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"END_YMD");
			var PDD_CNT_SUB = dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"PDD_CNT");

			if(STR_YMD_SUB.length != 10 && END_YMD_SUB.length != 10){
				return false;
			}

			dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"PDD_CNT") = parseInt((dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"END_YMD")).replace("-", "").replace("-", "")) -
																								parseInt((dsT_CP_PAYMASTER_OFFICE.NameValue(dsT_CP_PAYMASTER_OFFICE.RowPosition,"STR_YMD")).replace("-", "").replace("-", "")) + 1;

			fnc_CalDAYS();

  		}

  		function fnc_CalDAYS(){
            var DAYS1 = 0;
            var DAYS2 = 0;
            var DAYS3 = 0;
            var iCount = dsT_CP_PAYMASTER_OFFICE.countrow;

            for( var i = 1; i <= iCount; i++ ) {
	            DAYS1 = DAYS1 + dsT_CP_PAYMASTER_OFFICE.NameValue(i,"PDD_CNT")
            }

            document.getElementById("txtDAYS1").value = DAYS1;
            document.getElementById("txtDAYS2").value = DAYS2;
            document.getElementById("txtDAYS3").value = DAYS3;
			document.getElementById("txtTOT_DAYS").value = DAYS1 + DAYS2 + DAYS3;
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
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_OFFICE                     |
    | 3. Table List : T_CP_PAYMASTER_OFFICE                |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_OFFICE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <Script For=dsT_CP_PAYMASTER_OFFICE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_CalDAYS();

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

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_OFFICE Event="OnLoadError()">
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

    <Script For=dsT_CP_PAYMASTER_OFFICE Event="OnDataError()">
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
		}else{
            document.getElementById("txtDAYS1").value = "";
            document.getElementById("txtDAYS2").value = "";
            document.getElementById("txtDAYS3").value = "";
			document.getElementById("txtTOT_DAYS").value = "";
		}

   		var iCount2 = dsT_CP_PAYMASTER_OFFICE.CountRow;
		if (iCount2 == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount2);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ��޿����װ���</td>
					<td align="right" class="navigator">HOME/�������/�޿�����/<font color="#000000">���κ��޿����װ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">�޻󿩱���</td>
								<td>
									<input type="hidden" id="txtSAL_GBN" name="txtSAL_GBN" value="0">
									<input id="txtSAL_GBN_NM" name="txtSAL_GBN_NM" size="11" maxlength="10" class="input_ReadOnly"  readOnly value="�޿�">
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
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
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
            <strong>�޿�����</strong></td>
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
						<input id="txtDPT_CD" size="4" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtDPT_NM" size="16" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtJOB_CD" size="4" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtJOB_NM" size="16" class="input_ReadOnly" readOnly>
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
					<td class="padding2423">
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
            <strong>�ٹ��ϼ�</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDAYS1" size="16" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDAYS2" size="16" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;Ÿ</td>
					<td class="padding2423"><input id="txtDAYS3" size="16" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtTOT_DAYS" size="16" class="input_ReadOnly" readOnly></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�޿�����</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
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
					<td align="center" class="creamBold">�������ݰ�</td>
					<td colspan="3">
						<table width="100%" border="0" >
							<tr>
								<td width="100">
									<select id="cmbLAB_TAG" style="WIDTH:100%">
										<option value="Y">����</option>
										<option value="N">����</option>
									</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">�����ڵ�</td>
					<td class="padding2423">
                        <input id="txtABA_CD" style="width:20%" maxlength="3"> <input id="txtABA_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgABA_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgABA_CD" name="imgABA_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtABA_CD','txtABA_NM','����','BK');"></a>
					</td>
                    <td align="center" class="creamBold">������</td>
					<td class="padding2423"><input id="txtREC_NAM" size="25" maxlength="12"></td>
					<td align="center" class="creamBold">�������</td>
					<td class="padding2423"><input id="txtACC_NO" size="25" maxlength="20"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�ǰ�����</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<select id="cmbHIU_TAG" style="WIDTH:90%">
							<option value="1" >����</option>
							<option value="0" >����</option>

						</select>
					</td>
                    <td align="center" class="creamBold">����ȣ</td>
					<td class="padding2423"><input id="txtHIU_NO" size="25" maxlength="15"></td>
                    <td align="center" class="creamBold">�����</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medHINU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
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
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold"></td>
					<td class="padding2423"></td>
                    <td align="center" class="creamBold"></td>
					<td class="padding2423"></td>
                    <td align="center" class="creamBold">����纸��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medOLD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
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
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>���ο���</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
				    <col width="80"></col>
                    <col width="178"></col>
                    <col width="80"></col>
                    <col width=""></col>

             	</colgroup>
				<tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<select id="cmbNPN_TAG" style="WIDTH:90%">
							<option value="1" >����</option>
							<option value="0" >����</option>
						</select>
					</td>
                    <td align="center" class="creamBold">�����</td>
					<td class="padding2423">
                        <comment id="__NSID__"><object id="medNPEN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:36%" >
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=false>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=9>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
     			</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������ �޿�����</strong>
        </td>
		<td height="26" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_InsertOver.gif',1)">  <input type="image" style="border:0" src="/images/button/btn_InsertOn.gif"   name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append();return false;"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)">  <input type="image" style="border:0" src="/images/button/btn_RemoveOn.gif"   name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove();return false;"></a>
		</td>
    </tr>
	<tr>
		<td colspan="2">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�ش�����</td>
					<td class="padding2423" colspan="3">
						<input id="txtSTR_YMD_SUB" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this); fnc_CalPDD_CNT();" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SUB','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SUB" width="21" height="20" border="0" align="absmiddle" onclick="if(txtSTR_YMD_SUB.disabled != true){ calendarBtn('datetype1','txtSTR_YMD_SUB','','60','520');} fnc_CalPDD_CNT();return false;"></a>
						&nbsp;~&nbsp;
						<input id="txtEND_YMD_SUB" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this); fnc_CalPDD_CNT();" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SUB','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SUB" width="21" height="20" border="0" align="absmiddle" onclick="if(txtEND_YMD_SUB.disabled != true){ calendarBtn('datetype1','txtEND_YMD_SUB','','190','520');} fnc_CalPDD_CNT();return false;"></a>
						&nbsp;&nbsp;
						<input id="txtPDD_CNT_SUB" size="3" maxlength="2" onChange="fnc_CalDAYS();" >&nbsp;��
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtDPT_CD_SUB" name="txtDPT_CD_SUB" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtDPT_CD_SUB','txtDPT_NM_SUB');" onChange="fnc_GetCommNm('A4','txtDPT_CD_SUB','txtDPT_NM_SUB');">
						<input id="txtDPT_NM_SUB" name="txtDPT_NM_SUB" size="16" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SUB','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SUB" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SUB','txtDPT_NM_SUB','�Ҽ�','DEPT');return false;"></a>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtJOB_CD_SUB" name="txtJOB_CD_SUB" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SUB','txtJOB_NM_SUB');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SUB','txtJOB_NM_SUB');">
						<input id="txtJOB_NM_SUB" name="txtJOB_NM_SUB" size="16" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SUB','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgJOB_CD_SUB" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SUB','txtJOB_NM_SUB','����','A2');return false;"></a>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtJCD_CD_SUB" name="txtJCD_CD_SUB" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('J3','txtJCD_CD_SUB','txtJCD_NM_SUB');" onChange="fnc_GetCommNm('J3','txtJCD_CD_SUB','txtJCD_NM_SUB');">
						<input id="txtJCD_NM_SUB" name="txtJCD_NM_SUB" size="16" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJCD_CD_SUB','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgJCD_CD_SUB" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJCD_CD_SUB','txtJCD_NM_SUB','����','J3');return false;"></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->



<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER_OFFICE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:120px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER_OFFICE">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="AutoReSizing"              value="true">
						  	<param name=ColSizing  value="true">
							<param name="Format"				value="
								<C> id='{CUROW}'			width=39			name='NO'					align=center			value={String(Currow)}	</C>
								<C> id='STR_YMD'			width=80			name='������'				align=center													</C>
								<C> id='END_YMD'			width=80			name='������'				align=center													</C>
								<C> id='PDD_CNT'			width=50			name='�ϼ�'					align=center													</C>
								<C> id='DPT_CD'				width=50			name='�Ҽ�'					align=center													</C>
								<C> id='DPT_NM'				width=100			name='�ҼӸ�'				align=center													</C>
								<C> id='JOB_CD'				width=50			name='����'					align=center													</C>
								<C> id='JOB_NM'				width=100			name='������'				align=center													</C>
								<C> id='JCD_CD'				width=50			name='����'					align=center													</C>
								<C> id='JCD_NM'				width=130			name='������'				align=center													</C>
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

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="searchState"><span id="resultMessage">&nbsp;</span></td>
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

		<C>Col=OCC_CD     		 	Ctrl=txtOCC_CD     		 	Param=value 		</C>
		<C>Col=OCC_NM     		 	Ctrl=txtOCC_NM    		 	Param=value 		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     		 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM    		 	Param=value 		</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     		 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM    		 	Param=value 		</C>
		<C>Col=HOB_NM     		 	Ctrl=txtHOB_NM     		 	Param=value 		</C>
		<C>Col=RZI_NO     		 	Ctrl=txtRZI_NO     		 	Param=value 		</C>
		<C>Col=RADR     		 	Ctrl=txtRADR     	 	    Param=value 		</C>
		<C>Col=RADR_CT     	    	Ctrl=txtRADR_CT     	 	Param=value 		</C>
		<C>Col=CET_NO	     	 	Ctrl=txtCET_NO     		 	Param=value 		</C>
		<C>Col=HIR_YMD     		 	Ctrl=txtHIR_YMD     	 	Param=value 		</C>
		<C>Col=RET_YMD     	 	    Ctrl=txtRET_YMD     	 	Param=value 		</C>
		<C>Col=TMR_YMD     	 	    Ctrl=txtTMR_YMD     	 	Param=value 		</C>
		<C>Col=TMR_DD     		 	Ctrl=txtTMR_DD     		 	Param=value 		</C>
		<C>Col=SOU_CNT     	 	    Ctrl=txtSOU_CNT     	 	Param=value 		</C>
		<C>Col=DFM_CNT     	 	    Ctrl=txtDFM_CNT     	 	Param=value 		</C>
		<C>Col=TRB_CNT     	 	    Ctrl=txtTRB_CNT     	 	Param=value 		</C>
		<C>Col=GOL_CNT     	 	    Ctrl=txtGOL_CNT     	 	Param=value 		</C>
		<C>Col=WCT_CNT     	 	    Ctrl=txtWCT_CNT     	 	Param=value 		</C>
		<C>Col=CHI_CNT 	    	 	Ctrl=txtCHI_CNT     	 	Param=value 		</C>
		<C>Col=LAB_TAG     		 	Ctrl=cmbLAB_TAG    		 	Param=value 		</C>
		<C>Col=ABA_CD     		 	Ctrl=txtABA_CD     		 	Param=value 		</C>
		<C>Col=ABA_NM     		 	Ctrl=txtABA_NM     		 	Param=value 		</C>
		<C>Col=REC_NAM     	 	    Ctrl=txtREC_NAM     	 	Param=value 		</C>
		<C>Col=ACC_NO     		 	Ctrl=txtACC_NO     		 	Param=value 		</C>
		<C>Col=HIU_TAG     		 	Ctrl=cmbHIU_TAG     	 	Param=value 		</C>
		<C>Col=HIU_NO     		 	Ctrl=txtHIU_NO     		 	Param=value 		</C>
		<C>Col=HINU_AMT  	 	    Ctrl=medHINU_AMT    	 	Param=text	 		</C>
		<C>Col=OLD_AMT  	 	    Ctrl=medOLD_AMT    	 		Param=text	 		</C>
		<C>Col=NPN_TAG     	 	    Ctrl=cmbNPN_TAG   	    	Param=value 		</C>
		<C>Col=NPEN_AMT     	 	Ctrl=medNPEN_AMT   		 	Param=text  		</C>
    '>
</object>
<object id="bndT_CP_PAYMASTER_OFFICE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_PAYMASTER_OFFICE">
	<Param Name="BindInfo", Value='

		<C>Col=STR_YMD     		 	Ctrl=txtSTR_YMD_SUB     	 	Param=value 		</C>
		<C>Col=END_YMD     		 	Ctrl=txtEND_YMD_SUB    		 	Param=value 		</C>
		<C>Col=PDD_CNT     		 	Ctrl=txtPDD_CNT_SUB     	 	Param=value 		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD_SUB    		 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM_SUB     		 	Param=value 		</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD_SUB    		 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM_SUB     		 	Param=value 		</C>
		<C>Col=HOB_NM     		 	Ctrl=txtHOB_NM_SUB     		 	Param=value 		</C>
		<C>Col=JCD_CD     		 	Ctrl=txtJCD_CD_SUB     		 	Param=value 		</C>
		<C>Col=JCD_NM     		 	Ctrl=txtJCD_NM_SUB     		 	Param=value 		</C>

    '>
</object>
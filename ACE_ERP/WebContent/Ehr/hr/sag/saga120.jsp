<!--
    ***********************************************************************************
    * @source         : saga120.jsp 				                                  *                                                  *
    * @description   : �ڷ�UP/DOWN PAGE.                                              *
    ***********************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                           *
    *-------------+-----------+-------------------------------------------------------+
    * 2007/03/26  |  ������   | �����ۼ�                                              *
    ***********************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>�ڷ�UP/DOWN</title>
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
		var btnList = 'TFTTTFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // �ش�⵵
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ

			if(document.form1.radCHULJA_TYPE[0].checked == true){
				RADIO_OPTION = 0;
			}
			else if(document.form1.radCHULJA_TYPE[1].checked == true){
				RADIO_OPTION = 1;
			}
			else{
				RADIO_OPTION = 2;
			}

			fnc_SetGridFormat(RADIO_OPTION);


			if(document.getElementById("searchMessage_01").innerText == "�ش���"){
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
			}else{
				//�ش�⵵�� ������ ��ȸ����.
				if(PIS_YY_SHR.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("�ش�⵵�� �Է��ϼ���.");
						document.getElementById("txtPIS_YY_SHR").focus();
						return false;
					}
				}

				//�ش�⵵�� �߸��Ǿ����� ��ȸ����.
				if(PIS_YY_SHR.trim().length != 4){
					if(event.type == "change"){
						return false;
					}else{
						alert("�ش�⵵�� �߸��Ǿ����ϴ�.");
						document.getElementById("txtPIS_YY_SHR").focus();
						return false;
					}
				}
			}

            //�����ͼ� ����
			if(document.tabSAGA120.ActiveIndex==1){//�޻��Ա�
	            dsT_CP_PAYMASTER_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_01&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_01.Reset();

			}else if(document.tabSAGA120.ActiveIndex==2){//���ڱ�

				if(RADIO_OPTION == 0)
				{
					dsT_AC_LOAN_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_02&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            	dsT_AC_LOAN_02.Reset();
	            }
	            else if(RADIO_OPTION == 1)
	            {
	            	dsT_AC_LOAN_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_02_1&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            	dsT_AC_LOAN_02.Reset();
	            }
	            else if(RADIO_OPTION == 2)
	            {
	            	dsT_AC_LOAN_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_02_2&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            	dsT_AC_LOAN_02.Reset();
	            }
			}else if(document.tabSAGA120.ActiveIndex==3){//�����ȯ��
				//����

			}else if(document.tabSAGA120.ActiveIndex==4){//��������
				trT_AC_RETACC_04.KeyValue = "SVL(O:dsT_AC_RETACC_04=dsT_AC_RETACC_04)";
				trT_AC_RETACC_04.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_04&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				trT_AC_RETACC_04.Post();

			}else if(document.tabSAGA120.ActiveIndex==5){//�����ҵ�_1
	            dsT_AC_RETTABLE_05.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_05&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_RETTABLE_05.Reset();

			}else if(document.tabSAGA120.ActiveIndex==6){//�����ҵ�_2
	            dsT_AC_RETTABLE_09.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_09&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_RETTABLE_09.Reset();

			}else if(document.tabSAGA120.ActiveIndex==7){//��������
				//����

			}else if(document.tabSAGA120.ActiveIndex==8){//�Ƿ��Ű�
	            dsT_AC_MEDICAL_07.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_07&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_MEDICAL_07.Reset();

			}else if(document.tabSAGA120.ActiveIndex==9){//��αݽŰ�
	            dsT_AC_DONATION_08.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_08&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_DONATION_08.Reset();

			}else if(document.tabSAGA120.ActiveIndex==10){//�Ͽ���
	            dsT_CA_PAYMASTER_10.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_10&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CA_PAYMASTER_10.Reset();
	            
            }

        }

        function fnc_SetGridFormat(radioOption){

        	if(radioOption == 0){
	        	form1.grdT_AC_LOAN_02.ColumnProp("DPT_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("JOB_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("CET_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("GMK_AMT","Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("EMAENO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("OCC_CD", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("TAG",    "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("PAY_YMD","Show") = "true";
	        	form1.grdT_AC_LOAN_02.ColumnProp("HIR_YMD",   "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("EM_PHN_NO", "Show") = "false";
			}
        	else if(radioOption == 1){
        		form1.grdT_AC_LOAN_02.ColumnProp("DPT_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("JOB_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NO", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("CET_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("GMK_AMT","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("EMAENO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("OCC_CD", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("TAG",    "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("PAY_YMD","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("HIR_YMD","Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("EM_PHN_NO", "Show") = "true";
        	}
        	else{
        		form1.grdT_AC_LOAN_02.ColumnProp("DPT_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("JOB_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NO", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("CET_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("GMK_AMT","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("EMAENO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("OCC_CD", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("TAG",    "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("PAY_YMD","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("HIR_YMD","Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("EM_PHN_NO", "Show") = "false";
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // �ش�⵵
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ

			if(document.tabSAGA120.ActiveIndex==1){//�޻��Ա�
				//����

			}else if(document.tabSAGA120.ActiveIndex==2){//���ڱ�
				//����

			}else if(document.tabSAGA120.ActiveIndex==3){//�����ȯ��
				//tr�� �¿�� ���ؿ� ���������� ����
				for(var i=1; i<= dsT_AC_LOAN_03.CountRow; i++){
					dsT_AC_LOAN_03.UserStatus(i)="1";
				}

	            trT_AC_LOAN_03.KeyValue = "SVL(I:dsT_AC_LOAN_03=dsT_AC_LOAN_03)";
	            trT_AC_LOAN_03.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SAV_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trT_AC_LOAN_03.post();

			}else if(document.tabSAGA120.ActiveIndex==4){//��������
				//����

			}else if(document.tabSAGA120.ActiveIndex==5){//�����ҵ�_1
				//����

			}else if(document.tabSAGA120.ActiveIndex==6){//�����ҵ�_2
				//����

			}else if(document.tabSAGA120.ActiveIndex==7){//��������
				//tr�� �¿�� ���ؿ� ���������� ����
				for(var i=1; i<= dsT_AC_LOAN_06.CountRow; i++){
					dsT_AC_LOAN_06.UserStatus(i)="1";
				}

	            trT_AC_LOAN_06.KeyValue = "SVL(I:dsT_AC_LOAN_06=dsT_AC_LOAN_06, O:dsRESULT=dsRESULT)";
	            trT_AC_LOAN_06.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SAV_06&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trT_AC_LOAN_06.post();


			}else if(document.tabSAGA120.ActiveIndex==8){//�Ƿ��Ű�
				//����

			}else if(document.tabSAGA120.ActiveIndex==9){//��αݽŰ�
				//����

			}else if(document.tabSAGA120.ActiveIndex==10){//�Ͽ���
				//����				
				
            }

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

			if(document.tabSAGA120.ActiveIndex==1){//�޻��Ա�
				if (dsT_CP_PAYMASTER_01.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_02.GridToExcel("�޻��Ա�", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==2){//���ڱ�
				if (dsT_AC_LOAN_02.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}

				if(RADIO_OPTION == 1){
	            	form1.grdT_AC_LOAN_02.GridToExcel("���ڱ�", '', 225)
	            }
	            else if(RADIO_OPTION == 1){
	            	form1.grdT_AC_LOAN_02.GridToExcel("�űԻ�����", '', 225)
	            }
	            if(RADIO_OPTION == 2){
   	            	form1.grdT_AC_LOAN_02.GridToExcel("�ٷα��к���", '', 225)
	            }

			}else if(document.tabSAGA120.ActiveIndex==3){//�����ȯ��
				if (dsT_AC_LOAN_03.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_LOAN_03.GridToExcel("�����ȯ��", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==4){//��������
				if (dsT_AC_RETACC_04.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_RETACC_04.GridToExcel("��������", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==5){//�����ҵ�_1
				if (dsT_AC_RETTABLE_05.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_RETTABLE_05.GridToExcel("�����ҵ�_1", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==6){//�����ҵ�_2
				if (dsT_AC_RETTABLE_09.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_RETTABLE_09.GridToExcel("�����ҵ�_2", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==7){//��������
				if (dsT_AC_LOAN_06.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_LOAN_06.GridToExcel("��������", '', 225)


			}else if(document.tabSAGA120.ActiveIndex==8){//�Ƿ��Ű�
				if (dsT_AC_MEDICAL_07.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_MEDICAL_07.GridToExcel("�Ƿ��Ű�", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==9){//��αݽŰ�
				if (dsT_AC_DONATION_08.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_DONATION_08.GridToExcel("��αݽŰ�", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==10){//�Ͽ���
				if (dsT_CA_PAYMASTER_10.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CA_PAYMASTER_10.GridToExcel("�Ͽ����Ű�", '', 225)
            	
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
			document.tabSAGA120.ActiveIndex=2;
			document.tabSAGA120.ActiveIndex=1;

			dsT_CP_PAYMASTER_01.ClearData();
			dsT_AC_LOAN_02.ClearData();
			dsT_AC_LOAN_03.ClearData();
			dsT_AC_RETACC_04.ClearData();
			dsT_AC_RETTABLE_05.ClearData();
			dsT_AC_LOAN_06.ClearData();
			dsT_AC_MEDICAL_07.ClearData();
			dsT_AC_DONATION_08.ClearData();
			dsT_AC_RETTABLE_09.ClearData();
			dsT_CA_PAYMASTER_10.ClearData();			
			
			
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbSAL_GBN_SHR").value = "0";
			document.getElementById("cmbSEQ_SHR").value = "1";
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_PAYMASTER_01.IsUpdated || dsT_AC_LOAN_02.IsUpdated || dsT_AC_LOAN_03.IsUpdated || dsT_AC_RETACC_04.IsUpdated ||
				dsT_AC_RETTABLE_05.IsUpdated || dsT_AC_LOAN_06.IsUpdated || dsT_AC_MEDICAL_07.IsUpdated || dsT_AC_DONATION_08.IsUpdated ||
				dsT_AC_RETTABLE_09.IsUpdated || dsT_CA_PAYMASTER_10.IsUpdated)  {

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

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7); // �ش���
			document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4); // �ش�⵵
			document.getElementById("txtPIS_YMD").value = getToday(); // �ش�����

			//ȭ���ħ���� �ӽ� �ذ�
			document.tabSAGA120.ActiveIndex=2;
			document.tabSAGA120.ActiveIndex=1;

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CP_PAYMASTER_01,0,"false","false");
			cfStyleGrid(form1.grdT_AC_LOAN_02,0,"false","false");
			cfStyleGrid(form1.grdT_AC_LOAN_03,0,"false","false");
			cfStyleGrid(form1.grdT_AC_RETACC_04,0,"false","true");
			cfStyleGrid(form1.grdT_AC_RETTABLE_05,0,"false","false");
			cfStyleGrid(form1.grdT_AC_LOAN_06,0,"false","false");
			cfStyleGrid(form1.grdT_AC_MEDICAL_07,0,"false","true");
			cfStyleGrid(form1.grdT_AC_DONATION_08,0,"false","true");
			cfStyleGrid(form1.grdT_AC_RETTABLE_09,0,"false","false");
			cfStyleGrid(form1.grdT_CA_PAYMASTER_10,0,"false","true");
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/**
         * ÷������ ó��
         */
        function fnc_FileUpload() {

        	var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // �ش�⵵
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsFILE_UPLOAD.CountColumn == 0) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

			if(document.tabSAGA120.ActiveIndex==1){//�޻��Ա�
				//����

			}else if(document.tabSAGA120.ActiveIndex==2){//���ڱ�
				//����

			}else if(document.tabSAGA120.ActiveIndex==3){//�����ȯ��

	            trFILE_UPLOAD_03.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_AC_LOAN_03=dsT_AC_LOAN_03)";
	            trFILE_UPLOAD_03.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trFILE_UPLOAD_03.post();

			}else if(document.tabSAGA120.ActiveIndex==4){//��������
				//����

			}else if(document.tabSAGA120.ActiveIndex==5){//�����ҵ�_1
				//����

			}else if(document.tabSAGA120.ActiveIndex==6){//�����ҵ�_2
				//����

			}else if(document.tabSAGA120.ActiveIndex==7){//��������
	            trFILE_UPLOAD_06.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_AC_LOAN_06=dsT_AC_LOAN_06)";
	            trFILE_UPLOAD_06.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_06&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trFILE_UPLOAD_06.post();

			}else if(document.tabSAGA120.ActiveIndex==8){//�Ƿ��Ű�
				//����

			}else if(document.tabSAGA120.ActiveIndex==9){//��αݽŰ�
				//����

            }
        }

        /**
         * ���Ϸ� ����
         */
        function fnc_ToFile() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // �ش�⵵
			var PIS_YMD = document.getElementById("txtPIS_YMD").value; // �ش�⵵
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ
			var FILE_NAME = "";//���ϸ�

			if(document.tabSAGA120.ActiveIndex==1){//�޻��Ա�
	            if (dsT_CP_PAYMASTER_01.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_CP_PAYMASTER_01.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }

				if(SAL_GBN_SHR == "0"){//�޿�
		            FILE_NAME = document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"paya.dat";
	            }else if(SAL_GBN_SHR == "1"){//��
		            FILE_NAME = document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"bona.dat";
	            }else if(SAL_GBN_SHR == "4"){//����
	    	        FILE_NAME = document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"cpsa.dat";
    	        }else{
    	        	alert("����");return false;
    	        }

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_01&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==2){//���ڱ�


	            if (dsT_AC_LOAN_02.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_AC_LOAN_02.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }


	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";

	            if(form.radCHULJA_TYPE[0].checked == true){
		            FILE_NAME = "g"+document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+".txt";
					form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_02&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				}
				else if(form.radCHULJA_TYPE[1].checked == true){
					FILE_NAME = "g"+document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"_�űԻ�����.txt";
					form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_02_1&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				}
				else{
					FILE_NAME = "g"+document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"_�ٷα��к���.txt";
					form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_02_2&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				}


	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==3){//�����ȯ��
				//����

			}else if(document.tabSAGA120.ActiveIndex==4){//��������
				/*
	            if (dsT_AC_RETACC_04.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_AC_RETACC_04.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }
				*/
    	        FILE_NAME = "C2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_04&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&PIS_YMD="+PIS_YMD+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==5){//�����ҵ�_1
	            if (dsT_AC_RETTABLE_05.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_AC_RETTABLE_05.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }

    	        FILE_NAME = "E2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_05&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==6){//�����ҵ�
	            if (dsT_AC_RETTABLE_09.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_AC_RETTABLE_09.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }

    	        FILE_NAME = "EA028123.012";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_09&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==7){//��������
				//����

			}else if(document.tabSAGA120.ActiveIndex==8){//�Ƿ��Ű�
	            if (dsT_AC_MEDICAL_07.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_AC_MEDICAL_07.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }

	            //�������ڰ� ������ ��ȸ����.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڸ� �Է��ϼ���.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//�������ڰ� �߸��Ǿ����� ��ȸ����.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڰ� �߸��Ǿ����ϴ�.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "CA2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_07&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==9){//��αݽŰ�
	            if (dsT_AC_DONATION_08.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_AC_DONATION_08.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }

	            //�������ڰ� ������ ��ȸ����.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڸ� �Է��ϼ���.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//�������ڰ� �߸��Ǿ����� ��ȸ����.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڰ� �߸��Ǿ����ϴ�.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "H2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_08&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==10){//�Ͽ���
	            if (dsT_CA_PAYMASTER_10.CountColumn == 0) {
	                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
	                return;
	            }

	            if (dsT_CA_PAYMASTER_10.CountRow < 1) {
	                alert("������ ����Ÿ�� �����ϴ�.");
	                return;
	            }

	            //�������ڰ� ������ ��ȸ����.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڸ� �Է��ϼ���.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//�������ڰ� �߸��Ǿ����� ��ȸ����.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڰ� �߸��Ǿ����ϴ�.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "I2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_10&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;
	            form.submit();
	            
            }

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
    | 2. �̸� : dsT_CP_PAYMASTER_01                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_LOAN_02                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_LOAN_03                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_RETACC_04                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETACC_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_RETTABLE_05                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETTABLE_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_LOAN_06                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN_06" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_MEDICAL_07                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_MEDICAL_07" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">        
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_DONATION_08                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_DONATION_08" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_AC_RETTABLE_09                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETTABLE_09" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CA_PAYMASTER_10                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CA_PAYMASTER_10" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���ε�� Data Transacton                             |
    | 2. �̸� : trFILE_UPLOAD_03                                       |
    | 3. Table List :                                                            |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD_03" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���ε�� Data Transacton                             |
    | 2. �̸� : trFILE_UPLOAD_06                                       |
    | 3. Table List :                                                            |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD_06" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_AC_LOAN_03                                           |
    | 3. Table List : T_AC_LOAN                                         |
    +----------------------------------------------->
    <Object ID ="trT_AC_LOAN_03" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_AC_RETACC_04                                           |
    | 3. Table List :                                                             |
    +----------------------------------------------->
    <Object ID ="trT_AC_RETACC_04" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_AC_LOAN_06                                           |
    | 3. Table List : T_AC_LOAN                                         |
    +----------------------------------------------->
    <Object ID ="trT_AC_LOAN_06" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

	<!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_LOAN_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_LOAN_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_RETACC_04 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_RETTABLE_05 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_LOAN_06 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_MEDICAL_07 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_DONATION_08 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_RETTABLE_09 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CA_PAYMASTER_10 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>
    
    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_LOAN_02 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_LOAN_03 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_RETACC_04 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_RETTABLE_05 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_LOAN_06 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_MEDICAL_07 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_DONATION_08 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_RETTABLE_09 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CA_PAYMASTER_10 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_LOAN_02 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_LOAN_03 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_RETACC_04 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_RETTABLE_05 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_LOAN_06 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_MEDICAL_07 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_DONATION_08 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_RETTABLE_09 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_CA_PAYMASTER_10 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>
    
    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_AC_LOAN_03 event="OnSuccess()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </script>

    <script for=trFILE_UPLOAD_03 event="OnSuccess()">

   		var iCount1 = dsT_AC_LOAN_03.CountRow;

		if (iCount1 == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount1);
        }

    </script>

    <script for=trT_AC_RETACC_04 event="OnSuccess()">

   		var iCount = dsT_AC_RETACC_04.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </script>

    <script for=trT_AC_LOAN_06 event="OnSuccess()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </script>

    <script for=trFILE_UPLOAD_06 event="OnSuccess()">

   		var iCount1 = dsT_AC_LOAN_06.CountRow;

		if (iCount1 == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount1);
        }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trFILE_UPLOAD_03 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_LOAN_03 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_RETACC_04 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trFILE_UPLOAD_06 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_LOAN_06 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!----------------------+
    | �� ����� ����� �̺�Ʈ  |
    +----------------------->
    <script language=JavaScript for=tabSAGA120 event=OnSelChanged(index)>
			if(document.tabSAGA120.ActiveIndex==1){//�޻��Ա�
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش���";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "none";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==2){//���ڱ�
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش���";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==3){//�����ȯ��
				document.getElementById("changeButton_01").style.display = "none";
				document.getElementById("changeButton_02").style.display = "";
				document.getElementById("searchMessage_01").innerText = "�ش���";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "none";
				document.getElementById("divSAGA120_file_01").style.display = "";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==4){//��������
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش���";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==5){//�����ҵ�_1
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش�⵵";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==6){//�����ҵ�_2
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش�⵵";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==7){//��������
				document.getElementById("changeButton_01").style.display = "none";
				document.getElementById("changeButton_02").style.display = "";
				document.getElementById("searchMessage_01").innerText = "�ش���";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "none";
				document.getElementById("divSAGA120_file_01").style.display = "";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==8){//�Ƿ��Ű�
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش�⵵";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==9){//��αݽŰ�
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش�⵵";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==10){//�Ͽ���
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "�ش���";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;
			
	  			
            }
	</script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- ���� ������ ���� -->
<iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ڷ�UP/DOWN</td>
					<td align="right" class="navigator">HOME/�������/�޿�����/<font color="#000000">�ڷ�UP/DOWN</font></td>
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
			<div id="changeButton_01" style="position:absolute; left:562; top:49; width:60; height:20; z-index:1;" >
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
           	</div>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
			<div id="changeButton_02" style="position:absolute; left:562; top:49; width:60; height:20; z-index:1;" >
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            </div>
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
								<col width="10"></col>
								<col width="80"></col>
								<col width="190"></col>
								<col width="80"></col>
								<col width="180"></col>
								<col width="80"></col>
								<col width="100"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState"><span id="searchMessage_01"></span></td>
								<td>
									<div id="changeDate_01" style="position:absolute; left:121; top:93; width:120; height:20; z-index:1;" >
										<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
						           	</div>
									<div id="changeDate_02" style="position:absolute; left:121; top:93; width:120; height:20; z-index:1;" >
										<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
						           	</div>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="WIDTH:70">
										<option value="0" >��  ��</option>
	                                    <option value="1" >��  ��</option>
	                                    <option value="4" >��  ��</option>
									</select>
								</td>
								<td align="center" class="searchState">�Ϸù�ȣ</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:60">
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

<!-- �ǿ� ���� DISPLAY ���� -->
<div id="divSAGA120_file" style="position:absolute; left:617; top:152; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right" >
			<a  href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFilecreate','','/images/button/btn_FilecreateOver.gif',3)" >
				<img src="/images/button/btn_FilecreateOn.gif" id="imgFilecreate" name="imgFilecreate" width="80" height="20" border="0" align="absmiddle" onClick="fnc_ToFile()" >
			</a>
		</td>
	</tr>
	</table>
</div>

<!-- �������� -->
<div id="divSAGA120_file_01" style="position:absolute; left:617; top:152; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td align="right" style="padding-right:5px; padding-top:2px;">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('saga120.xls', '<%=FILEURL %>/saga120.xls');"></a>
        </td>
		<td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
			<a  href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFileAdd','','/images/button/FileAddOver.gif',3)" >
				<img src="/images/button/FileAddOn.gif" id="imgFileAdd" name="imgFileAdd" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()" >
			</a>
		</td>
	</tr>
	</table>
</div>
<!-- �������� -->

<div id="divSAGA120_file_02" style="position:absolute; left:617; top:130; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right" >
				��������
				<input id="txtPIS_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD','','634','150');"></a>
		</td>
	</tr>
	</table>
</div>
<!-- �ǿ� ���� DISPLAY �� -->

		<!--<T>divid="tabSAGA120_01"	title="�޻�"</T>-->
		<!--<T>divid="tabSAGA120_02"	title="���ڱ�"</T>-->
		<!--<T>divid="tabSAGA120_03"	title="�����ȯ"</T>-->
		<!--<T>divid="tabSAGA120_04"	title="��������"</T>-->
		<!--<T>divid="tabSAGA120_05"	title="�����ҵ�1"</T>-->
		<!--<T>divid="tabSAGA120_09"	title="�����ҵ�2"</T>-->
		<!--<T>divid="tabSAGA120_06"	title="��������"</T>-->
		<!--<T>divid="tabSAGA120_07"	title="�Ƿ��"</T>-->
		<!--<T>divid="tabSAGA120_08"	title="��α�"</T>-->

<!-- �� ��� ���۳�Ʈ ���� -->
<comment id="__NSID__">
<object id=tabSAGA120 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
		style="position:absolute; left:20; top:155; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#F8B97B">
	<param name="DisableBackColor"		value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 			value="1">
	<param name="Format"					value='

		<T>divid="tabSAGA120_01"	title="�޻�"</T>
		<T>divid="tabSAGA120_02"	title="���ڱ�"</T>
		<T>divid="tabSAGA120_03"	title="�����ȯ"</T>
		<T>divid="tabSAGA120_04"	title="��������"</T>
		<T>divid="tabSAGA120_05"	title="����1"</T>
		<T>divid="tabSAGA120_09"	title="����2"</T>
		<T>divid="tabSAGA120_06"	title="����"</T>
		<T>divid="tabSAGA120_07"	title="�Ƿ��"</T>
		<T>divid="tabSAGA120_08"	title="��α�"</T>
		<T>divid="tabSAGA120_10"	title="�Ͽ���"</T>

	'>
</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!-- �� ��� ���۳�Ʈ �� -->

<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA120_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:5;" >

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
						<C> id="{currow}"			width=44		name="NO"				align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=100		name="�Ҽ�"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=100		name="����"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=100		name="���"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=100		name="����"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO"				width=135		name="���¹�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="PAY_AMT"			width=100		name="�Աݾ�"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REMARK"				width=100		name="���"				align=left			Edit=none		SubBgColor="#99FFCC"	</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>

                <div style="visibility:hidden; position:absolute; display:none;">
                    <!-- ���� ����� ���� -->
                    <comment id="__NSID__">
                    <object id="grdT_CP_PAYMASTER_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CP_PAYMASTER_01">
                        <param name="EdiTABLE"                  value="false">
                        <param name="DragDropEnable"            value="true">
                        <param name="SortView"                  value="Left">
                        <param name="VIEWSUMMARY"               value=0>
                        <param name="Format" value='
                            <C> id="ENO_NO"             width=135       name="���"            align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                            <C> id="GBN"                width=100       name="�����ڵ�"        align=left          Edit=none       SubBgColor="#99FFCC"    </C>
                            <C> id="ACC_NO"             width=135       name="���¹�ȣ"        align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                            <C> id="PAY_AMT"            width=100       name="�Աݾ�"          align=right         Edit=none       SubBgColor="#99FFCC"    </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                </div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��1 ���� �Է� ���̺� �� -->

<!-- ��2 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA120_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

<table width="800" border=1 cellspacing="0" cellpadding="0">
	<tr height="30px" border=1 align=right>
		<td class="tabBold" align="right">
			<input type="radio" name="radCHULJA_TYPE" id="radCHULJA_TYPE" checked style="margin-bottom:-2px;border:0;" value="A" onClick="fnc_SearchList();">���ڱ�
			<input type="radio" name="radCHULJA_TYPE" id="radCHULJA_TYPE" style="margin-bottom:-2px;border:0;" value="B" onClick="fnc_SearchList();">�űԻ�����
			<input type="radio" name="radCHULJA_TYPE" id="radCHULJA_TYPE" style="margin-bottom:-2px;border:0;" value="C" onClick="fnc_SearchList();">�ٷα��к���
			&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table width="800" border=0 cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=44		name="NO"					align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="�Ҽ�"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=70		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="���"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="�ֹε�Ϲ�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_AMT"			width=70		name="���ڱ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EMAENO"				width=70		name="�󼱻��"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OCC_CD"				width=55		name="�ٷα���"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(OCC_CD,"A","�繫��","M","�ù���","C","�����","D","������")}</C>
						<C> id="TAG"				width=60		name="�űԱ���"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="PAY_YMD"			width=80		name="��ü��"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HIR_YMD"			width=80		name="�Ի���"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EM_PHN_NO"			width=90		name="��ȭ��ȣ"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
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
<div class=page id="tabSAGA120_03" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=35		name="NO"					align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="�Ҽ�"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=55		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=65		name="���"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=65		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EMAENO"				width=65		name="�󼱻��"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_AMT"			width=70		name="�����"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_BAK"			width=70		name="�����ܾ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OCC_CD"				width=45		name="�ٷα���"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(OCC_CD,"A","�繫��","M","�ù���","C","�����","D","������")}</C>
						<C> id="GMK_INT"			width=59		name="����"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=90		name="�ֹε�Ϲ�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAL_GBN"			width=35		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(SAL_GBN,"0","�޿�","1","��","2","����")}</C>
						<C> id="DED_TAG"			width=35		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
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
<!-- ��3���� �Է� ���̺� �� -->

<!-- ��4 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA120_04" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETACC_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_RETACC_04">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=44		name="NO"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)}	</C>
						<C> id="REC_TAG"			width=60		name="����"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TAX_CD"				width=60		name="������"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMP_CD"			width=100		name="����ڹ�ȣ"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CNT"				width=70		name="���ٹ�ó��"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR2"			width=100		name="����"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO2"			width=100		name="�ֹε�Ϲ�ȣ"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="ZIP_NO"				width=100		name="�����ȣ"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JUSO"				width=350		name="�ּ�"						align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HOL_YN"				width=100		name="�����ֿ���"						align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAS_NM"				width=100		name="���ٹ�ó"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAO_NO"				width=100		name="���ٹ������ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMTS"			width=100		name="�޿���"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMTB"			width=100		name="�󿩰�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMTT"			width=100		name="�Ѱ�"						align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SEA_FREE"			width=100		name="���ܱٷμҵ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="FREE_INCOME"		width=100		name="������ҵ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="FIN_SALT"			width=100		name="���������ױ޿�"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TAX_INCOME"			width=100		name="�Ѱ����ҵ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MGR_AMT"			width=100		name="�ٷμҵ����"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MNI_AMT"			width=100		name="�ٷμҵ�ݾ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BADD_AMT"			width=100		name="���ΰ���"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SPSB_AMT"			width=100		name="����ڰ���"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DFM_CNT"			width=100		name="�ξ��ڼ�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GDED_AMT"			width=100		name="�ξ簡������"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GOL_CNT"			width=100		name="����ڼ�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GOL_AMT"			width=100		name="����ڰ���"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_CNT"			width=100		name="����ڼ�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TBL_DED"			width=100		name="����ڰ���"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="WDD_AMT"			width=100		name="�γ��ڰ���"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_CNT"			width=100		name="�ڳ��ڼ�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_AMT"			width=100		name="���������"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INP_CNT"			width=100		name="����Ծ��"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INP_AMT"			width=100		name="����Ծ����"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CHI_CNT"            width=100       name="���ڳ��߰��ο�"           align=right         Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="SMD_AMT"			width=100		name="���ڳ��߰�����"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NPEN_DED"			width=100		name="���ݺ�������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="HINU_AMT"			width=100		name="�ǰ������"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HINS_AMT"			width=100		name="��뺸���"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LIN_DED"			width=100		name="���强�����"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LIH_DED"			width=100		name="���������"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="MMA_DED"			width=100		name="�Ƿ��"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_DED"			width=100		name="������"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LOAN_DED"			width=100		name="����������������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="MRENT_DED"			width=100		name="������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="LONG_DED"			width=100		name="���������������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CPC_DED"			width=100		name="��α�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="WFM_DED"			width=100		name="��ȥ����̻�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SPC_TOT"			width=100		name="��Ư�������հ�"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NSE_TOT"			width=100		name="Ư��������"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="STA_TOT"			width=100		name="ǥ�ذ���"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INDED_TOT"			width=100		name="�����ҵ�ݾ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="PER_SAV"			width=100		name="���ο��ݼҵ����"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ANN_DED"			width=100		name="��������ҵ����"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE_DED"			width=100		name="���ø����������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_DED"			width=100		name="�ſ�ī��"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="SAVE1_DED"			width=100		name="û������"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE2_DED"			width=100		name="����û����������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE3_DED"			width=100		name="������ø�������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE4_DED"			width=100		name="�ٷ������ø�������"		align=right			Edit=none		SubBgColor="#99FFCC"	</C>


						<C> id="STOCK_DED"			width=100		name="����ֽ�������"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="VEN_DED"			width=100		name="������������"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TTAX_STD"			width=100		name="���ռҵ����ǥ��"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TAX_AMT"			width=100		name="���⼼��"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HGR_DED"			width=100		name="�ٷμҵ漼�װ���"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="STX_DED"			width=100		name="���༼��"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HTX_DED"			width=100		name="���ü���"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HSX_DED"			width=100		name="�ٷ����ֽļ���"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LSX_DED"			width=100		name="��������ֽļ���"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GOV_DED"			width=100		name="��ġ��αݼ���"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OTX_DED"			width=100		name="�ܱ����μ���"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TDED_TOT"			width=100		name="���װ�����"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DGG_TAX"			width=100		name="�ҵ漼"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DBW_TAX"			width=100		name="��Ư��"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DJM_TAX"			width=100		name="�ֹμ�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAL_AMT"			width=100		name="���ٹ��ҵ漼"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAN_AMT"			width=100		name="���ٹ��ֹμ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INCM_TAX"			width=100		name="���ٹ��ҵ漼"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CITI_TAX"			width=100		name="���ٹ��ֹμ�"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HIR_YMD"			width=100		name="�ͼӽ�����"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX-XX-XX"	</C>
						<C> id="RET_YMD"			width=100		name="�ͼ�������"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX-XX-XX"	</C>
						<C> id="CASH_AMT"			width=100		name="���ݿ�����"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAI_AMT"			width=100		name="������"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_1"			width=100		name="����1"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_1"			width=100		name="����1"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_1"			width=100		name="�ֹι�ȣ1"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_1"			width=100		name="�⺻����1"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_1"			width=100		name="�����1"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_1"			width=100		name="�ڳ����1"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
					    <C> id="WCT_MAN_1"          width=100       name="�γ���1"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_1"          width=100       name="��ο��1"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_1"          width=100       name="���ڳ��߰�1"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="INP_MAN_1"          width=100       name="����Ծ�1"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                    	<C> id="INV_NTS_1"			width=100		name="����û�����1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_1"			width=100		name="����û�Ƿ��1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_1"			width=100		name="����û������1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_1"			width=100		name="����û�ſ�ī��1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_1"			width=100		name="����û����1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_1"			width=100		name="�����1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_1"			width=100		name="�Ƿ��1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_1"			width=100		name="������1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_1"			width=100		name="�ſ�ī��1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_1"			width=100		name="��α�1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_2"			width=100		name="����2"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_2"			width=100		name="����2"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_2"			width=100		name="�ֹι�ȣ2"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_2"			width=100		name="�⺻����2"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_2"			width=100		name="�����2"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_2"			width=100		name="�ڳ����2"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_2"          width=100       name="�γ���2"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_2"          width=100       name="��ο��2"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_2"          width=100       name="���ڳ��߰�2"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_2"          width=100       name="����Ծ�2"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_2"			width=100		name="����û�����2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_2"			width=100		name="����û�Ƿ��2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_2"			width=100		name="����û������2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_2"			width=100		name="����û�ſ�ī��2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_2"			width=100		name="����û����2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_2"			width=100		name="�����2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_2"			width=100		name="�Ƿ��2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_2"			width=100		name="������2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_2"			width=100		name="�ſ�ī��2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_2"			width=100		name="��α�2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_3"			width=100		name="����3"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_3"			width=100		name="����3"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_3"			width=100		name="�ֹι�ȣ3"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_3"			width=100		name="�⺻����3"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_3"			width=100		name="�����3"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_3"			width=100		name="�ڳ����3"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_3"          width=100       name="�γ���3"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_3"          width=100       name="��ο��3"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_3"          width=100       name="���ڳ��߰�3"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_3"          width=100       name="����Ծ�3"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_3"			width=100		name="����û�����3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_3"			width=100		name="����û�Ƿ��3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_3"			width=100		name="����û������3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_3"			width=100		name="����û�ſ�ī��3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_3"			width=100		name="����û����3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_3"			width=100		name="�����3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_3"			width=100		name="�Ƿ��3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_3"			width=100		name="������3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_3"			width=100		name="�ſ�ī��3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_3"			width=100		name="��α�3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_4"			width=100		name="����4"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_4"			width=100		name="����4"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_4"			width=100		name="�ֹι�ȣ4"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_4"			width=100		name="�⺻����4"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_4"			width=100		name="�����4"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_4"			width=100		name="�ڳ����4"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_4"          width=100       name="�γ���4"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_4"          width=100       name="��ο��4"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_4"          width=100       name="���ڳ��߰�4"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_4"          width=100       name="����Ծ�4"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_4"			width=100		name="����û�����4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_4"			width=100		name="����û�Ƿ��4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_4"			width=100		name="����û������4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_4"			width=100		name="����û�ſ�ī��4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_4"			width=100		name="����û����4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_4"			width=100		name="�����4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_4"			width=100		name="�Ƿ��4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_4"			width=100		name="������4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_4"			width=100		name="�ſ�ī��4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_4"			width=100		name="��α�4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_5"			width=100		name="����5"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_5"			width=100		name="����5"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_5"			width=100		name="�ֹι�ȣ5"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_5"			width=100		name="�⺻����5"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_5"			width=100		name="�����5"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_5"			width=100		name="�ڳ����5"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_5"          width=100       name="�γ���5"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_5"          width=100       name="��ο��5"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_5"          width=100       name="���ڳ��߰�5"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_5"          width=100       name="����Ծ�5"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_5"			width=100		name="����û�����5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_5"			width=100		name="����û�Ƿ��5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_5"			width=100		name="����û������5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_5"			width=100		name="����û�ſ�ī��5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_5"			width=100		name="����û����5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_5"			width=100		name="�����5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_5"			width=100		name="�Ƿ��5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_5"			width=100		name="������5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_5"			width=100		name="�ſ�ī��5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_5"			width=100		name="��α�5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_1"		width=100		name="�ҵ��������1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_1"			width=100		name="��������ڵ�1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_1"			width=100		name="���������ȣ1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_1"			width=100		name="���¹�ȣ1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_1"			width=100		name="���Կ���1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_1"			width=100		name="���Աݾ�1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_1"			width=100		name="�����ݾ�1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_2"		width=100		name="�ҵ��������2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_2"			width=100		name="��������ڵ�2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_2"			width=100		name="���������ȣ2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_2"			width=100		name="���¹�ȣ2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_2"			width=100		name="���Կ���2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_2"			width=100		name="���Աݾ�2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_2"			width=100		name="�����ݾ�2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_3"		width=100		name="�ҵ��������3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_3"			width=100		name="��������ڵ�3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_3"			width=100		name="���������ȣ3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_3"			width=100		name="���¹�ȣ3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_3"			width=100		name="���Կ���3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_3"			width=100		name="���Աݾ�3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_3"			width=100		name="�����ݾ�3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_4"		width=100		name="�ҵ��������4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_4"			width=100		name="��������ڵ�4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_4"			width=100		name="���������ȣ4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_4"			width=100		name="���¹�ȣ4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_4"			width=100		name="���Կ���4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_4"			width=100		name="���Աݾ�4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_4"			width=100		name="�����ݾ�4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_5"		width=100		name="�ҵ��������5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_5"			width=100		name="��������ڵ�5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_5"			width=100		name="���������ȣ5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_5"			width=100		name="���¹�ȣ5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_5"			width=100		name="���Կ���5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_5"			width=100		name="���Աݾ�5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_5"			width=100		name="�����ݾ�5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_6"		width=100		name="�ҵ��������6"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_6"			width=100		name="��������ڵ�6"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_6"			width=100		name="���������ȣ6"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_6"			width=100		name="���¹�ȣ6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_6"			width=100		name="���Կ���6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_6"			width=100		name="���Աݾ�6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_6"			width=100		name="�����ݾ�6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_7"		width=100		name="�ҵ��������7"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_7"			width=100		name="��������ڵ�7"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_7"			width=100		name="���������ȣ7"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_7"			width=100		name="���¹�ȣ7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_7"			width=100		name="���Կ���7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_7"			width=100		name="���Աݾ�7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_7"			width=100		name="�����ݾ�7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_8"		width=100		name="�ҵ��������8"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_8"			width=100		name="��������ڵ�8"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_8"			width=100		name="���������ȣ8"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_8"			width=100		name="���¹�ȣ8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_8"			width=100		name="���Կ���8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_8"			width=100		name="���Աݾ�8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_8"			width=100		name="�����ݾ�8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_9"		width=100		name="�ҵ��������9"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_9"			width=100		name="��������ڵ�9"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_9"			width=100		name="���������ȣ9"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_9"			width=100		name="���¹�ȣ9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_9"			width=100		name="���Կ���9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_9"			width=100		name="���Աݾ�9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_9"			width=100		name="�����ݾ�9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_10"	width=100		name="�ҵ��������10"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_10"			width=100		name="��������ڵ�10"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_10"			width=100		name="���������ȣ10"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_10"			width=100		name="���¹�ȣ10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_10"		width=100		name="���Կ���10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_10"			width=100		name="���Աݾ�10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_10"			width=100		name="�����ݾ�10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_11"	width=100		name="�ҵ��������11"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_11"			width=100		name="��������ڵ�11"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_11"			width=100		name="���������ȣ11"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_11"			width=100		name="���¹�ȣ11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_11"		width=100		name="���Կ���11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_11"			width=100		name="���Աݾ�11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_11"			width=100		name="�����ݾ�11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_12"	width=100		name="�ҵ��������12"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_12"			width=100		name="��������ڵ�12"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_12"			width=100		name="���������ȣ12"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_12"			width=100		name="���¹�ȣ12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_12"		width=100		name="���Կ���12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_12"			width=100		name="���Աݾ�12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_12"			width=100		name="�����ݾ�12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_13"	width=100		name="�ҵ��������13"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_13"			width=100		name="��������ڵ�13"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_13"			width=100		name="���������ȣ13"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_13"			width=100		name="���¹�ȣ13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_13"		width=100		name="���Կ���13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_13"			width=100		name="���Աݾ�13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_13"			width=100		name="�����ݾ�13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_14"	width=100		name="�ҵ��������14"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_14"			width=100		name="��������ڵ�14"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_14"			width=100		name="���������ȣ14"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_14"			width=100		name="���¹�ȣ14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_14"		width=100		name="���Կ���14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_14"			width=100		name="���Աݾ�14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_14"			width=100		name="�����ݾ�14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_15"	width=100		name="�ҵ��������15"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_15"			width=100		name="��������ڵ�15"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_15"			width=100		name="���������ȣ15"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_15"			width=100		name="���¹�ȣ15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_15"		width=100		name="���Կ���15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_15"			width=100		name="���Աݾ�15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_15"			width=100		name="�����ݾ�15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
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
<div class=page id="tabSAGA120_05" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETTABLE_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_RETTABLE_05">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=40		name="NO"						align=center	Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>

						<G>name="�ҵ���"		HeadBgColor="#F7DCBB"
							<C> id="COL6"			width=100		name="��(��)�ٹ�ó��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL7_NM"	width=100		name="�����ڱ����ڵ�"					align=center	Edit=none		SubBgColor="#99FFCC"	value={DECODE(COL7,"1","������","�������")}</C>
							<C> id="COL9"			width=120		name="�ͼӿ������ۿ�����"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL10"			width=120		name="�ͼӿ������Ῥ����"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL11"			width=100		name="����"							align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL13"			width=100		name="�ֹε�Ϲ�ȣ"					align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="��(��)�ҵ�����ó����"		HeadBgColor="#F7DCBB"
							<C> id="COL14"			width=100		name="�����޿�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL15"			width=100		name="����������"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL16"			width=100		name="���������Ͻñ�"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL17"			width=100		name="��"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL18"			width=100		name="������ҵ�"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="��(��)�ٹ����������ݸ�"		HeadBgColor="#F7DCBB"
							<C> id="COL19"			width=100		name="�Ѽ��ɾ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL20"			width=100		name="�������հ��"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL21"			width=100		name="�ҵ��ں��Ծ�"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL22"			width=120		name="�������ݼҵ������"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL23"			width=100		name="���������Ͻñ�"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="����ȯ���"		HeadBgColor="#F7DCBB"
							<C> id="COL24"			width=150		name="���������Ͻñ����޿����"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL25"			width=100		name="���Ͻñ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL26"			width=120		name="���ɰ��������޿���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL27"			width=120		name="ȯ�������ҵ����"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL28"			width=150		name="ȯ�������ҵ��������ǥ��"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL29"			width=120		name="ȯ�꿬��հ���ǥ��"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL30"			width=120		name="ȯ�꿬��ջ��⼼��"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="�ټӿ���"		HeadBgColor="#F7DCBB"
							<C> id="COL31"			width=140		name="��(��)�ٹ����Ի翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL32"			width=140		name="��(��)�ٹ�����翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL33"			width=130		name="��(��)�ٹ����ټӿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL34"			width=130		name="��(��)�ٹ������ܿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL35"			width=140		name="��(��)�ٹ����Ի翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL36"			width=140		name="��(��)�ٹ�����翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL37"			width=130		name="��(��)�ٹ����ټӿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL38"			width=130		name="��(��)�ٹ������ܿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL39"			width=100		name="�ߺ�����"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL40"			width=100		name="�ټӿ���"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="�����"		HeadBgColor="#F7DCBB"
							<C> id="COL41"			width=100		name="�����޿���"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL42"			width=100		name="�����ҵ����"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL43"			width=120		name="�����ҵ����ǥ��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL44"			width=100		name="����հ���ǥ��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL45"			width=100		name="����ջ��⼼��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL46"			width=100		name="���⼼��"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="��������"		HeadBgColor="#F7DCBB"
							<C> id="COL47"			width=100		name="�ҵ漼"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL48"			width=100		name="�ֹμ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL49"			width=100		name="��Ư��"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL50"			width=100		name="��"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="�ⳳ�μ���(��(��)�ٹ���)"		HeadBgColor="#F7DCBB"
							<C> id="COL51"			width=100		name="�ҵ漼"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL52"			width=100		name="�ֹμ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL53"			width=100		name="��Ư��"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL54"			width=100		name="��"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>
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
<div class=page id="tabSAGA120_06" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN_06" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN_06">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=40		name="NO"				align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="OCC_CD"				width=80		name="�ٷα���"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=80		name="����"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DPT_NM"				width=99		name="�Ҽ�"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=80		name="����"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=80		name="���"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_PAY"			width=80		name="����ݾ�"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_INT"			width=80		name="���ڻ�ȯ��"		align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_AMT"			width=80		name="���ݻ�ȯ��"		align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_BAK"			width=80		name="�����ܾ�"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
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
<div class=page id="tabSAGA120_07" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_MEDICAL_07" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_MEDICAL_07">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=40		name="NO"								align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="�Ҽ�"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=60		name="����"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="���"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="�ֹε�Ϲ�ȣ"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAT_CD"				width=80		name="���ܱ���"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="����"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"				width=90		name="����ڹ�ȣ"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NM"			width=180		name="��ü��"							align=center		Edit=none		SubBgColor="#99FFCC"	SubSumText=" �� �� "</C>
						<C> id="MED_CD"				width=80		name="�����ڵ�"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="�Ǽ�"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="���ޱݾ�"						align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_NM"				width=120		name="����"							align=center		Edit=none		SubBgColor="#99FFCC"	show=false</C>
						<C> id="TCET_NO"			width=140		name="������ֹε�Ϲ�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAT_CD2"			width=80		name="���ܱ���"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMM_CD"			width=50		name="����"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
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

<!-- ��8 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA120_08" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_DONATION_08" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_DONATION_08">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=44		name="NO"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="�Ҽ�"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=60		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="���"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="�ֹε�Ϲ�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"				width=90		name="����ڹ�ȣ"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NM"			width=180		name="��ü��"					align=center		Edit=none		SubBgColor="#99FFCC"	SubSumText=" �� �� "</C>
						<C> id="REL_NM"				width=60		name="�������"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="�Ǽ�"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="�ݾ�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
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
<!-- ��8 ���� �Է� ���̺� �� -->


<!-- ��9 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA120_09" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETTABLE_09" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_RETTABLE_09">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=40		name="NO"						align=center	Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>

						<G>name="�ҵ���"		HeadBgColor="#F7DCBB"
							<C> id="COL6"			width=100		name="��(��)�ٹ�ó��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL7_NM"	width=100		name="�����ڱ����ڵ�"					align=center	Edit=none		SubBgColor="#99FFCC"	value={DECODE(COL7,"1","������","�������")}</C>
							<C> id="COL9"			width=120		name="�ͼӿ������ۿ�����"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL10"			width=120		name="�ͼӿ������Ῥ����"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL11"			width=100		name="����"							align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL13"			width=100		name="�ֹε�Ϲ�ȣ"					align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="��(��)�ҵ�����ó����"		HeadBgColor="#F7DCBB"
							<C> id="COL14"			width=100		name="�����޿�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL15"			width=100		name="����������"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL16"			width=100		name="���������Ͻñ�"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL17"			width=100		name="��"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL18"			width=100		name="������ҵ�"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="��(��)�ٹ����������ݸ�"		HeadBgColor="#F7DCBB"
							<C> id="COL19"			width=100		name="�Ѽ��ɾ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL20"			width=100		name="�������հ��"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL21"			width=100		name="�ҵ��ں��Ծ�"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL22"			width=120		name="�������ݼҵ������"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL23"			width=100		name="���������Ͻñ�"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="����ȯ���"		HeadBgColor="#F7DCBB"
							<C> id="COL24"			width=150		name="���������Ͻñ����޿����"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL25"			width=100		name="���Ͻñ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL26"			width=120		name="���ɰ��������޿���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL27"			width=120		name="ȯ�������ҵ����"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL28"			width=150		name="ȯ�������ҵ��������ǥ��"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL29"			width=120		name="ȯ�꿬��հ���ǥ��"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL30"			width=120		name="ȯ�꿬��ջ��⼼��"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="�ټӿ���"		HeadBgColor="#F7DCBB"
							<C> id="COL31"			width=140		name="��(��)�ٹ����Ի翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL32"			width=140		name="��(��)�ٹ�����翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL33"			width=130		name="��(��)�ٹ����ټӿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL34"			width=130		name="��(��)�ٹ������ܿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL35"			width=140		name="��(��)�ٹ����Ի翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL36"			width=140		name="��(��)�ٹ�����翬����"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL37"			width=130		name="��(��)�ٹ����ټӿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL38"			width=130		name="��(��)�ٹ������ܿ���"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL39"			width=100		name="�ߺ�����"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL40"			width=100		name="�ټӿ���"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="�����"		HeadBgColor="#F7DCBB"
							<C> id="COL41"			width=100		name="�����޿���"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL42"			width=100		name="�����ҵ����"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL43"			width=120		name="�����ҵ����ǥ��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL44"			width=100		name="����հ���ǥ��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL45"			width=100		name="����ջ��⼼��"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL46"			width=100		name="���⼼��"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="��������"		HeadBgColor="#F7DCBB"
							<C> id="COL47"			width=100		name="�ҵ漼"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL48"			width=100		name="�ֹμ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL49"			width=100		name="��Ư��"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL50"			width=100		name="��"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="�ⳳ�μ���(��(��)�ٹ���)"		HeadBgColor="#F7DCBB"
							<C> id="COL51"			width=100		name="�ҵ漼"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL52"			width=100		name="�ֹμ�"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL53"			width=100		name="��Ư��"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL54"			width=100		name="��"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>
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
<!-- ��9 ���� �Է� ���̺� �� -->

<!-- ��10 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA120_10" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CA_PAYMASTER_10" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CA_PAYMASTER_10">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=30		name="��"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="�Ҽ�"					align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=60		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NATION"				width=60		name="��/��"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(NATION,"0","������","�ܱ���")}</C>						

						<C> id="WRK_YM"				width=60		name="���޿�"					align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX/XX"	</C>						
						<C> id="WRK_YM2"			width=60		name="�ٹ���"					align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX/XX"	</C>
						<C> id="CNT"					width=60		name="�ٹ���"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>						
						<C> id="WRK_PAY"			width=70		name="������"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>						
						<C> id="NOTAX"				width=70		name="�����"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>			
																		
						<C> id="INCM_TAX"			width=60		name="�ҵ漼"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CITI_TAX"			width=60		name="���漼"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>				

						<C> id="CET_NO"				width=100		name="�ֹε�Ϲ�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="PH_NO"				width=100		name="��ȭ��ȣ"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>						
								
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
<!-- ��10 ���� �Է� ���̺� �� -->



</form>
<!-- form �� -->

</body>
</html>
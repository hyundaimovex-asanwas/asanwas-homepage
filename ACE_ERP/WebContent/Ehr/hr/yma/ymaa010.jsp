<!--
    ************************************************************************************
    * @source         : ymaa010.jsp 				                                                                                     *
    * @description   : ���������۾����� PAGE.                                                                             *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/25  |  ������   | �����ۼ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���������۾�����</title>
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
		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���

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
            dsT_CP_WORKLOG.DataID = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR;
            dsT_CP_WORKLOG.Reset();

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

			fnc_OnLoadProcess();
			dsT_CP_WORKLOG.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtPRO_STS_MSG").value = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = "A"; // �ٷα��б���
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_WORKLOG.IsUpdated)  {

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

        	if (!dsT_CP_WORKLOG.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 1;
			var oPIS_YYMM;

			/*
			oPIS_YYMM = dsT_CP_WORKLOG.NameValue(i,"PIS_YYMM");
			if(oPIS_YYMM.trim().length == 0){
				alert("�������� �߸��Ǿ����ϴ�.");
				dsT_CP_WORKLOG.RowPosition = i;
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
			//cfStyleGrid(form1.grdT_CP_WORKLOG,0,"false","false");

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);

			//�ٷα���
			if(document.getElementById("cmbOCC_CD_SHR").length == 0){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
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

         //�۾� OPEN
         function object_sts_1(){

         	var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���
			var SAL_GBN_SHR = "4";//����
			var PRO_STS = "1";//�۾���Ȳ

			var i = 1;
			var oPAY_YMD, oSTR_YYMM, oEND_YYMM,  oAPY_YMD;

			oPAY_YMD = dsT_CP_WORKLOG.NameValue(i,"PAY_YMD");
			if(oPAY_YMD.trim().length == 0){
				alert("�������ڸ� �Է��ϼ���.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}
			if(oPAY_YMD.trim().length != 10){
				alert("�������ڰ� �߸��Ǿ����ϴ�.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}

			oSTR_YYMM = dsT_CP_WORKLOG.NameValue(i,"STR_YYMM");
			if(oSTR_YYMM.trim().length == 0){
				alert("���Ⱓ ���۳���� �Է��ϼ���.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}
			if(oSTR_YYMM.trim().length != 7){
				alert("���Ⱓ ���۳���� �߸��Ǿ����ϴ�.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}

			oEND_YYMM = dsT_CP_WORKLOG.NameValue(i,"END_YYMM");
			if(oEND_YYMM.trim().length == 0){
				alert("���Ⱓ �������� �Է��ϼ���.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			if(oEND_YYMM.trim().length != 7){
				alert("���Ⱓ �������� �߸��Ǿ����ϴ�.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			
			if(oSTR_YYMM.substring(0,4) != oEND_YYMM.substring(0,4)){
                alert("���Ⱓ�� ���۳⵵�� ����⵵�� ���ƾ��մϴ�.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
			}
			
			if(oSTR_YYMM.replace("-", "").replace("-", "") > oEND_YYMM.replace("-", "").replace("-", "")){
                alert("�������� ���۳������ �����ϴ�.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
			}

			oAPY_YMD = dsT_CP_WORKLOG.NameValue(i,"APY_YMD");
			if(oAPY_YMD.trim().length == 0){
				alert("ȣ��ǥ���ڸ� �Է��ϼ���.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}
			if(oAPY_YMD.trim().length != 10){
				alert("ȣ��ǥ���ڰ� �߸��Ǿ����ϴ�.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}

			//Ű���� ���� �־�� Ʈ��������� �Ѿ��.
			dsT_CP_WORKLOG.NameValue(i,"PIS_YY")=PIS_YYMM_SHR.substring(0,4);
			dsT_CP_WORKLOG.NameValue(i,"PIS_MM")=PIS_YYMM_SHR.substring(5,7);
			dsT_CP_WORKLOG.NameValue(i,"OCC_CD")=OCC_CD_SHR;
			dsT_CP_WORKLOG.NameValue(i,"SAL_GBN")=SAL_GBN_SHR;
			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV";
			trT_CP_WORKLOG.Post();

         }

         //����� ����
         function object_sts_2(){

			var i = 1;
			var oPAY_YMD, oSTR_YYMM, oEND_YYMM,  oAPY_YMD;

			oPAY_YMD = dsT_CP_WORKLOG.NameValue(i,"PAY_YMD");
			if(oPAY_YMD.trim().length == 0){
				alert("�������ڸ� �Է��ϼ���.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}
			if(oPAY_YMD.trim().length != 10){
				alert("�������ڰ� �߸��Ǿ����ϴ�.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}

			oSTR_YYMM = dsT_CP_WORKLOG.NameValue(i,"STR_YYMM");
			if(oSTR_YYMM.trim().length == 0){
				alert("���Ⱓ ���۳���� �Է��ϼ���.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}
			if(oSTR_YYMM.trim().length != 7){
				alert("���Ⱓ ���۳���� �߸��Ǿ����ϴ�.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}

			oEND_YYMM = dsT_CP_WORKLOG.NameValue(i,"END_YYMM");
			if(oEND_YYMM.trim().length == 0){
				alert("���Ⱓ �������� �Է��ϼ���.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			if(oEND_YYMM.trim().length != 7){
				alert("���Ⱓ �������� �߸��Ǿ����ϴ�.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			
            if(oSTR_YYMM.substring(0,4) != oEND_YYMM.substring(0,4)){
                alert("���Ⱓ�� ���۳⵵�� ����⵵�� ���ƾ��մϴ�.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
            }
            
            if(oSTR_YYMM.replace("-", "").replace("-", "") > oEND_YYMM.replace("-", "").replace("-", "")){
                alert("�������� ���۳������ �����ϴ�.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
            }

			oAPY_YMD = dsT_CP_WORKLOG.NameValue(i,"APY_YMD");
			if(oAPY_YMD.trim().length == 0){
				alert("ȣ��ǥ���ڸ� �Է��ϼ���.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}
			if(oAPY_YMD.trim().length != 10){
				alert("ȣ��ǥ���ڰ� �߸��Ǿ����ϴ�.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}

            if (confirm("����� ������ �Ͻðڽ��ϱ�? ") == false) return;

			var PRO_STS = "2";//�۾���Ȳ

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;
            
            
            //db�� �ִ� Ŀ���� ������ ���Ͽ� ������ �۾�
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_01&TR_SEQ=1";
			trT_CP_WORKLOG.Post();
			
            dsT_CP_WORKLOG.UseChangeInfo = "false";
            			
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_01&TR_SEQ=2";
			trT_CP_WORKLOG.Post();
			
			dsT_CP_WORKLOG.UseChangeInfo = "true";

         }

         //���
         function object_sts_4(){

            if (confirm("����� �Ͻðڽ��ϱ�? ") == false) return;

			var PRO_STS = "4";//�۾���Ȳ

			var i = 1;

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_03";
			trT_CP_WORKLOG.Post();

         }

         //����� �ʱ�ȭ
         function object_sts_2_reset(){
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

			if(PRO_STS == "2"){//����ڼ��� �ʱ�ȭ

	            if (confirm("����� �ʱ�ȭ�� �Ͻðڽ��ϱ�? ") == false) return;

				PRO_STS = "1";//����ڼ������� ����

				dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

				//Ʈ����� ����
				trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
				trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_02";
				trT_CP_WORKLOG.Post();
			}
         }

         //��� �ʱ�ȭ
         function object_sts_4_reset(){
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

			if(PRO_STS == "4"){//��� �ʱ�ȭ

	            if (confirm("��� �ʱ�ȭ�� �Ͻðڽ��ϱ�? ") == false) return;

				PRO_STS = "2";//������� ����

				dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

				//Ʈ����� ����
				trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
				trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_04";
				trT_CP_WORKLOG.Post();
			}
         }

         //�۾�CLOSE
         function object_sts_6(){
            if (confirm("�۾�CLOSE�� �Ͻðڽ��ϱ�? ") == false) return;

			var PRO_STS = "6";//�۾���Ȳ

			var i = 1;

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_05";
			trT_CP_WORKLOG.Post();
         }

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(state){

			//��ȸ�ʵ�� ��� �Ұ����ϰ�
			document.form1.txtPIS_YYMM_SHR.readOnly = true;
  			document.form1.txtPIS_YYMM_SHR.className = "input_ReadOnly";
  			document.getElementById("imgPIS_YYMM_SHR").disabled = true;
  			document.getElementById("cmbOCC_CD_SHR").disabled = true;

  			if(state == "0"){//�۾�OPEN����
				document.form1.txtPAY_YMD.readOnly = false;
	  			document.form1.txtPAY_YMD.className = "";
	  			document.getElementById("imgPAY_YMD").disabled = false;
				document.form1.txtSTR_YYMM.readOnly = false;
	  			document.form1.txtSTR_YYMM.className = "";
	  			document.getElementById("imgSTR_YYMM").disabled = false;
				document.form1.txtEND_YYMM.readOnly = false;
	  			document.form1.txtEND_YYMM.className = "";
	  			document.getElementById("imgEND_YYMM").disabled = false;
				document.form1.txtAPY_YMD.readOnly = false;
	  			document.form1.txtAPY_YMD.className = "";
	  			document.getElementById("imgAPY_YMD").disabled = false;

	  			document.getElementById("btnPRO_STS_1").disabled = false;
				document.getElementById("btnPRO_STS_1").className="";//�۾�OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//���
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//����� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//��� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//�۾�CLOSE
  			}

  			else if(state == "1"){//�۾�OPEN �Ϸ�
				document.form1.txtPAY_YMD.readOnly = false;
	  			document.form1.txtPAY_YMD.className = "";
	  			document.getElementById("imgPAY_YMD").disabled = false;
				document.form1.txtSTR_YYMM.readOnly = false;
	  			document.form1.txtSTR_YYMM.className = "";
	  			document.getElementById("imgSTR_YYMM").disabled = false;
				document.form1.txtEND_YYMM.readOnly = false;
	  			document.form1.txtEND_YYMM.className = "";
	  			document.getElementById("imgEND_YYMM").disabled = false;
				document.form1.txtAPY_YMD.readOnly = false;
	  			document.form1.txtAPY_YMD.className = "";
	  			document.getElementById("imgAPY_YMD").disabled = false;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//�۾�OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = false;
				document.getElementById("btnPRO_STS_2").className="";//����ڼ���
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//���
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//����� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//��� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//�۾�CLOSE
  			}

  			else if(state == "2"){//����� ���� �Ϸ�
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
				document.form1.txtSTR_YYMM.readOnly = true;
	  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgSTR_YYMM").disabled = true;
				document.form1.txtEND_YYMM.readOnly = true;
	  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgEND_YYMM").disabled = true;
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//�۾�OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPRO_STS_4").disabled = false;
				document.getElementById("btnPRO_STS_4").className="";//���
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = false;
				document.getElementById("btnPRO_STS_2_RESET").className="";//����� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//��� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//�۾�CLOSE

  			}

  			else if(state == "4"){//��� �Ϸ�
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
				document.form1.txtSTR_YYMM.readOnly = true;
	  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgSTR_YYMM").disabled = true;
				document.form1.txtEND_YYMM.readOnly = true;
	  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgEND_YYMM").disabled = true;
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//�۾�OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//���
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//����� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = false;
				document.getElementById("btnPRO_STS_4_RESET").className="";//��� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_6").disabled = false;
				document.getElementById("btnPRO_STS_6").className="";//�۾�CLOSE

  			}

  			else if(state == "6"){//�۾�CLOSE
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
				document.form1.txtSTR_YYMM.readOnly = true;
	  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgSTR_YYMM").disabled = true;
				document.form1.txtEND_YYMM.readOnly = true;
	  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgEND_YYMM").disabled = true;
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//�۾�OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//���
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//����� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//��� �ʱ�ȭ
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//�۾�CLOSE

  			}

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			//��ȸ�ʵ�� ��� �����ϰ�
			document.form1.txtPIS_YYMM_SHR.readOnly = false;
  			document.form1.txtPIS_YYMM_SHR.className = "";
  			document.getElementById("imgPIS_YYMM_SHR").disabled = false;
  			document.getElementById("cmbOCC_CD_SHR").disabled = false;

			document.form1.txtPAY_YMD.readOnly = true;
  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
  			document.getElementById("imgPAY_YMD").disabled = true;
			document.form1.txtSTR_YYMM.readOnly = true;
  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
  			document.getElementById("imgSTR_YYMM").disabled = true;
			document.form1.txtEND_YYMM.readOnly = true;
  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
  			document.getElementById("imgEND_YYMM").disabled = true;
			document.form1.txtAPY_YMD.readOnly = true;
  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
  			document.getElementById("imgAPY_YMD").disabled = true;
  			document.getElementById("btnPRO_STS_1").disabled = true;
			document.getElementById("btnPRO_STS_1").className="inputDisabled";//�۾�OPEN
  			document.getElementById("btnPRO_STS_2").disabled = true;
			document.getElementById("btnPRO_STS_2").className="inputDisabled";//����ڼ���
  			document.getElementById("btnPRO_STS_4").disabled = true;
			document.getElementById("btnPRO_STS_4").className="inputDisabled";//���
  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
			document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//���۾�(����ڹװ��)
  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
			document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//���۾�(����ڹװ��)
  			document.getElementById("btnPRO_STS_6").disabled = true;
			document.getElementById("btnPRO_STS_6").className="inputDisabled";//�۾�CLOSE

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
    | 2. �̸� : dsT_CP_WORKLOG                             |
    | 3. Table List : T_CP_WORKLOG                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut    value=100000>
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CP_PAYTABLE                          |
    | 3. Table List : T_CP_PAYTABLE                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_CP_WORKLOG                                       |
    | 3. Table List : T_CP_WORKLOG                                 |
    +----------------------------------------------->
    <Object ID ="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
            <param name=TimeOut    value=1000000>
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">


        if (iCount == 0) {//�����Ͱ� ������ �ű� �۾�OPEN
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.getElementById("txtPRO_STS_MSG").value = "��������ó�� �۾�OPEN �� �� �ֽ��ϴ�.";

            dsT_CP_WORKLOG.AddRow();

            //����� �ʱ�ȭ
			document.getElementById("txtSTR_YYMM").value = getToday().substring(0,4)+"-01";
  			document.getElementById("txtEND_YYMM").value = getToday().substring(0,4)+"-12";

			//�ֱ� ������ ȣ��ǥ���� ��ȸ
			ds01T_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SHR_01";
			ds01T_CP_PAYTABLE.Reset();

			enableInput("0");

			document.getElementById("txtPAY_YMD").focus();

        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "�۾�OPEN�� �Ͽ����ϴ�.";
				enableInput("1");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "����� ������ �Ϸ��Ͽ����ϴ�.";
				enableInput("2");
            }else if(PRO_STS == "3"){
               	//document.getElementById("txtPRO_STS_MSG").value = "����ڼ����Ϸ�";
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "����� �Ϸ��Ͽ����ϴ�.";
               	enableInput("4");
            }else if(PRO_STS == "5"){
               	//document.getElementById("txtPRO_STS_MSG").value = "�۾��Ϸ�";
            }else if(PRO_STS == "6"){
               	document.getElementById("txtPRO_STS_MSG").value = "�۾�CLOSE";
               	enableInput("6");
            }

        }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
			document.getElementById("txtAPY_YMD").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        //alert("�ش� �ʼ��Է��׸�[�ش���/�ٷα���/����/ȣ��] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        //alert("�ش���/�ٷα���/����/ȣ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

		var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

		if(PRO_STS == "1"){
			//document.getElementById("txtPRO_STS_MSG").value = "�۾�OPEN�� �Ͽ����ϴ�.";
			//enableInput("1");
			fnc_SearchList();//����ȸ
		}else if(PRO_STS == "2"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "����� ������ �Ϸ��Ͽ����ϴ�.";
			//enableInput("2");
			fnc_SearchList();//����ȸ
		}else if(PRO_STS == "3"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "����ڼ����Ϸ�";
		}else if(PRO_STS == "4"){
		    //document.getElementById("txtPRO_STS_MSG").value = "����� �Ϸ��Ͽ����ϴ�.";
			//enableInput("4");
			fnc_SearchList();//����ȸ
		}else if(PRO_STS == "5"){
	   		//document.getElementById("txtPRO_STS_MSG").value = "�۾��Ϸ�";
		}else if(PRO_STS == "6"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "�۾�CLOSE";
			//enableInput("6");
			fnc_SearchList();//����ȸ
		}

    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CP_WORKLOG event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���������۾�����</td>
					<td align="right" class="navigator">HOME/�������/��������/<font color="#000000">���������۾�����</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
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
								<col width="50"></col>
								<col width="100"></col>
								<col width="300"></col>
								<col width="100"></col>
								<col width="150"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�ش���</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','130','112');"></a>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:100">
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="140"></col>
					<col width="80"></col>
					<col width="240"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">��������</td>
					<td class="padding2423">
						<input id="txtPAY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPAY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAY_YMD','','65','155');"></a>
					</td>
                    <td align="center" class="creamBold">���Ⱓ</td>
					<td class="padding2423">
						<input id="txtSTR_YYMM" size="8" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YYMM','','290','155');"></a>
						&nbsp;~&nbsp;
						<input id="txtEND_YYMM" size="8" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YYMM','','400','155');"></a>
					</td>
					<td align="center" class="creamBold">ȣ��ǥ����</td>
					<td class="padding2423">
						<input id="txtAPY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD','','620','155');"></a>
					</td>
				</tr>
				<tr>
	        		<td align="center" class="creamBold">����ο�</td>
	        		<td colspan="5">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                  <colgroup>
                                      <col width="100"></col>
                                      <col width="130"></col>
                                      <col width="100"></col>
                                      <col width=""></col>
                                  </colgroup>
                                  <tr>
	        		            <td align="right">ó���ο�&nbsp;</td>
	        		            <td ><input id="txtPRO_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> ��</td>
	        		            <td align="right">��ó���ο�&nbsp;</td>
	        		            <td ><input id="txtERR_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> ��</td>
	        		        <tr>
	        		    </table>
	        		</td>
				</tr>
				<tr>
	        		<td align="center" class="creamBold">�۾���Ȳ</td>
	        		<td  class="padding2423" colspan="5">
	        			<input id="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
	        			<input id="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
	        		</td>
	            </tr>
			</table>
		</td>
	</tr>
</table>
<table>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td class="paddingTop8">
	                    <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                        <colgroup>
	                            <col width="260"></col>
	                            <col width="260"></col>
	                            <col width=""></col>
	                        </colgroup>
	                        <tr height="50">
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_1"  style="cursor:hand;width:110pt;height:25pt;" value=" �۾�OPEN " onclick="object_sts_1();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_2"  style="cursor:hand;width:110pt;height:25pt;" value=" ����ڼ��� " onclick="object_sts_2();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_4"  style="cursor:hand;width:110pt;height:25pt;" value=" ��� " onclick="object_sts_4();">
	                            </td>
	                        </tr>
	                        <tr height="50">
	                            <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_6" style="cursor:hand;width:110pt;height:25pt;" value=" �۾�CLOSE " onclick="object_sts_6();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_2_RESET"  style="cursor:hand;width:110pt;height:25pt;" value=" ����� �ʱ�ȭ " onclick="object_sts_2_reset();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_4_RESET"  style="cursor:hand;width:110pt;height:25pt;" value=" ��� �ʱ�ȭ " onclick="object_sts_4_reset();">
	                            </td>
	                        </tr>
	                    </table>
	                <td>
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
<object id="bndT_CP_WORKLOG" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_WORKLOG">
	<Param Name="BindInfo", Value='
		<C>Col=PRO_STS     		 	Ctrl=txtPRO_STS     		 	Param=value 		</C>
		<C>Col=PAY_YMD     		 	Ctrl=txtPAY_YMD     		 	Param=value 		</C>
		<C>Col=STR_YYMM     	 	Ctrl=txtSTR_YYMM    		 	Param=value 		</C>
		<C>Col=END_YYMM     	 	Ctrl=txtEND_YYMM    		 	Param=value 		</C>
		<C>Col=APY_YMD     		 	Ctrl=txtAPY_YMD     		 	Param=value 		</C>
		<C>Col=PRO_CNT     		 	Ctrl=txtPRO_CNT     		 	Param=value 		</C>
		<C>Col=ERR_CNT		     	Ctrl=txtERR_CNT     		 	Param=value 		</C>
    '>
</object>
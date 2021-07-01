<!--
    ************************************************************************************
    * @Source              : joba010.jsp                                                                                              *
    * @Description        : �����̵�����ڼ���                                                                                  *
    * @Font                   :                                                                                                                 *
    * @Developer Desc :                                                                                                                 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/11  |  ������   | �����ۼ�                                                                                           *
    * 2006/10/20  |  ������   | ���߿Ϸ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����̵�����ڼ���</title>
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

		var btnList = 'TTTTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var f = document.form1;
			//if (!valid(form1)) return;//Validation ����
			try {
	            dsT_EV_JOBHEAD.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SHR";
	            dsT_EV_JOBHEAD.Reset();
				//������ row�� �̵�
				dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

				//�������ڸ� �������ڷ� ����
	            //document.getElementById("txtBASIC_YMD").value = getToday();
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
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
			if(fnc_SaveItemCheck()) {
				document.getElementById("viewflag").value = "1";
				trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
				trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV";
				trT_EV_JOBHEAD.post();

				//�ű������̸� ������ ����� ������ �����ϴ�.
				if(dsT_EV_JOBHEAD.NameValue(dsT_EV_JOBHEAD.RowPosition,"STATUS_JOB") == ""){
					dsT_EV_JOBHEAD.NameValue(dsT_EV_JOBHEAD.RowPosition,"STATUS_JOB") = "0";
					dsT_EV_JOBHEAD.ResetStatus();
					posChanged(dsT_EV_JOBHEAD.RowPosition);
				}
			} else {
				return;
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

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_JOBHEAD.CountColumn == 0) {
                dsT_EV_JOBHEAD.setDataHeader("PIS_YYMM:STRING:KEYVALUETYPE, RSH_DEC:INT, RSHOBJ_01:STRING, RSHOBJ_02:STRING, EXCEPT_MON:INT, TOTAL_CNT:INT, OBJECT_CNT:INT, STATUS_JOB:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_JOBHEAD.AddRow();

            fnc_ColEnabled('E');

			dsT_EV_JOBHEAD.NameValue(dsT_EV_JOBHEAD.RowPosition,"RSH_DEC") = "1";
			document.getElementById("txtPIS_YYMM").focus();
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
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_JOBHEAD.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			// Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_JOBHEAD.ColumnString(dsT_EV_JOBHEAD.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_EV_JOBHEAD.DeleteRow(dsT_EV_JOBHEAD.RowPosition);

            // ���� �� �ش� �׸���� Focus �̵�
            grdT_EV_JOBHEAD.SetColumn(grdT_EV_JOBHEAD.GetColumnID(0));
            grdT_EV_JOBHEAD.Focus();
        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
			dsT_EV_JOBHEAD.ClearData();
			dsT_EV_JOBHEAD.Reset();
			//������ row�� �̵�
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

			fnc_ColEnabled('D');
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        if (dsT_EV_JOBHEAD.IsUpdated)  {

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
			var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
			if (!dsT_EV_JOBHEAD.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oPIS_YYMM, oBASIC_YMD, oRSH_DEC, oRSHOBJ_01, oRSHOBJ_02, oEXCEPT_MON, oRSHOBJ_01, oRSHOBJ_02;
			var RowCnt = dsT_EV_JOBHEAD.CountRow;

			for(i=1; i<=RowCnt; i++){

				oPIS_YYMM = dsT_EV_JOBHEAD.NameValue(i,"PIS_YYMM");
				if(oPIS_YYMM.trim().length == 0){
					alert("�������� �Է��ϼ���.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtPIS_YYMM").focus();
					return false;
				}

				if(!cfDateExpr(oPIS_YYMM) || oPIS_YYMM.trim().length != 7){
					alert("��������  �߸��Ǿ����ϴ�.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtPIS_YYMM").focus();
					return false;
				}

				oBASIC_YMD = dsT_EV_JOBHEAD.NameValue(i,"BASIC_YMD");
				if(oBASIC_YMD.trim().length == 0){
					alert("�������ڸ� �Է��ϼ���.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtBASIC_YMD").focus();
					return false;
				}

				if(!cfDateExpr(oBASIC_YMD) || oBASIC_YMD.trim().length != 10){
					alert("�������ڰ�  �߸��Ǿ����ϴ�.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtBASIC_YMD").focus();
					return false;
				}

				oRSH_DEC = dsT_EV_JOBHEAD.NameValue(i,"RSH_DEC");
				if(oRSH_DEC.toString().trim() == "0"){
					alert("���系����  �߸��Ǿ����ϴ�." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("cmbRSH_DEC").focus();
					return false;
				}

				oRSHOBJ_01 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_01");
				oRSHOBJ_02 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_02");
				if((oRSHOBJ_01.trim() == "F" || oRSHOBJ_01.trim() == "") &&
					(oRSHOBJ_02.trim() == "F" || oRSHOBJ_02.trim() == "")){
					alert("��������  �ϳ��̻� üũ�ϼ���." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("chkRSHOBJ_01").focus();
					return false;
				}

				/*
				oEXCEPT_MON = dsT_EV_JOBHEAD.NameValue(i,"EXCEPT_MON");
				if(oEXCEPT_MON.toString().trim() == "0"){
					alert("���ܴ���� �߸��Ǿ����ϴ�." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtEXCEPT_MON").focus();
					return false;
				}
				*/

				oRSHOBJ_01 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_01");
				oRSHOBJ_02 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_02");

				if(oRSHOBJ_01.toString().trim() == "F" && oRSHOBJ_02.toString().trim() == "F"){//�ƹ� �ٷα��е� ���õ��� ������ �ʵȴ�.
					alert("�ϳ��̻��� �ٷα����� ���õǾ�� �մϴ�." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtEXCEPT_MON").focus();
					return false;
				}

			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_JOBHEAD,0,"false","false");

            fnc_ColEnabled('D');

			//form load�� ������ ������ ��ȸ
            var f = document.form1;
			//if (!valid(form1)) return;//Validation ����
			try {
	            dsT_EV_JOBHEAD.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SHR";
	            dsT_EV_JOBHEAD.Reset();
				//������ row�� �̵�
				//dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

				//�������ڸ� �������ڷ� ����
	            //document.getElementById("txtBASIC_YMD").value = getToday();
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
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

        // üũ�ڽ� Ŭ���� ���ε� ������ ����
		function checkRSHOBJ() {
			var oRSHOBJ_01 = document.getElementById("chkRSHOBJ_01").checked;

			if(oRSHOBJ_01 == true){//true�̸�
				document.getElementById("txtRSHOBJ_01").value = "T";
			}else{//false�̸�
				document.getElementById("txtRSHOBJ_01").value = "F";
			}

			var oRSHOBJ_02 = document.getElementById("chkRSHOBJ_02").checked;

			if(oRSHOBJ_02 == true){//true�̸�
				document.getElementById("txtRSHOBJ_02").value = "T";
			}else{//false�̸�
				document.getElementById("txtRSHOBJ_02").value = "F";
			}
		}

		//����� ����
		function object_set() {
			//DataSet�� ���� ���� Ȯ��
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("���� �����̵���������� ������ �ּ���.");
		    	return false;
			}

            document.getElementById("viewflag").value = "2";
			document.getElementById("txtSTATUS_JOB").value = "1";
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_01";
			trT_EV_JOBHEAD.post();
            dsT_EV_JOBHEAD.Reset();
			//������ row�� �̵�
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

		}

		//����� �缱��
		function object_reset() {
			//DataSet�� ���� ���� Ȯ��
			/*
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("���� �����̵���������� ������ �ּ���.");
		    	return false;
			}
			*/

            document.getElementById("viewflag").value = "3";
   			document.getElementById("txtSTATUS_JOB").value = "0";
			dsT_EV_JOBHEAD.UserStatus(dsT_EV_JOBHEAD.RowPosition) = "1";//���Ƿ� ��������
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_02";
			trT_EV_JOBHEAD.post();
			dsT_EV_JOBHEAD.ResetUserStatus();
			dsT_EV_JOBHEAD.Reset();
			//������ row�� �̵�
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;
		}

		function object_open() {
			//DataSet�� ���� ���� Ȯ��
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("���� �����̵���������� ������ �ּ���.");
		    	return false;
			}

			if (!confirm("����open�� �Ͻðڽ��ϱ�?"))  return;

			document.getElementById("viewflag").value = "";
			document.getElementById("txtSTATUS_JOB").value = "2";
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_03";
			trT_EV_JOBHEAD.post();
            dsT_EV_JOBHEAD.Reset();
			//������ row�� �̵�
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;
		}

		function object_close() {
			//DataSet�� ���� ���� Ȯ��
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("���� �����̵���������� ������ �ּ���.");
		    	return false;
			}

			if (!confirm("����close�� �Ͻðڽ��ϱ�?"))  return;

			document.getElementById("viewflag").value = "";
			document.getElementById("txtSTATUS_JOB").value = "3";
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_04";
			trT_EV_JOBHEAD.post();
            dsT_EV_JOBHEAD.Reset();
			//������ row�� �̵�
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;
		}


		/***************************************
		 * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// �ش� �÷��� �Ӽ��� Enabled�� ����
			if (prop == 'E') {
				form1.txtPIS_YYMM.disabled   = false;
				form1.txtBASIC_YMD.disabled  = false;
				form1.cmbRSH_DEC.disabled    = false;
				form1.chkRSHOBJ_01.disabled  = false;
				form1.chkRSHOBJ_02.disabled  = false;
				form1.txtEXCEPT_MON.disabled = false;

				document.getElementById("img_HelpOn1").disabled = false;
				document.getElementById("img_HelpOn2").disabled = false;
			}
			// �ش� �÷��� �Ӽ��� Disabled�� ����
			else if (prop == 'D') {
				form1.txtPIS_YYMM.disabled   = true;
				form1.txtBASIC_YMD.disabled  = true;
				form1.cmbRSH_DEC.disabled    = true;
				form1.chkRSHOBJ_01.disabled  = true;
				form1.chkRSHOBJ_02.disabled  = true;
				form1.txtEXCEPT_MON.disabled = true;

				document.getElementById("img_HelpOn1").disabled = true;
                document.getElementById("img_HelpOn2").disabled = true;
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
    | 2. �̸� : dsT_EV_JOBHEAD                                       |
    | 3. Table List : T_EV_JOBHEAD                                  |
    +----------------------------------------------->
    <Object ID="dsT_EV_JOBHEAD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_EV_JOBHEAD                                         |
    | 3. Table List : T_EV_JOBHEAD                                   |
    +----------------------------------------------->
    <Object ID ="trT_EV_JOBHEAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_JOBHEAD Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			fnc_ColEnabled('D');
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            fnc_ColEnabled('E');
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_EV_JOBHEAD Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_EV_JOBHEAD Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_EV_JOBHEAD event="OnSuccess()">
	    if(document.getElementById("viewflag").value == "1"){
   			fnc_Message(document.getElementById("resultMessage"), "MSG_01");
	    }else if(document.getElementById("viewflag").value == "2"){
	        alert("����� ������ �Ϸ�Ǿ����ϴ�.");
	    }else if(document.getElementById("viewflag").value == "3"){
	        alert("����� �缱���� �Ϸ�Ǿ����ϴ�.");
	    }
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_EV_JOBHEAD event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!---------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ����                |
    +---------------------------------->
    <script language=JavaScript for=dsT_EV_JOBHEAD event=OnRowPosChanged(row)>
	    posChanged(row);
	</script>
	<script language="javascript" >
	function posChanged(row) {
        if(row != 0){
			var oRSHOBJ_01, oRSHOBJ_02, oSTATUS_JOB;

			oRSHOBJ_01 = dsT_EV_JOBHEAD.NameValue(row,"RSHOBJ_01");
			if(oRSHOBJ_01 == "T"){//true�̸�
				document.getElementById("chkRSHOBJ_01").checked = true;
			}else{//false�̸�
				document.getElementById("chkRSHOBJ_01").checked = false;
			}

			oRSHOBJ_02 = dsT_EV_JOBHEAD.NameValue(row,"RSHOBJ_02");
			if(oRSHOBJ_02 == "T"){//true�̸�
				document.getElementById("chkRSHOBJ_02").checked = true;
			}else{//false�̸�
				document.getElementById("chkRSHOBJ_02").checked = false;
			}

			//�۾����� ��ư Ȱ��ȭ ����
			oSTATUS_JOB = dsT_EV_JOBHEAD.NameValue(row,"STATUS_JOB");
			if(oSTATUS_JOB == "0"){//����
				document.getElementById("btnSTATUS_JOB1").disabled = false;
				document.getElementById("btnSTATUS_JOB1").className="";
				document.getElementById("btnSTATUS_JOB2").disabled = true;
				document.getElementById("btnSTATUS_JOB2").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB3").disabled = true;
				document.getElementById("btnSTATUS_JOB3").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB4").disabled = true;
				document.getElementById("btnSTATUS_JOB4").className="inputDisabled";
				document.getElementById("txtSTATUS_PRESENT").value="����ڼ����� �� �� �ֽ��ϴ�.";
			}else if(oSTATUS_JOB == "1"){//����ڼ��� �Ϸ�
				document.getElementById("btnSTATUS_JOB1").disabled = true;
				document.getElementById("btnSTATUS_JOB1").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB2").disabled = false;
				document.getElementById("btnSTATUS_JOB2").className="";
				document.getElementById("btnSTATUS_JOB3").disabled = false;
				document.getElementById("btnSTATUS_JOB3").className="";
				document.getElementById("btnSTATUS_JOB4").disabled = true;
				document.getElementById("btnSTATUS_JOB4").className="inputDisabled";
				document.getElementById("txtSTATUS_PRESENT").value="����ڼ����� �Ϸ��Ͽ����ϴ�. ���� open�� �����մϴ�.";
			}else if(oSTATUS_JOB == "2"){//����open �Ϸ�
				document.getElementById("btnSTATUS_JOB1").disabled = true;
				document.getElementById("btnSTATUS_JOB1").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB2").disabled = true;
				document.getElementById("btnSTATUS_JOB2").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB3").disabled = true;
				document.getElementById("btnSTATUS_JOB3").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB4").disabled = false;
				document.getElementById("btnSTATUS_JOB4").className="";
				document.getElementById("txtSTATUS_PRESENT").value="���� open�� �Ͽ����ϴ�. ����ڴ� �����ۼ��� �����մϴ�.";
			}else{//����close �Ϸ�
				document.getElementById("btnSTATUS_JOB1").disabled = true;
				document.getElementById("btnSTATUS_JOB1").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB2").disabled = true;
				document.getElementById("btnSTATUS_JOB2").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB3").disabled = true;
				document.getElementById("btnSTATUS_JOB3").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB4").disabled = true;
				document.getElementById("btnSTATUS_JOB4").className="inputDisabled";

				if(oSTATUS_JOB == ""){
					document.getElementById("txtSTATUS_PRESENT").value="";
				}else{
					document.getElementById("txtSTATUS_PRESENT").value="�����ۼ��� �Ϸ��Ͽ����ϴ�.";
				}
			}

			var RowStatus = dsT_EV_JOBHEAD.RowStatus(row);

			if(RowStatus != "1" && oSTATUS_JOB != "0"){
				document.getElementById("txtBASIC_YMD").readOnly = true;
				document.getElementById("txtBASIC_YMD").className="input_ReadOnly";
				document.getElementById("img_HelpOn2").style.display = "none";
				document.getElementById("cmbRSH_DEC").disabled = true;
				document.getElementById("cmbRSH_DEC").className="input_ReadOnly";
				document.getElementById("chkRSHOBJ_01").disabled = true;
				document.getElementById("chkRSHOBJ_01").className="input_ReadOnly";
				document.getElementById("chkRSHOBJ_02").disabled = true;
				document.getElementById("chkRSHOBJ_02").className="input_ReadOnly";
				document.getElementById("txtEXCEPT_MON").readOnly = true;
				document.getElementById("txtEXCEPT_MON").className="input_ReadOnly";
			}else{
				document.getElementById("txtBASIC_YMD").readOnly = false;
				document.getElementById("txtBASIC_YMD").className="";
				document.getElementById("img_HelpOn2").style.display = "";
				document.getElementById("cmbRSH_DEC").disabled = false;
				document.getElementById("cmbRSH_DEC").className="";
				document.getElementById("chkRSHOBJ_01").disabled = false;
				document.getElementById("chkRSHOBJ_01").className="";
				document.getElementById("chkRSHOBJ_02").disabled = false;
				document.getElementById("chkRSHOBJ_02").className="";
				document.getElementById("txtEXCEPT_MON").readOnly = false;
				document.getElementById("txtEXCEPT_MON").className="";
			}

			//�ű��̸� ������ �Է� Ȱ��ȭ
			if(RowStatus == "1"){
				document.getElementById("txtPIS_YYMM").readOnly = false;
				document.getElementById("txtPIS_YYMM").className="";
				document.getElementById("img_HelpOn1").style.display = "";
			}else{
				document.getElementById("txtPIS_YYMM").readOnly = true;
				document.getElementById("txtPIS_YYMM").className="input_ReadOnly";
				document.getElementById("img_HelpOn1").style.display = "none";
			}

			//�����ο� ǥ��
			var oTOTAL_CNT = document.getElementById("txtTOTAL_CNT").value;
			var oOBJECT_CNT = document.getElementById("txtOBJECT_CNT").value;
			document.getElementById("txtEXCEPT_CNT").value = oTOTAL_CNT - oOBJECT_CNT;

		}
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
<input type="hidden" id="txtRSHOBJ_01">
<input type="hidden" id="txtRSHOBJ_02">
<input type="hidden" id="txtSTATUS_JOB">
<input type="hidden" id="viewflag">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����̵�����ڼ���</td>
					<td align="right" class="navigator">HOME/�����̵�/�����̵��۾�/<font color="#000000">�����̵�����ڼ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
   			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>  -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td>
			            <!-- ���� �Է� ���̺� ���� -->
				        <table width="800" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				        	<colgroup>
				        		<col width="90"></col>
				        		<col width="100"></col>
				        		<col width="90"></col>
				        		<col width="120"></col>
				        		<col width="90"></col>
				        		<col width=""></col>
				        	</colgroup>
				        	<tr>
				        		<td align="center" class="creamBold">������</td>
				        		<td class="padding2423">
			                        <input id="txtPIS_YYMM" size="7" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM','','150','138');"></a>
				        		</td>
				        		<td align="center" class="creamBold">��������</td>
				        		<td class="padding2423">
					        		<input id="txtBASIC_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBASIC_YMD','','315','138');"></a>
				        		</td>
				        		<td align="center" class="creamBold">���系��</td>
	                            <td class="padding2423">
	                                <select id="cmbRSH_DEC" style="width:100%">
										<option value="1" >�����̵�+�ڱ�Ű�</option>
	                                    <option value="2" >�����̵�</option>
	                                    <option value="3" >�ڱ�Ű�</option>
	                                </select>
	                            </td>
				        	</tr>
	                        <tr>
				        		<td align="center" class="creamBold">������</td>
				        		<td class="padding2423" colspan="3">
				        		    <input type="checkbox" id="chkRSHOBJ_01" value="yes" style="border:0" align="absmiddle" onclick="checkRSHOBJ();">�繫��
				        		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				        		    <input type="checkbox" id="chkRSHOBJ_02" value="yes" style="border:0" align="absmiddle" onclick="checkRSHOBJ();">�ù���
				        		</td>
				        		<td align="center" class="creamBold">���ܴ��</td>
				        		<td class="padding2423"><input id="txtEXCEPT_MON" size="2" maxlength="2" style="text-align:right" onkeypress="cfNumberCheck();"> �����̳� �Ի���</td>
				        	</tr>
							<tr>
				        		<td align="center" class="creamBold">����ο�</td>
				        		<td colspan="5">
	                                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                                    <colgroup>
	                                        <col width="80"></col>
	                                        <col width="150"></col>
	                                        <col width="50"></col>
	                                        <col width="150"></col>
	                                        <col width="50"></col>
	                                        <col width=""></col>
	                                    </colgroup>
	                                    <tr>
				        		            <td align="right">�� ��&nbsp;</td>
				        		            <td ><input id="txtTOTAL_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> ��</td>
				        		            <td align="right">�� ��&nbsp;</td>
				        		            <td ><input id="txtOBJECT_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> ��</td>
				        		            <td align="right">�� ��&nbsp;</td>
				        		            <td ><input id="txtEXCEPT_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> ��</td>
				        		        <tr>
				        		    </table>
				        		</td>
	                        </tr>
	                        <tr>
				        		<td align="center" class="creamBold">�������</td>
				        		<td  class="padding2423" colspan="5"><input id="txtSTATUS_PRESENT" style="width:100%"  class="input_ReadOnly" readonly></td>
				            </tr>
				        </table>
				        <!-- ���� �Է� ���̺� �� -->
				    </td>
				</tr>
			</table>
		</td>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td class="paddingTop8">
	                    <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                        <colgroup>
	                            <col width="200"></col>
	                            <col width="200"></col>
	                            <col width="200"></col>
	                            <col width=""></col>
	                        </colgroup>
	                        <tr>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB1"  style="cursor:hand" value=" ����ڼ��� " onclick="object_set();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB2"  style="cursor:hand" value=" ���۾� " onclick="object_reset();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB3" style="cursor:hand" value=" ����OPEN " onclick="object_open();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB4" style="cursor:hand" value="����CLOSE"onclick="object_close();">
	                            </td>
	                        </tr>
	                    </table>
	                <td>
	            </tr>
            </table>
        </td>
	</tr>
</table>

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

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		    <!-- ���� ��ȸ �׸��� ���̺� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_EV_JOBHEAD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
                            <param name="DataID"						value="dsT_EV_JOBHEAD">
                            <param name="EdiTABLE"				value="false">
                            <param name="DragDropEnable"		value="true">
                            <param name="SortView"					value="Left">
                            <param name="VIEWSUMMARY"		value=0>
							<param name="IndWidth"                  value=0>
                            <param name="Format"						value="
								<C> id='{CUROW}'			width=49		name='����'				align=center		value={String(Currow)}																												</C>
								<C> id='PIS_YYMM'			width=95		name='������'		align=center																																							</C>
								<C> id='BASIC_YMD'			width=95		name='��������'		align=center																																							</C>
								<C> id='RSH_DEC'			width=180		name='���系��'		align=center		value={Decode(RSH_DEC,1,'�����̵�+�ڱ�Ű�',2,'�����̵�',3,'�ڱ�Ű�')}									</C>
								<C> id='OBJECT'				width=180		name='������'		align=center		value={Decode(RSHOBJ_01&RSHOBJ_02,'TT','�繫��+�ù���','TF','�繫��','FT','�ù���','FF','')}	</C>
								<C> id='EXCEPT_MON'		width=180		name='���ܴ��'		align=center		value={EXCEPT_MON&'�����̳� �Ի���'}																						</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ �׸��� ���̺� �� -->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                                               |
    | 2. �̸� : bndT_EV_JOBHEAD                                   |
    | 3. Table List : T_EV_JOBHEAD                                 |
    +----------------------------------------------->
	<object id="bndT_EV_JOBHEAD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_JOBHEAD">
		<Param Name="BindInfo", Value="
			<C>Col='PIS_YYMM'				Ctrl='txtPIS_YYMM'				Param=value</C>
			<C>Col='BASIC_YMD'			Ctrl='txtBASIC_YMD'				Param=value</C>
			<C>Col='RSH_DEC'				Ctrl='cmbRSH_DEC'				Param=value</C>
			<C>Col='RSHOBJ_01'			Ctrl='txtRSHOBJ_01'				Param=value</C>
			<C>Col='RSHOBJ_02'			Ctrl='txtRSHOBJ_02'				Param=value</C>
			<C>Col='EXCEPT_MON'		Ctrl='txtEXCEPT_MON'			Param=value</C>
			<C>Col='TOTAL_CNT'			Ctrl='txtTOTAL_CNT'				Param=value</C>
			<C>Col='OBJECT_CNT'			Ctrl='txtOBJECT_CNT'			Param=value</C>
			<C>Col='STATUS_JOB'			Ctrl='txtSTATUS_JOB'			Param=value</C>
	    ">
	</object>

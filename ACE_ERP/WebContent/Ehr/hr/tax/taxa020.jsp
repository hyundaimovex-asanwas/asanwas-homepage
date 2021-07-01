<!--*************************************************************************
* @source      : taxa020.jsp                                                *
* @description : �δ��������ó������ PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/05/03      ������          �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
    <title>�δ��������ó������(taxa020)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTFFFT';

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {

            var oPIS_YM     = document.getElementById("txtPIS_YM").value;//�ش���
            var oAGN_YM     = document.getElementById("txtAGN_YM").value;//������
            var oOCC_CD     = document.getElementById("cmbOCC_CD").value;
            //var oSAL_GBN    = document.getElementById("cmbSAL_GBN").value;
            var oSAL_GBN    = "7";

			//�ش����� ������ ��ȸ����.
			if(oPIS_YM.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YM").focus();
					return false;
				}
			}

			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(oPIS_YM.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YM").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(oAGN_YM.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtAGN_YM").focus();
					return false;
				}
			}

			//�������� �߸��Ǿ����� ��ȸ����.
			if(oAGN_YM.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtAGN_YM").focus();
					return false;
				}
			}

            //��¥ ��������
            var dayArray1 = oPIS_YM.split("-");
            var dayArray2 = oAGN_YM.split("-");


            var params = "&S_MODE=SHR"
                   + "&PIS_YY="+dayArray1[0]
                   + "&PIS_MM="+dayArray1[1]
                   + "&AGN_YY="+dayArray2[0]
                   + "&AGN_MM="+dayArray2[1]
                   + "&OCC_CD="+oOCC_CD
                   + "&SAL_GBN="+oSAL_GBN;

			trT_AC_AGAIN.KeyValue = "SVL(O:dsT_CP_WORKLOG=dsT_CP_WORKLOG, O:dsT_AC_AGAIN=dsT_AC_AGAIN)";
            trT_AC_AGAIN.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa020.cmd.TAXA020CMD"+params;
            trT_AC_AGAIN.post();

        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {

        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsT_AC_AGAIN.CountColumn == 0) {
                dsT_AC_AGAIN.setDataHeader("PIS_YY:STRING(4):KEYVALUETYPE,PIS_MM:STRING(2):KEYVALUETYPE,AGN_YY:STRING(4):KEYVALUETYPE,AGN_MM:STRING(2):KEYVALUETYPE,ENO_NO:STRING(8):KEYVALUETYPE,ENO_NM:STRING(16),OCC_CD:STRING(1),DPT_CD:STRING(3),JOB_CD:STRING(2),DPT_NM:STRING(16),JOB_NM:STRING(16)");
            }

       		document.form1.txtENO_NO.readOnly = false;
  			document.form1.txtENO_NO.className = "";
  			document.getElementById("imgENO_NO").disabled = false;
			document.form1.txtENO_NO.focus();

			dsT_AC_AGAIN.AddRow();
			dsT_AC_AGAIN.NameValue(dsT_AC_AGAIN.RowPosition,"PIS_YY")=document.getElementById("txtPIS_YM").value.substring(0,4);
			dsT_AC_AGAIN.NameValue(dsT_AC_AGAIN.RowPosition,"PIS_MM")=document.getElementById("txtPIS_YM").value.substring(5,7);
			dsT_AC_AGAIN.NameValue(dsT_AC_AGAIN.RowPosition,"AGN_YY")=document.getElementById("txtAGN_YM").value.substring(0,4);
			dsT_AC_AGAIN.NameValue(dsT_AC_AGAIN.RowPosition,"AGN_MM")=document.getElementById("txtAGN_YM").value.substring(5,7);
			//dsT_AC_AGAIN.NameValue(dsT_AC_AGAIN.RowPosition,"OCC_CD")=document.getElementById("cmbOCC_CD").value;

			document.form1.txtENO_NO.focus();
        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

			// ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_AC_AGAIN.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			// Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_AC_AGAIN.ColumnString(dsT_AC_AGAIN.RowPosition,7) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

			dsT_AC_AGAIN.DeleteRow(dsT_AC_AGAIN.RowPosition);

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {

            fnc_OnLoadProcess();
            dsT_CP_WORKLOG.ClearData();
            document.getElementById("resultMessage").innerText = ' ';
   			document.getElementById("txtPRO_STS_MSG").value = ""; // �۾��޼���
   			document.getElementById("cmbOCC_CD").value = "A"; // �ٷα��б���
   			//document.getElementById("cmbSAL_GBN").value = "7"; // ���걸��
			document.form1.txtPIS_YM.focus();

        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_WORKLOG.IsUpdated || dsT_AC_AGAIN.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_AC_AGAIN,15,"false","false");

            //�⵵ �ʱ�ȭ
            document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            //document.getElementById("txtAGN_YM").value = "2007-07";

			//�ٷα���
			if(document.getElementById("cmbOCC_CD").length == 0){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD").add(oOption);
				}
			}

			disableInput();//�Է��ʵ� ��Ȱ��ȭ

        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /**
         * 1:����� ����
         */
        function fnc_proc1() {

            var oPIS_YM     = document.getElementById("txtPIS_YM").value; // �ش���
            var oAGN_YM     = document.getElementById("txtAGN_YM").value; // ������
            var oOCC_CD     = document.getElementById("cmbOCC_CD").value; // �ٷα��б���
            var oOCC_CD     = document.getElementById("cmbOCC_CD").value; // �ٷα��б���
            var oOCC_NM     = "";
            var oSAL_GBN    = "7";
            var oPRO_STS    = "1";
			var i = 1;
			var j = 1;

			if(oOCC_CD == "A"){
				oOCC_NM = "�繫��";
			}else if(oOCC_CD == "M"){
				oOCC_NM = "�ù���";
			}

			for(j=1; j<=dsT_AC_AGAIN.CountRow; j++){
				if(dsT_AC_AGAIN.NameValue(j,"OCC_CD").trim() != oOCC_CD){
					alert(j+"��° ����ڴ� "+oOCC_NM+"�� �ƴմϴ�." );
					dsT_AC_AGAIN.RowPosition = j;
					document.getElementById("txtENO_NO").focus();
					return false;
				}
			}

            if (confirm("����� ������ �Ͻðڽ��ϱ�? ") == false) return;

            //��¥ ��������
            var dayArray1 = oPIS_YM.split("-");
            var dayArray2 = oAGN_YM.split("-");

            dsT_CP_WORKLOG.NameValue(i,"PIS_YY")=dayArray1[0];
			dsT_CP_WORKLOG.NameValue(i,"PIS_MM")=dayArray1[1];
            dsT_CP_WORKLOG.NameValue(i,"AGN_YY")=dayArray2[0];
			dsT_CP_WORKLOG.NameValue(i,"AGN_MM")=dayArray2[1];
			dsT_CP_WORKLOG.NameValue(i,"OCC_CD")=oOCC_CD;
			dsT_CP_WORKLOG.NameValue(i,"SAL_GBN")=oSAL_GBN;
			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=oPRO_STS;

			trT_CP_WORKLOG.KeyValue = "SVL(I:dsT_CP_WORKLOG=dsT_CP_WORKLOG,I:dsT_AC_AGAIN=dsT_AC_AGAIN)";
            trT_CP_WORKLOG.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa020.cmd.TAXA020CMD&S_MODE=PROC1";
            trT_CP_WORKLOG.post();
        }

        /**
         * 3:��ó��
         */
        function fnc_proc3() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("��ó���۾��� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "2";//��ó���� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa020.cmd.TAXA020CMD&S_MODE=PROC3";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 4:�۾�����
         */
        function fnc_proc4() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("�۾����Ḧ �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "3";//�۾����� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa020.cmd.TAXA020CMD&S_MODE=PROC4";
			trT_CP_WORKLOG.Post();
        }

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(state){

			//��ȸ�ʵ�� ��� �Ұ����ϰ�
			document.form1.txtPIS_YM.readOnly = true;
  			document.form1.txtPIS_YM.className = "input_ReadOnly";
  			document.getElementById("imgPIS_YM").disabled = true;
			document.form1.txtAGN_YM.readOnly = true;
  			document.form1.txtAGN_YM.className = "input_ReadOnly";
  			document.getElementById("imgAGN_YM").disabled = true;
  			document.getElementById("cmbOCC_CD").disabled = true;
  			//document.getElementById("cmbSAL_GBN").disabled = true;

  			if(state == "0"){//����ڼ��� ����
	  			document.getElementById("imgInsert").disabled = false;
	  			document.getElementById("imgRemove").disabled = false;

	  			document.getElementById("btnPROC1").disabled = false;
				document.getElementById("btnPROC1").className="";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//��ó��
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����

  			}

  			else if(state == "1"){//����ڼ��� �Ϸ�
	  			document.getElementById("imgInsert").disabled = true;
	  			document.getElementById("imgRemove").disabled = true;

	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = false;
				document.getElementById("btnPROC3").className="";//��ó��
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����

  			}

  			else if(state == "2" ){//��ó�� �Ϸ�
	  			document.getElementById("imgInsert").disabled = true;
	  			document.getElementById("imgRemove").disabled = true;

	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//��ó��
	  			document.getElementById("btnPROC4").disabled = false;
				document.getElementById("btnPROC4").className="";//�۾�����

  			}

  			else if(state == "3" || state == "4"){//�۾�����,�ڷ�ݿ�
	  			document.getElementById("imgInsert").disabled = true;
	  			document.getElementById("imgRemove").disabled = true;

	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//��ó��
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����

  			}

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			//��ȸ�ʵ�� ��� �����ϰ�
			document.form1.txtPIS_YM.readOnly = false;
  			document.form1.txtPIS_YM.className = "";
  			document.getElementById("imgPIS_YM").disabled = false;
			document.form1.txtAGN_YM.readOnly = false;
  			document.form1.txtAGN_YM.className = "";
  			document.getElementById("imgAGN_YM").disabled = false;
  			document.getElementById("cmbOCC_CD").disabled = false;
  			//document.getElementById("cmbSAL_GBN").disabled = true;

  			document.getElementById("imgInsert").disabled = true;
  			document.getElementById("imgRemove").disabled = true;
			document.form1.txtENO_NO.readOnly = true;
  			document.form1.txtENO_NO.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO").disabled = true;

  			document.getElementById("btnPROC1").disabled = true;
			document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
  			document.getElementById("btnPROC3").disabled = true;
			document.getElementById("btnPROC3").className="inputDisabled";//��ó��
  			document.getElementById("btnPROC4").disabled = true;
			document.getElementById("btnPROC4").className="inputDisabled";//�۾�����

  		}

		/**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO', 'txtENO_NM');

            fnc_GetUserInfo();
        }

  		/**
         * fnc_GetEnoNm �ٸ������� �������� ������
         */
        function fnc_GetUserInfo() {

            var obj = fnc_GetEnoNm("txtENO_NO");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtOCC_CD").value = obj.occ_cd;

        }

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)                |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut    value=100000>
    </Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_AGAIN)           |
    | 3. ���Ǵ� Table List(T_AC_AGAIN)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_AGAIN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut    value=100000>
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_WORKLOG)                |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <param name=TimeOut value=1000000>
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_AGAIN)            |
    | 3. ���Ǵ� Table List(T_AC_AGAIN)                   |
    +------------------------------------------------------>
    <Object ID="trT_AC_AGAIN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <param name=TimeOut value=1000000>
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.getElementById("txtPRO_STS_MSG").value = "����� ������ �� �� �ֽ��ϴ�.";

	        dsT_CP_WORKLOG.AddRow();

			enableInput("0");

        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "����� ������ �Ϸ��Ͽ����ϴ�.";
				enableInput("1");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "��ó���۾��� �Ϸ��Ͽ����ϴ�.";
				enableInput("2");
            }else if(PRO_STS == "3"){
               	document.getElementById("txtPRO_STS_MSG").value = "�۾��� �����Ͽ����ϴ�.";
               	enableInput("3");
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "�ڷḦ �ݿ��Ͽ����ϴ�.";
               	enableInput("4");
            }

        }

    </Script>

    <Script For=dsT_AC_AGAIN Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			fnc_Append();
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_AGAIN Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_AGAIN Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
		fnc_SearchList();//����ȸ
    </script>

    <script for=trT_AC_AGAIN event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_AGAIN event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- Ķ���� ������-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�δ��������ó������</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">�δ��������ó������</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="100"></col>
					<col width="160"></col>
					<col width="100"></col>
					<col width="160"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�ش���</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YM" name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','80','108');"></a>
					</td>
					<td class="searchState" align="right">������</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtAGN_YM" name="txtAGN_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAGN_YM','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAGN_YM" name="imgAGN_YM" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtAGN_YM','','80','108');"></a>
					</td>
                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD" id="cmbOCC_CD">
                        </select>
                    </td>
				<!--<td class="searchState" align="right">���걸��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbSAL_GBN" id="cmbSAL_GBN">
                            <option value="8">��������</option>
                            <option value="9">����������</option>
                        </select>
                    </td>
				</tr>-->
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
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    	        		<td align="center" class="creamBold">����ο�</td>
    	        		<td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <colgroup>
                                    <col width="200"></col>
                                    <col width="200"></col>
                                    <col width="100"></col>
                                    <col width=""></col>
                                </colgroup>
                                <tr>
                                    <td align="right">ó���ο�&nbsp;</td>
    	        		            <td ><input id="txtPRO_CNT" name="txtPRO_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> ��</td>
    	        		            <td align="right">��ó���ο�&nbsp;</td>
    	        		            <td ><input id="txtERR_CNT" name="txtERR_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> ��</td>
    	        		        <tr>
    	        		    </table>
    	        		</td>
    				</tr>
    				<tr>
    	        		<td align="center" class="creamBold">�۾���Ȳ</td>
    	        		<td  class="padding2423">
    	        			<input id="txtPRO_STS" name="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
    	        			<input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
    	        		</td>
    	            </tr>
                    <tr>
                        <td align="center" class="creamBold">�۾�����</td>
                        <td  class="padding2423">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" ����ڼ��� " onclick="fnc_proc1()">
                                        <input type="button" id="btnPROC3" style="cursor:hand;width:140pt;height:25pt;" value=" ��ó���۾� " onclick="fnc_proc3()">
                                        <input type="button" id="btnPROC4" style="cursor:hand;width:140pt;height:25pt;" value=" �۾����� " onclick="fnc_proc4()">
                                    </td>
                                </tr>
                            </table>
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
		<td class="paddingTop15">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="70%" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					<td align="right">
            <!--����--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInsert','','/images/button/btn_InsertOver.gif',1)">    <img src="/images/button/btn_InsertOn.gif"   name="imgInsert"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <!--����--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)">    <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="210"></col>
					<col width="80"></col>
					<col width="160"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�����ȣ</td>
					<td class="padding2423">
						<input id="txtENO_NO" name="txtENO_NO" size="10" maxlength="8" onChange="fnc_GetUserInfo();">
						<input id="txtENO_NM" name="txtENO_NM" size="14" maxlength="14" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();"></a>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtDPT_CD" size="5" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtDPT_NM" size="15" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtJOB_CD" size="5" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtJOB_NM" size="15" class="input_ReadOnly" readOnly>
					</td>
				</tr>
			</table>
			<input type="hidden" id="txtOCC_CD">
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_AC_AGAIN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:160px;">
							<param name="DataID"					value="dsT_AC_AGAIN">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=80			name='NO'				align=center			value={String(Currow)}	</C>
								<C> id='DPT_NM'				width=171			name='�Ҽ�'				align=center									</C>
								<C> id='JOB_NM'				width=171			name='����'				align=center									</C>
								<C> id='ENO_NO'				width=171			name='���'				align=center									</C>
								<C> id='ENO_NM'				width=171			name='����'				align=center									</C>
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

<object id="bndT_CP_WORKLOG" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_WORKLOG">
	<Param Name="BindInfo", Value='
		<C>Col=PRO_STS     		 	Ctrl=txtPRO_STS     		 	Param=value 		</C>
		<C>Col=PRO_CNT     		 	Ctrl=txtPRO_CNT     		 	Param=value 		</C>
		<C>Col=ERR_CNT		     	Ctrl=txtERR_CNT     		 	Param=value 		</C>
    '>
</object>

<object id="bndT_AC_AGAIN" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_AC_AGAIN">
	<Param Name="BindInfo", Value='
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM     			 	Param=value 		</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD    			 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM    			 	Param=value 		</C>
		<C>Col=ENO_NO     		 	Ctrl=txtENO_NO     		 		Param=value 		</C>
		<C>Col=ENO_NM     		 	Ctrl=txtENO_NM    			 	Param=value 		</C>
		<C>Col=OCC_CD     		 	Ctrl=txtOCC_CD	 			 	Param=value 		</C>
    '>
</object>
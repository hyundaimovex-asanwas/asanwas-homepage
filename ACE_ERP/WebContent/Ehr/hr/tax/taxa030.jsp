<!--*************************************************************************
* @source      : taxa030.jsp                                                *
* @description : ������ó�� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>������ó��(taxa030)</title>
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

            var vPIS_YM     = document.getElementById("txtPIS_YM").value;
            var vOCC_CD     = document.getElementById("cmbOCC_CD").value;
            var vSAL_GBN    = document.getElementById("cmbSAL_GBN").value;


			//�ش����� ������ ��ȸ����.
			if(vPIS_YM.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YM").focus();
					return false;
				}
			}

			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(vPIS_YM.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YM").focus();
					return false;
				}
			}

            //��¥ ��������
            var dayArray = vPIS_YM.split("-");

            var params = "&S_MODE=SHR"
                       + "&PIS_YY="+dayArray[0]
                       + "&PIS_MM="+dayArray[1]
                       + "&OCC_CD="+vOCC_CD
                       + "&SAL_GBN="+vSAL_GBN;

            dsT_CP_WORKLOG.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD"+params;
            dsT_CP_WORKLOG.Reset();


            //������ �����϶� ���� ����� ����Ʈ�� ��ȸ�Ѵ�.
            document.getElementById("resultMessage").innerText = " ";
            if(vSAL_GBN == "9") {

                params = "&S_MODE=SHR_RET"
                       + "&PIS_YM="+dayArray[0]+dayArray[1]
                       + "&OCC_CD="+vOCC_CD

                dsT_AC_RETTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD"+params;
                dsT_AC_RETTABLE.Reset();


                fnc_ShowElement  ("layLIST");
            } else {
                fnc_HiddenElement("layLIST");
            }

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

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {

            //fnc_OnLoadProcess();
            disableInput();//�Է��ʵ� ��Ȱ��ȭ

            dsT_CP_WORKLOG.ClearData();
            document.getElementById("resultMessage").innerText = ' ';
   			document.getElementById("txtPRO_STS_MSG").value   = ""; // �۾��޼���
   			document.getElementById("cmbOCC_CD").value        = "A"; // �ٷα��б���
   	//		document.getElementById("cmbSAL_GBN").value       = "9"; // ���걸��
			document.form1.txtPIS_YM.focus();

            fnc_HiddenElement("layLIST");

        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_WORKLOG_01.IsUpdated)  {
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
            //ù��° �μ� : �׸����                                                     �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"false","false");

            //�⵵ �ʱ�ȭ
            //document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtPIS_YM").value = '2014-12';

			//�ٷα���
			document.getElementById("cmbOCC_CD").value        = "A";
			if(document.getElementById("cmbOCC_CD").length == 0){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD").add(oOption);
				}
			}

			disableInput();//�Է��ʵ� ��Ȱ��ȭ

			fnc_SearchList();

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
            var oOCC_CD     = document.getElementById("cmbOCC_CD").value; // �ٷα��б���
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN").value;//���걸��
			var i = 1;

            if (confirm("����� ������ �Ͻðڽ��ϱ�? ") == false) return;

            //��¥ ��������
            var dayArray = oPIS_YM.split("-");

            dsT_CP_WORKLOG.NameValue(i,"PIS_YY")=dayArray[0];
			dsT_CP_WORKLOG.NameValue(i,"PIS_MM")=dayArray[1];
			dsT_CP_WORKLOG.NameValue(i,"OCC_CD")=oOCC_CD;
			dsT_CP_WORKLOG.NameValue(i,"SAL_GBN")=oSAL_GBN;

			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC1";
            trT_CP_WORKLOG.post();
        }

        /**
         * 2:����ڼ����߰�
         */
        function fnc_proc2() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("����� �߰��� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "7";//����ڼ����߰����� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;
			dsT_CP_WORKLOG.UserStatus(i) = 1;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC2";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 3:�⸻������
         */
        function fnc_proc3() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("�������۾��� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "2";//�⸻���������� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC3";
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
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC4";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 5:���۾� (����ڼ���)
         */
        function fnc_proc5() {

        	var oSAL_GBN    = document.getElementById("cmbSAL_GBN").value;//���걸��
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("����� �ʱ�ȭ�� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "0";//����ڼ��� �������� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC5";
			trT_CP_WORKLOG.Post();

         }

        /**
         * 6:���۾�(������)
         */
        function fnc_proc6() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("�������۾� �ʱ�ȭ�� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "1";//����ڼ������� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD&S_MODE=PROC6";
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
  			document.getElementById("cmbOCC_CD").disabled = true;
  			document.getElementById("cmbSAL_GBN").disabled = true;

  			if(state == "0"){//����ڼ��� ����
	  			document.getElementById("btnPROC1").disabled = false;
				document.getElementById("btnPROC1").className="";//����ڼ���
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//����ڼ����߰�
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//���۾�(����ڼ���)
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//���۾�(������)

  			}

  			else if(state == "1" || state == "7"){//����ڼ��� �Ϸ�
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="";//����ڼ����߰�
	  			document.getElementById("btnPROC3").disabled = false;
				document.getElementById("btnPROC3").className="";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//���۾�(����ڼ���)
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//���۾�(������)

  			}

  			else if(state == "2" ){//�⸻������ �Ϸ�
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//����ڼ����߰�
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
	  			document.getElementById("btnPROC4").disabled = false;
				document.getElementById("btnPROC4").className="";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//���۾�(����ڼ���)
	  			document.getElementById("btnPROC6").disabled = false;
				document.getElementById("btnPROC6").className="";//���۾�(������)

  			}

  			else if(state == "3" || state == "4"){//�۾�����,�ڷ�ݿ�
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//����ڼ����߰�
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//���۾�(����ڼ���)
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//���۾�(������)

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
  			document.getElementById("cmbOCC_CD").disabled = false;
  			document.getElementById("cmbSAL_GBN").disabled = false;

  			document.getElementById("btnPROC1").disabled = true;
			document.getElementById("btnPROC1").className="inputDisabled";//����ڼ���
  			document.getElementById("btnPROC2").disabled = true;
			document.getElementById("btnPROC2").className="inputDisabled";//����ڼ����߰�
  			document.getElementById("btnPROC3").disabled = true;
			document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
  			document.getElementById("btnPROC4").disabled = true;
			document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
  			document.getElementById("btnPROC5").disabled = true;
			document.getElementById("btnPROC5").className="inputDisabled";//���۾�(����ڼ���)
  			document.getElementById("btnPROC6").disabled = true;
			document.getElementById("btnPROC6").className="inputDisabled";//���۾�(������)

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
        <param name=TimeOut    value=200000>
    </Object>

    <Object ID="dsT_CP_WORKLOG_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut    value=200000>
    </Object>

    <Object ID="dsT_AC_RETTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut    value=200000>
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
        <param name=TimeOut value=2000000>
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
			document.getElementById("txtPRO_STS_MSG").value = "����� ������ �� �� �ֽ��ϴ�.";

	        dsT_CP_WORKLOG.AddRow();

			enableInput("0");

        } else {
            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "����� ������ �Ϸ��Ͽ����ϴ�.";
				enableInput("1");
            }else if(PRO_STS == "7"){
                document.getElementById("txtPRO_STS_MSG").value = "����� �߰��� �Ϸ��Ͽ����ϴ�.";
				enableInput("7");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "�������� �Ϸ��Ͽ����ϴ�.";
				enableInput("2");
            }else if(PRO_STS == "3"){
               	//document.getElementById("txtPRO_STS_MSG").value = "�۾��� �����Ͽ����ϴ�. ���������ڷ� �޿��ݿ��� �����մϴ�.";
               	document.getElementById("txtPRO_STS_MSG").value = "�۾��� �����Ͽ����ϴ�.";
               	enableInput("3");
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "�ڷḦ �ݿ��Ͽ����ϴ�.";
               	enableInput("4");
            }else if(PRO_STS == "5"){
               	//document.getElementById("txtPRO_STS_MSG").value = "���۾�(����ڼ���)�� �Ϸ��Ͽ����ϴ�.";
            }else if(PRO_STS == "6"){
               	//document.getElementById("txtPRO_STS_MSG").value = "���۾�(������)�� �Ϸ��Ͽ����ϴ�.";
            }

        }

        var vPIS_YM     = document.getElementById("txtPIS_YM").value;
        var vOCC_CD     = document.getElementById("cmbOCC_CD").value;
        var vSAL_GBN    = document.getElementById("cmbSAL_GBN").value;

        //��¥ ��������
        var dayArray = vPIS_YM.split("-");

        var params = "&S_MODE=SHR_01"
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+vOCC_CD
                   + "&SAL_GBN="+vSAL_GBN;

        //��ó���ο� ��ȸ
        dsT_CP_WORKLOG_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa030.cmd.TAXA030CMD"+params;
        dsT_CP_WORKLOG_01.Reset();

    </Script>

    <Script For=dsT_CP_WORKLOG_01 Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            if(dsT_CP_WORKLOG_01.NameValue(1,"CNT") != "0"){
                dsT_CP_WORKLOG.NameValue(1,"ERR_CNT") = dsT_CP_WORKLOG_01.NameValue(1,"CNT");
            }
        }
    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
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

    <Script For=dsT_CP_WORKLOG_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnLoadError()">
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

    <Script For=dsT_CP_WORKLOG_01 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
		fnc_SearchList();//����ȸ
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������ó��</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">������ó��</font></td>
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
					<col width="80"></col>
					<col width="160"></col>
                    <col width="80"></col>
                    <col width="160"></col>
					<col width="10"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�ش���</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YM" name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','80','108');"></a>
					</td>
                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD" id="cmbOCC_CD">
                        	<option value="A">��ü</option>
                        </select>
                    </td>
                    <td class="searchState" align="right">���걸��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbSAL_GBN" id="cmbSAL_GBN">
                            <option value="8">��������</option>
                            <!--  <option value="9">����������</option> -->
                        </select>
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
                                        <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" �۾�����">
                                        <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" ����ڼ��� " onclick="fnc_proc1()">
                                        <input type="button" id="btnPROC3" style="cursor:hand;width:140pt;height:25pt;" value=" �������۾� " onclick="fnc_proc3()">
                                    </td>
                                </tr>
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC4" style="cursor:hand;width:140pt;height:25pt;" value=" �۾����� " onclick="fnc_proc4()">
                                        <input type="button" id="btnPROC5" style="cursor:hand;width:140pt;height:25pt;" value=" ����ڼ��� �ʱ�ȭ " onclick="fnc_proc5()">
                                        <input type="button" id="btnPROC6" style="cursor:hand;width:140pt;height:25pt;" value=" �������۾� �ʱ�ȭ " onclick="fnc_proc6()">
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
    <div id="layLIST" style={display:none;position:absolute;}>
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr align="center">
                <td>
                    <comment id="__NSID__">
                    <object id="grdT_AC_RETTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:160px;">
                        <param name="DataID"                    value="dsT_AC_RETTABLE">
                        <param name="EdiTABLE"                  value="false">
                        <param name="DragDropEnable"            value="true">
                        <param name="SortView"                  value="Left">
                        <param name="VIEWSUMMARY"               value=0>
                        <param name="Format"                value="
                            <C> id='{CUROW}'        width=40            name='NO'               align=center        value={String(Currow)}      </C>
                            <C> id='DPT_NM'         width=95            name='�Ҽ�'             align=center                                    </C>
                            <C> id='JOB_NM'         width=95            name='����'             align=center                                    </C>
                            <C> id='ENO_NO'         width=95            name='���'             align=center                                    </C>
                            <C> id='ENO_NM'         width=95            name='����'             align=center                                    </C>
                            <C> id='HIR_YMD'        width=90            name='�Ի���'          align=center                                    </C>
                            <C> id='RET_YMD'        width=90            name='����������'       align=center                                    </C>
                            <C> id='LSE_MM'         width=90            name='�ٹ�����'         align=center                                    </C>
                            <C> id='RET_AMT'        width=90            name='�����ݾ�'         align=right                                    </C>
                            <C> id='ICM_TAX'        width=90            name='�ҵ漼'         align=right                                    </C>
                            <C> id='DJM_TAX'        width=90            name='�ֹμ�'         align=right                                    </C>
                            <C> id='RET_AMT2'        width=90            name='����ݾ�'         align=right         value={(RET_AMT-ICM_TAX-DJM_TAX)}	                           </C>
                        ">
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                </td>
            </tr>
        </table>
    </div>
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
<!--*************************************************
* @source      : yaca090_14.jsp                                                 *
* @description : ����������ó�� PAGE                                         *
****************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*-----------------------------------------------------------------
* 2015/01/27            �̵���             �����ۼ�                                         *
****************************************************-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

    <title>����������ó��(yaca090_14)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

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


            //��¥ ��������
            var dayArray = vPIS_YM.split("-");

            var params = "&S_MODE=SHR"
                       + "&PIS_YY="+dayArray[0]
                       + "&PIS_MM="+dayArray[1];

            dsT_CP_WORKLOG.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD"+params;
            dsT_CP_WORKLOG.Reset();


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

            disableInput();//�Է��ʵ� ��Ȱ��ȭ

            dsT_CP_WORKLOG.ClearData();
            document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtPIS_YM.focus();

        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
        	
			window.close();
			
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

            //�⵵ �ʱ�ȭ
            document.getElementById("txtPIS_YM").value = '2014-12';

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
         * 2:����� ����
         */
        function fnc_proc2() {

            var oPIS_YM     = document.getElementById("txtPIS_YM").value; // �ش���

			var i = 1;

            if (confirm("����� ������ �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "2";//�⸻���������� ����            

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;			

			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC2";
            trT_CP_WORKLOG.post();
        }


        /**
         * 3:�⸻������
         */
        function fnc_proc3() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("�������۾��� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "3";//�⸻���������� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC3";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 4:�۾�����
         */
        function fnc_proc4() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("�۾����Ḧ �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "4";//�۾����� ����

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC4";
			trT_CP_WORKLOG.Post();
        }

        /**
         * 5:����ڼ��� �ʱ�ȭ
         */
        function fnc_proc5() {

			var i = 1;
			
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("����� �ʱ�ȭ�� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "5";//����ڼ��� �ʱ�ȭ

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC5";
			trT_CP_WORKLOG.Post();

         }

        /**
         * 6:�������۾� �ʱ�ȭ
         */
        function fnc_proc6() {
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

            if (confirm("�������۾� �ʱ�ȭ�� �Ͻðڽ��ϱ�? ") == false) return;

			PRO_STS = "6";//�������۾� �ʱ�ȭ

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//Ʈ����� ����
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca090.cmd.YACA090CMD&S_MODE=PROC6";
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


  			if(state == "1"){//�۾�����
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC2").disabled = false;
				document.getElementById("btnPROC2").className="";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//����ڼ��� �ʱ�ȭ
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//�⸻������ �ʱ�ȭ

  			}else if(state == "2" ){//����ڼ��� �Ϸ�
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = false;
				document.getElementById("btnPROC3").className="";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//����ڼ��� �ʱ�ȭ
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//�⸻������ �ʱ�ȭ				
				
  			}else if(state == "3" ){//�⸻������ �Ϸ�
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
	  			document.getElementById("btnPROC4").disabled = false;
				document.getElementById("btnPROC4").className="";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//����ڼ��� �ʱ�ȭ
	  			document.getElementById("btnPROC6").disabled = false;
				document.getElementById("btnPROC6").className="";//�⸻������ �ʱ�ȭ

  			}else if(state == "4"){//�۾�����
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//����ڼ��� �ʱ�ȭ
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//�⸻������ �ʱ�ȭ

  			}else if(state == "5"){//����ڼ��� �ʱ�ȭ
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC2").disabled = false;
				document.getElementById("btnPROC2").className="";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = true;
				document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = true;
				document.getElementById("btnPROC5").className="inputDisabled";//����ڼ��� �ʱ�ȭ
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//�⸻������ �ʱ�ȭ				
				
  			}else if(state == "6"){//�������۾� �ʱ�ȭ
  				
	  			document.getElementById("btnPROC1").disabled = true;
				document.getElementById("btnPROC1").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC2").disabled = true;
				document.getElementById("btnPROC2").className="inputDisabled";//����ڼ���
	  			document.getElementById("btnPROC3").disabled = false;
				document.getElementById("btnPROC3").className="";//�⸻������
	  			document.getElementById("btnPROC4").disabled = true;
				document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
	  			document.getElementById("btnPROC5").disabled = false;
				document.getElementById("btnPROC5").className="";//����ڼ��� �ʱ�ȭ
	  			document.getElementById("btnPROC6").disabled = true;
				document.getElementById("btnPROC6").className="inputDisabled";//�⸻������ �ʱ�ȭ						
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

  			document.getElementById("btnPROC1").disabled = true;
			document.getElementById("btnPROC1").className="inputDisabled";//�۾�����
  			document.getElementById("btnPROC2").disabled = true;
			document.getElementById("btnPROC2").className="inputDisabled";//����ڼ���
  			document.getElementById("btnPROC3").disabled = true;
			document.getElementById("btnPROC3").className="inputDisabled";//�⸻������
  			document.getElementById("btnPROC4").disabled = true;
			document.getElementById("btnPROC4").className="inputDisabled";//�۾�����
  			document.getElementById("btnPROC5").disabled = true;
			document.getElementById("btnPROC5").className="inputDisabled";//����ڼ��� �ʱ�ȭ
  			document.getElementById("btnPROC6").disabled = true;
			document.getElementById("btnPROC6").className="inputDisabled";//�⸻������ �ʱ�ȭ

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

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "�۾��� �����Ͽ����ϴ�.";
				enableInput("1");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "����� ������ �Ϸ��Ͽ����ϴ�.";
				enableInput("2");				
            }else if(PRO_STS == "3"){
               	document.getElementById("txtPRO_STS_MSG").value = "�������� �Ϸ��Ͽ����ϴ�.";
				enableInput("3");
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "�۾��� �����Ͽ����ϴ�.";
               	enableInput("4");
            }else if(PRO_STS == "5"){
               	document.getElementById("txtPRO_STS_MSG").value = "����ڼ��� �ʱ�ȭ�� �Ϸ��Ͽ����ϴ�.";
               	enableInput("5");
            }else if(PRO_STS == "6"){
               	document.getElementById("txtPRO_STS_MSG").value = "�������۾� �ʱ�ȭ�� �Ϸ��Ͽ����ϴ�.";
               	enableInput("6");               	
            }

    </Script>

    <Script For=dsT_CP_WORKLOG_01 Event="OnLoadCompleted(iCount)">
        if(iCount == 0) {
        	
        } else {

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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">����������ó��</td>
                    <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">����������ó��</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
	<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="10"></col>
					<col width="160"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="center">�ش���</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YM" name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','80','108');"></a>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->


    <!-- ���� �Է� ���̺� ���� -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
    	<tr>
            <td class="paddingTop8">
    			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    				<colgroup>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    	        		<td align="center" class="blueBold">����ο�</td>
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
    	        		<td align="center" class="blueBold">�۾���Ȳ</td>
    	        		<td  class="padding2423">
    	        			<input id="txtPRO_STS" name="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
    	        			<input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
    	        		</td>
    	            </tr>
                    <tr>
                        <td align="center" class="blueBold">�۾�����</td>
                        <td  class="padding2423">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" �۾�����">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" ����ڼ��� " onclick="fnc_proc2()">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input type="button" id="btnPROC3" style="cursor:hand;width:140pt;height:25pt;" value=" �������۾� " onclick="fnc_proc3()">
                                    </td>
                                </tr>
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC4" style="cursor:hand;width:140pt;height:25pt;" value=" �۾����� " onclick="fnc_proc4()">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input type="button" id="btnPROC5" style="cursor:hand;width:140pt;height:25pt;" value=" ����ڼ��� �ʱ�ȭ " onclick="fnc_proc5()">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
		<C>Col=PRO_CNT     		Ctrl=txtPRO_CNT     		 	Param=value 		</C>
		<C>Col=ERR_CNT		     	Ctrl=txtERR_CNT     		 	Param=value 		</C>
    '>
</object>
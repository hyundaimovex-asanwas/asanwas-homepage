<!--
    ************************************************************************************
    * @source         : saga031.jsp 				                                                                                     *
    * @description   : �޿����ó��(������߰�) PAGE.                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/22  |  ������   | �����ۼ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�޿����ó��(������߰�)</title>
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
		var btnList = 'FFTFFFFT';

        var dsT_CP_WORKLOG = window.dialogArguments;//opener���� �޾ƿ´�.

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

        }

   		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

   			if( !fnc_SaveItemCheck() )	return;

			//Ʈ����� ����
			trT_CP_PAYMASTER.KeyValue = "SVL(I:SAV=dsT_CP_PAYMASTER)";
			trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga031.cmd.SAGA031CMD&S_MODE=SAV";
			trT_CP_PAYMASTER.Post();

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

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CP_PAYMASTER.CountColumn == 0) {
                dsT_CP_PAYMASTER.setDataHeader("OCC_CD:STRING(1):KEYVALUETYPE,PIS_YY:STRING(4):KEYVALUETYPE,PIS_MM:STRING(2):KEYVALUETYPE,SAL_GBN:STRING(1):KEYVALUETYPE,SEQ:STRING(2):KEYVALUETYPE,ENO_NO:STRING(8):KEYVALUETYPE,PRO_STS:STRING(1),ENO_NM:STRING(12),DPT_NM:STRING(12),JOB_NM:STRING(12)");
            }

            enableInput();

			dsT_CP_PAYMASTER.AddRow();

			var i = 1;

			//dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"OCC_CD")=dsT_CP_WORKLOG.NameValue(i,"OCC_CD");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_YY")=dsT_CP_WORKLOG.NameValue(i,"PIS_YY");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_MM")=dsT_CP_WORKLOG.NameValue(i,"PIS_MM");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SAL_GBN")=dsT_CP_WORKLOG.NameValue(i,"SAL_GBN");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SEQ")=dsT_CP_WORKLOG.NameValue(i,"SEQ");
			dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PRO_STS")="7";//������߰�

			/*alert(dsT_CP_PAYMASTER.RowPosition+"--->"+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"OCC_CD") +",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_YY")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PIS_MM")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SAL_GBN")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"SEQ")+",  "+
					dsT_CP_PAYMASTER.NameValue(dsT_CP_PAYMASTER.RowPosition,"PRO_STS"));*/

			document.form1.txtENO_NO.focus();

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

			// ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			// Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_CP_PAYMASTER.ColumnString(dsT_CP_PAYMASTER.RowPosition,8) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

			dsT_CP_PAYMASTER.DeleteRow(dsT_CP_PAYMASTER.RowPosition);

			if(dsT_CP_PAYMASTER.CountRow < 1){
				disableInput();
			}

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			fnc_OnLoadProcess();
			dsT_CP_PAYMASTER.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_PAYMASTER.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

			window.close();

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
			var oOCC_CD, oPIS_YY, oPIS_MM, oSAL_GBN, oENO_NO, oSEQ;

			var RowCnt = dsT_CP_PAYMASTER.CountRow;

			for(i=1; i<=RowCnt; i++){
				oOCC_CD = dsT_CP_PAYMASTER.NameValue(i,"OCC_CD");
				oPIS_YY = dsT_CP_PAYMASTER.NameValue(i,"PIS_YY");
				oPIS_MM = dsT_CP_PAYMASTER.NameValue(i,"PIS_MM");
				oSAL_GBN = dsT_CP_PAYMASTER.NameValue(i,"SAL_GBN");
				oENO_NO = dsT_CP_PAYMASTER.NameValue(i,"ENO_NO");
				oSEQ = dsT_CP_PAYMASTER.NameValue(i,"SEQ");

				dsT_CP_PAYMASTER_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga031.cmd.SAGA031CMD&S_MODE=SHR&OCC_CD="+oOCC_CD+"&PIS_YY="+oPIS_YY+"&PIS_MM="+oPIS_MM+"&SAL_GBN="+oSAL_GBN+"&ENO_NO="+oENO_NO+"&SEQ="+oSEQ;
    			dsT_CP_PAYMASTER_01.reset();

    			if(dsT_CP_PAYMASTER_01.CountRow != 0){
    				alert(dsT_CP_PAYMASTER.NameValue(i, "ENO_NM")+"["+dsT_CP_PAYMASTER.NameValue(i, "ENO_NO")+"]"+"�� �̹� ����� ������ �Ǿ� �ֽ��ϴ�.");
					return false;
    			}

			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");

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
         * �Է��ʵ� ��� �����ϰ�(Enable)          	        	 *
         ********************************************/
  		function enableInput(){

			document.form1.txtENO_NO.readOnly = false;
  			document.form1.txtENO_NO.className = "";
			document.form1.txtENO_NM.readOnly = false;
  			document.form1.txtENO_NM.className = "";
  			document.getElementById("imgENO_NO").disabled = false;

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtENO_NO.readOnly = true;
  			document.form1.txtENO_NO.className = "input_ReadOnly";
			document.form1.txtENO_NM.readOnly = true;
  			document.form1.txtENO_NM.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO").disabled = true;

  		}

		/**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO', 'txtENO_NM');

            fnc_GetUserInfo1();
        }

  		/**
         * fnc_GetEnoNm �ٸ������� �������� ������
         */
        function fnc_GetUserInfo1() {

            var i = 1;
            var obj = fnc_GetEnoNm("txtENO_NO");

            if (!(obj.occ_cd == "0" || obj.occ_cd == "1" || obj.occ_cd == "2" || obj.occ_cd != "3" )){

		            alert("�ش������� �޿���� ������ �ƴմϴ�.");

	            document.getElementById("txtOCC_CD").value = "";
	            document.getElementById("txtENO_NO").value = "";
	            document.getElementById("txtENO_NM").value = "";
	            document.getElementById("txtJOB_CD").value = "";
	            document.getElementById("txtJOB_NM").value = "";
	            document.getElementById("txtDPT_CD").value = "";
	            document.getElementById("txtDPT_NM").value = "";

            }else{
	            document.getElementById("txtOCC_CD").value = obj.occ_cd;
	            document.getElementById("txtENO_NO").value = obj.eno_no;
	            document.getElementById("txtENO_NM").value = obj.eno_nm;
	            document.getElementById("txtJOB_CD").value = obj.job_cd;
	            document.getElementById("txtJOB_NM").value = obj.job_nm;
	            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
	            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            }

        }

        function fnc_GetUserInfo2() {

            fnc_GetEnoNo("txtENO_NM","txtENO_NO");

            fnc_GetUserInfo1();

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
    | 2. �̸� : dsT_CP_PAYMASTER                                 |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_01                                 |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
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

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        //ó���� ���� CLOSE
		window.close();

    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CP_PAYMASTER event="OnFail()">
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
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�޿�ó��������߰�</td>
					<td align="right" class="navigator">HOME/�������/�޿�����/�޿����ó��/<font color="#000000">�޿�ó��������߰�</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!--����--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInsert','','/images/button/btn_InsertOver.gif',1)">    <img src="/images/button/btn_InsertOn.gif"   name="imgInsert"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <!--����--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)">    <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
            <!--ó��--><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_ConductOver.gif',1)">    <img src="/images/button/btn_ConductOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="195"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�����ȣ</td>
					<td class="padding2423" colspan="3">
						<input id="txtENO_NO" name="txtENO_NO" size="10" maxlength="8"  onkeypress="if(event.keyCode==13) fnc_GetUserInfo1();cfNumberCheck();" onChange="fnc_GetUserInfo1();" style="ime-mode:disabled">
						<input id="txtENO_NM" name="txtENO_NM" size="14" maxlength="14" onkeypress="if(event.keyCode==13) fnc_GetUserInfo2();" onChange="fnc_GetUserInfo2();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();"></a>

						<input type="hidden" id="txtOCC_CD" name="txtOCC_CD" >
					</td>
				</tr>
				<tr>
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
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
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
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:220px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=49			name='NO'					align=center				value={String(Currow)}	</C>
								<C> id='DPT_NM'				width=120			name='�Ҽ�'					align=center														</C>
								<C> id='JOB_NM'				width=120			name='����'					align=center														</C>
								<C> id='ENO_NO'				width=120			name='���'					align=center														</C>
								<C> id='ENO_NM'				width=120			name='����'					align=center														</C>
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
<!-- -->
<object id="bndT_CP_PAYMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_PAYMASTER">
	<Param Name="BindInfo", Value='

		<C>Col=OCC_CD     		 	Ctrl=txtOCC_CD     		 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM     		 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM 			 	Param=value 		</C>
		<C>Col=ENO_NO     		 	Ctrl=txtENO_NO    		 	Param=value 		</C>
		<C>Col=ENO_NM     		 	Ctrl=txtENO_NM 			 	Param=value 		</C>

    '>
</object>

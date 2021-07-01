<!--
***********************************************************************
* @source      : sagb010.jsp
* @description : ���κ� ��������/���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/22      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���κ� ��������/����(sagb010)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTFTT';

        var today = getToday();

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var occ_cd = document.getElementById('txtOCC_CD_SHR').value;
			var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_gbn = document.getElementById('cmbSAL_GBN_SHR').value;
			var bon_num = document.getElementById('cmbBON_NUM_SHR').value;

			dsT_CP_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb010.cmd.SAGB010CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&OCC_CD="+occ_cd+"&ENO_NO="+eno_no+"&SAL_GBN="+sal_gbn+"&BON_NUM="+bon_num;
    		dsT_CP_CHANGE.reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

				if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

				trT_CP_CHANGE.KeyValue = "tr01(I:dsT_CP_CHANGE=dsT_CP_CHANGE)";
				trT_CP_CHANGE.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb010.cmd.SAGB010CMD&S_MODE=SAV";
				trT_CP_CHANGE.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var SAL_NM = document.getElementById("txtSAL_NM").value;

			if(dsT_CP_CHANGE.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
            if(dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "TRS_TAG") == "F"){
                alert("���������� �����ʹ� ������ �� �����ϴ�!");
                return;
            }

			if(confirm("[�޿��׸�:"+SAL_NM+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_CP_CHANGE.DeleteRow(dsT_CP_CHANGE.RowPosition);
				trT_CP_CHANGE.KeyValue = "tr02(I:dsT_CP_CHANGE=dsT_CP_CHANGE)";
				trT_CP_CHANGE.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb010.cmd.SAGB010CMD&S_MODE=DEL";
				trT_CP_CHANGE.post();
			}

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_CHANGE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_CHANGE.GridToExcel("���κ��������Ұ���", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_CP_CHANGE.CountColumn < 1){
				alert("��ȸ �� �ű� �׸� �߰��� �����մϴ�!");
                return;
			}

            var cnt = dsT_CP_CHANGE.CountRow;

			dsT_CP_CHANGE.AddRow();

            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "OCC_CD") = document.getElementById('txtOCC_CD_SHR').value;
            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "PIS_YY") = document.getElementById('txtPIS_YM_SHR').value.substring(0,4);
            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "PIS_MM") = document.getElementById('txtPIS_YM_SHR').value.substring(5,7);
            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "ENO_NO") = document.getElementById('txtENO_NO_SHR').value;
            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "DPT_CD") = document.getElementById('txtDPT_CD_SHR').value;
            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "JOB_CD") = document.getElementById('txtJOB_CD_SHR').value;
            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "SAL_GBN") = document.getElementById('cmbSAL_GBN_SHR').value;
            dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "BON_NUM") = document.getElementById('cmbBON_NUM_SHR').value;
            if(cnt < 1){
                dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "SEQ") = 0;
            }else{
                dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition, "SEQ") = Number(dsT_CP_CHANGE.NameValue(cnt, "SEQ"))+1;
            }



			document.getElementById('txtSAL_CD').focus();

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			document.getElementById('txtPIS_YM_SHR').className = "";
            document.getElementById('txtPIS_YM_SHR').readOnly = false;
	        document.getElementById('txtENO_NO_SHR').className = "";
	        document.getElementById('txtENO_NO_SHR').readOnly = false;
	        document.getElementById('txtENO_NM_SHR').className = "";
	        document.getElementById('txtENO_NM_SHR').readOnly = false;
	        document.getElementById('imgENO_NO_SHR').disabled = false;
            document.getElementById('cmbSAL_GBN_SHR').disabled = false;
            document.getElementById('cmbBON_NUM_SHR').disabled = false;
            //document.getElementById('txtPIS_YM_SHR').value = "";
            document.getElementById('cmbSAL_GBN_SHR').value = "0";
            document.getElementById('cmbBON_NUM_SHR').value = "1";
            //document.getElementById('txtENO_NO_SHR').value = "";
            //document.getElementById('txtENO_NM_SHR').value = "";
            //document.getElementById('txtOCC_CD_SHR').value = "";
            //document.getElementById('txtOCC_NM_SHR').value = "";
            //document.getElementById('txtDPT_CD_SHR').value = "";
            //document.getElementById('txtDPT_NM_SHR').value = "";
            //document.getElementById('txtJOB_CD_SHR').value = "";
            //document.getElementById('txtJOB_NM_SHR').value = "";
            //document.getElementById('txtRET_YMD_SHR').value = "";

   			form1.medAMOUNT.Enable = "false";

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_CHANGE.ClearData();
			dsT_CP_CHANGE.ClearAll();

            document.getElementById('txtPIS_YM_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_CHANGE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			var pis_ym = document.getElementById('txtPIS_YM_SHR');
			var eno_no = document.getElementById('txtENO_NO_SHR');

            if(pis_ym.value == ""){
                alert("�ش����� �Է��ϼž� �մϴ�!");
                pis_ym.focus();
                return false;
            }
            if(eno_no.value == ""){
                alert("����� �˻��Ͽ� �Է��ϼž� �մϴ�!");
                eno_no.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_CP_CHANGE.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			var RowCnt = dsT_CP_CHANGE.CountRow;

			for(i=1; i<=RowCnt; i++){

				if(dsT_CP_CHANGE.NameValue(i,"SAL_CD").trim() == ""){
					alert("�޿��׸��� �Է��ϼ���.");
					dsT_CP_CHANGE.RowPosition = i;
					document.getElementById("txtSAL_CD").focus();
					return false;
				}

				if(dsT_CP_CHANGE.NameValue(i,"AD_TAG").trim() == ""){
					alert("������ �Է��ϼ���.");
					dsT_CP_CHANGE.RowPosition = i;
					document.getElementById("cmbAD_TAG").focus();
					return false;
				}

			}

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var occ_cd = document.getElementById('txtOCC_CD_SHR').value;
			var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_gbn = document.getElementById('cmbSAL_GBN_SHR').value;
			var bon_num = document.getElementById('cmbBON_NUM_SHR').value;

			dsT_CP_WORKLOG.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb010.cmd.SAGB010CMD&S_MODE=SHR_01&PIS_YM="+pis_ym+"&OCC_CD="+occ_cd+"&ENO_NO="+eno_no+"&SAL_GBN="+sal_gbn+"&SEQ="+bon_num;
    		dsT_CP_WORKLOG.reset();

			var PRO_STS = dsT_CP_WORKLOG.NameValue(1, "PRO_STS");

			/*
			if(PRO_STS == "4"){
				alert("���ó���� �Ϸ�Ǿ� ������ �� �� �����ϴ�.");
		        return false;
			}
			*/

			if(PRO_STS == "6"){
				alert("�۾�CLOSE�� �Ǿ� ������ �� �� �����ϴ�.");
		        return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {


            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);

			cfStyleGrid(form1.grdT_CP_CHANGE,15,"true","true");      // Grid Style ����

  			//form1.medAMOUNT.Enable = "false";

            document.getElementById('txtPIS_YM_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO_SHR', 'txtENO_NM_SHR');

            fnc_GetUserInfo1();
        }

  		/**
         * fnc_GetEnoNm �ٸ������� �������� ������
         */
        function fnc_GetUserInfo1() {

            var obj = fnc_GetEnoNm("txtENO_NO_SHR");

            document.getElementById("txtENO_NO_SHR").value = obj.eno_no;
            document.getElementById("txtENO_NM_SHR").value = obj.eno_nm;
            document.getElementById("txtOCC_CD_SHR").value = obj.occ_cd;
            document.getElementById("txtOCC_NM_SHR").value = obj.occ_nm;
            document.getElementById("txtDPT_CD_SHR").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM_SHR").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD_SHR").value = obj.job_cd;
            document.getElementById("txtJOB_NM_SHR").value = obj.job_nm;
            document.getElementById("txtRET_YMD_SHR").value = obj.ret_ymd;

        }

        function fnc_GetUserInfo2() {
            fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');

            fnc_GetUserInfo1();
        }



        /******************************
         * 17. �Է� ����/�Ұ��� ó��  *
         *****************************/
		function fnc_EnableDisable(row) {

			//���������̸� �ԷºҰ�
            if(dsT_CP_CHANGE.NameValue(row, "TRS_TAG") == "F"){

                document.getElementById("txtSAL_CD").className = "input_ReadOnly";
                document.getElementById("txtSAL_CD").readOnly = true;
	  			form1.medAMOUNT.Enable = "false";
                document.getElementById("cmbAD_TAG").disabled = true;
                document.getElementById("txtREMARK").className = "input_ReadOnly";
                document.getElementById("txtREMARK").readOnly = true;

                document.form1.grdT_CP_CHANGE.Focus();

            }else{

                document.getElementById("txtSAL_CD").className = "";
                document.getElementById("txtSAL_CD").readOnly = false;
	  			form1.medAMOUNT.Enable = "true";
                document.getElementById("cmbAD_TAG").disabled = false;
                document.getElementById("txtREMARK").className = "";
                document.getElementById("txtREMARK").readOnly = false;

            }

		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_CHANGE)   |
    | 3. ���Ǵ� Table List(T_CP_CHANGE)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_CP_CHANGE)	    |
    | 3. ���Ǵ� Table List(T_CP_CHANGE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CP_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnLoadCompleted(iCount)">

        document.getElementById('txtPIS_YM_SHR').className = "input_ReadOnly";
        document.getElementById('txtPIS_YM_SHR').readOnly = true;
        document.getElementById('txtENO_NO_SHR').className = "input_ReadOnly";
        document.getElementById('txtENO_NO_SHR').readOnly = true;
        document.getElementById('txtENO_NM_SHR').className = "input_ReadOnly";
        document.getElementById('txtENO_NM_SHR').readOnly = true;
        document.getElementById('imgENO_NO_SHR').disabled = true;
        document.getElementById('cmbSAL_GBN_SHR').disabled = true;
		document.getElementById('cmbBON_NUM_SHR').disabled = true;

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            fnc_EnableDisable("1");

        }

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�޿��׸�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CP_CHANGE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CP_CHANGE event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!---------------------------------------------+
    | Grid Ŭ���� �Է� ����/�Ұ��� ó��			   |
    +---------------------------------------------->
	<script language="javascript"  for=dsT_CP_CHANGE event=OnRowPosChanged(row)>

		if(row > 0){
            fnc_EnableDisable(row);//�Է� ����/�Ұ��� ó��
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ���������/����</td>
					<td align="right" class="navigator">HOME/�������/�������/<font color="#000000">���κ���������/����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
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
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="60"></col>
									<col width="100"></col>
									<col width="80"></col>
									<col width="140"></col>
									<col width="60"></col>
									<col width="90"></col>
									<col width="50"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td class="searchState" align="right">�ش���&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM_SHR.readOnly == true){return;} calendarBtn('datetype2','txtPIS_YM_SHR','','5','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="center" class="searchState">�޻󿩱���&nbsp;</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="width:100" onChange="fnc_SearchList();">
										<option value="0" >�޿�</option>
	                                    <option value="1" >��</option>
	                                    <option value="4" >����</option>

									</select>
								</td>
								<td align="center" class="searchState">�Ϸù�ȣ&nbsp;</td>
								<td>
									<select id="cmbBON_NUM_SHR" style="width:70" onChange="fnc_SearchList();">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
								<td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423">
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetUserInfo1();cfNumberCheck();" onChange="fnc_GetUserInfo1();">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetUserInfo2();" onChange="fnc_GetUserInfo2();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();"></a>
								</td>
							</tr>
                            <tr>
                                <td align="right" class="searchState">�ٷα���&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtOCC_CD_SHR" size="2" class="input_ReadOnly" readonly>
                                    <input id="txtOCC_NM_SHR" size="8" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�Ҽ�&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtDPT_CD_SHR" size="3" class="input_ReadOnly" readonly>
                                    <input id="txtDPT_NM_SHR" size="16" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">����&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtJOB_CD_SHR" size="3" class="input_ReadOnly" readonly>
                                    <input id="txtJOB_NM_SHR" size="6" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�����&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtRET_YMD_SHR" size="16" class="input_ReadOnly" readonly>
                                </td>
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
					<col width="170"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�޿��׸�</td>
					<td class="padding2423">
						<input id="txtSAL_CD" name="txtSAL_CD" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');" onChange="fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');">
						<input id="txtSAL_NM" name="txtSAL_NM" size="16" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD','txtSAL_NM','�޿������׸�','U4');return false;"></a>
                    </td>
					<td align="center" class="creamBold">��  ��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=8>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
					<td align="center" class="creamBold">��  ��</td>
					<td class="padding2423">
                        <select id="cmbAD_TAG" style="WIDTH: 100%" >
						    <option value="A">�� ��</option>
						    <option value="D">�� ��</option>
						</select>
                    </td>
					<td align="center" class="creamBold">��������</td>
					<td class="padding2423">
                        <input id="txtTRS_TAG" style="WIDTH: 100%" class="input_ReadOnly" readonly></td>
				</tr>
                <tr>
					<td align="center" class="creamBold">��  ��</td>
					<td class="padding2423" colspan="7">
                        <input id="txtREMARK" style="WIDTH: 100%;" onKeyUp="fc_chk_byte(this,60);">
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:310px;">
							<param name="DataID"					value="dsT_CP_CHANGE">
							<param name="SortView"				value="Left">							
							<param name="Format"					value="
								<C> id={currow}		width=49    name='NO'			align=center </C>
								<C> id='SAL_NM'		width=140	name='�޿��׸�'		align=left      LeftMargin='10' </C>
								<C> id='AMOUNT'		width=120	name='�ݾ�'			align=right RightMargin='10' </C>
								<C> id='AD_TAG'		width=80	name='����'		    align=center    Value={Decode(AD_TAG,'A','����','D','����')} </C>
								<C> id='TRS_NM'	width=80	name='��������'	    align=center </C>
								<C> id='REMARK'	    width=295	name='����'		    align=left LeftMargin='10' </C>
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
<!-- �޻� ���� ���λ��� ���� ���̺� -->
<object id="bndT_CP_CHANGE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_CHANGE">
	<Param Name="BindInfo", Value='
		<C>Col=SAL_CD		Ctrl=txtSAL_CD	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_NM		Ctrl=txtSAL_NM	      	Param=value		Disable=disabled</C>
		<C>Col=AMOUNT    	Ctrl=medAMOUNT	     	Param=text		Disable=disabled</C>
		<C>Col=AD_TAG		Ctrl=cmbAD_TAG      	Param=value		Disable=disabled</C>
		<C>Col=TRS_NM		Ctrl=txtTRS_TAG	      	Param=value		Disable=disabled</C>
		<C>Col=REMARK		Ctrl=txtREMARK	     	Param=value		Disable=disabled</C>
    '>
</object>
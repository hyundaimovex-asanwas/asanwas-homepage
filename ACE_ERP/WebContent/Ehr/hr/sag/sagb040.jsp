<!--
***********************************************************************
* @source      : sagb040.jsp
* @description : ���κ� ��������/���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/23      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���κ� ��������/����(sagb040)</title>
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

		var btnList = 'TTTTTTTT';

        var today = getToday();

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;

			var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var end_yn = document.getElementById('cmbEND_YN_SHR').value;
            var gbn = "";
             //����1
            if(f.rdoGBN_SHR[0].checked){
                gbn = "ENO_NO";
            }else if(f.rdoGBN_SHR[1].checked){
                gbn = "SAL_CD";
            }

			dsT_CP_FIXED.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb040.cmd.SAGB040CMD&S_MODE=SHR&GBN="+gbn+"&ENO_NO="+eno_no+"&SAL_CD="+sal_cd+"&END_YN="+end_yn;
    		dsT_CP_FIXED.reset();

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

				trT_CP_FIXED.KeyValue = "tr01(I:dsT_CP_FIXED=dsT_CP_FIXED)";
				trT_CP_FIXED.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb040.cmd.SAGB040CMD&S_MODE=SAV";
				trT_CP_FIXED.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var SAL_NM = document.getElementById("txtSAL_NM").value;

			if(dsT_CP_FIXED.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

			if(confirm("[���:"+dsT_CP_FIXED.NameValue(dsT_CP_FIXED.RowPosition,"ENO_NO")+"/����:"+dsT_CP_FIXED.NameValue(dsT_CP_FIXED.RowPosition,"ENO_NM")+"/�޿��׸�:"+SAL_NM+"]\n�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_CP_FIXED.DeleteRow(dsT_CP_FIXED.RowPosition);
				trT_CP_FIXED.KeyValue = "tr02(I:dsT_CP_FIXED=dsT_CP_FIXED)";
				trT_CP_FIXED.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb040.cmd.SAGB040CMD&S_MODE=DEL";
				trT_CP_FIXED.post();
			}

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

           var f = document.form1;

			var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var end_yn = document.getElementById('cmbEND_YN_SHR').value;
            var gbn = "";
             //����1
            if(f.rdoGBN_SHR[0].checked){
                gbn = "ENO_NO";
            }else if(f.rdoGBN_SHR[1].checked){
                gbn = "SAL_CD";
            }

	        var url = "sagb040_PV.jsp?GBN="+gbn+"&ENO_NO="+eno_no+"&SAL_CD="+sal_cd+"&END_YN="+end_yn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_FIXED.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_FIXED.GridToExcel("���κ��������Ұ���", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_CP_FIXED.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_CP_FIXED.setDataHeader("OCC_CD:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, SAL_CD:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, AD_TAG:STRING, AMOUNT:NUMBER, SAL_GBN:STRING, DPT_CD:STRING, JOB_CD:STRING, ENO_NM:STRING, DPT_NM:STRING, JOB_NM:STRING");
			}

			dsT_CP_FIXED.AddRow();

			document.getElementById('txtENO_NO').focus();

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

            document.form1.rdoGBN_SHR[0].checked = true;
            document.getElementById('txtENO_NO_SHR').value = "";
            document.getElementById('txtENO_NM_SHR').value = "";
            document.getElementById('hidOCC_CD_SHR').value = "";
            document.getElementById('txtOCC_NM_SHR').value = "";
            document.getElementById('txtRET_YMD_SHR').value = "";
            document.getElementById('txtSAL_CD_SHR').value = "";
            document.getElementById('txtSAL_NM_SHR').value = "";
            document.getElementById('cmbEND_YN_SHR').value = "N";

   			//form1.medAMOUNT.Enable = "false";

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_FIXED.ClearData();

            document.getElementById('txtENO_NO_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_FIXED.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_CP_FIXED.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			var RowCnt = dsT_CP_FIXED.CountRow;

			for(i=1; i<=RowCnt; i++){

	            if(dsT_CP_FIXED.NameValue(i,"ENO_NO").trim() == ""){
	                alert("����� �Է��ϼ���.");
					dsT_CP_FIXED.RowPosition = i;
	                document.getElementById('txtENO_NO').focus();
	                return false;
	            }

	            if(dsT_CP_FIXED.NameValue(i,"ENO_NO").trim().length != 7 || dsT_CP_FIXED.NameValue(i,"ENO_NM").trim() == ""){
	                alert("�ùٸ� ����� �ƴմϴ�.");
					dsT_CP_FIXED.RowPosition = i;
	                document.getElementById('txtENO_NO').focus();
	                return false;
	            }

   				if(dsT_CP_FIXED.NameValue(i,"SAL_CD").trim() == ""){
					alert("�޿��׸��� �Է��ϼ���.");
					dsT_CP_FIXED.RowPosition = i;
					document.getElementById("txtSAL_CD").focus();
					return false;
				}

				if(dsT_CP_FIXED.NameValue(i,"SAL_GBN").trim() == ""){
					alert("�޻󿩱����� �Է��ϼ���.");
					dsT_CP_FIXED.RowPosition = i;
					document.getElementById("cmbSAL_GBN").focus();
					return false;
				}

				if(dsT_CP_FIXED.NameValue(i,"AD_TAG").trim() == ""){
					alert("������ �Է��ϼ���.");
					dsT_CP_FIXED.RowPosition = i;
					document.getElementById("cmbAD_TAG").focus();
					return false;
				}

			}
			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_CP_FIXED,15,"true","true");      // Grid Style ����

  		//	form1.medAMOUNT.Enable = "false";

            document.getElementById('cmbEND_YN_SHR').value = "N";
            document.getElementById('txtENO_NO_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/***********************
         * 16. �����ȸ�� �˾� *
         **********************/
		function fnc_EmplPop(gbn) {

			var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(gbn == '1'){
                document.getElementById("txtENO_NO_SHR").value = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value = obj.eno_nm;
                document.getElementById("hidOCC_CD_SHR").value = obj.occ_cd;
                document.getElementById("txtOCC_NM_SHR").value = obj.occ_nm;
                document.getElementById("txtRET_YMD_SHR").value = obj.ret_ymd;
            }else{
                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("hidOCC_CD").value = obj.occ_cd;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
            }

		}

        /**********************************
         * 17. ������� ���������ȸ ó�� *
         *********************************/
        function fnc_UserGetEnoNm(gbn) {

            var obj = new String();

            if(gbn == '1'){
                obj = fnc_GetEnoNm("txtENO_NO_SHR");
                document.getElementById("txtENO_NM_SHR").value = obj.eno_nm;
                document.getElementById("hidOCC_CD_SHR").value = obj.occ_cd;
                document.getElementById("txtOCC_NM_SHR").value = obj.occ_nm;
                document.getElementById("txtRET_YMD_SHR").value = obj.ret_ymd;
            }else{
                obj = fnc_GetEnoNm("txtENO_NO");
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("hidOCC_CD").value = obj.occ_cd;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
            }

        }

        /**********************************
         * 18. �̸����� ���������ȸ ó�� *
         *********************************/
        function fnc_UserGetEnoNo(gbn) {

            var obj = new String();

            if(gbn == '1'){
	            fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');

				fnc_UserGetEnoNm(gbn);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_FIXED)   |
    | 3. ���Ǵ� Table List(T_CP_FIXED)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_FIXED" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_CP_FIXED)	    |
    | 3. ���Ǵ� Table List(T_CP_FIXED)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CP_FIXED" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_FIXED Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
 			form1.medAMOUNT.Enable = "true";
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_FIXED Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_FIXED Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���/�޿��׸�/������/�޻󿩱���]\n�Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[���/�޿��׸�/������/�޻󿩱���]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CP_FIXED event="OnSuccess()">
        //fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CP_FIXED event="OnFail()">
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
									<col width="80"></col>
									<col width="500"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td align="right" class="searchState" rowspan="2">�˻�����&nbsp;</td>
								<td class="padding2423" rowspan="2">
                                    <table width="100%" height="100%" border="1" cellspacing="1" cellpadding="2">
                                        <tr>
                                            <td><input type="radio" id="radio1" name="rdoGBN_SHR" style="border:none" value="0" checked>�����ȣ&nbsp;&nbsp;
                                                <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxLength="8" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_UserGetEnoNm('1'); cfNumberCheck();" onChange="fnc_UserGetEnoNm('1')">
									            <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="10" maxlength="12" onKeypress="javascript:if(event.keyCode==13) fnc_UserGetEnoNo('1');" onChange="fnc_UserGetEnoNo('1')">
									            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPop('1');"></a>
                                                <input type="hidden" id="hidOCC_CD_SHR">
                                                �ٷα��� <input id=txtOCC_NM_SHR name=txtOCC_NM_SHR size="8" class="input_ReadOnly" readonly>
                                                ����� <input id=txtRET_YMD_SHR name=txtRET_YMD_SHR size="12" class="input_ReadOnly" readonly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><input type="radio" id="radio2" name="rdoGBN_SHR" style="border:none" value="0">�޿��׸�&nbsp;&nbsp;
												<input id="txtSAL_CD_SHR" name="txtSAL_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');" onChange="fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');">
												<input id="txtSAL_NM_SHR" name="txtSAL_NM_SHR" size="16" class="input_ReadOnly" readonly>
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD_SHR','txtSAL_NM_SHR','�޿������׸�','U4');"></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>&nbsp;</td>
							</tr>
                            <tr>
                                <td align="right" class="searchState">���Ῡ��&nbsp;</td>
								<td>
									<select id="cmbEND_YN_SHR" style="width:100" onChange="fnc_SearchList();">
                                        <option value="" >�� ü</option>
										<option value="Y" >�� ��</option>
	                                    <option value="N" >������</option>
									</select>
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
					<col width="137"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
                <tr>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" style="width:80;ime-mode:disabled" maxLength="8" onKeypress="cfNumberCheck();" onChange="fnc_UserGetEnoNm('2')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtENO_NO.disabled == true){return;} fnc_EmplPop();"></a>
                    </td>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" style="width:100%" class="input_ReadOnly" readonly>
                        <input type="hidden" id="hidOCC_CD" name="hidOCC_CD">
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtJOB_CD" name="txtJOB_CD" style="width:30" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" name="txtJOB_NM" style="width:50" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtDPT_CD" name="txtDPT_CD" style="width:30" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" name="txtDPT_NM" style="width:90" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
					<td align="center" class="creamBold">�޿��׸�</td>
					<td class="padding2423">
						<input id="txtSAL_CD" name="txtSAL_CD" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');" onChange="fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');">
						<input id="txtSAL_NM" name="txtSAL_NM" size="11" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD','txtSAL_NM','�޿������׸�','U4');return false;"></a>
                    </td>
					<td align="center" class="creamBold">�� ��</td>
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
                    <td align="center" class="creamBold">������</td>
					<td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtSTR_YMD.disabled == true) return; calendarBtn('datetype1','txtSTR_YMD','','410','215');"></a>
                    </td>
                    <td align="center" class="creamBold">������</td>
					<td class="padding2423">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtEND_YMD.disabled == true) return; calendarBtn('datetype1','txtEND_YMD','','600','215');"></a>
                    </td>
				</tr>
                <tr>
					<td align="center" class="creamBold">�޻󿩱���</td>
					<td class="padding2423">
                        <select id="cmbSAL_GBN" style="width:100%">
							<option value="0" >�� ��</option>
	                        <option value="1" >�� ��</option>
						</select>
                    </td>
                    <td align="center" class="creamBold">��  ��</td>
					<td class="padding2423">
                        <select id="cmbAD_TAG" style="WIDTH: 100%" >
						    <option value="A">�� ��</option>
						    <option value="D">�� ��</option>
						</select>
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
						<object	id="grdT_CP_FIXED" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
							<param name="DataID"					value="dsT_CP_FIXED">
							<param name="SortView"					value="Left">
							<param name="Format"					value="
								<C> id={currow}		width=39    name='NO'			align=center </C>
                                <C> id='DPT_NM'	    width=80	name='�Ҽ�'	        align=left </C>
                                <C> id='JOB_NM'	    width=60	name='����'	        align=center </C>
                                <C> id='ENO_NO'	    width=60	name='���'	        align=center </C>
                                <C> id='ENO_NM'	    width=60	name='����'	        align=center </C>
								<C> id='SAL_NM'		width=100	name='�޿��׸�'		align=left      LeftMargin='10' </C>
                                <C> id='SAL_GBN'	width=80	name='�޻󿩱���'	align=center    Value={Decode(SAL_GBN,'0','�޿�','1','��')} </C>
                                <C> id='STR_YMD'	width=80	name='������'	    align=center </C>
                                <C> id='END_YMD'	width=80	name='������'	    align=center </C>
								<C> id='AMOUNT'		width=75	name='�ݾ�'			align=right </C>
								<C> id='AD_TAG'		width=50	name='����'		    align=center    Value={Decode(AD_TAG,'A','����','D','����')} </C>
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
<object id="bndT_CP_FIXED" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_FIXED">
	<Param Name="BindInfo", Value='
        <C>Col=OCC_CD		Ctrl=hidOCC_CD	      	Param=value		</C>
        <C>Col=DPT_CD		Ctrl=txtDPT_CD	      	Param=value		</C>
        <C>Col=DPT_NM		Ctrl=txtDPT_NM	      	Param=value		</C>
        <C>Col=JOB_NM		Ctrl=txtJOB_NM	      	Param=value		</C>
        <C>Col=JOB_CD		Ctrl=txtJOB_CD	      	Param=value		</C>
        <C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		Disable=disabled</C>
        <C>Col=ENO_NM		Ctrl=txtENO_NM	      	Param=value		</C>
        <C>Col=SAL_GBN		Ctrl=cmbSAL_GBN	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_CD		Ctrl=txtSAL_CD	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_NM		Ctrl=txtSAL_NM	      	Param=value		Disable=disabled</C>
		<C>Col=AMOUNT    	Ctrl=medAMOUNT	     	Param=text		Disable=disabled</C>
		<C>Col=AD_TAG		Ctrl=cmbAD_TAG      	Param=value		Disable=disabled</C>
        <C>Col=STR_YMD		Ctrl=txtSTR_YMD      	Param=value		Disable=disabled</C>
        <C>Col=END_YMD		Ctrl=txtEND_YMD      	Param=value		Disable=disabled</C>
    '>
</object>
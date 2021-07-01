<!--
***********************************************************************
* @source      : sagb030.jsp
* @description : ��������/�������� PAGE
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
<title>��������/��������(sagb030)</title>
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
		var btnList = 'TFFTTTTT';

        var today = getToday();

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var occ_cd = document.getElementById('cmbOCC_CD_SHR').value;
            var sal_gbn = document.getElementById('cmbSAL_GBN_SHR').value;
			var bon_num = document.getElementById('cmbBON_NUM_SHR').value;
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var ad_tag = document.getElementById('cmbAD_TAG_SHR').value;
            var ipt_man = document.getElementById('txtIPT_MAN_SHR').value;
            var wrk_seq = document.getElementById('cmbWRK_SEQ_SHR').value;
            var gbn = "";
             //����1
            if(f.rdoGBN_SHR[0].checked){
                gbn = "SMR";
            }else if(f.rdoGBN_SHR[1].checked){
                gbn = "DTL";
            }

			dsT_CP_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb030.cmd.SAGB030CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&OCC_CD="+occ_cd+"&SAL_GBN="+sal_gbn+"&BON_NUM="+bon_num+"&SAL_CD="+sal_cd+"&AD_TAG="+ad_tag+"&GBN="+gbn+"&IPT_MAN="+ipt_man+"&WRK_SEQ="+wrk_seq;
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

				//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CP_CHANGE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            //�۾���ȣ�� ������ �������� ���Ѵ�.
            if(dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"WRK_SEQ") == null || dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"WRK_SEQ") == ""){
                alert("�۾���ȣ�� �����Ƿ� �ش� �޿��׸��� ������ �� �����ϴ�.");
                return false;
            }

            if(dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"ENO_NO") == null || dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"ENO_NO") == ""){
                if (confirm("�۾���ȣ["+ dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"WRK_SEQ") +"] �ڷḦ ���� �����Ͻðڽ��ϱ�?") == false) return;
            }else{
                if (confirm("���["+dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"ENO_NO")+"], ����["+dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"ENO_NM")+"], �޿��׸�["+dsT_CP_CHANGE.NameValue(dsT_CP_CHANGE.RowPosition,"SAL_NM")+"] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            }

            dsT_CP_CHANGE.DeleteRow(dsT_CP_CHANGE.RowPosition);

            trT_CP_CHANGE.KeyValue = "SVL(I:dsT_CP_CHANGE=dsT_CP_CHANGE)";
            trT_CP_CHANGE.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb030.cmd.SAGB030CMD&S_MODE=DEL";
            trT_CP_CHANGE.post();

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var occ_cd = document.getElementById('cmbOCC_CD_SHR').value;
            var sal_gbn = document.getElementById('cmbSAL_GBN_SHR').value;
			var bon_num = document.getElementById('cmbBON_NUM_SHR').value;
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var ad_tag = document.getElementById('cmbAD_TAG_SHR').value;
            var ipt_man = document.getElementById('txtIPT_MAN_SHR').value;
            var gbn = "";
             //����1
            if(f.rdoGBN_SHR[0].checked){
                alert("����ȸ�� �������� �μ��ư�� Ŭ���� �ֽʽÿ�.");
                return;
            }else if(f.rdoGBN_SHR[1].checked){
                gbn = "DTL";
            }

	        var url = "sagb030_PV.jsp?PIS_YM="+pis_ym+"&OCC_CD="+occ_cd+"&SAL_GBN="+sal_gbn+"&BON_NUM="+bon_num+"&SAL_CD="+sal_cd+"&AD_TAG="+ad_tag+"&IPT_MAN="+ipt_man;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_CHANGE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_CHANGE.GridToExcel("�������Ұ�������", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

			document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);
            document.getElementById('cmbOCC_CD_SHR').value = "";
            document.getElementById('cmbSAL_GBN_SHR').value = "0";
            document.getElementById('cmbBON_NUM_SHR').value = "1";
            document.getElementById('txtSAL_CD_SHR').value = "";
            document.getElementById('txtSAL_NM_SHR').value = "";
            document.getElementById('cmbAD_TAG_SHR').value = "";
            document.form1.rdoGBN_SHR[0].checked = true;
            fnc_EnableDisable();

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_CHANGE.ClearData();

            fnc_SearchWRK_SEQ();

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

            if(pis_ym.value == ""){
                alert("�ش����� �Է��ϼž� �մϴ�!");
                pis_ym.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);

			cfStyleGrid(form1.grdT_CP_CHANGE,15,"false","false");      // Grid Style ����

			fnc_EnableDisable();

			fnc_SearchWRK_SEQ();

            document.getElementById('txtPIS_YM_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /******************************
         * 16. �Է� ����/�Ұ��� ó��  *
         *****************************/
		function fnc_EnableDisable() {

			if(document.form1.rdoGBN_SHR[0].checked == true){
                document.getElementById("txtIPT_MAN_SHR").className = "input_ReadOnly";
                document.getElementById("txtIPT_MAN_SHR").readOnly = true;
                document.getElementById("txtENO_NM_SHR").className = "input_ReadOnly";
                document.getElementById("txtENO_NM_SHR").readOnly = true;
		        document.getElementById('imgIPT_MAN_SHR').disabled = true;
                document.getElementById("txtIPT_MAN_SHR").value = "";
                document.getElementById("txtENO_NM_SHR").value = "";
            }else{
                document.getElementById("txtIPT_MAN_SHR").className = "";
                document.getElementById("txtIPT_MAN_SHR").readOnly = false;
                document.getElementById("txtENO_NM_SHR").className = "";
                document.getElementById("txtENO_NM_SHR").readOnly = false;
		        document.getElementById('imgIPT_MAN_SHR').disabled = false;
            }

		}

		function fnc_SearchWRK_SEQ() {

            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

            var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var sal_gbn = document.getElementById('cmbSAL_GBN_SHR').value;
            var bon_num = document.getElementById('cmbBON_NUM_SHR').value;
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var ad_tag = document.getElementById('cmbAD_TAG_SHR').value;

		  //��ȣ�� �ٲ�Ƿ� �ʱ�ȭ
		  document.getElementById("cmbWRK_SEQ_SHR").value = "";

          dsT_CP_CHANGE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb030.cmd.SAGB030CMD&S_MODE=SHR_01&PIS_YM="+pis_ym+"&SAL_GBN="+sal_gbn+"&BON_NUM="+bon_num+"&SAL_CD="+sal_cd+"&AD_TAG="+ad_tag;
          dsT_CP_CHANGE_01.reset();

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

    <Object ID="dsT_CP_CHANGE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <Script For=dsT_CP_CHANGE_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

            //������ ����
            document.getElementById("cmbWRK_SEQ_SHR").options.length = 0;

            oOption       = document.createElement("OPTION");
            oOption.value = "";
            oOption.text  = "��ü";
            document.getElementById("cmbWRK_SEQ_SHR").add(oOption);

            //��������
            for(var i=1; i<=iCount; i++) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CP_CHANGE_01.NameValue(i,"WRK_SEQ");
                oOption.text  = dsT_CP_CHANGE_01.NameValue(i,"WRK_SEQ");
                document.getElementById("cmbWRK_SEQ_SHR").add(oOption);
            }

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

    <Script For=dsT_CP_CHANGE_01 Event="OnLoadError()">

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
	        alert("�ش� �ʼ��Է��׸�[�ش���/���/�޻󿩱���/�Ϸù�ȣ]\n�Է� �� ���� �۾��� �����մϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CP_CHANGE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        //������ Ŭ����
        fnc_Clear();
        //fnc_SearchWRK_SEQ();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CP_CHANGE event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������/��������</td>
					<td align="right" class="navigator">HOME/�������/�������/<font color="#000000">��������/��������</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
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
									<col width="60"></col>
									<col width="80"></col>
									<col width="35"></col>
									<col width="70"></col>
									<col width="70"></col>
									<col width="70"></col>
									<col width="60"></col>
									<col width="70"></col>
									<col width="60"></col>
									<col width=""></col>
								</colgroup>
							<tr>
								<td class="searchState" align="right">�ش���</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onchange="fnc_SearchWRK_SEQ();" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM_SHR.readOnly == true){return;} calendarBtn('datetype2','txtPIS_YM_SHR','','10','115');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">�ٷα���</td>
								<td class="padding2423">
									<select id="cmbOCC_CD_SHR" style="width:90%" onChange="fnc_SearchList();">
                                        <option value="" >��ü</option>
										<option value="A" >�繫��</option>
	                                <!--<option value="M" >�ù���</option>-->
									</select>
								</td>
                                <td align="right" class="searchState">�޻󿩱���</td>
								<td class="padding2423">
									<select id="cmbSAL_GBN_SHR" style="width:90%" onChange="fnc_SearchList();fnc_SearchWRK_SEQ();">
										<option value="0" >�޿�</option>
	                                    <option value="1" >��</option>
									</select>
								</td>
                                <td align="right" class="searchState">�Ϸù�ȣ</td>
                                <td class="padding2423">
                                    <select id="cmbBON_NUM_SHR" style="width:90%" onChange="fnc_SearchList();fnc_SearchWRK_SEQ();">
                                        <option value="1" >1</option>
                                        <option value="2" >2</option>
                                        <option value="3" >3</option>
                                    </select>
                                </td>
								<td align="right" class="searchState">�������</td>
                                <td class="padding2423">
                                    <input type="radio" id="radio1" name="rdoGBN_SHR" style="border:none" checked onClick="fnc_EnableDisable();">���&nbsp;
                                    <input type="radio" id="radio2" name="rdoGBN_SHR" style="border:none" onClick="fnc_EnableDisable();">��
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">�޿��׸�</td>
                                <td class="padding2423" colspan="3">
									<input id="txtSAL_CD_SHR" name="txtSAL_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');" onChange="fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');fnc_SearchWRK_SEQ();">
									<input id="txtSAL_NM_SHR" name="txtSAL_NM_SHR" size="16" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD_SHR','txtSAL_NM_SHR','�޿������׸�','U4');document.getElementById('txtSAL_CD_SHR').focus();"></a>
                                </td>
                                <td align="right" class="searchState">����</td>
								<td class="padding2423">
									<select id="cmbAD_TAG_SHR" style="width:90%" onChange="fnc_SearchList();fnc_SearchWRK_SEQ();">
                                        <option value="">��ü</option>
										<option value="A">����</option>
	                                    <option value="D">����</option>
									</select>
								</td>
                                <td class="searchState" align="right">�۾���ȣ</td>
                                <td class="padding2423">
                                    <select id="cmbWRK_SEQ_SHR" style="width:90%" onChange="fnc_SearchList();">
                                    </select>
                                </td>
                                <td align="right" class="searchState">�Է���</td>
                                <td class="padding2423">
                                    <input id="txtIPT_MAN_SHR" name="txtIPT_MAN_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtIPT_MAN_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtIPT_MAN_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtIPT_MAN_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtIPT_MAN_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgIPT_MAN_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgIPT_MAN_SHR" name="imgIPT_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtIPT_MAN_SHR','txtENO_NM_SHR');"></a>
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
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:360px;">
							<param name="DataID"					value="dsT_CP_CHANGE">
							<param name="Format"					value="
								<C> id={currow}		width=34    name='NO'			align=center value={String(Currow)}</C>
                                <C> id='SAL_NM'		width=110	name='�޿��׸�'		align=left      LeftMargin='10' </C>
                                <C> id='WRK_SEQ'    width=50	name='�۾���ȣ'		align=center    Value={Decode(WRK_SEQ,'0','',WRK_SEQ)} </C>
                                <C> id='DPT_NM'	    width=100	name='�Ҽ�'	        align=left </C>
                                <C> id='JOB_NM'	    width=60	name='����'	        align=center </C>
                                <C> id='ENO_NO'	    width=70	name='���'	        align=center </C>
                                <C> id='ENO_NM'	    width=70	name='����'	        align=center </C>
								<C> id='AMOUNT'		width=90	name='�ݾ�'			align=right </C>
								<C> id='REMARK'	    width=180	name='����'		    align=left LeftMargin='10' </C>
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

<!--
    ************************************************************************************
    * @source         : ymaa020.jsp 				                                                                                     *
    * @description   : ����������� PAGE.                                                                             *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/24  |  ������   | �����ۼ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����������</title>
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
		var btnList = 'TFTTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���

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

			//����� ������ ��ȸ ����.
			if(ENO_NO_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("����� �Է��ϼ���.");
					document.getElementById("txtENO_NO_SHR").focus();
					return false;
				}
			}

            //Ʈ����� ����
			trT_CP_YEARLYBONUS.KeyValue = "SVL(O:dsT_CP_YEARLYBONUS=dsT_CP_YEARLYBONUS)";
			trT_CP_YEARLYBONUS.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa020.cmd.YMAA020CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			trT_CP_YEARLYBONUS.Post();

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
			if( !fnc_SaveItemCheck() )	return;

			//Ʈ����� ����
			tr01T_CP_YEARLYBONUS.KeyValue = "SVL(I:SAV=dsT_CP_YEARLYBONUS)";
			tr01T_CP_YEARLYBONUS.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa020.cmd.YMAA020CMD&S_MODE=SAV";
			tr01T_CP_YEARLYBONUS.Post();

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
			dsT_CP_YEARLYBONUS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtENO_NO_SHR").value = "";
			document.getElementById("txtENO_NM_SHR").value = "";
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_YEARLYBONUS.IsUpdated)  {

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

        	if (!dsT_CP_YEARLYBONUS.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 1;
			var oPIS_YYMM;

			/*
			oPIS_YYMM = dsT_CP_YEARLYBONUS.NameValue(i,"PIS_YYMM");
			if(oPIS_YYMM.trim().length == 0){
				alert("�������� �߸��Ǿ����ϴ�.");
				dsT_CP_YEARLYBONUS.RowPosition = i;
				return false;
			}
			*/

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//�ֱ� ������ �ش��� ��ȸ
			ds01T_CP_YEARLYBONUS.DataID = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa020.cmd.YMAA020CMD&S_MODE=SHR_01";
			ds01T_CP_YEARLYBONUS.Reset();

			//���� ��� �����¸� �����°� ����
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(PIS_YYMM_SHR.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
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

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){

			form1.medANUO_MM.Enable = "true";
			form1.medANUU_MM.Enable = "true";

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			form1.medANUO_MM.Enable = "false";
			form1.medANUU_MM.Enable = "false";

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
    | 2. �̸� : dsT_CP_YEARLYBONUS                             |
    | 3. Table List : T_CP_YEARLYBONUS                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_YEARLYBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CP_YEARLYBONUS                          |
    | 3. Table List : T_CP_YEARLYBONUS                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_YEARLYBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_CP_YEARLYBONUS                                    |
    | 3. Table List : T_CP_YEARLYBONUS                             |
    +----------------------------------------------->
    <Object ID ="trT_CP_YEARLYBONUS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : tr01T_CP_YEARLYBONUS                                    |
    | 3. Table List : T_CP_YEARLYBONUS                             |
    +----------------------------------------------->
    <Object ID ="tr01T_CP_YEARLYBONUS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_YEARLYBONUS Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_YEARLYBONUS Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = ds01T_CP_YEARLYBONUS.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtPIS_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6);
			document.getElementById("txtPIS_YYMM_SHR").focus();
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_YEARLYBONUS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CP_YEARLYBONUS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_YEARLYBONUS Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�ش���/�ٷα���/����/ȣ��] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�ش���/�ٷα���/����/ȣ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_YEARLYBONUS Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CP_YEARLYBONUS event="OnSuccess()">

   		var iCount1 = dsT_CP_YEARLYBONUS.CountRow;
		if (iCount1 != 0) {
			enableInput();//�Է��ʵ� Ȱ��ȭ
			document.getElementById("txtENO_NM_SHR").value = dsT_CP_YEARLYBONUS.NameValue(iCount1,"ENO_NM");
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount1);
		}else{
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
		}

		document.getElementById("txtENO_NO_SHR").focus();

    </script>

    <script for=tr01T_CP_YEARLYBONUS event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CP_YEARLYBONUS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=tr01T_CP_YEARLYBONUS event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script language=JavaScript for=medANUO_MM event=onKillFocus()>
        var oANUO_MM = document.getElementById("medANUO_MM");
    
        if(Number(oANUO_MM.Text) > 25) {
            alert("�����߻����ڴ� �ִ� 25���Դϴ�.");
            oANUO_MM.Text = "25";
        }
    
		form1.medANUN_MM.Text		=	(Number(form1.medANUO_MM.Text) - Number(form1.medANUU_MM.Text));

		form1.medTUN_DD.Text		=	(Number(form1.medANUN_MM.Text));

		form1.medPAY_AMT.Text		=	Trunc(((Number(form1.medTUN_DD.Text) * Number(form1.medMNOR_WAG.Text) * 8) / 226),0);
	</script>

	<script language=JavaScript for=medANUU_MM event=onKillFocus()>
		form1.medANUN_MM.Text		=	(Number(form1.medANUO_MM.Text) - Number(form1.medANUU_MM.Text));

		form1.medTUN_DD.Text		=	(Number(form1.medANUN_MM.Text));

		form1.medPAY_AMT.Text		=	Trunc(((Number(form1.medTUN_DD.Text) * Number(form1.medMNOR_WAG.Text) * 8) / 226),0);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����������</td>
					<td align="right" class="navigator">HOME/�������/�����������/<font color="#000000">�����������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="50"></col>
								<col width="100"></col>
								<col width="240"></col>
								<col width="100"></col>
								<col width="240"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�ش���</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','135','112');"></a>
								</td>
								<td align="center" class="searchState">�����ȣ</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) cfNumberCheck(); fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�λ�����</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtOCC_CD" size="3" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtOCC_NM" size="11" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtDPT_CD" size="3" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtDPT_NM" size="11" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtJOB_CD" size="3" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtJOB_NM" size="11" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">ȣ&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtHOB_CD" size="3" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtHOB_NM" size="11" class="input_ReadOnly" readOnly>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�Ի���</td>
					<td class="padding2423"><input id="txtHIR_YMD" size="17"  maxlength="10" class="input_ReadOnly" readonly></td>
                    <td align="center" class="creamBold">�����ڵ�</td>
					<td class="padding2423">
                        <input id="txtABA_CD" size="3" style="text-align:center;" class="input_ReadOnly"  readonly>&nbsp;<input id="txtABA_NM" size="11" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">������</td>
					<td class="padding2423"><input id="txtREC_NAM" size="17" maxlength="12" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">�������</td>
					<td class="padding2423"><input id="txtACC_NO" size="17" maxlength="16" class="input_ReadOnly" readonly></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�߻��ϼ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medANUO_MM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=2>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
                            <param name=MoveCaret   value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">����ϼ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medANUU_MM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=2>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">�̻���ϼ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medANUN_MM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=2>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�ϼ��ݾ�</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�ѹ̻����</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medTUN_DD" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=2>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">������ӱ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medMNOR_WAG" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">���ޱݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medPAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
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
<object id="bndT_CP_YEARLYBONUS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_YEARLYBONUS">
	<Param Name="BindInfo", Value='

		<C>Col=OCC_CD     		 	Ctrl=txtOCC_CD     		 	Param=value 		</C>
		<C>Col=OCC_NM     		 	Ctrl=txtOCC_NM    			 	Param=value 		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM    			 	Param=value 		</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM    			 	Param=value 		</C>
		<C>Col=HOB_CD     		 	Ctrl=txtHOB_CD     		 	Param=value 		</C>
		<C>Col=HOB_NM     		 	Ctrl=txtHOB_NM     		 	Param=value 		</C>
		<C>Col=HIR_YMD     		 	Ctrl=txtHIR_YMD     		 	Param=value 		</C>
		<C>Col=ABA_CD     		 	Ctrl=txtABA_CD     			 	Param=value 		</C>
		<C>Col=ABA_NM     		 	Ctrl=txtABA_NM     		 	Param=value 		</C>
		<C>Col=REC_NAM     	 	Ctrl=txtREC_NAM     		 	Param=value 		</C>
		<C>Col=ACC_NO     		 	Ctrl=txtACC_NO     		 	Param=value 		</C>

		<C>Col=ANUO_MM     	 	Ctrl=medANUO_MM     	 	Param=text	 		</C>
		<C>Col=ANUU_MM   		 	Ctrl=medANUU_MM     	 	Param=text	 		</C>
		<C>Col=ANUN_MM    	 	Ctrl=medANUN_MM     	 	Param=text	 		</C>

		<C>Col=TUN_DD     	 		Ctrl=medTUN_DD     	 		Param=text	 		</C>
		<C>Col=MNOR_WAG		 	Ctrl=medMNOR_WAG  	 	Param=text	 		</C>
		<C>Col=PAY_AMT    	 		Ctrl=medPAY_AMT     	 	Param=text	 		</C>
    '>
</object>
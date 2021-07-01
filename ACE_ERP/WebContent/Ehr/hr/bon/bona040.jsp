<!--
    ************************************************************************************
    * @source         : bona040.jsp 				                                                                                     *
    * @description   : �����޻�������Ȳ PAGE.                                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  ������   | �����ۼ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����޻�������Ȳ</title>
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
		var btnList = 'TFFTTTFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // ���۳��
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // ������
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���
			var SORT_SHR = document.getElementById("cmb_SORT_SHR").value; // ���ı���

			//���۳���� ������ ��ȸ����.
			if(STR_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �Է��ϼ���.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}
			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(STR_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(END_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//�������� �߸��Ǿ����� ��ȸ����.
			if(END_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ���۳������ ũ�� �ʵȴ�.
			if(parseInt(END_YYMM_SHR.replaceStr("-","")) < parseInt(STR_YYMM_SHR.replaceStr("-",""))){
					alert("�������� ���۳������ �����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}

            if(SORT_SHR == "1"){//���ν��� ��ȸ ���������� ����
            //Ʈ����� ����
				trT_CP_PAYMASTER.KeyValue = "SVL(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
				trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona040.cmd.BONA040CMD&S_MODE=SHR&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR+
													            "&OCC_CD_SHR="+OCC_CD_SHR+"&SORT_SHR="+SORT_SHR;
				trT_CP_PAYMASTER.Post();
            }else{
	            //�����ͼ� ����
	            dsT_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona040.cmd.BONA040CMD&S_MODE=SHR&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR+
													            "&OCC_CD_SHR="+OCC_CD_SHR+"&SORT_SHR="+SORT_SHR;
	            dsT_CP_PAYMASTER.Reset();
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

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // ���۳��
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // ������
			var OCC_CD_SHR   = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���
			var SORT_SHR     = document.getElementById("cmb_SORT_SHR").value; // ���ı���


			//���۳���� ������ ��ȸ����.
			if(STR_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �Է��ϼ���.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}
			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(STR_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(END_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//�������� �߸��Ǿ����� ��ȸ����.
			if(END_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ���۳������ ũ�� �ʵȴ�.
			if(parseInt(END_YYMM_SHR.replaceStr("-","")) < parseInt(STR_YYMM_SHR.replaceStr("-",""))){
					alert("�������� ���۳������ �����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}

			var url = "bona040_PV.jsp?STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SORT_SHR="+SORT_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("�����޻�������Ȳ", '', 225);

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

			dsT_CP_PAYMASTER.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = ""; // �ٷα��б���
			document.getElementById("cmb_SORT_SHR").value = "1";
			document.form1.txtSTR_YYMM_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_PAYMASTER.IsUpdated)  {

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

        	if (!dsT_CP_PAYMASTER.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
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

			//�ֱ� ������ �ش��� ��ȸ - ���κ��޿����װ��� Ŭ���� ����
			ds01T_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga020.cmd.SAGA020CMD&S_MODE=SHR_01";
			ds01T_CP_PAYMASTER.Reset();

			//���� ��� �����¸� �����°� ����
			var STR_YYMM_SHR = (document.getElementById("txtSTR_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(STR_YYMM_SHR.trim() == ""){
				document.getElementById("txtSTR_YYMM_SHR").value = "";
			}

			var END_YYMM_SHR = (document.getElementById("txtEND_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(END_YYMM_SHR.trim() == ""){
				document.getElementById("txtEND_YYMM_SHR").value = "";
			}

			//�ٷα���
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

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
    | 2. �̸� : dsT_CP_PAYMASTER                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CP_PAYMASTER                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = ds01T_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtSTR_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // ���۳��
			document.getElementById("txtEND_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // ������

			document.getElementById("txtSTR_YYMM_SHR").focus();
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

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">

   		var iCount = dsT_CP_PAYMASTER.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			//alert(dsT_CP_PAYMASTER.ExportData(1, dsT_CP_PAYMASTER.CountRow, true));

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����޻�������Ȳ</td>
					<td align="right" class="navigator">HOME/�������/�󿩰���/<font color="#000000">�����޻�������Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
								<col width="10"></col>
								<col width="80"></col>
								<col width="250"></col>
								<col width="80"></col>
								<col width="140"></col>
								<col width="80"></col>
								<col width="130"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<input id="txtSTR_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YYMM_SHR','','75','112');"></a>
									&nbsp;~&nbsp;
									<input id="txtEND_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YYMM_SHR','','190','112');"></a>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="" >��ü</option>
									</select>
								</td>
								<td align="center" class="searchState">���ı���</td>
								<td>
									<select id="cmb_SORT_SHR" style="width:100" onChange="fnc_SearchList();">
										<option value="1" >��ü</option>
										<option value="2" >�ҼӺ�</option>
	                                    <option value="3" >������</option>
	                                    <option value="4" >����������</option>
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
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=39			name='NO'					align=center			value={String(Currow)}																</C>
								<C> id='PIS_YYMM'			width=80			name='���'				align=center																													</C>
								<C> id='COMM_NM'			width=120			name='����'				align=center				subsumtext='�հ�'																		</C>
								<C> id='ENO_CNT'			width=60			name='�ο�'					align=right																												</C>
								<G>name=�޿�		HeadBgColor=#F7DCBB
									<C> id='PAY_AMT'				width=105			name='�޿�'					align=right																										</C>
									<C> id='OTH_AMT'				width=105			name='��Ÿ'					align=right																										</C>
									<C> id='SUM_AMT'				width=105			name='��'				align=right																												</C>
								</G>
								<G>name=��		HeadBgColor=#F7DCBB
									<C> id='BON_AMT'				width=105			name='�ݾ�'					align=right																										</C>
									<C> id='PAY_PCT'				width=60			name='%'					align=right			Value={Decode(CurLevel,9999,SubAvg(PAY_PCT),PAY_PCT)}		</C>
								</G>
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
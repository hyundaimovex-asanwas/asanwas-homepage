<!--
    ************************************************************************************
    * @source         : guna110.jsp
    * @description   : �Ⱓ��������Ȳ PAGE.
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION
    *-------------+-----------+--------------------------------------------------------+
* 2007/02/23      ���м�        �����ۼ�.
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�Ⱓ��������Ȳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;//��������
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;//��������
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value;  //�ٷα��б���
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;  //�Ҽ�
            var GBN_TAG_SHR = document.getElementById("cmbGBN_TAG").value;     //�ް�����

			//�������ڰ� ������ ��ȸ����.
			if(STR_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(STR_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� ������ ��ȸ����.
			if(END_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(END_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� �������ں��� ũ�� �ʵȴ�.
			if(parseInt(END_YMD_SHR.replaceStr("-","")) < parseInt(STR_YMD_SHR.replaceStr("-",""))){
					alert("�������ڰ� �������ں��� �����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}

			//�Ҽ��� ������
			/*
			if(DPT_CD_SHR.trim().length == 0){
					alert("�Ҽ��� �Է��ϼ���.");
					document.getElementById("txtDPT_CD_SHR").focus();
					return false;
			}*/

            //�����ͼ� ����
            trT_DI_DILIGENCE.KeyValue = "SVL(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE, O:dsT_DI_DILIGENCE_01=dsT_DI_DILIGENCE_01)";
            trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna110.cmd.GUNA110CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&GBN_TAG_SHR="+GBN_TAG_SHR;
            trT_DI_DILIGENCE.post();

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


        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_DI_DILIGENCE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_DILIGENCE.GridToExcel("�Ⱓ��������Ȳ", '', 225);

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

			dsT_DI_DILIGENCE.ClearData();
			dsT_DI_DILIGENCE_01.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.txtSTR_YMD_SHR.value = getToday().substring(0,8)+"01";// ��������(�˻�)
			//document.form1.txtEND_YMD_SHR.value = getToday();                    // ��������(�˻�)
			document.getElementById("cmbOCC_CD_SHR").value = "";
			document.getElementById("txtDPT_CD_SHR").value = "<%= box.get("SESSION_DPTCD")%>";// �Ҽ��ڵ�
			document.getElementById("txtDPT_NM_SHR").value = "<%= box.get("SESSION_DPTNM")%>";// �ҼӸ�
			document.form1.txtSTR_YMD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_DI_DILIGENCE.IsUpdated)  {

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

        	if (!dsT_DI_DILIGENCE.isUpdated ) {
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
			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"false","true");

			//���� �׸���
			cfStyleGrid(form1.grdT_DI_DILIGENCE_01,0,"false","false");      // Grid Style ����
			//form1.grdT_DI_DILIGENCE_01.HiddenHScroll  = true;
			form1.grdT_DI_DILIGENCE_01.HiddenVScroll  = true;
			//form1.grdT_DI_DILIGENCE_01.DisableNoHScroll = false;
			form1.grdT_DI_DILIGENCE_01.DisableNoVScroll = false;
			form1.grdT_DI_DILIGENCE_01.ViewHeader = false;
			//form1.grdT_DI_DILIGENCE_01.Enable = false;
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row�� ���õ� Column�� Color(#F3FED2)
		    form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row���� ���õ� Cell�� ������ ������ ��
		    form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row�� ���õ� Column�� Color(#F3FED2)
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row���� ���õ� Cell�� ������ ������ ��
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='EditCol',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row�� ���õ� Column�� Color
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='EditRow',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row���� ���õ� Cell�� ������ ������ ��
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='CurCol',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row�� ���õ� Column�� Color
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='CurRow',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row���� ���õ� Cell�� ������ ������ ��


			document.form1.txtSTR_YMD_SHR.value = getToday().substring(0,8)+"01";// ��������(�˻�)
			document.form1.txtEND_YMD_SHR.value = getToday();                    // ��������(�˻�)

			//�ٷα���
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")&&
        !box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }
%>

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
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_DILIGENCE                       |
    | 3. Table List : T_DI_DILIGENCE                   |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name=TimeOut           Value=100000>
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_DILIGENCE_01                       |
    | 3. Table List : T_DI_DILIGENCE                   |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name=TimeOut           Value=100000>
    </Object>

    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_DI_DILIGENCE                  |
    | 3. Table List : T_DI_DILIGENCE              |
    +----------------------------------------------->
    <Object ID ="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
        <param Name=TimeOut     Value=1000000>
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_DI_DILIGENCE event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-- ��ũ�� ����ȭ -->
	<script language="JavaScript" for=grdT_DI_DILIGENCE event="OnScrolling(row, col, bymethod)">
		if(!bymethod)
			grdT_DI_DILIGENCE_01.SetScrolling(row, col);
	</script>

	<script language="JavaScript" for= grdT_DI_DILIGENCE_01 event="OnScrolling(row, col, bymethod)">
		if(!bymethod)
			grdT_DI_DILIGENCE.SetScrolling(row, col);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�Ⱓ��������Ȳ</td>
					<td align="right" class="navigator">HOME/���°���/���ϱ��°���/<font color="#000000">�Ⱓ��������Ȳ</font></td>
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
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="70"></col>
								<col width="230"></col>
								<col width="50"></col>
								<col width="70"></col>
								<col width="50"></col>
							    <col width="160"></col>
                                <col width="60"></col>
        					</colgroup>
							<tr>
								<td align="center" class="searchState">�ش�����</td>
								<td>
									<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','108','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
									 ~
									<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','224','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
								</td>
								<td align="center" class="searchState">�ٷα���</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:60">
		                                <option value="">��ü</option>
									</select>
								</td>
								<td align="center" class="searchState">��&nbsp;��</td>
								<td>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
								</td>
                                <td align="center" class="searchState">��&nbsp;��</td>
                                <td>
                                    <select id="cmbGBN_TAG" style="WIDTH:100">
                                        <option value="">��ü</option>
                                        <option value="1" >������ް�</option>
                                        <option value="2" >Refresh�ް�</option>
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
						<object	id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:329px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=29			name='NO'				align=center			value={String(Currow)}		</FC>
								<FC> id='DPT_NM'			width=100			name='�Ҽ�'				align=center			         					</FC>
								<FC> id='JOB_NM'			width=50			name='����'				align=center										</FC>
								<FC> id='ENO_NO'			width=60			name='���'				align=center										</FC>
								<FC> id='ENO_NM'			width=60			name='����'				align=center										</FC>
								<FC> id='MF_TAG'			width=50			name='����'				align=center			Value={Decode(MF_TAG,'M','����','����')}			  </FC>
								<FC> id='YRP_CNT'			width=50			name='�߻�;����'		align=right				Value={Decode(YRP_CNT,'0',' ',YRP_CNT)}	               </FC>
								<C> id='ATT_F'				width=50			name='����'				align=right				Value={Decode(ATT_F,'0',' ',ATT_F)}		               </C>
								<G>name=�ް�		HeadBgColor=#F7DCBB
									<C> id='ATT_Q'			width=50			name='���'				align=right				Value={Decode(ATT_Q,'0',' ',ATT_Q)}		show=false               </C>
									<C> id='ATT_H'			width=50			name='����'				align=right				Value={Decode(ATT_H,'0',' ',ATT_H)}		DECAO=1        </C>
									<C> id='ATT_Z'			width=50			name='Refresh'			align=right				Value={Decode(ATT_Z,'0',' ',ATT_Z)}		show=false               </C>
									<C> id='ATT_I'			width=50			name='Ư��'				align=right				Value={Decode(ATT_I,'0',' ',ATT_I)}		               </C>
								</G>
								<G>name=���		HeadBgColor=#F7DCBB
									<C> id='ATT_A'			width=50			name='����'				align=right				Value={Decode(ATT_A,'0',' ',ATT_A)}		               </C>
									<C> id='ATT_B'			width=50			name='����'				align=right				Value={Decode(ATT_B,'0',' ',ATT_B)}		               </C>
								</G>
								<C> id='ATT_C'				width=50			name='����'				align=right				Value={Decode(ATT_C,'0',' ',ATT_C)}		               </C>
								<C> id='ATT_D'				width=50			name='����'				align=right				Value={Decode(ATT_D,'0',' ',ATT_D)}		               </C>
								<C> id='ATT_E'				width=50			name='����'				align=right				Value={Decode(ATT_E,'0',' ',ATT_E)}		               </C>
								<C> id='ATT_T'				width=50			name='��ü;�ް�'		align=right				Value={Decode(ATT_T,'0',' ',ATT_T)}		DECAO=1        </C>
								<C> id='ATT_L'				width=50			name='��Ÿ'				align=right				Value={Decode(ATT_L,'0',' ',ATT_L)}		               </C>
								<G>name=����		HeadBgColor=#F7DCBB
									<C> id='ATT_C_NU'		width=50			name='����'				align=right				Value={Decode(ATT_C_NU,'0',' ',ATT_C_NU)}	           </C>
									<C> id='ATT_H_NU'		width=50			name='����'				align=right				Value={Decode(ATT_H_NU,'0',' ',ATT_H_NU)}	DECAO=1    </C>
								</G>
								<C> id='NYRP_CNT'			width=50			name='�̻��;����'		align=right				Value={Decode(NYRP_CNT,'0',' ',NYRP_CNT)}	DECAO=1    </C>

							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:43px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE_01">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=29			name='NO'				align=center			</FC>
								<FC> id='DPT_NM'			width=100			name='�Ҽ�'				align=center			Suppress=1					</FC>
								<FC> id='JOB_NM'			width=50			name='����'				align=center										</FC>
								<FC> id='ENO_NO'			width=60			name='���'				align=center										</FC>
								<FC> id='ENO_NM'			width=60			name='����'				align=center										</FC>
								<FC> id='MF_TAG'			width=50			name='����'				align=right											</FC>

								<FC> id='YRP_CNT'			width=50			name='�߻�;����'		align=right											</FC>
								<C> id='ATT_F'				width=50			name='����'				align=right											</C>
								<G>name=�ް�		HeadBgColor=#F7DCBB
									<C> id='ATT_Q'			width=50			name='���'				align=right				show=false							</C>
									<C> id='ATT_H'			width=50			name='����'				align=right				DECAO=1 					</C>
									<C> id='ATT_Z'			width=50			name='Refresh'			align=right				sho=false							</C>
									<C> id='ATT_I'			width=50			name='Ư��'				align=right											</C>
								</G>
								<G>name=���		HeadBgColor=#F7DCBB
									<C> id='ATT_A'			width=50			name='����'				align=right											</C>
									<C> id='ATT_B'			width=50			name='����'				align=right											</C>
								</G>
								<C> id='ATT_C'				width=50			name='����'				align=right											</C>
								<C> id='ATT_D'				width=50			name='����'				align=right											</C>
								<C> id='ATT_E'				width=50			name='����'				align=right											</C>
								<C> id='ATT_T'				width=50			name='��ü;�ް�'		align=right				DECAO=1 					</C>
								<C> id='ATT_L'				width=50			name='��Ÿ'				align=right											</C>
								<G>name=����		HeadBgColor=#F7DCBB
									<C> id='ATT_C_NU'		width=50			name='����'				align=right											</C>
									<C> id='ATT_H_NU'		width=50			name='����'				align=right				DECAO=1 					</C>
								</G>
								<C> id='NYRP_CNT'			width=50			name='�̻��;����'		align=right				DECAO=1 					</C>

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
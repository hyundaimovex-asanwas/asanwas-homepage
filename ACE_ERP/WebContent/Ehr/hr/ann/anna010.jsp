<!--
*****************************************************
* @source      : anna010.jsp
* @description : �����Ļ�/���ο���/���ο��ݰ���
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/06      ����ȣ                   �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ο��ݰ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ann.a.anna010.cmd.ANNA010CMD";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/

        /**
         * ��������� ��ȸ �Ѵ�.
         */
        function fnc_SearchEmp() {
        	//�˻�����
			var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

			dsT_CM_PERSON.dataid = dataClassName+"&S_MODE=SHR_EMP&ENO_NO="+oENO_NO;
			dsT_CM_PERSON.reset();

        }

        /**
         * �˻��� ����� ������ ���� ���� ���� ����Ʈ�� �����´�.
         */
        function fnc_SearchList() {
            //�˻�����
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;
            fncClearInputField();
            changeMode();

            if(oENO_NO != "") {
                dsT_SV_SAVELIST.dataid = dataClassName+"&S_MODE=SHR&ENO_NO="+oENO_NO;
                dsT_SV_SAVELIST.reset();
            } else {
                alert("����� ������ �ּ���");
            }
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

			if(!fnc_SaveItemCheck()) return;

			var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

			trT_SV_SAVELIST.KeyValue = "tr01(I:dsT_SV_SAVELIST=dsT_SV_SAVELIST)";
			trT_SV_SAVELIST.action = dataClassName+"&S_MODE=SAV&ENO_NO="+oENO_NO;
			trT_SV_SAVELIST.post();
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_SV_SAVELIST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("���¹�ȣ [" + dsT_SV_SAVELIST.ColumnString(dsT_SV_SAVELIST.RowPosition,19) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_SV_SAVELIST.DeleteRow(dsT_SV_SAVELIST.RowPosition);

			trT_SV_SAVELIST.KeyValue = "SVL(I:dsT_SV_SAVELIST=dsT_SV_SAVELIST)";
			trT_SV_SAVELIST.Action = dataClassName+"&S_MODE=DEL&ENO_NO="+oENO_NO;
			trT_SV_SAVELIST.post();
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

            if (dsT_SV_SAVELIST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_SV_SAVELIST.GridToExcel("���ο��ݰ���", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
            // �ش� Dataset�� Header�� ������ �˻��� ���� �ʾҴٴ� ������ �����ϰ� ����
            if (dsT_SV_SAVELIST.CountColumn == 0) {
                alert("���ο��ݸ���Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
                return;
            }

            dsT_SV_SAVELIST.AddRow();
            fncClearInputField();
            changeMode("insert");
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
            fncClearInputField();
            changeMode();
			dsT_SV_SAVELIST.ClearData();
			dsT_CM_PERSON.ClearData();
	        fnc_OnLoadProcess();
			document.getElementById("resultMessage").innerText = ' ';
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_SV_SAVELIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_SV_SAVELIST.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var oSelect = document.getElementById("cmbSAV_CD2");
            var oOption = null;

            //ù��° ������ ������ ��� option ����
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }

            // �ٷα��� ���� �˻� �޺��ڽ� ����
            for(i = 1; i <= dsT_CM_COMMON_V2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_V2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_V2.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }

            var elementList = new Array( "txtTOTAL_SAV_SHR"
                                        ,"txtDSC_AMT"
                                        ,"txtWOL_AMT"
                                        ,"txtOTHP_AMT"
                                        ,"txtOTH_AMT"
                                        ,"txtSUM_SAV");

            fnc_DisableElementAll(elementList);

            changeMode("onload");

			cfStyleGrid(form1.grdT_SV_SAVELIST,15,"false","false")      // Grid Style ����
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

            fnc_emplPopup('txtENO_NO_SHR');

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmp();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');
            fnc_SearchEmp();
        }

        /**
         * ��¥ ���� ��ȿ�� üũ
         */
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

        /**
         * ������ �Է� �ʵ��� �ʱ�ȭ
         */
        function fncClearInputField() {
            //�ʱ�ȭ ��ų �Է�â
            var inputFields = new Array( "cmbSAV_CD2"
                                        ,"txtCON_YMD"
                                        ,"txtDUE_YMD"
                                        ,"txtSUM_SAV"
                                        ,"txtSUMP_CNT"
                                        ,"txtFAPP_YMD"
                                        ,"cmbCAN_TAG"
                                        ,"txtCAN_YMD");
            //�ʱ�ȭ ��ų �Է�â �� ���� ���� �ʱ�ȭ�� "0" ����
            var inputAmtFields = new Array("txtCONM_AMT"
                                        ,"txtDSC_PCT"
                                        ,"txtDSC_AMT"
                                        ,"txtWOL_AMT"
                                        ,"txtOTHP_AMT"
                                        ,"txtOTH_AMT"
                                        ,"txtSUM_SAV");

            fnc_ClearInputElement(inputFields);
            fnc_ClearInputElement(inputAmtFields, new Array(), "0");
        }

        /**
         * �Է� ����϶�
         */
        function changeMode(mode) {
            var inputFields = new Array( "cmbSAV_CD2"
                                        ,"txtCON_YMD"
                               //         ,"txtDUE_YMD"
                                        ,"txtCONM_AMT"
                                        ,"txtDSC_PCT"
                                        ,"cmbCAN_TAG"
                                        ,"txtCAN_YMD"
                                        ,"imgCON_YMD"
                                //        ,"imgDUE_YMD"
                                        ,"imgCAN_YMD");

            fnc_EnableElementAll(inputFields);
            if(mode == "insert") {

            } else if(mode == "onload") {
                fnc_DisableElementAll(inputFields);
            } else {
                fnc_DisableElementAll(inputFields, new Array("cmbCAN_TAG" ,"txtCAN_YMD", "imgCAN_YMD"));
            }
            //2010.1.17 �����Ծ�/�ǿ����Ծ��� ����������� ����
            //�������.
            changeCustomMode("use");
        }

        /**
         * �����Ծ�,�ǿ����Ծ�,��Ÿ���Ծ�,��Ÿ������ Ǯ��
         */
        function changeCustomMode(mode) {
            var inputFields = new Array( "txtWOL_AMT"
                                        ,"txtCONM_AMT"
                                        ,"txtDSC_PCT"
                                        ,"txtOTHP_AMT"
                                        ,"txtOTH_AMT" );

            if(mode == "use") {
            	fnc_EnableElementAll(inputFields);
            } else if(mode == "notuse") {
                fnc_DisableElementAll(inputFields);
            }
        }

        /**
         * �������� ���
         */
        function calcDscAmt(conmAmtName, dscAmtName, dscPctName, wolAmtName) {
            var conmAmt = document.getElementById(conmAmtName);
            var dscAmt = document.getElementById(dscAmtName);
            var dscPct = document.getElementById(dscPctName);
            var wolAmt = document.getElementById(wolAmtName);

            var amt = (parseFloat(conmAmt.text)*parseFloat(dscPct.value)/100);

            if(isNaN(amt)) {
                dscAmt.text = 0;
                wolAmt.text = 0;
            } else {
                dscAmt.text = amt;
                wolAmt.text = conmAmt.text - dscAmt.text;
            }

            document.getElementById("txtOTHP_AMT").text = conmAmt.text/2;
        	document.getElementById("txtOTH_AMT").text = document.getElementById("txtWOL_AMT").text;
        }

        function calcDscAmt2(conmAmtName, dscAmtName, dscPctName, wolAmtName) {
            var conmAmt = document.getElementById(conmAmtName);
            var dscAmt = document.getElementById(dscAmtName);
            var dscPct = document.getElementById(dscPctName);
            var wolAmt = document.getElementById(wolAmtName);

            var rate = Math.round(((parseFloat(conmAmt.text)-parseFloat(wolAmt.text))/parseFloat(conmAmt.text))*100 * Math.pow(10,1)) / Math.pow(10,1);
            if(isNaN(rate)) {
                dscAmt.text = 0;
                dscPct.value = 0;
            } else {
                dscAmt.text = conmAmt.text -wolAmt.text;
                dscPct.value = rate;
            }

            document.getElementById("txtOTHP_AMT").text = conmAmt.text/2;
        	document.getElementById("txtOTH_AMT").text = document.getElementById("txtWOL_AMT").text;

        }
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_SV_SAVELIST                       |
    | 3. Table List : T_SV_SAVELIST                 |
    +----------------------------------------------->
    <Object ID="dsT_SV_SAVELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			                  |
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_SV_SAVELIST)		  |
    | 3. ���Ǵ� Table List(T_SV_SAVELIST)	                  |
    +--------------------------------------------------->
    <Object ID ="trT_SV_SAVELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet                               |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_V2"/>
       <jsp:param name="CODE_GUBUN"    value="V2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_SV_SAVELIST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_SV_SAVELIST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_SV_SAVELIST event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-- ����Ÿ �׸��带 ���� Ŭ���Ҷ� -->
    <script for=grdT_SV_SAVELIST event=OnDblClick(Row,Colid)>
		if(Row < 1) {
			return;
		} else {
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;
            var oACC_NO = dsT_SV_SAVELIST.NameValue(Row, "ACC_NO");
            var oSAV_CD = dsT_SV_SAVELIST.NameValue(Row, "SAV_CD2");
            var oBNK_CD = dsT_SV_SAVELIST.NameValue(Row, "BNK_CD");

			window.showModalDialog("/hr/ann/anna011.jsp?ENO_NO="+oENO_NO+"&ACC_NO="+oACC_NO+"&SAV_CD="+oSAV_CD+"&BNK_CD="+oBNK_CD, "", "dialogWidth:670px; dialogHeight:530px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		}
    </script>

    <!-- ����Ÿ �׸��带 �ѹ� �����Ҷ� -->


    <!-- �����Ծ׿��� Ŀ���� ���ư� �� ��� �� -->
    <script language=JavaScript for=txtCONM_AMT event=onKillFocus()>
        calcDscAmt('txtCONM_AMT', 'txtDSC_AMT', 'txtDSC_PCT', 'txtWOL_AMT');
    </script>

    <!-- �ǿ����Ծ׿��� Ŀ���� ���ư� �� ��� �� -->
    <script language=JavaScript for=txtWOL_AMT event=onKillFocus()>
        calcDscAmt2('txtCONM_AMT', 'txtDSC_AMT', 'txtDSC_PCT', 'txtWOL_AMT');
    </script>


    <!-- ������ ����ִ��� ���θ� ������ -->
    <script for=dsT_SV_SAVELIST event=CanRowPosChange(row)>
        var element;

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "SAV_CD2");
        if(element.trim().length == 0 || element == "0"){
            alert("���������� �Է��ϼ���.");
            document.getElementById("cmbSAV_CD2").focus();
            return false;
        }

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "CON_YMD");
        if(element.trim().length == 0){
            alert("������ڸ� �Է��ϼ���.");
            document.getElementById("txtCON_YMD").focus();
            return false;
        }
        if(element.trim().length != 10){
            alert("������ڰ� �߸��Ǿ����ϴ�.");
            document.getElementById("txtCON_YMD").focus();
            return false;
        }

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "DUE_YMD");
        if(element.trim().length == 0){
            alert("�������ڸ� �Է��ϼ���.");
            document.getElementById("txtDUE_YMD").focus();
            return false;
        }
        if(element.trim().length != 10){
            alert("�������ڰ� �߸��Ǿ����ϴ�.");
            document.getElementById("txtDUE_YMD").focus();
            return false;
        }

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "CONM_AMT");
        if(element.trim().length == 0 || element == "0"){
            alert("�����Ծ��� �����ϼ���.");
            document.getElementById("txtCONM_AMT").Focus();
            return false;
        }

    </script>

    <!-- disable ��ų������ ���� ���� -->
    <script language=JavaScript for=dsT_SV_SAVELIST event=OnRowPosChanged(row)>
        if(row > 0) {
            //�Է¸��� �Է»��·�
            if(dsT_SV_SAVELIST.RowStatus(row) == "1") {
                changeMode("insert");
            } else {
                changeMode();
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ο��ݰ���</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ο���/<font color="#000000">���ο��ݰ���</font></td>
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
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�����ȣ</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmp()" onfocusout="fnc_SearchEmp()">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423">
                                    <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�ֹε�Ϲ�ȣ</td>
                                <td class="padding2423">
                                    <input id="txtCET_NO_SHR" name="txtCET_NO_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�Ի���</td>
                                <td class="padding2423">
                                    <input id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�Ѻ��Դ���</td>
                                <td class="padding2423">
                                    <comment id="__NSID__"><object id="txtTOTAL_SAV_SHR" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                        <param name=Alignment               value=2>
                                        <param name=Border                  value=true>
                                        <param name=ClipMode                value=true>
                                        <param name=DisabledBackColor       value="#EEEEEE">
                                        <param name=Enable                  value=true>
                                        <param name=IsComma                 value=true>
                                        <param name=Language                value=0>
                                        <param name=MaxLength               value=8>
                                        <param name=Numeric                 value=true>
                                        <param name=NumericRange            value=0~+:0>
                                        <param name=ShowLiteral             value=false>
                                        <param name=Visible                 value=true>
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
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

<!-- ������ -->
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="creamBold" align="center" rowspan="3">������</td>
                    <td class="creamBold" align="center">��� ����</td>
                    <td class="padding2423">
                        <select id="cmbSAV_CD2" name="cmbSAV_CD2" style="width:130;">
                            <option value="0">���</option>
                        </select>
                    </td>
                    <td class="creamBold" align="center">�� �� ��</td>
                    <td class="padding2423">
                        <input type="text" id="txtCON_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgCON_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCON_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCON_YMD','','360','200');" style="cursor:hand;">
                    </td>
                    <td class="creamBold" align="center">�� �� ��</td>
                    <td class="padding2423">
                        <input type="text" id="txtDUE_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgDUE_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDUE_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUE_YMD','','610','200');" style="cursor:hand;">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">�����Ծ�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtCONM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtDSC_PCT" name="txtDSC_PCT" size="8" style="text-align:right" value="0" maxlength="4" style="ime-mode:disabled"  onkeypress="cfCheckNumber3();">
                        %
                        <a href="#" onclick="javascript:calcDscAmt('txtCONM_AMT', 'txtDSC_AMT', 'txtDSC_PCT', 'txtWOL_AMT');">���</a>
                    </td>
                    <td class="creamBold" align="center">�� �� ��</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtDSC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">�ǿ����Ծ�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtWOL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">��Ÿ���Ծ�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtOTHP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">��Ÿ������</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtOTH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
<!-- ������ -->

<!-- �������� -->
                <tr>
                    <td class="creamBold" align="center">��������</td>
                    <td class="creamBold" align="center">�������Ծ�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtSUM_SAV" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">����Ƚ��</td>
                    <td class="padding2423">
                        <input id="txtSUMP_CNT" name="txtSUMP_CNT" size="14" style="text-align:right" value="0" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">����������</td>
                    <td class="padding2423">
                        <input id="txtFAPP_YMD" name="txtFAPP_YMD" size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
<!-- �������� -->

<!-- �ؾ���� -->
                <tr>
                    <td class="creamBold" align="center">�ؾ����</td>
                    <td class="creamBold" align="center">�ؾ࿩��</td>
                    <td class="padding2423">
                        <select id="cmbCAN_TAG" name="cmbCAN_TAG" style="width:50">
                            <option></option>
                            <option value="Y">����</option>
                            <option value="C">�ߵ�</option>
                        </select>
                    </td>
                    <td class="creamBold" align="center">�� �� ��</td>
                    <td class="padding2423" colspan="3">
                        <input type="text" id="txtCAN_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgCAN_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCAN_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCAN_YMD','','360','300');" style="cursor:hand;">
                    </td>
                </tr>
            </table>
<!-- �ؾ���� -->

        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="520" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SV_SAVELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
							<param name="DataID"				value="dsT_SV_SAVELIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id='{currow}'       width=39    name='NO'           align=center    Edit=none   SubBgColor='#99FFCC'</C>
                                <C> id=SAV_NM2      width=130       align=center        name=��������       </C>
                                <C> id=PYM_AMT      width=80        align=center        name=���������       </C>
                                <C> id=CON_YMD      width=80        align=center        name=�����            </C>
                                <C> id=DUE_YMD      width=80        align=center        name=������            </C>
                                <C> id=CONM_AMT     width=80        align=center        name=�������Ծ�   </C>
                                <C> id=DSC_PCT      width=80        align=center        name=������            </C>
                                <C> id=DSC_AMT      width=80        align=center        name=���ξ�            </C>
                                <C> id=WOL_AMT      width=80        align=center        name=���������Ծ�   </C>
                                <C> id=OTHP_AMT     width=80        align=center        name=��Ÿ���ұݾ�   </C>
                                <C> id=OTH_AMT      width=80        align=center        name=��Ÿ�����ݾ�   </C>
                                <C> id=SUM_SAV      width=80        align=center        name=���������      </C>
                                <C> id=SUMP_CNT     width=80        align=center        name=��������Ƚ��   </C>
                                <C> id=FAPP_YMD     width=80        align=center        name=����������     </C>
                                <C> id=CAN_TAG      width=80        align=center        name=�ؾ౸��        value={Decode(CAN_TAG,'Y','����','C','�ߵ�')}</C>
                                <C> id=CAN_YMD      width=80        align=center        name=�ؾ���            </C>
                                <C> id=ACC_NO       width=100       align=center        name=���¹�ȣ     Show=false      </C>
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
<!-- T_CM_PERSON ��ȸ�ؿ� ��� ������ â�� �ѷ��� -->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
        <C>Col=ENO_NO               Ctrl=txtENO_NO_SHR              Param=value     </C>
        <C>Col=ENO_NM               Ctrl=txtENO_NM_SHR              Param=value     </C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM_SHR 		     	Param=value     </C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM_SHR	   		   	Param=value		</C>
		<C>Col=CET_NO				Ctrl=txtCET_NO_SHR				Param=value		</C>
		<C>Col=HIRG_YMD			    Ctrl=txtHIRG_YMD_SHR			Param=value		</C>
		<C>Col=OCC_NM				Ctrl=txtOCC_NM_SHR			    Param=value	    </C>
		<C>Col=TOTAL_SAV			Ctrl=txtTOTAL_SAV_SHR			Param=Text 		</C>
    '>
</object>


<!-- T_SV_SAVELIST ���ο��ݰ����� ���ε��� ���� -->
<object id="bndT_SV_SAVELIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_SV_SAVELIST">
    <Param Name="BindInfo", Value='
        <C>Col=SAV_CD2              Ctrl=cmbSAV_CD2               Param=value   </C>
        <C>Col=CON_YMD              Ctrl=txtCON_YMD               Param=value   </C>
        <C>Col=DUE_YMD              Ctrl=txtDUE_YMD               Param=value   </C>
        <C>Col=CONM_AMT             Ctrl=txtCONM_AMT              Param=text     </C>
        <C>Col=DSC_PCT              Ctrl=txtDSC_PCT               Param=value   DEC=1</C>
        <C>Col=DSC_AMT              Ctrl=txtDSC_AMT               Param=text    </C>
        <C>Col=WOL_AMT              Ctrl=txtWOL_AMT               Param=text    </C>
        <C>Col=OTHP_AMT             Ctrl=txtOTHP_AMT              Param=text    </C>
        <C>Col=OTH_AMT              Ctrl=txtOTH_AMT               Param=text    </C>
        <C>Col=SUM_SAV              Ctrl=txtSUM_SAV               Param=text    </C>
        <C>Col=SUMP_CNT             Ctrl=txtSUMP_CNT              Param=value   </C>
        <C>Col=FAPP_YMD             Ctrl=txtFAPP_YMD              Param=value   </C>
        <C>Col=CAN_TAG              Ctrl=cmbCAN_TAG               Param=value   </C>
        <C>Col=CAN_YMD              Ctrl=txtCAN_YMD               Param=value   </C>
    '>
</object>

<!--
    ************************************************************************************
    * @Source         : stoa010.jsp 					                               *
    * @Description    :  ���ֵ��.                                                     *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/27  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>������Ȳ</title>
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
		var btnList = 'TFTTFTTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var BASIC_YMD = document.getElementById("txtBASIC_YMD_SHR").value;
            var EMP_GBN_SHR = document.getElementById("cmbEMP_GBN_SHR").value;

            dsT_SH_STOCKHOLDER.UseChangeInfo = true;    //false ������ �Է�

            //�����ͼ� ����
            dsT_SH_STOCKHOLDER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=SHR&BASIC_YMD_SHR="+BASIC_YMD+"&EMP_GBN_SHR="+EMP_GBN_SHR;
            dsT_SH_STOCKHOLDER.Reset();
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
			trT_SH_STOCKHOLDER.KeyValue = "SVL(I:SAV=dsT_SH_STOCKHOLDER, O:dsRESULT=dsRESULT)";
			trT_SH_STOCKHOLDER.Action = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=SAV";
			trT_SH_STOCKHOLDER.Post();

        }

		/******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_SH_STOCKHOLDER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_SH_STOCKHOLDER.ColumnString(dsT_SH_STOCKHOLDER.RowPosition,3) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_SH_STOCKHOLDER.DeleteRow(dsT_SH_STOCKHOLDER.RowPosition);
			trT_SH_STOCKHOLDER.KeyValue = "SVL(I:SAV=dsT_SH_STOCKHOLDER)";
			trT_SH_STOCKHOLDER.Action = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=DEL";
			trT_SH_STOCKHOLDER.post();

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

			var BASIC_YMD_SHR = document.getElementById("txtBASIC_YMD_SHR").value; // ��ȸ������
			var cmbEMP_GBN_SHR = document.getElementById("cmbEMP_GBN_SHR").value; // �������


		    var url = "stoa010_PV.jsp?BASIC_YMD_SHR="+BASIC_YMD_SHR+"&cmbEMP_GBN_SHR="+cmbEMP_GBN_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {
            if (dsT_SH_STOCKHOLDER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_SH_STOCKHOLDER.GridToExcel("������Ȳ", '', 225);

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			// �ش� Dataset�� Header�� ������ Header ����
            if (dsT_SH_STOCKHOLDER.CountColumn == 0) {
                dsT_SH_STOCKHOLDER.setDataHeader("BASIC_YMD:STRING:KEYVALUETYPE,SH_NO:STRING:KEYVALUETYPE,SEQ_NO:STRING:KEYVALUETYPE,ENO_NM:STRING,EMP_GBN:STRING,HIR_YMD:STRING,RET_YMD:STRING,COM_STK:DECIMAL,PRE_STK:DECIMAL,NEW_STK1:DECIMAL,NEW_STK2:DECIMAL,POST_NO:STRING,ADDRESS:STRING");
            }

            dsT_SH_STOCKHOLDER.AddRow();
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

			dsT_SH_STOCKHOLDER.ClearData();
            document.getElementById("cmbEMP_GBN_SHR").selectedIndex = 0;
			document.getElementById("resultMessage").innerText = ' ';


        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_SH_STOCKHOLDER.IsUpdated)  {

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
        	if (!dsT_SH_STOCKHOLDER.isUpdated && dsT_SH_STOCKHOLDER.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 0;
			var oBASIC_YMD, oSH_NO, oENO_NM;
			var RowCnt = dsT_SH_STOCKHOLDER.CountRow;

			for(i=1; i<=RowCnt; i++){

				oBASIC_YMD = dsT_SH_STOCKHOLDER.NameValue(i,"BASIC_YMD");
				if(oBASIC_YMD.trim().length == 0){
					alert("�������� �߸��Ǿ����ϴ�.");
					dsT_SH_STOCKHOLDER.RowPosition = i;
					return false;
				}

				oSH_NO = dsT_SH_STOCKHOLDER.NameValue(i,"SH_NO");
				if(oSH_NO.trim().length == 0){
					alert("���ֹ�ȣ�� �߸��Ǿ����ϴ�.");
					dsT_SH_STOCKHOLDER.RowPosition = i;
					return false;
				}

				oENO_NM = dsT_SH_STOCKHOLDER.NameValue(i,"ENO_NM");
				if(oENO_NM.trim().length == 0){
					alert("���ָ��� �߸��Ǿ����ϴ�.");
					dsT_SH_STOCKHOLDER.RowPosition = i;
					return false;
				}

			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
            cfStyleGrid(form1.grdT_SH_STOCKHOLDER,15,"false","false");

            document.getElementById("txtBASIC_YMD_SHR").value = getTodayArray()[0];
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17. �������� ���ε� ó��  *
         ****************************/
         function fnc_FileUpload() {

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsFILE_UPLOAD.CountColumn < 1) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_SH_STOCKHOLDER=dsT_SH_STOCKHOLDER)";
                trFILE_UPLOAD.action   = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=SHR_02";
                trFILE_UPLOAD.post();

            }

            dsT_SH_STOCKHOLDER.UseChangeInfo = false;    //false ������ �Է�
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
    | 2. �̸� : dsT_SH_STOCKHOLDER                             |
    | 3. Table List : T_SH_STOCKHOLDER                         |
    +----------------------------------------------->
    <Object ID="dsT_SH_STOCKHOLDER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_SH_STOCKHOLDER                          |
    | 3. Table List : T_SH_STOCKHOLDER                         |
    +----------------------------------------------->
    <Object ID="ds01T_SH_STOCKHOLDER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>


    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!----------------------------------------------+
    | 1. �ڷ� ���ε�� Data Transacton              |
    | 2. �̸� : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_SH_STOCKHOLDER                                |
    | 3. Table List : T_SH_STOCKHOLDER                         |
    +----------------------------------------------->
    <Object ID ="trT_SH_STOCKHOLDER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_SH_STOCKHOLDER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_SH_STOCKHOLDER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oBASIC_YMD = ds01T_SH_STOCKHOLDER.NameValue(1,"BASIC_YMD").trim();
			document.getElementById("txtBASIC_YMD_SHR").value = oBASIC_YMD.substring(0,4)+"-"+oBASIC_YMD.substring(4,6)+"-"+oBASIC_YMD.substring(6,8);
        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_SH_STOCKHOLDER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_SH_STOCKHOLDER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_SH_STOCKHOLDER Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[������/���ֹ�ȣ/���ָ�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("������/���ֹ�ȣ/���ָ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_SH_STOCKHOLDER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_SH_STOCKHOLDER event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_SH_STOCKHOLDER event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������Ȳ</td>
					<td align="right" class="navigator">HOME/��������/���ְ���/<font color="#000000">������Ȳ</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
											<col width="10"></col>
											<col width="80"></col>
											<col width="100"></col>
											<col width="80"></col>
											<col width="150"></col>
											<col width="*"></col>
										</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">���س⵵</td>
								<td>
                                    <input type="text" id="txtBASIC_YMD_SHR" name="txtBASIC_YMD_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn1" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtBASIC_YMD_SHR','','340','108');"></a>
								</td>
								<td align="center" class="searchState">�������</td>
								<td>
	                                <select id="cmbEMP_GBN_SHR" style="width:70%">
										<option value="" >��ü</option>
										<option value="1" >������</option>
	                                    <option value="2" >����</option>
	                                    <option value="3" >���</option>
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
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td class="searchState" align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" width="80" height="20" border="0" align="absmiddle" onclick="cfDownload('stoa010.xls', '<%=FILEURL %>/stoa010.xls');"></a>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SH_STOCKHOLDER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_SH_STOCKHOLDER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
								<C> id='{CUROW}'		width=47		name='NO'				align=center		BgColor='#EEEEEE'		value={String(Currow)}	</C>
								<C> id='BASIC_YMD'		width=70		name='������'			align=center												</C>
								<C> id='SH_NO'			width=110		name='���ֹ�ȣ' 		align=center												</C>
								<C> id='ENO_NM'			width=150		name='���ָ�'			align=center												</C>
								<C> id='EMP_GBN'		width=70		name='�������'	    	align=center		BgColor='#EEEEEE' 			</C>
								<C> id='HIR_YMD'		width=70		name='�Ի���'			align=center		BgColor='#EEEEEE' 			</C>
								<C> id='RET_YMD'		width=70		name='�����'			align=center		BgColor='#EEEEEE' 			</C>
								<C> id='COM_STK'		width=88		name='������'			align=right			RightMargin='10'					</C>
								<C> id='PRE_STK'		width=88		name='�켱��'			align=right			RightMargin='10'					</C>
								<C> id='NEW_STK1'		width=88		name='����1'			align=right			RightMargin='10'					</C>
								<C> id='NEW_STK2'		width=88		name='����2'			align=right			RightMargin='10'					</C>
								<C> id='POST_NO'		width=70		name='�����ȣ'		    align=center												</C>
								<C> id='ADDRESS'		width=350		name='�ּ�'				align=left													</C>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>
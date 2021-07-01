<!--
*****************************************************
* @source       : aida060.jsp
* @description : ����ȸ�����ޱ��ذ��� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/06      ������        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����ȸ���������ǥ</title>
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

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����
			var basic_ymd = document.form1.txtBASIC_YMD_SHR.value;		//������

			if(basic_ymd.trim().length != 0 && basic_ymd.trim().length != 10){
				alert("�������� �ùٸ��� �ʽ��ϴ�.");
				document.getElementById("txtBASIC_YMD_SHR").focus();
				return false;
			}

			dsT_AD_HELP_BASIS.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida060.cmd.AIDA060CMD&S_MODE=SHR&BASIC_YMD="+basic_ymd;
			dsT_AD_HELP_BASIS.reset();

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

			trT_AD_HELP_BASIS.KeyValue = "tr01(I:dsT_AD_HELP_BASIS=dsT_AD_HELP_BASIS)";
			trT_AD_HELP_BASIS.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida060.cmd.AIDA060CMD&S_MODE=SAV";
			trT_AD_HELP_BASIS.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_AD_HELP_BASIS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_AD_HELP_BASIS.ColumnString(dsT_AD_HELP_BASIS.RowPosition,3) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_AD_HELP_BASIS.DeleteRow(dsT_AD_HELP_BASIS.RowPosition);

			trT_AD_HELP_BASIS.KeyValue = "SVL(I:dsT_AD_HELP_BASIS=dsT_AD_HELP_BASIS)";
			trT_AD_HELP_BASIS.Action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida060.cmd.AIDA060CMD&S_MODE=DEL";
			trT_AD_HELP_BASIS.post();

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
            if (dsT_AD_HELP_BASIS.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AD_HELP_BASIS.GridToExcel("����ȸ���������ǥ", '', 225);
        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsT_AD_HELP_BASIS.CountColumn == 0) {
                dsT_AD_HELP_BASIS.setDataHeader("BASIC_YMD:STRING:KEYVALUETYPE, OCC_CD:STRING:KEYVALUETYPE, JOB_CD:STRING:KEYVALUETYPE, JOB_NM:STRING:KEYVALUETYPE, DHLP_AMT:DECIMAL");
            }

            dsT_AD_HELP_BASIS.AddRow();
            document.form1.txtBASIC_YMD.focus();

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

	        fnc_OnLoadProcess();
			dsT_AD_HELP_BASIS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtBASIC_YMD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_AD_HELP_BASIS.IsUpdated)  {

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

			if (!dsT_AD_HELP_BASIS.IsUpdated) {
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

            //�ֱ� ������ ������ ��ȸ
            ds01T_AD_HELP_BASIS.DataID = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida060.cmd.AIDA060CMD&S_MODE=SHR_01";
            ds01T_AD_HELP_BASIS.Reset();

            var basic_ymd = (document.getElementById("txtBASIC_YMD_SHR").value).replace(/-/g, "");
            if(basic_ymd.trim() == ""){
	            document.getElementById("txtBASIC_YMD_SHR").value = "";
            }

            cfStyleGrid(form1.grdT_AD_HELP_BASIS,15,"false","false")      // Grid Style ����


            fnc_ConstructCommonCode("dsT_CM_COMMON_A1", "cmbOCC_CD");
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD");

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        var elementList = new Array(     "txtBASIC_YMD"
                                        ,"imgBASIC_YMD_SHR"
                                        ,"cmbOCC_CD"
                                        ,"cmbJOB_CD"
                                        ,"medDHLP_AMT" );

        var exceptionList = new Array(   "txtBASIC_YMD"
                                        ,"imgBASIC_YMD_SHR"
                                        ,"cmbOCC_CD"
                                        ,"cmbJOB_CD");

        var keyList = new Array(         "txtBASIC_YMD"
                                        ,"cmbOCC_CD"
                                        ,"cmbJOB_CD");

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_AD_HELP_BASIS                      |
    | 3. Table List : T_AD_HELP_BASIS                  |
    +----------------------------------------------->
    <Object ID="dsT_AD_HELP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_AD_HELP_BASIS                          |
    | 3. Table List : T_AD_HELP_BASIS                         |
    +----------------------------------------------->
    <Object ID="ds01T_AD_HELP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_AD_HELP_BASIS)		|
    | 3. ���Ǵ� Table List(T_AD_HELP_BASIS)	            |
    +--------------------------------------------------->
    <Object ID ="trT_AD_HELP_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
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
    <Script For=dsT_AD_HELP_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtBASIC_YMD_SHR.focus();
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <Script For=ds01T_AD_HELP_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount == 0) {
        } else {
			var oBASIC_YMD = ds01T_AD_HELP_BASIS.NameValue(1,"BASIC_YMD").trim();
			document.getElementById("txtBASIC_YMD_SHR").value = oBASIC_YMD.substring(0,4)+"-"+oBASIC_YMD.substring(4,6)+"-"+oBASIC_YMD.substring(6,8);
			document.getElementById("txtBASIC_YMD_SHR").focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_AD_HELP_BASIS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=ds01T_AD_HELP_BASIS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_AD_HELP_BASIS Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[������/����/����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("������/����/������ ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <Script For=ds01T_AD_HELP_BASIS Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_AD_HELP_BASIS event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_AD_HELP_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AD_HELP_BASIS event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //�ű��� ���
            if(dsT_AD_HELP_BASIS.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_AD_HELP_BASIS event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_AD_HELP_BASIS.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_AD_HELP_BASIS.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ȸ���������ǥ</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�������/<font color="#000000">����ȸ���������ǥ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">������</td>
                                <td class="padding2423">
									<input id="txtBASIC_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBASIC_YMD_SHR','','70','106');"></a>
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
					<col width="130"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<input type="text" id="txtBASIC_YMD"  style="ime-mode:disabled" style="width:75%" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtBASIC_YMD','','75','150');"></a>
					</td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
						<select id="cmbOCC_CD" style="WIDTH:100%"></select>
					</td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
						<select id="cmbJOB_CD" style="WIDTH:100%"></select>
					</td>
					<td align="center" class="creamBold">����ȸ��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medDHLP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_AD_HELP_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_AD_HELP_BASIS">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=80			name='����'						align=center			value={String(Currow)}	</C>
								<C> id='BASIC_YMD'		width=172			name='������'					align=center													</C>
								<C> id='OCC_CD'			width=170			name='����'						align=center			value={DECODE(OCC_CD,'A','�繫��','M','�ù���')}	</C>
								<C> id='JOB_CD'			width=170			name='����'						align=center			EditStyle=Lookup Data='dsT_CM_COMMON_A2:CODE:CODE_NAME' </C>
								<C> id='DHLP_AMT'		width=170			name='����ȸ��'				align=right                   RightMargin='15'        	</C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_AD_HELP_BASIS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_AD_HELP_BASIS">
	<Param Name="BindInfo", Value='
		<C>Col=BASIC_YMD      	Ctrl=txtBASIC_YMD      	Param=value 		</C>
		<C>Col=OCC_CD			Ctrl=cmbOCC_CD	   		Param=value		</C>
		<C>Col=JOB_CD   		Ctrl=cmbJOB_CD   	 	Param=value		</C>
		<C>Col=DHLP_AMT			Ctrl=medDHLP_AMT 	 	Param=text			</C>
    '>
</object>
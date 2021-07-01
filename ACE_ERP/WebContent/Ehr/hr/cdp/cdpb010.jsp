<!--
    ************************************************************************************
    * @Source              : cdpb010.jsp                                               *
    * @Description        : ��å������ڵ���                                         *
    * @Font                   :                                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/01  |  ������   | �����ۼ�                                               *
    * 2006/09/29  |  ������   | ���߿Ϸ�                                               *
    * 2006/11/06  |  ������   | ��ȿ��ó�� �߰�                                        *
    * 2007/03/20  |  ���м�   | �����ڵ����� ��å������ڵ������� ��ȯ             *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��å������ڵ���</title>
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

		var btnList = 'FTTTFFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

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
			if(fnc_SaveItemCheck()) {
				tr01T_CD_RESPCODE.KeyValue = "SVL(I:ds01T_CD_RESPCODE=ds01T_CD_RESPCODE)";
				tr01T_CD_RESPCODE.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SAV_01";
				tr01T_CD_RESPCODE.post();
	            dsT_CD_RESPCODE.Reset();//Ʈ���� �籸���Ѵ�.
			} else {
				return;
			}
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (ds01T_CD_RESPCODE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			//������å�� ������ ���� �ʵȴ�
			var oDOWNRESP_CD = ds01T_CD_RESPCODE.NameValue(ds01T_CD_RESPCODE.RowPosition,"DOWNRESP_CD");
			//alert("row:"+ds01T_CD_RESPCODE.RowPosition+", down:"+oDOWNRESP_CD);
			if(oDOWNRESP_CD == "2"){
				alert("������å�� �����մϴ�.");
				return false;
			}

			// ������� ������ ������ �� ����.
			var oEND_YMD = ds01T_CD_RESPCODE.NameValue(ds01T_CD_RESPCODE.RowPosition,"END_YMD");
			if(oEND_YMD != "") {
				alert("������� �����ϸ� ������ �� �����ϴ�.");
				return false;
			}

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + ds01T_CD_RESPCODE.ColumnString(ds01T_CD_RESPCODE.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            ds01T_CD_RESPCODE.DeleteRow(ds01T_CD_RESPCODE.RowPosition);
			tr01T_CD_RESPCODE.KeyValue = "SVL(I:ds01T_CD_RESPCODE=ds01T_CD_RESPCODE)";
			tr01T_CD_RESPCODE.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=DEL_01";
			tr01T_CD_RESPCODE.post();
            dsT_CD_RESPCODE.Reset();//Ʈ���� �籸���Ѵ�.

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

            if(document.tvT_CD_RESPCODE.ItemText.trim() == ""){
            	alert("Ʈ�� �������� ���� �������ּ���.");
	            return false;
            }

			//AddNew
            ds01T_CD_RESPCODE.AddRow();

            fnc_ColEnabled('E');

            //���� ���õ� Ʈ���� ������ �����´�.
			var overNm = document.tvT_CD_RESPCODE.ItemText;
			var Row = dsT_CD_RESPCODE.NameValueRow("RESP_NM",overNm);
			var oUPRESP_CD = dsT_CD_RESPCODE.NameValue(Row,"RESP_CD");
			var oUPRESP_NM = dsT_CD_RESPCODE.NameValue(Row,"RESP_NM");

			var oRESP_LBL=	dsT_CD_RESPCODE.NameValue(Row,"RESP_LBL");
			var oCOUNT_REM=dsT_CD_RESPCODE.NameValue(Row,"COUNT_REM");
			var dsCnt = ds01T_CD_RESPCODE.CountRow

			//����Ʈ���� �ϱ����� ������ �ø���.
			oRESP_LBL = parseInt(oRESP_LBL)+1;
			//����Ʈ���� ������ seq�� ����Ͽ� �ڿ� ���δ�.
			oCOUNT_REM = oCOUNT_REM+lpad(parseInt(dsCnt)-1, 3, "0");
			//alert("oRESP_LBL:"+oRESP_LBL+", oCOUNT_REM:"+oCOUNT_REM);

            document.getElementById("txtUPRESP_CD").value = oUPRESP_CD;
            document.getElementById("txtUPRESP_NM").value = oUPRESP_NM;
            document.getElementById("txtRESP_LBL").value = oRESP_LBL;
            document.getElementById("txtCOUNT_REM").value = oCOUNT_REM;

			//�������� �����´�.
            document.getElementById("txtSTR_YMD").value = getToday();

			//�Է� ���̺�� ��Ŀ��
			document.getElementById("txtRESP_CD").focus();
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
			dsT_CD_RESPCODE.ClearData();
			ds01T_CD_RESPCODE.ClearData();
			dsT_CD_RESPCODE.Reset();

		//	fnc_ColEnabled('D');
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (ds01T_CD_RESPCODE.IsUpdated)  {
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
   			var f = document.form1;

			//DataSet�� ���� ���� Ȯ��
			if (!ds01T_CD_RESPCODE.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oRESP_CD, oRESP_NM, oSTR_YMD, oEND_YMD;
			var RowCnt = ds01T_CD_RESPCODE.CountRow;
			for(i=1; i<=RowCnt; i++){

				oRESP_CD = ds01T_CD_RESPCODE.NameValue(i,"RESP_CD");
				if(oRESP_CD.trim().length != 6){
					alert(i+"��°�� ��å�ڵ�� �ݵ�� 6�ڸ����� �մϴ�.");
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtRESP_CD").focus();
					return false;
				}

				oRESP_NM = ds01T_CD_RESPCODE.NameValue(i,"RESP_NM");
				if(oRESP_NM.trim() == ""){
					alert(i+"��°�� ��å���� �߸��Ǿ����ϴ�." );
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtRESP_NM").focus();
					return false;
				}

				oSTR_YMD = ds01T_CD_RESPCODE.NameValue(i,"STR_YMD");
				if(!cfDateExpr(oSTR_YMD) || oSTR_YMD.trim().length == 0){//������� �ݵ�� �����Ѵ�.
					alert(i+"��°�� �������  �߸��Ǿ����ϴ�." );
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtSTR_YMD").focus();
					return false;
				}

				oEND_YMD = ds01T_CD_RESPCODE.NameValue(i,"END_YMD");
				if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){//������� �ȵ��� �ȴ�.
					alert(i+"��°�� �������  �߸��Ǿ����ϴ�." );
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtEND_YMD").focus();
					return false;
				}

				if(oEND_YMD.trim().length != 0){//������� �ִٸ� �ݵ�� ����Ϻ��� �����̾�� �Ѵ�.
					oSTR_YMD = parseInt(oSTR_YMD.replaceStr("-",""));
					oEND_YMD = parseInt(oEND_YMD.replaceStr("-",""));
					if(oSTR_YMD > oEND_YMD){
						alert(i+"��°�� ������� ����Ϻ��� �����ϴ�." );
						ds01T_CD_RESPCODE.RowPosition = i;
						document.getElementById("txtEND_YMD").focus();
						return false;
					}
				}

			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
            cfStyleGrid(form1.grd01T_CD_RESPCODE,15,"false","right");

            fnc_ColEnabled('D');

			//form load�� ������ ��å�ڵ� Ʈ�����·� ��ȸ
            var f = document.form1;
			//if (!valid(form1)) return;//Validation ����


				dsT_CD_RESPCODE.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SHR";
				dsT_CD_RESPCODE.Reset();

				//idsT_CD_RESPCODE.DataId="/servlet/GauceChannelSVL?cmd=template.hhh.pilot.cmd.RetrieveTreeImageListCMD";
				//idsT_CD_RESPCODE.Reset();

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

		/***************************************
		 * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// �ش� �÷��� �Ӽ��� Enabled�� ����
			if (prop == 'E') {
				form1.txtRESP_CD.disabled  = false;
				form1.txtRESP_NM.disabled  = false;
				form1.txtSTR_YMD.disabled  = false;
				form1.txtEND_YMD.disabled  = false;

				document.getElementById("img_HelpOn1").disabled = false;
				document.getElementById("img_HelpOn2").disabled = false;
			}
			// �ش� �÷��� �Ӽ��� Disabled�� ����
			else if (prop == 'D') {
				form1.txtRESP_CD.disabled  = true;
				form1.txtRESP_NM.disabled  = true;
				form1.txtSTR_YMD.disabled  = true;
				form1.txtEND_YMD.disabled  = true;

				document.getElementById("img_HelpOn1").disabled = true;
				document.getElementById("img_HelpOn2").disabled = true;
			}
		}


</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. Ʈ�������� DataSet                                               |
    | 2. �̸� : dsT_CD_RESPCODE                                            |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <Object ID="dsT_CD_RESPCODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. Ʈ�� �̹��� DataSet                                              |
    | 2. �̸� : idsT_CD_RESPCODE                                           |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <!--
	<object id=idsT_CD_RESPCODE classid=CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
			<param name=SyncLoad	value="true">
	</object>
	 -->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CD_RESPCODE                                        |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <Object ID="ds01T_CD_RESPCODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : tr01T_CD_RESPCODE                                    |
    | 3. Table List : T_CD_RESPCODE                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CD_RESPCODE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CD_RESPCODE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
	        //��å������ �ϳ��� ������ ȸ�������� �ִ´�.
	        dsT_CD_RESPCODE.AddRow();
			tr01T_CD_RESPCODE.KeyValue = "SVL(I:dsT_CD_RESPCODE=dsT_CD_RESPCODE)";
			tr01T_CD_RESPCODE.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SAV";
			tr01T_CD_RESPCODE.post();
            dsT_CD_RESPCODE.Reset();//Ʈ���� �籸���Ѵ�.
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_RESPCODE.CountRow);
        }
    </Script>

    <Script For=ds01T_CD_RESPCODE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

			fnc_ColEnabled('D');
        } else {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CD_RESPCODE.CountRow);

	        fnc_ColEnabled('E');
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CD_RESPCODE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CD_RESPCODE Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[��å�ڵ�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("��å�ڵ忡 ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=tr01T_CD_RESPCODE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=tr01T_CD_RESPCODE event="OnFail()">
	    cfErrorMsg(this);
    </script>

    <!-------------------------------+
    | treeview���� item�� Ŭ��������      |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CD_RESPCODE event=OnItemClick()>
		var overId1 = "RESP_CD";
		var overId2 = "COUNT_REM";
		var overNm = tvT_CD_RESPCODE.ItemText;
		var Row = dsT_CD_RESPCODE.NameValueRow("RESP_NM",overNm);
		var overValue1 = dsT_CD_RESPCODE.NameValue(Row,overId1);
		var overValue2 = dsT_CD_RESPCODE.NameValue(Row,overId2);
		//alert("overNm : "+overNm+", Row : "+Row+", overValue1 : "+overValue1);
		try {
			ds01T_CD_RESPCODE.DataID = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SHR_01&"+overId1+"="+overValue1+"&"+overId2+"="+overValue2;
			ds01T_CD_RESPCODE.Reset();

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
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
<!-- ���ε��� ���� �ӽõ����� ���� -->
<input type="hidden" id="txtRESP_LBL">
<input type="hidden" id="txtCOUNT_REM">
<input type="hidden" id="txtDOWNRESP_CD">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��å������ڵ���</td>
					<td align="right" class="navigator">HOME/��������/CDP/��å����/<font color="#000000">��å������ڵ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="311"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�����ڵ�</td>
					<td class="padding2423"><input id="txtUPRESP_CD" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">������å��</td>
					<td class="padding2423"><input id="txtUPRESP_NM" style="width:100%" class="input_ReadOnly" readonly></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
        <td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
				<colgroup>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��å�ڵ�</td>
					<td class="padding2423"><input id="txtRESP_CD" style="width:100%" maxlength="6"></td>
					<td align="center" class="creamBold">��å��</td>
					<td class="padding2423"><input id="txtRESP_NM" style="width:100%" maxlength="25"></td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" style="width:84" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn1" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"onclick="calendarBtn('datetype1','txtSTR_YMD','','450','134');"></a>
					</td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423">
						<input id="txtEND_YMD" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn2" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','650','134');"></a>
					</td>
				</tr>

			</table>
		</td>
	</tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="above">
                <tr>
                    <td>
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

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- ���� ��ȸ Ʈ�� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CD_RESPCODE" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:340px">
							<param name=DataID		value="dsT_CD_RESPCODE">
							<param name=TextColumn	value="RESP_NM">
							<param name=LevelColumn	value="RESP_LBL">
							<param name=ExpandLevel	value="1">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">

							<!-- <param name=UseImage		value="true">
							<param name=ImgDataID		value="idsT_CD_RESPCODE">
							<param name=ImgCColumn	value="ImgC">
							<param name=ImgDColumn	value="ImgD">
							<param name=ImgOColumn	value="ImgO"> -->
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ Ʈ�� ��-->
		</td>
		<td>
			<!-- ���� ��ȸ �׸��� ���̺� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grd01T_CD_RESPCODE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:340px">
							<param name="DataID"							value="ds01T_CD_RESPCODE">
                            <param name="EdiTABLE"				value="false">
                            <param name="DragDropEnable"		value="true">
                            <param name="SortView"					value="Left">
                            <param name="VIEWSUMMARY"		value=0>
                            <param name="Format"						value="
								<C> id='RESP_CD'		width=100	    name='�ڵ�'			sort=true		align=center									</C>
								<C> id='RESP_NM'		width=184		name='��å��'		sort=true		align=left		 								</C>
								<C> id='STR_YMD'		width=90		name='�����'		sort=true		align=center 								</C>
								<C> id='END_YMD'		width=90		name='�����'		sort=true		align=center									</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ �׸��� ���̺� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                                               |
    | 2. �̸� : bndT_CD_RESPCODE                                   |
    | 3. Table List : T_CD_RESPCODE                                 |
    +----------------------------------------------->
	<object id="bndT_CD_RESPCODE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="ds01T_CD_RESPCODE">
		<Param Name="BindInfo", Value="
			<C>Col='UPRESP_CD'				Ctrl='txtUPRESP_CD'				    Param=value</C>
			<C>Col='UPRESP_NM'			    Ctrl='txtUPRESP_NM'				    Param=value</C>
			<C>Col='RESP_CD'				Ctrl='txtRESP_CD'					Param=value</C>
			<C>Col='RESP_NM'				Ctrl='txtRESP_NM'					Param=value</C>
			<C>Col='STR_YMD'				Ctrl='txtSTR_YMD'					Param=value</C>
			<C>Col='END_YMD'				Ctrl='txtEND_YMD'					Param=value</C>
			<C>Col='RESP_LBL'				Ctrl='txtRESP_LBL'					Param=value</C>
			<C>Col='COUNT_REM'			    Ctrl='txtCOUNT_REM'			        Param=value</C>
			<C>Col='DOWNRESP_CD'            Ctrl='txtDOWNRESP_CD'			    Param=value</C>
	    ">
	</object>

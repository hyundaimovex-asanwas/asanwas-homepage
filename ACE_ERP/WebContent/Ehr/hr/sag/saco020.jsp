<!--
    ************************************************************************************
    * @Source              : codb010.jsp                                                                                             *
    * @Description        : �޿�����/�μ� ����                                                                                            *
    * @Font                   :                                                                                                                 *
    * @Developer Desc :                                                                                                                 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/06  |  ������   | �����ۼ�                                                                                           *
    * 2006/09/21  |  ������   | ���߿Ϸ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�޿�����/�μ� ����</title>
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

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			//if (!valid(form1)) return;//Validation ����
			  dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR";
	          dsT_CM_COMMON.Reset();

	          dsT_CM_COMMON2.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR_02";
	          dsT_CM_COMMON2.Reset();
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
			var f = document.form1;
			if(fnc_SaveItemCheck()) {
				tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
				tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SAV";
				tr01T_CM_COMMON.post();

	            //dsT_CM_COMMON.Reset();

	            dsT_CM_COMMON2.Reset();
	            ds01T_CM_COMMON.Reset();
			} else {
				return;
			}
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (ds01T_CM_COMMON.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");//�޼����� �����ε� ������ �������
                return;
            }
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + ds01T_CM_COMMON.ColumnString(ds01T_CM_COMMON.RowPosition,2) +  " : "  + ds01T_CM_COMMON.ColumnString(ds01T_CM_COMMON.RowPosition,4) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            ds01T_CM_COMMON.DeleteRow(ds01T_CM_COMMON.RowPosition);
			tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
			tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=DEL";
			tr01T_CM_COMMON.post();

			dsT_CM_COMMON2.Reset();
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
            // �ش� Dataset�� Header�� ������ Header ����
            if (ds01T_CM_COMMON.CountColumn == 0) {
                ds01T_CM_COMMON.setDataHeader("CD_GBN:STRING, COMM_CD:STRING, COMM_NM:STRING, COMM_NM2:STRING, STR_YMD:STRING, END_YMD:STRING, SORT_NO:DECIMAL, GBN2_TAG:STRING, EXT_01:STRING, EXT_02:STRING, EXT_03:STRING, EXT_04:STRING, REMARK:STRING, REMARK2:STRING, REMARK3:STRING, OTH_DEC:STRING");
            }

            // AddNew �� �Է� ���̺�� ��Ŀ��
            ds01T_CM_COMMON.AddRow();

            enableInput();// �Է��ʵ� Ȱ��ȭ

            var oCD_GBN = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition,"COMM_CD");
            if(oCD_GBN == undefined){
	            oCD_GBN = "**";
            }
            ds01T_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition, "STR_YMD") = getToday();

            document.getElementById("txtCD_GBN").value = oCD_GBN;
			document.getElementById("txtCOMM_CD").focus();
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
			dsT_CM_COMMON.ClearData();
			ds01T_CM_COMMON.ClearData();
			fnc_OnLoadProcess();
			document.getElementById("resultMessage").innerText = ' ';
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CM_COMMON.IsUpdated)  {
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
			if (!ds01T_CM_COMMON.IsUpdated ) {
				alert("������ ���� �����ϴ�.");
		    	return false;
			}

			var i = 0;
			var oACC_CD, oACC_NM, oDPT_CD, oDPT_NM;
			var RowCnt = ds01T_CM_COMMON.CountRow;
			for(i=1; i<=RowCnt; i++){

				oACC_CD = ds01T_CM_COMMON.NameValue(i,"ACC_CD");
				if(oACC_CD.trim() == ""){
					alert(i+"��°�� �����ڵ尡 �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					return false;
				}

				oDPT_CD = ds01T_CM_COMMON.NameValue(i,"DPT_CD");
				if(oDPT_CD.trim() == ""){
					alert(i+"��°�� �μ��ڵ尡 �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					return false;
				}

				/*
				oSORT_NO = ds01T_CM_COMMON.NameValue(i,"SORT_NO");
				if(oSORT_NO.toString().trim().length == 0 || oSORT_NO == 0){
					alert(i+"��°�� ���ļ�����  �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.medSORT_NO.Focus();
					return false;
				}
				*/
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
			cfStyleGrid(form1.grdT_CM_COMMON,15,"false","right");
			cfStyleGrid(form1.grdT_CM_COMMON2,15,"false","right");

			cfStyleGrid(form1.grd01T_CM_COMMON,15,"false","right");

			fnc_SearchList();

			ds01T_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR_01&COMM_CD=01";
			ds01T_CM_COMMON.Reset();
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

  		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                                                      |
    | 2. �̸� : dsT_CM_COMMON                                      |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CM_COMMON                                  |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID="ds01T_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : tr01T_CM_COMMON                                    |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_COMMON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=tr01T_CM_COMMON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=tr01T_CM_COMMON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | grid���� row�� Ŭ��������      |
    +------ -------------------->
	<script for=grdT_CM_COMMON event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		var overId = "COMM_CD";
		var overValue = dsT_CM_COMMON.NameValue(Row,overId);
		try {
			ds01T_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR_01&"+overId+"="+overValue;
			ds01T_CM_COMMON.Reset();
		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

	<script for=grdT_CM_COMMON2 event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		var overId = "NO_DPT_CD";
		var overId2 = "NO_DPT_NM";
		var overId3 = "ACC_CD";
		var overId4 = "ACC_NM";
		var overValue = dsT_CM_COMMON2.NameValue(Row,overId);
		var overValue2 = dsT_CM_COMMON2.NameValue(Row,overId2);
		var overValue3 = document.getElementById("txtACC_CD").value;
		var overValue4 = document.getElementById("txtACC_NM").value;

		try {
			// AddNew �� �Է� ���̺�� ��Ŀ��
            ds01T_CM_COMMON.AddRow();

            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"DPT_CD")=overValue;
            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"DPT_NM")=overValue2;
            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"ACC_CD")=overValue3;
            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"ACC_NM")=overValue4;

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

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�޿�����/�μ� ����</td>
                    <td align="right" class="navigator">HOME/��������/��Ÿ����/<font color="#000000">�޿�����/�μ� ����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- ���� ȭ�� ����-->
			<table width="300" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">
						<!-- ��ȸ ���� ���̺� �� -->
						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="300" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="left">
						                   <td align="left">
						                   		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
													<colgroup>
														<col width="90"></col>
														<col width=""></col>
													</colgroup>
													<tr>
														<td align="center" class="creamBold">�����ڵ�(�޿�)</td>
													</tr>
												</table>
						                   </td>
						                </tr>
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:80px;">
						                            <param name="DataID"						value="dsT_CM_COMMON">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"		value=0>
						                            <param name="Format"						value="
						                                <C>    id='ACC_CD'     name='�����ڵ�'    width='90'    align=left                </C>
						                                <C>    id='ACC_NM'   name='��������'    width='150'    align=left   edit=true             </C>
						                            ">
						                        </object>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>
						                    </td>
						                </tr>
										<tr align="left">
						                   <td align="left">
						                   		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
													<colgroup>
														<col width="90"></col>
														<col width=""></col>
													</colgroup>
													<tr>
														<td align="center" class="creamBold">���ε��� ���� �μ�</td>
													</tr>
												</table>
						                   </td>
						                </tr>
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CM_COMMON2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:230px;">
						                            <param name="DataID"						value="dsT_CM_COMMON2">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"		value=0>
						                            <param name="Format"						value="
						                                <C>    id='NO_DPT_CD'     name='�μ��ڵ�'    width='90'    align=left                </C>
						                                <C>    id='NO_DPT_NM'   name='�μ�'    width='150'    align=left   edit=true             </C>
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

					</td>
				</tr>
			</table>
			<!-- ���� ȭ�� ��-->
		</td>
		<td>
			<!-- ������ ȭ�� ����-->
			<table width="495" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<!-- ���� �Է� ���̺� ���� -->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width="145"></col>
											<col width="90"></col>
											<col width=""></col>
										</colgroup>
										<tr>
										 <td valign="bottom" class="searchState" colspan="4"><input id="txtACC_CD" name="txtACC_CD" size="8" type="hidden">
										 <input id="txtACC_NM" name="txtACC_NM" size="8" type="hidden"><span id="resultMessage">&nbsp;</span></td>
										 </tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- ���� �Է� ���̺� �� -->

						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr align="left">
			                   <td align="left">
			                   		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width=""></col>
										</colgroup>
										<tr>
											<td align="center" class="creamBold">���ε� �μ�</td>
										</tr>
									</table>
			                   </td>
			                </tr>
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grd01T_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:495px;height:335px;">
						                            <param name="DataID"						value="ds01T_CM_COMMON">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"		value=0>
						                            <param name="Format"						value="
						                                <C> id='CURROW'		width=40		name='NO'							align=center		value={String(Currow)}		</C>
						                                <C> id='ACC_CD'	width=70		name='�����ڵ�'			sort=true	align=center 										</C>
						                                <C> id='ACC_NM'	width=125		name='��������'		sort=true	align=left				                    		</C>
						                                <C> id='DPT_CD'	width=73		name='�μ��ڵ�'	sort=true	align=left				 	</C>
						                                <C> id='DPT_NM'	width=100		name='�μ�'	sort=true	align=center										 	</C>
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

					</td>
				</tr>
			</table>
			<!-- ������ ȭ�� ��-->
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
    | 2. �̸� : bndT_CM_COMMON                                   |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
	<object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CM_COMMON">
		<Param Name="BindInfo", Value="
			<C>Col='ACC_CD'			Ctrl='txtACC_CD'			Param=value</C>
			<C>Col='ACC_NM'			Ctrl='txtACC_NM'			Param=value</C>
	    ">
	</object>

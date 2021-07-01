<!--
***********************************************************************
* @source      : buta060.jsp
* @description : ����ǰ�� ����ó�� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>������û����(buta050)</title>
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

		var btnList = 'TFFTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			var ord_no = document.getElementById("txtORD_NO_SHR").value;

			dsT_DI_BUSINESSTRIP_STATE.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta060.cmd.BUTA060CMD&S_MODE=SHR&ORD_NO="+ord_no;
			dsT_DI_BUSINESSTRIP_STATE.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

            if(dsT_DI_BUSINESSTRIP_STATE.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

            if(confirm("[ǰ�ǹ�ȣ:"+dsT_DI_BUSINESSTRIP_STATE.NameValue(1,'ORD_NO')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_DI_BUSINESSTRIP_STATE.DeleteRow(1);
				trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_STATE=dsT_DI_BUSINESSTRIP_STATE)";
				trT_DI_BUSINESSTRIP_STATE.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta060.cmd.BUTA060CMD&S_MODE=DEL";
				trT_DI_BUSINESSTRIP_STATE.post();
			}

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

           //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

            document.getElementById("txtORD_NO_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_BUSINESSTRIP_STATE.ClearData();

            document.getElementById("txtORD_NO_SHR").focus();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_BUSINESSTRIP_STATE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var ord_no = document.getElementById("txtORD_NO_SHR");

            if(ord_no.value == ""){
                alert("ǰ�ǹ�ȣ�� �Է��ϼ���!");
                ord_no.focus();
                return false;
            }
            return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtORD_NO_SHR").focus();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_BUSINESSTRIP_STATE)	   |
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_STATE)	|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE)	        |
    +----------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_STATE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_STATE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        dsT_DI_BUSINESSTRIP_STATE.ClearData();
        document.getElementById("txtORD_NO_SHR").value = "";
        document.getElementById("txtORD_NO_SHR").focus();        
        
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
        cfErrorMsg(this);
    </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ǰ�� ����ó��</td>
					<td align="right" class="navigator">HOME/���°���/�������/<font color="#000000">����ǰ�� ����ó��</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="120"></col>
							<col width="120"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">ǰ�ǹ�ȣ&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtORD_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled">
							</td>
                            <td>&nbsp;</td>
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
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr align="center">
			<td width="20">&nbsp;</td>
			<td>
				<table width="360" height="220" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
								<colgroup>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
								<tr height="30">
									<td align="center" class="creamBold">��   ��</td>
									<td class="padding2423">
										<input id="txtDPT_NM" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
								<tr height="30">
									<td class="creamBold" align="center">��   ��</td>
									<td class="padding2423">
										<input id="txtJOB_NM" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
								<tr height="30">
									<td align="center" class="creamBold">ǰ �� ��</td>
									<td class="padding2423">
										<input id="txtNAM_KOR" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
								<tr height="30">
									<td align="center" class="creamBold">�������</td>
									<td class="padding2423">
										<input id="txtAPP_CMT" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
                                <tr height="30">
									<td align="center" class="creamBold">������ȣ</td>
									<td class="padding2423">
										<input id="txtTRANS_NO" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

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
<object id="bndT_DI_BUSINESSTRIP_STATE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_BUSINESSTRIP_STATE">
	<Param Name="BindInfo", Value='
        <C>Col=DPT_NM     		Ctrl=txtDPT_NM     		Param=value 	</C>
        <C>Col=JOB_NM			Ctrl=txtJOB_NM	   		Param=value		</C>
		<C>Col=NAM_KOR			Ctrl=txtNAM_KOR     	Param=value		</C>
		<C>Col=APP_CMT			Ctrl=txtAPP_CMT	   		Param=value		</C>
		<C>Col=TRANS_NO			Ctrl=txtTRANS_NO   		Param=value		</C>
    '>
</object>
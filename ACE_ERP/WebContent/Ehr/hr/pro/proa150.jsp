	<!--*************************************************************************
	* @source      : proa150.jsp												*
	* @description : ����� ��������ڼ��� PAGE									*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/04/13      ���м�        �����ۼ�									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>����� ��������� ����(proa150)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">
    //��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
        var btnList = 'TFTTFFFT';
//        var btnList = 'FTTTFFTT';
//		var btnList = 'TFTTFFFT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var isSave = false;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 		 	*
         ********************************************/
        function fnc_SearchList() {
			if(!fnc_SearchItemCheck()) return;	//��ȸ ��ȿ�� �˻�

			var PMT_YMD_SHR  = document.form1.txtPMT_YMD_SHR.value;   // �����⵵
			var GBN_CD_SHR     = document.form1.hidGBN_CD_SHR.value;     // ����/Ư�� ���� ����

            dsT_PM_PROMOTION_01.ClearData();

            dsT_PM_PROMOTION_01.DataId = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa150.cmd.PROA150CMD&S_MODE=SHR_01&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
            dsT_PM_PROMOTION_01.Reset();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  		 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
            dsT_PM_PROMOTION.UseChangeInfo = "false";
            trT_PM_PROMOTION.KeyValue = "tr01(I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)";
			trT_PM_PROMOTION.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa150.cmd.PROA150CMD&S_MODE=SAV";
			trT_PM_PROMOTION.post();
		}

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
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
  			document.form1.txtPMT_YMD_SHR.value = "";
//			document.form1.txtPRO_CNT.value     = "";
			document.form1.hidGBN_CD_SHR.value  = "1";
            document.getElementById("resultMessage").innerText = ' ';
//			changeInput();
			document.form1.txtPMT_YMD_SHR.value = next_yy;
        	dsT_PM_PROMOTION_01.ClearData();
        	dsT_PM_PROMOTION.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PROMOTION.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {
			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;   // �����⵵

            if( PMT_YMD_SHR == "" ){
        		alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
				return false;
        	}
        	if( PMT_YMD_SHR.length != 4 ){
        		alert("�����⵵�� �ٸ��� �Է��Ͻʽÿ�. ��)"+next_yy);
				return false;
        	}
        	if( PMT_YMD_SHR != next_yy ){
        		alert("����⵵�� ����ڸ� ó�� �����մϴ�. ��)"+next_yy);
				return false;
        	}
			return true;
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( dsT_PM_PROMOTION.CountRow == 0 ) {
				alert("������ ���� ����ڰ� �����ϴ�.");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�	*
         ********************************************/
        function fnc_OnLoadProcess() {
	        document.form1.txtPMT_YMD_SHR.value = next_yy;
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 		*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

  		/********************************************
         * ��¥ ���� ��ȿ�� üũ          			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_PROMOTION)  |
    | 3. ���Ǵ� Table List(T_PM_PROMOTION)         |
    +----------------------------------------------->
    <Object ID="dsT_PM_PROMOTION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_PROMOTION)  |
    | 3. ���Ǵ� Table List(T_PM_PROMOTION)         |
    +----------------------------------------------->
    <Object ID="dsT_PM_PROMOTION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_PM_PROMOTION                     |
    | 3. Table List : T_PM_PROMOTION                 |
    +----------------------------------------------->
    <Object ID ="trT_PM_PROMOTION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_PM_PROMOTION=dsT_PM_PROMOTION,I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_PM_PROMOTION_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

//            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			var PMT_YMD_SHR  = document.form1.txtPMT_YMD_SHR.value;   // �����⵵
			var GBN_CD_SHR     = document.form1.hidGBN_CD_SHR.value;     // ����/Ư�� ���� ����

//alert("SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR);
            dsT_PM_PROMOTION.ClearData();

            dsT_PM_PROMOTION.DataId = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa150.cmd.PROA150CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
            dsT_PM_PROMOTION.Reset();
        } else {
//alert(iCount);
//            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_PROMOTION.CountRow );
			alert("����� ���� ����� ������ �Ǿ� �ֽ��ϴ�.");

        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_PM_PROMOTION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_PROMOTION.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_PM_PROMOTION_01 Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_PM_PROMOTION Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		//fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnFail()">
        alert(trT_PM_PROMOTION.ErrorMsg);
    </script>

    <!--Ʈ������ ���� -->
<!--
    <script for=trT_PM_PROMOTION event="OnFail()">

        cfErrorMsg(this);

    </script>
 -->

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����� ��������ڼ���</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">����� ��������ڼ���</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<table width="100%" border="0" cellspacing="10" cellpadding="0">
						<colgroup>
							<col width="150"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">�����⵵</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtPMT_YMD_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPMT_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPMT_YMD_SHR" name="imgPMT_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPMT_YMD_SHR','','204','118');"></a>
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
        <td class="paddingTop15">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

	<input type="hidden" id="hidGBN_CD_SHR"    value="1">
	</form>

	<!-- form �� -->

</body>
</html>
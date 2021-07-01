	<!--*************************************************************************
	* @source      : wele020.jsp												*
	* @description : �Ⱓ���Ĵ����� PAGE										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/22            ä����         	        �����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�Ⱓ���Ĵ�����(wele020)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFFFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			//�Ĵ��̿��� ���� ��ȸ
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
            
            if(STR_YMD_SHR == "") {
                alert("���۳���� �Է��� �ּ���.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }
            if(END_YMD_SHR == "") {
                alert("�������� �Է��� �ּ���.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return;
            }

			dsT_WL_DININGUSE.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.e.wele020.cmd.WELE020CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR;
			dsT_WL_DININGUSE.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
  			document.getElementById("resultMessage").innerText = ' ';

        	dsT_WL_DININGUSE.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_WL_DININGUSE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            var vDATE = new Date(getTodayArray()[0], getTodayArray()[1]-1, getTodayArray()[2]);
            vDATE.setMonth(vDATE.getMonth() -1);
            
            var vSTR_YMD = vDATE.getYear()+"-"+lpad((vDATE.getMonth()+1), 2, "0")+"-16";
            var vEND_YMD = getTodayArray()[0]+"-"+getTodayArray()[1]+"-15";
            
            document.getElementById("txtSTR_YMD_SHR").value = vSTR_YMD;
            document.getElementById("txtEND_YMD_SHR").value = vEND_YMD;
            document.getElementById('txtSTR_YMD_SHR').focus();
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}


  		/********************************************
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

  		/********************************************
         * �Ⱓ������ �ʵ忡�� ��Ŀ�� ������ ������(�˻�)		*
         ********************************************/
        function setStdYmd(stObj){
        	var str_ymd = document.getElementById(stObj).value;
        	if( str_ymd.length > 8 ){
        		document.getElementById(stObj).value = str_ymd.substr(0,7)+"-16";
        	}
        }


  		/********************************************
         * �Ⱓ������ �ʵ忡�� ��Ŀ�� ������ ������ ����(�˻�)	*
         ********************************************/
        function setEndYmd2(enObj){
           	var end_ymd = document.getElementById(enObj).value;
           	if( end_ymd.length > 8 ){
           		document.getElementById(enObj).value = end_ymd.substr(0,7)+"-15";
           	}
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_DININGUSE)			 	   |
    | 3. ���Ǵ� Table List(T_WL_DININGUSE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_DININGUSE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_DININGUSE)			   |
    | 3. ���Ǵ� Table List(T_WL_DININGUSE)				   |
    +------------------------------------------------------>
	<Object ID="trT_WL_DININGUSE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_DININGUSE=dsT_WL_DININGUSE,I:dsT_WL_DININGUSE=dsT_WL_DININGUSE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            document.getElementById("resultMessage").value = "�ڷᰡ ��ȸ �Ǿ����ϴ�!";
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_DININGUSE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_DININGUSE event="OnFail()">
        alert(trT_WL_DININGUSE.ErrorMsg);
    </script>
    
    
    <script language=JavaScript for=medMRN_UNI event=onKeyUp(kcode,scode)>
        var uni = parseInt(document.getElementById("medMRN_UNI").Text);
        var cnt = parseInt(document.getElementById("txtMRN_CNT").value);
        document.getElementById("medMRN_AMT").Text = uni*cnt;
        
        
        var mrn = parseInt(document.getElementById("medMRN_AMT").Text);
        var afn = parseInt(document.getElementById("medAFN_AMT").Text);
        var evn = parseInt(document.getElementById("medEVN_AMT").Text);
        document.getElementById("medTOT_AMT").Text = mrn+afn+evn;
    </script>
    <script language=JavaScript for=medAFN_UNI event=onKeyUp(kcode,scode)>
        var uni = parseInt(document.getElementById("medAFN_UNI").Text);
        var cnt = parseInt(document.getElementById("txtAFN_CNT").value);
        document.getElementById("medAFN_AMT").Text = uni*cnt;
        
        
        var mrn = parseInt(document.getElementById("medMRN_AMT").Text);
        var afn = parseInt(document.getElementById("medAFN_AMT").Text);
        var evn = parseInt(document.getElementById("medEVN_AMT").Text);
        document.getElementById("medTOT_AMT").Text = mrn+afn+evn;
    </script>
    <script language=JavaScript for=medEVN_UNI event=onKeyUp(kcode,scode)>
        var uni = parseInt(document.getElementById("medEVN_UNI").Text);
        var cnt = parseInt(document.getElementById("txtEVN_CNT").value);
        document.getElementById("medEVN_AMT").Text = uni*cnt;
        
        
        var mrn = parseInt(document.getElementById("medMRN_AMT").Text);
        var afn = parseInt(document.getElementById("medAFN_AMT").Text);
        var evn = parseInt(document.getElementById("medEVN_AMT").Text);
        document.getElementById("medTOT_AMT").Text = mrn+afn+evn;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�Ⱓ���Ĵ�����</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�Ĵ��ڵ�/<font color="#000000">�Ⱓ���Ĵ�����</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">��ȸ�Ⱓ</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);setStdYmd('txtSTR_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','103','117');"></a>
								~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);setEndYmd2('txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','218','117');"></a>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="200"></col>
							<col width="200"></col>
							<col width="170"></col>
							<col width="200"></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold" colspan="2">&nbsp;</td>
							<td align="center" class="creamBold" colspan="2">��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medMRN_UNI" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=5>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="center"><input id="txtMRN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medMRN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medAFN_UNI" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=5>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="center"><input id="txtAFN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medAFN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medEVN_UNI" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=5>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="center"><input id="txtEVN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medEVN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold" colspan="2">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td class="padding2423" align="center"><input id="txtTOT_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">��</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_WL_DININGUSE ���� ���̺� -->
	<object id="bndT_WL_DININGUSE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_DININGUSE">
		<Param Name="BindInfo", Value="
			<C>Col=MRN_CNT		Ctrl=txtMRN_CNT		Param=value</C>
			<C>Col=MRN_AMT		Ctrl=medMRN_AMT		Param=Text</C>
			<C>Col=MRN_UNI		Ctrl=medMRN_UNI		Param=Text</C>
			<C>Col=AFN_CNT		Ctrl=txtAFN_CNT		Param=value</C>
			<C>Col=AFN_AMT		Ctrl=medAFN_AMT		Param=Text</C>
			<C>Col=AFN_UNI		Ctrl=medAFN_UNI		Param=Text</C>
			<C>Col=EVN_CNT		Ctrl=txtEVN_CNT		Param=value</C>
			<C>Col=EVN_AMT		Ctrl=medEVN_AMT		Param=Text</C>
			<C>Col=EVN_UNI		Ctrl=medEVN_UNI		Param=Text</C>
			<C>Col=TOT_CNT		Ctrl=txtTOT_CNT		Param=value</C>
			<C>Col=TOT_AMT		Ctrl=medTOT_AMT		Param=Text</C>
			<C>Col=TOT_UNI		Ctrl=medTOT_UNI		Param=Text</C>
		">
	</object>
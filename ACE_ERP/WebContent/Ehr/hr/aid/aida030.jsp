	<!--*************************************************************************
	* @source      : aida030.jsp												*
	* @description : ������� ������Ȳ PAGE	 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/13            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>������� ������Ȳ(aida030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TFFTTFFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			//������� ������Ȳ ��ȸ
			var SPL_YMD_STDT_SHR = document.form1.txtSPL_YMD_STDT_SHR.value;
			var SPL_YMD_ENDT_SHR = document.form1.txtSPL_YMD_ENDT_SHR.value;

			var JOB_CD_SHR       = document.form1.txtJOB_CD_SHR.value;
			var DPT_CD_SHR       = document.form1.txtDPT_CD_SHR.value;
			var AID_CD_SHR       = document.form1.txtAID_CD_SHR.value;

			var CEF_SEC_SHR      = document.getElementById("cmbCEF_SEC_SHR").value;
			var OCC_CD_SHR       = document.getElementById("cmbOCC_CD_SHR").value;

            var ORDER_TYPE          = fnc_GetCheckedValue("radORDER_TYPE");

			dsT_AD_AIDAPP.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida030.cmd.AIDA030CMD&S_MODE=SHR&SPL_YMD_STDT_SHR="+SPL_YMD_STDT_SHR+"&SPL_YMD_ENDT_SHR="+SPL_YMD_ENDT_SHR+"&CEF_SEC_SHR="+CEF_SEC_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&AID_CD_SHR="+AID_CD_SHR+"&ORDER_TYPE="+ORDER_TYPE;
			dsT_AD_AIDAPP.reset();
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
			//������� ������Ȳ ��ȸ
			var SPL_YMD_STDT_SHR = document.form1.txtSPL_YMD_STDT_SHR.value;
			var SPL_YMD_ENDT_SHR = document.form1.txtSPL_YMD_ENDT_SHR.value;

			var JOB_CD_SHR  = document.form1.txtJOB_CD_SHR.value;
			var DPT_CD_SHR  = document.form1.txtDPT_CD_SHR.value;
			var AID_CD_SHR  = document.form1.txtAID_CD_SHR.value;

			var CEF_SEC_SHR = document.getElementById("cmbCEF_SEC_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

			var ORDER_TYPE          = fnc_GetCheckedValue("radORDER_TYPE");


            //var url = "aida030_PV.jsp?SPL_YMD_STDT_SHR="+SPL_YMD_STDT_SHR+"&SPL_YMD_ENDT_SHR="+SPL_YMD_ENDT_SHR+"&CEF_SEC_SHR="+CEF_SEC_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&AID_CD_SHR="+AID_CD_SHR;
            var hnwparm = "[:SPL_YMD_STDT_SHR]="+SPL_YMD_STDT_SHR+"[:SPL_YMD_ENDT_SHR]="+SPL_YMD_ENDT_SHR+"[:CEF_SEC_SHR]="+CEF_SEC_SHR+"[:OCC_CD_SHR]="+OCC_CD_SHR+"[:JOB_CD_SHR]="+JOB_CD_SHR+"[:DPT_CD_SHR]="+DPT_CD_SHR+"[:AID_CD_SHR]="+AID_CD_SHR+"[:ORDER_TYPE]="+ORDER_TYPE;

            document.form1.rptObject.SetValues(hnwparm);
            document.form1.rptObject.RunButton("Print");

            //window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AD_AIDAPP.GridToExcel("������� ������Ȳ", '', 225)
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
        	// �ʱ�ȭ
			document.form1.txtAID_CD_SHR.value = "";
			document.form1.txtAID_NM_SHR.value = "";
			document.form1.txtDPT_CD_SHR.value = "";
			document.form1.txtDPT_NM_SHR.value = "";
			document.form1.txtJOB_CD_SHR.value = "";
			document.form1.txtJOB_NM_SHR.value = "";

        	document.form1.cmbCEF_SEC_SHR.selectedIndex = 0;
        	document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_AD_AIDAPP.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_AD_AIDAPP.IsUpdated)  {
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
            // ������� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_R2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_R2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_R2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_SEC_SHR").add(oOption);
			}

            // ���� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}

            document.getElementById('txtSPL_YMD_STDT_SHR').value = getStrDate();
            document.getElementById('txtSPL_YMD_ENDT_SHR').value = getToday();

			cfStyleGrid(form1.grdT_AD_AIDAPP,0,"true","false");      // Grid Style ����

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
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDAPP)			   |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AD_AIDAPP)			   |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP)				   |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP,I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ������� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R2"/>
       <jsp:param name="CODE_GUBUN"    value="R2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ ��3434�ᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDAPP.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnFail()">
        alert(trT_AD_AIDAPP.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | �׸����� ROW�� ����Ŭ�� �� ó��  	   						   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_AD_AIDAPP event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else {
            var url = "/hr/aid/aida011.jsp?REQ_NO="+dsT_AD_AIDAPP.NameString(row, "REQ_NO")+"&TYPE=TYPE3";
			cfWinOpen(url,"�����",870,500)
			fnc_SearchList();
		}
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������� ������Ȳ</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�������/<font color="#000000">������� ������Ȳ</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="290"></col>
							<col width="70"></col>
							<col width="290"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">������</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSPL_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSPL_YMD_STDT_SHR','','107','107');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtSPL_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSPL_YMD_ENDT_SHR','','222','107');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">������</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="0">
								<select id="cmbOCC_CD_SHR" style="WIDTH: 50%" onChange="fnc_SearchList()">
									<option value="0">���</option>
								</select>
							</td>
						</tr>






						<tr>
							<td class="searchState" rowspan="4" align="right">��ȸ����</td>
							<td class="padding2423" rowspan="4" align="left">
								<select id="cmbCEF_SEC_SHR" style="WIDTH: 50%" onChange="fnc_SearchList()">
									<option value="0">���</option>
								</select>
							</td>
						</tr>


						<tr>
							<td class="searchState" align="right">������</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="1">
								<input id="txtJOB_CD_SHR" style="width:10%" maxlength="2"> <input id="txtJOB_NM_SHR" style="width:30%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')"></a>
							</td>
						</tr>
						<tr>
							<td class="searchState" align="right">�ҼӺ�</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="2">
								<input id="txtDPT_CD_SHR" style="width:10%" maxlength="2"> <input id="txtDPT_NM_SHR" style="width:30%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
							</td>
						</tr>
						<tr>
							<td class="searchState" align="right">��û���뺰</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="3">
								<input id="txtAID_CD_SHR" style="width:10%" maxlength="2"> <input id="txtAID_NM_SHR" style="width:30%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAidCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgAidCd" name="ImgAidCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtAID_CD_SHR','txtAID_NM_SHR','��û����','R1')"></a>
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
					<object id="grdT_AD_AIDAPP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AD_AIDAPP">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=57	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="REQ_NO"		width=80	name="��û��ȣ"		align=center	Edit=none	show=false</C>
							<C> id="OCC_NM"		width=60	name="����"			align=center	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A1:CODE:CODE_NAME"</C>
							<C> id="DPT_NM"		width=100	name="�μ�"			align=left		Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A4:CODE:CODE_NAME"	LeftMargin=10</C>
							<C> id="JOB_NM"		width=60	name="����"			align=left		Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"	LeftMargin=10</C>
							<C> id="ENO_NM"		width=80	name="����"			align=center	Edit=none</C>
							<C> id="AID_NM"		width=100	name="��û����"		align=left		Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R1:CODE:CODE_NAME"	LeftMargin=10</C>
							<C> id="AID_YMD"	width=80	name="�߻�����"		align=center	Edit=none</C>
							<C> id="HLP1_AMT"	width=80	name="������"		align=right		Edit=none	RightMargin=10</C>
							<C> id="HLP2_AMT"	width=80	name="������"		align=right		Edit=none	RightMargin=10</C>
							<C> id="SPL_YMD"	width=80	name="��������"		align=center	Edit=none</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->
<comment id="__HNWID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="aida030.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
</comment><script> __ShowEmbedObject(__HNWID__); </script>
	</form>
	<!-- form �� -->

</body>
</html>


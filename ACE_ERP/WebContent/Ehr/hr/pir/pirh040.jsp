	<!--*************************************************************************
	* @source      : pirh040.jsp												*
	* @description : �ټӳ�����ټ�����Ȳ PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/04            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�ټӳ����������Ȳ(pirh040)</title>
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

		var btnList = 'TFFTTTFT';
		var today = getToday();

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	// �������� �Է� �ʼ�
        	if( document.form1.txtHIR_YMD_SHR.value=="" ){
        		alert("�������ڸ� �Է��Ͻʽÿ�. ��)"+today);
        		return;
        	}

        	var FLAG_SHR = "";
         	if( document.form1.rdoGBN_SHR[0].checked ){
        		FLAG_SHR = "HIR";  // ���
        	}
        	if( document.form1.rdoGBN_SHR[1].checked ){
        		FLAG_SHR = "HIRG"; // GROUP
        	}

			var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;  // ����(����, ����)
			var HIR_SHR_01  = document.getElementById("txtHIR_SHR_01").value;
			var HIR_SHR_02  = document.getElementById("txtHIR_SHR_02").value;

			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.h.pirh040.cmd.PIRH040CMD&S_MODE=SHR&HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&HIR_SHR_01="+HIR_SHR_01+"&HIR_SHR_02="+HIR_SHR_02;
			trVI_T_CM_PERSON.post();

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
                	// �������� �Է� �ʼ�
	        	if( document.form1.txtHIR_YMD_SHR.value=="" ){
	        		alert("�������ڸ� �Է��Ͻʽÿ�. ��)"+today);
	        		return;
	        	}

	        	var FLAG_SHR = "";
	         	if( document.form1.rdoGBN_SHR[0].checked ){
	        		FLAG_SHR = "HIR";  // ���
	        	}
	        	if( document.form1.rdoGBN_SHR[1].checked ){
	        		FLAG_SHR = "HIRG"; // GROUP
	        	}

				var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
				var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
				var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;  // ����(����, ����)
				var HIR_SHR_01  = document.getElementById("txtHIR_SHR_01").value;
				var HIR_SHR_02  = document.getElementById("txtHIR_SHR_02").value;

                var url = "pirh040_PV.jsp?HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&HIR_SHR_01="+HIR_SHR_01+"&HIR_SHR_02="+HIR_SHR_02;
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
                return;

        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsVI_T_CM_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdVI_T_CM_PERSON.GridToExcel("�ټӳ�����ټ�����Ȳ", '', 225)
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

        	document.form1.txtHIR_YMD_SHR.value = "";
        	document.form1.txtHIR_SHR_01.value = "";
        	document.form1.txtHIR_SHR_02.value = "";
        	document.form1.cmbGBN_CD_SHR.selectedIndex  = 0;
        	//document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.form1.rdoGBN_SHR[0].checked = true;
        	document.getElementById("resultMessage").innerText = ' ';
        	document.form1.txtHIR_YMD_SHR.value = today;

        	dsVI_T_CM_PERSON.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsVI_T_CM_PERSON.IsUpdated)  {
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

			fnc_ChangeGrid();      //�׸��� ���� ó��

            // �ٷα��� ���� �˻� �޺��ڽ� ����
			/*
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			*/
			document.form1.txtHIR_YMD_SHR.value = today;
			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style ����
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
         * ��¥ ���� ��ȿ�� üũ                    *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

		/********************************************
         * �ټӳ�� �Ⱓ���� �� ����>���� üũ      *
         ********************************************/
        function fnc_cfYmd() {
        	if( (document.form1.txtHIR_SHR_01.value >= document.form1.txtHIR_SHR_02.value) && document.form1.txtHIR_SHR_02.value != ""){
        		document.form1.txtHIR_SHR_02.value = "";
        		document.form1.txtHIR_SHR_02.focus();
        		alert("�ټӳ�� ������ �ùٸ��� �ʽ��ϴ�.");
        	}
        }

        /*************************
         * �׸��� ���� ó��      *
         ************************/
		function fnc_ChangeGrid() {
			var gbn_shr = document.form1.hidGBN_SHR.value;
			dsVI_T_CM_PERSON.ClearData();

			//disableInput();

			if(gbn_shr == "H"){  // ���
				form1.grdVI_T_CM_PERSON.Format =   	"<C> id='{CUROW}'	width=30	name='NO'			align=center	value={String(Currow)}</C>" +
													"<C> id='JOB_NM'		width=50	name='����'			align=center	Edit=none</C>" +
													"<C> id='DPT_NM'		width=120	name='�μ�'			align=left		Edit=none	 LeftMargin='10'</C>" +
													"<C> id='ENO_NM'		width=70	name='����'			align=center	Edit=none</C>" +
													"<C> id='BIR_YMD'	width=70	name='�������'		align=center	Edit=none</C>" +
													"<C> id='GUR_YMD'	width=70	name='������'			align=center	Edit=none</C>" +
													"<C> id='SCH_NM'		width=150	name='�����з�'		align=left		Edit=none	 LeftMargin='10'</C>" +
													"<C> id='HIR_YMD'	width=80	name='����Ի���'		align=center	Edit=none</C>" +
													"<C> id='JPR_YMD'	width=80	name='������'			align=center	Edit=none</C>" +
													"<C> id='HIR_CON'	width=60	name='�ٹ��Ⱓ'		align=center	Edit=none</C>";
				//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
				//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
				cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"false","false");

			} else if(gbn_shr == "G"){  // �׷�
				form1.grdVI_T_CM_PERSON.Format =   	"<C> id='{CUROW}'	width=30	name='NO'			align=center	value={String(Currow)}</C>" +
													"<C> id='JOB_NM'		width=50	name='����'			align=center	Edit=none</C>" +
													"<C> id='DPT_NM'		width=120	name='�μ�'			align=left		Edit=none	 LeftMargin='10'</C>" +
													"<C> id='ENO_NM'		width=70	name='����'			align=center	Edit=none</C>" +
													"<C> id='BIR_YMD'	width=70	name='�������'		align=center	Edit=none</C>" +
													"<C> id='GUR_YMD'	width=70	name='������'			align=center	Edit=none</C>" +
													"<C> id='SCH_NM'		width=150	name='�����з�'		align=left		Edit=none	 LeftMargin='10'</C>" +
													"<C> id='HIRG_YMD'	width=80	name='�׷��Ի���'		align=center	Edit=none</C>" +
													"<C> id='JPR_YMD'	width=80	name='������'			align=center	Edit=none</C>" +
													"<C> id='HIR_CON'	width=60	name='�ٹ��Ⱓ'		align=center	Edit=none</C>";
				//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
				//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
				cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"false","false");

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
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsVI_T_CM_PERSON)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
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
	<Script For=dsVI_T_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnSuccess()">
		// Ʈ�������� �̿��� ��ȸ�̹Ƿ�  "**���� �ڷᰡ ��ȸ�Ǿ����ϴ�."  ǥ��
		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnFail()">
        alert(trVI_T_CM_PERSON.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ټӳ���� ������Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�������ο���Ȳ/<font color="#000000">�ټӳ����������Ȳ</font></td>
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
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="80"></col>
					<col width="180"></col>
					<col width="80"></col>
					<col width="180"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">��������</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtHIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgHIR_YMD_SHR" name="imgHIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD_SHR','','114','108');"></a>
					</td>
					<td class="searchState" align="right">�Ի������</td>
					<td class="padding2423" align="left">
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_SHR.value = 'H';fnc_ChangeGrid();fnc_SearchList()">���
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_SHR.value = 'G';fnc_ChangeGrid();fnc_SearchList()">GROUP
						<input type="hidden" name="hidGBN_SHR" value="H">
					</td>
					<input type="hidden" id="cmbOCC_CD_SHR" value="0">
					<!--
					<td class="searchState" align="right">�ٷα��к�</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 70%" onChange="fnc_SearchList()">
							<option value="0">���</option>
						</select>
					</td>
					-->
				</tr>
				<tr>
					<td align="right" class="searchState">�ټӳ��</td>
					<td align="left" class="padding2423" colspan="3">
						<input id="txtHIR_SHR_01" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">&nbsp;�� ~
						<input id="txtHIR_SHR_02" size="4" maxLength="2" style="ime-mode:disabled" onblur="fnc_cfYmd()" onKeypress="cfCheckNumber()">&nbsp;�� (�� : 0,1,2,3..)
					</td>
					<td class="searchState" align="right">������</td>
					<td class="padding2423" align="left">
						<select id="cmbGBN_CD_SHR" style="WIDTH: 70%" onChange="fnc_SearchList()">
							<option value="0">���</option>
							<option value="1">����</option>
							<option value="2">����</option>
						</select>
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
					<object id="grdVI_T_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsVI_T_CM_PERSON">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
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


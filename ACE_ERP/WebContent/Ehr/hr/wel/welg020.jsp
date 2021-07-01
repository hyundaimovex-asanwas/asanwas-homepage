	<!--*************************************************************************
	* @source      : welg020.jsp												*
	* @description : �������Ȳ PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/02            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�������Ȳ(welg020)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TFFTTTFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	// �˻����� �Է� �ʼ�
        	if(document.form1.txtBIR_YMD_SHR.value=="" && document.form1.txtWED_YMD_SHR.value == "" && document.form1.txtHIR_YMD_SHR.value == ""){
        		alert("��ȸ������ �Է��Ͻʽÿ�.\n\n(����/��ȥ�����/�Ի��)");
        		return;
        	}
            var GBN_SHR     = fnc_GetCheckedValue("rdoGBN_SHR");
			var BIR_YMD_SHR = document.getElementById("txtBIR_YMD_SHR").value;
			var WED_YMD_SHR = document.getElementById("txtWED_YMD_SHR").value;
			var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

            trSHR.KeyValue  = "tr01(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON)";
            trSHR.action    = "/servlet/GauceChannelSVL?cmd=hr.wel.g.welg020.cmd.WELG020CMD&S_MODE=SHR&BIR_YMD_SHR="+BIR_YMD_SHR+"&WED_YMD_SHR="+WED_YMD_SHR+"&HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_SHR="+GBN_SHR;
            trSHR.post();

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
        	// �˻����� �Է� �ʼ�
        	if(document.form1.txtBIR_YMD_SHR.value=="" && document.form1.txtWED_YMD_SHR.value == "" && document.form1.txtHIR_YMD_SHR.value == ""){
        		alert("��ȸ������ �Է��Ͻʽÿ�.\n('����', '��ȥ�����', '�Ի���')");
        		return;
        	}

			var GBN_SHR     = fnc_GetCheckedValue("rdoGBN_SHR");
			var BIR_YMD_SHR = document.getElementById("txtBIR_YMD_SHR").value;
			var WED_YMD_SHR = document.getElementById("txtWED_YMD_SHR").value;
			var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;


			var url = "welg020_PV.jsp?BIR_YMD_SHR="+BIR_YMD_SHR+"&WED_YMD_SHR="+WED_YMD_SHR+"&HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_SHR="+GBN_SHR;
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

            form1.grdVI_T_CM_PERSON.GridToExcel("�������Ȳ", '', 225);
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
  //      	document.form1.txtHIR_YMD_SHR.value    = "";
  //      	document.form1.txtBIR_YMD_SHR.value   = "";
  //      	document.form1.txtWED_YMD_SHR.value   = "";
        	document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	document.form1.rdoGBN_SHR.item(0).checked = true;
        	changeInput();

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

            // �ٷα��� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}

			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style ����

            var vDate  = getTodayArray()[0]+"-"+getTodayArray()[1];
            var vDate1 = getTodayArray()[1];


            document.getElementById("txtBIR_YMD_SHR").value = vDate;
            document.getElementById("txtWED_YMD_SHR").value = vDate1;
            document.getElementById("txtHIR_YMD_SHR").value = vDate1;

			// Ȱ��ȭ ó��
			changeInput();

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
         * �˻��ʵ� Ȱ��ȭ ó��                           			*
         ********************************************/
        function changeInput() {
            var chk_val = fnc_GetCheckedValue("rdoGBN_SHR");

        	if(chk_val == "0") {
        		document.form1.txtHIR_YMD_SHR.readOnly  = true;
	  			document.form1.txtHIR_YMD_SHR.className = "input_ReadOnly";

        		document.form1.txtBIR_YMD_SHR.readOnly  = false;
	  			document.form1.txtBIR_YMD_SHR.className = "";
	  			document.getElementById("imgBIR_YMD_SHR").disabled = false;

        		document.form1.txtWED_YMD_SHR.readOnly  = true;
	  			document.form1.txtWED_YMD_SHR.className = "input_ReadOnly";

        	}else if(chk_val == "1") {
        		document.form1.txtHIR_YMD_SHR.readOnly  = true;
	  			document.form1.txtHIR_YMD_SHR.className = "input_ReadOnly";

        		document.form1.txtBIR_YMD_SHR.readOnly  = true;
	  			document.form1.txtBIR_YMD_SHR.className = "input_ReadOnly";
	  			document.getElementById("imgBIR_YMD_SHR").disabled = true;

        		document.form1.txtWED_YMD_SHR.readOnly  = false;
	  			document.form1.txtWED_YMD_SHR.className = "";

        	} else {
        		document.form1.txtHIR_YMD_SHR.readOnly  = false;
	  			document.form1.txtHIR_YMD_SHR.className = "";

        		document.form1.txtBIR_YMD_SHR.readOnly  = true;
	  			document.form1.txtBIR_YMD_SHR.className = "input_ReadOnly";
	  			document.getElementById("imgBIR_YMD_SHR").disabled = true;

        		document.form1.txtWED_YMD_SHR.readOnly  = true;
	  			document.form1.txtWED_YMD_SHR.className = "input_ReadOnly";

        	}
        }

        /**
         * �׸����� ����� ���� ��Ų��.
         */
        function fnc_ChangeHeader() {
            var oGrid = document.form1.grdVI_T_CM_PERSON;
            var chk_val = fnc_GetCheckedValue("rdoGBN_SHR");

            if(chk_val == "0") {

                oGrid.Format= "<C> id='DPT_NM'     width=100   name='�Ҽ�'             align=left          Edit=none       LeftMargin=5</C>        "
                            + "<C> id='JOB_NM'     width=50    name='����'             align=center        Edit=none</C>                            "
                            + "<C> id='ENO_NO'     width=60    name='���'             align=center        Edit=none</C>                            "
                            + "<C> id='ENO_NM'     width=60    name='����'             align=center        Edit=none</C>                            "
                            + "<C> id='ZIP_NO'     width=55    name='�����ȣ'         align=center        Edit=none</C>                            "
                            + "<C> id='ADDRESS'    width=350   name='�ּ�'             align=left          Edit=none       LeftMargin=10</C>        "
                            + "<C> id='BIR_YMD'    width=100   name='�������'         align=center        Edit=none</C>                            "
                            + "<C> id='S_BIR'      width=100   name='��±���'         align=center        Edit=none       show = false</C>                            "
                            + "<C> id='EM_PHN_NO'  width=100   name='�ڵ�����ȣ'       align=center        Edit=none</C>                            ";

            } else if(chk_val == "1") {
                oGrid.Format= "<C> id='DPT_NM'     width=100   name='�Ҽ�'             align=left          Edit=none       LeftMargin=10</C>        "
                            + "<C> id='JOB_NM'     width=50    name='����'             align=center        Edit=none</C>                            "
                            + "<C> id='ENO_NO'     width=60    name='���'             align=center        Edit=none</C>                            "
                            + "<C> id='ENO_NM'     width=60    name='����'             align=center        Edit=none</C>                            "
                            + "<C> id='ZIP_NO'     width=55    name='�����ȣ'         align=center        Edit=none</C>                            "
                            + "<C> id='ADDRESS'    width=350   name='�ּ�'             align=left          Edit=none       LeftMargin=10</C>        "
                            + "<C> id='WED_YMD'    width=100   name='��ȥ��'           align=center        Edit=none</C>                            "
                            + "<C> id='WED_NM'     width=70    name='����ڼ���'       align=center        Edit=none</C>                            "
                            + "<C> id='EM_PHN_NO'  width=100   name='�ڵ�����ȣ'       align=center        Edit=none</C>                            ";

            } else {
                oGrid.Format= "<C> id='DPT_NM'     width=100   name='�Ҽ�'             align=left          Edit=none       LeftMargin=10</C>                                    "
                            + "<C> id='JOB_NM'     width=50    name='����'             align=center        Edit=none</C>                                                        "
                            + "<C> id='ENO_NO'     width=60    name='���'             align=center        Edit=none</C>                                                        "
                            + "<C> id='ENO_NM'     width=60    name='����'             align=center        Edit=none</C>                                                        "
                            + "<C> id='HIR_YMD'    width=70    name='�Ի���'           align=center        Edit=none</C>                                                        "
                            + "<C> id='LSE_YY'     width=60    name='�ټӳ��'         align=center        Edit=none</C>                                                        "
                            + "<C> id='ZIP_NO'     width=55    name='�����ȣ'         align=center        Edit=none</C>                                                        "
                            + "<C> id='ADDRESS'    width=350   name='�ּ�'             align=left          Edit=none       LeftMargin=10</C>                                    "
                            + "<C> id='EM_PHN_NO'  width=100   name='�ڵ�����ȣ'       align=center        Edit=none</C>                                                        ";

            }

            cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style ����
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
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 			   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON,I:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON)">
	</Object>

     <Object ID ="trSHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
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
		} else {
            fnc_ChangeHeader();


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
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������Ȳ</td>
					<td align="right" class="navigator">HOME/�����Ļ�/<font color="#000000">�������Ȳ</font></td>
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
	     <!--        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>     -->
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
					<col width="70"></col>
					<col width="100"></col>
					<col width="70"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="90"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�ٷα��к�</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 80%" onChange="fnc_SearchList()">
							<option value="0">���</option>
						</select>
					</td>
                    <td class="searchState" align="right">
                        <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" value="2" checked style="margin-bottom:-2px;border:0;" onClick="changeInput()">�Ի��<br>
                    </td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtHIR_YMD_SHR" style="ime-mode:disabled" size="4" maxlength="2">&nbsp;��
                    </td>
					<td class="searchState" align="right">
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" value="0"  style="margin-bottom:-2px;border:0;" onClick="changeInput()">����<br>
					</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtBIR_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgBIR_YMD_SHR" name="imgBIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtBIR_YMD_SHR','','230','108');"></a>
					</td>
					<td class="searchState" align="right">
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" value="1" style="margin-bottom:-2px;border:0;" onClick="changeInput()">��ȥ�����<br>
					</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtWED_YMD_SHR" style="ime-mode:disabled" size="4" maxlength="2">&nbsp;��
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
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="DPT_NM"		width=100	name="�Ҽ�"			align=left		Edit=none	LeftMargin=10</C>
							<C> id="JOB_NM"		width=50	name="����"			align=center	Edit=none </C>
							<C> id="ENO_NO"		width=60	name="���"			align=center	Edit=none </C>
							<C> id="ENO_NM"		width=60	name="����"			align=center	Edit=none </C>
							<C> id="HIR_YMD"	width=70	name="�Ի���"		align=center	Edit=none </C>
							<C> id="LSE_YY"		width=60	name="�ټӳ��"		align=center	Edit=none </C>
							<C> id="ZIP_NO"		width=55	name="�����ȣ"		align=center	Edit=none </C>
							<C> id="ADDRESS"	width=250	name="�ּ�"			align=left		Edit=none	LeftMargin=10</C>
							<C> id="WED_TAG"	width=50	name="��ȥ����"		align=center	Edit=none   value={decode(WED_TAG, "Y", "��ȥ", "��ȥ")}</C>
							<C> id="WED_NM"		width=70	name="����ڼ���"   align=center	Edit=none </C>

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

	</form>
	<!-- form �� -->

</body>
</html>


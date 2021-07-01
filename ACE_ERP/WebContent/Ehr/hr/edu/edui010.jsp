<!--*************************************************************************
* @source      : edui010.jsp												*
* @description : ������ ������Ȳ                        					*
* @source      : edui010.jsp												*
* @description : ��������													*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2007/01/04            ä����            	�����ۼ�                        *
* 2007/05/09            ���м�            	����                            *
* 2007/05/29            �̽¿�            	����                            *
***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>��������(edui010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language=javascript src="/common/input.js"></script>
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
            if( document.form1.txtSTR_YMD_SHR.value=="" ){
                alert("�������ڸ� �Է��Ͻʽÿ�. ��)"+today);
                return;
            }
            if( document.form1.txtEND_YMD_SHR.value=="" ){
                alert("�������ڸ� �Է��Ͻʽÿ�. ��)"+today);
                return;
            }

            var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;

            var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

            var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;
            var DPT_NM_SHR  = document.getElementById("txtDPT_NM_SHR").value;
            var EDU_CD_SHR  = document.getElementById("txtEDU_CD_SHR").value;
            var EDU_NM_SHR  = document.getElementById("txtEDU_NM_SHR").value;
            var JOB_CD_SHR  = document.getElementById("txtJOB_CD_SHR").value;
            var JOB_NM_SHR  = document.getElementById("txtJOB_NM_SHR").value;
            var FIELD_CD_SHR  = document.getElementById("cmbFIELD_CD_SHR").value;

            dsT_CM_EDUCATION.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.i.edui010.cmd.EDUI010CMD"
                                    + "&S_MODE=SHR"
                                    + "&STR_YMD_SHR="+STR_YMD_SHR
                                    + "&OCC_CD_SHR="+OCC_CD_SHR
                                    + "&END_YMD_SHR="+END_YMD_SHR
                                    + "&DPT_CD_SHR="+DPT_CD_SHR
                                    + "&DPT_NM_SHR="+DPT_NM_SHR
                                    + "&EDU_CD_SHR="+EDU_CD_SHR
                                    + "&EDU_NM_SHR="+EDU_NM_SHR
                                    + "&JOB_CD_SHR="+JOB_CD_SHR
                                    + "&JOB_NM_SHR="+JOB_NM_SHR
                                    + "&FIELD_CD_SHR="+FIELD_CD_SHR;
            dsT_CM_EDUCATION.Reset();
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

        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CM_EDUCATION.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_EDUCATION.GridToExcel("�������װ���", '', 225);

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
           	document.form1.cmbOCC_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbFIELD_CD_SHR.selectedIndex    = 0;
        	document.getElementById("txtDPT_CD_SHR").value  = "";
        	document.getElementById("txtDPT_NM_SHR").value  = "";
            document.getElementById("txtEDU_CD_SHR").value  = "";
            document.getElementById("txtEDU_NM_SHR").value  = "";
        	document.getElementById("txtJOB_CD_SHR").value  = "";
        	document.getElementById("txtJOB_NM_SHR").value  = "";

        	document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_EDUCATION.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CM_EDUCATION.IsUpdated)  {
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

            //Grid Style ����
            cfStyleGrid(form1.grdT_CM_EDUCATION,0,"false","false");

            // �ٷα��� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
            // �������� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_Q5.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_Q5.NameValue(i,"CODE_NAME");
				document.getElementById("cmbFIELD_CD_SHR").add(oOption);
			}
			document.form1.txtSTR_YMD_SHR.value = today.substring(0,8)+"01";
			document.form1.txtEND_YMD_SHR.value = today;

            document.form1.txtJOB_CD_SHR.readOnly = true;
            document.form1.txtJOB_CD_SHR.className = "input_ReadOnly";
            document.form1.txtDPT_CD_SHR.readOnly = false;
            document.form1.txtDPT_CD_SHR.className = "";

            document.form1.txtJOB_CD_SHR.value = "";
            document.form1.txtJOB_NM_SHR.value = "";
            document.getElementById("Image20").disabled = true;
            document.getElementById("Image21").disabled = false;
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
         * ����/�μ� ���ÿ� ���� �Է� ����                 			*
         ********************************************/
        function changeInput() {
        	if( document.form1.rdoJOBDPT_SHR[0].checked ){
        		document.form1.txtJOB_CD_SHR.readOnly = true;
        		document.form1.txtJOB_CD_SHR.className = "input_ReadOnly";
        		document.form1.txtDPT_CD_SHR.readOnly = false;
        		document.form1.txtDPT_CD_SHR.className = "";

        		document.form1.txtJOB_CD_SHR.value = "";
        		document.form1.txtJOB_NM_SHR.value = "";
        		document.getElementById("Image20").disabled = true;
        		document.getElementById("Image21").disabled = false;

        	}else{
                document.form1.txtJOB_CD_SHR.readOnly = false;
        		document.form1.txtJOB_CD_SHR.className = "";
        		document.form1.txtDPT_CD_SHR.readOnly = true;
        		document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";

        		document.form1.txtDPT_CD_SHR.value = "";
        		document.form1.txtDPT_NM_SHR.value = "";
        		document.getElementById("Image20").disabled = false;
        		document.getElementById("Image21").disabled = true;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EDUCATION)			   |
    | 3. ���Ǵ� Table List(T_CM_EDUCATION) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �����о߱��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
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
	<Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_EDUCATION.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>



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
				<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������</td>
				<td align="right" class="navigator">HOME/��������/��Ȳ/<font color="#000000">��������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="greenTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
				<td class="searchState" align="right" width="100">�ٷα��б���</td>
				<td class="padding2423" align="left" width="300">
					<select id="cmbOCC_CD_SHR" name="cmbOCC_CD_SHR" style="WIDTH: 20%" onChange="fnc_SearchList()">
						<option value="">���</option>
					</select>
				</td>
                <td align="right" class="searchState"><input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" checked style="margin-bottom:-2px;border:0;"   onClick="changeInput()">�ҼӺ�</td>
                <td class="padding2423" align="left">
                    <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6">
                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)">
                        <img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
                    </a>
                </td>
            </tr>
            <tr>
				<td class="searchState" align="right">��������</td>
                <td class="padding2423">
                    <input id="txtEDU_CD_SHR" name="txtEDU_CD_SHR" size="5"  maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
                    <input id="txtEDU_NM_SHR" name="txtEDU_NM_SHR" size="20" class="input_ReadOnly"  readOnly>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd1','','/images/button/btn_HelpOver.gif',1)">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEduCd1" name="ImgEduCd1" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');">
                    </a>
                </td>
                <td align="right" class="searchState"><input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" style="margin-bottom:-2px;border:0;"  onClick="changeInput()">������</td>
                <td class="padding2423" align="left">
                    <input id="txtJOB_CD_SHR" name="txtJOB_CD_SHR" size="6"  maxlength="6">
                    <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)">
                        <img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')">
                    </a>
                </td>
            </tr>
			<tr>
				<td class="searchState" align="right">��������</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtSTR_YMD_SHR" name="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgSTR_YMD_SHR" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtEND_YMD_SHR" name="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgEND_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','134','108');"></a>
				</td>
				<td class="searchState" align="right">�����о�</td>
				<td class="padding2423" align="left" width="300">
					<select id="cmbFIELD_CD_SHR" name="cmbFIELD_CD_SHR" style="WIDTH: 50%">
						<option value="">���</option>
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
                        <object    id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_EDUCATION">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'       width=30        name='����'       align=center </C>
                                <C> id='DPT_NM'         width='100'     name='�Ҽ�'       align='center' </C>
                                <C> id='JOB_NM'         width='60'      name='����'       align='center' </C>
                                <C> id='ENO_NM'         width='60'      name='�̸�'       align='center' </C>
                                <C> id='EDU_TERM'       width='150'     name='�����Ⱓ'   align='center' </C>
                                <C> id='PLACE_NM'       width='60'      name='��������'   align='center' </C>
                                <C> id='EDU_NM'         width='120'     name='������'   align='center' </C>
                                <C> id='INT_NAM'        width='120'     name='����ó'     align='center' </C>
                                <C> id='CPT_PNT'        width='80'      name='��������'   align='center' </C>
                                <C> id='COST_AMT'       width='80'      name='������'     align='right' rightmargin='10' </C>
                                <C> id='DECISION_NM'    width='60'      name='��������'   align='center' </C>
                                <C> id='APP_VAL'        width='60'      name='������'   align='center' </C>
                                <C> id='REMARK'         width='100'     name='���'       align='center' </C>
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

</body>
</html>


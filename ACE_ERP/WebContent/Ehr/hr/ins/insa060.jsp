	<!--*************************************************************************
	* @source      : insa060.jsp												*
	* @description : ���ο��ݽŰ����� PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/14            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>���ο��ݽŰ�����(insa060)</title>
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
        	if( document.form1.txtSTR_YMD_SHR.value=="" ){
        		alert("���� �������ڸ� �Է��Ͻʽÿ�. ��)"+today.substr(0,8)+"01");
        		return;
        	}
        	if( document.form1.txtEND_YMD_SHR.value=="" ){
        		alert("���� �������Ḧ �Է��Ͻʽÿ�. ��)"+today);
        		return;
        	}

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

			if(document.tabINSA060.ActiveIndex==1){
				trT_CM_PERSON.KeyValue = "tr02(O:dsT_CM_PERSON_01=dsT_CM_PERSON_01)";
				trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa060.cmd.INSA060CMD&S_MODE=SHR_01&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR;
				trT_CM_PERSON.post();
			}else{
				trT_CM_PERSON.KeyValue = "tr03(O:dsT_CM_PERSON_02=dsT_CM_PERSON_02)";
				trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa060.cmd.INSA060CMD&S_MODE=SHR_02&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR;
				trT_CM_PERSON.post();
			}


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
			if(document.tabINSA060.ActiveIndex == 1){
	            if (confirm("������� ���ݺ���Ḧ Ȯ���Ͻðڽ��ϱ�?") == false) return;
				// save
				trT_CM_PERSON_SAV.KeyValue = "service_tr06(I:dsT_CM_PERSON_01=dsT_CM_PERSON_01)";
				trT_CM_PERSON_SAV.action   = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa060.cmd.INSA060CMD&S_MODE=SAV";
				trT_CM_PERSON_SAV.post();
			}
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
            var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
            var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
            var occ_cd  = document.getElementById("cmbOCC_CD_SHR").value;

            var str_ymd = str_ymd_shr.substr(0,4) + str_ymd_shr.substr(5,2) + str_ymd_shr.substr(8,2);
            var end_ymd = end_ymd_shr.substr(0,4) + end_ymd_shr.substr(5,2) + end_ymd_shr.substr(8,2);
            var ymd_val = "( " + str_ymd_shr.substr(0,4) + "/" + str_ymd_shr.substr(5,2) + "/" + str_ymd_shr.substr(8,2) + " - ";
            var ymd_val = ymd_val + end_ymd_shr.substr(0,4) + "/" + end_ymd_shr.substr(5,2) + "/" + end_ymd_shr.substr(8,2) + " )";

			if(document.tabINSA060.ActiveIndex==1){
            	var url = "insa060_PV.jsp?str_ymd="+str_ymd+"&end_ymd="+end_ymd+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
            }else{
            	var url = "insa060_PV1.jsp?str_ymd="+str_ymd+"&end_ymd="+end_ymd+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
            }
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

	        if(document.tabINSA060.ActiveIndex==1){
				if (dsT_CM_PERSON_01.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CM_PERSON_01.GridToExcel("���ο��ݽŰ�����(�����)", '', 225)

			}else{
				if (dsT_CM_PERSON_02.CountRow < 1) {
					alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
					return;
				}
	            form1.grdT_CM_PERSON_02.GridToExcel("���ο��ݽŰ�����(�����)", '', 225)

			}
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

        	//document.form1.txtSTR_YMD_SHR.value = today.substr(0,8)+"01";
        	//document.form1.txtEND_YMD_SHR.value = today;
        	document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_CM_PERSON_01.ClearData();
        	dsT_CM_PERSON_02.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CM_PERSON_01.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			if (dsT_CM_PERSON_02.IsUpdated)  {
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
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
	                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
	                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

			//ȭ���ħ���� �ӽ� �ذ�
			document.tabINSA060.ActiveIndex=2;
			document.tabINSA060.ActiveIndex=1;

			document.form1.txtSTR_YMD_SHR.value = today.substr(0,8)+"01";
        	document.form1.txtEND_YMD_SHR.value = today;

			cfStyleGrid(form1.grdT_CM_PERSON_01,0,"true","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_CM_PERSON_02,0,"true","false");      // Grid Style ����
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
         * �������ڿ��� ��Ŀ�� ������ �������ڿ� ��       		*
         ********************************************/
		function cfCheckDateTerm2(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("�������ڰ� �������ں��� Ů�ϴ�.");
					document.getElementById(p_obj).value = '';
				}
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)			  	   |
    | 3. ���Ǵ� Table List(T_CM_PERSON) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ����� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)			  	   |
    | 3. ���Ǵ� Table List(T_CM_PERSON) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON_01_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)			  	   |
    | 3. ���Ǵ� Table List(T_CM_PERSON) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)			       |
    | 3. ���Ǵ� Table List(T_CM_PERSON)				       |
    +------------------------------------------------------>
	<Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CM_PERSON_01=dsT_CM_PERSON_01,O:dsT_CM_PERSON_02=dsT_CM_PERSON_02)">
	</Object>

	<Object ID="trT_CM_PERSON_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
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
	<Script For=dsT_CM_PERSON_01 Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_01.CountRow);

			//ds copy�� Status�� ������ �����Ƿ� tr���� �Ѱ����� insert�� update�� ���� ���Ѵ�.
			cfCopyDataSet(dsT_CM_PERSON_01, dsT_CM_PERSON_01_CP, "copyHeader=yes,rowFrom=1,rowCnt="+dsT_CM_PERSON_01.CountRow);

			//�� �÷��� status�� �ٲپ� �־� cmd�� ���� �Ѿ�� �ְ� �Ѵ�.
			for(var i=1;i<=dsT_CM_PERSON_01.CountRow; i++){
				dsT_CM_PERSON_01_CP.UserStatus(i)=1;
			}

        }
    </Script>

	<Script For=dsT_CM_PERSON_02 Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_02.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
	<Script For=dsT_CM_PERSON_02 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON_01 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
	<Script For=dsT_CM_PERSON_02 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnSuccess()">
    </script>
	<script for=trT_CM_PERSON_SAV event="OnSuccess()">
        alert("ó���� �Ϸ�Ǿ����ϴ�.");
        fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnFail()">
        alert(trT_CM_PERSON.ErrorMsg);
    </script>
	<script for=trT_CM_PERSON_SAV event="OnFail()">
        alert(trT_CM_PERSON_SAV.ErrorMsg);
    </script>



    <!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_CM_PERSON_01 event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "IS_PROC" && dsT_CM_PERSON_01.CountRow > 0) {
            for(var i=1; i<=dsT_CM_PERSON_01.CountRow; i++) {
                if(dsT_CM_PERSON_01.NameString(i, "IS_PROC") == "F") {
                    dsT_CM_PERSON_01.NameString(i, "IS_PROC") = "T";
                } else if(dsT_CM_PERSON_01.NameString(i, "IS_PROC") == "T") {
                    dsT_CM_PERSON_01.NameString(i, "IS_PROC") = "F";
                }
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ο��ݽŰ�����</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ο���/<font color="#000000">���ο��ݽŰ�����</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
					<col width="60"></col>
					<col width="230"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�Ⱓ</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
						 ~
						<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTerm2('txtEND_YMD_SHR', 'txtSTR_YMD_SHR', 'txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','208','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
					<td class="searchState" align="right">�ٷα���</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 25%" onChange="fnc_SearchList()">
							<option value="0">��ü</option>
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


	<!-- �� ��� ���۳�Ʈ ���� -->
	<comment id="__NSID__">
	<object id=tabINSA060 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
			style="position:absolute; left:20; top:155; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
		<param name="BackColor"				value="#F8B97B">
		<param name="DisableBackColor"	value="#EEEEEE">
		<param name="TextColor"				value="#000000">
		<param name="DisableTextColor"		value="#878787">
		<param name="ActiveIndex" 				value="1">

		<param name="Format"			value='
			<T>divid="tabINSA060_01"	title="�����"</T>
			<T>divid="tabINSA060_02"	title="�����"</T>'>
	</object>
	</comment><script> __ShowEmbedObject(__NSID__); </script>


	<!-- ��1 ���� �Է� ���̺� ���� -->
	<div class=page id="tabINSA060_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:5;" >

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_PERSON_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_PERSON_01">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{currow}"		width=30	name="NO"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="IS_PROC"		width=60	name="�ݿ�"			align=center	EditStyle=CheckBox,Pointer=Hand  Edit={IF(IS_PROC="","false","true")}    CheckBoxText=IS_PROC_MSG    HeadCheckShow=true</C>
							<C> id="DPT_NM"			width=100	name="�Ҽ�"			align=left		Edit=none	SubBgColor="#99FFCC"	leftMargin="10"</C>
							<C> id="JOB_NM"			width=60	name="����"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="ENO_NO"			width=60	name="���"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="ENO_NM"			width=60	name="����"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="CET_NO"			width=90	name="�ֹι�ȣ"		align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="MON_PAY"		width=90	name="�ҵ����"		align=right		Edit=none	SubBgColor="#99FFCC"	RightMargin="10"</C>
							<C> id="NPEN_AMT"		width=70	name="�����"		align=right  	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="HIR_YMD"		width=80	name="�ڰ������"	align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="REMARK"			width=80	name="���"			align=left		Edit=none	SubBgColor="#99FFCC"	leftMargin="10"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	</div>
	<!-- ��1 ���� �Է� ���̺� �� -->

	<!-- ��2 ���� �Է� ���̺� ���� -->
	<div class=page id="tabINSA060_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_PERSON_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_PERSON_02">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{currow}"		width=50	name="NO"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="DPT_NM"			width=130	name="�Ҽ�"			align=left		Edit=none	SubBgColor="#99FFCC"	leftMargin="10"</C>
							<C> id="JOB_NM"			width=100	name="����"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="ENO_NO"			width=90	name="���"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="ENO_NM"			width=90	name="����"			align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="CET_NO"			width=140	name="�ֹι�ȣ"		align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="RET_YMD"		width=90	name="�ڰݻ����"		align=center	Edit=none	SubBgColor="#99FFCC"</C>
							<C> id="REMARK"			width=90	name="���"			align=left		Edit=none	SubBgColor="#99FFCC"	leftMargin="10"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	</div>
	<!-- ��2 ���� �Է� ���̺� �� -->

	</form>
	<!-- form �� -->

</body>
</html>


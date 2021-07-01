<!--
    ************************************************************************************
    * @source         : saga080.jsp 				                                                                                     *
    * @description   : �޿����ǥ PAGE.                                                                             *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/17  |  ������   | �����ۼ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�޿����ǥ</title>
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

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTTTFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; 	// �ش���
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; 		// �ٷα���
			var CD_GBN_SHR = document.getElementById("cmbCD_GBN_SHR").value; 		//�Ҽ�,���� ����
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; 		// �Ҽӱ���
			var TOTAL_SHR = document.getElementById("chkTOTAL_SHR").checked; 		// ��ü����

			//�ش����� ������ ��ȸ����.
			if(PIS_YYMM_SHR.trim().length == 0){
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}
			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(PIS_YYMM_SHR.trim().length != 7){
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}

            //�����ͼ� ����

			if(document.tabSAGA080.ActiveIndex==1){
			    dsT_CP_PAYMASTER_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga080.cmd.SAGA080CMD&S_MODE=SHR_01&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&CD_GBN_SHR="+CD_GBN_SHR;
	            dsT_CP_PAYMASTER_01.Reset();

	        }else if(document.tabSAGA080.ActiveIndex==2){
	            dsT_CP_PAYMASTER_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga080.cmd.SAGA080CMD&S_MODE=SHR_02&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&DPT_CD_SHR="+DPT_CD_SHR+"&TOTAL_SHR="+TOTAL_SHR;
	            dsT_CP_PAYMASTER_02.Reset();
			}else{
	            dsT_CP_PAYMASTER_03.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga080.cmd.SAGA080CMD&S_MODE=SHR_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&CD_GBN_SHR="+CD_GBN_SHR;
	            dsT_CP_PAYMASTER_03.Reset();
            }


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

        }

		/******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα���
			var CD_GBN_SHR = document.getElementById("cmbCD_GBN_SHR").value; //�Ҽ�,���� ����
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // �Ҽӱ���
			var TOTAL_SHR = document.getElementById("chkTOTAL_SHR").checked; // ��ü����

			//�ش����� ������ ��ȸ����.
			if(PIS_YYMM_SHR.trim().length == 0){
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}
			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(PIS_YYMM_SHR.trim().length != 7){
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}

            //�����ͼ� ����
			if(document.tabSAGA080.ActiveIndex==2){
	            var url = "saga081_PV.jsp?PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&DPT_CD_SHR="+DPT_CD_SHR+"&TOTAL_SHR="+TOTAL_SHR+"&GUBUN=1"+"&CD_GBN_SHR="+CD_GBN_SHR;
			}else if(document.tabSAGA080.ActiveIndex==3){

	            var url = "saga082_PV.jsp?PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&DPT_CD_SHR="+DPT_CD_SHR+"&TOTAL_SHR="+TOTAL_SHR+"&GUBUN=2"+ "&CD_GBN_SHR=" + CD_GBN_SHR;
            }
   			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			if(document.tabSAGA080.ActiveIndex==1){
               if (dsT_CP_PAYMASTER_01.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_01.GridToExcel("�޿����ǥ(���ݳ���)", '', 225)
            }else if (document.tabSAGA080.ActiveIndex==2){
			   if (dsT_CP_PAYMASTER_02.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_02.GridToExcel("�޿����ǥ(�޿�������)", '', 225)
            }else if (document.tabSAGA080.ActiveIndex==3){
			   if (dsT_CP_PAYMASTER_03.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_02.GridToExcel("�޿����ǥ(�޿�������)", '', 225)
            }

        }


         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

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

		 	dsT_CP_PAYMASTER_01.ClearData();
		  	dsT_CP_PAYMASTER_02.ClearData();
		 	dsT_CP_PAYMASTER_03.ClearData();

            document.tabSAGA080.ActiveIndex=1;
		 	document.getElementById("cmbOCC_CD_SHR").value = "";
			document.getElementById("txtDPT_CD_SHR").value = "";
			document.getElementById("txtDPT_NM_SHR").value = "";
			document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtPIS_YYMM_SHR.focus();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_PAYMASTER_01.IsUpdated || dsT_CP_PAYMASTER_02.IsUpdated)  {

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

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//�ٷα���
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7); // �ش���

			//ȭ���ħ���� �ӽ� �ذ�
			document.tabSAGA080.ActiveIndex=3;
			document.tabSAGA080.ActiveIndex=2;
			document.tabSAGA080.ActiveIndex=1;

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CP_PAYMASTER_01,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_02,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_03,0,"false","false");

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_01                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_02                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

     <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER_03                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>
    <Script For=dsT_CP_PAYMASTER_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <script language=JavaScript for=tabSAGA080 event=OnSelChanged(index)>

		if(document.tabSAGA080.ActiveIndex==1){
		    document.getElementById("tabSAGA080_TOTAL").style.display = "none";
  			document.getElementById("cmbCD_GBN_SHR").disabled = false;
			document.form1.txtDPT_CD_SHR.readOnly = true;
  			document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";
  			document.getElementById("imgDPT_CD_SHR").disabled = true;
  			document.form1.txtDPT_CD_SHR.value = "";
  			document.form1.txtDPT_NM_SHR.value = "";
            document.getElementById("imgPrint").style.display = "none";

           }else if (document.tabSAGA080.ActiveIndex==2){
			document.getElementById("tabSAGA080_TOTAL").style.display = "";
			document.getElementById("cmbCD_GBN_SHR").value = "0";
  			document.getElementById("cmbCD_GBN_SHR").disabled = true;
			document.form1.txtDPT_CD_SHR.readOnly = false;
  			document.form1.txtDPT_CD_SHR.className = "";
  			document.getElementById("imgDPT_CD_SHR").disabled = false;
            document.getElementById("imgPrint").style.display = "";

           }else if (document.tabSAGA080.ActiveIndex==3){
			document.getElementById("tabSAGA080_TOTAL").style.display = "none";
  			document.getElementById("cmbCD_GBN_SHR").disabled = false;
			document.form1.txtDPT_CD_SHR.readOnly = true;
  			document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";
  			document.getElementById("imgDPT_CD_SHR").disabled = true;
  			document.form1.txtDPT_CD_SHR.value = "";
  			document.form1.txtDPT_NM_SHR.value = "";
            document.getElementById("imgPrint").style.display = "";

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�޿����ǥ</td>
					<td align="right" class="navigator">HOME/�������/�޿�����/<font color="#000000">�޿����ǥ</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
								<col width="10"></col>
								<col width="80"></col>
								<col width="120"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="300"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="right" class="searchState">�ش���&nbsp;</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="right" class="searchState">�ٷα���&nbsp;</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">��ü</option>
									</select>
								</td>
								<td align="center" class="searchState">&nbsp;</td>
								<td>
									<select id="cmbCD_GBN_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="0" >�ҼӺ�</option>
	                                    <option value="1" >������</option>
									</select>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
										<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')">
									</a>
								</td>
								<td align="center">&nbsp;</td>
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

<!-- �ǿ� ���� DISPLAY ���� -->
<div id="tabSAGA080_TOTAL" style="position:absolute; left:617; top:137; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right" >
			<input type="checkbox" id="chkTOTAL_SHR" style="border:0" align="absmiddle" checked="checked" onClick="fnc_SearchList();">��ü����Ʈ
		</td>
	</tr>
	</table>
</div>
<!-- �ǿ� ���� DISPLAY �� -->

<!-- �� ��� ���۳�Ʈ ���� -->
<comment id="__NSID__">
<object id=tabSAGA080 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
		style="position:absolute; left:20; top:140; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#F8B97B">
	<param name="DisableBackColor"	value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 				value="1">

	<param name="Format"			value='
	    <T>divid="tabSAGA080_01"	title="���޳���"</T>
		<T>divid="tabSAGA080_02"	title="�޿�������"</T>
		<T>divid="tabSAGA080_03"	title="�Ѱ�ǥ"</T>'>
</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!-- �� ��� ���۳�Ʈ �� -->


<!-- ��0 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA080_01" style="position:absolute; left:20; top:160; width:800; height:300; z-index:3; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_01">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"		width=43		name="NO"			    align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DPT_NM"		    width=90		name="�Ҽ�"	            align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"	        width=45		name="����"		        align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"		    width=75		name="���"		        align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"	        width=65		name="����"		        align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMT_0"		width=80		name="�޿���"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMT_1"	    width=80		name="�󿩾�"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="FREE_TAX"		width=67		name="�߽Ĵ�"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NPEN_AMT"		width=67		name="���ο���"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HINU_AMT"	    width=67		name="�ǰ�����"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OLD_AMT"		width=100		name="��������纸��"		align=right	   Edit=none	    SubBgColor="#99FFCC"</C>
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
<!-- ��0 ���� �Է� ���̺� �� -->




<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabSAGA080_02" style="position:absolute; left:20; top:160; width:800; height:300; z-index:5;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"		width=44		name="NO"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DPT_NM"			width=105		name="�Ҽ�"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"			width=105		name="����"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"			width=105		name="���"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"			width=105		name="����"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BEF_AMT"		width=105		name="�����޿�"		align=right	    	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AFT_AMT"		width=105		name="����޿�"		align=right		    Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BALANCE"		width=105		name="����"			align=right		    Edit=none		SubBgColor="#99FFCC"	value={AFT_AMT - BEF_AMT}	</C>
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
<div class=page id="tabSAGA080_03" style="position:absolute; left:20; top:160; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"		width=44		name="NO"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMM_NM"		width=105		name="�Ҽ�/����"	align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BEF_PERSONS"	width=80		name="�����ο�"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BEF_AMT"		width=130		name="�����ݾ�"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AFT_PERSONS"	width=80		name="����ο�"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AFT_AMT"		width=130		name="����ݾ�"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CHANGE_PERSONS"	width=80		name="�����ο�"		align=right		Edit=none		SubBgColor="#99FFCC"	value={AFT_PERSONS - BEF_PERSONS}</C>
						<C> id="BALANCE"		width=130		name="����"			align=right		Edit=none		SubBgColor="#99FFCC"	value={AFT_AMT - BEF_AMT}		 </C>
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

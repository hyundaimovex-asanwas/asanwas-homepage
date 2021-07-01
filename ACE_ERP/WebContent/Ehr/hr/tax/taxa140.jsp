<!--
    ************************************************************************************
    * @source         : taxa140.jsp 				                                                                                     *
    * @description   : ���ڱ�/����ݰ��� PAGE.                                                                               *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/30  |  ������   | �����ۼ�                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ڱ�/����ݰ���</title>
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
		var btnList = 'TFFTTTTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var GMK_TAG_SHR = document.getElementById("cmbGMK_TAG_SHR").value; // ����/��������
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ - �޻󿩱����� ��ü�̸� �̻��
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // �Ҽ�

			//�ش����� ������ ��ȸ����.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}
			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

            //�����ͼ� ����
            dsT_AC_LOAN.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa140.cmd.TAXA140CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&GMK_TAG_SHR="+GMK_TAG_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+
															"&SEQ_SHR="+SEQ_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
            dsT_AC_LOAN.Reset();

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


            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_AC_LOAN.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_AC_LOAN.ColumnString(dsT_AC_LOAN.RowPosition,1)+"-"+dsT_AC_LOAN.ColumnString(dsT_AC_LOAN.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_AC_LOAN.DeleteRow(dsT_AC_LOAN.RowPosition);

			trT_AC_LOAN.KeyValue = "SVL(I:dsT_AC_LOAN=dsT_AC_LOAN)";
			trT_AC_LOAN.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa140.cmd.TAXA140CMD&S_MODE=DEL";
			trT_AC_LOAN.post();

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var GMK_TAG_SHR  = document.getElementById("cmbGMK_TAG_SHR").value; // ����/��������
			var SAL_GBN_SHR  = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var SEQ_SHR      = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ - �޻󿩱����� ��ü�̸� �̻��
			var OCC_CD_SHR   = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���
			var DPT_CD_SHR   = document.getElementById("txtDPT_CD_SHR").value; // �Ҽ�

			//�ش����� ������ ��ȸ����.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}
			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}


			//var hnwparm = "[:PIS_YYMM_SHR]="+PIS_YYMM_SHR+"[:GMK_TAG_SHR]="+GMK_TAG_SHR+"[:SAL_GBN_SHR]="+SAL_GBN_SHR+"[:SEQ_SHR]="+SEQ_SHR+"[:OCC_CD_SHR]="+OCC_CD_SHR+"[:DPT_CD_SHR]="+DPT_CD_SHR;

            //document.form1.rptObject.SetValues(hnwparm);
//            document.form1.rptObject.RunButton("Print");

			var url = "taxa140_PV.jsp?PIS_YYMM_SHR="+PIS_YYMM_SHR+"&GMK_TAG_SHR="+GMK_TAG_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+
													"&SEQ_SHR="+SEQ_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_AC_LOAN.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AC_LOAN.GridToExcel("���ڱ�/����ݰ���", '', 225)

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

			fnc_OnLoadProcess();
			dsT_AC_LOAN.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbGMK_TAG_SHR").value = "0"; // ����/��������
			document.getElementById("cmbSAL_GBN_SHR").value = "0"; // �޻󿩱���
			document.getElementById("cmbSEQ_SHR").value = "1"; // �Ϸù�ȣ
			document.getElementById("cmbOCC_CD_SHR").value = ""; // �ٷα��б���
			document.getElementById("txtDPT_CD_SHR").value = ""; // �Ҽ��ڵ�
			document.getElementById("txtDPT_NM_SHR").value = ""; // �ҼӸ�
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_AC_LOAN.IsUpdated)  {

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

        	if (!dsT_AC_LOAN.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

	        fnc_ChangeGrid();      //�׸��� ���� ó��

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);

			//����/��������
			if(document.getElementById("cmbGMK_TAG_SHR").length == 0){
				for( var i = 1; i <= dsCOMMON_V3.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_V3.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_V3.NameValue(i,"CODE_NAME");
					document.getElementById("cmbGMK_TAG_SHR").add(oOption);
				}
			}

			//�ٷα���
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

			//���ı��� ����
			fnc_changeGMK_TAG();

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************
         * ���ı��� ����         *
         *******************/
		function fnc_changeGMK_TAG() {

			var GMK_TAG_SHR = document.getElementById("cmbGMK_TAG_SHR").value; // ���ı���

			if(GMK_TAG_SHR == "3"){//�������� �����
				document.getElementById("divBONA050_01").style.display = "";
			}else{
				document.getElementById("divBONA050_01").style.display = "none";
			}

		}

        /*************************
         * �׸��� ���� ó��               *
         ************************/
		function fnc_ChangeGrid(obj) {

			if(obj == undefined || obj.value == "0"){
				form1.grdT_AC_LOAN.Format = "<C> id='{currow}'			width=44		name='NO'				align=center				value={String(Currow)}											</C>" +
																"<C> id='OCC_NM'				width=80		name='�ٷα���'				align=center					subsumtext='�հ�' </C>" +
																"<C> id='DPT_NM'				width=100		name='�Ҽ�'				align=center																								</C>" +
																"<C> id='JOB_NM'				width=80		name='����'				align=center																								</C>" +
																"<C> id='ENO_NO'				width=80		name='���'				align=center																								</C>" +
																"<C> id='ENO_NM'				width=80		name='����'				align=center																								</C>" +
																"<C> id='GMK_AMT'			width=100		name='���ڱ�'			align=right    rightmargin=10																					</C>";

            }else{
				form1.grdT_AC_LOAN.Format = "<C> id='{currow}'			width=44		name='NO'				align=center				value={String(Currow)}											</C>" +
																"<C> id='OCC_NM'				width=55		name='�ٷα���'				align=center					subsumtext='�հ�' </C>" +
																"<C> id='DPT_NM'				width=120		name='�Ҽ�'				align=center																								</C>" +
																"<C> id='JOB_NM'				width=60		name='����'				align=center																								</C>" +
																"<C> id='ENO_NO'				width=70		name='���'				align=center																								</C>" +
																"<C> id='ENO_NM'				width=70		name='����'				align=center																								</C>" +
																"<C> id='GMK_AMT'			width=90		name='���ݻ�ȯ��'	    align=right    rightmargin=10																					</C>" +
																"<C> id='GMK_INT'			width=90		name='���ڻ�ȯ��'	    align=right    rightmargin=10																				    </C>" +
																"<C> id='SUM_AMT'			width=90		name='�հ�'				align=right    rightmargin=10				value={GMK_AMT+GMK_INT}									            </C>" +
															    "<C> id='GMK_BAK'			width=90		name='������ܾ�'	    align=right    rightmargin=10																					</C>";

            }

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_AC_LOAN,0,"false","right");//mgrd������� �ּ�ó��

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
    | 2. �̸� : dsT_AC_LOAN                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
        <param Name=TimeOut           Value="360000">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- ����/�������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_V3"/>
       <jsp:param name="CODE_GUBUN"    value="V3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_AC_LOAN                                    |
    | 3. Table List : T_AC_LOAN                             |
    +----------------------------------------------->
    <Object ID ="trT_AC_LOAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_LOAN Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_AC_LOAN Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_AC_LOAN Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_AC_LOAN event="OnSuccess()">

   		var iCount = dsT_AC_LOAN.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			//alert(dsT_AC_LOAN.ExportData(1, dsT_AC_LOAN.CountRow, true));

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_AC_LOAN event="OnFail()">
        cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ڱ�/����ݰ���</td>
					<td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">���ڱ�/����ݰ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
								<col width="10"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�ش���</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<select id="cmbGMK_TAG_SHR" style="width:90" onChange="fnc_ChangeGrid(this);fnc_changeGMK_TAG();fnc_SearchList();">
									</select>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:90" onChange="fnc_SearchList();">
										<option value="" >��ü</option>
									</select>
								</td>
								<td align="center">&nbsp;</td>
							</tr>
							<tr class="paddingTop5">
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�޻󿩱���</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="width:90" onChange="fnc_SearchList();">
										<option value="0" >�޿�</option>
	                                    <option value="1" >��</option>
									</select>
								</td>
								<td align="center" class="searchState">�Ϸù�ȣ</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:90" onChange="fnc_SearchList();">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
										<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
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

<!-- ���ǿ� ���� DISPLAY ���� -->
<div id="divBONA050_01" style="position:absolute; left:619; top:155; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
		</td>
	</tr>
	</table>
</div>
<!-- ���ǿ� ���� DISPLAY �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
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
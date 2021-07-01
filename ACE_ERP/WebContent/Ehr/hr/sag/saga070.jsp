<!--
    ************************************************************************************
    * @source         : saga070.jsp 				                                                                                     *
    * @description   : ���κ��޿�������Ȳ PAGE.                                                                             *
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
<title>���κ��޿�������Ȳ</title>
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

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // ���޳⵵
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // �����ȣ

			//���޳⵵�� ������ ��ȸ����.
			if(PIS_YY_SHR.trim().length == 0){
					alert("���޳⵵�� �Է��ϼ���.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}
			//���޳⵵�� �߸��Ǿ����� ��ȸ����.
			if(PIS_YY_SHR.trim().length != 4){
					alert("���޳⵵�� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}

			//�����ȣ�� ������ ��ȸ����.
			if(ENO_NO_SHR.trim().length == 0){
					alert("�����ȣ�� �Է��ϼ���.");
					document.getElementById("txtENO_NO_SHR").focus();
					return false;
			}

            //Ʈ����� ����
			trT_CP_PAYMASTER.KeyValue = "SVL(O:dsT_CM_PERSON=dsT_CM_PERSON, O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
			trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga070.cmd.SAGA070CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			trT_CP_PAYMASTER.Post();

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


        	var OCC_CD = dsT_CP_PAYMASTER.NameValue(1,'OCC_CD');

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // ���޳⵵
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // �����ȣ

			//���޳⵵�� ������ ��ȸ����.
			if(PIS_YY_SHR.trim().length == 0){
					alert("���޳⵵�� �Է��ϼ���.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}
			//���޳⵵�� �߸��Ǿ����� ��ȸ����.
			if(PIS_YY_SHR.trim().length != 4){
					alert("���޳⵵�� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}

			//�����ȣ�� ������ ��ȸ����.
			if(ENO_NO_SHR.trim().length == 0){
					alert("�����ȣ�� �Է��ϼ���.");
					document.getElementById("txtENO_NO_SHR").focus();
					return false;
			}


			var url = "saga070_PV.jsp?PIS_YY_SHR="+PIS_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&OCC_CD="+OCC_CD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("���κ��޿�������Ȳ", '', 225);

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
			dsT_CP_PAYMASTER.ClearData();
			dsT_CM_PERSON.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

            if(dsTemp != "Modal"){
				document.getElementById("txtENO_NO_SHR").value = ""; // �����ȣ
				document.getElementById("txtENO_NM_SHR").value = ""; // �����ȣ
			}

			document.form1.txtPIS_YY_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
		        if (dsT_CP_PAYMASTER.IsUpdated)  {
		            if (!fnc_ExitQuestion()) return;
		        }

		        frame = window.external.GetFrame(window);
		        frame.CloseFrame();

            }else{
                window.close();

            }

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

        	if (!dsT_CP_PAYMASTER.isUpdated ) {
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

			//�ֱ� ������ �ش��� ��ȸ - ���κ��޿����װ��� Ŭ���� ����
			ds01T_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga020.cmd.SAGA020CMD&S_MODE=SHR_01";
			ds01T_CP_PAYMASTER.Reset();

			//�˾��ϰ�� �ڵ���ȸ(pirc020���� ���)
            if(dsTemp == "Modal"){

				document.getElementById('txtENO_NO_SHR').value = "<%=request.getParameter("ENO_NO")%>";
				document.getElementById('txtENO_NM_SHR').value = "<%=request.getParameter("ENO_NM")%>";

	  			document.getElementById("txtENO_NO_SHR").readOnly = true;
				document.getElementById("txtENO_NO_SHR").className = "input_ReadOnly";
	  			document.getElementById("txtENO_NM_SHR").readOnly = true;
				document.getElementById("txtENO_NM_SHR").className = "input_ReadOnly";
	            document.getElementById("imgENO_NO_SHR").style.display = "none";

				fnc_SearchList();

            }

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*************************
         * �׸��� ���� ó��               *
         ************************/
		function fnc_ChangeGrid(occ_cd) {

			if(occ_cd == undefined || occ_cd == "A"){
				form1.grdT_CP_PAYMASTER.Format = "<FC> id='{CUROW}'			width=40		name='NO'						align=center		value={String(Currow)}					</FC>" +
																		"<FC> id='PIS_MM'				width=50		name='��'							align=center																</FC>" +
																		"<FC> id='SAL_GBN_NM'			width=50		name='����'					align=center		value={DECODE(SAL_GBN,'0','�޿�','1','��',2,'�ұ�','4','����')}		SubSumText={decode(curlevel,9999,'�հ�')}	</FC>" +
																		"<C> id='SALT_AMT'				width=85		name='�޿���'					align=right		BgColor='#EEEEEE'								</C>" +
																		"<C> id='BAS_AMT'				width=85		name='�⺻��' 					align=right																</C>" +
																		"<C> id='DUTY_AMT'				width=85		name='��������'				align=right																</C>" +
																		"<C> id='LAW_AMT'				width=85		name='�ð��ܼ���'			align=right																</C>" +
																		"<C> id='BNS_AMT'				width=85		name='�󿩱�'				align=right																</C>" +
																		"<C> id='PPEN_AMT'				width=85		name='���ο���'				align=right																</C>" +
																		"<C> id='LSEV_AMT'				width=85		name='�ټӼ���'				align=right																</C>" +
																		"<C> id='ETC_AMT'				width=85		name='����������'			align=right																</C>" +
																		"<C> id='ETC_AMT2'				width=85		name='�����ٹ�����'			align=right																</C>" +
																		"<C> id='ETC_AMT3'				width=85		name='�Ĵ�'			align=right																</C>" +
																		"<C> id='ETC_AMT4'				width=85		name='�����ξ��'			align=right																</C>" +
																		"<C> id='OTH_AMT'				width=85		name='��Ÿ���� '				align=right																</C>" +
																		"<C> id='INCM_TAX'				width=85		name='�ҵ漼'				align=right																</C>" +
																		"<C> id='CITI_TAX'				width=85		name='�ֹμ�'				align=right																</C>" +
																		"<C> id='NPEN_AMT'				width=85		name='���ο���'				align=right																</C>" +
																		"<C> id='HINU_AMT'				width=85		name='�ǰ�����'				align=right																</C>" +
																		"<C> id='OLD_AMT'				width=85		name='����纸��'				align=right															</C>" +
																		"<C> id='HINS_AMT'				width=85		name='��뺸��'				align=right																</C>" +
																		"<C> id='DHLP_AMT'				width=85		name='����ȸ��'				align=right																</C>" +
																		"<C> id='PPED_AMT'				width=85		name='���ο���'				align=right																</C>" +
																		"<C> id='LAB_AMT'				width=85		name='��������'				align=right																</C>" +
																		"<C> id='LON_AMT'				width=85		name='�����ȯ'		align=right																</C>" +
																		"<C> id='OTHD_AMT'				width=85		name='��Ÿ���� '				align=right															</C>" +
																		"<C> id='DDTT_AMT'				width=85		name='���� �� '				align=right			BgColor='#EEEEEE'									</C>" +
																		"<C> id='PAY_AMT'				width=85		name='�Ǽ��ɾ�'				align=right			BgColor='#EEEEEE'									</C>";

            }else if(occ_cd == "M"){
				form1.grdT_CP_PAYMASTER.Format = "<FC> id='{CUROW}'			width=40		name='NO'						align=center		value={String(Currow)}					</FC>" +
																		"<FC> id='PIS_MM'				width=50		name='��'							align=center																</FC>" +
																		"<FC> id='SAL_GBN'				width=50		name='����'						align=center		value={DECODE(SAL_GBN,'0','�޿�','1','��','4','����')}		SubSumText={decode(curlevel,9999,'�հ�')}	</FC>" +
																		"<C> id='SALT_AMT'				width=85		name='�޿���'					align=right		BgColor='#EEEEEE'							</C>" +
																		"<C> id='BAS_AMT'				width=85		name='�⺻��' 					align=right																</C>" +
																		"<C> id='DUTY_AMT'				width=85		name='��������'				align=right																</C>" +
																		"<C> id='OT_AMT'				width=85		name='�������'				align=right																</C>" +
																		"<C> id='OSE_AMT'				width=85		name='�ù����'				align=right																</C>" +
																		"<C> id='RUN_AMT'				width=85		name='����/�۾�����'		align=right																</C>" +
																		"<C> id='MH_AMT'				width=85		name='�ڱⰳ�ߺ�'			align=right																</C>" +
																		"<C> id='LSEV_AMT'				width=85		name='�ټӼ���'				align=right																</C>" +
																		"<C> id='ETC_AMT'				width=85		name='��Ÿ����'				align=right		value={TB3_AMT+ SGF_AMT+OTH_AMT}	</C>";

            }

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","right");

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
    | 2. �̸� : dsT_CP_PAYMASTER                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubsumExpr"	value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CP_PAYMASTER                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CM_PERSON                                       |
    | 3. Table List : T_CM_PERSON                                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_CP_PAYMASTER                                    |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = ds01T_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtPIS_YY_SHR").value = oPIS_YYMM.substring(0,4); // ���޳⵵
			document.getElementById("txtPIS_YY_SHR").focus();
        }
    </Script>

    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">

		fnc_ChangeGrid(dsT_CM_PERSON.NameValue(iCount1,"OCC_CD"));

   		var iCount1 = dsT_CM_PERSON.CountRow;
		if (iCount1 != 0) {
			document.getElementById("txtENO_NM_SHR").value = dsT_CM_PERSON.NameValue(iCount1,"ENO_NM");
		}

   		var iCount2 = dsT_CP_PAYMASTER.CountRow;
		if (iCount2 == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount2);
        }

		document.getElementById("txtENO_NO_SHR").focus();

    </script>


    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CP_PAYMASTER event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ��޿�������Ȳ</td>
					<td align="right" class="navigator">HOME/�������/�޿�����/<font color="#000000">���κ��޿�������Ȳ</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>  -->
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
								<col width="200"></col>
								<col width="80"></col>
								<col width="100"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">���޳⵵</td>
								<td>
									<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">�����ȣ</td>
								<td>
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
								</td>
								<td align="center" class="searchState">&nbsp;</td>
								<td>&nbsp;</td>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtDPT_CD" style="text-align:center;width:26%" class="input_ReadOnly"  readonly>&nbsp;<input id="txtDPT_NM" style="width:70%" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtJOB_CD" style="text-align:center;width:26%" class="input_ReadOnly"  readonly>&nbsp;<input id="txtJOB_NM" style="width:70%" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">�Ի�����</td>
					<td class="padding2423"><input id="txtHIRG_YMD"  maxlength="10"  class="input_ReadOnly" style="width:100%" readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��������</td>
					<td class="padding2423"><input id="txtABA_NM"  maxlength="10"  class="input_ReadOnly" style="width:100%" readonly></td>
				    <td align="center" class="creamBold">���¹�ȣ</td>
					<td class="padding2423"><input id="txtACC_NO"  maxlength="10"  class="input_ReadOnly" style="width:100%" readonly></td>
				</tr>

			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
		<C>Col=OCC_CD     		 	Ctrl=txtOCC_CD     		 	Param=value 		</C>
		<C>Col=OCC_NM     		 	Ctrl=txtOCC_NM    			 	Param=value 		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM    			 	Param=value 		</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM    			 	Param=value 		</C>
		<C>Col=ABA_CD     		 	Ctrl=txtABA_CD     		 	Param=value 		</C>
		<C>Col=ABA_NM     		 	Ctrl=txtABA_NM     		 	Param=value 		</C>
		<C>Col=ACC_NO    		 	Ctrl=txtACC_NO     		 	Param=value 		</C>
		<C>Col=HIRG_YMD     		Ctrl=txtHIRG_YMD     		 	Param=value 		</C>
    '>
</object>
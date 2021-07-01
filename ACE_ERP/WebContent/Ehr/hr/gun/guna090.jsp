<!--
    ************************************************************************************
    * @source         : guna090.jsp
    * @description   : ���ں�������Ȳ PAGE.
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION
    *-------------+-----------+--------------------------------------------------------+
* 2007/02/23      ���м�        �����ۼ�.
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�ϱ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YMD_SHR = document.getElementById("txtPIS_YMD_SHR").value;// �ش�����

			//�ش����ڰ� ������ ��ȸ����.
			if(PIS_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����ڸ� �Է��ϼ���.");
					document.getElementById("txtPIS_YMD_SHR").focus();
					return false;
				}
			}
			//�ش����ڰ� �߸��Ǿ����� ��ȸ����.
			if(PIS_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YMD_SHR").focus();
					return false;
				}
			}

            //�����ͼ� ����
            trT_DI_DILIGENCE.KeyValue = "SVL(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE, O:dsT_DI_DILIGENCE_01=dsT_DI_DILIGENCE_01)";
            trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna090.cmd.GUNA090CMD&S_MODE=SHR&PIS_YMD_SHR="+PIS_YMD_SHR+"&OCC_CD_SHR=";
            trT_DI_DILIGENCE.post();

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
        	var PIS_YMD_SHR = document.getElementById("txtPIS_YMD_SHR").value;// �ش�����

			var url = "guna090_2007_PV.jsp?PIS_YMD_SHR="+PIS_YMD_SHR+"&OCC_CD_SHR=";

            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_DI_DILIGENCE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_DILIGENCE.GridToExcel("���ں�������Ȳ", '', 225);

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

			dsT_DI_DILIGENCE.ClearData();
			dsT_DI_DILIGENCE_01.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			//document.getElementById("txtPIS_YMD_SHR").value = getToday();
			document.form1.txtPIS_YMD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_DI_DILIGENCE.IsUpdated)  {

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

        	if (!dsT_DI_DILIGENCE.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"false","false");

			//���� �׸���
			cfStyleGrid(form1.grdT_DI_DILIGENCE_01,0,"false","false");      // Grid Style ����
			//form1.grdT_DI_DILIGENCE_01.HiddenHScroll  = true;
			form1.grdT_DI_DILIGENCE_01.HiddenVScroll  = true;
			//form1.grdT_DI_DILIGENCE_01.DisableNoHScroll = false;
			form1.grdT_DI_DILIGENCE_01.DisableNoVScroll = false;
			form1.grdT_DI_DILIGENCE_01.ViewHeader = false;
			//form1.grdT_DI_DILIGENCE_01.Enable = false;
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row�� ���õ� Column�� Color(#F3FED2)
		    form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row���� ���õ� Cell�� ������ ������ ��
		    form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row�� ���õ� Column�� Color(#F3FED2)
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row���� ���õ� Cell�� ������ ������ ��
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='EditCol',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row�� ���õ� Column�� Color
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='EditRow',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(O) ���õ� Row���� ���õ� Cell�� ������ ������ ��
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='CurCol',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row�� ���õ� Column�� Color
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='CurRow',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(��) Editable(X) ���õ� Row���� ���õ� Cell�� ������ ������ ��


			document.getElementById("txtPIS_YMD_SHR").value = getToday();
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
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_DILIGENCE                       |
    | 3. Table List : T_DI_DILIGENCE                   |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_DILIGENCE_01                       |
    | 3. Table List : T_DI_DILIGENCE                   |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_DI_DILIGENCE                  |
    | 3. Table List : T_DI_DILIGENCE              |
    +----------------------------------------------->
    <Object ID ="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_DI_DILIGENCE event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-- ��ũ�� ����ȭ -->
	<script language="JavaScript" for=grdT_DI_DILIGENCE event="OnScrolling(row, col, bymethod)">
		if(!bymethod)
			grdT_DI_DILIGENCE_01.SetScrolling(row, col);
	</script>

	<script language="JavaScript" for= grdT_DI_DILIGENCE_01 event="OnScrolling(row, col, bymethod)">
		if(!bymethod)
			grdT_DI_DILIGENCE.SetScrolling(row, col);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ϱ������</td>
					<td align="right" class="navigator">HOME/���°���/���ϱ��°���/<font color="#000000">�ϱ������</font></td>
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
			<!--
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			-->
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
								<col width="80"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="right" class="searchState">�ش�����&nbsp;</td>
								<td>
									<input id="txtPIS_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD_SHR','','65','112');"></a>
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
						<object	id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:285px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=39			name='NO'				align=center			value={String(Currow)}		</FC>
								<FC> id='DPT_NM'			width=130			name='�Ҽ�'				align=center			Suppress=1					</FC>
								<FC> id='ENO_CNT'			width=50			name='�ѿ�'				align=right				Value={Decode(ENO_CNT,'0',' ',ENO_CNT)} </FC>
								<FC> id='REA_CNT'			width=50			name='���'				align=right				Value={Decode(REA_CNT,'0',' ',REA_CNT)} </FC>
								<FC> id='ATT_CNT'			width=50			name='���'				align=right				Value={Decode(ATT_CNT,'0',' ',ATT_CNT)} </FC>
								<C> id='ATT_E'				width=60			name='����'				align=center										</C>
								<C> id='ATT_T'				width=60			name='��ü;�ް�'		align=center										</C>
								<G>name=�������Ȳ		HeadBgColor=#F7DCBB
									<C> id='ATT_F'			width=120			name='����'				align=center										</C>
									<C> id='ATT_Q'			width=120			name='���'				align=center		show=false								</C>
									<C> id='ATT_P'			width=120			name='����'				align=center		show=false								</C>
									<C> id='ATT_H'			width=120			name='����'				align=center										</C>
									<C> id='ATT_Z'			width=120			name='��������'			align=center		show=false								</C>
									<C> id='ATT_I'			width=120			name='Ư���ް�'			align=center										</C>
									<C> id='ATT_A'			width=120			name='���'				align=center										</C>
									<C> id='ATT_L'			width=120			name='��Ÿ'				align=center										</C>
								</G>
								<C> id='ATT_C'				width=60			name='����'				align=center										</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:87px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE_01">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=39			name='NO'				align=center			</FC>
								<FC> id='DPT_NM'			width=130			name='�Ҽ�'				align=center			</FC>
								<FC> id='ENO_CNT'			width=50			name='�ѿ�'				align=right				</FC>
								<FC> id='REA_CNT'			width=50			name='���'				align=right				</FC>
								<FC> id='ATT_CNT'			width=50			name='���'				align=right				</FC>
								<C> id='E_CNT'				width=60			name='����'				align=right				</C>
								<C> id='T_CNT'				width=60			name='��ü;�ް�'		align=right				</C>
								<G>name=�������Ȳ		HeadBgColor=#F7DCBB
									<C> id='F_CNT'			width=120			name='����'				align=right				</C>
									<C> id='Q_CNT'			width=120			name='���'				align=right		show=false		</C>
									<C> id='P_CNT'			width=120			name='����'				align=right		show=false		</C>
									<C> id='H_CNT'			width=120			name='����'				align=right				</C>
									<C> id='Z_CNT'			width=120			name='��������'			align=right		show=false		</C>
									<C> id='I_CNT'			width=120			name='Ư���ް�'			align=right				</C>
									<C> id='A_CNT'			width=120			name='���'				align=right				</C>
									<C> id='L_CNT'			width=120			name='��Ÿ'				align=right				</C>
								</G>
								<C> id='C_CNT'				width=60			name='����'				align=right				</C>
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
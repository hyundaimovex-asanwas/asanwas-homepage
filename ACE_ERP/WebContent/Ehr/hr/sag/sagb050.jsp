<!--
***********************************************************************
* @source      : sagb050.jsp
* @description : �׷캰 ��������/���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/23      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�׷캰 ��������/����(sagb050)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTTTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;

			var occ_cd = '1';
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var apy_tag = document.getElementById('cmbAPY_TAG_SHR').value;

			dsT_CP_GROUPFIXED.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb050.cmd.SAGB050CMD&S_MODE=SHR&OCC_CD="+occ_cd+"&SAL_CD="+sal_cd+"&APY_TAG="+apy_tag;
    		dsT_CP_GROUPFIXED.reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

				if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

				trT_CP_GROUPFIXED.KeyValue = "tr01(I:dsT_CP_GROUPFIXED=dsT_CP_GROUPFIXED)";
				trT_CP_GROUPFIXED.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb050.cmd.SAGB050CMD&S_MODE=SAV";
				trT_CP_GROUPFIXED.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var dpt_index = document.getElementById("cmbDPT_CD").selectedIndex;
            var pos_index = document.getElementById("cmbPOS_CD").selectedIndex;
            var SAL_NM = "";
            var DPT_NM = "";
            var POS_NM = "";

			SAL_NM = document.getElementById("txtSAL_NM").value;

            if(dpt_index >= 0){
				DPT_NM = document.getElementById("cmbDPT_CD")[dpt_index].text;
			}
            if(pos_index >= 0){
				POS_NM = document.getElementById("cmbPOS_CD")[pos_index].text;
			}


			if(dsT_CP_GROUPFIXED.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

			if(confirm("[�޿��׸�:" + SAL_NM + "/�Ҽ�:" + DPT_NM + "/����:" + POS_NM + "]\n�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_CP_GROUPFIXED.DeleteRow(dsT_CP_GROUPFIXED.RowPosition);
				trT_CP_GROUPFIXED.KeyValue = "tr02(I:dsT_CP_GROUPFIXED=dsT_CP_GROUPFIXED)";
				trT_CP_GROUPFIXED.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb050.cmd.SAGB050CMD&S_MODE=DEL";
				trT_CP_GROUPFIXED.post();
			}

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
           var f = document.form1;

			var occ_cd = '1';
            var sal_cd = document.getElementById('txtSAL_CD_SHR').value;
            var apy_tag = document.getElementById('cmbAPY_TAG_SHR').value;

			var url = "sagb050_PV.jsp?OCC_CD="+occ_cd+"&SAL_CD="+sal_cd+"&APY_TAG="+apy_tag;

   			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_GROUPFIXED.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_GROUPFIXED.GridToExcel("�׷캰�������Ұ���", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {



			dsT_CP_GROUPFIXED.AddRow();

			document.getElementById('txtSAL_CD').focus();

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById('txtSAL_CD_SHR').value = "";
            document.getElementById('txtSAL_NM_SHR').value = "";
            document.getElementById('cmbAPY_TAG_SHR').value = "";

   			form1.medAMOUNT.Enable = "true";

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_GROUPFIXED.ClearData();

            document.getElementById('txtSAL_CD_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_GROUPFIXED.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_CP_GROUPFIXED.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			var RowCnt = dsT_CP_GROUPFIXED.CountRow;

			for(i=1; i<=RowCnt; i++){

				if(dsT_CP_GROUPFIXED.NameValue(i,"SAL_CD").trim() == ""){
					alert("�޿��׸��� �Է��ϼ���.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("txtSAL_CD").focus();
					return false;
				}

				/*
				if(dsT_CP_GROUPFIXED.NameValue(i,"DPT_CD").trim() == ""){
					alert("�Ҽ��� �Է��ϼ���.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbDPT_CD").focus();
					return false;
				}

				if(dsT_CP_GROUPFIXED.NameValue(i,"POS_CD").trim() == ""){
					alert("������ �Է��ϼ���.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbPOS_CD").focus();
					return false;
				}
				*/

				if(dsT_CP_GROUPFIXED.NameValue(i,"AD_TAG").trim() == ""){
					alert("������ �Է��ϼ���.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbAD_TAG").focus();
					return false;
				}

				if(dsT_CP_GROUPFIXED.NameValue(i,"APY_TAG").trim() == ""){
					alert("������ �Է��ϼ���.");
					dsT_CP_GROUPFIXED.RowPosition = i;
					document.getElementById("cmbAPY_TAG").focus();
					return false;
				}

			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
				dsT_CP_GROUPFIXED.setDataHeader("OCC_CD:STRING:KEYVALUETYPE, SAL_CD:STRING:KEYVALUETYPE, DPT_CD:STRING:KEYVALUETYPE, POS_CD:STRING:KEYVALUETYPE, APY_YMD:STRING:KEYVALUETYPE, APY_TAG:STRING, AD_TAG:STRING, AMOUNT:NUMBER");
            //�����ͼ� ����
            dsT_CM_COMMON_DEPT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.codenm.cmd.CODENMCMD&S_MODE=SHR&GBN=DEPT";
            dsT_CM_COMMON_DEPT.Reset();

            //��������
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbPOS_CD").add(oOption);

            }

			cfStyleGrid(form1.grdT_CP_GROUPFIXED,15,"false","false");      // Grid Style ����

  			form1.medAMOUNT.Enable = "true";

            document.getElementById('txtSAL_CD_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_GROUPFIXED)   |
    | 3. ���Ǵ� Table List(T_CP_GROUPFIXED)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_GROUPFIXED" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_CP_GROUPFIXED)	    |
    | 3. ���Ǵ� Table List(T_CP_GROUPFIXED)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CP_GROUPFIXED" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_GROUPFIXED Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
  			form1.medAMOUNT.Enable = "true";

        }

    </Script>

    <Script For=dsT_CM_COMMON_DEPT Event="OnLoadCompleted(iCount)">

        //�Ҽӱ���
        for( var i = 1; i <= dsT_CM_COMMON_DEPT.CountRow; i++ ) {

            oOption       = document.createElement("OPTION");
            oOption.value = dsT_CM_COMMON_DEPT.NameValue(i,"CODE_CD");
            oOption.text  = dsT_CM_COMMON_DEPT.NameValue(i,"CODE_CD")+" "+dsT_CM_COMMON_DEPT.NameValue(i,"CODE_NM");
            document.getElementById("cmbDPT_CD").add(oOption);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_GROUPFIXED Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_GROUPFIXED Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�޿��׸�/�Ҽ�/����/��������]\n�Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[�޿��׸�/�Ҽ�/����/��������]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CP_GROUPFIXED event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CP_GROUPFIXED event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�׷캰��������/����</td>
					<td align="right" class="navigator">HOME/�������/�������/<font color="#000000">�׷캰��������/����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
									<col width="80"></col>
									<col width="200"></col>
									<col width="80"></col>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td align="right" class="searchState">�޿��׸�&nbsp;</td>
								<td>
									<input id="txtSAL_CD_SHR" name="txtSAL_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');" onChange="fnc_GetCommNm('U4','txtSAL_CD_SHR','txtSAL_NM_SHR');">
									<input id="txtSAL_NM_SHR" name="txtSAL_NM_SHR" size="16" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD_SHR','txtSAL_NM_SHR','�޿������׸�','U4');"></a>
								</td>
                                <td align="right" class="searchState">���뿩��&nbsp;</td>
								<td>
									<select id="cmbAPY_TAG_SHR" style="width:100" onChange="fnc_SearchList();">
                                        <option value="" >�� ü</option>
										<option value="Y" >�� ��</option>
	                                    <option value="N" >������</option>
									</select>
								</td>
                                <td>&nbsp;</td>
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
					<col width="80"></col>
					<col width="80"></col>
					<col width="140"></col>
					<col width="80"></col>
					<col width="130"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
                <tr>
					<td align="center" class="creamBold">�޿��׸�</td>
					<td class="padding2423" colspan="3">
						<input id="txtSAL_CD" name="txtSAL_CD" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');" onChange="fnc_GetCommNm('U4','txtSAL_CD','txtSAL_NM');">
						<input id="txtSAL_NM" name="txtSAL_NM" size="11" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAL_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSAL_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSAL_CD','txtSAL_NM','�޿������׸�','U4');return false;"></a>
                    </td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
                        <select id="cmbDPT_CD" style="width:100%">
							<option value=" " >��ü</option>
						</select>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" >
                        <select id="cmbPOS_CD" style="width:100%">
							<option value=" " >��ü</option>
						</select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=8>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">��  ��</td>
					<td class="padding2423">
                        <select id="cmbAD_TAG" style="WIDTH: 100%" >
						    <option value="A">�� ��</option>
						    <option value="D">�� ��</option>
						</select>
                    </td>
                    <td align="center" class="creamBold">��������</td>
					<td class="padding2423">
                        <input id="txtAPY_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtAPY_YMD.disabled == true) return; calendarBtn('datetype1','txtAPY_YMD','','410','215');"></a>
                    </td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
                        <select id="cmbAPY_TAG" style="width:100%">
							<option value="Y" >�� ��</option>
	                        <option value="N" >������</option>
						</select>
                    </td>
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
						<object	id="grdT_CP_GROUPFIXED" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
							<param name="DataID"					value="dsT_CP_GROUPFIXED">
							<param name="Format"					value="
								<C> id={currow}		width=49    name='NO'				align=center 	</C>
								<C> id='SAL_NM'		width=150	name='�޿��׸�'			align=left      LeftMargin='10' </C>
                                <C> id='DPT_CD'	    width=120	name='�Ҽ�'	        	align=left      EditStyle=Lookup Data='dsT_CM_COMMON_DEPT:CODE_CD:CODE_NM' LeftMargin='10' </C>
                                <C> id='POS_CD'	    width=85	name='����'	        	align=left      EditStyle=Lookup Data='dsT_CM_COMMON_A2:CODE:CODE_NAME' LeftMargin='10' </C>
								<C> id='AMOUNT'		width=100	name='�ݾ�'				align=right 	</C>
								<C> id='AD_TAG'		width=80	name='����'		    	align=center    Value={Decode(AD_TAG,'A','����','D','����')} </C>
                                <C> id='APY_YMD'	width=100	name='��������'	        align=center 	</C>
                                <C> id='APY_TAG'	width=80	name='���뿩��'	        align=center Value={Decode(APY_TAG,'Y','����','������')} </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �޻� ���� ���λ��� ���� ���̺� -->
<object id="bndT_CP_GROUPFIXED" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_GROUPFIXED">
	<Param Name="BindInfo", Value='
        <C>Col=DPT_CD		Ctrl=cmbDPT_CD	      	Param=value		Disable=disabled</C>
        <C>Col=POS_CD		Ctrl=cmbPOS_CD	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_CD		Ctrl=txtSAL_CD	      	Param=value		Disable=disabled</C>
		<C>Col=SAL_NM		Ctrl=txtSAL_NM	      	Param=value		Disable=disabled</C>
		<C>Col=AMOUNT    	Ctrl=medAMOUNT	     	Param=text		Disable=disabled</C>
		<C>Col=AD_TAG		Ctrl=cmbAD_TAG      	Param=value		Disable=disabled</C>
        <C>Col=APY_YMD		Ctrl=txtAPY_YMD      	Param=value		Disable=disabled</C>
        <C>Col=APY_TAG		Ctrl=cmbAPY_TAG      	Param=value		Disable=disabled</C>
    '>
</object>
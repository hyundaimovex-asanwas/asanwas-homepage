<!--
*****************************************************
* @source       : zzz1011.jsp
* @description : HRMS PAGE :: MS-SQL����
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2001/11/12      ������        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>MS-SQL����</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			var INTERFACE_CD = document.getElementById("cmbINTERFACE_CD").value;
			if(INTERFACE_CD == "MS"){
				trT_ZZ_YIMJT_SHR.KeyValue = "tr05(O:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)";
				trT_ZZ_YIMJT_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.zzz.a.zzza011.cmd.ZZZA011CMD&S_MODE=SHR";
				trT_ZZ_YIMJT_SHR.post();
			}else{
				trT_ZZ_SAP_SHR.KeyValue = "tr05(O:dsT_ZZ_SAP=dsT_ZZ_SAP)";
				trT_ZZ_SAP_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.zzz.a.zzza011.cmd.ZZZA011CMD&S_MODE=SAP_SHR";
				trT_ZZ_SAP_SHR.post();
			}
        }

		/***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			var INTERFACE_CD = document.getElementById("cmbINTERFACE_CD").value;
			if(INTERFACE_CD == "MS"){
				trT_ZZ_YIMJT.KeyValue = "tr01(I:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT,O:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)";
				trT_ZZ_YIMJT.action = "/servlet/GauceChannelSVL?cmd=hr.zzz.a.zzza011.cmd.ZZZA011CMD&S_MODE=SAV";
				trT_ZZ_YIMJT.post();
			}else{
				trT_ZZ_YIMJT.KeyValue = "tr01(I:dsT_ZZ_SAP=dsT_ZZ_SAP,O:dsT_ZZ_SAP=dsT_ZZ_SAP)";
				trT_ZZ_YIMJT.action = "/servlet/GauceChannelSVL?cmd=hr.zzz.a.zzza011.cmd.ZZZA011CMD&S_MODE=SAP_SAV";
				trT_ZZ_YIMJT.post();
			}
			/*
			// save

			*/
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

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			var INTERFACE_CD = document.getElementById("cmbINTERFACE_CD").value;
			if(INTERFACE_CD == "MS"){
				dsT_ZZ_YIMJT.AddRow();
			}else{
				dsT_ZZ_SAP.AddRow();
			}
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

	        document.getElementById("txtDONG").value = "";

			dsT_ZZ_POSTLIST.ClearData();
			document.form1.txtDONG.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_ZZ_YIMJT.IsUpdated)  {

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
        	 dsT_ZZ_YIMJT.SetDataHeader(
        	        			"ID:STRING(10),"+			// ���̵�
								"NAME:STRING(10),"+			// �̸�
								"REMARK:STRING(50)"			// ���
								);

        	 dsT_ZZ_YIMJT.SetDataHeader(
        	        			"KTOPL:STRING(10),"+			// ��������ǥ
								"SAKNR:STRING(10),"+			// G/L������ȣ
								"XBILK:STRING(1),"+			// ������
								"KTOKS:STRING(20),"+			// L�����׷�
								"TXT20:STRING(100),"+			// �����ؽ�Ʈ
								"TXT50:STRING(200)"			// �ؽ�Ʈ
								);
			fnc_Combo();
            //Grid Style ����
            cfStyleGrid(form1.grdT_ZZ_YIMJT,15,"true","false");
            cfStyleGrid(form1.grdT_ZZ_SAP,15,"true","false");
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}
		function fnc_Combo(){
			var cd = document.getElementById("cmbINTERFACE_CD").value;
			if(cd == "MS"){
				document.getElementById("ms").style.display = "";
                document.getElementById("sap").style.display = "none";
			}else{
				document.getElementById("ms").style.display = "none";
                document.getElementById("sap").style.display = "";
			}
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
    | 2. �̸� : dsT_ZZ_POSTLIST                                     |
    | 3. Table List : T_ZZ_POSTLIST                                |
    +----------------------------------------------->
    <Object ID="dsT_ZZ_YIMJT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_ZZ_YIMJT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT,I:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)">
	</Object>

	<Object ID="trT_ZZ_YIMJT_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)">
	</Object>


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_ZZ_POSTLIST                                     |
    | 3. Table List : T_ZZ_POSTLIST                                |
    +----------------------------------------------->
    <Object ID="dsT_ZZ_SAP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_ZZ_SAP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT,I:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)">
	</Object>

	<Object ID="trT_ZZ_SAP_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_ZZ_YIMJT=dsT_ZZ_YIMJT)">
	</Object>
    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_ZZ_YIMJT Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_ZZ_YIMJT Event="OnLoadError()">

    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">MS-SQL����</td>
					<td align="right" class="navigator">HOME/�ѹ�(��Ÿ)/MS-SQL����/<font color="#000000">MS-SQL����/SAP����</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
		<td class="padding2423" align="left">
			<select id="cmbINTERFACE_CD" style="width='200';" onChange="fnc_Combo()" >
				<option value="MS">MS-SQL���� �׽�Ʈ</option>			
				<option value="SAP">SAP���� �׽�Ʈ</option>			
			</select>
		</td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<div id ="ms"  style="display:none">
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ZZ_YIMJT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_ZZ_YIMJT">
							<param name="EdiTABLE"					value="true">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="Format"					value="
                                <C>    id='ID'       name='���̵�'  width='100'    align=center               </C>
                                <C>    id='NAME'     name='�̸�'    width='100'    align=left                </C>
                                <C>    id='REMARK'   name='���'    width='300'    align=left   edit=true             </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div id ="sap"  style="display:none">
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ZZ_SAP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_ZZ_SAP">
							<param name="EdiTABLE"					value="true">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="Format"					value="
								 <C>    id='{CURROW}'       name='NO'  width='30'    align=center               </C>
                                <C>    id='KTOPL'       name='��������ǥ'  width='80'    align=center               </C>
                                <C>    id='SAKNR'     name='G/L������ȣ'    width='100'    align=left                </C>
                                <C>    id='XBILK'   name='������'    width='50'    align=left   edit=true             </C>
                                <C>    id='KTOKS'   name='G/L�����׷�'    width='100'    align=left   edit=true             </C>
                                <C>    id='TXT20'   name='�����ؽ�Ʈ'    width='200'    align=left   edit=true             </C>
                                <C>    id='TXT50'   name='�ؽ�Ʈ'    width='200'    align=left   edit=true             </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>
<!--
***********************************************************************
* @source      : butb010.jsp
* @description : �ؿ�����ǰ�ǰ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/03/11      ������        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�ؿ�����ǰ�ǰ���(butc010)</title>
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

		var btnList = 'TFFTFFFT';

        var today = getToday();
        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

            var f = document.form1;

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
            var app_yn = document.getElementById("cmbAPP_YN_SHR").value;
            var app_status = document.getElementById("cmbAPP_STATUS_SHR").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;

            if(!fnc_SearchItemCheck()) return;//�˻����� ��ȿ�� �˻�

            //�����ڴ� ��� ��ȸ�� ����
			dsT_DI_DISPATCH.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb010.cmd.BUTB010CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&APP_YN="+app_yn+"&APP_STATUS="+app_status+"&PENO_NO="+eno_no+"&ENO_NO="+our_man;
			dsT_DI_DISPATCH.reset();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

            if(dsT_DI_DISPATCH.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
		
            //ó����Ȳ�� ��û�� �ƴѰ��� ���� �� �� ����
            if(!(dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,'APP_STATUS') == '1')){
                alert("��� ������ �����ʹ� ������ �� �����ϴ�!");
                return;
            }

			if(confirm("[ǰ�ǹ�ȣ:"+dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,'ORD_NO')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_DI_DISPATCH.DeleteRow(dsT_DI_DISPATCH.RowPosition);
				trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
				trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb010.cmd.BUTB010CMD&S_MODE=DEL";
				trT_DI_DISPATCH.post();
			}

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			//document.getElementById("txtSTR_YMD_SHR").value = "";
			//document.getElementById("txtEND_YMD_SHR").value = "";

			document.getElementById("cmbGBN1_SHR").value = "";
			document.getElementById("cmbGBN2_SHR").value = "";

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("txtOUR_MAN_SHR").value = "";
            document.getElementById("txtOUR_MAN_NM_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

        	dsT_DI_DISPATCH.ClearData();

            document.getElementById("txtSTR_YMD_SHR").focus();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			if(dsTemp != "Modal"){
	            if (dsT_DI_DISPATCH.IsUpdated)  {
	                if (!fnc_ExitQuestion())  return;
	            }
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }else{
                window.close();
            }
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

 			//���۳���� ������ ��ȸ����.
			if(str_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(str_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(end_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������� �߸��Ǿ����� ��ȸ����.
			if(end_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//�������� ���۳������ ũ�� �ʵȴ�.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
					alert("�������� ���۳������ �����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}

            return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

            //document.getElementById("txtSTR_YMD_SHR").value = today.substring(0,8)+"01";
            document.getElementById("txtSTR_YMD_SHR").value = addDate("M", today, -1).substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = next_month(getToday())+"-"+getToday().substring(8);

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_DI_DISPATCH,0,"false","false");      // Grid Style ����

			//�̰��� �ڵ���ȸ
			document.getElementById("cmbAPP_YN_SHR").value = "R";
			fnc_SearchList();

            document.getElementById("txtSTR_YMD_SHR").focus();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!----------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_DISPATCH)	|
    | 3. ���Ǵ� Table List(T_DI_DISPATCH) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_DISPATCH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------------------+
    | 1. ī�ǿ� DataSet							                |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_STATE)	|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_DISPATCH_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


    <!----------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_DISPATCH)	|
    | 3. ���Ǵ� Table List(T_DI_DISPATCH)	        |
    +----------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DISPATCH Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

		<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsPROC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=trT_DI_DISPATCH Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_DISPATCH event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_DISPATCH event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | �׸����� ROW�� ����Ŭ�� �� ó��  	   				   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_DI_DISPATCH event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else {

			if(dsT_DI_DISPATCH.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				return;
			}

            //���õ� ROW�� dsT_DI_BUSINESSTRIP_STATE_CP �����Ͽ� �Ѱ��ش�.
			cfCopyDataSet(dsT_DI_DISPATCH, dsT_DI_DISPATCH_CP, "copyHeader=yes,rowFrom="+dsT_DI_DISPATCH.RowPosition+",rowCnt=1");

            var url = "/hr/but/butb020.jsp?ORD_NO=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ORD_NO") + "&ENO_NO=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"PENO_NO") + "&APP_STATUS=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"APP_STATUS") + "&APP_CMT=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"APP_CMT");
			window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:710px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            fnc_SearchList();

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ؿ�����ǰ�ǰ���</td>
					<td align="right" class="navigator">HOME/���°���/�ؿ�����/<font color="#000000">�ؿ�����ǰ�ǰ���</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<col width="220"></col>
					<col width="80"></col>
					<col width="170"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">��&nbsp;&nbsp;��&nbsp;</td>
					<td>
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
					    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
					</td>
					<td class="searchState" align="right">���籸��&nbsp;</td>
					<td>
						<select id="cmbAPP_YN_SHR" style="width:100" onChange="fnc_SearchList();">
							<option value="" >��ü</option>
							<option value="Y" >����</option>
                            <option value="R" >�̰���</option>
						</select>
					</td>
					<td class="searchState" align="right">���±���&nbsp;</td>
					<td>
						<select id="cmbAPP_STATUS_SHR" style="width:100" onChange="fnc_SearchList();">
							<option value="" >��ü</option>
							<option value="1" >����</option>
                            <option value="2" >���</option>
                            <option value="3" >����̿Ϸ�</option>
                            <option value="4" >����Ϸ�</option>
                            <option value="5" >�ݼ�</option>
                            <option value="6" >�ΰ�</option>
                            <option value="7" >��ǥó���Ϸ�</option>
						</select>
					</td>
				</tr>
				<tr class="paddingTop5">
					<td class="searchState" align="right">�����&nbsp;</td>
					<td >
						<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength="9" onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
						<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="10" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
					</td>
					<td class="searchState" align="right">������&nbsp;</td>
					<td colspan="3">
						<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9" onChange="fnc_GetEnoNm('txtOUR_MAN_SHR', 'txtOUR_MAN_NM_SHR');">
						<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
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
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height="20">
						<td width="360" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td width="320">�ذ��縦 ���Ͻø� �ش� ����ǰ�Ǽ��� ����Ŭ�� �ϼ���.</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DISPATCH" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
						<param name="DataID" value="dsT_DI_DISPATCH">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=30	name="NO"			align=center	value={String(Currow)}		</C>
                            <C> id="ORD_NO"		width=80	name="ǰ�ǹ�ȣ"		align=center     </C>
                            <C> id="PENO_NO"	width=100	name="�����"		align=center    value={PJOB_NM&" "&PENO_NM}	</C>
							<C> id="ORD_DATE"	width=110	name="�����-�ð�"	align=center     </C>
							<C> id="APP_ENO_NO"	width=100	name="�ް���Ϸ���" align=center    value={APP_JOB_NM&" "&APP_ENO_NM}</C>
                            <C> id="APP_DATE"	width=110	name="������/�ð�"	align=center     </C>
							<C> id="APP_CMT"	width=250	name="�����ǰ�"	    align=left	     </C>
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
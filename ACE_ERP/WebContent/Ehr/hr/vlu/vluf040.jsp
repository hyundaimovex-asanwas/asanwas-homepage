<!--
*****************************************************
* @source       : vluf040.jsp
* @description : HRMS PAGE :: �������缭
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/16      ���뼺        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<!-- ������ �ʱ�ȭ ���� -->
<script>
	//Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�.
	var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}
</script>
<!-- ������ �ʱ�ȭ �� -->

<html>
<head>
<title><script>�������缭(vluf040)</script></title>
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
		
		var btnList = 'TTFTFFTT';
		var today = getToday();     //�ý��۳�¥
		var duty_stdt = '';         //�������� ������
		var duty_endt = '';			//�������� ������
		var selectedRow = 0;
		var url = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;	//��ȸ ��ȿ�� �˻�

			//���� ���缭 ���� ��ȸ
			dsT_EV_DUTYRSH.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf040.cmd.VLUF040CMD&S_MODE=SHR&DUTY_NO="+document.getElementById('cmbDUTY_NO_SHR').value;
			dsT_EV_DUTYRSH.reset();

			document.form1.grdT_EV_DUTYRST.focus();

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
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
			
			var duty_no = document.getElementById('cmbDUTY_NO_SHR');
			selectedRow = duty_no.selectedIndex + 1;
			duty_stdt = ds01T_EV_DUTYBAS.NameValue(selectedRow, 'DUTY_STDT');
			duty_endt = ds01T_EV_DUTYBAS.NameValue(selectedRow, 'DUTY_ENDT');
			
			if(dsT_EV_DUTYRSH.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

			if (today < duty_stdt || today > duty_endt) {
				alert(duty_no.value+"ȸ�� �������� �Ⱓ�� �ƴϹǷ� ������ �� �����ϴ�.");
				document.getElementById("resultMessage").innerText = '* ������ �� �����ϴ�.';
				duty_no.focus();
				return;
			}

			if(confirm("["+dsT_EV_DUTYRSH.NameValue(dsT_EV_DUTYRSH.RowPosition,'DUTY_NM')+"] �������缭�� �����Ͻðڽ��ϱ�?")){
				dsT_EV_DUTYRSH.DeleteRow(dsT_EV_DUTYRSH.RowPosition);
				trT_EV_DUTYRSH.KeyValue = "tr01(I:dsT_EV_DUTYRSH=dsT_EV_DUTYRSH)";
				trT_EV_DUTYRSH.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf040.cmd.VLUF040CMD&S_MODE=DEL";
				trT_EV_DUTYRSH.post();
			}

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			
			var duty_no = document.getElementById('cmbDUTY_NO_SHR');
			selectedRow = duty_no.selectedIndex + 1;
			duty_stdt = ds01T_EV_DUTYBAS.NameValue(selectedRow, 'DUTY_STDT');
			duty_endt = ds01T_EV_DUTYBAS.NameValue(selectedRow, 'DUTY_ENDT');
			
			if (today < duty_stdt || today > duty_endt) {
				alert(duty_no.value+"ȸ�� �������� �Ⱓ�� �ƴմϴ�.");
				document.getElementById("resultMessage").innerText = '* �������� �Ⱓ�� �ƴմϴ�.';
				duty_no.focus();
				return;
			}
			//���� �̵� ����� ���� ��ȸ
			dsT_EV_DUTYLST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf040.cmd.VLUF040CMD&S_MODE=SHR_01&DUTY_NO="+document.getElementById('cmbDUTY_NO_SHR').value;
			dsT_EV_DUTYLST.reset();

			document.form1.grdT_EV_DUTYRST.focus();

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

			dsT_EV_DUTYRSH.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {
			
//			if(document.getElementById('cmbDUTY_NO_SHR').value == ''){
//				alert('����ȸ���� ���� �ϼž� �մϴ�.');
//				document.getElementById('cmbDUTY_NO_SHR').focus();
//				return false;
//			}
			return true;
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_EV_DUTYRST,0,"false","right");      // Grid Style ����

            //���۽� ����ȸ���� �������� ���� VLUF020CMD�� ���
            ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
            ds01T_EV_DUTYBAS.Reset();
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

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : ds01T_EV_DUTYBAS                    |
    | 3. Table List : T_EV_DUTYBAS                  |
    +----------------------------------------------->
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							               |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_DUTYRSH)					   |
    | 3. ���Ǵ� Table List(T_EV_DUTYRSH, T_CM_DUTYMST)			   |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_DUTYRSH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------------------+
    | 1. ī�ǿ� DataSet												   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_DUTYRSH)					   |
    | 3. ���Ǵ� Table List(T_EV_DUTYRSH, T_CM_DUTYMST)			   |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_DUTYRSH_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet						   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_DUTYLST)	   |
    | 3. ���Ǵ� Table List(T_EV_DUTYLST)			   |
    +-------------------------------------------------->
    <Object ID="dsT_EV_DUTYLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_DUTYRSH)       |
    | 3. ���Ǵ� Table List(T_EV_DUTYRSH, T_EV_DUTYSUB)|
    +--------------------------------------------------->
    <Object ID ="trT_EV_DUTYRSH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_DUTYRSH)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {
            alert("���� ���� ������ ������ ȸ���� �����ϴ�.");
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			var i;
			var oOption;

			//�˻����� �޺��ڽ��� ����ȸ���� ����
			for(i=1; i <= iCount; i++){
	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO_SHR").add(oOption);
        	}
		
			document.form1.txtENO_NM.value = '<%=box.get("SESSION_ENONM")%>';
			document.form1.txtJOB_NM.value = '<%= box.get("SESSION_JOBNM")%>';
			document.form1.txtDPT_NM.value = '<%= box.get("SESSION_DPTNM")%>';

			document.form1.cmbDUTY_NO_SHR.focus();
        }
		
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=ds01T_EV_DUTYBAS Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYRSH Event="OnLoadCompleted(iCount)">

        if (iCount < 1) {

			fnc_Message(document.getElementById("resultMessage"), 'MSG_02');

        } else {

			fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
			
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYRSH Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

	<!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYLST Event="OnLoadCompleted(iCount)">

        if (iCount < 1) {

            alert("���� ���� ����ڰ� �ƴմϴ�.");
			document.getElementById("resultMessage").innerText = '* �������� ����ڰ� �ƴմϴ�.';

        } else {

			url = "/hr/vlu/vluf041.jsp?HEAD_NM="+ds01T_EV_DUTYBAS.NameValue(1,'HEAD_NM')+"&TITLE=�������缭_���&SHOW=YES";
			
			dsT_EV_DUTYRSH_CP.setDataHeader("GUBUN:STRING, DUTY_NO:INT, DUTY_YMD:STRING, DUTY_CD:STRING, DUTY_NM:STRING, SEC_CD:STRING, SEC_NM:STRING, THR_CD:STRING, THR_NM:STRING, DUTY_OBJ:STRING, SCH_LBL:STRING");

			window.showModalDialog(url, dsT_EV_DUTYRSH_CP, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			fnc_SearchList();
			
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYLST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_DUTYRSH event="OnSuccess()">
		fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_DUTYRSH event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_EV_DUTYRST event="OnDblClick(row,colid)">
		
		if(row < 1) {
			return;
		} else {
			var duty_no = document.getElementById('cmbDUTY_NO_SHR');
			selectedRow = duty_no.selectedIndex + 1;
			duty_stdt = ds01T_EV_DUTYBAS.NameValue(selectedRow, 'DUTY_STDT');
			duty_endt = ds01T_EV_DUTYBAS.NameValue(selectedRow, 'DUTY_ENDT');
			
			if (today < duty_stdt || today > duty_endt) {
				url = "/hr/vlu/vluf041.jsp?HEAD_NM="+ds01T_EV_DUTYBAS.NameValue(1,'HEAD_NM')+"&TITLE=�������缭_��";
			} else {
				url = "/hr/vlu/vluf041.jsp?HEAD_NM="+ds01T_EV_DUTYBAS.NameValue(1,'HEAD_NM')+"&TITLE=�������缭_���";
			}
			//���õ� ROW�� dsT_EV_DUTYRSH_CP�� �����Ͽ� Modalâ�� dsT_EV_DUTYRSH_CP�� �Ѱ��ش�.
			cfCopyDataSet(dsT_EV_DUTYRSH, dsT_EV_DUTYRSH_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

			window.showModalDialog(url, dsT_EV_DUTYRSH_CP, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			fnc_SearchList();
		}

	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������缭</td>
					<td align="right" class="navigator">HOME/�λ���/��������/��������/<font color="#000000">�������缭</td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="75"></col>
                                <col width="100"></col>
                                <col width="60"></col>
                                <col width="100"></col>
                                <col width="60"></col>
                                <col width="100"></col>
                                <col width="60"></col>
                                <col width="100"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="center" class="searchState">����ȸ��</td>
								<td width="50">
									<select id="cmbDUTY_NO_SHR" name="cmbDUTY_NO_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
									</select>
								</td>
                                <td align="right" class="searchState">�μ�&nbsp;</td>
                                <td class="padding2423">
    	                            <input name=txtDPT_NM size="15" class="input_ReadOnly" readOnly>
                                </td>
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
    	                            <input name=txtJOB_NM size="10" class="input_ReadOnly" readOnly>
                                </td>
                                <td align="right" class="searchState">�ۼ���&nbsp;</td>
                                <td class="padding2423">
	                                <input name=txtENO_NM size="10" class="input_ReadOnly" readOnly>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_DUTYRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:370px;">
                            <param name="DataID"                  value="dsT_EV_DUTYRSH">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='DUTY_NO'		width=90		name='����ȸ��'		align=center </C>
                                <C> id='DUTY_YMD'		width=150		name='�ۼ���'		align=center </C>
                                <C> id='THR_NM'			width=180		name='����'			align=left </C>
                                <C> id='SEC_NM'			width=180		name='����'			align=left </C>
                                <C> id='DUTY_NM'		width=180		name='����'			align=left </C>
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

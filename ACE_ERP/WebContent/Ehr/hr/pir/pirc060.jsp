<!--
***********************************************************************
* @source      : pirc060.jsp
* @description : �λ�����������û PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/21      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�λ�����������û(pirc060)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TTTTTFTT';

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
            var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
            var sts_gbn1 = "";
            var sts_gbn3 = "";
            if(document.getElementById('chkSTS_GBN_SHR1').checked){
                sts_gbn1 = "1";
            }

            if(document.getElementById('chkSTS_GBN_SHR3').checked){
                sts_gbn3 = "3";
            }

            if(!fnc_SearchCheck()) return;  //��ȸ ��ȿ�� �˻�

			dsT_CM_UPRQST.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc060.cmd.PIRC060CMD&S_MODE=SHR_02&ENO_NO="+eno_no+"&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&STS_GBN1="+sts_gbn1+"&STS_GBN3="+sts_gbn3;
    		dsT_CM_UPRQST.reset();

        }

        /**
        * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
        */
        function fnc_ClickEmpPopup() {
        	fnc_emplPopup("txtENO_NO");

        	if (document.getElementById("txtENO_NO").value  != "") {
        		fnc_SearchEmpNo();
        	}
        }

        /**
        * ��� ������ ��ȸ �Ѵ�.
        * ��������� �˻�
        */
        function fnc_SearchEmpNm() {
        	//����� ã�ƿ��� �� ���� ��������
        	fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
        	fnc_SearchEmpNo();
        }

        /**
        * ��������� ��ȸ �Ѵ�.
        * ������� �˻�
        */
        function fnc_SearchEmpNo() {
        	var obj = new String;

        	// ������ ��ü
        	obj = fnc_GetEnoNm("txtENO_NO");
        	//fnc_ClearInputFieldAll(new Array("txtENO_NO", "txtENO_NM", "txtDPT_NM", "txtJOB_NM"));
        	if(document.getElementById("txtENO_NO").value != "") {

        		document.getElementById("txtENO_NO").value = obj.eno_no;
        		document.getElementById("txtENO_NM").value = obj.eno_nm;
        		document.getElementById("txtDPT_NM").value = obj.dpt_nm;
        		document.getElementById("txtJOB_NM").value = obj.job_nm;
        	} else {
        		document.getElementById("txtENO_NO").value = "";
        		document.getElementById("txtENO_NM").value = "";
        		document.getElementById("txtDPT_NM").value = "";
        		document.getElementById("txtJOB_NM").value = "";
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

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

            trT_CM_UPRQST.KeyValue = "tr01(I:dsT_CM_UPRQST=dsT_CM_UPRQST)";
			trT_CM_UPRQST.action = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc060.cmd.PIRC060CMD&S_MODE=SAV";
			trT_CM_UPRQST.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_CM_UPRQST.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
            //ó����Ȳ�� ��û�� �ƴѰ��� ���� �� �� ����
            if(dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition,'STS_GBN') != '1'){
                alert("ó�����̰ų� �Ϸ�� �����ʹ� ������ �� �����ϴ�!");
                return;
            }
			if(confirm("[�Ϸù�ȣ:"+dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition,'SEQ_NO')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_CM_UPRQST.DeleteRow(dsT_CM_UPRQST.RowPosition);
				trT_CM_UPRQST.KeyValue = "tr01(I:dsT_CM_UPRQST=dsT_CM_UPRQST)";
				trT_CM_UPRQST.action = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc060.cmd.PIRC060CMD&S_MODE=DEL";
				trT_CM_UPRQST.post();
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

			if (dsT_CM_UPRQST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_UPRQST.GridToExcel("��������������û", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			dsT_CM_UPRQST_SEQ.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc060.cmd.PIRC060CMD&S_MODE=SHR_01";
    		dsT_CM_UPRQST_SEQ.reset();

            //DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_CM_UPRQST.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_CM_UPRQST.setDataHeader("SEQ_NO:STRING:KEYVALUE, ENO_NO:STRING:KEYVALUE, ENO_NM:STRING, OCC_NM:STRING, JOB_NM:STRING, DPT_NM:STRING, UPDATE_TXT:STRING, WORK_GBN:STRING, STS_GBN:STRING, REPLY_TXT:STRING");
			}

            dsT_CM_UPRQST.AddRow();
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'SEQ_NO') = dsT_CM_UPRQST_SEQ.NameValue(1,'SEQ_NO');
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'ENO_NO') = dsT_CM_UPRQST_SEQ.NameValue(1,'ENO_NO');
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'ENO_NM') = dsT_CM_UPRQST_SEQ.NameValue(1,'ENO_NM');
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'OCC_NM') = dsT_CM_UPRQST_SEQ.NameValue(1,'OCC_NM');
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'JOB_NM') = dsT_CM_UPRQST_SEQ.NameValue(1,'JOB_NM');
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'DPT_NM') = dsT_CM_UPRQST_SEQ.NameValue(1,'DPT_NM');
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'STS_GBN') = "1";
            dsT_CM_UPRQST.NameValue(dsT_CM_UPRQST.RowPosition, 'WORK_GBN') = "1";

            document.getElementById("txtUPDATE_TXT").focus();
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


<%
    //�����ڰ� �ƴϸ� �˻� ������ ����
    if(!box.get("SESSION_ROLE_CD").equals("1001")
            && !box.get("SESSION_ROLE_CD").equals("1002")) {
%>
            document.getElementById('txtENO_NO_SHR').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtENO_NM_SHR').value = '<%=box.get("SESSION_ENONM")%>';
<%
    }
%>

            document.getElementById('chkSTS_GBN_SHR1').checked = true;
            document.getElementById('chkSTS_GBN_SHR3').checked = true;
			document.getElementById("resultMessage").innerText = ' ';



  	        fnc_DisableElementAll(elementList);

			dsT_CM_UPRQST.ClearData();

            document.getElementById('txtSTR_YMD_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
	            if (dsT_CM_UPRQST.IsUpdated)  {
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
        function fnc_SearchCheck() {

            var str_ymd = document.getElementById('txtSTR_YMD_SHR');
            var end_ymd = document.getElementById('txtEND_YMD_SHR');
            var sts_gbn1 = document.getElementById('chkSTS_GBN_SHR1');
            var sts_gbn3 = document.getElementById('chkSTS_GBN_SHR3');

            if(str_ymd.value == "" && end_ymd.value == ""){
                alert("��ȸ�Ⱓ�� �Է��ϼ���!");
                str_ymd.focus();
                return false;
            }

            if(sts_gbn1.checked == false && sts_gbn3.checked == false){
                alert("ó���ܰ� �� ��� �ϳ� �̻��� �ݵ�� �����ϼž� �մϴ�!");
                sts_gbn1.checked = true;
                return false;
            }

            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_CM_UPRQST.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            document.getElementById('txtSTR_YMD_SHR').value = getStrDate();
            document.getElementById('txtEND_YMD_SHR').value = getToday();


<%
    //�����ڰ� �ƴϸ� �˻� ������ ����
    if(!box.get("SESSION_ROLE_CD").equals("1001")
            && !box.get("SESSION_ROLE_CD").equals("1002")) {
%>
            document.getElementById('txtENO_NO_SHR').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtENO_NM_SHR').value = '<%=box.get("SESSION_ENONM")%>';

            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
            document.getElementById("ImgEnoNoShr").style.display = "none";
<%
    }
%>

            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_CM_UPRQST,15,"false","false");      // Grid Style ����

            document.getElementById('txtSTR_YMD_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        var elementList = new Array( "txtSEQ_NO"
                                    ,"txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"txtJOB_NM"
                                    ,"txtDPT_NM"
                                    ,"cmbWORK_GBN"
                                    ,"cmbSTS_GBN"
                                    ,"txtUPDATE_TXT"
                                    ,"txtREPLY_TXT"
                                    ,"ImgEnoNo");

        var keyList = new Array(     "txtENO_NO"
                                    ,"txtUPDATE_TXT" );
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_UPRQST)   |
    | 3. ���Ǵ� Table List(T_CM_UPRQST)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_UPRQST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_UPRQST)   |
    | 3. ���Ǵ� Table List(T_CM_UPRQST)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_UPRQST_SEQ" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_CM_UPRQST)	    |
    | 3. ���Ǵ� Table List(T_CM_UPRQST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CM_UPRQST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_UPRQST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_UPRQST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_UPRQST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';

		//Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_UPRQST_SEQ Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_UPRQST_SEQ Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_UPRQST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_UPRQST event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script language="javascript"  for=dsT_CM_UPRQST event=OnRowPosChanged(row)>
        if(row > 0) {

        	var oSTS_GBN = document.getElementById('cmbSTS_GBN').value;
            fnc_DisableElementAll(elementList);

            // ó���ܰ谡 ��û����(1)�̰ų� �ű��Է�(1)�� ��츸 �������� ���� ����.
            if(oSTS_GBN == "1" || dsT_CM_UPRQST.RowStatus(row) == "1") {
                fnc_ChangeStateElement(true, "cmbWORK_GBN");
                fnc_ChangeStateElement(true, "txtUPDATE_TXT");

                if("<%=box.get("SESSION_ROLE_CD") %>" == "1001"
                        || "<%=box.get("SESSION_ROLE_CD") %>" == "1002") {
                    fnc_ChangeStateElement(true, "txtENO_NO");
                    fnc_ChangeStateElement(true, "txtENO_NM");
                    fnc_ChangeStateElement(true, "ImgEnoNo");
                }
            }

            // �������� ���
            if(oSTS_GBN == "1"
                    && dsT_CM_UPRQST.RowStatus(row) != "1"
                    && ("<%=box.get("SESSION_ROLE_CD") %>" == "1001"
                            || "<%=box.get("SESSION_ROLE_CD") %>" == "1002")) {
                fnc_ChangeStateElement(true, "cmbSTS_GBN");
                fnc_ChangeStateElement(true, "txtREPLY_TXT");
            }

        }
     </script>

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_CM_UPRQST event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_CM_UPRQST.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_CM_UPRQST.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�λ�����������û</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">�λ�����������û</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="60"></col>
									<col width="220"></col>
                                    <col width="60"></col>
                                    <col width="180"></col>
                                    <col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">��ȸ�Ⱓ&nbsp;</td>
								<td class="padding2423">
									<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','10','110');"></a> ~
									<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','110');"></a>
								</td>
                                <td align="right" class="searchState">�� ��&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                                </td>
                                <td align="right" class="searchBold">ó���ܰ�&nbsp;</td>
								<td class="padding2423">
                                    <input type="checkbox" id="chkSTS_GBN_SHR1" style="border:none" checked>��û
                                    <input type="checkbox" id="chkSTS_GBN_SHR3" style="border:none" checked>�Ϸ�
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="85"></col>
                    <col width="100"></col>
                    <col width="85"></col>
                    <col width="100"></col>
                    <col width="85"></col>
                    <col width="100"></col>
                    <col width="85"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtDPT_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" style="width:70%" class="input_ReadOnly" readonly onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" style="width:100" class="input_ReadOnly" readonly onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�Ϸù�ȣ</td>
                    <td class="padding2423">
                        <input id="txtSEQ_NO" style="width:100%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" colspan="1">
                        <select id="cmbWORK_GBN" style="width:100%">
                            <option value="1">�⺻����</option>
                            <option value="2">��������</option>
                            <option value="3">�Ի��� ���</option>
                            <option value="4">�ǰ�����</option>
                            <option value="5">�ڰݸ���</option>
                            <option value="6">��ȸ����</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">ó���ܰ�</td>
                    <td class="padding2423" colspan="3">
                        <select id="cmbSTS_GBN" style="width:100">
                            <option value="1">�� û</option>
                            <option value="3">�� ��</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" colspan="7">
                        <input id="txtUPDATE_TXT" style="width:100%" onKeyUp="fc_chk_byte(this,200)">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423" colspan="7">
                        <input id="txtREPLY_TXT" style="width:100%" onKeyUp="fc_chk_byte(this,100)">
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
						<object	id="grdT_CM_UPRQST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:285px;">
							<param name="DataID"					value="dsT_CM_UPRQST">
                            <param name="Format"					value="
								<C> id={currow}		width=40    name='����'		align=center </C>
								<C> id='SEQ_NO'	    width=80	name='�Ϸù�ȣ'	align=center </C>
                                <C> id='DPT_NM' 	width=80	name='�Ҽ�'	    align=left </C>
								<C> id='JOB_NM'	    width=55	name='����'	    align=center </C>
								<C> id='ENO_NO'	    width=70	name='���'		align=center </C>
								<C> id='ENO_NM' 	width=70	name='����'		align=center </C>
                                <C> id='WORK_GBN'	width=80	name='��������'	align=center Editstyle=combo	data='1:�⺻����,2:��������,3:�Ի��� ���,4:�ǰ�����,5:�ڰݸ���,6:��ȸ����' </C>
                                <C> id='STS_GBN'	width=60	name='ó���ܰ�'	align=center Editstyle=combo	data='1:��û,2:Ȯ��,3:�Ϸ�' </C>
								<C> id='UPDATE_TXT'	width=500	name='��������'	align=left </C>
                                <C> id='REPLY_TXT'	width=120	name='���'	    align=left </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
    <tr>
       <td>
          <br><b>&nbsp;&nbsp;<u>�� ����/�ڰݻ��� ������ ��û�Ͻô� ���� ����ڿ��� ���ü��� �纻�� ��ĵ�Ͽ� �����ֽñ� �ٶ��ϴ�.(�λ��� �̻� ����[��3691 / sm2@hdasan.com]</u></b>
       </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>

<!-- �������� ������û ���̺� -->
<object id="bndT_CM_UPRQST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_UPRQST">
    <Param Name="BindInfo", Value='
        <C> Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value   Disable=disabled</C>
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value   Disable=disabled</C>
        <C> Col=ENO_NM       Ctrl=txtENO_NM       Param=value   Disable=disabled</C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value   Disable=disabled</C>
        <C> Col=DPT_NM       Ctrl=txtDPT_NM       Param=value   Disable=disabled</C>
        <C> Col=WORK_GBN     Ctrl=cmbWORK_GBN     Param=value   Disable=disabled</C>
        <C> Col=STS_GBN      Ctrl=cmbSTS_GBN      Param=value   Disable=disabled</C>
        <C> Col=UPDATE_TXT   Ctrl=txtUPDATE_TXT   Param=value   Disable=disabled</C>
        <C> Col=REPLY_TXT    Ctrl=txtREPLY_TXT    Param=value   Disable=disabled</C>
    '>
</object>
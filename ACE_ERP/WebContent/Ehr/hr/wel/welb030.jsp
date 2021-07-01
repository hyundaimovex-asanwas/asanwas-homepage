<!--
***********************************************************************
* @source      : welb030.jsp
* @description : �ӿ���������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/07      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%

    String ROLE_CD = box.getString("SESSION_ROLE_CD");


    //ROLE_CD�� IT���� ����
    boolean itMaster = false;

    if(ROLE_CD.equals("1001")) {
    	itMaster = true;
    }

%>
<html>
<head>
<title>�ӿ����������(welb030)</title>
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

		var btnList = 'TTTTFFTT';
		var emp_Sbutton = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var eno_no = document.getElementById('txtENO_NO_SHR').value;
			var phn_no = document.getElementById('txtPHN_NO_SHR').value;
			var name_gbn = document.getElementById('cmbNAME_GBN_SHR').value;
			var chk_data;


            if(document.getElementById('chkCHK_DATA').checked) {
                chk_data = "1";
            } else {
                chk_data = "";
            }

			dsT_WL_HDPCLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb030.cmd.WELB030CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PHN_NO="+phn_no+"&NAME_GBN="+name_gbn+"&CHK_DATA="+chk_data;
    		dsT_WL_HDPCLIST.reset();

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

				trT_WL_HDPCLIST.KeyValue = "tr01(I:dsT_WL_HDPCLIST=dsT_WL_HDPCLIST)";
				trT_WL_HDPCLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb030.cmd.WELB030CMD&S_MODE=SAV";
				trT_WL_HDPCLIST.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_HDPCLIST.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[����:"+dsT_WL_HDPCLIST.NameValue(dsT_WL_HDPCLIST.RowPosition,'ENO_NM')+"/�޴�����ȣ:"+dsT_WL_HDPCLIST.NameValue(dsT_WL_HDPCLIST.RowPosition,'PHN_NO')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_WL_HDPCLIST.DeleteRow(dsT_WL_HDPCLIST.RowPosition);

				trT_WL_HDPCLIST.KeyValue = "tr01(I:dsT_WL_HDPCLIST=dsT_WL_HDPCLIST)";
				trT_WL_HDPCLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb030.cmd.WELB030CMD&S_MODE=DEL";
				trT_WL_HDPCLIST.post();
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

			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_WL_HDPCLIST.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_WL_HDPCLIST.setDataHeader("PHN_NO:STRING, NAME_GBN:STRING, ENO_NO:STRING, ENO_NM:STRING, JOB_CD:STRING, REMARK:STRING, STR_YMD:STRING, END_YMD:STRING");
			}

			dsT_WL_HDPCLIST.AddRow();

			document.getElementById('txtPHN_NO').focus();

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

			document.getElementById('txtENO_NO_SHR').value = '';
			document.getElementById('txtPHN_NO_SHR').value = '';
        	document.getElementById('cmbNAME_GBN_SHR').value = '';

			dsT_WL_HDPCLIST.ClearData();

		}

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_HDPCLIST.IsUpdated)  {

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

			if (!dsT_WL_HDPCLIST.IsUpdated ) {
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
            fnc_DisableElementAll(elementList);
			cfStyleGrid(form1.grdT_WL_HDPCLIST,15,"false","false");      // Grid Style ����

            document.getElementById('txtPHN_NO_SHR').focus();
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*****************************
         * 16. ������� ��ȸ�� �˾�  *
         *****************************/
		function fnc_emplPopup_this(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06) {

			var obj = new String();

			obj.eno_nm = "";

			window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(ctrl_01 != undefined && ctrl_01 != "" && obj.eno_no.trim() != ""){
  				document.getElementById(ctrl_01).value = obj.eno_no;
 			}
			if(ctrl_02 != undefined && ctrl_02 != "" && obj.eno_nm.trim() != ""){
 				document.getElementById(ctrl_02).value = obj.eno_nm;
			}
			if(ctrl_03 != undefined && ctrl_03 != "" && obj.dpt_cd.trim() != ""){
 				document.getElementById(ctrl_03).value = obj.dpt_cd;
			}
			if(ctrl_04 != undefined && ctrl_04 != "" && obj.dpt_nm.trim() != ""){
  				document.getElementById(ctrl_04).value = obj.dpt_nm;
 			}
			if(ctrl_05 != undefined && ctrl_05 != "" && obj.job_cd.trim() != ""){
 				document.getElementById(ctrl_05).value = obj.job_cd;
			}
			if(ctrl_06 != undefined && ctrl_06 != "" && obj.job_nm.trim() != ""){
  				document.getElementById(ctrl_06).value = obj.job_nm;
 			}

		}

        /**********************************
         * 17. ������� ���������ȸ ó�� *
         *********************************/
        function fnc_UserGetEnoNm() {

            var obj = new String();

            obj = fnc_GetEnoNm("txtENO_NO");

            document.getElementById("txtENO_NM").value = obj.eno_nm;

            document.getElementById("cmbJOB_CD").value = obj.job_cd;

        }

        var elementList = new Array( "txtPHN_NO"
                                    ,"rdoNAME_GBN"
                                    ,"txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"txtREMARK"
                                    ,"txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"imgSTR_YMD"
                                    ,"imgEND_YMD"
                                    );

        var exceptionList = new Array(
                                     "txtPHN_NO"
                                    ,"rdoNAME_GBN"
                                    ,"txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"txtSTR_YMD"
                                    ,"imgSTR_YMD"
                                      );

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

            if(obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtJOB_CD").value      = obj.job_cd;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtJOB_CD").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_HDPCLIST) |
    | 3. ���Ǵ� Table List(T_WL_HDPCLIST)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_HDPCLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_HDPCLIST)	|
    | 3. ���Ǵ� Table List(T_WL_HDPCLIST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_HDPCLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_HDPCLIST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_HDPCLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_HDPCLIST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�޴�����ȣ, ���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
//	        alert("�ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_HDPCLIST event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_HDPCLIST event="OnFail()">
        cfErrorMsg(this);
    </script>



    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_HDPCLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(row > 0) {
            if(dsT_WL_HDPCLIST.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
                rdoNAME_GBN.Enable = true;
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
                rdoNAME_GBN.Enable = false;
            }
        }
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ, ��ȿ�� �˻�
    +------------------------------------------------------>
      <script language=JavaScript for=dsT_WL_HDPCLIST event=CanRowPosChange(row)>

        if ( dsT_WL_HDPCLIST.NameValue(row,"ENO_NO") == "" ) {
            alert("[ ��� ]�� �ʼ� �Է»����Դϴ�");
            return false;
        } else if ( dsT_WL_HDPCLIST.NameValue(row,"PHN_NO") == "" ) {
            alert("[ �޴�����ȣ ]�� �ʼ� �Է»����Դϴ�");
            return false;
        } else if ( dsT_WL_HDPCLIST.NameValue(row,"NAME_GBN") == "" ) {
            alert("[ �� �� ]�� �ʼ� �Է»����Դϴ�");
            return false;
        } else if ( dsT_WL_HDPCLIST.NameValue(row,"STR_YMD") == "" ) {
            alert("[ ������ ]�� �ʼ� �Է»����Դϴ�");
            return false;
        }

        //���� ���� �϶��� �ݵ�� ����� ���� ��
        if(dsT_WL_HDPCLIST.NameValue(row,"NAME_GBN") == "2"
                && dsT_WL_HDPCLIST.NameValue(row,"ENO_NO") == "") {
            alert("[ ���θ��� ] �϶� [ �� �� ]�� �ʼ� �Է»����Դϴ�");
            return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ӿ����������</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�޴�������/<font color="#000000">�ӿ����������</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
<%
    if(itMaster){
%>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<%
    }
%>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="90"></col>
                                    <col width="70"></col>
                                    <col width="60"></col>
                                    <col width="60"></col>
                                    <col width="60"></col>
                                    <col width="170"></col>
                                    <col width="150"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="center" class="searchState">�޴�����ȣ&nbsp;</td>
                                <td class="padding2423"><input id="txtPHN_NO_SHR" size="15" maxlength="15" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber();"  style="ime-mode:disabled"></td>
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbNAME_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
                                        <option value=''>�� ü</option>
                                        <option value='1'>�� ��</option>
                                        <option value='2'>�� ��</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�� ��&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                                </td>

                                <td align="right" class="searchState">��ȿ������(���ϱ���)&nbsp;</td>
                                <td class="padding2423">
                                    <input type="checkbox" name="chkCHK_DATA" value="1">
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
					<col width="60"></col>
					<col width="180"></col>
                    <col width="60"></col>
                    <col width="70"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>

                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input type=hidden id="txtJOB_CD">
                        <input id="txtJOB_NM" size="18" class="input_ReadOnly" readonly>
                    </td>

					<td align="center" class="creamBold">�޴�����ȣ</td>
					<td class="padding2423">
                        <input id="txtPHN_NO" size="15" maxlength="15" onkeypress="cfCheckNumber()"  style="ime-mode:disabled">
                    </td>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <comment id="__NSID__">
						<object id=rdoNAME_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:20; width:100">
							<param name=AutoMargin	value="false">
							<param name=DataID      value="dsT_WL_HDPCLIST">
							<param name=CodeColumn  value="NAME_GBN">
							<param name=Cols		value="2">
							<param name=Format	value="1^����,2^����">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
					<td class="padding2423" colspan="3">
                        <input id="txtSTR_YMD" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YMD','','5','115');"></a>
                         ~
                        <input id="txtEND_YMD" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YMD','','100','115');"></a>
                    </td>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423" colspan="3">
                        <input id="txtREMARK" size="30" maxlength="30" onKeyUp="fc_chk_byte(this,30)">
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
						<object	id="grdT_WL_HDPCLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"					value="dsT_WL_HDPCLIST">
							<param name="Format"					value="
								<C> id={currow}		width=50    name='NO'			align=center </C>
                                <C> id='JOB_NM'     width=100   name='����'           align=left  </C>
                                <C> id='ENO_NO'     width=100   name='���'           align=center </C>
                                <C> id='ENO_NM'     width=100   name='����'           align=center </C>
                                <C> id='NM_GBN_VAL' width=90    name='����'           align=center    Value={Decode(NAME_GBN,'1','���θ���','2','���θ���')}</C>
								<C> id='PHN_NO'		width=140	name='�޴�����ȣ'	align=left </C>
								<C> id='REMARK'		width=185	name='���'			align=left </C>
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
<!-- ���� ���θ��� �������� �ڵ��� ���� ���̺� -->
<object id="bndT_WL_HDPCLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_HDPCLIST">
	<Param Name="BindInfo", Value='
		<C>Col=PHN_NO		Ctrl=txtPHN_NO	     	Param=value		</C>
		<C>Col=NAME_GBN		Ctrl=rdoNAME_GBN     	Param=value		</C>
		<C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		</C>
		<C>Col=ENO_NM    	Ctrl=txtENO_NM	     	Param=value		</C>
		<C>Col=JOB_CD		Ctrl=txtJOB_CD	     	Param=value		</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM	     	Param=value		</C>
		<C>Col=REMARK		Ctrl=txtREMARK	     	Param=value		</C>
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD         Param=value     </C>
        <C>Col=END_YMD      Ctrl=txtEND_YMD         Param=value     </C>
    '>
</object>
<!--
***********************************************************************
* @source      : crua060.jsp
* @description : ���������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/12      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����������(crua060)</title>
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

		var btnList = 'TFTTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;

			var pis_yy   = document.getElementById("txtPIS_YY_SHR").value;
			var seq_no   = document.getElementById("txtSEQ_NO_SHR").value;
            var reg_no  = document.getElementById("txtREG_NO_SHR").value;
            var eno_nm  = document.getElementById("txtENO_NM_SHR").value;
            var cd_gbn  = document.getElementById("cmbCD_GBN_SHR").value;
            var pnt     = document.getElementById("txtPNT_SHR").value;
            var ud_gbn  = document.getElementById("cmbUD_GBN_SHR").value;

            //ä�� ���� ����Ʈ ��ȸ
            dsT_RC_HISTORY.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua040.cmd.CRUA040CMD&S_MODE=SHR2&PIS_YY="+pis_yy+"&SEQ_NO="+seq_no;
            dsT_RC_HISTORY.reset();

            //������ ����Ʈ ��ȸ
			dsT_RC_ADDPOINT.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua060.cmd.CRUA060CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&SEQ_NO="+seq_no+"&REG_NO="+reg_no+"&ENO_NM="+eno_nm+"&CD_GBN="+cd_gbn+"&PNT="+pnt+"&UD_GBN="+ud_gbn;
    		dsT_RC_ADDPOINT.reset();

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

				trT_RC_ADDPOINT.KeyValue = "tr01(I:dsT_RC_ADDPOINT=dsT_RC_ADDPOINT)";
				trT_RC_ADDPOINT.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua060.cmd.CRUA060CMD&S_MODE=SAV";
				trT_RC_ADDPOINT.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            document.getElementById("txtREG_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("cmbCD_GBN_SHR").value = "";
            document.getElementById("txtPNT_SHR").value = "";
            document.getElementById("cmbUD_GBN_SHR").value = "U";
			document.getElementById("resultMessage").innerText = ' ';

			dsT_RC_ADDPOINT.ClearData();
            dsT_RC_HISTORY.ClearData();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_RC_ADDPOINT.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			var year = document.getElementById("txtPIS_YY_SHR");
			var seq = document.getElementById("txtSEQ_NO_SHR");

            if(year == "" || year.value.length < 4){
                alert("4�ڸ��� ä��⵵�� �ݵ�� �Է��ϼž� �մϴ�!");
                year.focus();
                return false;
            }
            if(seq == "" || seq.value.length < 2) {
                alert("2�ڸ��� ������ �ݵ�� �Է��ϼž� �մϴ�!");
                seq.focus();
                return false;
            }

			return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_RC_ADDPOINT.IsUpdated ) {
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
            fnc_DisableElementAll(pntList);

            document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4);
			document.getElementById("txtSEQ_NO_SHR").value = "01";

			cfStyleGrid(form1.grdT_RC_ADDPOINT,15,"false","right");      // Grid Style ����

            document.getElementById('txtPIS_YY_SHR').focus();

            fnc_SearchList();
                form1.grdT_RC_ADDPOINT.ColumnProp("{currow}", "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("PIS_YY"  , "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("SEQ_NO"  , "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("REG_NO"  , "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("ENO_NM"  , "Sort") = "false";

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        //������ �׸� ����Ʈ
        var pntList = new Array(     "txtSCH_PNT"
                                    ,"txtUYMD_PNT"
                                    ,"txtTAVE_PNT"
                                    ,"txtAWDYN_PNT"
                                    ,"txtTOEIC_PNT"
                                    ,"txtHSK_PNT"
                                    ,"txtJPT_PNT"
                                    ,"txtLICENCE_PNT"
                                    ,"txtMILYN_PNT"
                                    ,"txtETC_PNT" );

        var exceptionList = new Array();

        /**
         * ������ ���
         */
		function fnc_TotalPNT(pnt) {
            var tot_pnt = 0;

            for(var i=0; i<pntList.length; i++) {
                tot_pnt += fnc_covNumber(document.getElementById(pntList[i]).value);
            }
            document.getElementById("txtTOTAL_PNT").value = tot_pnt;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_RC_ADDPOINT) |
    | 3. ���Ǵ� Table List(T_RC_ADDPOINT)		     |
    +------------------------------------------------>
    <Object ID="dsT_RC_ADDPOINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                                |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_RC_HISTORY)  |
    | 3. ���Ǵ� Table List(T_RC_HISTORY)          |
    +----------------------------------------------->
    <Object ID="dsT_RC_HISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_RC_ADDPOINT)	|
    | 3. ���Ǵ� Table List(T_RC_ADDPOINT)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_ADDPOINT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_RC_ADDPOINT)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_RC_ADDPOINT Event="OnLoadCompleted(iCount)">

        document.getElementById("txtPIS_YY").value = document.getElementById("txtPIS_YY_SHR").value;
		document.getElementById("txtSEQ_NO").value = document.getElementById("txtSEQ_NO_SHR").value;

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_RC_ADDPOINT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_ADDPOINT Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���̵�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[ä��⵵/����/���̵�]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_RC_ADDPOINT event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_RC_ADDPOINT event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_RC_ADDPOINT event=OnRowPosChanged(row)>
        fnc_DisableElementAll(pntList);

        if(row > 0) {
            //ä�������� �����ɻ���� �Ϸ� �϶��� ������ ������ ������
            if(dsT_RC_HISTORY.NameString(0, "PRO_STS") == "2") {
                fnc_EnableElementAll(pntList);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������</td>
					<td align="right" class="navigator">HOME/��������/ä�����/<font color="#000000">����������</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
								<col width="80"></col>
								<col width="110"></col>
								<col width="80"></col>
								<col width="60"></col>
                                <col width="80"></col>
								<col width="60"></col>
                                <col width="80"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">ä��⵵&nbsp;</td>
								<td class="padding2423">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>
								</td>
								<td align="center" class="searchState">ä������&nbsp;</td>
								<td class="padding2423">
									<input id="txtSEQ_NO_SHR" size="4" maxLength="2" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfNumberCheck();">
								</td>
                                <td align="center" class="searchState">�����ȣ</td>
                                <td class="padding2423"><input id="txtREG_NO_SHR" size="15" maxLength="11" style="ime-mode:disabled;" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"></td>
                                <td align="center" class="searchState">�� ��</td>
                                <td class="padding2423"><input id="txtENO_NM_SHR" size="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onkeyup="fc_chk_byte(this,40);"></td>
							</tr>
                            <tr>
                                <td align="center" class="searchState">������ ����</td>
                                <td class="padding2423">
                                    <select id="cmbCD_GBN_SHR" style="WIDTH: 100%">
                                        <option value="">�� ��</option>
                                        <option value="SCH_PNT">�з°�����</option>
                                        <option value="UYMD_PNT">�������������</option>
                                        <option value="TAVE_PNT">����������</option>
                                        <option value="AWDYN_PNT">���ƴ�󰡻���</option>
                                        <option value="TOEIC_PNT">���Ͱ�����</option>
                                        <option value="HSK_PNT">HSK������</option>
                                        <option value="JPT_PNT">JPT������</option>
                                        <option value="LICENCE_PNT">�ڰ���������</option>
                                        <option value="MILYN_PNT">����������</option>
                                        <option value="ETC_PNT">��Ÿ������</option>
                                    </select>
                                </td>
								<td align="center" class="padding2423">
									<input id="txtPNT_SHR" size="3" maxLength="3" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfNumberCheck();">��
								</td>
                                <td align="center" class="padding2423">
									<select id="cmbUD_GBN_SHR" style="WIDTH: 100%">
                                        <option value="U">�� ��</option>
                                        <option value="D">�� ��</option>
                                    </select>
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
					<col width="100"></col>
					<col width="35"></col>
					<col width="100"></col>
					<col width="35"></col>
					<col width="100"></col>
					<col width="60"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">ä��⵵</td>
					<td class="padding2423"><input id="txtPIS_YY" size="11" class="input_ReadOnly" readOnly></td>
					<td align="center" class="creamBold">��  ��</td>
					<td class="padding2423"><input id="txtSEQ_NO" size="4" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">�����ȣ</td>
					<td class="padding2423"><input id="txtREG_NO" size="11" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">�� ��</td>
					<td class="padding2423"><input id="txtENO_NM" size="10" class="input_ReadOnly" readOnly></td>
                </tr>
                <tr>
					<td align="center" class="creamBold">�з°�����</td>
					<td class="padding2423"><input id="txtSCH_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">�������������</td>
					<td class="padding2423"><input id="txtUYMD_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">����������</td>
					<td class="padding2423"><input id="txtTAVE_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">���ƴ�󰡻���</td>
					<td class="padding2423"><input id="txtAWDYN_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">���Ͱ�����</td>
					<td class="padding2423"><input id="txtTOEIC_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">HSK������</td>
					<td class="padding2423"><input id="txtHSK_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">JPT������</td>
					<td class="padding2423"><input id="txtJPT_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">�ڰ���������</td>
					<td class="padding2423"><input id="txtLICENCE_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">����������</td>
					<td class="padding2423"><input id="txtMILYN_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">��Ÿ������</td>
					<td class="padding2423"><input id="txtETC_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">��</td>
                    <td align="center" class="creamBold">������ ����</td>
					<td class="padding2423" colspan="3"><input id="txtTOTAL_PNT" size="7" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly>��</td>
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
						<object	id="grdT_RC_ADDPOINT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				  value="dsT_RC_ADDPOINT">
   						    <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
							<param name="Format"					value="
                                <C> id={currow}		    width=35    name='NO'			sort=false  align=center value={String(currow)}</C>
                                <C> id='PIS_YY'		    width=60	name='ä��⵵'		sort=false  align=center </C>
                                <C> id='SEQ_NO'		    width=35	name='����'			sort=false  align=center </C>
                                <C> id='REG_NO'		    width=75	name='�����ȣ'		sort=false  align=center </C>
                                <C> id='ENO_NM'		    width=55	name='����'			sort=false  align=center </C>
                                <C> id='SCH_PNT'	    width=50	name='�з�'			sort=true   align=right </C>
                                <C> id='UYMD_PNT'	    width=70	name='�������'		sort=true   align=right </C>
                                <C> id='TAVE_PNT'	    width=50	name='����'			sort=true   align=right </C>
                                <C> id='AWDYN_PNT'	    width=70	name='���ƴ��'		sort=true   align=right </C>
                                <C> id='TOEIC_PNT'	    width=50	name='����'			sort=true   align=right </C>
                                <C> id='HSK_PNT'	    width=45	name='HSK'			sort=true   align=right </C>
                                <C> id='JPT_PNT'	    width=45	name='JPT'			sort=true   align=right </C>
                                <C> id='LICENCE_PNT'    width=60	name='�ڰ���'		sort=true   align=right </C>
                                <C> id='MILYN_PNT'		width=50	name='����'			sort=true   align=right </C>
                                <C> id='ETC_PNT'		width=50	name='��Ÿ'		    sort=true   align=right </C>
                                <C> id='TOTAL_PNT'		width=85	name='����������'	sort=true   align=right </C>
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
<!-- ä�������� ���̵�� ��й�ȣ ���� ���̺� -->
<object id="bndT_RC_ADDPOINT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_RC_ADDPOINT">
	<Param Name="BindInfo", Value='
        <C>Col=PIS_YY		Ctrl=txtPIS_YY	      	Param=value		</C>
        <C>Col=SEQ_NO    	Ctrl=txtSEQ_NO	     	Param=value		</C>
        <C>Col=REG_NO		Ctrl=txtREG_NO      	Param=value		</C>
        <C>Col=ENO_NM		Ctrl=txtENO_NM	      	Param=value		</C>
        <C>Col=SCH_PNT		Ctrl=txtSCH_PNT	      	Param=value		</C>
        <C>Col=UYMD_PNT		Ctrl=txtUYMD_PNT	    Param=value		</C>
        <C>Col=TAVE_PNT		Ctrl=txtTAVE_PNT	    Param=value		</C>
        <C>Col=AWDYN_PNT	Ctrl=txtAWDYN_PNT	    Param=value		</C>
        <C>Col=TOEIC_PNT	Ctrl=txtTOEIC_PNT	    Param=value		</C>
        <C>Col=HSK_PNT		Ctrl=txtHSK_PNT	     	Param=value		</C>
        <C>Col=JPT_PNT		Ctrl=txtJPT_PNT	     	Param=value		</C>
        <C>Col=LICENCE_PNT	Ctrl=txtLICENCE_PNT	    Param=value		</C>
        <C>Col=MILYN_PNT	Ctrl=txtMILYN_PNT	    Param=value		</C>
        <C>Col=ETC_PNT		Ctrl=txtETC_PNT	     	Param=value		</C>
        <C>Col=TOTAL_PNT	Ctrl=txtTOTAL_PNT	    Param=value		</C>
    '>
</object>
<!--
    ************************************************************************************
    * @Source         : edue031.jsp                                                    *
    * @Description    : �系���½�û�� PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/22  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/sessionCheck.jsp"%>

<%
	String ROLE_CD = box.getString("SESSION_ROLE_CD");
	String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");

	boolean isMaster = false;
	boolean isSubMaster = false;

	if (ROLE_CD.equals("1001") || ROLE_CD.equals("1002")
			|| EDU_AUTHO.equals("A")) {
		isMaster = true;
	} else if (EDU_AUTHO.equals("S")) {
		isSubMaster = true;
	}
%>

<html>

<head>
<title>������û��(edue031)</title>
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
<script language="javascript">

        var btnList = 'TFFTFTFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_CHASULIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue031.cmd.EDUE031CMD"
                                    + "&S_MODE=SHR"
                                    + "&ENO_NO="+document.getElementById("txtENO_NO").value
                                    + "&EDU_CD="+opener.edu_cd
                                    + "&SEQ_NO="+opener.seq_no;
            dsT_ED_CHASULIST.Reset();

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
            var isChk;

            // Ȯ�� CHECK
            if( document.getElementById("chkCHECK").checked == false ) {
                isChk = "N";

                //��û�ߴ��� ����
                if (dsT_ED_CHASULIST.NameValue(1, "CHK_YN") == "N")    {

                    alert("��û�Ͻñ� ���� ���������� �����Ͻð�, Ȯ�ζ��� üũ�Ͽ� �ֽʽÿ�.");
                    document.getElementById("chkCHECK").focus();
                    return false;

                } else {

                    var msg = "��û�� [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"ENO_NM") + "]\n"
                            + "�ش���� [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_CD") + "]"
                            + "[" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_NM") + "]\n"
                            + "��û�� ����Ͻðڽ��ϱ�?";
                    if (!confirm(msg)) return;
                }

            } else {
                isChk = "Y";
                alert(dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_NM") + " ������ ��û�Ǿ����ϴ�.");
            }


            //üũ�� ������ ����
            dsT_ED_CHASULIST.NameString(1, "CHK_YN") = isChk;

            trT_ED_CHASULIST.KeyValue = "SVL(I:dsT_ED_CHASULIST=dsT_ED_CHASULIST)";
            trT_ED_CHASULIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue031.cmd.EDUE031CMD"
                                    + "&S_MODE=SAV";
            trT_ED_CHASULIST.post();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);

            document.getElementById("txtENO_NO").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM").value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_NM").value = '<%=box.get("SESSION_DPTNM")%>';
            document.getElementById("txtJOB_NM").value = '<%=box.get("SESSION_JOBNM")%>';

<%
    //�����ڰ� �ƴϸ� �ٸ� ������� ��ȸ�� ���� �ʰ�
    if(!isMaster && !isSubMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    }
    //�ҼӺμ�������̰ų� �Ϲݻ������ ��� �ڽ��� �μ������� �˻��� ����
    if(!isMaster) {
%>
            document.getElementById("hidEMPL_DPT_CD").value = "<%=box.get("SESSION_DPTCD") %>";
<%
    }
%>

            fnc_SearchList();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_CHASULIST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList();

            window.close();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtCET_NO").value      = obj.cet_no;

                //��û�� ������ ��ȸ
                fnc_SearchList();

            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
            }
        }

        var elementList = new Array(     "txtEDU_CD"
                                        ,"txtEDU_NM"
                                        ,"txtSEQ_NO"
                                        ,"txtCHASU_TAG"
                                        ,"txtEDU_STR_YMD"
                                        ,"txtEDU_END_YMD"
                                        ,"txtSTR_YMD"
                                        ,"txtMAN_ENO_NM"
                                        ,"txtEDU_GBN_NM"
                                        ,"txtMNGER_NM"
                                        ,"txtFIELD_NM"
                                        ,"txtSHAPE_NM"
                                        ,"txtCOST_NM"
                                        ,"txtPLACE_NM"
                                        ,"txtGOAL_TAG"
                                        ,"txtCONTENT_TXT"
                                        ,"txtEFFECT_TAG"
                                        ,"txtOBJ_TAG"
                                        ,"txtCPT_TAG"
                                        ,"txtINT_NAM"
                                        ,"txtFIX_NO"
                                        ,"txtDAY_NO"
                                        ,"txtTIME_NO"
                                        ,"medCOST_AMT"
                                        ,"medRTN_AMT"
                                        ,"txtCPT_PNT"
                                        ,"txtSITE_TAG");
    </script>

</head>


<!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

<!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EDUCATION) |
    | 3. ���Ǵ� Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
<Object ID="dsT_ED_CHASULIST"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ED_CHASULIST                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
<Object ID="trT_ED_CHASULIST"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>


<!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

<!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
<Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            alert("��û�� ������ �����ϴ�.");
            window.close();

        } else {

            if (dsT_ED_CHASULIST.NameValue(1, "CHK_YN") == "N")    {

                if(dsT_ED_CHASULIST.NameValue(1, "IS_EXP") == "Y") {
                    alert("�����ڷ� ��ϵǾ� �־� ��û�Ͻ� �� �����ϴ�.");
                    document.getElementById("Message").innerText = '* �����ڷ� ��ϵǾ� �־� ��û�Ͻ� �� �����ϴ�.';
                    fnc_ChangeStateElement(false, "chkCHECK");
                    fnc_HiddenElement("imgSave");
                    fnc_HiddenElement("imgSave2");

                    return;
                } else if (dsT_ED_CHASULIST.NameValue(1, "FIX_NO") <= dsT_ED_CHASULIST.NameValue(1, "REQ_CNT")) {
                    alert("�̹� ��û������ ���������̹Ƿ� ��û�Ͻ� �� �����ϴ�.");
                    document.getElementById("Message").innerText = '* �̹� ��û������ ���������̹Ƿ� ��û�Ͻ� �� �����ϴ�.';
                    fnc_ChangeStateElement(false, "chkCHECK");
                    fnc_HiddenElement("imgSave");
                    fnc_HiddenElement("imgSave2");

                    return;
                } else {
                    document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ͻ� �� �ֽ��ϴ�.';
                    document.getElementById("chkCHECK").checked = false;
                }
            } else {
                document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ǿ����ϴ�.';
                document.getElementById("chkCHECK").checked = true;
            }

        }

    </Script>

<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
<Script For=dsT_ED_CHASULIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

<!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
<Script For=dsT_ED_CHASULIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

<!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
<script for=trT_ED_CHASULIST event="OnSuccess()">
        //fnc_SearchList();
        opener.fnc_SearchList();
        self.close();
    </script>

<!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
<script for=trT_ED_CHASULIST event="OnFail()">
        cfErrorMsg(this);
    </script>
<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"
	onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form ���� -->
<form name="form1"><!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"
					height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"
					class="barTitle">�系���½�û��</td>
				<td align="right" class="navigator">HOME/�λ����/�İ߻��/<font
					color="#000000">�系���½�û��</font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� --> <!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right"><img
			src="/images/button/btn_SaveOn.gif" name="imgSave" width="60"
			height="20" border="0" align="absmiddle" onClick="fnc_Save()"
			onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"
			style="cursor:hand;"> <img src="/images/button/btn_ExitOn.gif"
			name="imgExit" width="60" height="20" border="0" align="absmiddle"
			onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"
			style="cursor:hand;"></td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="100"></col>
				<col width="300"></col>
				<col width="100"></col>
				<col width="300"></col>
			</colgroup>
			<tr>
				<td align="center" class="creamBold">������</td>
				<td class="padding2423" colspan="3"><input id="txtEDU_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">��������</td>
				<td class="padding2423"><input id="txtEDU_GBN_NM"
					style="width:100%" maxlength="100"></td>
				<td align="center" class="creamBold">�����ְ�</td>
				<td class="padding2423"><input id="txtMNGER_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�����о�</td>
				<td class="padding2423"><input id="txtFIELD_NM"
					style="width:100%" maxlength="100"></td>
				<td align="center" class="creamBold">��������</td>
				<td class="padding2423"><input id="txtSHAPE_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">������ǥ</td>
				<td class="padding2423" colspan="3"><input id="txtGOAL_TAG"
					name="txtGOAL_TAG" style="width:100%" maxlength="100"></td>
			</tr>
			<tr>

			<td align="center" class="creamBold">��������</td>
				<td class="padding2423" colspan="3"><textarea
					id="txtCONTENT_TXT" name="txtCONTENT_TXT" cols="112" rows="5"
					onkeyup="fc_chk_byte(this,300);" class="input_ReadOnly" readonly></textarea></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�������</td>
				<td class="padding2423" colspan="3"><textarea id="txtCPT_TAG"
					name="txtCPT_TAG" cols="112" rows="3"
					onkeyup="fc_chk_byte(this,150);" class="input_ReadOnly" readonly></textarea></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">���ȿ��</td>
				<td class="padding2423" colspan="3"><input id="txtEFFECT_TAG"
					name="txtEFFECT_TAG" style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�������</td>
				<td class="padding2423" colspan="3"><input id="txtOBJ_TAG"
					name="txtOBJ_TAG" style="width:100%" maxlength="50"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�������</td>
				<td class="padding2423" colspan="3"><input id="txtINT_NAM"
					name="txtINT_NAM" style="width:100%" maxlength="22"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">��������</td>
				<td class="padding2423"><input id="txtFIX_NO" name="txtFIX_NO"
					style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3">
				��</td>
				<td align="center" class="creamBold">�����ð�</td>
				<td class="padding2423"><input id="txtTIME_NO"
					name="txtTIME_NO"
					style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3">
				�ð�</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�����ϼ�</td>
				<td class="padding2423" colspan="3"><input id="txtDAY_NO"
					name="txtDAY_NO"
					style="width:34%;ime-mode:disabled;text-align:right;" maxlength="3">
				��</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">���δ�</td>
				<td class="padding2423"><input id="txtCOST_NM"
					style="width:100%" maxlength="100"></td>
				<td align="center" class="creamBold">�������</td>
				<td class="padding2423"><input id="txtPLACE_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�������</td>
				<td class="padding2423"><comment id="__NSID__"><object
					id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
					style="width:80%">
					<param name=Alignment value=2>
					<param name=Border value=true>
					<param name=ClipMode value=true>
					<param name=DisabledBackColor value="#EEEEEE">
					<param name=Enable value=true>
					<param name=IsComma value=true>
					<param name=Language value=0>
					<param name=MaxLength value=9>
					<param name=Numeric value=true>
					<param name=ShowLiteral value="false">
					<param name=Visible value="true">
				</object></comment><script> __ShowEmbedObject(__NSID__); </script> ��</td>
				<td align="center" class="creamBold">ȯ�ޱݾ�</td>
				<td class="padding2423"><comment id="__NSID__"><object
					id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
					style="width:80%">
					<param name=Alignment value=2>
					<param name=Border value=true>
					<param name=ClipMode value=true>
					<param name=DisabledBackColor value="#EEEEEE">
					<param name=Enable value=true>
					<param name=IsComma value=true>
					<param name=Language value=0>
					<param name=MaxLength value=9>
					<param name=Numeric value=true>
					<param name=ShowLiteral value="false">
					<param name=Visible value="true">
				</object></comment><script> __ShowEmbedObject(__NSID__); </script> ��</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�̼�����</td>
				<td class="padding2423"><input id="txtCPT_PNT"
					name="txtCPT_PNT"
					style="width:80%;ime-mode:disabled;text-align:right;" maxlength="2">
				��</td>
				<td align="center" class="creamBold">�������Ʈ</td>
				<td class="padding2423">http://<input id="txtSITE_TAG"
					name="txtSITE_TAG" style="width:80%" maxlength="30"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">�������</td>
				<td class="padding2423" colspan="3"><input id="txtSTR_YMD"
					style="width:100%" maxlength="100"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" class="searchState"><span id="Message">&nbsp;</span></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� --> <!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="100"></col>
				<col width="*"></col>
			</colgroup>
			<tr>
				<td align="center" class="creamBold">�� û ��</td>
				<td class="padding2423" colspan="5"><input id="txtENO_NO"
					name="txtENO_NO" size="9" maxlength="8"
					onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()"
					onchange="fnc_SearchEmpNo()"> <input id="txtENO_NM"
					name="txtENO_NM" size="9" maxlength="9"
					onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()"
					onchange="fnc_SearchEmpNm()"> <img
					src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo"
					width="21" height="20" border="0" align="absmiddle"
					onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()"
					onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"
					style="cursor:hand;"> <input type="hidden"
					id="hidEMPL_DPT_CD"> <b> &nbsp;&nbsp;�μ� <input
					id="txtDPT_NM" size="20" class="input_ReadOnly" readonly>
				&nbsp;&nbsp;���� <input id="txtJOB_NM" size="16"
					class="input_ReadOnly" readonly> &nbsp;&nbsp;�ֹι�ȣ <input
					id="txtCET_NO" size="20" class="input_ReadOnly" readonly> </b>
				</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">��������</td>
				<td class="padding2423" colspan="5"><textarea id="txtTEXT"
					name="txtTEXT" cols="117" rows="5" maxlength="4000" readonly>
&nbsp;1) ���ܰἮ ��5ȸ �̻��� ��� ��������� �����ϰ� ������� ������ �δ��Ѵ�.
&nbsp;2) �����⼮�� 75% �̸��� ��� �̼���ó���ϰ� Ÿ ������ȸ�� ������ �д�.
&nbsp;3) ��ް����� �ſ� �п����� �⼮ �� �� ����� ���� �����������θ� �����Ѵ�.
                        </textarea></td>
			</tr>
			<tr>
				<td align="right" class="padding2423" colspan="6">��� ����������
				�����Ͽ�����, �系���¸� ��û�մϴ�. <input type="checkbox" id="chkCHECK"
					name="chkCHECK">Ȯ��&nbsp;&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8" align="right"><img
			src="/images/button/btn_SaveOn.gif" name="imgSave2" width="60"
			height="20" border="0" align="absmiddle" onClick="fnc_Save()"
			onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgSave2','','/images/button/btn_SaveOver.gif',1)"
			style="cursor:hand;"> <img src="/images/button/btn_ExitOn.gif"
			name="imgExit2" width="60" height="20" border="0" align="absmiddle"
			onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgExit2','','/images/button/btn_ExitOver.gif',1)"
			style="cursor:hand;"></td>
	</tr>
</table>
<!-- ��ȸ ���̺� �� --></form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �򰡴���ڼ��� ���̺� -->
<object id="bndT_ED_CHASULIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_ED_CHASULIST">
	<Param Name="BindInfo",  Value="
        <C>Col=ENO_NO           Ctrl=txtENO_NO          Param=value </C>
        <C>Col=ENO_NM           Ctrl=txtENO_NM          Param=value </C>
        <C>Col=DPT_NM           Ctrl=txtDPT_NM          Param=value </C>
        <C>Col=JOB_NM           Ctrl=txtJOB_NM          Param=value </C>
        <C>Col=CET_NO           Ctrl=txtCET_NO          Param=value </C>
        <C>Col=EDU_CD           Ctrl=txtEDU_CD          Param=value </C>
        <C>Col=EDU_NM           Ctrl=txtEDU_NM          Param=value </C>
        <C>Col=SEQ_NO           Ctrl=txtSEQ_NO          Param=value </C>
        <C>Col=CHASU_TAG        Ctrl=txtCHASU_TAG       Param=value </C>
        <C>Col=EDU_STR_YMD      Ctrl=txtEDU_STR_YMD     Param=value </C>
        <C>Col=EDU_END_YMD      Ctrl=txtEDU_END_YMD     Param=value </C>
        <C>Col=STR_YMD          Ctrl=txtSTR_YMD         Param=value </C>
        <C>Col=MAN_ENO_NM       Ctrl=txtMAN_ENO_NM      Param=value </C>
        <C>Col=EDU_GBN_NM       Ctrl=txtEDU_GBN_NM      Param=value </C>
        <C>Col=MNGER_NM         Ctrl=txtMNGER_NM        Param=value </C>
        <C>Col=FIELD_NM         Ctrl=txtFIELD_NM        Param=value </C>
        <C>Col=SHAPE_NM         Ctrl=txtSHAPE_NM        Param=value </C>
        <C>Col=COST_NM          Ctrl=txtCOST_NM         Param=value </C>
        <C>Col=PLACE_NM         Ctrl=txtPLACE_NM        Param=value </C>
        <C>Col=GOAL_TAG         Ctrl=txtGOAL_TAG        Param=value </C>
        <C>Col=CONTENT_TXT      Ctrl=txtCONTENT_TXT     Param=value </C>
        <C>Col=EFFECT_TAG       Ctrl=txtEFFECT_TAG      Param=value </C>
        <C>Col=OBJ_TAG          Ctrl=txtOBJ_TAG         Param=value </C>
        <C>Col=CPT_TAG          Ctrl=txtCPT_TAG         Param=value </C>
        <C>Col=INT_NAM          Ctrl=txtINT_NAM         Param=value </C>
        <C>Col=FIX_NO           Ctrl=txtFIX_NO          Param=value </C>
        <C>Col=DAY_NO           Ctrl=txtDAY_NO          Param=value </C>
        <C>Col=TIME_NO          Ctrl=txtTIME_NO         Param=value </C>
        <C>Col=COST_AMT         Ctrl=medCOST_AMT        Param=Text  </C>
        <C>Col=RTN_AMT          Ctrl=medRTN_AMT         Param=Text  </C>
        <C>Col=CPT_PNT          Ctrl=txtCPT_PNT         Param=value </C>
        <C>Col=SITE_TAG         Ctrl=txtSITE_TAG        Param=value </C>
        <C>Col=COMM_NO          Ctrl=hidCOMM_NO         Param=value </C>

    ">
</object>

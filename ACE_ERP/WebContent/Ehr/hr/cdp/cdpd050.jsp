<!--
    ************************************************************************************
    * @Source         : cdpd040.jsp                                                    *
    * @Description    : OJT�濵�������� �򰡼� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/23  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");

    boolean isMaster = false;
    boolean isSubMaster = false;

    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")
            || EDU_AUTHO.equals("A")) {
        isMaster = true;
    } else if (EDU_AUTHO.equals("S")) {
        isSubMaster = true;
    }
%>

<html>

    <head>
    <title>OJT �濵�������� �򰡼�(cdpd050)</title>
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
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var eno_no = '';
        var eno_nm = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var MNT_GBN = document.getElementById("cmbMNT_GBN").value;
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var DPT_CD  = document.getElementById("hidEMPL_DPT_CD").value;
            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;


            // �İ߽������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "�İ߱�� FROM����") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }

            // ���丵 �Ⱓ TO���� CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "���丵 �Ⱓ TO����") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // ���丵 �Ⱓ FROM���ڿ� TO���� ��
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("�������ڴ� �ݵ�� �������ں��� �۾ƾ��մϴ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return false;
                }
            }

            dsT_CD_OJT.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd050.cmd.CDPD050CMD"
                                + "&S_MODE=SHR"
                                + "&MNT_GBN="+MNT_GBN
                                + "&ENO_NO="+ENO_NO
                                + "&DPT_CD="+DPT_CD
                                + "&STR_YMD="+STR_YMD
                                + "&END_YMD="+END_YMD;
            dsT_CD_OJT.Reset();

            //form1.grdT_CD_OJT.Focus();
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
			var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;

            if(fnc_SaveItemCheck()) {

                trT_CD_OJT.KeyValue = "tr01(I:SAV=dsT_CD_OJT)";
                trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd050.cmd.CDPD050CMD&S_MODE=SAV&ENO_NO="+ENO_NO;
                trT_CD_OJT.post();

            } else {

                return;

            }

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

            var MNT_GBN = document.getElementById("cmbMNT_GBN").value;
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;

            // �İ߽�������
            if( STR_YMD == '' ) {
                alert("���丵 �Ⱓ FROM���ڴ� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }

            // �İ߽������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "�İ߱�� FROM����") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }

            // ���丵 �Ⱓ TO����
            if( END_YMD == '' ) {
                alert("���丵 �Ⱓ TO���ڴ� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // ���丵 �Ⱓ TO���� CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "���丵 �Ⱓ TO����") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // ���丵 �Ⱓ FROM���ڿ� TO���� ��
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("���丵 �Ⱓ FROM���ڴ� �ݵ�� ���丵 �Ⱓ TO���ں��� �۾ƾ��մϴ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return false;
                }
            }

            var url = "cdpd050_PV.jsp?MNT_GBN="+MNT_GBN
                                + "&ENO_NO="+ENO_NO
                                + "&STR_YMD="+STR_YMD
                                + "&END_YMD="+END_YMD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

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

            document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

            dsT_CD_OJT.ClearData();


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
			if (!dsT_CD_OJT.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_CD_OJT,0,"false","false");

<%
    //�����ڰ� �ƴϸ� �ٸ� ������� ��ȸ�� ���� �ʰ�
    if(!isMaster && !isSubMaster) {
%>
                document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
                document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';

                fnc_ChangeStateElement(false, "txtENO_NO_SHR");
                fnc_ChangeStateElement(false, "txtENO_NM_SHR");
                fnc_ChangeStateElement(false, "ImgEnoNoShr");

                //����(Mentor)�� ��ȸ�� �ǰ�
                fnc_ChangeStateElement(false, "cmbMNT_GBN");
                document.getElementById("cmbMNT_GBN").value = "M";
<%
    }
    //�ҼӺμ�������� ��� �ڽ��� �μ������� �˻��� ����
    if(isSubMaster) {
%>
                document.getElementById("hidEMPL_DPT_CD").value = "<%=box.get("SESSION_DPTCD") %>";
<%
    }
%>

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_OJT.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

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


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTO)|
    | 3. ���Ǵ� Table List(T_CD_MENTO)       |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CD_MENTO                    |
    | 3. Table List : T_CD_MENTO                |
    +----------------------------------------------->
    <Object ID ="trT_CD_OJT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_OJTREPORT)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_CD_OJT Event="OnDblClick(row, col)">

        eno_no  = dsT_CD_OJT.NameValue(row, "ENO_NO");
        eno_nm  = dsT_CD_OJT.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/cdp/cdpd051.jsp", self, "dialogHeight:770px; dialogWidth:840px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJT.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_CD_OJT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CD_OJT event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">OJT �濵�������� �򰡼�</td>
                    <td align="right" class="navigator">HOME/��������/CDP/OJT����/<font color="#000000">OJT �濵�������� �򰡼�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
      <!--       <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>  -->
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
                                <col width="90"></col>
                                <col width="100"></col>
                                <col width="90"></col>
                                <col width="180"></col>
                                <col width="90"></col>
                                <col width="*"></col>
                            </colgroup>

                            <tr>
                                <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbMNT_GBN">
                                        <option value="">��ü</option>
                                        <option value="P">���Ի��</option>
                                        <option value="M">å���������</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState" width="70">�����ȣ&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">OJT�Ⱓ&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�İ߱Ⱓ FROM����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> ~
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�İ߱Ⱓ TO����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
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

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                	<col width="90"></col>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                	<td align="center" class="creamBold">�����</td>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold">å���������</td>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtMDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id="txtMJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                        ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�μ�</td>
                    <td class="padding2423">
                    	<input id="txtTRA_DPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_DPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�Ի���</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" name="txtHIR_YMD" size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423">
                    	<input id="txtHEAD_EMP_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtHEAD_EMP_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" colspan="3">
						<input id="txtTRA_DUTY" size="53" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">������ǥ</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtEDU_GOAL1" size="110" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL2" size="110" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL3" size="110" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

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
                        <object    id="grdT_CD_OJT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:270px;">
                            <param name="DataID"                  value="dsT_CD_OJT">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"             value="
                                <C> id='{currow}'            width=29    name='����'       align=center </C>
                                <G> name='���Ի��' HeadBgColor='#F7DCBB'
                                    <C> id='ENO_NO'          width=70    name='���'       align=center  Gte_ColumnType='Number:0:False'</C>
                                    <C> id='ENO_NM'          width=70    name='����'       align=center </C>
                                    <C> id='DPT_NM'          width=90    name='�Ҽ�'       align=left   </C>
                                    <C> id='JOB_NM'          width=60    name='����'       align=center </C>
                                    <C> id='HIR_YMD'        width=70    name='�Ի���'     align=center </C>
                                </G>
                                <C> id='TRA_DPT_NM'            width=90    name='OJT�μ�'       align=center </C>
                                <G> name='å���������' HeadBgColor='#F7DCBB'
                                    <C> id='TRA_ENO_NO'         width=70    name='���'       align=center Gte_ColumnType='Number:0:False'</C>
                                    <C> id='TRA_ENO_NM'         width=70    name='����'       align=center </C>
                                    <C> id='MDPT_NM'         width=90    name='�Ҽ�'       align=left   </C>
                                    <C> id='MJOB_NM'         width=60    name='����'       align=center </C>
                                </G>
                                <G> name='OJT�Ⱓ' HeadBgColor='#F7DCBB'
                                    <C> id='STR_YMD'         width=70    name='��������'   align=center </C>
                                    <C> id='END_YMD'         width=70    name='��������'   align=center </C>
                                </G>
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

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* �ش� �׸��� ����Ŭ�� �Ͻø� �򰡼��� ����ϰų� �����Ͻ� �� �ֽ��ϴ�.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>
<!-- form �� -->

</body>
</html>
<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- ���뺸�� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJT">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=TRA_ENO_NO       Ctrl=txtTRA_ENO_NO       Param=value </C>
        <C> Col=TRA_ENO_NM       Ctrl=txtTRA_ENO_NM       Param=value </C>
        <C> Col=MDPT_CD       Ctrl=txtMDPT_CD       Param=value </C>
        <C> Col=MDPT_NM       Ctrl=txtMDPT_NM       Param=value </C>
        <C> Col=MJOB_CD       Ctrl=txtMJOB_CD       Param=value </C>
        <C> Col=MJOB_NM       Ctrl=txtMJOB_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD       Param=value </C>
        <C> Col=TRA_DPT_CD        Ctrl=txtTRA_DPT_CD        Param=value </C>
        <C> Col=TRA_DPT_NM        Ctrl=txtTRA_DPT_NM        Param=value </C>
        <C> Col=HIR_YMD       Ctrl=txtHIR_YMD       Param=value </C>
        <C> Col=TRA_DUTY        Ctrl=txtTRA_DUTY        Param=value </C>
        <C> Col=HEAD_EMP_NO        Ctrl=txtHEAD_EMP_NO        Param=value </C>
        <C> Col=HEAD_EMP_NM        Ctrl=txtHEAD_EMP_NM        Param=value </C>
        <C> Col=EDU_GOAL1        Ctrl=txtEDU_GOAL1        Param=value </C>
        <C> Col=EDU_GOAL2        Ctrl=txtEDU_GOAL2        Param=value </C>
        <C> Col=EDU_GOAL3        Ctrl=txtEDU_GOAL3        Param=value </C>
        <C> Col=EDU_POINT        Ctrl=txtEDU_POINT        Param=value </C>
    '>
</object>
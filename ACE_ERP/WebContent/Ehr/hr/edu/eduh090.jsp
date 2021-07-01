<!--
    ************************************************************************************
    * @Source         : eduh090.jsp                                                    *
    * @Description    : ��뺸����� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/08  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>��뺸�����(eduh090)</title>
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

        var btnList = 'TTFTFFFT';

        var gbn      = '';
        var edu_cd   = '';
        var seq_no   = '';
        var edu_nm   = '';
        var edu_term = '';


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var FIELD_CD = document.getElementById("cmbFIELD_CD_SHR").value;
            var SHAPE_CD = document.getElementById("cmbSHAPE_CD_SHR").value;
            var YEAR     = document.getElementById("txtYEAR_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            var EDU_CD   = document.getElementById("txtEDU_CD_SHR").value;

            if (YEAR == "") {
                alert("�⵵�� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtYEAR_SHR").focus();
                return;
            }

            // �����Ⱓ FROM���� CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "�����Ⱓ FROM����") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // �����Ⱓ TO���� CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "�����Ⱓ TO����") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // ������������ FROM ~ TO���� ��
            if (STR_YMD != "" && END_YMD != "") {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("���������� FROM���ڴ� �ݵ�� ���������� TO���ں��� �۾ƾ��մϴ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }
            }

            if (STR_YMD != "") {
                if (STR_YMD.substr(0,4) != YEAR) {
                    alert("�������ڴ� ���ǳ⵵�� ���������� �Է��ϼž� �մϴ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }

                if (END_YMD == "") {
                    alert("���������� TO���ڸ� �Է��Ͻʽÿ�.");
                    document.getElementById("txtEND_YMD_SHR").focus();
                    return;
                }
            }

            if (END_YMD != "") {
                if (END_YMD.substr(0,4) != YEAR) {
                    alert("�������ڴ� ���ǳ⵵�� ���������� �Է��ϼž� �մϴ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }

                if (STR_YMD == "") {
                    alert("���������� FROM���ڸ� �Է��Ͻʽÿ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }
            }

            dsT_ED_INSURANCE.ClearData();

            dsT_ED_INSURANCE.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh090.cmd.EDUH090CMD&S_MODE=SHR&FIELD_CD="+FIELD_CD+"&SHAPE_CD="+SHAPE_CD+"&YEAR="+YEAR+"&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD+"&EDU_CD="+EDU_CD;
            dsT_ED_INSURANCE.Reset();

            form1.grdT_ED_INSURANCE.Focus();

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

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ED_INSURANCE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�����ڵ�[" + dsT_ED_INSURANCE.NameValue(dsT_ED_INSURANCE.RowPosition,"EDU_CD") + "] ������[" + dsT_ED_INSURANCE.NameValue(dsT_ED_INSURANCE.RowPosition,"EDU_NM")  + "] �����Ⱓ [" + dsT_ED_INSURANCE.NameValue(dsT_ED_INSURANCE.RowPosition,"EDU_TERM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ED_INSURANCE.DeleteRow(dsT_ED_INSURANCE.RowPosition);

            trT_ED_INSURANCE.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh090.cmd.EDUH090CMD&S_MODE=DEL";
            trT_ED_INSURANCE.post();


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

            if (dsT_ED_INSURANCE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_ED_INSURANCE.GridToExcel("��뺸�����", '', 225);
        }



        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            gbn     = "1";        // 1: �ű�, 2: ����
            edu_cd  = "";
            seq_no  = "";
            edu_nm   = '';
            edu_term = '';

            window.showModalDialog("/hr/edu/eduh091.jsp", self, "dialogHeight:640px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            document.getElementById("cmbFIELD_CD_SHR").value = '';
            document.getElementById("cmbSHAPE_CD_SHR").value = '';
            document.getElementById("txtYEAR_SHR").value     = getToday().substr(0,4);
            document.getElementById("txtSTR_YMD_SHR").value  = '';
            document.getElementById("txtEND_YMD_SHR").value  = '';
            document.getElementById("txtENO_NM_SHR").value   = '';
            document.getElementById("txtEDU_CD_SHR").value   = '';
            document.getElementById("txtEDU_NM_SHR").value   = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_INSURANCE.ClearData();

            document.getElementById("txtYEAR_SHR").focus();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_ED_INSURANCE,0,"false","false");

            //�����о�
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);

            }

            //��������
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);

            }

            document.getElementById("txtYEAR_SHR").value = getToday().substr(0, 4);

            document.getElementById("txtYEAR_SHR").focus();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_INSURANCE)  |
    | 3. ���Ǵ� Table List(T_ED_INSURANCE)         |
    +----------------------------------------------->
    <Object ID="dsT_ED_INSURANCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_INSURANCE)  |
    | 3. ���Ǵ� Table List(T_ED_INSURANCE)         |
    +----------------------------------------------->
    <Object ID ="trT_ED_INSURANCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_INSURANCE)">
    </Object>

    <!-- �����о� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_INSURANCE Event="OnDblClick(row, col)">

        gbn      = "2";        // 1: �ű�, 2: ����
        edu_cd   = dsT_ED_INSURANCE.NameValue(row, "EDU_CD");
        seq_no   = dsT_ED_INSURANCE.NameValue(row, "SEQ_NO");
        edu_nm   = dsT_ED_INSURANCE.NameValue(row, "EDU_NM");
        edu_term = dsT_ED_INSURANCE.NameValue(row, "EDU_TERM");

        if (col == 'FUNC') {

            // ������
            if (dsT_ED_INSURANCE.NameValue(row, "PAS_CNT") > 0) {

                window.showModalDialog("/hr/edu/eduh092.jsp", self, "dialogHeight:460px; dialogWidth:570px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            }
            else {
                alert("�ش� ���������� ���� �����ڰ� �������մϴ�.");
                return;
            }
        }
        else {

            // ��뺸����� ����
            window.showModalDialog("/hr/edu/eduh091.jsp", self, "dialogHeight:640px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        }


    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_INSURANCE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_INSURANCE.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_INSURANCE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_INSURANCE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-- Ʈ������ ����. -->
    <script for=trT_ED_INSURANCE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_ED_INSURANCE event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��뺸�����</td>
                    <td align="right" class="navigator">HOME/��������/�������/<font color="#000000">��뺸�����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
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
                            <tr>
                                <td align="right" class="searchState">�⵵</td>
                                <td class="padding2423" align="left">
                                    <input id="txtYEAR_SHR" style="ime-mode:disabled" size="4" maxlength="4" onkeypress="cfCheckNumber();">
                                </td>
                                <td align="right" class="searchState">�����Ⱓ</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�����Ⱓ FROM����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> ~
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�����Ⱓ TO����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
                                </td>
                            </tr>
                            <tr>

                                <td align="right" class="searchState">�����о�</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbFIELD_CD_SHR">
                                        <option value="">��ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">��������</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbSHAPE_CD_SHR">
                                        <option value="">��ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">��������</td>
                                <td class="padding2423">
                                    <input id="txtEDU_CD_SHR" name="txtEDU_CD_SHR" size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('Q1', 'txtEDU_CD_SHR','txtEDU_NM_SHR');"> <input id="txtEDU_NM_SHR" name="txtEDU_NM_SHR" size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd1" name="ImgEduCd1" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtEDU_CD_SHR','txtEDU_NM_SHR','��������','Q1')"></a>
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
                        <object    id="grdT_ED_INSURANCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ED_INSURANCE">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=60    name='����'           align=center </C>
                                <C> id='EDU_NM'       width=120   name='������'         align=left   </C>
                                <C> id='EDU_TERM'     width=200   name='�����Ⱓ'       align=center </C>
                                <C> id='PAS_CNT'      width=80    name='����'           align=center </C>
                                <C> id='RTN_EXPT_AMT' width=80    name='ȯ�޿���'       align=right  </C>
                                <C> id='RTN_RQST_AMT' width=80    name='ȯ�޿�û'       align=right  </C>
                                <C> id='INS_E_AMT'    width=80    name='ȯ�޽���'       align=right  </C>
                                <C> id='FUNC'         width=80    name='������'       align=center Color='Blue' </C>
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
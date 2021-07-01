<!--
    ************************************************************************************
    * @Source         : cdpc031.jsp                                                    *
    * @Description    : �İ��λ��������� PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/23  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�İ��λ���������(cdpc031)</title>
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

    <!-- ÷�� ������ ���� -->
    <jsp:include page="/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->

    <script language="javascript" >

        var btnList = 'TFFTFTFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO    = opener.eno_no;
            var SEQ_NO    = opener.seq_no;

            dsT_CD_MENTO.ClearData();

            dsT_CD_MENTO.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc031.cmd.CDPC031CMD&S_MODE=SHR&ENO_NO="+ENO_NO+"&SEQ_NO="+SEQ_NO;
            dsT_CD_MENTO.Reset();

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

            var CONS_YMD = dsT_CD_MENTORESULT.NameValue(1, "CONS_YMD");

            if(fnc_SaveItemCheck()) {

                trT_CD_MENTORESULT.KeyValue = "tr01(I:SAV=dsT_CD_MENTORESULT, O:RELOAD=dsT_CD_MENTORESULT2)";
                trT_CD_MENTORESULT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc031.cmd.CDPC031CMD&S_MODE=SAV&ENO_NO="+opener.eno_no+"&SEQ_NO="+opener.seq_no+"&CONS_YMD="+CONS_YMD;
                trT_CD_MENTORESULT.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete(gubun) {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
            var ENO_NO    = opener.eno_no;
            var SEQ_NO    = opener.seq_no;
            var CONS_YMD  = opener.cons_ymd;

            var url = "cdpc031_PV.jsp?ENO_NO="+ENO_NO+"&SEQ_NO="+SEQ_NO+"&CONS_YMD="+CONS_YMD;
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
        function fnc_AddNew(gubun) {

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            if (!dsT_CD_MENTORESULT.IsUpdated) {

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

            // �İ��λ������ ������ ��ȸ
            fnc_SearchList();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_MENTORESULT.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList2();

            window.close();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        //�Է� ����â
        var elementList = new Array(     "txtPLACE_TXT"
                                        ,"txtCONS_YMD"
                                        ,"btnImgYmd"
                                        ,"txtSBJ_TXT"
                                        ,"txtEDU_TXT"
                                        ,"txtPPS_TXT"
                                        ,"txtIDEA_TXT" );



        /********************************************
         * ÷������ ó��                              *
         ********************************************/
        function fnc_FileUpload() {
            if(dsFILE.CountRow == 5) {
                alert("�� �̻� ÷�������� �߰��Ͻ� �� �����ϴ�.");
                return;
            }

            var key = "cdpc031"
                    + dsT_CD_MENTORESULT.NameValue(1, "ENO_NO")
                    + dsT_CD_MENTORESULT.NameValue(1, "SEQ_NO")
                    + dsT_CD_MENTORESULT.NameValue(1, "CONS_YMD");

            if(!fnc_AddFile(key, false)) {
                return;
            }
        }

        /********************************************
         * ÷������ ����                              *
         ********************************************/
        function fnc_FileDelete() {
            if(dsFILE.CountRow < 1) {
                alert("������ ������ �������� �ʽ��ϴ�.");
                return;
            }

            if( confirm("÷�ε� ������ �����Ͻðڽ��ϱ�?") ){
                dsFILE.DeleteRow(dsFILE.RowPosition);
                fnc_DelFile();
            }
        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTORESULT) |
    | 3. ���Ǵ� Table List(T_CD_MENTORESULT)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTORESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- Reload�� �����ͼ� -->
    <Object ID="dsT_CD_MENTORESULT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTO)     |
    | 3. ���Ǵ� Table List(T_CD_MENTO)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CD_MENTO                    |
    | 3. Table List : T_CD_MENTO                |
    +----------------------------------------------->
    <Object ID ="trT_CD_MENTORESULT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_MENTORESULT)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTORESULT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_MENTORESULT.CountRow );
            dsT_CD_MENTORESULT.RowPosition = 1;

        }


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTORESULT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTORESULT Event="OnDataError()">

        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTO Event="OnLoadCompleted(iCount)">


        var ENO_NO  = opener.eno_no;
        var SEQ_NO  = opener.seq_no;

        if (iCount > 0) {
        	var today = getToday().replace("-","").replace("-","");
        	var STR_YMD = dsT_CD_MENTO.NameValue(1, "STR_YMD").replace("-","").replace("-","");
        	var END_YMD = dsT_CD_MENTO.NameValue(1, "END_YMD").replace("-","").replace("-","");

			if (STR_YMD > today || END_YMD < today) {
                //���â ����
                fnc_DisableElementAll(elementList);

                document.getElementById("imgSave").disabled = true;
                document.getElementById("imgSave").style.display = "none";

            }
            else {
                fnc_EnableElementAll(elementList);
            }

            // ������ �����̸�
            if (opener.gbn == "2") {

                dsT_CD_MENTORESULT.ClearData();

                dsT_CD_MENTORESULT.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc031.cmd.CDPC031CMD&S_MODE=SHR_02&ENO_NO="+opener.eno_no+"&SEQ_NO="+opener.seq_no+"&CONS_YMD="+opener.cons_ymd;
                dsT_CD_MENTORESULT.Reset();

                //������ڸ� �������ϰ� ����
                fnc_ChangeStateElement(false, "txtCONS_YMD");
                fnc_ChangeStateElement(false, "btnImgYmd");

            }
            else {

                if (document.getElementById("imgSave").disabled == true) {
                    alert("�İ߱Ⱓ�� ����� ��Ƽ(Mentee)�Դϴ�. ��������� �ۼ��Ͻ� �� �����ϴ�.");
                    return;
                }

                // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��
                if (dsT_CD_MENTORESULT.CountColumn == 0) {
                    dsT_CD_MENTORESULT.setDataHeader("ENO_NO:STRING:NOTNULL, SEQ_NO:STRING, CONS_YMD:STRING, PLACE_TXT:STRING, SBJ_TXT:STRING, EDU_TXT:STRING, PPS_TXT:STRING, IDEA_TXT:STRING, FILE_NAME:STRING, FILE_URL:STRING");
                }


                // Row Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
                dsT_CD_MENTORESULT.AddRow();

                dsT_CD_MENTORESULT.NameValue(1, "ENO_NO")   = opener.eno_no;
                dsT_CD_MENTORESULT.NameValue(1, "SEQ_NO")   = opener.seq_no;
                dsT_CD_MENTORESULT.NameValue(1, "CONS_YMD") = getToday();

                document.getElementById('txtPLACE_TXT').focus();
            }

            var key = "cdpc031"
                    + dsT_CD_MENTORESULT.NameValue(1, "ENO_NO")
                    + dsT_CD_MENTORESULT.NameValue(1, "SEQ_NO")
                    + dsT_CD_MENTORESULT.NameValue(1, "CONS_YMD");

            //÷������ ����Ʈ�� �������
            fnc_GetFileList(key);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <script for=dsT_CD_MENTORESULT2 event="OnLoadCompleted(iCount)">
        if (iCount == 0){
            alert("��ȸ�� �����Ͱ� �����ϴ�.");
            return;
        }

    </script>



    <!-- Ʈ������ ����. -->
    <script for=trT_CD_MENTORESULT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CD_MENTORESULT event="OnFail()">

        cfErrorMsg(this);

    </script>


    <!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
        if(row > 0) {
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            if (vFILE_NAME != "" && vFILE_URL != "") {
                cfDownload(vFILE_NAME, vFILE_URL);
            }
        }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���丵 �������</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">   <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="110"></col>
                    <col width="150"></col>
                    <col width="110"></col>
                    <col width="150"></col>
                    <col width="110"></col>
                    <col width="180"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��Ƽ&nbsp;�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��Ƽ&nbsp;����</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��Ƽ&nbsp;���</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">����&nbsp;�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtMDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMDPT_NM" size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����&nbsp;����</td>
                    <td class="padding2423">
                        <input id="txtMJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMJOB_NM" size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����&nbsp;���</td>
                    <td class="padding2423">
                        <input id="txtMENO_NO" size="10" maxlength="10" style="ime-mode:disabled"  class="input_ReadOnly" readonly>
                        <input id="txtMENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���丵&nbsp;�Ⱓ</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly> ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtOBJ_TXT" maxlength="10" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_TXT"  name="txtPLACE_TXT" style="width:100%" maxlength="50">
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <input name="txtCONS_YMD" id="txtCONS_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�İ߱Ⱓ FROM����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="btnImgYmd" name="btnImgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCONS_YMD','','630','180');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtSBJ_TXT" name="txtSBJ_TXT" style="width:100%" maxlength="300">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��� �� <br>��������</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtEDU_TXT"  name="txtEDU_TXT" cols="112" rows="5" maxlength="4000" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���� �� �ǰ�</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtPPS_TXT"  name="txtPPS_TXT" cols="112" rows="5" maxlength="4000" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">����(Mentor) �ǰ�</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtIDEA_TXT"  name="txtIDEA_TXT" cols="112" rows="5" maxlength="4000" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">÷���ڷ�</td>
                    <td class="padding2423" colspan="3">
        				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
        				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','/images/button/FileDelOver.gif',1)"><img src="/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>

                        <comment id="__NSID__">
                        <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:103px;">
                            <param name="DataID" value="dsFILE">
                            <param name="Editable" value="false">
                            <param name="DragDropEnable" value="true">
                            <param name="SortView" value="Left">
                            <param name=ViewHeader  value="false">
                            <param name="Format" value='
                                <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                                <C> id=FILE_NAME    width="500"     name="���ϸ�"      align="left"    leftmargin="10"</C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- ����(Mentor)��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_MENTO">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=MENO_NO       Ctrl=txtMENO_NO       Param=value </C>
        <C> Col=MENO_NM       Ctrl=txtMENO_NM       Param=value </C>
        <C> Col=MDPT_CD       Ctrl=txtMDPT_CD       Param=value </C>
        <C> Col=MDPT_NM       Ctrl=txtMDPT_NM       Param=value </C>
        <C> Col=MJOB_CD       Ctrl=txtMJOB_CD       Param=value </C>
        <C> Col=MJOB_NM       Ctrl=txtMJOB_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD       Param=value </C>
        <C> Col=OBJ_TXT       Ctrl=txtOBJ_TXT       Param=value </C>
    '>
</object>

<!-- ����(Mentor)������� ���̺� -->
<object id="bndT_CD_MENTORESULT"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",      Value="dsT_CD_MENTORESULT">
    <Param Name="BindInfo",    Value='
        <C>Col=CONS_YMD        Ctrl=txtCONS_YMD       Param=value </C>
        <C>Col=PLACE_TXT       Ctrl=txtPLACE_TXT      Param=value </C>
        <C>Col=SBJ_TXT         Ctrl=txtSBJ_TXT        Param=value </C>
        <C>Col=EDU_TXT         Ctrl=txtEDU_TXT        Param=value </C>
        <C>Col=PPS_TXT         Ctrl=txtPPS_TXT        Param=value </C>
        <C>Col=IDEA_TXT        Ctrl=txtIDEA_TXT       Param=value </C>
        <C>Col=FILE_NAME       Ctrl=txtFILE_NAME      Param=value </C>
        <C>Col=FILE_URL        Ctrl=txtFILE_URL       Param=value </C>
    '>
</object>


<!-- ÷�����Ͽ� ���ε� ������Ʈ -->
<object id="oFileBD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID"       Value="oFileListGDS">
    <Param Name="BindInfo"     Value='
        <C>Col=FILE_NAME       Ctrl=oFileGF           Param=Value</C>
        <C>Col=FILE_URL        Ctrl=oFileGF           Param=Value</C>
    '>
</object>
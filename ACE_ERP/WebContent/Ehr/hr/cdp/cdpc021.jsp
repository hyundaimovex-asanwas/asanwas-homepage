<!--
    ************************************************************************************
    * @Source         : cdpc021.jsp                                                    *
    * @Description    : �İ��ξ缺��ȹ��� PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/22  |  ������   | �����ۼ�                                               *
    * 2007/04/17  |  ���м�   | �μ��߰�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�İ��ξ缺��ȹ���(cdpc021)</title>
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

        var btnList = 'TFFTFTFT';

        var opener = window.dialogArguments;
        var flag   = '';                       // 0: ��ȸ, 1: ����/����

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO  = opener.eno_no;
            var SEQ_NO  = opener.seq_no;

            flag = '0';

            dsT_CD_MENTO.ClearData();

            dsT_CD_MENTO.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc021.cmd.CDPC021CMD&S_MODE=SHR&ENO_NO="+ENO_NO+"&SEQ_NO="+SEQ_NO;
            dsT_CD_MENTO.Reset();

            form1.grdT_CD_MENTOPLAN_01.Focus();

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
            if(fnc_SaveItemCheck()) {

                flag = '1';

                trT_CD_MENTO.KeyValue = "SVL(I:SAV_01=dsT_CD_MENTOPLAN_01, I:SAV_02=dsT_CD_MENTOPLAN_02, I:SAV_09=dsT_CD_MENTOPLAN_09)";
                trT_CD_MENTO.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc021.cmd.CDPC021CMD&S_MODE=SAV";
                trT_CD_MENTO.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete(gubun) {
            var status = "";

            // ��ǥ
            if (gubun == '1') {
                if(dsT_CD_MENTOPLAN_01.CountRow < 1) {
                    alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
                    return;
                }

                status = dsT_CD_MENTOPLAN_01.RowStatus(dsT_CD_MENTOPLAN_01.RowPosition);

                //DataSet�� ���� ���� Ȯ��
                if (dsT_CD_MENTOPLAN_01.IsUpdated && status != 1) {
                    alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                    return false;
                }

                if(confirm("��ǥ���� ["+dsT_CD_MENTOPLAN_01.RowPosition +"]�� �����͸� �����Ͻðڽ��ϱ�?")){
                    dsT_CD_MENTOPLAN_01.DeleteRow(dsT_CD_MENTOPLAN_01.RowPosition);
                }
            }
            // ��������
            else if (gubun == '2') {
                if(dsT_CD_MENTOPLAN_02.CountRow < 1) {
                    alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
                    return;
                }

                status = dsT_CD_MENTOPLAN_02.RowStatus(dsT_CD_MENTOPLAN_02.RowPosition);

                //DataSet�� ���� ���� Ȯ��
                if (dsT_CD_MENTOPLAN_02.IsUpdated && status != 1) {
                    alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                    return false;
                }

                if(confirm("�������� ["+dsT_CD_MENTOPLAN_02.RowPosition +"]�� �����͸� �����Ͻðڽ��ϱ�?")){
                    dsT_CD_MENTOPLAN_02.DeleteRow(dsT_CD_MENTOPLAN_02.RowPosition);
                }
            }
            // ��Ÿ
            else if (gubun == '9') {
                if(dsT_CD_MENTOPLAN_09.CountRow < 1) {
                    alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
                    return;
                }

                status = dsT_CD_MENTOPLAN_09.RowStatus(dsT_CD_MENTOPLAN_09.RowPosition);

                //DataSet�� ���� ���� Ȯ��
                if (dsT_CD_MENTOPLAN_09.IsUpdated && status != 1) {
                    alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                    return false;
                }

                if(confirm("��Ÿ���� ["+dsT_CD_MENTOPLAN_09.RowPosition +"]�� �����͸� �����Ͻðڽ��ϱ�?")){
                    dsT_CD_MENTOPLAN_09.DeleteRow(dsT_CD_MENTOPLAN_09.RowPosition);
                }
            }

            if (status != "1")    {

                flag = '2';

                eval("trT_CD_MENTO.KeyValue = 'SVL(I:DEL=dsT_CD_MENTOPLAN_0"+gubun+")';");

                trT_CD_MENTO.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc021.cmd.CDPC021CMD&S_MODE=DEL";
                trT_CD_MENTO.post();
            }

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
            var ENO_NO  = opener.eno_no;
            var SEQ_NO  = opener.seq_no;

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            var url = "cdpc021_PV.jsp?ENO_NO="+ENO_NO+"&SEQ_NO="+SEQ_NO;
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

            eval("dsT_CD_MENTOPLAN_0"+gubun+".AddRow()");

            eval("dsT_CD_MENTOPLAN_0"+gubun+".NameValue(dsT_CD_MENTOPLAN_0"+gubun+".RowPosition,'ENO_NO')="+opener.eno_no);
            eval("dsT_CD_MENTOPLAN_0"+gubun+".NameValue(dsT_CD_MENTOPLAN_0"+gubun+".RowPosition,'SEQ_NO')="+opener.seq_no);
            eval("dsT_CD_MENTOPLAN_0"+gubun+".NameValue(dsT_CD_MENTOPLAN_0"+gubun+".RowPosition,'SGBN_CD')="+gubun);

            eval("document.form1.grdT_CD_MENTOPLAN_0"+gubun+".SetColumn(form1.grdT_CD_MENTOPLAN_0"+gubun+".getColumnID(0));");

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

            var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CD_MENTOPLAN_01.IsUpdated && !dsT_CD_MENTOPLAN_02.IsUpdated && !dsT_CD_MENTOPLAN_09.IsUpdated) {
                //document.getElementById("resultMessage_01").innerText = "* ������ ������ �����ϴ�.";
                //document.getElementById("resultMessage_02").innerText = "* ������ ������ �����ϴ�.";
                //document.getElementById("resultMessage_09").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        
            //Grid Style ����
            cfStyleGrid(form1.grdT_CD_MENTOPLAN_01,0,"true","false");
            cfStyleGrid(form1.grdT_CD_MENTOPLAN_02,0,"true","false");
            cfStyleGrid(form1.grdT_CD_MENTOPLAN_09,0,"true","false");
        
            //�İ����� ��쿡�� ��ϰ����ϰ�
            if("<%=box.getString("SESSION_ENONO") %>" == opener.eno_no) {
                form1.grdT_CD_MENTOPLAN_01.Enabled = false;
                form1.grdT_CD_MENTOPLAN_02.Enabled = false;
                form1.grdT_CD_MENTOPLAN_09.Enabled = false;

                fnc_HiddenElement("imgSave");
                fnc_HiddenElement("ImgAddNew1");
                fnc_HiddenElement("ImgDelete1");
                fnc_HiddenElement("ImgAddNew2");
                fnc_HiddenElement("ImgDelete2");
                fnc_HiddenElement("ImgAddNew9");
                fnc_HiddenElement("ImgDelete9");

            }

            fnc_SearchList();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_MENTOPLAN_01.IsUpdated ||
                dsT_CD_MENTOPLAN_02.IsUpdated ||
                dsT_CD_MENTOPLAN_09.IsUpdated )
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



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTOPLAN) |
    | 3. ���Ǵ� Table List(T_CD_MENTOPLAN)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTOPLAN_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTOPLAN) |
    | 3. ���Ǵ� Table List(T_CD_MENTOPLAN)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTOPLAN_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTOPLAN) |
    | 3. ���Ǵ� Table List(T_CD_MENTOPLAN)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTOPLAN_09" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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
    <Object ID ="trT_CD_MENTO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_MENTO)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTOPLAN_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage_01"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage_01"), "MSG_03", dsT_CD_MENTOPLAN_01.CountRow );

        }


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTOPLAN_01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTOPLAN_01 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {

            alert("�ش� �ʼ��Է��׸�[����] �Է� �� ���� �۾��� �����մϴ�.");

        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTOPLAN_02 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage_02"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage_02"), "MSG_03", dsT_CD_MENTOPLAN_02.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTOPLAN_02 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTOPLAN_02 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {

            alert("�ش� �ʼ��Է��׸�[����] �Է� �� ���� �۾��� �����մϴ�.");

        }
        else {
            cfErrorMsg(this);
        }

    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTOPLAN_09 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage_09"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage_09"), "MSG_03", dsT_CD_MENTOPLAN_09.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTOPLAN_09 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTOPLAN_09 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {

            alert("�ش� �ʼ��Է��׸�[����] �Է� �� ���� �۾��� �����մϴ�.");

        }
        else {
            cfErrorMsg(this);
        }

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

                form1.grdT_CD_MENTOPLAN_01.Enabled = false;
                form1.grdT_CD_MENTOPLAN_02.Enabled = false;
                form1.grdT_CD_MENTOPLAN_09.Enabled = false;

                document.getElementById("imgSave").disabled = true;
                document.getElementById("imgSave").style.display = "none";

                document.getElementById("ImgAddNew1").disabled = true;
                document.getElementById("ImgAddNew1").style.display = "none";
                document.getElementById("ImgDelete1").disabled = true;
                document.getElementById("ImgDelete1").style.display = "none";
                document.getElementById("ImgAddNew2").disabled = true;
                document.getElementById("ImgAddNew2").style.display = "none";
                document.getElementById("ImgDelete2").disabled = true;
                document.getElementById("ImgDelete2").style.display = "none";
                document.getElementById("ImgAddNew9").disabled = true;
                document.getElementById("ImgAddNew9").style.display = "none";
                document.getElementById("ImgDelete9").disabled = true;
                document.getElementById("ImgDelete9").style.display = "none";
            }

            trT_CD_MENTO.KeyValue = "tr01(O:SHR_01=dsT_CD_MENTOPLAN_01, O:SHR_02=dsT_CD_MENTOPLAN_02, O:SHR_09=dsT_CD_MENTOPLAN_09)";
            trT_CD_MENTO.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc021.cmd.CDPC021CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO+"&SEQ_NO="+SEQ_NO;
            trT_CD_MENTO.post();

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

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CD_MENTO event="OnSuccess()">

        // ������ ��� ����ȸ
        if (flag == '1') {

            fnc_SearchList();

        }

        flag = '';

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CD_MENTO event="OnFail()">

        cfErrorMsg(this);
        flag = '';

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���丵 ��ȹ���</td>
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
                    <td align="center" class="creamBold">���丵 �Ⱓ</td>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��ǥ</strong>
        </td>
        <td align="right" valign="bottom">
        <span id="button1">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAddNew1','','/images/button/btn_AppendOver.gif',1)" onClick="fnc_AddNew('1');return false;"><img src="/images/button/btn_AppendOn.gif" id="ImgAddNew1" name="ImgAddNew1" width="60" height="20" border="0" align="absmiddle"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete1','','/images/button/btn_RemoveOver.gif',1)" onClick="fnc_Delete('1');return false;"><img src="/images/button/btn_RemoveOn.gif" id="ImgDelete1" name="ImgDelete1" width="60" height="20" border="0" align="absmiddle"></a>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3" colspan="2">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_MENTOPLAN_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
                            <param name="DataID"                  value="dsT_CD_MENTOPLAN_01">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'         align=center edit='none'</C>
                                <C> id='PLAN_TXT'     width=738   name='����'         align=left   EditLimit=4000 </C>
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
<!--
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage_01">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
-->
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>����(���̳�,�м�) ����</strong>
        </td>
        <td align="right" valign="bottom">
        <span id="button2">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAddNew2','','/images/button/btn_AppendOver.gif',1)" onClick="fnc_AddNew('2');return false;"><img src="/images/button/btn_AppendOn.gif" id="ImgAddNew2" name="ImgAddNew2" width="60" height="20" border="0" align="absmiddle"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete2','','/images/button/btn_RemoveOver.gif',1)" onClick="fnc_Delete('2');return false;"><img src="/images/button/btn_RemoveOn.gif" id="ImgDelete2" name="ImgDelete2" width="60" height="20" border="0" align="absmiddle"></a>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3" colspan="2">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_MENTOPLAN_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
                            <param name="DataID"                  value="dsT_CD_MENTOPLAN_02">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'         align=center edit='none'</C>
                                <C> id='PLAN_TXT'     width=738   name='����'         align=left   EditLimit=4000 </C>
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
<!--
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage_02">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
-->
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��Ÿ����</strong>
        </td>
        <td align="right" valign="bottom">
        <span id="button9">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAddNew9','','/images/button/btn_AppendOver.gif',1)" onClick="fnc_AddNew('9');return false;"><img src="/images/button/btn_AppendOn.gif" id="ImgAddNew9" name="ImgAddNew9" width="60" height="20" border="0" align="absmiddle"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete9','','/images/button/btn_RemoveOver.gif',1)" onClick="fnc_Delete('9');return false;"><img src="/images/button/btn_RemoveOn.gif" id="ImgDelete9" name="ImgDelete9" width="60" height="20" border="0" align="absmiddle"></a>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3" colspan="2">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_MENTOPLAN_09" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
                            <param name="DataID"                  value="dsT_CD_MENTOPLAN_09">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'         align=center edit='none'    </C>
                                <C> id='PLAN_TXT'     width=738   name='����'         align=left   EditLimit=4000 </C>
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
<!--
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage_09">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
-->
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
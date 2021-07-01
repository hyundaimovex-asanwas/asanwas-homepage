<!--
    ************************************************************************************
    * @Source         : eisd020.jsp                                                    *
    * @Description    : ȸ�Ǻ����ڷ���Ȳ PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>ȸ�Ǻ����ڷ���Ȳ(eisd020)</title>
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

        var bbs_gbn = "";              // �Խ��Ǳ��� : 5: ȸ�Ǻ����ڷ���Ȳ(�ְ�)
                                       //              6: ȸ�Ǻ����ڷ���Ȳ(����)
                                       //              7: ȸ�Ǻ����ڷ���Ȳ(����)
        var vGbn    = '';              // �˻����� (1: ����, 2: ����, 3: �ۼ���)
        var vText   = '';              // �˻����� ����

        var gbn     =  '';
        var title   =  '';
        var seq_no  =  '';
        var ref_no  =  '';
        var step_no =  '';
        var dept_no =  '';
        var eno_no  =  '';
        var eno_nm  =  '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var SUBJECT_TAG    = document.getElementById("txtSUBJECT_TAG_SHR").value;

            // ��ü ��ȸ
            if (bbs_gbn == "") {

                trT_ED_BOARD.action = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR_01&SUBJECT_TAG="+SUBJECT_TAG;
                trT_ED_BOARD.post();
            }
            // �ű� �Ǵ� ����â ���� �� �ش� �Խ��Ǳ������� �ʱ�ȭ
            // �ְ�
            else if (bbs_gbn == "5")  {

                dsT_ED_BOARD01.ClearData();

                dsT_ED_BOARD01.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR&BBS_GBN=5&SUBJECT_TAG="+SUBJECT_TAG;
                dsT_ED_BOARD01.Reset();
            }
            // ����
            else if (bbs_gbn == "6")  {

                dsT_ED_BOARD02.ClearData();

                dsT_ED_BOARD02.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR&BBS_GBN=6&SUBJECT_TAG="+SUBJECT_TAG;
                dsT_ED_BOARD02.Reset();
            }
            // ����
            else if (bbs_gbn == "7")  {

                dsT_ED_BOARD03.ClearData();

                dsT_ED_BOARD03.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR&BBS_GBN=7&SUBJECT_TAG="+SUBJECT_TAG;
                dsT_ED_BOARD03.Reset();
            }

            bbs_gbn = "";

            document.getElementById("txtSUBJECT_TAG_SHR").focus();

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

            var obj = new String();

            vGbn    = '';                     // �˻����� (1: ����, 2: ����, 3: �ۼ���)
            vText   = '';                     // �˻����� ����

            gbn     = "1";                    // 1: ���, 2: ����, 3: �亯
            title   = "���";
            bbs_gbn = "";
            seq_no  = "";
            ref_no  = "";
            step_no = "0";
            dept_no = "0";
            eno_no  = '<%=box.get("SESSION_ENONO")%>';
            eno_nm  = '<%=box.get("SESSION_ENONM")%>';

            window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            document.getElementById("txtSUBJECT_TAG_SHR").value = getToday().substr(0,4);

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_BOARD01.ClearData();
            dsT_ED_BOARD02.ClearData();
            dsT_ED_BOARD03.ClearData();

            document.getElementById("txtSUBJECT_TAG_SHR").focus();

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
            cfStyleGridEis(form1.grdT_ED_BOARD01,0,"false","false");
            cfStyleGridEis(form1.grdT_ED_BOARD02,0,"false","false");
            cfStyleGridEis(form1.grdT_ED_BOARD03,0,"false","false");

            document.getElementById("txtSUBJECT_TAG_SHR").value = getToday().substr(0,4);
<%
    if(box.getString("SESSION_SEL_AUTHO").equals("A")
            || box.getString("SESSION_SEL_AUTHO").equals("S")) {
%>
            document.getElementById("view_1").style.display='inline';
<%
    } else {
%>
            document.getElementById("view_1").style.display='none';
<%
    }
%>

            fnc_SearchList();

            document.getElementById("txtSUBJECT_TAG_SHR").focus();
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
         
        function fnc_DownloadFile() {
            var obj;
            type = document.getElementById("hidFILE_TYPE_CD").value;
            
            if(type == "1")
                obj = dsT_ED_BOARD01;
            else if(type == "2")
                obj = dsT_ED_BOARD02;
            else if(type == "3")
                obj = dsT_ED_BOARD03;
            else
                return;
            
            cfDownload(obj.NameValue(obj.RowPosition, "SRCFILE_NM"), obj.NameValue(obj.RowPosition, "TGTFILE_NM"));
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_BOARD)     |
    | 3. ���Ǵ� Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_BOARD)     |
    | 3. ���Ǵ� Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_BOARD)     |
    | 3. ���Ǵ� Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_BOARD)     |
    | 3. ���Ǵ� Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID ="trT_ED_BOARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(O:SHR_01=dsT_ED_BOARD01,O:SHR_02=dsT_ED_BOARD02,O:SHR_03=dsT_ED_BOARD03)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_BOARD01 Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: ���, 2: ����, 3: �亯
        bbs_gbn = dsT_ED_BOARD01.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD01.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD01.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD01.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD01.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD01.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD01.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <Script For=grdT_ED_BOARD02 Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: ���, 2: ����, 3: �亯
        bbs_gbn = dsT_ED_BOARD02.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD02.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD02.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD02.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD02.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD02.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD02.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <Script For=grdT_ED_BOARD03 Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: ���, 2: ����, 3: �亯
        bbs_gbn = dsT_ED_BOARD03.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD03.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD03.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD03.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD03.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD03.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD03.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD01 Event="OnLoadCompleted(iCount)">

        if (dsT_ED_BOARD01.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0)    {

            document.getElementById("resultMessage").innerText = '* �ڷᰡ ��ȸ�Ǿ����ϴ�.';

        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD01 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD02 Event="OnLoadCompleted(iCount)">

        if (dsT_ED_BOARD01.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0)    {

            document.getElementById("resultMessage").innerText = '* �ڷᰡ ��ȸ�Ǿ����ϴ�.';

        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD02 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD02 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD03 Event="OnLoadCompleted(iCount)">

        if (dsT_ED_BOARD01.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0)    {

            document.getElementById("resultMessage").innerText = '* �ڷᰡ ��ȸ�Ǿ����ϴ�.';

        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD03 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD03 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>



    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD01 Event=OnRowPosChanged(row)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value    = "1";
            document.getElementById("txtFILE_TYPE").value       = "�� ��";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD01.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=dsT_ED_BOARD02 Event=OnRowPosChanged(row)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "2";
            document.getElementById("txtFILE_TYPE").value       = "�� ��";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD02.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=dsT_ED_BOARD03 Event=OnRowPosChanged(row)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "3";
            document.getElementById("txtFILE_TYPE").value       = "�� ��";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD03.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>
    
    
    
    <!-----------------------------------------------------+
    | Row ���� ��
    +------------------------------------------------------>
    <Script For=grdT_ED_BOARD01 Event=OnClick(row,colid)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value    = "1";
            document.getElementById("txtFILE_TYPE").value       = "�� ��";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD01.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=grdT_ED_BOARD02 Event=OnClick(row,colid)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "2";
            document.getElementById("txtFILE_TYPE").value       = "�� ��";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD02.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=grdT_ED_BOARD03 Event=OnClick(row,colid)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "3";
            document.getElementById("txtFILE_TYPE").value       = "�� ��";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD03.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>
    

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ȸ�Ǻ����ڷ���Ȳ</td>
                    <td align="right" class="navigator">HOME/�濵����/��Ÿ��Ȳ/<font color="#000000">ȸ�Ǻ����ڷ���Ȳ</font></td>
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
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            </div>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                    <td><img src="/images/common/eis_menu_bg_01.gif" width="7" height="7"></td>
                    <td height="7" background="/images/common/eis_menu_bg_02.gif"></td>
                    <td><img src="/images/common/eis_menu_bg_03.gif" width="7" height="7"></td>
                </tr>
                <tr>
                    <td width="7" background="/images/common/eis_menu_bg_04.gif">&nbsp;</td>
                    <td height="20">
                    
                    
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState" width="80">
                                    &nbsp;&nbsp;��ȸ��&nbsp;
                                </td>
                                <td align="left" class="searchState">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtSUBJECT_TAG_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtSUBJECT_TAG_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtSUBJECT_TAG_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table> 
                                </td>
                            </tr>
                        </table>
                    
                    
                    </td>
                    <td width="7" background="/images/common/eis_menu_bg_04.gif">&nbsp;</td>
                </tr>
                <tr>
                    <td><img src="/images/common/eis_menu_bg_05.gif" width="7" height="7"></td>
                    <td height="7" background="/images/common/eis_menu_bg_02.gif"></td>
                    <td><img src="/images/common/eis_menu_bg_06.gif" width="7" height="7"></td>
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
        <td class="paddingTop8" align="right">
            <b>�ٿ�ε� :</b>
            <input id=txtFILE_TYPE name=txtFILE_TYPE size="5" class="input_ReadOnly" readonly>
            <input id=txtFILE_NAME name=txtFILE_NAME size="30" class="input_ReadOnly" readonly>
            <input type="hidden" id="hidFILE_TYPE_CD">
            <img src="/images/button/FileOpenOn.gif" id="btnFILE_OPEN" name="btnFILEOPEN" width="80" height="20" border="0" align="absmiddle" onClick="fnc_DownloadFile()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnFILEOPEN','','/images/button/FileOpenOver.gif',3)" style="cursor:hand;">
        </td>
    </tr>
    <tr>
        <td colspan="2" height="5"></td>
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
                        <object    id="grdT_ED_BOARD01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:265px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_BOARD01">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <G> name='�� ��'  HeadBgColor='#f0f0f0'   HeadFontStyle=bold
                                    <C> id='SUBJECT_TAG'  width=100   name='�� ¥'          align=center Suppress=1</C>
                                    <C> id='SEQ_NO'       width=39    name='SEQ'          align=center   </C>
                                    <C> id='SRCFILE_NM'   width=105   name='÷�ι���'       align=left   </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_BOARD02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:265px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_BOARD02">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <G> name='�� ��'  HeadBgColor='#f0f0f0'   HeadFontStyle=bold
                                    <C> id='SUBJECT_TAG'  width=100   name='�� ¥'          align=center Suppress=1</C>
                                    <C> id='SEQ_NO'       width=39    name='SEQ'          align=center   </C>
                                    <C> id='SRCFILE_NM'   width=105   name='÷�ι���'       align=left   </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_BOARD03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:265px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_BOARD03">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <G> name='�� ��'  HeadBgColor='#f0f0f0'   HeadFontStyle=bold
                                    <C> id='SUBJECT_TAG'  width=140   name='�� ¥'          align=center Suppress=1</C>
                                    <C> id='SRCFILE_NM'   width=105   name='÷�ι���'       align=left   </C>
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

</form>
<!-- form �� -->

</body>
</html>